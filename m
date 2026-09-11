Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA8FC88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53jw-0003P3-2f; Fri, 11 Sep 2026 12:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53jN-0003IY-Rg
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x53j3-0007MP-NJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:04:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEm2p7442925
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hk8HZIcqLuMR36gPhr72Rn
 7Gvw+e7+uHlEY7sVk5Fco=; b=FeCZ2s2RBfeZILznFYPgqNVJFkD5QqEiVJPN2E
 FlsetHnP7M9M+k5mRKQjjyfR/3aUpqMiLZDVph7A5F8SZzALwEU0Rl/oLAoRiaPr
 aFKsR5Bqwfhu56/O7cZo9XI9mb3CYg6ih/qPTjV0p/JXbU6WGiqu/tl7aJqC7Dnh
 6RTfT50IsgipN7Ovpm1bj53lVFCInvEZ7XLhCErsi/faFad0jlW1d712CU2p6c2g
 9o4p7lzFflnjwUnttBpDzAAYVvFu5k+p2MIT8xT73xGRsxeoQKLTb/GcqTGvM9sj
 p2AbXDqNbh9hXaujzS9g6HPgrKY72lVDQ7JyOX76YP1+pz1w==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmapg2rvu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:03:34 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4b28deb7ee3so1709716b6e.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789142614; x=1789747414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hk8HZIcqLuMR36gPhr72Rn7Gvw+e7+uHlEY7sVk5Fco=;
 b=Rm4+qS9ZRkFxgchbq9M+iEHNqRNdMHAv3cpwm2TfHiL8F1d3epGWLlngsEs7ES4/pT
 ZpGdknnO+ZOCZP7z9m3xeaz7b1hLyqMcqiMFg7W5aSOMc0PlOFE9tywCMDwavtjQgrqT
 dBBEi4nlSdRuagl8BgYAO90FP1oW2dUpl/R30h1kgXWaVtr91kIfYWt66hXNTAXHjguL
 J88mZR1AVdPeBH6Tf9t1aR0g9aPJoy+KNVYuJDoiAgYi4448FOJROJHWsHPqK+fyxqne
 Rb40uM6vnppIBot37R5Rl9I3+sc7D2RQq47Ntt5q94AvBwhWl7/7quZF4AVYYAnBzcsl
 AWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789142614; x=1789747414;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hk8HZIcqLuMR36gPhr72Rn7Gvw+e7+uHlEY7sVk5Fco=;
 b=l/gRM+xh04VNC3Sahm95nLYXZtvUo+pxdgowThF/5lrYc7TOw2USDKqNM/c022ONMK
 /WwyhgFBlrqpcCkx87Xtb5etHSlrBayOxWoulDNe4e+1TWmnlEcZH9Ym+o8j8+h649+k
 gWkpYVfZKH4xVgtR2drrChgJ3vHuWgdp0GxsZcDedfYF7CavLvsNnj3EMUMAZB4THr/T
 LvnkobFeVXuDNIi4zCIEo1jm2KW9Gfs6aLRY7dldxhWykXlqXQa5VgXT2myvF7UNCj7r
 aRxdjRDmNeq0eIj29waSWF1vLlP2gmSVpaaKHnBpDLZYg7TARUUjVZiEuiu4Ct7bkNAE
 XIJQ==
X-Gm-Message-State: AFuF++lEewi+G7y3NrYZEeCCLrzYmvnLwIfNr0dRpEapkthPWXX178mI
 eH3e31yaATuPvo2ow0jddWALNQOkJl7lR3HDIX/72W4AFUNCU5X9vNnxt7jaF+Fhc0zBwBVG0DC
 f7smFW5OeJFeiX4+6lqgpKlOpzla4Lho0H0e7Pz4zfYiIRF2tLGcqM2vjKoslN6RHzQ==
X-Gm-Gg: AYBFou0ne4P+CdG94TBbkjzxxPbOgx+q3O6x7uQQ7prPsJ77ztU4TNYoqh7n5NnIVwj
 87EJCSzOZDkseQCx8c3gO69ZnMAdIiNWE7SeX5Fk9NPJcl5RPEABwngYyMRNcaKVWVbqQMDVUS7
 Z7PrNNrXZ9oi1Iq5oh4xYBoywihFv/DD0rJ2Iv/NQfDpLUFhWTiFOjcsHWnzEjihLcNmzwhmou/
 dpEsjZ+KGPjj3BT+6Pr51BcmaGLDaODPpnj+DmQFhD/gKUAKSlGkPw/sSNwpkdLCjaGrvm2lahH
 JJgio/w/eErlq5VNXfwH9Hv+lszMzGNuwsbjqeQoXLax2E7SXZAlKICbSFE/v5ju8XoeZQMabkQ
 g4PwMdv3BnQANBKAvAGViD8QKI4k82XXLaEhEFxDhLFbhMRQB
X-Received: by 2002:a05:6808:1453:b0:490:315d:e0d5 with SMTP id
 5614622812f47-4c31a16935fmr4195828b6e.16.1789142613889; 
 Fri, 11 Sep 2026 09:03:33 -0700 (PDT)
X-Received: by 2002:a05:6808:1453:b0:490:315d:e0d5 with SMTP id
 5614622812f47-4c31a16935fmr4195754b6e.16.1789142613312; 
 Fri, 11 Sep 2026 09:03:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3321ecd0asm2451876b6e.17.2026.09.11.09.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:03:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com
Subject: [PULL 00/10] hex queue
Date: Fri, 11 Sep 2026 09:02:57 -0700
Message-Id: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: xS8-FSTTQcxJNjpjzzeBozUE_NOc66RA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX3Bjf2trmeu5C
 +Qc7zSGTLbdNRfCsIiXgMdJnoLCkUYoHyEfqCNtYwV/v7bdv5bfMgMnz/kJ2/BbN4S8XJ3/nJNl
 xEgzwEbOK36Ezxe6dY/gLpeKMUr41eY=
X-Proofpoint-GUID: xS8-FSTTQcxJNjpjzzeBozUE_NOc66RA
X-Authority-Analysis: v=2.4 cv=DLoacCNb c=1 sm=1 tr=0 ts=6aa42656 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=7kzkXxtQ95IcNSd7OWUA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfX2OH1um+owQyB
 fd1CP2z/DQZMRDNTw3mTr9iexhlv8ETf8ENeLpk/ZwUBpa42AOdajbWiXCOqJaXi7pt9SGF224O
 WAPM3lkLxhUkMnjzgTrVFKhoeiqZ/w1Y/SNi/UQloKkt3qtluVGot/+FGLKIMiatU4ct5PV2MVg
 iOJeLUk3uzhy0pSymxWnjprO9kvwXFxcD2oNK7EbPFClmQhJOclq9fyfPp6yx8LUxrGkuQG4E8n
 CtNZSDrGkxGNAVC75gQPSs15rjS+V6Dkh91h8IQZ4Pujw8kS1NZC3ajb78ivx8I4CDK+5fKD7tm
 D/hE7ZOj06gqpo+KeJBnblGRhutHLwgJuCwGURHOs7MO3/6pHfLJgOOPUa3cqiH8rzrJfa4taPJ
 4DIMbQGrpSDIsKl/DZkgGsvnhafiJwk+6VqXsiMGNqiSkxioJJSS5bMDeiAzCO1DGPrPV0+n5TF
 +cOwPlhANveGEKAe8Cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110224
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAyMDliMmFmYWZhY2UwMDFjN2Q0ZDk4
MWUzOGYxODZhZmU3YjI0YTUwOgoKICBNZXJnZSB0YWcgJ3B1bGwtcGFyYWxsZWxzLTIwMjYtMDkt
MTEnIG9mIGh0dHBzOi8vZ2l0bGFiLmNvbS9kbHVuZXYvcWVtdSBpbnRvIHN0YWdpbmcgKDIwMjYt
MDktMTAgMjI6MDI6MTggLTEwMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9y
eSBhdDoKCiAgaHR0cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUgdGFncy9wdWxsLWhleC0y
MDI2MDkxMQoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDhhY2MwMzc4N2JkNjAyZGVj
NzRjMDE2OWNmOGNmMjMyMzU2ZWVkYmQ6CgogIGRvY3M6IENvcnJlY3Qgc2VtaWhvc3Qgc3BlYyBV
UkwgKDIwMjYtMDktMTEgMDc6Mjk6MTAgLTA3MDApCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkhleGFnb246IHY4MSBzdXBw
b3J0CgpJbml0aWFsIHN1cHBvcnQgZm9yIHY4MSwgc2NhbGFyIG9ubHkgZm9yIG5vdy4gIEhWWCBz
dXBwb3J0CnRvIGZvbGxvdy4KCkFkZHMgbmV3IG1hY2hpbmUgZGVmaW5pdGlvbnMsIHY4MSBzeXN0
ZW0gYXJjaGl0ZWN0dXJlIGNoYW5nZXMsCm5ldyBzY2FsYXIgb3Bjb2Rlcy4KCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQnJp
YW4gQ2FpbiAoMTApOgogICAgICB0YXJnZXQvaGV4YWdvbjogYWRkIHRoZSB2NzUsIHY3OSBhbmQg
djgxIENQVSBtb2RlbHMKICAgICAgdGFyZ2V0L2hleGFnb246IGFkZCB0aGUgdjczIEoyX3VucGF1
c2Ugc2NhbGFyIGluc3RydWN0aW9uCiAgICAgIHRhcmdldC9oZXhhZ29uOiBhZGQgdGhlIHY3OSBp
bnN0cnVjdGlvbnMKICAgICAgdGFyZ2V0L2hleGFnb246IGFkZCBZMl90bGJwcCBhcyB1bmltcGxl
bWVudGVkCiAgICAgIGh3L2hleGFnb246IGFkZCB0aGUgVjgxREdCXzEgYW5kIFY4MVFBXzEgbWFj
aGluZXMKICAgICAgaHcvaGV4YWdvbjogbW92ZSAic2ltIiBhbGlhcyB0byAiVjgxUUFfMSIKICAg
ICAgdGFyZ2V0L2hleGFnb246IHdpZGVuIHY4MSBDUFUgbWFza3MKICAgICAgdGFyZ2V0L2hleGFn
b246IGFkZCB2ODEgaW50ZXJydXB0IHJlZ2lzdGVycwogICAgICB0ZXN0cy9mdW5jdGlvbmFsOiBj
b3ZlciB2ODEgc3lzdGVtIHJlZ2lzdGVycwogICAgICBkb2NzOiBDb3JyZWN0IHNlbWlob3N0IHNw
ZWMgVVJMCgogZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0ICAgICAgICAgICAgICB8ICAg
MiArLQogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCAgICAgICAgICAgICAgICB8ICAxMSAr
KwogdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oICAgICAgICAgICAgICAgICAgICB8ICAgNiArKwog
dGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQogdGFy
Z2V0L2hleGFnb24vaGV4X3JlZ3MuaCAgICAgICAgICAgICAgICAgICB8ICA0MiArKysrKysrKwog
dGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oICAgICAgICAgICAgICAgICB8ICAxMSArLQogaHcv
aGV4YWdvbi9tYWNoaW5lX2NmZ192ODFkZ2JfMS5oLmluYyAgICAgICB8ICA3MyArKysrKysrKysr
KysrCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y4MXFhXzEuaC5pbmMgICAgICAgIHwgIDczICsr
KysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jICAgICAgICAgICAg
fCAgIDMgKwogdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMgICAgICAgICB8ICAx
MCArLQogaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jICAgICAgICAgICAgICAgICAgICB8ICA0OCAr
KysrKysrKy0KIGh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyAgICAgICAgICAgICAgfCAg
MTAgKysKIGxpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMgICAgICAgICAgICAgICAgfCAgIDYg
KysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQgKyst
CiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgICAgICAgICAgICAgICAgIHwgIDE1ICsrLQog
dGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgICAgICAgICB8ICAgOCArLQogdGFy
Z2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMuYyAgICAgICAgICAgICB8IDE0MSArKysrKysrKysr
KysrKysrKy0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAg
ICAgIHwgIDU4ICsrKysrKy0tLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAg
ICAgICAgICAgfCAgIDggKy0KIHRlc3RzL3RjZy9oZXhhZ29uL2NoZWNrX3Jldl9nYXRpbmcuYyAg
ICAgICAgfCAgMzIgKysrKystCiB0ZXN0cy90Y2cvaGV4YWdvbi92NzNfc2NhbGFyLmMgICAgICAg
ICAgICAgIHwgICA3ICsrCiB0ZXN0cy90Y2cvaGV4YWdvbi92Nzlfc2NhbGFyLmMgICAgICAgICAg
ICAgIHwgMTU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL3Rh
Z19yZXZfaW5mby5jLmluYyAgICAgICAgICAgfCAgMzAgKysrKystCiB0YXJnZXQvaGV4YWdvbi9p
bXBvcnRlZC9lbmNvZGVfcHAuZGVmICAgICAgIHwgIDIxICsrKysKIHRhcmdldC9oZXhhZ29uL2lt
cG9ydGVkL2xkc3QuaWRlZiAgICAgICAgICAgfCAgMjEgKysrKwogdGFyZ2V0L2hleGFnb24vaW1w
b3J0ZWQvc3lzdGVtLmlkZWYgICAgICAgICB8ICAgNyArKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhh
Z29uL3Rlc3RfYXJjaF90ZXN0cy5weSB8ICAyMSArKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9tZXNv
bi5idWlsZCAgICAgICAgICAgICAgIHwgICAxICsKIDI4IGZpbGVzIGNoYW5nZWQsIDc1MyBpbnNl
cnRpb25zKCspLCA4NyBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29u
L21hY2hpbmVfY2ZnX3Y4MWRnYl8xLmguaW5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdv
bi9tYWNoaW5lX2NmZ192ODFxYV8xLmguaW5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNn
L2hleGFnb24vdjc5X3NjYWxhci5jCg==

