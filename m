Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E90AC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNP-0002tJ-DE; Sat, 01 Mar 2025 00:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNN-0002sD-DH
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:01 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNM-00086p-0G
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:01 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KB0V027265
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WRfQDmT2uYJax+HxewxqdV189Frd9cjTaFidWfDF9Wc=; b=Wl+sYO19fEgdY9Rg
 9muV8ADpFWt9fW5bBuihgQLTBFVks2dOETh/GkH0/V9fwtJAljvePw69/uYne3Dr
 QgqPJ1N8zkDaoGl+F9w0OfDRYSr2zV9Vej4yUCMEskXzi2Ah7ASRQIZ5jhTyCa9e
 RLoJ2KDho2PfYcNWbA62jyrGtO/kgvUBpQJSclgt4VbjY0T4GuJfspGb3lF+hLk9
 c+am+VCKwMPfS0i5WqRzFxmfcf7XufHFPuWUqTa/U/3UFlhmOwsb2nhgA9wdm2IB
 LCVLY6Ht8Z4vrLkfsjGQpPO9hfl+kL1nINCL5H5MXfCupppqoS7CGeuhXOtbDc6m
 SOJS7g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t89r62x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:26:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fed0f307ccso1244559a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806817; x=1741411617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRfQDmT2uYJax+HxewxqdV189Frd9cjTaFidWfDF9Wc=;
 b=Da++WZLbFqHtgrwYTb9CFY9URdz/kdm+wAaCwEsA7W01jhqaqvU01cw6crmfx/JETP
 oEgLuHahb0rJ1N0puevbt+miRsGwaTCkCAM44VSMzjq1OQVRJvKIpIGwkYlarKNtKIuX
 HsBLgLvSc5Nj0UmTWZQ/UoD5l8QkWRmEK4YIdSbcZyYWsyDfAxfYLqQcwkl9dXaW7/7X
 KC/fSS3ShcFZFv3wizDCsAT9z1cPJStwtadbvbmq0j2Wv4Oulk9RrvX9LBkWe5Rim+7k
 piU7O8no8s+UyVbVoLP8XLOc+kHUE7bhva2fIB8/mSstRqWql6FcSShWoDahBwyjJTA7
 Qt1Q==
X-Gm-Message-State: AOJu0Ywlm9xb5GYGEnX8FddxBndI7wWlSlws3mW4JIS5TEZtsLGhPukx
 MhLyZK4RIgDUEY5hgLqSLVjNJ9PgDDqe7tL/54XyHMNhc7UWTYfWrqnLWe0104zmfkU5j3+s/N5
 es43pnfeAQXdmyu8U7TE3hrQcfvEOQV72DlBCvxDc0Ld7PErd0f1Hi2Ax7NmhfA==
X-Gm-Gg: ASbGncvJj4jAl8If0f04GK74xHjRwjOIoba5LjanIyDLv6AsofwJu2E+Jgnh6Kocu4U
 tSZQ7uVAe5ZnZYPvX2S6X2VInYl/89SeNM9w4DQDPC1E20pIHhY8bwv9XOGyQ/Yu6/HaNmmV/KP
 I7/S4oja+8LJMkTARCkyjraMytzk2l7wrhHsdX0322VgjtDRLw9+REiZHvkL6yl6oG6qPVgwYtc
 c6XDK7Rbf5SvluEFVccpW/FCFhMWT2FRjMX2Y9eH9Fi7aTgkw9HVoFNSsAFyMKiLeEBDp3089H/
 dJL8RymLoEvzhvRXsJ/adhHq0rbHYfrtY927ZP9A7RtTCL+NdgkwuZPaErNiBSJk
X-Received: by 2002:a17:90b:5281:b0:2fa:1a8a:cff8 with SMTP id
 98e67ed59e1d1-2febac109f3mr9722141a91.29.1740806817494; 
 Fri, 28 Feb 2025 21:26:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9mI+sYFTqrhwjBPoPAcvwr7VgEgiq13OkATIrF/VEKr95iAfkgTRa11gY/MD0gMdrYS82+Q==
X-Received: by 2002:a17:90b:5281:b0:2fa:1a8a:cff8 with SMTP id
 98e67ed59e1d1-2febac109f3mr9722122a91.29.1740806817161; 
 Fri, 28 Feb 2025 21:26:57 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:26:56 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 07/38] target/hexagon: Add a placeholder fp exception
Date: Fri, 28 Feb 2025 21:25:57 -0800
Message-Id: <20250301052628.1011210-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: hGeaVwV1dws7tZARMMZjwLrUNgMmsmpW
X-Proofpoint-GUID: hGeaVwV1dws7tZARMMZjwLrUNgMmsmpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=694
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010039
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
YXJjaC5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2FyY2guYyBiL3RhcmdldC9oZXhhZ29uL2FyY2guYwppbmRl
eCBkMDUzZDY4NDg3Li44N2MyZjZhNTNmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNo
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMDgsNiArMjA4LDExIEBAIHZvaWQg
YXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0ZSAqZW52KQogICogbW9kZWwgaXQgaW4gcWVt
dSB1c2VyIG1vZGUuCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCisjZWxzZQorIC8qCisgICogVG8gYmUgaW1wbGVtZW50ZWQuCisgICovCisjZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBN
WUUpIFwKLS0gCjIuMzQuMQoK

