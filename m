Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173F7C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFOJ-0004Jb-Pn; Sat, 01 Mar 2025 00:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOE-0003pD-7x
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:54 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOC-0008BS-I8
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:53 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KJnS027528
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fpppYVbnnpdwoeHiW2JEmeIafyPaEomWXFw+JeKRawA=; b=OhcWGMWwDY+F34m/
 hKbala7WPNrNFBvwymvzqmzp9feH7eOr88FmVEdVTbLgNdUGp0BfcXwXVV72467R
 R+xwq7FkiA2QX1JPyL8DTYHPVR8hUJJTOFXj4rQGXNvIVSOEMAKQnpdeCgtSyncD
 TxIL0ldk4utSIJhFvbaJl8RR7kncO7aIGx0xX8XCoQ6eJewN+CD85NJ8hLQcTQ33
 21jxn/nrqJmN3+Tr6v+sifYu7G/eKjlJaFbEaB7dOUX08s9SjLlp3wmfxnGDoXso
 A4FiyUKkxBWfWeLqbvXk+n7R4Gc5DFdBYDYh99uB4P0l9jB2IVyQda/0JbLhNG7e
 jHuzZQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t89r657-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fe8c697ec3so6192248a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806854; x=1741411654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fpppYVbnnpdwoeHiW2JEmeIafyPaEomWXFw+JeKRawA=;
 b=ijcKFXOslR49nKOqNFOsKpg5tT+He1/SH1IQklbZ4G9e/kgGqpg9XIylRC86q+NABL
 HbknRWmwMZxYXilQmCqH2t2iMusQ/Re6hJ0kkN6EaD3NOYasnoeqE1OeWG18Fj8nFtrC
 7LbY4D65rXCK6F1EE7UrgzeBN4u0gWBXMRMmONmXJXgn8qwnRmECXi21PauhODsCYj9y
 qLYnsQOrk1v2leWJRuvkrJHKRs5fOjGplSfkESHhqTHjW65JJjNjFoUw7lLMO3EoF6/u
 SVv1D7UBI2nbHs2ufrtwct/ilQ5/NxoZFqlfaacHJO40BDDdYnja4TqCneNRmCuh1F3h
 XG3w==
X-Gm-Message-State: AOJu0Yx9gTYZksEb5b+1v6xyDw3IHQCyph/ZSuCLI8qJcVVN2ZQ2ZKsm
 9re0tP6MufIWQUO033qUHBVSK+bbMpe4I6adnKF1CSTZWrodxTHOMDIZechgozMHhMcyC565ppI
 9+rSq8V33V1Z8SWhnyPlimTktwhHCPlNGjCv7wNxYFHg5m5RC8l2CdZjYf5v6nQ==
X-Gm-Gg: ASbGncuKDS9VrPuVNwLgKEL4Wzhx3Y4B+oL6HWdIj4pQ53O3emgI6B/lVo0VHjYm0s8
 HCiWtRGvG+FlBZHW5giX6dupBau+fulbFey3E/66m05SRiHm0lrIlI0o7khf3CoaVi81WQB2Ej9
 zeyPvCP6M5Oo0Y8Es05ouKJxOWtcKv5memeG1/2o4cqEGLb4pcPbsyCFjAOY+9gYDD8vwEtg13s
 ken4gXRkS7E6I+UfypgSxCrU1/5oCp1Q6f/P6bQ6XMXkC0/71f0y+k+mwGTsdKmmlOvejzv2aoz
 +dfMhoRa3owCoTI49fXd4RS3rh6mohxG6valWdy80TwM16aozVBzJgSP8HDLLWUc
X-Received: by 2002:a17:90b:1ccd:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-2fea12907f5mr16487228a91.6.1740806854138; 
 Fri, 28 Feb 2025 21:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK5VfSCU6VRMtSGtGBrPxn24R0XTsBolB1M/GZyF9xrGN/k6x0oyoVADi7IQuyIU2Rug45Ig==
X-Received: by 2002:a17:90b:1ccd:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-2fea12907f5mr16487194a91.6.1740806853806; 
 Fri, 28 Feb 2025 21:27:33 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:33 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 35/38] target/hexagon: Add IRQ events
Date: Fri, 28 Feb 2025 21:26:25 -0800
Message-Id: <20250301052628.1011210-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: leSxZYShNviqk3ZDgsnUOE42_kGufQB0
X-Proofpoint-GUID: leSxZYShNviqk3ZDgsnUOE42_kGufQB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=999
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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
Y3B1X2JpdHMuaCB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Y3B1X2JpdHMuaCBiL3RhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmgKaW5kZXggNWQyNjgxNWViOS4u
YjU1OWE3YmE4OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaAorKysgYi90
YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oCkBAIC0yNiw2ICsyNiwyOCBAQAogZW51bSBoZXhfZXZl
bnQgewogICAgIEhFWF9FVkVOVF9OT05FICAgICAgICAgICA9IC0xLAogICAgIEhFWF9FVkVOVF9U
UkFQMCAgICAgICAgICA9ICAweDAwOCwKKyAgICBIRVhfRVZFTlRfRkVUQ0hfTk9fVVBBR0UgPSAg
MHgwMTIsCisgICAgSEVYX0VWRU5UX0lOVkFMSURfUEFDS0VUID0gIDB4MDE1LAorICAgIEhFWF9F
VkVOVF9JTlZBTElEX09QQ09ERSA9ICAweDAxNSwKKyAgICBIRVhfRVZFTlRfUENfTk9UX0FMSUdO
RUQgPSAgMHgwMWUsCisgICAgSEVYX0VWRU5UX1BSSVZfTk9fVVJFQUQgID0gIDB4MDI0LAorICAg
IEhFWF9FVkVOVF9QUklWX05PX1VXUklURSA9ICAweDAyNSwKKyAgICBIRVhfRVZFTlRfSU5UMCA9
IDB4MTAsCisgICAgSEVYX0VWRU5UX0lOVDEgPSAweDExLAorICAgIEhFWF9FVkVOVF9JTlQyID0g
MHgxMiwKKyAgICBIRVhfRVZFTlRfSU5UMyA9IDB4MTMsCisgICAgSEVYX0VWRU5UX0lOVDQgPSAw
eDE0LAorICAgIEhFWF9FVkVOVF9JTlQ1ID0gMHgxNSwKKyAgICBIRVhfRVZFTlRfSU5UNiA9IDB4
MTYsCisgICAgSEVYX0VWRU5UX0lOVDcgPSAweDE3LAorICAgIEhFWF9FVkVOVF9JTlQ4ID0gMHgx
OCwKKyAgICBIRVhfRVZFTlRfSU5UOSA9IDB4MTksCisgICAgSEVYX0VWRU5UX0lOVEEgPSAweDFh
LAorICAgIEhFWF9FVkVOVF9JTlRCID0gMHgxYiwKKyAgICBIRVhfRVZFTlRfSU5UQyA9IDB4MWMs
CisgICAgSEVYX0VWRU5UX0lOVEQgPSAweDFkLAorICAgIEhFWF9FVkVOVF9JTlRFID0gMHgxZSwK
KyAgICBIRVhfRVZFTlRfSU5URiA9IDB4MWYsCiB9OwogCiBlbnVtIGhleF9jYXVzZSB7CkBAIC0z
OSw2ICs2MSwxOCBAQCBlbnVtIGhleF9jYXVzZSB7CiAgICAgSEVYX0NBVVNFX1BSSVZfTk9fVVdS
SVRFID0gIDB4MDI1LAogICAgIEhFWF9DQVVTRV9QUklWX1VTRVJfTk9fR0lOU04gPSAweDAxYSwK
ICAgICBIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX1NJTlNOID0gMHgwMWIsCisgICAgSEVYX0NBVVNF
X0lOVDAgPSAweDBjMCwKKyAgICBIRVhfQ0FVU0VfSU5UMSA9IDB4MGMxLAorICAgIEhFWF9DQVVT
RV9JTlQyID0gMHgwYzIsCisgICAgSEVYX0NBVVNFX0lOVDMgPSAweDBjMywKKyAgICBIRVhfQ0FV
U0VfSU5UNCA9IDB4MGM0LAorICAgIEhFWF9DQVVTRV9JTlQ1ID0gMHgwYzUsCisgICAgSEVYX0NB
VVNFX0lOVDYgPSAweDBjNiwKKyAgICBIRVhfQ0FVU0VfSU5UNyA9IDB4MGM3LAorICAgIEhFWF9D
QVVTRV9WSUMwID0gMHgwYzIsCisgICAgSEVYX0NBVVNFX1ZJQzEgPSAweDBjMywKKyAgICBIRVhf
Q0FVU0VfVklDMiA9IDB4MGM0LAorICAgIEhFWF9DQVVTRV9WSUMzID0gMHgwYzUsCiB9OwogCiBl
bnVtIGRhdGFfY2FjaGVfc3RhdGUgewotLSAKMi4zNC4xCgo=

