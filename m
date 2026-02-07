Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFB5EE0AF4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 18:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vomi5-0001UP-OK; Sat, 07 Feb 2026 13:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vomhz-0001Tc-SU
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 13:07:04 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vomhr-0005Ks-DB
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 13:07:01 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6177bdeZ2117358
 for <qemu-devel@nongnu.org>; Sat, 7 Feb 2026 18:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=NVn6wQZKHhhaBQT7urUhsE
 97kqebj0QciCg1uyhQiKY=; b=MZtymcA9ZJT1jirUxKYV3q0m8sUNERbyq3i2tG
 EeG2YGjFH7HUWNuYscRDhOTmKoEHvkJN+az16webBPxVxyp1DWeErwE+Vhy2FL04
 hSje+UlNh/0l8+yPFKesuyeUKYXpZXBB6HkykfK90Qb0jGgvm2IKyr0XmoHEQL3m
 raocs/QAOAXx8fpyQvPtuNbCQgkNCRQqBJhvbN6uVn22KImGjSs7RZKkU+mwa630
 I2rgeZwc0iaF6vxIzK+K4MkO8/8PKoywuuHdwgWD29H+bS5uAiC5ujy4IDn7RdOc
 u3DZQaZQG+dvNIeiemu9JDIYhJocynRLOAJqIV1XG8eBFqtg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xbf93y0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 18:06:50 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-123349958b2so19708725c88.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 10:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770487610; x=1771092410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NVn6wQZKHhhaBQT7urUhsE97kqebj0QciCg1uyhQiKY=;
 b=Ba2mL7cRcTsqEKcGKJQ9FAKgF0ZYi0luVQj+J6VA3/R8NnB0npFYWjQRTiLOupKhbF
 8qBUuvJ333sVLZYibNolPSTpVWejbhhIt2nipcdX2IDGP/Mn6m5LUVSeZ/98RK+mD2J1
 1SlLo6ZiCgg0DogYFs/n3YtTtDOc1ftP0gNmUm+vNiQfAAD3Ec4clTMR492IKV3AnXmX
 KwvDMyTTWWvLl6ECfqhLZOlMY6MDAv5eJLVDyV9K9lCDalAhroaa2ymZFkc+vcq1s7Ce
 M/d+r87/Jz1RY/neCvA53Owxy7gl3GITaZjl9A9YoIWFboY1D5N6uItumqcYY5XrwKwF
 aehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770487610; x=1771092410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVn6wQZKHhhaBQT7urUhsE97kqebj0QciCg1uyhQiKY=;
 b=b16hBKFODO7rKipKVHm0AzAO0F6gL4pAq8XEc0gOnOjAtOyWpYCBm37Qba2TFGD2Oh
 0yqQKTEfM3zut4SETmhZkqbYiBXJPoW+o45vFE1r+M/qCsXz7sfF94fr+IOt2XxBLnMf
 lHVEsq05A7OtsbwBQaA5G9UtlMg8JGnMeQ24yC/Vil7mq6o/ZpOO+mj35eYLz4RqLaUS
 m4nbYYXo18lkG8ekhgTwAAiwXuWdIQdwkbqFicKXznLDNg4mXuxbBGC6OPjPb1i+TnQe
 n6vwi6vsqS9ctAUBIvhMAIQtf5Y6KJLmR6a/B1Z2Pv4Q1sAXQYITSAqqtUDkctSQllRV
 90Hw==
X-Gm-Message-State: AOJu0YwDfIFwNoK+AuWFuQDKwYWMXZTzav+Ec2ltjdDyCBf94nHu6Uau
 M0vs43pWKrcXGoEcB0W7edn7cK/cZaRlxwSMgEjdD84ULczTMqaDcZ4IaFVCGmC3XbOPXNKW5S4
 Wvis2q+GRBxk5poZbkGysbxJ1jPYSF2JfkygdQg2wAAYenwL1h6qMy87BOrg6bQdTqA==
X-Gm-Gg: AZuq6aK2PSj8wOaoOnXbKpS3nNilptdLmfIS/De/I1R01Abo8fAbzDWycT3cB+FBiRO
 thkW4eBVwZAaMJaxluuoMrdglfTFWMzVlN8XtHpbiX18WwJ7K8oYIKT5OP1GiCfFkhctV1joadq
 MyHkRjkGMWJG+m8mehJjqlch834rm7wFglCn7/KgY7aBzoIpemrjo4XZ4ztA1TYbytmZsX7Fn3R
 Wb4mYHsBoR38AKnuqZSISNt64l/OE4nMkmckHcbCfD4+TeRgZQ+Vn2E4pIVTZVZ0C6AcRqPU3gV
 5Por4JSAf60okVYiUYkLcVhrknR0YgdiuP/r3MCbTkDObJYIUX9zALip9utvP9xr9XHx7c70XwY
 HCQWxgWZfOmQixFm9BWFqJNeEMIvKnzk3ecWNavciP4g9LnJ7NCDiWjeBZPBNZu7HCcCOwA==
X-Received: by 2002:a05:7300:df01:b0:2ae:5d5b:4ed0 with SMTP id
 5a478bee46e88-2b85671dba1mr3325998eec.21.1770487609547; 
 Sat, 07 Feb 2026 10:06:49 -0800 (PST)
X-Received: by 2002:a05:7300:df01:b0:2ae:5d5b:4ed0 with SMTP id
 5a478bee46e88-2b85671dba1mr3325985eec.21.1770487608947; 
 Sat, 07 Feb 2026 10:06:48 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855c63152sm4002328eec.25.2026.02.07.10.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 10:06:48 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com
Subject: [PATCH v2 0/4] Handle some invalid encodings
Date: Sat,  7 Feb 2026 10:06:28 -0800
Message-Id: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: pPTkC25jjCOQODz8Kl7cgtUsf22f2lwo
X-Proofpoint-GUID: pPTkC25jjCOQODz8Kl7cgtUsf22f2lwo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDE0OSBTYWx0ZWRfX6Oejwpod0P8f
 Q39YtsB/IxpcoXsQBHm0RR79ubZ0yNL97hnu0UmH8NLAJGPsxmODodohRbNpMRnVNSmp42CH/R4
 4HrqzZj0wPihz/9307J5NdIS1clxnJhvGYq+nbw1C3j7ETUN/9XPgWGMDZrpyLbTIJSPg9/4zft
 4G2b8v+dwFyz+Z6GwP464xw5D99IXj+9+XRTASYHZieLLFK6W0KaHsUr3vZPZq+TEkVDGdPQcPD
 lNHE6R3wEqjUOcsBu8HVfxVxycenmmbHwa6ShFLRHwzWoHnD/3G3UYCJ+xufzqSdZCASVcNQWca
 vlnIyJpmuLKUar4XhTdXWxu0JnILrCw2+Siyo2Z0zXNQeyIesMCjozihI/oxDod0UKs+JrKIjL4
 MyRTl4kPPPf8XPbOL4n4aKYmvbj3EYJ58TCr3K1PJbY7plURyYjbIR7j3CKlVHaw9D+vDb663Oo
 84PfhTuB5QiwW0bHU8g==
X-Authority-Analysis: v=2.4 cv=aIb9aL9m c=1 sm=1 tr=0 ts=69877f3a cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=a6j-A4SwrRrYJy-fcMoA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602070149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Rml4IHRoZSBpc3N1ZXMgcmVwb3J0ZWQgYnkgQWxleCBSw7hubmUgUGV0ZXJzZW4gY2F1c2luZyB6
aWcgdGVzdCBzdWl0ZQpmYWlsdXJlcy4gIFRoZSAweDAgY2FzZSBpcyBhIGNvbmZsaWN0aW5nICJt
dWx0aXBsZSByZWdpc3RlciB3cml0ZSIgLSB0aGUKaGFuZGxlciBoZXJlIHdpbGwgY292ZXIgZHVw
bGV4ZXMgYnV0IG5vdCB0aGUgbW9yZSBnZW5lcmFsIGNhc2Ugb2YgbXVsdGlwbGUKcmVnaXN0ZXIg
d3JpdGVzLiAgSSdsbCBpbmNsdWRlIHRoYXQgaW4gYSBzdWJzZXF1ZW50IHBhdGNoc2V0LgoKdjI6
IHVzZSBhIHNpZ25hbCBoYW5kbGVyIGZvciBTSUdJTEwsIGNvbWJpbmUgdGhlIHRlc3RzLiAgUy1i
IFBpZXJyaWNrLgoKQnJpYW4gQ2FpbiAoNCk6CiAgdGFyZ2V0L2hleGFnb246IEZpeCBpbnZhbGlk
IGR1cGxleCBkZWNvZGluZwogIHRhcmdldC9oZXhhZ29uOiBSZWplY3QgZHVwbGV4IGVuY29kaW5n
cyB3aXRoIGR1cGxpY2F0ZSBkZXN0IHJlZ2lzdGVycwogIHRhcmdldC9oZXhhZ29uOiBSZXR1cm4g
ZGVjb2RlIGZhaWx1cmUgZm9yIGludmFsaWQgbm9uLWR1cGxleCBlbmNvZGluZ3MKICB0ZXN0cy90
Y2cvaGV4YWdvbjogSGFuZGxlIFNJR0lMTCBpbnRlcm5hbGx5IGluIGludmFsaWQtc2xvdHMgdGVz
dAoKIGxpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jICAgICAgICB8ICAgNCArCiB0YXJnZXQv
aGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAgfCAgMjggKysrKystCiB0YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyAgICAgICAgICAgfCAgMTggKysrLQogdGVzdHMvdGNnL2hleGFnb24vaW52
YWxpZC1lbmNvZGluZy5jIHwgMTM1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKwogdGVzdHMv
dGNnL2hleGFnb24vaW52YWxpZC1zbG90cy5jICAgIHwgIDc2ICsrKysrKysrKysrLS0tLQogdGVz
dHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0ICAgIHwgICA3ICstCiA2IGZpbGVzIGNoYW5n
ZWQsIDI0MCBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29kaW5nLmMKCi0tIAoyLjM0LjEKCg==

