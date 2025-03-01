Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973ADC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQF-00044b-1W; Sat, 01 Mar 2025 00:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFQA-0003VI-PD
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:54 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFQ8-0008Vn-7s
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:54 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214eiN1031822
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +2Uu93RgWR6oL6wb6Fda56k1MooPgz2Lg2tWOd7viHI=; b=Q2uIPxKMOBGjTnkS
 vKxs3lzXX6DTVgjTeYnz8xUieSG/C8B/86TdJkJwqnOvCRcNzs+oUbgBQ5auE9IA
 ihugb3PxKBau3r2MPzxy5D5YI/FlsD7g1ySV85F1sQl7IuyV7kNlhepXgQuTShL9
 7o2NKxPp4qq+Ex8pQnmOb/G+/yW2Ljrn09i9/rpuU7ebJcnssJZ8Ln1P+kwZuSg8
 +vBRg4Tl/ZcuFO745IsZWQMhCdVWPMLUwMH05cKNCF2u64XxFhau6e/fJc+9DjGR
 3iMOJmdL3/rKz/bBEDB8xt7NbJUXTJoJHLv+sSBRLis70/Ld8ub11SdYFy901JoG
 BiOkhw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453udgr2ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-223725a1e76so20314255ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806980; x=1741411780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2Uu93RgWR6oL6wb6Fda56k1MooPgz2Lg2tWOd7viHI=;
 b=Ju7aZd5Vt+vxEClJp2miLZ/KFNYS8n/6G2YKyVe/bIB29gdo8HD9G4yWAa9Zi8i0xh
 lx16z3CQ+fI6e5U7FfXW4kmisDgHh64blXDiGdPVGa9FBPj0CV7ItoNTeW9S05oNNuQK
 EHcpQL/S5A8hXXQr/rBBJCl5K9y147bQLcucucCkz/str2nojWmtqpzikafMEWWLZZ5q
 1K+0ioB4GLZjoGKyZXgpPf2vwlfxfGylDYRWIQCKD8c6Itgdr5uuv5gsWZUUip/20hBY
 8uCWjBiWE9tnMBrkyMv3wkwoVbpANkgqvQ/u9D1tJaonD/95+PnMYMF8QZ5l2YnPOou6
 9cPQ==
X-Gm-Message-State: AOJu0YxebEcng0duarUFCTSgqAU90aoYbMvE/XoCOFQMzfmX9GKe0+eu
 xFVtNTn/f+XCc23YNPfCg7Gl13nFqd2pySh6JyT7I/13nKTGpJkSaqOoorj3/McSD7sjUevMjjj
 1XEwvzQc185r3SRfb6Nc7s5jhCHQ0YWDgo4X3iaJo6xktGnMAiFMzbz8VHPzvgw==
X-Gm-Gg: ASbGnctSgkCIZw4/2XWwcTtLdkqYOWZawzG6tM8K7briI12gdOeJYTk/61uM8qR6+gs
 q0uxrbL+e2YYxzKL+xuEZDdAZqw1UWlxuMxFp3H5iT5Uo11vERyp7z0VQA/FYWlWlAoEx7zecXX
 +vamjopJsKwHbHW7E1dns2AhSwwdpcSqYdWYLOnmnFfsMCdWAMUBQaLuYW3trP4I4QgOj7yvSQb
 dkX9lOBdDWmAtL/joxAFSGn1tjXw+yoS3a7rQX106Y/Y53b/SCHtq4z1RyAg6aKMwzNz4XR0zYQ
 IGdsanfaFHDv1obcZY8hcRem6sSjf/ru6tXVKv+MDZ1cm5+DgoLXBsS7rBFCeWAP
X-Received: by 2002:a17:902:ef45:b0:223:653e:eb06 with SMTP id
 d9443c01a7336-223690e1497mr114207635ad.26.1740806979839; 
 Fri, 28 Feb 2025 21:29:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPa/IsZnnGAKvKU5ODffoAPuI3rOMGxJeW/K21ii4Y7w+TdZsQSl9/E+IBCdfBuOYFhCzFpw==
X-Received: by 2002:a17:902:ef45:b0:223:653e:eb06 with SMTP id
 d9443c01a7336-223690e1497mr114207225ad.26.1740806979376; 
 Fri, 28 Feb 2025 21:29:39 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:38 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH 38/39] target/hexagon: Add guest reg reading functionality
Date: Fri, 28 Feb 2025 21:28:44 -0800
Message-Id: <20250301052845.1012069-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: b_0N1umVmUVA-nfgdsqczqDNpl3KdS4f
X-Proofpoint-ORIG-GUID: b_0N1umVmUVA-nfgdsqczqDNpl3KdS4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRo
YmVybkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICB8IDE5ICsr
KysrKysrKysrKysrKysrKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTkgKysrKysr
KysrKysrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmMKaW5kZXggM2M0Nzc2MjMyZS4uODBmNWUyMzc5NCAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTczOSw3ICs3Mzks
MjQgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywg
dm9pZCAqZGF0YSkKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogdWludDMyX3QgaGV4YWdvbl9n
cmVnX3JlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKIHsKLSAgICBnX2Fz
c2VydF9ub3RfcmVhY2hlZCgpOworICAgIHRhcmdldF91bG9uZyBzc3IgPSBhcmNoX2dldF9zeXN0
ZW1fcmVnKGVudiwgSEVYX1NSRUdfU1NSKTsKKyAgICBpbnQgc3NyX2NlID0gR0VUX1NTUl9GSUVM
RChTU1JfQ0UsIHNzcik7CisKKyAgICBpZiAocmVnIDw9IEhFWF9HUkVHX0czKSB7CisgICAgICAg
IHJldHVybiBlbnYtPmdyZWdbcmVnXTsKKyAgICB9CisgICAgc3dpdGNoIChyZWcpIHsKKyAgICBj
YXNlIEhFWF9HUkVHX0dQQ1lDTEVMTzoKKyAgICAgICAgcmV0dXJuIHNzcl9jZSA/IGhleGFnb25f
Z2V0X3N5c19wY3ljbGVfY291bnRfbG93KGVudikgOiAwOworCisgICAgY2FzZSBIRVhfR1JFR19H
UENZQ0xFSEk6CisgICAgICAgIHJldHVybiBzc3JfY2UgPyBoZXhhZ29uX2dldF9zeXNfcGN5Y2xl
X2NvdW50X2hpZ2goZW52KSA6IDA7CisKKyAgICBkZWZhdWx0OgorICAgICAgICBxZW11X2xvZ19t
YXNrKExPR19VTklNUCwgInJlYWRpbmcgZ3JlZyAlIiBQUklkMzIKKyAgICAgICAgICAgICAgICAi
IG5vdCB5ZXQgc3VwcG9ydGVkLlxuIiwgcmVnKTsKKyAgICAgICAgcmV0dXJuIDA7CisgICAgfQog
fQogI2VuZGlmCiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggM2JkNGUyYTg3Mi4uMjhiNTU1ZTg3MyAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMKQEAgLTE4NzcsMTMgKzE4NzcsMjggQEAgdWludDY0X3QgSEVMUEVSKHNyZWdf
cmVhZF9wYWlyKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQogfQogCiB1aW50
MzJfdCBIRUxQRVIoZ3JlZ19yZWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVn
KQorCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICByZXR1cm4gaGV4YWdvbl9n
cmVnX3JlYWQoZW52LCByZWcpOwogfQogCiB1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIp
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCisKIHsKLSAgICBnX2Fzc2VydF9u
b3RfcmVhY2hlZCgpOworICAgIGlmIChyZWcgPT0gSEVYX0dSRUdfRzAgfHwgcmVnID09IEhFWF9H
UkVHX0cyKSB7CisgICAgICAgIHJldHVybiAodWludDY0X3QpKGVudi0+Z3JlZ1tyZWddKSB8Cisg
ICAgICAgICAgICAgICAoKCh1aW50NjRfdCkoZW52LT5ncmVnW3JlZyArIDFdKSkgPDwgMzIpOwor
ICAgIH0KKyAgICBzd2l0Y2ggKHJlZykgeworICAgIGNhc2UgSEVYX0dSRUdfR1BDWUNMRUxPOiB7
CisgICAgICAgIHRhcmdldF91bG9uZyBzc3IgPSBhcmNoX2dldF9zeXN0ZW1fcmVnKGVudiwgSEVY
X1NSRUdfU1NSKTsKKyAgICAgICAgaW50IHNzcl9jZSA9IEdFVF9TU1JfRklFTEQoU1NSX0NFLCBz
c3IpOworICAgICAgICByZXR1cm4gc3NyX2NlID8gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3Vu
dChlbnYpIDogMDsKKyAgICB9CisgICAgZGVmYXVsdDoKKyAgICAgICAgcmV0dXJuICh1aW50NjRf
dCloZXhhZ29uX2dyZWdfcmVhZChlbnYsIHJlZykgfAorICAgICAgICAgICAgICAgKCh1aW50NjRf
dCkoaGV4YWdvbl9ncmVnX3JlYWQoZW52LCByZWcgKyAxKSkgPDwgMzIpOworICAgIH0KIH0KIAog
dm9pZCBIRUxQRVIoc2V0cHJpbykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRocmVh
ZCwgdWludDMyX3QgcHJpbykKLS0gCjIuMzQuMQoK

