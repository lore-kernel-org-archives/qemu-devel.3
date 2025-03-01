Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2D1C282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQD-0003qQ-9G; Sat, 01 Mar 2025 00:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFQ9-0003JI-7c
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:53 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFQ5-0008V9-Ks
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:52 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213NWhX027683
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RhF45BDDcsKwjvuyo2XiQ9b81apjy0CuFDQnbMbTwfM=; b=c4cVAEHqD0r+FV2q
 JvKCPNpFZW3ydUE1aSDllB3waJ4dIigByHi/FXYeZdkGKeaQT25EQsFvYRMtvfVh
 0lvXHkNk7NYErPytGW+tuYBXgX/Be3Qv4n5J3wH4rmYnRDiy8TTvTlctsHcQDHwr
 7LYOCVGpoJep06BuX0Kshise4Uc6cSlGv3qVl61ErV/XHwe/1DbGzl+3EU3jnNfB
 GLhnCjipvHHuaMsYf/WnsyK1kn9Abx3valPNXZQLENkiOHm7N8+cmanleABywk88
 Aq2EHEfF123pxOqUM4xCRUOUsX0xRKCFQPD5hpJxctAFhxpo+iZ+OK4f2ZMJ35rr
 RDs6qQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t9905sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fe916ba298so5763179a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806977; x=1741411777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RhF45BDDcsKwjvuyo2XiQ9b81apjy0CuFDQnbMbTwfM=;
 b=m0Xa4jMFyMkzgPk3spJ8xTWo4GEJZT7LCpgAJFDaHwZGXadpGJyUCycmyUgptypGZm
 lx1BhkSwu+4+Y1Aeze/t8eG/BNMzAUDtv6ydpHyZQ3zgVqNMOu/HYcPFgZj30pGIJ2KB
 6nd9hLPqfqKKc1Dse0h776NhVFvcyKz4zrs6p3q0aN6xNAjoR2nB8ASwCz/JBTWnCggp
 MQTvloiJaJXYED1854IWRIGSO9y1U7AiO5rLfdK7mzxzlkC2+34AX3LFf2E2+vB0Jcql
 hs1oRjuN0m3IrNax5ww89klejfY5X4v7iR7WQt+yc+ma6Kd+V31ZgDLWELYQF06AdOBP
 U/GQ==
X-Gm-Message-State: AOJu0Yy3CXk34P5F4kujh0Tv+AxYWTUcYrp76/rkVylOXRlRU8lb1TuW
 VqC85JQnpHQ/NYKUWTU/ljXJ4k2GOa7Wq5fIyuQ5BI4ek5G27V1YbrMVy6XJrnT2aaLMqPcBV3X
 qrdmK5aA50x4B426HtvIDjNMMqjZ7FrOz2pUxrHrpxyKFMom6Nt48UWRRmuIoXQ==
X-Gm-Gg: ASbGnctcrl8ai8vygBLV4HhTC86kfENhoIVU9YjTIyhNKaG0FtwR3f0CgDzWTTcDaLb
 CuL3YRCrh25nSMnl4Emac/lhr1GIQiba5vjbREeuQaShxxMp+Hzr2FYC5il/Jgd5YyhGhwUSrNR
 NPiLBbwtJK/y07JtSVfcHiyZpjtUt63mUoiPTD4Q7LQo2SsiGxJfs16/5f+bK2NN6rcG+/pvdug
 c9ky6UcHVHXTR7r5OvWp0eSj0WdDB+XD7Zep2Lq9DAMGWzT0UxdFWgwaTL/k1uYEcIE1dEl6nuo
 n5vWqhyZV0pFdXPCjYKHsXpibrXTqVkXJUjo3YKxRhg1CSlEDgof5uOQVZBPDzR9
X-Received: by 2002:a17:90b:1e44:b0:2ee:5edc:4b2 with SMTP id
 98e67ed59e1d1-2febab78d59mr10304774a91.20.1740806977105; 
 Fri, 28 Feb 2025 21:29:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6XvohxLjysGis56/138znIkTak748BqIdTHxJNjdxxV0YxnGROxAzPXnTDe/Y/kk0bKWlMg==
X-Received: by 2002:a17:90b:1e44:b0:2ee:5edc:4b2 with SMTP id
 98e67ed59e1d1-2febab78d59mr10304759a91.20.1740806976786; 
 Fri, 28 Feb 2025 21:29:36 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:36 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 36/39] target/hexagon: Add TCG overrides for transfer insts
Date: Fri, 28 Feb 2025 21:28:42 -0800
Message-Id: <20250301052845.1012069-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: eSEbXkvoWBtT4-dv6A0kIkv6wnjEtJ7_
X-Proofpoint-GUID: eSEbXkvoWBtT4-dv6A0kIkv6wnjEtJ7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=551
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Z2VuX3RjZ19zeXMuaCB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCAyNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Z19zeXMuaCBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKaW5kZXggNmQ3M2ExOGRiNC4u
ZTU2NTUzNDYyZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MSw2ICs4MSwzMSBAQAogICAgICAg
ICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxlICgwKQogCisjZGVmaW5l
IGZHRU5fVENHX1kyX3RmcnNjcnIoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfdGwoUmRW
LCBTc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfdGZyc3JjcihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChTZFYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZNF90ZnJzY3BwKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X2k2NChSZGRWLCBTc3NWKQorCisjZGVmaW5lIGZH
RU5fVENHX1k0X3RmcnNwY3AoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFNkZFYs
IFJzc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ2NycihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChSZFYsIEdzVikKKworI2RlZmluZSBmR0VOX1RDR19HNF90ZnJncmNyKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X3RsKEdkViwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX0c0X3RmcmdjcHAoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFJkZFYsIEdz
c1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ3BjcChTSE9SVENPREUpIFwKKyAgICB0Y2df
Z2VuX21vdl9pNjQoR2RkViwgUnNzVikKKworCiAvKgogICogcnRlIChyZXR1cm4gZnJvbSBleGNl
cHRpb24pCiAgKiAgICAgQ2xlYXIgdGhlIEVYIGJpdCBpbiBTU1IKLS0gCjIuMzQuMQoK

