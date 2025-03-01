Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E1AC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPQ-0008CH-1U; Sat, 01 Mar 2025 00:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPO-00088r-BF
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPM-0008Nx-Pf
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:06 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213MTlM026432
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TTGw28iruESNeRODIQhTUu056yp02YTfEP0NCHtOlZI=; b=iJY+f5e0TpDccfAF
 7rRRFQkibp3sx1cuyL2JP2gZWXZFFkEDoeTJPYrPL8vOUt4a71wh2wAjzVh898DL
 TNge47hLTfPp4VmIu6TKPr2Y2LKPE78x9so83Mj8tlo2V2tIeF4KgFYu0O6IsCYc
 c8syW5UHMAJLokqQCPdVKsHePigrDATkLjSVlqR0r5qtOGgxk/WIg8c94exFL/EE
 Fiu75rHsWBDuWMVTC/WNFDBBTJ1GgkWQNlN/xFsjiT9rIQ0Jrxg5i2gP7U/5Mvi9
 lGSWIlTwL4asjQbrg0SmBXdk2FK2HxVokNLunRmQJrBB4UxHdfKkIzvhAlJAj8t0
 5yf4SQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t9905q3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc404aaed5so9487338a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806942; x=1741411742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTGw28iruESNeRODIQhTUu056yp02YTfEP0NCHtOlZI=;
 b=xUcU/6UDzsFpEg7OQB0HS24hAs6UNUvjx18joSXmuBXSjSufjoQK826V2w2RifSxfR
 biW/1otFuVir4uZCBVlPeO8RZF/BZPPCIgDlMQbgBvV69ijVg8EPEaF3LaxXi0cd5KNJ
 4kN6vjJ1zw1adPnWEsM0Zon9Qa610UhAXWg/AfEUvaGCj5UP9oQQ98jaiG1jd8dER3RQ
 y2VdfLxZ9wmALuefAhi6BRRLLor5sZaxY2/KbEkXZQ7cW21ooGNqkU7G5xtIBRn6taPS
 S6GnMb0b3CqD8valVY3KCfvswuOCJOyHKOEElFHT9xZGSBtp3JPXSGzVS18Yn2eTfGtO
 XZdw==
X-Gm-Message-State: AOJu0YxNOtmQ00EMr4YiLkh2/GX1Q8ja3uaNAMJsEFXJ1JqnLLc6bFu6
 /DJQMZgzVWxJ/IYrb2lZhaRSCEECvXUEUPcU4/iulopO1+l+yN9v8/7GoecAeQ1KtgeBQxfm1/s
 RD1fRb5/5LBIvTKs+ZNzCwrGmNMSWh9e4csgt/di3OVg7HbAiPOJbpTRsx/UgqA==
X-Gm-Gg: ASbGncuiz+rS1ItBLB1xEpfiJX7ubqLHfBHdAehG42QGNYFy+3NPTWieOK/7LpXC1Qd
 wV8j33osXBH0qY/7aeN7h4wGYknqHdPTakfHJzTd6ndKDyUy776v1CPQVyiRtqFagdIKaqhKZtF
 DPtjnWoGRGrVaLL0wgMjZEf2glkuhJzRXJ19Onz4G/fsN2S4dBhz6jiDr18wFZswHAwR3qZfr3o
 8mO9kFXvyULTsbBIZj89P8epNclIIWMSl7xRoG7ipQz6LIcbm8tdxigQrDyRH6NcyZCg/Zn18bv
 5HlYInS9hi2vXJNWh1U9JfP+ywQTcCYtrV6JAHSf6nJRtRK8FlW7wB+VXjQWr/vy
X-Received: by 2002:a17:90b:5745:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-2febab2e065mr10604902a91.2.1740806942420; 
 Fri, 28 Feb 2025 21:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7mS9BqJ7YzmMdEnYti5Xbra4mLjHQdMOSyVdty0HCMoZycthCklUyMpQJVrxlDMubPqxERA==
X-Received: by 2002:a17:90b:5745:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-2febab2e065mr10604889a91.2.1740806942114; 
 Fri, 28 Feb 2025 21:29:02 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:01 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 09/39] target/hexagon: Implement arch_get_system_reg()
Date: Fri, 28 Feb 2025 21:28:15 -0800
Message-Id: <20250301052845.1012069-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: sB0APoBaHOC9ZJ2F8Erp6YgtNMnpVB2L
X-Proofpoint-GUID: sB0APoBaHOC9ZJ2F8Erp6YgtNMnpVB2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=548
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
Y3B1X2hlbHBlci5jIHwgOSArKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVy
LmMgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKaW5kZXggZTBkZDEyMGNkNC4uMGIwODAy
YmZiOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMzYsNyArMzYsMTQgQEAgdWludDMyX3QgaGV4YWdv
bl9nZXRfcG11X2NvdW50ZXIoQ1BVSGV4YWdvblN0YXRlICpjdXJfZW52LCBpbnQgaW5kZXgpCiAK
IHVpbnQzMl90IGFyY2hfZ2V0X3N5c3RlbV9yZWcoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQz
Ml90IHJlZykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIGlmIChyZWcgPT0g
SEVYX1NSRUdfUENZQ0xFTE8pIHsKKyAgICAgICAgcmV0dXJuIGhleGFnb25fZ2V0X3N5c19wY3lj
bGVfY291bnRfbG93KGVudik7CisgICAgfSBlbHNlIGlmIChyZWcgPT0gSEVYX1NSRUdfUENZQ0xF
SEkpIHsKKyAgICAgICAgcmV0dXJuIGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChl
bnYpOworICAgIH0KKworICAgIGdfYXNzZXJ0KHJlZyA8IE5VTV9TUkVHUyk7CisgICAgcmV0dXJu
IHJlZyA8IEhFWF9TUkVHX0dMQl9TVEFSVCA/IGVudi0+dF9zcmVnW3JlZ10gOiBlbnYtPmdfc3Jl
Z1tyZWddOwogfQogCiB1aW50NjRfdCBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50KENQVUhl
eGFnb25TdGF0ZSAqZW52KQotLSAKMi4zNC4xCgo=

