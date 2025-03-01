Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDB0C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 17:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toQWf-0003DK-1S; Sat, 01 Mar 2025 12:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWM-00039k-7i
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:21:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWK-0008RH-5Q
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:21:01 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5216NHcV007137
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 17:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EYrM1Tw2JJjG2G6ea4WL6R8r9CdiNdQHoPM4DiyZYTc=; b=bq7yazJw7qNk5bol
 sU8n0We2Ot/a4dHQZ3L6b5sacKtVNrEdBE61QqN4oBhjA9WhKARmten+7MR4mJeF
 NXr76xTrfaWOSy/4+TGtWIPggUnGv+m+NcBTSUQyUA8a+q4T593iQhPLbndQzX3s
 LjS9kUCoqXKq6IH4w2bMGMKpByMomtIk367oX9hSVi+KOfPWIDLOVr8C+/z6LYDp
 Q9D3i8q+l6XplJoT9A5uI0SDom53mSp3SX5YPCe8gSXeSxNRDOOmyLQ6YQdH2FNq
 cWsBbwBc18Eydng4K8tuOtNWZ8QURThuHsKQBRR4GIEMjM3s/mpHu9SfuY/RdOci
 rArlAA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t89s4mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 17:20:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2234dddbd6fso70921515ad.0
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 09:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740849658; x=1741454458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYrM1Tw2JJjG2G6ea4WL6R8r9CdiNdQHoPM4DiyZYTc=;
 b=UlKXkKi5CyiB6QOg6HP+hw+DWuZs06wKptxd0v7BvSzsgiKwQsTgK6+u9Q4nYnLKgT
 P0uiRodsWLkbmT4eEbQC078hlwP5VlfocC39veMxna7Je1shH7DeLtEL/Kek6EuxgdMR
 So7nWLaZC843Tk7n3c7Dawa1rzg32RQ5lHJiWBbhP+wd3skUWqGwwKausPszbdAHCb+M
 AYtfkltysa+cra3HmfWVKjlsx/vApKtJmy6ZrNfDEnuQa/Usa+6uGcr9K98823B6pR1X
 t3t4wx7/K7gBOG3+XF190497FuYvc7mPKE69mK0IgddvjWGospzmkCpEb5x+rBJhsBm2
 JpsA==
X-Gm-Message-State: AOJu0YxaWdZmrl7niYSipnyXxxaJqNeklTTEUgOqDUn6XJwf9ccCrzpr
 99U2ROzxgReQ5RdXmmVk8sF9M/dr0v5obdxjwzI4CaBerceHwJmVbGDP+GdcoYXq5sRQhBigDuZ
 XMxiJAiREIWQlINb3NQa0jnqrzYLc5kbil0+58HMz8nwxjFV1HtDOcDyCUukVdg==
X-Gm-Gg: ASbGncsxdlEH2eRocd+gR51kX2C+RKxWsTecsdLDjUkxzGGokKOqDFtWbNaxvXhHZSB
 W+iHXtHt5CL97kcKS/ajWGib34v5qeVbnRHi3QFiGYWo3uJffuWMVUgh5lnXtu0MZ7HnkSkGrvA
 LStg2WpKXPDTKeJ6SDoGFQRwj52z9QlW1y1d5qB6FFFwwMeyKStOuGi0yWbr4ZLHkmsFc3ALf6t
 qw0jKhKS9jh6jyggqoq9SMLLBGNFfjx6psQFPS1GWQ+1bN2L4I3pFG18m/lCiJfxNPiEmlCFkmP
 D4ecslTkHWZQyDsnxwNkVe60bSio8rKuX28khz2iCMb+qJIxkXeazmgjqcHCfTk9
X-Received: by 2002:a17:903:190:b0:215:44fe:163d with SMTP id
 d9443c01a7336-223674cb85emr104566145ad.17.1740849657753; 
 Sat, 01 Mar 2025 09:20:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENRPaT5u+9u+F2q7snZ03Vohy90KthqC9fYMqkYnzLctrkIzo9ZJWYxsJe5RgtiUs1tKBrFg==
X-Received: by 2002:a17:903:190:b0:215:44fe:163d with SMTP id
 d9443c01a7336-223674cb85emr104565845ad.17.1740849657354; 
 Sat, 01 Mar 2025 09:20:57 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9dacsm51308275ad.83.2025.03.01.09.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 09:20:57 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH 4/8] hw/hexagon: Add support for cfgbase
Date: Sat,  1 Mar 2025 09:20:41 -0800
Message-Id: <20250301172045.1295412-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: PgfSRmeNDV699cd26hFSPr-VECsVJGc5
X-Proofpoint-GUID: PgfSRmeNDV699cd26hFSPr-VECsVJGc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_07,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBT
aWQgTWFubmluZyA8c2lkbmV5bUBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUu
aCAgICAgfCAgMSArCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgfCAxMCArKysrKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgfCAgNiArKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0
L2hleGFnb24vY3B1LmgKaW5kZXggNzNjM2JiMzRiMC4uMDYwOGQzMjY1YyAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTE5NSw2
ICsxOTUsNyBAQCBzdHJ1Y3QgQXJjaENQVSB7CiAgICAgdWludDMyX3QgbDJ2aWNfYmFzZV9hZGRy
OwogICAgIHVpbnQzMl90IGh2eF9jb250ZXh0czsKICAgICB1aW50MzJfdCBib290X2FkZHI7Cisg
ICAgdWludDY0X3QgY29uZmlnX3RhYmxlX2FkZHI7CiAjZW5kaWYKIH07CiAKZGlmZiAtLWdpdCBh
L2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBiL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwppbmRl
eCA5ZjE4Y2I2ZTNhLi5jNDk2MmE5OGJjIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleGFnb25f
ZHNwLmMKKysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCkBAIC04Miw2ICs4MiwxMiBAQCBz
dGF0aWMgdm9pZCBoZXhhZ29uX2NvbW1vbl9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgUmV2
X3QgcmV2LAogCiAgICAgTWVtb3J5UmVnaW9uICphZGRyZXNzX3NwYWNlID0gZ2V0X3N5c3RlbV9t
ZW1vcnkoKTsKIAorICAgIE1lbW9yeVJlZ2lvbiAqY29uZmlnX3RhYmxlX3JvbSA9IGdfbmV3KE1l
bW9yeVJlZ2lvbiwgMSk7CisgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JvbShjb25maWdfdGFibGVf
cm9tLCBOVUxMLCAiY29uZmlnX3RhYmxlLnJvbSIsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzaXplb2YobV9jZmctPmNmZ3RhYmxlKSwgJmVycm9yX2ZhdGFsKTsKKyAgICBtZW1vcnlfcmVn
aW9uX2FkZF9zdWJyZWdpb24oYWRkcmVzc19zcGFjZSwgbV9jZmctPmNmZ2Jhc2UsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmZpZ190YWJsZV9yb20pOworCiAgICAgTWVtb3J5
UmVnaW9uICpzcmFtID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAxKTsKICAgICBtZW1vcnlfcmVnaW9u
X2luaXRfcmFtKHNyYW0sIE5VTEwsICJkZHIucmFtIiwKICAgICAgICAgbWFjaGluZS0+cmFtX3Np
emUsICZlcnJvcl9mYXRhbCk7CkBAIC0xMzAsNiArMTM2LDEwIEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fY29tbW9uX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lLCBSZXZfdCByZXYsCiAgICAgICAg
IH0KIAogICAgIH0KKworICAgIHJvbV9hZGRfYmxvYl9maXhlZF9hcygiY29uZmlnX3RhYmxlLnJv
bSIsICZtX2NmZy0+Y2ZndGFibGUsCisgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZiht
X2NmZy0+Y2ZndGFibGUpLCBtX2NmZy0+Y2ZnYmFzZSwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsKIH0KIAogc3RhdGljIHZvaWQgaW5pdF9tYyhNYWNo
aW5lQ2xhc3MgKm1jKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQv
aGV4YWdvbi9jcHUuYwppbmRleCA0Y2E2YWRkODM0Li4zNDk0MGU5YTg0IDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtNjcsNiAr
NjcsOCBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkgaGV4YWdvbl9jcHVfcHJvcGVydGllc1tdID0g
ewogICAgICAgICAweGZmZmZmZmZmVUxMKSwKICAgICBERUZJTkVfUFJPUF9VSU5UMzIoImh2eC1j
b250ZXh0cyIsIEhleGFnb25DUFUsIGh2eF9jb250ZXh0cywgMCksCiAgICAgREVGSU5FX1BST1Bf
VUlOVDMyKCJleGVjLXN0YXJ0LWFkZHIiLCBIZXhhZ29uQ1BVLCBib290X2FkZHIsIDB4ZmZmZmZm
ZmZVTEwpLAorICAgIERFRklORV9QUk9QX1VJTlQ2NCgiY29uZmlnLXRhYmxlLWFkZHIiLCBIZXhh
Z29uQ1BVLCBjb25maWdfdGFibGVfYWRkciwKKyAgICAgICAgICAgICAgICAgICAgICAgMHhmZmZm
ZmZmZlVMTCksCiAjZW5kaWYKICAgICBERUZJTkVfUFJPUF9CT09MKCJsbGRiLWNvbXBhdCIsIEhl
eGFnb25DUFUsIGxsZGJfY29tcGF0LCBmYWxzZSksCiAgICAgREVGSU5FX1BST1BfVU5TSUdORUQo
ImxsZGItc3RhY2stYWRqdXN0IiwgSGV4YWdvbkNQVSwgbGxkYl9zdGFja19hZGp1c3QsIDAsCkBA
IC0zNjEsNiArMzYzLDggQEAgdm9pZCBoZXhhZ29uX2NwdV9zb2Z0X3Jlc2V0KENQVUhleGFnb25T
dGF0ZSAqZW52KQogfQogI2VuZGlmCiAKKworI2RlZmluZSBIRVhBR09OX0NGR19BRERSX0JBU0Uo
YWRkcikgKCgoYWRkcikgPj4gMTYpICYgMHgwZmZmZmYpCiBzdGF0aWMgdm9pZCBoZXhhZ29uX2Nw
dV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKIHsKICAgICBDUFVTdGF0
ZSAqY3MgPSBDUFUob2JqKTsKQEAgLTQwMSw2ICs0MDUsOCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKICAgICBlbnYtPndh
aXRfbmV4dF9wYyA9IDA7CiAgICAgZW52LT5jYXVzZV9jb2RlID0gLTE7CiAgICAgYXJjaF9zZXRf
dGhyZWFkX3JlZyhlbnYsIEhFWF9SRUdfUEMsIGNwdS0+Ym9vdF9hZGRyKTsKKyAgICBhcmNoX3Nl
dF9zeXN0ZW1fcmVnKGVudiwgSEVYX1NSRUdfQ0ZHQkFTRSwKKyAgICAgICAgICAgICAgICAgICAg
ICAgIEhFWEFHT05fQ0ZHX0FERFJfQkFTRShjcHUtPmNvbmZpZ190YWJsZV9hZGRyKSk7CiAjZW5k
aWYKIH0KIAotLSAKMi4zNC4xCgo=

