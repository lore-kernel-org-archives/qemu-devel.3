Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D51C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPI-0007vo-3b; Sat, 01 Mar 2025 00:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPF-0007oQ-4i
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:28:57 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPD-0008M7-Fr
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:28:56 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213GfWT005267
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kqTjuWP5/kn2hFISQcAJ8a0zTcK2MErShBDBky8zYfg=; b=f/FOnXbsuiaKFzRs
 Hv2POuZn54GkzrbzqBICNH3iIVX2EerKMRMcsgv5EGz7itUV8zjinFtuRYx9nIBL
 5fKymCi/6gitDp52ukbErm/GyqznMIHs7Nh6dbU3ywanb2EVQiNb7PDVG8WpL9/2
 B1kAFB4mgriZMCeYVCYcTwMuSDgmTSVBcvyYFou2+3hzyUPpipEXm4Ehz4OJbQfA
 N9Qgn9yw02+xIMHjJBExDiZR9I2IEu0eHUWes0XjrtW6PB5a5A8z5JjNYkXYs27H
 qkRXnAPenjlDHDp+QoYoDS5WXIJyJeODqKlOREKoxP8NK2Xhk0i0P4CBzEENcucm
 0jrX4g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k06fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:28:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2235667c974so69529305ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806933; x=1741411733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqTjuWP5/kn2hFISQcAJ8a0zTcK2MErShBDBky8zYfg=;
 b=rnIvAee4UsnjX5H4GA4jZFYm/taGsbe1GFIuLkoy49W/k1QzfxeWYADKENyBM7WZFt
 ivwhwNuRSoZEiNk28fHzNKX0iUR+xhFkNlhZi0tOY1egKuxky3ubLW5cAkSGiVZ7JvTP
 Hd+E5OqwUvJgD0nVfdq2oLYuBD4cjB1mnHmCejceHVmAP9+uYApysrKSfXtMZhR7JKAB
 Adxg7J3g+otb71OSAavIyUrMf4z2nVMgEC+zsikzhHp8658/nGdExj9xGtvzo6OGlEqw
 pmDP1VtOQxmJAavVGyFvWkTihSGGRZo6dT2L+09ZER7GpXEAzuLRv4ICy1PaSPNLgERE
 A85A==
X-Gm-Message-State: AOJu0Yx6K5Vrw1w26VG56tVcNnwaKe99ZAjXprrhYh3Rl5dRukI4BNtH
 RHd+zxvyFBvqpP3kiyBClHCiFge8ena7e4kpD2+YOunqN2oCnhDuNKCTEWhUO5Yaoy+khHXuGlQ
 SKsFnSoyoh8TIfl50ckvfxtbk4bT77k4Hw7m9c27JXo5UOIsgUYvgzF9encDTng==
X-Gm-Gg: ASbGncvXuu+ol6YNCzSUIsUGbOFF2c9l1qY9Qn/DC1FsuqsZPJjOwW1A12ME0i0Vix+
 lAa25BdoEZrt9UcaikMY7cUJHjmtJ8hBCiKbTQB2I98NA2/d9wfw4+/6o2CzufbkaNa6VWFz4tf
 zkd6LLln2wd1ltrMm8lYw3kbJ5QvzUCwnBKTA9jNkMCBPyisT0N/BSRWFDgPruQA1UpTOvAT3Ir
 wL226cpDQRxGhUvK9fTDIALX7qZsHwvjh0+Hl+9i7d41BtRBgGjGnFKThnUcfoQ4P+dXC7xDxIs
 WqM+mQr/OjjK7WG6v5cHA/nN5mrmjYiyRs+/kGZ+Q42vY5M4YpR/A0m6nVXC8usM
X-Received: by 2002:a17:902:d503:b0:21f:3616:1c7b with SMTP id
 d9443c01a7336-223690e1c4emr111735895ad.29.1740806932957; 
 Fri, 28 Feb 2025 21:28:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYFKwL7vXS0s+USC/rSN0G8aIkhH/5/v15sQ0LN2SGU99iOWAIrWbZpBqqmb+3d/pyxFkJlg==
X-Received: by 2002:a17:902:d503:b0:21f:3616:1c7b with SMTP id
 d9443c01a7336-223690e1c4emr111735685ad.29.1740806932595; 
 Fri, 28 Feb 2025 21:28:52 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:28:52 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 02/39] target/hexagon: Implement {c,}swi helpers
Date: Fri, 28 Feb 2025 21:28:08 -0800
Message-Id: <20250301052845.1012069-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: IO17Okmaa1Vr5coQ6VzDTx8Pd490sD82
X-Proofpoint-ORIG-GUID: IO17Okmaa1Vr5coQ6VzDTx8Pd490sD82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=476 mlxscore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7Yyx9c3dpIGFyZSB0aGUgInNv
ZnR3YXJlIGludGVycnVwdCIvIkNhbmNlbCBwZW5kaW5nIGludGVycnVwdHMiIGluc3RydWN0aW9u
cy4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXgg
YjI4YTE4YWRmNi4uZmVkNWNjMjcxNSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTEzODIsMTIgKzEzODIs
MTQgQEAgdm9pZCBIRUxQRVIoc2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1h
c2spCiAKIHZvaWQgSEVMUEVSKHN3aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1h
c2spCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBCUUxfTE9DS19HVUFSRCgp
OworICAgIGhleF9yYWlzZV9pbnRlcnJ1cHRzKGVudiwgbWFzaywgQ1BVX0lOVEVSUlVQVF9TV0kp
OwogfQogCiB2b2lkIEhFTFBFUihjc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qg
bWFzaykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJE
KCk7CisgICAgaGV4X2NsZWFyX2ludGVycnVwdHMoZW52LCBtYXNrLCBDUFVfSU5URVJSVVBUX1NX
SSk7CiB9CiAKIHZvaWQgSEVMUEVSKGlhc3NpZ253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3Qgc3JjKQotLSAKMi4zNC4xCgo=

