Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CA5C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 21:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxAfW-0003F1-9B; Thu, 20 Aug 2026 17:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxAfU-0003Es-QH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:51:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxAfT-0004LS-7M
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:51:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7YZT4012701
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KkW9x4b4B0PC6PKib+GM8r
 Y4p9GhkcEWCghFBXLyimk=; b=dB6EcgC5Bmwn1yFph94AL9squ/Nqt8HalXP2m5
 ODRxKLYui+wWDp9jE1hZxJrvIRLd4AG4lrdir75io/APPTRckuZvMArSEMmy4n+C
 0/dy7WtktHtYiCJvYKsXzkaEFE6/Inq2tWCA7Hy+P8z8T3+3UC1kG3e024Wbl2yv
 ii/5VP4BvXtbPMijXG5fNSlOygriUHGy0sKnXB5FWhVlLYnV1/6lJNqMFrTBO9fi
 IyV4t1GusDiP5wUFLX8ZsWyPP5+1vKnKobmruXVsVWrYFBUOFu+Jl1kPiFBmYb2R
 CAE1qh3+buGNIPRZe75h28mi3jhcdF/7LX2SQFYxA5McOT0A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29kfbd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:51:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so3445525ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787262680; x=1787867480; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KkW9x4b4B0PC6PKib+GM8rY4p9GhkcEWCghFBXLyimk=;
 b=CaeKGtimY6TMjhNk1/WoTd2nmDPgUZFb4avFz0uJyBeQQmiBXJOIfGa9Ktw0QsoYzN
 ntnEvbZM2WFse3M38aRC9AII3czixcuHetJ7V3DNQ9JFoDYv2YGSYgCSd2+zTSuWv841
 uVFOI52s+DRJRB5f3yMS3Ek6amoM0pHb9XdWnyJaIcxzYA5ufCUAc1Xy/PW8pi6j69T+
 UcePWsIBrLWXAZj2TyEuzVUq8f6zpSCATYEvBAGMfZWEBO+5XyZPfmbZ+GHQ6SIXa9vc
 CwaBFlr8/4Hxr0iW43Kv+fVHZNOODbCYh7qJNbXlVcwhZBBjE8yBVPkZNC41tufI2mzN
 mdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787262680; x=1787867480;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KkW9x4b4B0PC6PKib+GM8rY4p9GhkcEWCghFBXLyimk=;
 b=iAIrRvl/gYHN0ZnZLWyLL6H/rt8YQ4wep99Ks/HhEQkUjjFmWLEYyLpkPMjlusH61L
 KHJV/2PnzSPLPhfUlIPctW+hfbhk+j1Dg6OZSf4UjwPXm8zAYtpZo/9gOzR7irGOW6z3
 lgKQ+ZdrgJD15LHZ9qGuEYMoGZC9caI37OrC/RUGkWNlG9qdfGADov/wzU6+EwXK7vf3
 rbq+6AK7s82M6pdr9kRVxAsqhgPp6R7IksS8qW5wdeG6oO4oYFugYcHMIC8DaNa46OY3
 6QqQZ9hTD0qfIXPX269fdz2WJQ90dEZ2HLF/SxZ+stvdDVpPYZxKfGV5IFv3/ZEXuZGF
 W6Fw==
X-Gm-Message-State: AOJu0Yx9px/b1dgYn/SiyGOa5Y4pnYNyH7ldgpBHT3rI2+iJ17DYtyom
 HAIn0DVziLR31/BstELXDCfkZShrsSw5iP9QANqe0tS6GiiNAz4oRggKs6ASJsQBoEN6mlXAh5W
 Jqh8k21yaQYmnSx40PygOXPmRKN5WeYgCAny/x3dyILGdxaN1iB5CT/GxRwcKJ07D/w==
X-Gm-Gg: AR+sD10eXzH+VP6a7vZmUAjwsR50J7WlUm1vEheTs5hCSe/iaRl7hvvUNckurB3jDHP
 Xv7gPlFTCbRgIqr+yk3Oa6Fl4xZn1epD4ZWes22Xve/2Ool65pH5hwYfclnWlFV4wcclqY+p2Cc
 I3GYlf5UkLknatYimHSAvDkSbLr0zszk5cBeDTAUaQDcaymecLUqHNH/kyNVrk6K8bBx/KF+BOD
 Tjz+1Ghi4Wjpf1EQ7u+ooLx2wIRAPH8CjYgbuwnv/Kw3TPRffY91hr9uBtMYJjZrkT7LRLoAf3a
 ZRXYzhbaND0LHmxiH6m83/wWWWaiFWlP4nkMW50cSd4G6TfKA58bHMRoKgiF+EPR8qZvV460AS3
 /zbmfwd55msVMmsYJzauIIi+ooRVJO2JawaJ8CNKdPJzk60E8
X-Received: by 2002:a17:903:19cf:b0:2ca:53f7:3c69 with SMTP id
 d9443c01a7336-2d61a15e3e6mr123364245ad.9.1787262680126; 
 Thu, 20 Aug 2026 14:51:20 -0700 (PDT)
X-Received: by 2002:a17:903:19cf:b0:2ca:53f7:3c69 with SMTP id
 d9443c01a7336-2d61a15e3e6mr123363855ad.9.1787262679655; 
 Thu, 20 Aug 2026 14:51:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327d6168e5bsm9226899eec.1.2026.08.20.14.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 14:51:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/5] hexagon: fix HVX scatter gather, BE host
Date: Thu, 20 Aug 2026 14:51:12 -0700
Message-Id: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: R77qR-otv0S8I8XIKPlKUFTf0s4MqvCq
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a8776d8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=WF5N3kAk5PDI7vy9eqQA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MyBTYWx0ZWRfXzq+8Hh3rrebx
 yMHSPkaY3iMZ37JUuSrGTmXG6bFOsBUiAUP116BbyxmkGVkS1lkI7okxQHOqD2+IJAry21OilJ8
 ZSheKOlGA/KejXSk9/dpicSt1Oi2KBCydRWZsB1X6l0QKAN1kMrBCrN2acLpUyeVJZhKm/rZ4xz
 cLpaBLisimZ/hEM14G03BHcBvmWSjRN3MqXzHM7UFg5G5nZGSQlQ7lfCKCrNGIlDUmqByxdGg+W
 JFyTg35g4a+lfZqaKj0YPkgQ12bGpw+h9fT4d7is5TloAbuc/vtsXVRb0cMYo+okMsqSxKIn03G
 So1aravbrGG9Cntl6O4kfY54BGVEO+uJ6gpX4aN2H0lkb2aVTJ4uEtJ+E5cJ4vEJk8ksom+AhHk
 1VZa/1hSpQzZNhJwsvH2OwNsQjjKPMfd9jr4ojcJT7DD3ypYIe/S6Fu58emrS+4NQiXXtONBCMa
 Am6HlKPALJkXu098fiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MyBTYWx0ZWRfX64ZqjGEQACqC
 7DRlLB/Akeg/VFeVLPJQ0wrSzxXoyEfUzHXaRa98laDe6coMjFdI8UTr8DOgvSkbMWCWHAioNO5
 WuiTp6Z3C3Fm3+ZA09Yp+YsHa9vihxw=
X-Proofpoint-GUID: R77qR-otv0S8I8XIKPlKUFTf0s4MqvCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200163
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QW50b24gcG9pbnRlZCBvdXQgdGhpcyBlbmRpYW5uZXNzIGlzc3VlIHdpdGggSFZYLAphbmQgZm91
bmQgdGhpcyByZWdpb24gbGVuZ3RoIGlzc3VlIGFsb25nIHRoZSB3YXkuCgpGaXhlZCBpbiB2MjoK
KiBieXRlIGFjY2VzcyBoZWxwZXJzIG5vdyBhbGwgdXNlIGhleGFnb25fIHByZWZpeC4KKiBQcmVk
aWNhdGUgYnl0ZXMgYXJlIGV4dHJhY3RlZCBmcm9tIDMyLWJpdCB3b3JkcyByYXRoZXIgdGhhbiA2
NC1iaXQgd29yZHMsCiAgbWF0Y2hpbmcgdGhlIGhvc3QtbmF0aXZlIHByZWRpY2F0ZSBsYXlvdXQu
CiogR2F0aGVyIG9ubHkgcmVhZHMgbWVtb3J5IGZvciBsYW5lcyB0aGF0IGFyZSBib3RoIGluIHJh
bmdlIGFuZCBwcmVkaWNhdGUKICBlbmFibGVkLiAgU28gZHJvcHBlZCBsYW5lcyBjYW5ub3QgZmF1
bHQgb3Igb3RoZXJ3aXNlIGFjY2VzcyBtZW1vcnkuCiogVGhlIGdhdGhlciByZWdpb24tbGVuZ3Ro
IHRlc3Qgbm93IHBsYWNlcyBhbiBvdXQtb2YtcmFuZ2Ugb2Zmc2V0IG9uIGFuCiAgaW5hY2Nlc3Np
YmxlIHBhZ2UsIHZlcmlmeWluZyB0aGF0IGEgZHJvcHBlZCBsYW5lIHBlcmZvcm1zIG5vIHJlYWQu
CgpBZGRlZCB2MiBjb21taXRzOgoqIGZpeCBmb3IgaGlzdG9ncmFtIHByZWRpY2F0ZXMgLSB3ZXJl
IHVzaW5nIHRoZSB3cm9uZyBzaXplCiogdGVzdCB0byBjb3ZlciBwcmVkaWNhdGUgYnl0ZSBwZXJt
dXRhdGlvbgoKQnJpYW4gQ2FpbiAoNSk6CiAgdGFyZ2V0L2hleGFnb246IGZpeCBIVlggYmlnLWVu
ZGlhbiBieXRlIGFjY2VzcwogIHRhcmdldC9oZXhhZ29uOiBmaXggSFZYIHNjYXR0ZXIvZ2F0aGVy
IHJlZ2lvbi1sZW5ndGggY2hlY2sKICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRkIHZnYXRoZXIvdnNj
YXR0ZXIgcmVnaW9uLWxlbmd0aCB0ZXN0cwogIHRhcmdldC9oZXhhZ29uOiBmaXggSFZYIHByZWRp
Y2F0ZSBzYXZlIHNpemUgZm9yIGhpc3RvZ3JhbSBvcHMKICB0ZXN0cy90Y2cvaGV4YWdvbjogY2hl
Y2sgdGhlIHR3byBIVlggcHJlZGljYXRlIGJ1aWxkIHBhdGhzIGFncmVlCgogdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZ19odnguaCAgICAgICAgICAgIHwgIDEwICstCiB0YXJnZXQvaGV4YWdvbi9tbXZl
Yy9tYWNyb3MuaCAgICAgICAgICAgfCAgNTAgKysrKystLS0tCiB0YXJnZXQvaGV4YWdvbi9tbXZl
Yy9tbXZlYy5oICAgICAgICAgICAgfCAgMTggKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAg
ICAgICAgICAgICAgICAgIHwgIDE3ICstLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAg
ICAgICAgICAgIHwgICAzICstCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9zeXN0ZW1fZXh0X21tdmVj
LmMgfCAgIDIgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgICAgICAgICB8ICAx
NyArKy0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgICAgICAgICAgICB8ICA0NSArKysr
KysrKwogdGVzdHMvdGNnL2hleGFnb24vc2NhdHRlcl9nYXRoZXIuYyAgICAgIHwgMTM4ICsrKysr
KysrKysrKysrKysrKysrKysrLQogOSBmaWxlcyBjaGFuZ2VkLCAyNjEgaW5zZXJ0aW9ucygrKSwg
MzkgZGVsZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

