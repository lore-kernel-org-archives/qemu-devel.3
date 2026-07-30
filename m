Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9DFC54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpFZZ-0005dF-Pz; Wed, 29 Jul 2026 21:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZY-0005cv-PP
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZX-0005ZC-1T
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U1JAEw3662648
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lc0r0m3XKd4bkmC/58YlEfIB78yxw3GCW1HMX54fUKc=; b=Stfae7UCpowUm+ps
 oyDM1TT7zGmUFSiIWJHtwhC2EoCH3eNeqh9+IjsZYjNQ59oh5Hhvd4Ob1mCc1Y3C
 +qfRL56iHSV0u4+Jm1/xASASsZ91rm/305V5Nv2HIgP4ImJWCwLoQPz9LTUxwMep
 stYP2yKqsPswjepA1FaXSLNQYuwPZ1GnWihfHJDivP3SzBNgbV+f+WFZBHL25UW/
 afoKJ8EyYccH94QKv8Ql7f5s0Cgu1JGfAS/0xUELlJzjx+ItRcGGbAhv6cbYR++i
 tP4ILAU8D9K/aR/OnCCSXa+qIomD+bBwhrcrGdEzJNY3GLL/Vb0+njULU94hVgPZ
 kOAp3A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqvujr0ra-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so33044705ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 18:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785374909; x=1785979709; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lc0r0m3XKd4bkmC/58YlEfIB78yxw3GCW1HMX54fUKc=;
 b=JliLsngEZDjkglVV1HrfXOK2zL6aZoaktRHFucWTYWs9xkfxdrPcp1kVR74vXfNjmx
 jt8XUt+v5HOPWNi/wXLGeGwrSARX2sAe5m3BfnIYY60X3a9dPa0Pd+s6d28S7KKsVFx8
 Jgg8UXfxctim/mjKhd8t4n6vH7JINqcvmJNYEKlh1u53RBhSORSC2jhE46CJoblJnMNR
 QxmE4ROqx0pOkywDvEJP03dUc2EaJ7tP54s1tGczF+If3hWBXrRn2t94mXvxl3w+0GhC
 x7fdjcXKscEIShV+TRZ0xN/30MwZggZNijGVbmrwR9vHoJtwI//N8DiLfWI6QkLY1pUh
 qgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785374909; x=1785979709;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lc0r0m3XKd4bkmC/58YlEfIB78yxw3GCW1HMX54fUKc=;
 b=g2c76WnAeoj0dvQdWQFkKReYZ1StbkfyBrfMU4REw0jeUV3li2Lv7sijzuW4CvLmU/
 T6PYyR5xiIdos1LSIohkAleCnCNynQGB1OQAHi+i5BdVd1jwOBdCrE7IAr4QB2Af74No
 uWSt46qtWt0pkcbKWk+ZhaOmpEeZrjFCEBeNVwiF0Ebw+fGasd2JBWs9Cxb+u/7eBjKl
 YvZl3Hu/fIZElUs0na4nokMEoegc8B9VSr68EPJXr08WaYUTb4M412gP/5ykdgc7LHcF
 ewHWx+S0KAkn7mHC8tzNlMBYDb69VkdZWIz8aWYsIhbekvbe3ksaw/JHYKPhzwbS621e
 TECg==
X-Gm-Message-State: AOJu0Yxqc0RndhB+R7/bGF0cTNrM49xVxrzCmmY1gCeDhW9BV+W74i5K
 VQm2+ZHQc49JuDd4WK1d1pFwqWpqUyD4ZuqSv+T8ck88Zd4jMnEljdbZfq0kXJIbFz0LTkcIymc
 ni+yjbaXQXamiGMP5HLKXtPIhXdFoN+rwy56x+qSZgEalrgticS1sJLAzFOcT7RmK2A==
X-Gm-Gg: AR+sD10SXW1S+ccQVU6myb6Ynr3zw8oF+OOwhoq6EQHwTXvRhJHuLJx7n6rARDBEWoJ
 EMhSDk+gODFKmD67aSrOrgBqzHfhCXZrzLzEJm6EbcxQ89LrwoxYBjk2bpRL6JfsT0cD3Ke8oIL
 WOOEpBZhsWeRYNVE9CZo9JzlwzciiJvN64s9hvE/n3AfY7+mVM9pczjjxknSJbXML92WHTbXY59
 QfZoF0ElN3aGekn9+QIdtmIiAPMAfmsjWBo6W4XIJd1a7DwP2XFTrJgjxjNOM1a4qTTsnFPbOtA
 bKKyOGX6fWO8Q6elvZDegIeWUBi6sXRGa2+ohJttUg510cJ58av+KqpUXJyhDaitiylksNAat39
 tapL/76JaIP7YrXucJ/GF4QTdy0+0FNpDVPe4ca3JGcbsESWm
X-Received: by 2002:a17:903:2ac4:b0:2cc:9e99:55c9 with SMTP id
 d9443c01a7336-2d035ca8fc0mr7835565ad.26.1785374908928; 
 Wed, 29 Jul 2026 18:28:28 -0700 (PDT)
X-Received: by 2002:a17:903:2ac4:b0:2cc:9e99:55c9 with SMTP id
 d9443c01a7336-2d035ca8fc0mr7835285ad.26.1785374908445; 
 Wed, 29 Jul 2026 18:28:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm13242162eec.27.2026.07.29.18.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 18:28:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v4 02/18] hw/hexagon: move VTCM to the common machine state
Date: Wed, 29 Jul 2026 18:28:07 -0700
Message-Id: <20260730012824.1135905-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwNyBTYWx0ZWRfX65p4Ixf7Tj4w
 iy+d5TqehbOrzQtCWqrcJlSqad+LgyBA+TktxWgaL1fBwzma7NY15seKLi9QhgLrpPXVDsSoxgE
 wcGT0KJgQ7U7lYAe1JQW08MWfgzUDYc=
X-Proofpoint-ORIG-GUID: a_x3Z96159eqdPOypCdT0lXZgenWNewo
X-Authority-Analysis: v=2.4 cv=KpR9H2WN c=1 sm=1 tr=0 ts=6a6aa8bd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=31cAqr7vU2O6cbMaemAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: a_x3Z96159eqdPOypCdT0lXZgenWNewo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwNyBTYWx0ZWRfXwVm/TEv4dDkg
 05fieStqvtObzFpGTrjr/BmNQVU1p9Kn0osFxxM/81pqW8TfmDnS9MCHikRP7oe1zOX0xomwDcO
 w6sY2Birhy9I12Jlgvyme4dVr1N6athqOdqV3Q3FXc66ScCJeQE16jgvK5BlOJq70fGPzrJ+Ytx
 Vdx2UgJRJIcd/g/ozLkzgNeiSXkc6r0M4OULoHSlOmpVZXBxG+osk1iOhQx+0nfAaca+SHaOfxR
 /q+7z/zrJhzmaXyHx0loMtWHjbIGIU8IZInIcD24pYa3ikrPU0/fEPqpUyKdaR981MFIhN4w7vO
 3dTvO0LPAAKjmoM7dvDUDdjej/8BIBTFftjr3pjJ9AF9VzS/NA6gSNZfDHVVRAufF90NTlImmGH
 PCwHbTMgW+0yzSSHhciprPpe4mH8Ad7OJPFx2FAd+S6TqgXgBf+22KfIgP+N27I06xESZvN8SbY
 9F7yU6MhLCBGSZlZs4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhlIFZUQ00gaXMgZGVzY3JpYmVkIGJ5IHRoZSBjb25maWcgdGFibGUsIHNvIGV2ZXJ5IG1hY2hp
bmUgY2FuIHNldCBpdAp1cCB0aGUgc2FtZSB3YXkuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWlu
IDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaW5jbHVkZS9ody9oZXhhZ29uL2hl
eGFnb24uaCB8IDEgKwogaW5jbHVkZS9ody9oZXhhZ29uL3ZpcnQuaCAgICB8IDEgLQogaHcvaGV4
YWdvbi9oZXgtc3Vic3lzLmMgICAgICB8IDggKysrKysrKysKIGh3L2hleGFnb24vdmlydC5jICAg
ICAgICAgICAgfCA1IC0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oIGIv
aW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaAppbmRleCAxMDM0YjA5YzJhYy4uOWM3M2NhZGIx
NmQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgKKysrIGIvaW5jbHVk
ZS9ody9oZXhhZ29uL2hleGFnb24uaApAQCAtMTU2LDYgKzE1Niw3IEBAIHN0cnVjdCBIZXhhZ29u
Q29tbW9uTWFjaGluZVN0YXRlIHsKIAogICAgIE1lbW9yeVJlZ2lvbiByYW07CiAgICAgTWVtb3J5
UmVnaW9uIGNmZ3RhYmxlX3JvbTsKKyAgICBNZW1vcnlSZWdpb24gdnRjbTsKIH07CiAKICNlbmRp
ZgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9oZXhhZ29uL3ZpcnQuaCBiL2luY2x1ZGUvaHcvaGV4
YWdvbi92aXJ0LmgKaW5kZXggZmNiNDc3NjIxOTQuLmNmMGNkMmY4ZjIyIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2h3L2hleGFnb24vdmlydC5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmgK
QEAgLTE3LDcgKzE3LDYgQEAgc3RydWN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlIHsKICAgICBp
bnQgZmR0X3NpemU7CiAgICAgTWVtb3J5UmVnaW9uICpzeXM7CiAgICAgTWVtb3J5UmVnaW9uIHRj
bTsKLSAgICBNZW1vcnlSZWdpb24gdnRjbTsKICAgICBNZW1vcnlSZWdpb24gYmlvczsKICAgICBD
bG9jayAqYXBiX2NsazsKIH07CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYyBi
L2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCmluZGV4IGQxNDZlZTBjMDc1Li4wYzIwY2YwMmU3ZCAx
MDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKKysrIGIvaHcvaGV4YWdvbi9oZXgt
c3Vic3lzLmMKQEAgLTI5LDQgKzI5LDEyIEBAIHZvaWQgaGV4X3N1YnN5c19jcmVhdGUoSGV4YWdv
bkNvbW1vbk1hY2hpbmVTdGF0ZSAqaG1zLAogICAgIHJvbV9hZGRfYmxvYl9maXhlZF9hcygiY29u
ZmlnX3RhYmxlLnJvbSIsICZtX2NmZy0+Y2ZndGFibGUsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNpemVvZihtX2NmZy0+Y2ZndGFibGUpLCBtX2NmZy0+Y2ZnYmFzZSwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsKKworICAgIGlmIChtX2NmZy0+
Y2ZndGFibGUudnRjbV9zaXplX2tiID4gMCkgeworICAgICAgICBtZW1vcnlfcmVnaW9uX2luaXRf
cmFtKCZobXMtPnZ0Y20sIE5VTEwsICJ2dGNtLnJhbSIsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbV9jZmctPmNmZ3RhYmxlLnZ0Y21fc2l6ZV9rYiAqIDEwMjQsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2ZhdGFsKTsKKyAgICAgICAgbWVtb3J5X3JlZ2lv
bl9hZGRfc3VicmVnaW9uKHN5c21lbSwgbV9jZmctPmNmZ3RhYmxlLnZ0Y21fYmFzZSA8PCAxNiwK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZobXMtPnZ0Y20pOworICAgIH0K
IH0KZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vdmlydC5jIGIvaHcvaGV4YWdvbi92aXJ0LmMKaW5k
ZXggYWQwYmM0ZjEzMjkuLjUzZWFhZmFmODVhIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL3ZpcnQu
YworKysgYi9ody9oZXhhZ29uL3ZpcnQuYwpAQCAtNzUsMTEgKzc1LDYgQEAgc3RhdGljIHZvaWQg
ZmR0X2FkZF9odngoSGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgKnZtcywKICAgICBjb25zdCBNYWNo
aW5lU3RhdGUgKm1zID0gTUFDSElORSh2bXMpOwogICAgIHVpbnQzMl90IHZ0Y21fc2l6ZV9ieXRl
cyA9IG1fY2ZnLT5jZmd0YWJsZS52dGNtX3NpemVfa2IgKiAxMDI0OwogICAgIGlmICh2dGNtX3Np
emVfYnl0ZXMgPiAwKSB7Ci0gICAgICAgIG1lbW9yeV9yZWdpb25faW5pdF9yYW0oJnZtcy0+dnRj
bSwgTlVMTCwgInZ0Y20ucmFtIiwgdnRjbV9zaXplX2J5dGVzLAotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZlcnJvcl9mYXRhbCk7Ci0gICAgICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1
YnJlZ2lvbih2bXMtPnN5cywgbV9jZmctPmNmZ3RhYmxlLnZ0Y21fYmFzZSA8PCAxNiwKLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2bXMtPnZ0Y20pOwotCiAgICAgICAgIHFl
bXVfZmR0X2FkZF9zdWJub2RlKG1zLT5mZHQsICIvc29jL3Z0Y20iKTsKICAgICAgICAgcWVtdV9m
ZHRfc2V0cHJvcF9zdHJpbmcobXMtPmZkdCwgIi9zb2MvdnRjbSIsICJjb21wYXRpYmxlIiwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInFjb20saGV4YWdvbl92dGNtIik7Ci0tIAoy
LjM0LjEKCg==

