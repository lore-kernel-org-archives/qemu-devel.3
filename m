Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE53C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coD-0008Vq-Bp; Wed, 02 Sep 2026 00:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1co9-0008Uq-Mr
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1co7-0000Iy-DU
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTj053109252
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZNTR3/6EkzzGDdmrE+eKhhQJUXAT/uyCSJ3ksScZAE0=; b=GtjEYlJwoSMwKm3p
 zHVpwLe2Eg/NfpUOoSl+bXT9Rkrgtx1gLs6QyoSFP3F8dNO8DH/utpRcb5zQbc5P
 QLM6y3rHcpv3LvO2NzYLn+DjstNdnucSWLjzPl/JYenETur+lrxIlEN8B991DjWn
 /poU0JhL0qb6sT4zYjrqocy3bVYcvX0YkAx+/my7wrDyOyHIVyqSb/7PsfyfdYau
 JEUCNTt5eSr/kac0ql0KsadkrMTwFiea7wmmzMZ+iybpkCJchBLcuZmT8YJ2UwSI
 fCuTxivEQ3gvl/zYU43qIjhBWgk7e9Ft7fOKrGYDNnORlRxAWXH2kEiXBrcD5w/l
 TDz66w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpan6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:42:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d94a158dc8so10158065ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324161; x=1788928961; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZNTR3/6EkzzGDdmrE+eKhhQJUXAT/uyCSJ3ksScZAE0=;
 b=JysyZ9kvUQ+Whmgp72r/jVgIli1edo+0Hjm4xczHRb2F8vIn++WqGevldd4GLmDzV5
 ggul3uvgdRi1V304frRbTIPlUGEEzYWKGUBD2DQklLrcGeXhsIw4xtCs4x2infUVsV38
 CVsjiz9PFZ0wTJh6a/5hR3RMuJq39odh2lrB7x5EIwpj9gHvYr3bJQgFhTVLlbfiANpO
 +3QMNrbB1TUhZHJcawe47kWSTsPkFJ4xQGsEfchMn4fMveZvDckWOwW08PGr7q2qe76m
 EOA7dOpf27ydXAywOVQkKh4AlwDErgYgVQJAm5ajHe4+8y3m7pcVQTvO3uZVBoEM36Nd
 6Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324161; x=1788928961;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZNTR3/6EkzzGDdmrE+eKhhQJUXAT/uyCSJ3ksScZAE0=;
 b=Gz3pXp3Q3m6ivM6spGOXUWfR8wwOmUpUsZ28Toc8MRZi845+q84EOdzEFHe42t3+Fl
 CDmGqJ3fN0DAzV7aPT9/7ZA5MiOY7DvFN5jkbkx56Vkl1jumC256OhO5yRO0K3MYib7I
 hXzDaY9m1ncpN9VomlOBeM1V3XcZGaOpjPp3YvJEKmUsV69fTrvVDVkAMX6LDt65POul
 oLjbeHNi2hGkqmYvJCeM4nRPQNGfARY1CWzFYXbZ7ozVu6+6GJOAyofoe6rB4vjamMVR
 TMeTf4+TiexKXNyguB9mBaKpdGHRNmrr/4gOOwdQE9n3Nm70DOFgPQoVwQ8TEYNAkYpb
 FTTQ==
X-Gm-Message-State: AFuF++mKdwNK5aUGBkXmbzNGmqG1xBTeVyrfA/Cc8gAtFpOZAaxvqla8
 cC+hLKmfRQR+55fe6DG5OyJWCvfuzsm7805cGL1aRqRTy5p2rll8q1I8z2LbvemgjBvuiyz7IAG
 5n9WEtgFRskG2PoLZS0i0VoLKJCP63f6irlIS8z6A0DFAFsxwXq3N5NNtXjnZCL3cSg==
X-Gm-Gg: AYBFou1sc/1X2+NIJrAZKZKMq1utcpy76uvP0PK6UiofWHMG/mTI4i+ST9ULD/CR3sl
 5y2WwJAAEjJ2VwOG+bSaZoBTOiMX0YsLKajJmyLk6Z5oZubBmLmhJW8VDof/841Uv7/yJNHzg9S
 CB3KBIvt2mTy5fMEb8H+3uA31BDKY2o06iSm3n8fF+YaBB265wacLlLWUDIpc9I9QNjpQCDVLsW
 99LpUKFDDfPEyLPiRz8kVMj4uexa4KBhwkW/I0F924UoaCpY2e1+tMFSNs/tIo4ADQMYYMsLE5R
 0dS9y9ewFLPHq8MXLBC8YxRRTKlWAUn00go5Jp3Ar/3y7/OAdwIPF/FR4IPHOq5I2TqUD/v0BJe
 lLIBCifkfOtmVI6IMOTcZuqcyy6GmWYFKeULiZ0ACEV/30nFh
X-Received: by 2002:a17:903:3810:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2daec5e6457mr11107375ad.8.1788324161311; 
 Tue, 01 Sep 2026 21:42:41 -0700 (PDT)
X-Received: by 2002:a17:903:3810:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2daec5e6457mr11106875ad.8.1788324160781; 
 Tue, 01 Sep 2026 21:42:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:42:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 01/28] disas/hexagon: honour target byte order when printing
 instructions
Date: Tue,  1 Sep 2026 21:42:04 -0700
Message-Id: <20260902044231.843004-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97a941 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Y0R2AH0urpkzOH2ra7cA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 2seM4BhQVIx1zWq6-ly2DDadPVm29nJu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX8hqjjxXtJTac
 sEiwqSOvaDKO0yd3RzXlo4oxnUqyOLhLP9767GBYi+eeSbBuIFSzX2LLQHda/RkxIgG07zCOALo
 M5wfE8QPAiTaNmsmFOwdazkKfpG3F/I=
X-Proofpoint-ORIG-GUID: 2seM4BhQVIx1zWq6-ly2DDadPVm29nJu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfXw6l+1G4jmNqT
 r0QgF02+2CfdMqW1+mR/Eaeg7N6nku5tZoTYPHqnWwS2eulkXC8hCByXVMB9apJFA9D1xXlwS+c
 TluuYbpZJq4eyyr9mYc6BX7ZPfUP9HzcUSJjI/mtNDp7Q+2QbIdjSJs4wprSnOAfr8qPGDviU2U
 KgK/cu6T2WFXMoL3pMojqr4E2HYaCtqovoA+lSPQuf/4h6ZsGleDdyT73zwfY1QBViuCQG9RikW
 hifYYwSWtHuHdKXLwqiS9/C+aFMvEh7+KkiNS1yjNohjMBV2u+9Uc0AeW6X3WL1Xb+yUSI2SBIA
 Z4k9Lv4eTR3sd9ox3u8rBq3UWloBRXAt72vap5Ql7ACbdM7rmkoN8IU2s1SqBUHnE+gn7pUwWJ1
 Y+yxCXJqQhHUtMGQLQZ1wOUiAejdhnz3gCr4jlB/oRSBe5yCuObti8wqE4t1t442nmk6SbBusXW
 JyBnCFClqaFEdQkDFHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKcHJpbnRfaW5zbl9oZXhhZ29uKCkgcmVhZCBlYWNoIGluc3RydWN0aW9u
IHdvcmQgYXMgYSBob3N0LW9yZGVyIGludGVnZXIsCnRodXMgZ2V0dGluZyB0aGVtIGludmVydGVk
IG9uIGEgYmlnLWVuZGlhbiBob3N0LiBJbnN0ZWFkLCByZWFkIGludG8gYQpieXRlIGJ1ZmZlciBh
bmQgY29udmVydCB3aXRoIGxkbF9sZV9wKCkuCgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFy
ZXMgQmVybmFyZGlubyA8bWF0aGV1cy5iZXJuYXJkaW5vQG9zcy5xdWFsY29tbS5jb20+ClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiBkaXNhcy9oZXhhZ29uLmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kaXNhcy9oZXhhZ29uLmMg
Yi9kaXNhcy9oZXhhZ29uLmMKaW5kZXggZTJkMzgwNDYwNmUuLjYyZTBjYmE2NjExIDEwMDY0NAot
LS0gYS9kaXNhcy9oZXhhZ29uLmMKKysrIGIvZGlzYXMvaGV4YWdvbi5jCkBAIC0yMCw2ICsyMCw3
IEBACiAgKi8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJxZW11L2Jzd2Fw
LmgiCiAjaW5jbHVkZSAiZGlzYXMvZGlzLWFzbS5oIgogI2luY2x1ZGUgInRhcmdldC9oZXhhZ29u
L2NwdV9iaXRzLmgiCiAKQEAgLTM3LDkgKzM4LDkgQEAgaW50IHByaW50X2luc25faGV4YWdvbihi
ZmRfdm1hIG1lbWFkZHIsIHN0cnVjdCBkaXNhc3NlbWJsZV9pbmZvICppbmZvKQogICAgIGludCBp
LCBsZW47CiAKICAgICBmb3IgKGkgPSAwOyBpIDwgUEFDS0VUX1dPUkRTX01BWCAmJiAhZm91bmRf
ZW5kOyBpKyspIHsKKyAgICAgICAgYmZkX2J5dGUgaW5zbltzaXplb2YodWludDMyX3QpXTsKICAg
ICAgICAgaW50IHN0YXR1cyA9ICgqaW5mby0+cmVhZF9tZW1vcnlfZnVuYykobWVtYWRkciArIGkg
KiBzaXplb2YodWludDMyX3QpLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAoYmZkX2J5dGUgKikmd29yZHNbaV0sCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZih1aW50MzJfdCksIGluZm8pOworICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnNuLCBzaXplb2YodWlu
dDMyX3QpLCBpbmZvKTsKICAgICAgICAgaWYgKHN0YXR1cykgewogICAgICAgICAgICAgaWYgKGkg
PiAwKSB7CiAgICAgICAgICAgICAgICAgYnJlYWs7CkBAIC00Nyw2ICs0OCw3IEBAIGludCBwcmlu
dF9pbnNuX2hleGFnb24oYmZkX3ZtYSBtZW1hZGRyLCBzdHJ1Y3QgZGlzYXNzZW1ibGVfaW5mbyAq
aW5mbykKICAgICAgICAgICAgICgqaW5mby0+bWVtb3J5X2Vycm9yX2Z1bmMpKHN0YXR1cywgbWVt
YWRkciwgaW5mbyk7CiAgICAgICAgICAgICByZXR1cm4gc3RhdHVzOwogICAgICAgICB9CisgICAg
ICAgIHdvcmRzW2ldID0gbGRsX2xlX3AoaW5zbik7CiAgICAgICAgIGlmIChpc19wYWNrZXRfZW5k
KHdvcmRzW2ldKSkgewogICAgICAgICAgICAgZm91bmRfZW5kID0gdHJ1ZTsKICAgICAgICAgfQot
LSAKMi4zNC4xCgo=

