Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76308D1951B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkVAm-0003yi-GY; Mon, 26 Jan 2026 17:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1vkVAk-0003wJ-Kt
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:35:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1vkVAi-00055g-Qg
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:35:02 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60QKgCeS3384176
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=EWQtnQkgxE8NU8BF2VZBHb8D91KxHe1EThf
 uoFjaxKY=; b=Qk0pJT3S6GjXDRrb6soSD7fHGnCEGgEFoxcNoCwDLNJdbZX3u4h
 8LNGPjiX7tYuy7Nsbtv5x2ma7xFRTVO0cRkgsavkp5nD20zx/JneYOyO0tBX5ByH
 N+RTKfWFmkSUwzZU4mU1EY5XtIMyfff7at+Qr6lBmBRpv7wg/aDTI0tXcUuA1Ggw
 Gr7fAGn7Tm37DRafRRWwFcKHGzq6rBFXYcFc26eSOX8daDsb9Hpa9PBW5pJpkobI
 ygorHNUIBIK3AT+QRj5u7ytLwbzd5p74ql5bHsKlbi95uOLj+XR6ubdi11XC+fxA
 aMsenFG2zKHY1FPUILMekSZ9jqQ8Gq+thUw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a0afg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:34:58 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-4081db82088so8178198fac.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769466898; x=1770071698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EWQtnQkgxE8NU8BF2VZBHb8D91KxHe1EThfuoFjaxKY=;
 b=E8/RE5thq/81aNTug8QmENs6FgdltmB6DAv0EThzuztqZrOIuGqF9mAvzwNOpULGaY
 uWypa6rFCvoLDlpfzY3jo9HMMFxbF24q2NS5CFWNJGeY90oG3YHuyBuZZ1PTEKiOj/IW
 vknPra3e6sYBh1c42+O7OH/x4zZFctFZ26ARULUPzUqe5+I1B6ZZKj5AK5Hz+D48bYfE
 PRKFuMNIIYaXfkMZsw2auVm1JyeBX3U5A5KQzxfo/DAgXXICFTHdZEpt7onmWF3DutT8
 S3FztdCdfTDgl6ooHHcdggMVd7GPGHQk2NcI56dtBDRCWAuv0vl2ag+PwVy+to5evJOU
 pa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769466898; x=1770071698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWQtnQkgxE8NU8BF2VZBHb8D91KxHe1EThfuoFjaxKY=;
 b=ougtWRKOv+r4umoEuI28qkZhTic1LjtuLJDKyS7hGKbvomsbYOpalRmdW+wVV0oyBg
 yzRHROQYz4699eDr/ZVBy384NIl/gJQ8E3V3QqrcLPkzsqqBQKtE/VOiXlEKFK2/P8x5
 OoFRHUiNM91wpJ7FdfBL7K58rkFXq6jxeq+RaJ9ahIyAEWnKardUVSi3MH5ntzm5/TQ5
 IXU4p1Dy/5RhzqFIyJRi+nwzSItOEWsP24QrXv28pObiwJ5BeXkupFIcglpo0EWme6a9
 EFXGc5/5rm1bfESo04+XBEIrqoz0GTE9TGqkhG+pRpzPh1APAwCbo7uOf/q7wgZQtv2o
 gCzQ==
X-Gm-Message-State: AOJu0YzP6+ds3uJdnorYW0JfRU7H4eQNZwKGEW/7pT8oRR+bdKFYvmTD
 JAKDICYvAFXNkUZNhBVmwQMolEJqtFKd2f4GPRSaCx6oZaGMW9IuLo0rKigybRYr0yzVxMzNrMy
 UNcWPTzJkymWafD1IsppBt7nFIvaGYs3M8v56xtqCEOo2UvKfgh4Xn5jwqe7OFRe8s8yK
X-Gm-Gg: AZuq6aKL27t9+oQEr7OrI6ZCzKZhk3OcZcjIKLO640pyRglm7Sr7tYiLtQR8XAdQjww
 X13YeBLFMpwH18Jmo990fg/7fHG0mf+mRXGqJXb0i/0rnZ2L77RSEG2H+GCZVO51AUTdnNsOb9K
 Qa4t+EW2lAFZF/FvTpZwAlYp1ISXF7AQOuKLjkKjl4JBLCazdOuJT69Xbd9vqImYXYZWpAWXa9S
 u/xOycPOAHasJiAL71F9cTt9386w4NKWLI//pYibfsgfiBK3bBLAP/pG79VB1Hbxh3hfpQCY+RV
 QZUkJ6NtQYoTyfuJ6pzFOpGDx4By8LttBtwqYHtWrlN7obMZrDNS71feaNglhC3SctqUAW6SiG4
 PGfRUPewsi/nEbirVP+dxSRhRZGBMGi+A8w6AcWGJXmzkqwVOD0DWK97bOyFtuPLdmhGn
X-Received: by 2002:a05:6871:69b5:b0:3e8:995d:5794 with SMTP id
 586e51a60fabf-408f7b5692dmr2860336fac.7.1769466897615; 
 Mon, 26 Jan 2026 14:34:57 -0800 (PST)
X-Received: by 2002:a05:6871:69b5:b0:3e8:995d:5794 with SMTP id
 586e51a60fabf-408f7b5692dmr2860312fac.7.1769466897041; 
 Mon, 26 Jan 2026 14:34:57 -0800 (PST)
Received: from localhost.localdomain (65-36-8-206.dyn.grandenetworks.net.
 [65.36.8.206]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-408af49b115sm8047754fac.0.2026.01.26.14.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 14:34:56 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, brian.cain@oss.qualcomm.com,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH] target/hexagon: Remove unused EXT_IDX enum
Date: Mon, 26 Jan 2026 16:34:33 -0600
Message-ID: <20260126223439.46974-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5MyBTYWx0ZWRfX96mpPvxNVZHi
 faTuF1y5Yjx7tOYoBYNNwO58XiGTQiNY9W9dQaDUUkJrHKnjSJ/hbsP6vUfxUFWLWGXyq04GM0x
 q+wgjGRnmc1TyKZILD4oECDNkpf5zT7nuhnosz6ddfk/Fk1lA3v5LUKkvOtH21Y6+Sn7SQnCgUI
 cox7H+5wkQzhFGGOe0iyQ8Rs6sU3jE0Rr+ArBC8+zntjqD7B6MTaKhve6yfLZDexAhj0+7YFeSM
 PQZNop8pUnnYSytbxuAtEckgjPLOgvsBxOpfNF4SB6XUFl8PeEM2pqcjWXvmr/4OJYWAzsX3vr0
 vi42c7O3nDq2hUJ8lF/q9cN0T994cPIn2Gb2tpwUM7MyjliOimttiyWIfYR/dkJWgVaaWCGdnbG
 PoZt5TIlQTqKG6vLbpRs+oU819PGuOro+iBl0fEJ4ZZFWq4dV3Wtb7rgVDm4at657gXwdk+m1h0
 ful1G5QIrYIHRW4Z05Q==
X-Proofpoint-ORIG-GUID: xMycmxv2hMLvnCOw_cOJ8cPcliAGEuGh
X-Proofpoint-GUID: xMycmxv2hMLvnCOw_cOJ8cPcliAGEuGh
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=6977ec12 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=EC6cRb6ShDIsswujv3MNkw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0gKBD-w5_r1FFr0MK3MA:9 a=zZCYzV9kfG8A:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The EXT_IDX_noext, EXT_IDX_mmvec, and XX_LAST_EXT_IDX enum
constants are defined but never referenced anywhere in the
codebase.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/decode.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index c2516d927d..30100e5105 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -26,14 +26,6 @@
 
 #define fZXTN(N, M, VAL) ((VAL) & ((1LL << (N)) - 1))
 
-enum {
-    EXT_IDX_noext = 0,
-    EXT_IDX_noext_AFTER = 4,
-    EXT_IDX_mmvec = 4,
-    EXT_IDX_mmvec_AFTER = 8,
-    XX_LAST_EXT_IDX
-};
-
 /*
  *  Certain operand types represent a non-contiguous set of values.
  *  For example, the compound compare-and-jump instruction can only access
-- 
2.43.0


