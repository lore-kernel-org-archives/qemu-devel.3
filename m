Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C567C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPu-0001s0-1E; Sat, 01 Mar 2025 00:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPp-0001OR-HJ
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPm-0008Q6-Mt
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:33 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214oWeu023744
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=K4hMa9etYnht/UIt5MoNU1NjLmKvrQLpfqZopeYY0W4=; b=DP
 TbWYQU5ATFhMMS0Gf0oWb5xdYg6Eno7zAy0tn3mWHdMMDOOKNUWfoYE0PEGIZEV0
 O/Q4Yjbrzkh/MvxjNHcKauXz7dMJxKwjpB27Pmy8n+Lm391mr1qk/aRFQY8j9++X
 fnGXnFWmg0IEdzXAL4sIriLemiotOFfbg13pWyAox7WZjiygL7vpNY8lDdyvdHPY
 xLrZd1jOdQE2zIp7O6T2/03rLD97zaWdNTonn8vtGY26Z21A/zwBH7l+kF2n3DmB
 nJOsQiva9VFxag6+6Us4StC8Tf4/W8M0sC9I8QBsH6Yewe2TYlSIzPF6LY75/SQ+
 aZixw7UCY3GTSsiIzFZw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh701yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fe86c01f5cso5848780a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806958; x=1741411758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K4hMa9etYnht/UIt5MoNU1NjLmKvrQLpfqZopeYY0W4=;
 b=tocsL1kg9OAilvEQuflKvq/CSq5iB3U4WdfJ5t3xZYb3nxKkZfCKXI7e8bDW9CSdQw
 ienMSuFpwvMILA9J2fdutLPQlZYzIH8yuaWcebJGCiJtR4ZeKP5AdyT0lJ3PZv8T65R3
 J3h7Vud3pbEwx2SSg695oxtNQ0RfYHEU1z44KkB/BqStZOye1u9ZN7hflc496gf+QYT4
 OOrNlJ18fMr+9a9Vu/t8vKmDTmFeI7lsZb578E8tVOEHsuGc6X1EmHjjL7KsX6XSuRs9
 7rgsXYQPqubvv/gyVHrGNHAaCOqUOEBr3B7cgBSjYgHEe2YkexqxYDOp7aOkv327eZp4
 22Ww==
X-Gm-Message-State: AOJu0YzQrIKE+Ee3H9h3Oe7WN+Ltpj0pqvkclFHtFAa5Bm69e3VPwZqz
 KgRu2GOlOqmH+/gHjDFH0OfF5M/o2/7Spa+s+x7doCFRnPfiGA3HfPMLszUOWmyF5brbxZgZqaY
 TR4E/JumkZ+8Y8vo4c/izKkKm1mt15Oq907gJxD2lI4Qyl+hWYRE68ZoAyyTW1Q==
X-Gm-Gg: ASbGncsdK9ts3dB2kznH7BjBYrrEkg8ki0TYhQWVPL/PCoSc2F/7RXbsMeknEcvMP76
 l+0VBmPwfHy9INL8pkLrLfQ5MRtrRRAoKt2fKc2oW7lQIpY45mHXE01G1KbYTYqfAthRDiiDeT2
 uH01l+Bq1jIuKE78AW6WS2FpQO1avrY7I0VmFXeBVX4wjPEGBfLGpgvqXHkSV4of2/azZ11as6I
 7cO6YlgytyRTuYMuPWiEblMEoIRpYQxkphIUBRyf53F4O01mjnbdwlfuwsIJMeKbIWuaZuideew
 eCg2V1rs4j0+n/Hnq/PaWDrXeyKYl8cdnquTT0heWQEvEajGJ/9UjTYDUePZo79U
X-Received: by 2002:a17:90b:1b47:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-2febab2ebdamr10549891a91.2.1740806958306; 
 Fri, 28 Feb 2025 21:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNLxAis/j2X+4pyCuzBzG7hlqW9sd6LE4kWFZsOUDUHj5PTdCfYqinkxFSvwEHzru5BCk71w==
X-Received: by 2002:a17:90b:1b47:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-2febab2ebdamr10549865a91.2.1740806957931; 
 Fri, 28 Feb 2025 21:29:17 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:17 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 22/39] target/hexagon: Implement setprio, resched
Date: Fri, 28 Feb 2025 21:28:28 -0800
Message-Id: <20250301052845.1012069-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: bHxdBlCsVcJ_Rv6NkS_IAvo7hlBmmnJR
X-Proofpoint-ORIG-GUID: bHxdBlCsVcJ_Rv6NkS_IAvo7hlBmmnJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=689 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgaGFyZHdhcmUtYXNzaXN0
ZWQgc2NoZWR1bGVyIGhlbHBzIG1hbmFnZSB0YXNrcyBvbiB0aGUgcnVuIHF1ZXVlCmFuZCBpbnRl
cnJ1cHQgc3RlZXJpbmcuCgpUaGlzIGluc3RydWN0aW9uIGlzIGRlZmluZWQgaW4gdGhlIFF1YWxj
b21tIEhleGFnb24gVjcxIFByb2dyYW1tZXIncyBSZWZlcmVuY2UKTWFudWFsIC0KaHR0cHM6Ly9k
b2NzLnF1YWxjb21tLmNvbS9idW5kbGUvcHVibGljcmVzb3VyY2UvODAtTjIwNDAtNTFfUkVWX0FC
X0hleGFnb25fVjcxX1Byb2dyYW1tZXJTX1JlZmVyZW5jZV9NYW51YWwucGRmClNlZSDCpzExLjku
MiBTWVNURU0gTU9OSVRPUi4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDY1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNjUg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIv
dGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggMGRjZTEzM2QzYS4uZDBkYzRhZmFjNyAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKQEAgLTE0NjUsNiArMTQ2NSw1NyBAQCB2b2lkIEhFTFBFUihzdG9wKShD
UFVIZXhhZ29uU3RhdGUgKmVudikKICAgICBoZXhhZ29uX3N0b3BfdGhyZWFkKGVudik7CiB9CiAK
K3N0YXRpYyBpbmxpbmUgUUVNVV9BTFdBWVNfSU5MSU5FIHZvaWQgcmVzY2hlZChDUFVIZXhhZ29u
U3RhdGUgKmVudikKK3sKKyAgICB1aW50MzJfdCBzY2hlZGNmZzsKKyAgICB1aW50MzJfdCBzY2hl
ZGNmZ19lbjsKKyAgICBpbnQgaW50X251bWJlcjsKKyAgICBDUFVTdGF0ZSAqY3M7CisgICAgdWlu
dDMyX3QgbG93ZXN0X3RoX3ByaW8gPSAwOyAvKiAwIGlzIGhpZ2hlc3QgcHJpbyAqLworICAgIHVp
bnQzMl90IGJlc3R3YWl0X3JlZzsKKyAgICB1aW50MzJfdCBiZXN0X3ByaW87CisKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogY2hlY2sg
cmVzY2hlZFxuIiwgX19mdW5jX18pOworICAgIHNjaGVkY2ZnID0gYXJjaF9nZXRfc3lzdGVtX3Jl
ZyhlbnYsIEhFWF9TUkVHX1NDSEVEQ0ZHKTsKKyAgICBzY2hlZGNmZ19lbiA9IEdFVF9GSUVMRChT
Q0hFRENGR19FTiwgc2NoZWRjZmcpOworICAgIGludF9udW1iZXIgPSBHRVRfRklFTEQoU0NIRURD
RkdfSU5UTk8sIHNjaGVkY2ZnKTsKKworICAgIGlmICghc2NoZWRjZmdfZW4pIHsKKyAgICAgICAg
cmV0dXJuOworICAgIH0KKworICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIEhleGFnb25D
UFUgKnRocmVhZCA9IEhFWEFHT05fQ1BVKGNzKTsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICp0
aHJlYWRfZW52ID0gJih0aHJlYWQtPmVudik7CisgICAgICAgIHVpbnQzMl90IHRoX3ByaW8gPSBH
RVRfRklFTEQoCisgICAgICAgICAgICBTVElEX1BSSU8sIGFyY2hfZ2V0X3N5c3RlbV9yZWcodGhy
ZWFkX2VudiwgSEVYX1NSRUdfU1RJRCkpOworICAgICAgICBpZiAoIWhleGFnb25fdGhyZWFkX2lz
X2VuYWJsZWQodGhyZWFkX2VudikpIHsKKyAgICAgICAgICAgIGNvbnRpbnVlOworICAgICAgICB9
CisKKyAgICAgICAgbG93ZXN0X3RoX3ByaW8gPSAobG93ZXN0X3RoX3ByaW8gPiB0aF9wcmlvKQor
ICAgICAgICAgICAgPyBsb3dlc3RfdGhfcHJpbworICAgICAgICAgICAgOiB0aF9wcmlvOworICAg
IH0KKworICAgIGJlc3R3YWl0X3JlZyA9IGFyY2hfZ2V0X3N5c3RlbV9yZWcoZW52LCBIRVhfU1JF
R19CRVNUV0FJVCk7CisgICAgYmVzdF9wcmlvID0gR0VUX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIGJl
c3R3YWl0X3JlZyk7CisKKyAgICAvKgorICAgICAqIElmIHRoZSBsb3dlc3QgcHJpb3JpdHkgdGhy
ZWFkIGlzIGxvd2VyIHByaW9yaXR5IHRoYW4gdGhlCisgICAgICogdmFsdWUgaW4gdGhlIEJFU1RX
QUlUIHJlZ2lzdGVyLCB3ZSBtdXN0IHJhaXNlIHRoZSByZXNjaGVkdWxlCisgICAgICogaW50ZXJy
dXB0IG9uIHRoZSBsb3dlc3QgcHJpb3JpdHkgdGhyZWFkLgorICAgICAqLworICAgIGlmIChsb3dl
c3RfdGhfcHJpbyA+IGJlc3RfcHJpbykgeworICAgICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0df
SU5ULAorICAgICAgICAgICAgICAgICIlczogcmFpc2luZyByZXNjaGVkIGludCAlZCwgY3VyIFBD
IDB4IiBUQVJHRVRfRk1UX2x4ICJcbiIsCisgICAgICAgICAgICAgICAgX19mdW5jX18sIGludF9u
dW1iZXIsIGFyY2hfZ2V0X3RocmVhZF9yZWcoZW52LCBIRVhfUkVHX1BDKSk7CisgICAgICAgIFNF
VF9TWVNURU1fRklFTEQoZW52LCBIRVhfU1JFR19CRVNUV0FJVCwgQkVTVFdBSVRfUFJJTywgMHgx
ZmYpOworICAgICAgICBoZXhfcmFpc2VfaW50ZXJydXB0cyhlbnYsIDEgPDwgaW50X251bWJlciwg
Q1BVX0lOVEVSUlVQVF9TV0kpOworICAgIH0KK30KKwogdm9pZCBIRUxQRVIod2FpdCkoQ1BVSGV4
YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyBQQykKIHsKICAgICBCUUxfTE9DS19HVUFSRCgp
OwpAQCAtMTcxNSw2ICsxNzY2LDIwIEBAIHVpbnQ2NF90IEhFTFBFUihncmVnX3JlYWRfcGFpciko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKIAogdm9pZCBIRUxQRVIoc2V0cHJp
bykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRocmVhZCwgdWludDMyX3QgcHJpbykK
IHsKKyAgICBDUFVTdGF0ZSAqY3M7CisKKyAgICBCUUxfTE9DS19HVUFSRCgpOworICAgIENQVV9G
T1JFQUNIKGNzKSB7CisgICAgICAgIEhleGFnb25DUFUgKmZvdW5kX2NwdSA9IEhFWEFHT05fQ1BV
KGNzKTsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICpmb3VuZF9lbnYgPSAmZm91bmRfY3B1LT5l
bnY7CisgICAgICAgIGlmICh0aHJlYWQgPT0gZm91bmRfZW52LT50aHJlYWRJZCkgeworICAgICAg
ICAgICAgU0VUX1NZU1RFTV9GSUVMRChmb3VuZF9lbnYsIEhFWF9TUkVHX1NUSUQsIFNUSURfUFJJ
TywgcHJpbyk7CisgICAgICAgICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULCAiJXM6IHRp
ZCAlZCBwcmlvID0gMHgleFxuIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18s
IGZvdW5kX2Vudi0+dGhyZWFkSWQsIHByaW8pOworICAgICAgICAgICAgcmVzY2hlZChlbnYpOwor
ICAgICAgICAgICAgcmV0dXJuOworICAgICAgICB9CisgICAgfQogICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7CiB9CiAKLS0gCjIuMzQuMQoK

