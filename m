Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F7CC282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQD-0003qb-AY; Sat, 01 Mar 2025 00:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPv-00025F-Dr
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPt-0008SB-Jg
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:39 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213wWQ9011120
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SkuWazXNHguEaUmQjW1R53o9qQ6kemRMVlsuPBslfNY=; b=hdBXSptjy/6ewChc
 y56fSzrxbehAiwSGin2Stdbox0u6mRJHVu1gfaKhERHHoP10X/fOkIN/d1OsUphF
 QF7g1ji6z4uM7iWuG8XaIxnJB/aQ4qYQMhm2uPWMdIHtWP1zXseFigSUfr7BIWA0
 QaKt47m8bLsiW219VVdNbB/xn9asi40E3i1rKviiM4O9SM6cAPQuNk6sGiwmWs66
 9Js53BNVFEQA8arKJTV3Rdso+jubEtv7DQ+TjFlDfvSJsiOC7Js/0DiTYhp8saMf
 OvkRVBbL+vMwOyiUjG8K4IRtpQ1AWNhM5OwD0DbrowV7wAbn2M1fCF2Ug2FwcIHl
 kQPpxQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k06j7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2234c09240fso52033665ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806965; x=1741411765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkuWazXNHguEaUmQjW1R53o9qQ6kemRMVlsuPBslfNY=;
 b=oU1rt+JTFzHJNvLADWMYPNDeZKgIhQYNHna2JVcfEpN7Snlde33fFEyZZrkRTOuCs2
 w2NmOMZHn40933Kg8S2B8vRffRdX1Qc+bkCsIQDjQlOVUpgos+ElvEclbwfE1CgRJdo3
 wtbFvE0HgbQKK7XH7QMH5YqG6s57FaQBje4/Idtz1NhEioUw65loYsyzn6rzahGGJ1qo
 M59N6PpLbrypAK38e5K89E0Zeu5Z2vsK+tD9Xn6A+js3TPj91It/aa6l6aczVxfHpnnw
 ph82AQdTQrsNH9jCbQHCUs1zTRjGet09ZcJkLl986gNMZJRNTOaY2V6cyFaALLtkLCDh
 tlgw==
X-Gm-Message-State: AOJu0YyobVJKeAkvTr3ThNzV9JBcF2azT3Uw9Q6JdzEm7PT7Q64deWcP
 NWEC0MddgOtxERPvUsTS8S9yHfypFWNNhrA1w/g5TXE6tELaAr0dPVa0KYNAOdze1mfrbjPZZ10
 ZHKpwQGjOmFsK7OF/hm4osw1bab0fiGYvg7+uWOk+mzEGgH4i6//aolovigsYDw==
X-Gm-Gg: ASbGncvzyyJe8NpHDUV2n4ylgOhXd+hj5Dh9vqpt5O5lnACI3i80CmUxyyeeX761+/W
 8tkNZVvKMBM8VV0O0akOqOcnyS6wTv32i/s7nskHSPTNUGgJP9+j1i61+ADM78vEwQ5hZ9HrqWN
 OMqaZ2wXwjhNtoyHvJU5ls5py0wyUcFjX5Uhc8NaYwJJ85USnWKT86k3Wq8v68qyygbi6Fnahb7
 mJa/fAbHh/FRsfgo9NUkZLxBTOUdwMCxOwk6ip2QxLQOp/ZG/RshppjmuZMfrSSMCRIDJwMzfzZ
 RWHiISM4lLUp+4T6Cfuex8RrEr3CEc7pskHCWC7tFhyYL0iNA8kY7SqeGvBMcg11
X-Received: by 2002:a17:903:32c8:b0:223:4a10:311b with SMTP id
 d9443c01a7336-22368f6cff6mr101792125ad.1.1740806965141; 
 Fri, 28 Feb 2025 21:29:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR0uhoft/sXJjVvjA8zhMlBeeLm3f9bDfON3RfR0a83TsIJOm3i4uX0i85gh8e0VjWwUKAmw==
X-Received: by 2002:a17:903:32c8:b0:223:4a10:311b with SMTP id
 d9443c01a7336-22368f6cff6mr101791845ad.1.1740806964788; 
 Fri, 28 Feb 2025 21:29:24 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:24 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 27/39] target/hexagon: Implement hexagon_find_last_irq()
Date: Fri, 28 Feb 2025 21:28:33 -0800
Message-Id: <20250301052845.1012069-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: kdsyJFfpL6K0tBWY7cdMkzVzA5_5x8JS
X-Proofpoint-ORIG-GUID: kdsyJFfpL6K0tBWY7cdMkzVzA5_5x8JS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=577 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCA4ICsrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
Yi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBkMGRjNGFmYWM3Li5mM2ZmYWM4MWI2
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTYzNyw3ICsxNjM3LDEzIEBAIHN0YXRpYyB2b2lkIG1vZGlm
eV9zeXNjZmcoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHZhbCkKIAogc3RhdGljIHVp
bnQzMl90IGhleGFnb25fZmluZF9sYXN0X2lycShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgdmlkKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgaW50IG9mZnNldCA9
ICh2aWQgPT0gIEhFWF9TUkVHX1ZJRCkgPyBMMlZJQ19WSURfMCA6IEwyVklDX1ZJRF8xOworICAg
IENQVVN0YXRlICpjcyA9IGVudl9jcHUoZW52KTsKKyAgICBIZXhhZ29uQ1BVICpjcHUgPSBIRVhB
R09OX0NQVShjcyk7CisgICAgY29uc3QgaHdhZGRyIHBlbmRfbWVtID0gY3B1LT5sMnZpY19iYXNl
X2FkZHIgKyBvZmZzZXQ7CisgICAgdWludDMyX3QgaXJxOworICAgIGNwdV9waHlzaWNhbF9tZW1v
cnlfcmVhZChwZW5kX21lbSwgJmlycSwgc2l6ZW9mKGlycSkpOworICAgIHJldHVybiBpcnE7CiB9
CiAKIHN0YXRpYyB2b2lkIGhleGFnb25fcmVhZF90aW1lcihDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgKmxvdywKLS0gCjIuMzQuMQoK

