Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04280C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFOD-0003nP-I1; Sat, 01 Mar 2025 00:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOB-0003jC-E7
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:51 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFO9-0008BM-Oi
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:51 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213Pbhm006167
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jw41iskm0epqfRNOR1a67zncz3QB79UDAs1TKoJf0Ds=; b=LzyHLy6utYS3kxdX
 Xp8wvC+z3obef6OMW2Ufn9+xCOuIEOZVS3ppWjZIqNjokEtNnCrzp09oHwTBRsqF
 LxZvldANcXSYsl0NIa+xm8EFdrYyJYql86LMTkqAuPEo20isF68R86As68fW8nlp
 dioAmVDx049wdriroTVbGNebrb4iaEhUkZsSpe2RnBFQ7rxQ7f7kbeUkGgRDhoow
 Haq30d0OatTx17W9f41GWsgk0rdM83s9K4VU+FgzVjHa0ZFNxWIDYX7Y0uL1jMNt
 5LvG0Nd2PAMi0Z58w58Cpth7BhjC2dnITaJ6BmlnpgREOszayF2epUPQT7kf4pQF
 rs156w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tas85qy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fe86c01f5cso5847661a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806855; x=1741411655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jw41iskm0epqfRNOR1a67zncz3QB79UDAs1TKoJf0Ds=;
 b=a6SPSs5cU4ZQks/39qkCBIeG8tDnO/pIURMfgr3SOTYbSk1QVc2mdHlciwCGXS5Yki
 Vrs2A/km2cutkgByFusU97/e78q8jEYocdLrDMbf53v+ThA/AjbgSc3muxOMq+rMjuCx
 i+o7xTluTll9alRUtKHsc8uuTkgH4hCCl9H/JC/U9E8T+1wSUDNyS9Z3dGfzn/ZiUJvR
 PVyKYYC2oqnD6QDB7tjo8D9fXiAtFdvE5OjLv+Oy7+p8RAwdLWkb+AE/Z7pJLUEtXYa5
 XbbXTSiFw+qZOVZDaE+3HvRZsd9G/Z1dQH0S+4BxTIc2ufPNo1I0mJx29lU4DCtGvfZh
 g6ig==
X-Gm-Message-State: AOJu0YxuS4cOI3zPX3qBSQhOgd/VTc1gdNvYwbpYNYjlziVS2eXhRzgR
 R9vx83v2BPO9sGIqHKpUq+Q6Y0zDiHdn53kyASpqP5DOe+q0EvB4cCpVJkDpph/JFNEXsT3URTE
 ToSditkOe2hAKkYaWWJAMTgi/D8G6mlc/RnZdmIv/SjS/YbMXl1X5U1JUuz/xcg==
X-Gm-Gg: ASbGnct4xqNajzWm2FjlvsJR5un4suHbeTsXZR40DKzaN1fCMxXm6u2J2T/GH0xFy2x
 vJ4FPP/BXOAj7RylYELhxjA2Qe74r9lerSoDn4/WAruJ35aIIBks8OK3upsd4WQQxaqM9VcDDxC
 v52wiRV+yIWEBXR9e/v1sKGz6J2p95yzcss8fuqTNFcWDEZBagvOo4Voa8nQK5YdM/WEJtPsqQT
 +lstGkOUR1Vd2n281mE2jb4vf98+Ten+/M34/7VyuxP2npAirzOWOHaWFkt6/nswUV451OokV7B
 DmtYehpfYtkFotqo+gsQaDQYCSDG8MOYR+v/mNgGhgJNb0n7UQ9ZfySRaz1QzQt0
X-Received: by 2002:a17:90b:1fc6:b0:2f4:434d:c7f0 with SMTP id
 98e67ed59e1d1-2febab57061mr12152916a91.12.1740806855330; 
 Fri, 28 Feb 2025 21:27:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRqO+wem14xqGYFGgDbD0bQo+pwrJdDK2/GpAWtfLC/pXADC2T7lMXRnADqlwFr4IpJabuYw==
X-Received: by 2002:a17:90b:1fc6:b0:2f4:434d:c7f0 with SMTP id
 98e67ed59e1d1-2febab57061mr12152888a91.12.1740806855009; 
 Fri, 28 Feb 2025 21:27:35 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:34 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 36/38] target/hexagon: Add clear_wait_mode() definition
Date: Fri, 28 Feb 2025 21:26:26 -0800
Message-Id: <20250301052628.1011210-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: JrEouTVvnOcuCV6AmwJukZJUXQq0C5FL
X-Proofpoint-ORIG-GUID: JrEouTVvnOcuCV6AmwJukZJUXQq0C5FL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=806 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
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
Y3B1X2hlbHBlci5oIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgMTAgKysr
KysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5o
CmluZGV4IGUwYzBjMDM3YTYuLjZmMGM2Njk3YWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2NwdV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKQEAgLTE2LDYg
KzE2LDcgQEAgdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50X2xvdyhDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdWludDMyX3QpOwogdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50
X2hpZ2goQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90KTsKIHZvaWQgaGV4YWdvbl9tb2Rp
Znlfc3NyKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBuZXcsIHVpbnQzMl90IG9sZCk7
CiBpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQgY2xlYXJfd2Fp
dF9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIAogc3RhdGljIGlubGluZSB2b2lkIGFyY2hf
c2V0X3RocmVhZF9yZWcoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZywKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHZhbCkKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxw
ZXIuYwppbmRleCA5ZjRmYzcxNmUzLi45MzczZTQ5MWQ2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCkBAIC03
NCw2ICs3NCwxNiBAQCB2b2lkIGhleGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsKIH0KIAordm9pZCBjbGVhcl93YWl0X21vZGUoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7Cisg
ICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKworICAgIGNvbnN0IHVpbnQzMl90IG1vZGVjdGwg
PSBhcmNoX2dldF9zeXN0ZW1fcmVnKGVudiwgSEVYX1NSRUdfTU9ERUNUTCk7CisgICAgdWludDMy
X3QgdGhyZWFkX3dhaXRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX1csIG1vZGVjdGwpOworICAg
IHRocmVhZF93YWl0X21hc2sgJj0gfigweDEgPDwgZW52LT50aHJlYWRJZCk7CisgICAgU0VUX1NZ
U1RFTV9GSUVMRChlbnYsIEhFWF9TUkVHX01PREVDVEwsIE1PREVDVExfVywgdGhyZWFkX3dhaXRf
bWFzayk7Cit9CisKIGludCBnZXRfZXhlX21vZGUoQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7CiAg
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKLS0gCjIuMzQuMQoK

