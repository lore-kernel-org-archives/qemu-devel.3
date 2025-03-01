Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE0EC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNz-0003Qu-64; Sat, 01 Mar 2025 00:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNv-0003IX-5X
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNt-0008AX-Eo
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:34 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213NhXd027730
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aKvL3i6Vu6ZFK58vcOfHb7Sn1Naka9a/PukJGHq1R0I=; b=XqM1P66pPLOnt+Fo
 K1vMJbjLDWrpOGHfcuoGXUv7DHnsQpXqTw9ePBQi6Ua9RPxHKKO0P230mhn0adm/
 Ak3nNEsdeRxJuJQNvTXMwaa8MPyCsOY+xn57et10QzMNXPxG1fTKttSuR476QSik
 kVPb6ycVnx+fR2VktoTmi4XBGie++fCUDKFi3Ozz0lkZa+UOF1JSUaGrk8grnxD/
 S2O2lfkUiu+PUfFY60l3THxTBb57JzaQAcHcEVqj8VxFRM4s5CQ6T8y8gAKVXfGj
 XDqqWisnzFuOiY0t60cXhHvix3MRPO5RNjNCJYpbCMlZFhL3p2P4cuXedX8XxVVS
 uC8mJQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t9905k6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-21f6cb3097bso75792705ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806841; x=1741411641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKvL3i6Vu6ZFK58vcOfHb7Sn1Naka9a/PukJGHq1R0I=;
 b=GzUuwBCQQeEekqoCx20AXXJkJHnt/OeKBewpETpZTEN9WZfkC349ZOo9RmUC5/USqS
 L7QDuZMGtay4werpkio1Cxl5F5hFk8KkokhLlrW8xeiiagoZM5TvpRMZ/zP+0sS7rbt4
 8LD9MIxO6wRs5aaUygztJaS6RJZkbxrbJ1QKtw4LfIsUadLZJfOnxyORweZhXVR017+H
 Ui1LEpFDtQml0Xi/Zzdu9CYU6Sk4o6BAQSGkD8nybLkrhWsb7J1X59pq/0s9AsLw6kx7
 whCj2eW21IRjeXndPYTZOf6sdrIJGNSCb+KEstYB5kFgbJVd1KhKaMOfEcHYF22eO7yW
 HHHA==
X-Gm-Message-State: AOJu0YwBA+jsd1oqvLuGpQf0oStFrxgE4k051k/dwMgFf74w64BNs4CB
 MUKpseP+liol5xUeYGbM4PhSOyC8urCG1eN4Ee+BztgqNfxond8ZM999DqeHFSiymPrNDZ6vRoK
 Yfh7DD8xhHm9fJjCqhE/RCG/4oMHc6qGp7Vlmq1xDQZNzn9C1+8ak9P+5sbh2HQ==
X-Gm-Gg: ASbGncv4yud33oeWrzJ0SRugi1FaGZXFz0pFaGEwGkZJY/JKElr7Lcg5SPVrFxih23H
 8Iuf1N6S+EVj9aa4c4M7ja3k3Om2rUiOGTVFk5VisnRFzzLYac3Ip+tCiUkkxp7CthGfz3jcwSS
 b2xISAO20n0u7GvU/elG9ygSNeZlhH7tsKYKo73GCPx5nUvurB7WICEKZ7+SKJg8wjmfWhhk1MB
 +Mec5ZgdPOUo3HxW9AoekIxxK3CSN+yFoKR5/MdZu6a4dVYVdrlsIW95NohsvwFy8epXW2nHMjN
 eVt1RM3ni4m0Xm/jTNu7XZx2Gg3xdACVhCXmxKx7M2/20OA8VScz7Hsdp0K43fLE
X-Received: by 2002:a17:902:e78d:b0:223:6455:8752 with SMTP id
 d9443c01a7336-2236925924dmr90805275ad.43.1740806841068; 
 Fri, 28 Feb 2025 21:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/YXwweXXTanYtuF/Hmky7gtHnZLcKRQwdDVyw8kped8XqwAKUu1MK4G06/LCgagkiKOLymg==
X-Received: by 2002:a17:902:e78d:b0:223:6455:8752 with SMTP id
 d9443c01a7336-2236925924dmr90804995ad.43.1740806840707; 
 Fri, 28 Feb 2025 21:27:20 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:20 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 25/38] target/hexagon: Add TCG overrides for thread ctl
Date: Fri, 28 Feb 2025 21:26:15 -0800
Message-Id: <20250301052628.1011210-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: RST-KICdkGw9GghO4GSwq-S_eEAAKltg
X-Proofpoint-GUID: RST-KICdkGw9GghO4GSwq-S_eEAAKltg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=604
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Igc3RhcnQsIHN0b3AsIHdhaXQsIHJlc3VtZSBpbnN0cnVjdGlvbnMuCgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZ19zeXMuaCB8IDE4ICsrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hl
eGFnb24vaGVscGVyLmggICAgICB8ICA0ICsrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
ICAgfCAyMCArKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaCBiL3Rhcmdl
dC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKaW5kZXggNjQyY2EzZDNmZi4uOTQyZDA3YjQwMSAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnX3N5cy5oCkBAIC02Myw0ICs2MywyMiBAQAogICAgICAgICB0Y2dfZ2VuX2V4dHJo
X2k2NF9pMzIoY3R4LT50X3NyZWdfbmV3X3ZhbHVlW0hFWF9TUkVHX1NHUDFdLCB0bXApOyBcCiAg
ICAgfSB3aGlsZSAoMCkKIAorI2RlZmluZSBmR0VOX1RDR19ZMl93YWl0KFNIT1JUQ09ERSkgXAor
ICAgIGRvIHsgXAorICAgICAgICBSc1YgPSBSc1Y7IFwKKyAgICAgICAgZ2VuX2hlbHBlcl93YWl0
KHRjZ19lbnYsIHRjZ19jb25zdGFudF90bChjdHgtPnBrdC0+cGMpKTsgXAorICAgIH0gd2hpbGUg
KDApCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfcmVzdW1lKFNIT1JUQ09ERSkgXAorICAgIGdlbl9o
ZWxwZXJfcmVzdW1lKHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZMl9zdGFydChT
SE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX3N0YXJ0KHRjZ19lbnYsIFJzVikKKworI2RlZmlu
ZSBmR0VOX1RDR19ZMl9zdG9wKFNIT1JUQ09ERSkgXAorICAgIGRvIHsgXAorICAgICAgICBSc1Yg
PSBSc1Y7IFwKKyAgICAgICAgZ2VuX2hlbHBlcl9zdG9wKHRjZ19lbnYpOyBcCisgICAgfSB3aGls
ZSAoMCkKKwogI2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3Rh
cmdldC9oZXhhZ29uL2hlbHBlci5oCmluZGV4IDJmZTQ0NDBkZGMuLmFkYTUyMGJkNTIgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hlbHBl
ci5oCkBAIC0xMjQsNCArMTI0LDggQEAgREVGX0hFTFBFUl8yKGdyZWdfcmVhZF9wYWlyLCBpNjQs
IGVudiwgaTMyKQogREVGX0hFTFBFUl8zKHNyZWdfd3JpdGUsIHZvaWQsIGVudiwgaTMyLCBpMzIp
CiBERUZfSEVMUEVSXzMoc3JlZ193cml0ZV9wYWlyLCB2b2lkLCBlbnYsIGkzMiwgaTY0KQogREVG
X0hFTFBFUl8zKHNldHByaW8sIHZvaWQsIGVudiwgaTMyLCBpMzIpCitERUZfSEVMUEVSXzIoc3Rh
cnQsIHZvaWQsIGVudiwgaTMyKQorREVGX0hFTFBFUl8xKHN0b3AsIHZvaWQsIGVudikKK0RFRl9I
RUxQRVJfMih3YWl0LCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihyZXN1bWUsIHZvaWQs
IGVudiwgaTMyKQogI2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDU3NWYzZmIxNjMuLjA5YTUyODQz
MjkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xMzY3LDYgKzEzNjcsMjYgQEAgdWludDMyX3QgSEVMUEVS
KGlhc3NpZ25yKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CiB9CiAKK3ZvaWQgSEVMUEVSKHN0YXJ0KShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgaW1hc2spCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsK
K30KKwordm9pZCBIRUxQRVIoc3RvcCkoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7CisgICAgZ19h
c3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBIRUxQRVIod2FpdCkoQ1BVSGV4YWdvblN0
YXRlICplbnYsIHRhcmdldF91bG9uZyBQQykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworfQorCit2b2lkIEhFTFBFUihyZXN1bWUpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJf
dCBtYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKIHVpbnQzMl90IEhF
TFBFUihnZXRpbWFzaykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRpZCkKIHsKICAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwotLSAKMi4zNC4xCgo=

