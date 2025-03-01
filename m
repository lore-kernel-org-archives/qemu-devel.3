Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39730C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPh-0000qn-S8; Sat, 01 Mar 2025 00:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPg-0000lg-8n
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPe-0008Qb-06
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:23 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KdAP007765
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aEbO2N+96JBiF+lGMW1iJBT2PdRrbp/yZBpYAS9XHXM=; b=nsYjVyVj/bcld9e7
 HDCrn3/4JfRIDRfrfiylx3cGV8hpitHcd7ZXylvIin94ZXDVOI0nrMvkVKtpMkri
 qTVXwObpum0UD+1jBc8zfLlE1RO7KuSZoaFWK/EaVqR4Ivgh03e/2ND+z4N1bE3E
 GWkK0LERAj5iW78+KVBwUbLMybIfr2qVpZ9EgV3HvWOMJbV6vLkp5avO3NdZKPKv
 SOaDYQLmoiqj0tu8Vs3EeDnbwd7AVmUUZF2G+iqhP/iWqHLsmPngoTRN6z5ABfQW
 /s7cF8jl4ki3yQVe2HmKDTyqVIBRzwdsb94Z152C3XO7dPXK5W7WHoRhtHqfAzo3
 uirAbw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88r6cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2234bf13b47so53077335ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806959; x=1741411759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEbO2N+96JBiF+lGMW1iJBT2PdRrbp/yZBpYAS9XHXM=;
 b=GxQmjQ1dyyjk4106nBCwnf01NUbkp2zRhMXmqb/7o9ORsyh3gVfZ9lNdrw0Q3B83sC
 58WOLD4Ft3gGDqds24I39QlpjpvTutasKmreRJ1ZG36xFUiu7uCB9UFvNZwX/o3BrNu/
 A/5A17HPBijoc6VzmFftkU0YfzTWUb8CO8cXlZErBVwhANC7V+ooZ+mo6vMw5iRIoSka
 xclw/nAxd3/IOoUhXmOsFZibtHvVqpCI8KFXq7YypWC7gAoZrzKOhrc/n2abuFRP7Wlb
 bLolf90MyNh/yLWfUYN7NsJEMhc8Ynr8p2edw2m0+6KOmZedas8HrBPt+7uxWvEf082g
 VaUw==
X-Gm-Message-State: AOJu0YxSVyUEYNMXHyZKR9Lt2SJ0tiNr7AR7eTU7gxVFPAXwfPHH8DPv
 IaB2Lf/kBZ5tYSdKAWtUkjvCsEqw2JuDKKmRib/yKc9nid1co09ZHvNxfXftGIwgv/UY8zAp1Be
 B+c9lG6sCuRu7mqswQ0OtoMDU5YhuXtjRrYk4V6cPbUTu2JCpMsFZXBaMOOVL9Q==
X-Gm-Gg: ASbGncsfU54m1Bv+fIBNYb6cxhbAg6YyBHR+557Ga8ISWR+BAdiVoKFdd08ZAEcD5oG
 gHBekI9mVhEGYSSqxyPW5bCF3EFqx100Oibzttr3Z/1LIGd3AV/T55CXe0IhqsrQvCbAEoL/hvR
 yylpaVPHIfxcEzeJ7wxlQ0vPT5d9vOKzVUh6GPO6uz4z/8ilMVUFlzOIRknT3EYeNfsIBgK3i1K
 TFRc9KARVupue+EEPJx0H8bfoRA7MmhkcXSSyoXLIButQBhrUm4zFrHwCbDneLo/AuPCtx6bAwE
 t1GS5SyJICgM7DYx5fwrCXXFCMxRXKYOd3Ln2Rtr8fF63GZ/74tzeKD7gzFclDr9
X-Received: by 2002:a17:902:ec82:b0:221:7b4a:4773 with SMTP id
 d9443c01a7336-22369244a5dmr81399985ad.51.1740806959527; 
 Fri, 28 Feb 2025 21:29:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA7S6Q7OXHX+VEOYWpDXwxRSdKc2CX6EyLrK0kP7dDJgi81kxd13AaQ+ytE94AIHmz4tshNQ==
X-Received: by 2002:a17:902:ec82:b0:221:7b4a:4773 with SMTP id
 d9443c01a7336-22369244a5dmr81399885ad.51.1740806959174; 
 Fri, 28 Feb 2025 21:29:19 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:18 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 23/39] target/hexagon: Add sysemu_ops,
 cpu_get_phys_page_debug()
Date: Fri, 28 Feb 2025 21:28:29 -0800
Message-Id: <20250301052845.1012069-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: rM8PLCMDZeds1ZjvhRUb9evyjKEq6Jwt
X-Proofpoint-GUID: rM8PLCMDZeds1ZjvhRUb9evyjKEq6Jwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010040
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LmMgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDI5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IGE1NDhkNTc1YTcuLjlmNGNmZDAzYzQgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC00
ODksNiArNDg5LDI0IEBAIHN0YXRpYyB2b2lkIGZpbmRfcWVtdV9zdWJwYWdlKHZhZGRyICphZGRy
LCBod2FkZHIgKnBoeXMsIGludCBwYWdlX3NpemUpCiAgICAgKnBoeXMgKz0gb2Zmc2V0OwogfQog
CitzdGF0aWMgaHdhZGRyIGhleGFnb25fY3B1X2dldF9waHlzX3BhZ2VfZGVidWcoQ1BVU3RhdGUg
KmNzLCB2YWRkciBhZGRyKQoreworICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihj
cyk7CisgICAgaHdhZGRyIHBoeXNfYWRkcjsKKyAgICBpbnQgcHJvdDsKKyAgICBpbnQgcGFnZV9z
aXplID0gMDsKKyAgICBpbnQzMl90IGV4Y3AgPSAwOworICAgIGludCBtbXVfaWR4ID0gTU1VX0tF
Uk5FTF9JRFg7CisKKyAgICBpZiAoZ2V0X3BoeXNpY2FsX2FkZHJlc3MoZW52LCAmcGh5c19hZGRy
LCAmcHJvdCwgJnBhZ2Vfc2l6ZSwgJmV4Y3AsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGFkZHIsIDAsIG1tdV9pZHgpKSB7CisgICAgICAgIGZpbmRfcWVtdV9zdWJwYWdlKCZhZGRyLCAm
cGh5c19hZGRyLCBwYWdlX3NpemUpOworICAgICAgICByZXR1cm4gcGh5c19hZGRyOworICAgIH0K
KworICAgIHJldHVybiAtMTsKK30KKwogCiAjZGVmaW5lIElOVkFMSURfQkFEVkEgMHhiYWRhYmFk
YQogCkBAIC01OTUsNiArNjEzLDEyIEBAIHN0YXRpYyBib29sIGhleGFnb25fdGxiX2ZpbGwoQ1BV
U3RhdGUgKmNzLCB2YWRkciBhZGRyZXNzLCBpbnQgc2l6ZSwKIH0KIAogCisjaW5jbHVkZSAiaHcv
Y29yZS9zeXNlbXUtY3B1LW9wcy5oIgorCitzdGF0aWMgY29uc3Qgc3RydWN0IFN5c2VtdUNQVU9w
cyBoZXhhZ29uX3N5c2VtdV9vcHMgPSB7CisgICAgLmdldF9waHlzX3BhZ2VfZGVidWcgPSBoZXhh
Z29uX2NwdV9nZXRfcGh5c19wYWdlX2RlYnVnLAorfTsKKwogc3RhdGljIGJvb2wgaGV4YWdvbl9j
cHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJydXB0X3JlcXVlc3QpCiB7
CiAgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKQEAgLTYyNCw2ICs2NDgs
OCBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29wcyA9IHsKICNpZiAhZGVm
aW5lZChDT05GSUdfVVNFUl9PTkxZKQogICAgIC5jcHVfZXhlY19pbnRlcnJ1cHQgPSBoZXhhZ29u
X2NwdV9leGVjX2ludGVycnVwdCwKICAgICAudGxiX2ZpbGwgPSBoZXhhZ29uX3RsYl9maWxsLAor
ICAgIC5jcHVfZXhlY19oYWx0ID0gaGV4YWdvbl9jcHVfaGFzX3dvcmssCisgICAgLmRvX2ludGVy
cnVwdCA9IGhleGFnb25fY3B1X2RvX2ludGVycnVwdCwKICNlbmRpZiAvKiAhQ09ORklHX1VTRVJf
T05MWSAqLwogfTsKIApAQCAtNjUzLDkgKzY3OSwxMiBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2Nw
dV9jbGFzc19pbml0KE9iamVjdENsYXNzICpjLCB2b2lkICpkYXRhKQogICAgIGNjLT5nZGJfY29y
ZV94bWxfZmlsZSA9ICJoZXhhZ29uLWNvcmUueG1sIjsKICAgICBjYy0+ZGlzYXNfc2V0X2luZm8g
PSBoZXhhZ29uX2NwdV9kaXNhc19zZXRfaW5mbzsKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQor
ICAgIGNjLT5zeXNlbXVfb3BzID0gJmhleGFnb25fc3lzZW11X29wczsKICAgICBkYy0+dm1zZCA9
ICZ2bXN0YXRlX2hleGFnb25fY3B1OwogI2VuZGlmCisjaWZkZWYgQ09ORklHX1RDRwogICAgIGNj
LT50Y2dfb3BzID0gJmhleGFnb25fdGNnX29wczsKKyNlbmRpZgogfQogCiAjaWZuZGVmIENPTkZJ
R19VU0VSX09OTFkKLS0gCjIuMzQuMQoK

