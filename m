Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23CBC282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPd-0000gJ-Ct; Sat, 01 Mar 2025 00:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPa-0000Wg-Uy
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:19 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPZ-0008Oc-51
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:18 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213MR3O026429
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HtBGTN8h1V9BaLrO3MkP7qMtLGloXFEPLkdd3zfdKyc=; b=N30fSf0mnoDuceGI
 mtkPYn5YovCMMecElRnkgOQMRw4j3Bjfj2pMS1JoSBCssHBbcXzbqCtbnNon7EHo
 h1R86L4mE6XBgwkTmJLHvqgY9evmMDnfNmb2HK5p4Hkai6eR5YnuTkGAHgQ0vBy6
 8l2VyozNBMGLTPxVbhr60DWR5UuP8ylrckT72672LnPRX4747PZWd3JuYOwZIrNg
 7DYrnon++XEwcqheutdlRwIQ40lEV9BOo6jrtT2bYqwyOkK+VHzBbICsKAfMGh99
 xGgOn5gMh1/t7jgy1Hx8mmtA0vh7PWl/ivBho8gSsoheHgHmwgEBtkE0+hW2eb5o
 Y3zs2w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t9905qc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-223551ee0a3so62226975ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806945; x=1741411745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtBGTN8h1V9BaLrO3MkP7qMtLGloXFEPLkdd3zfdKyc=;
 b=scfL98pUdGG6n35IUrJDSR+kf9qGupY+3R2R6JgxbMouYyrNP+/ez6+qiv98PUHDd7
 oiqB9nXRqjG1YYamLe3ABrACTmwuXnmsJJFjfCgBdpZeLDYmUQAM6DuWZMBU/UEH5yDM
 y5MkgtVhZXxtnO1VZWcvWaT3GEL0d+4/PxKKhzBQHCCswOJHMp69KG0vgax5Fd0WyqGh
 O0Kfaj2U+Ad2wqx/XpTJrJAkaFj3GgwBmenqnUj4SnoX8Bs+EG1bTzKLCpskn3m3pRw5
 LRwliLS5xKvBxHjXe/rz7LvZrGxwi2bh1KcV/LFeV+e6K2Uc5SdcJIQ3sveDxxPjompE
 TWGA==
X-Gm-Message-State: AOJu0YzLudCCifnSJ98PKCMPU85En79YduPITHPJBR+E6HHBKEhYdcEi
 icHSn/YXhmDQfc638mStaLirmWw7kzZqGNE4se7D3Lr3+P4Mvo+0jYvqW/HQWEky2zWJ1c9bI2m
 Y3EEaZ9aCr/FbbQq3JrbiY/p6Guf378EeKTU3tWaRYz0hWCBQsWFBZptLWx4LZA==
X-Gm-Gg: ASbGncvyloh60FONoV7cSBS2hC2/Lvqx+/hUHzmPMuTZPCBIxfNYvS3SKuBERy5Xa9R
 GtcO+wAPcV3fCgH9Drp5fIDCHGEtw0uhtz7YzMw8ffW/4m2Sc6FVQEIxZyA9qZzwJBny6gHW7Vm
 LSyUABjYZg7rT/CkwkoQqB8qkf1+1rlvelDgOY52aYKSH4TCZgOwslPkPyvIZvjqNQeVhXQGtWq
 fLAVgF3qEDwkLzYWHclCrrv17SH12hVH07RtvsFGLCdxe0S6UsWht6VR9rAeuNAQEVrz5WCR1UZ
 mQFQchDNtACVBvJWmNxfu/+voBf4+JignuSVbbvjUrln4io18NkzmlaAyHk2c3PI
X-Received: by 2002:a17:902:ec91:b0:220:e5be:29c7 with SMTP id
 d9443c01a7336-22369207a01mr90721055ad.39.1740806944751; 
 Fri, 28 Feb 2025 21:29:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0JmxUTufO2QZXiTnJ7oXrrzI/OpJerq96cWG/PasxKBEzlJKJjvC9cULavQ9ENbXQxhWj9Q==
X-Received: by 2002:a17:902:ec91:b0:220:e5be:29c7 with SMTP id
 d9443c01a7336-22369207a01mr90720745ad.39.1740806944354; 
 Fri, 28 Feb 2025 21:29:04 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:04 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 11/39] target/hexagon: Add representation to count cycles
Date: Fri, 28 Feb 2025 21:28:17 -0800
Message-Id: <20250301052845.1012069-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Bh_tzz09n2quIJ65z2U253K6-YARHKqF
X-Proofpoint-GUID: Bh_tzz09n2quIJ65z2U253K6-YARHKqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=851
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgUENZQ0xFIHJlZ2lzdGVy
IGNhbiBiZSBlbmFibGVkIHRvIGluZGljYXRlIGFjY3VtdWxhdGVkIGNsb2NrIGN5Y2xlcy4KClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgfCAgMyArKy0KIHRhcmdldC9oZXhhZ29uL2NwdS5j
ICAgICB8ICAzICsrKwogdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jIHwgMjUgKysrKysrKysrKysr
KysrKysrKysrKysrLQogMyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmgKaW5kZXggMTU0OWM0ZjFmMC4uNGI5Yzk4NzNkYyAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTExMyw3ICsxMTMs
OCBAQCB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3RhdGUgewogICAgIHRhcmdldF91bG9uZyBzdGFj
a19zdGFydDsKIAogICAgIHVpbnQ4X3Qgc2xvdF9jYW5jZWxsZWQ7Ci0KKyAgICB1aW50NjRfdCB0
X2N5Y2xlX2NvdW50OworICAgIHVpbnQ2NF90ICpnX3BjeWNsZV9iYXNlOwogI2lmbmRlZiBDT05G
SUdfVVNFUl9PTkxZCiAgICAgLyogU29tZSBzeXN0ZW0gcmVnaXN0ZXJzIGFyZSBwZXIgdGhyZWFk
IGFuZCBzb21lIGFyZSBnbG9iYWwuICovCiAgICAgdGFyZ2V0X3Vsb25nIHRfc3JlZ1tOVU1fU1JF
R1NdOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9j
cHUuYwppbmRleCA4NGE5NmExOTRiLi44OWEwNTFiNDFkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMzM1LDYgKzMzNSw3IEBA
IHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlw
ZSB0eXBlKQogCiAgICAgaWYgKGNzLT5jcHVfaW5kZXggPT0gMCkgewogICAgICAgICBhcmNoX3Nl
dF9zeXN0ZW1fcmVnKGVudiwgSEVYX1NSRUdfTU9ERUNUTCwgMHgxKTsKKyAgICAgICAgKihlbnYt
PmdfcGN5Y2xlX2Jhc2UpID0gMDsKICAgICB9CiAgICAgbW11X3Jlc2V0KGVudik7CiAgICAgYXJj
aF9zZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVHX0hUSUQsIGNzLT5jcHVfaW5kZXgpOwpAQCAt
Mzk2LDEwICszOTcsMTIgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfcmVhbGl6ZShEZXZpY2VT
dGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKICAgICBp
ZiAoY3MtPmNwdV9pbmRleCA9PSAwKSB7CiAgICAgICAgIGVudi0+Z19zcmVnID0gZ19uZXcwKHRh
cmdldF91bG9uZywgTlVNX1NSRUdTKTsKKyAgICAgICAgZW52LT5nX3BjeWNsZV9iYXNlID0gZ19t
YWxsb2MwKHNpemVvZigqZW52LT5nX3BjeWNsZV9iYXNlKSk7CiAgICAgfSBlbHNlIHsKICAgICAg
ICAgQ1BVU3RhdGUgKmNwdTAgPSBxZW11X2dldF9jcHUoMCk7CiAgICAgICAgIENQVUhleGFnb25T
dGF0ZSAqZW52MCA9IGNwdV9lbnYoY3B1MCk7CiAgICAgICAgIGVudi0+Z19zcmVnID0gZW52MC0+
Z19zcmVnOworICAgICAgICBlbnYtPmdfcGN5Y2xlX2Jhc2UgPSBlbnYwLT5nX3BjeWNsZV9iYXNl
OwogICAgIH0KICNlbmRpZgogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMg
Yi90YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMKaW5kZXggZmNkYmFjZjlmZC4uNGJhYTIyZDUxZiAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L21hY2hpbmUuYwpAQCAtOSw2ICs5LDI3IEBACiAjaW5jbHVkZSAiY3B1LmgiCiAjaW5jbHVkZSAi
aGV4X21tdS5oIgogCitzdGF0aWMgaW50IGdldF91NjRfcHRyKFFFTVVGaWxlICpmLCB2b2lkICpw
diwgc2l6ZV90IHNpemUsCisgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFZNU3RhdGVGaWVs
ZCAqZmllbGQpCit7CisgICAgdWludDY0X3QgKnAgPSBwdjsKKyAgICAqcCA9IHFlbXVfZ2V0X2Jl
NjQoZik7CisgICAgcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgcHV0X3U2NF9wdHIoUUVNVUZp
bGUgKmYsIHZvaWQgKnB2LCBzaXplX3Qgc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAgICBjb25z
dCBWTVN0YXRlRmllbGQgKmZpZWxkLCBKU09OV3JpdGVyICp2bWRlc2MpCit7CisgICAgcWVtdV9w
dXRfYmU2NChmLCAqKCh1aW50NjRfdCAqKXB2KSk7CisgICAgcmV0dXJuIDA7Cit9CisKK2NvbnN0
IFZNU3RhdGVJbmZvIHZtc3RhdGVfaW5mb191aW50NjRfcHRyID0geworICAgIC5uYW1lID0gInVp
bnQ2NF90X3BvaW50ZXIiLAorICAgIC5nZXQgID0gZ2V0X3U2NF9wdHIsCisgICAgLnB1dCAgPSBw
dXRfdTY0X3B0ciwKK307CisKIHN0YXRpYyBpbnQgZ2V0X2hleF90bGJfcHRyKFFFTVVGaWxlICpm
LCB2b2lkICpwdiwgc2l6ZV90IHNpemUsCiAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFZN
U3RhdGVGaWVsZCAqZmllbGQpCiB7CkBAIC0zNSw3ICs1Niw2IEBAIGNvbnN0IFZNU3RhdGVJbmZv
IHZtc3RhdGVfaW5mb19oZXhfdGxiX3B0ciA9IHsKICAgICAucHV0ICA9IHB1dF9oZXhfdGxiX3B0
ciwKIH07CiAKLQogY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGV4YWdvbl9jcHUg
PSB7CiAgICAgLm5hbWUgPSAiY3B1IiwKICAgICAudmVyc2lvbl9pZCA9IDAsCkBAIC01Niw2ICs3
Niw5IEBAIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2hleGFnb25fY3B1ID0gewog
ICAgICAgICBWTVNUQVRFX1VJTlRUTChlbnYud2FpdF9uZXh0X3BjLCBIZXhhZ29uQ1BVKSwKICAg
ICAgICAgVk1TVEFURV9QT0lOVEVSKGVudi5oZXhfdGxiLCBIZXhhZ29uQ1BVLCAwLAogICAgICAg
ICAgICAgICAgICAgICAgICAgdm1zdGF0ZV9pbmZvX2hleF90bGJfcHRyLCBDUFVIZXhhZ29uVExC
Q29udGV4dCAqKSwKKyAgICAgICAgVk1TVEFURV9VSU5UNjQoZW52LnRfY3ljbGVfY291bnQsIEhl
eGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1BPSU5URVIoZW52LmdfcGN5Y2xlX2Jhc2UsIEhl
eGFnb25DUFUsIDAsCisgICAgICAgICAgICAgICAgICAgICAgICB2bXN0YXRlX2luZm9fdWludDY0
X3B0ciwgdWludDY0X3QgKiksCiAKICAgICAgICAgVk1TVEFURV9FTkRfT0ZfTElTVCgpCiAgICAg
fSwKLS0gCjIuMzQuMQoK

