Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F618CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBt9-0002Fm-Ms; Thu, 18 Jun 2026 08:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBt6-0002CI-Nr
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBt5-0000Q8-8J
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArv9s1609171
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DkmJmDittXAYBnHFpAqmuE7kPMztE7vBYCLNl4CmZaw=; b=hermUDcVm5hrI1rE
 Tc/aDnT/2HSwvqDXWEzk5CbrqUPSZRa6/HYtVOq6WH32zZktXXdZSv5RN1fGC0fY
 hOVOQDwzBImMPdcrYJwnRCJLY6BlTLfUzg+2bE1ian/zTWX0BSxiUR0LCWtrAemh
 A2xy3E+wy7M6ZmTpB8XPnr360mygoMTFhmUC1xjL6xJwD3thOH+T3VGd8iBod5MI
 AO0DuhbzrqYsWSROCFjdhj39vjnGno69rVNaVkbPEKCLZD3Rqv5rWPrV8eQRJa87
 V68xIiGUQ28VPc1H4813sgDt5GyhUje25ONh8zcw6mqpnYQwIIiC1GbiqYtEbuXG
 3S1Kcw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7kjub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915b6b63056so198552285a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785825; x=1782390625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DkmJmDittXAYBnHFpAqmuE7kPMztE7vBYCLNl4CmZaw=;
 b=eS8TJCUpad//yrMNjVcHE665ecvaboyox8ddcnFWdAu8RDU4N3+207rcqpoHu8qJBx
 R66zofGi6I3C/0hpoL8Eun7HNZAgzgLAuuwXgi+BCO/UhsD77x5kT/7L6O+4DmZ0jAtx
 AZ65uYPPITi17Y31gVwlr1Ccc4kyNvMBavvht3Bt8fo7sQzbrtL41lTQBeZ3pTDt8zkV
 ou0r0OhQWFMUJzRXmJ+nCWZhlRkD1k3StWFKSK/pRTXSix9G0sg4HH1aoh5JZ/wFjPzk
 lMPAMXAtqplOdzmVwlTHgeeRHBpO5a64mDc6yiZwvVf6lScvSjgrBRtutcSQw6zYwtQS
 9qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785825; x=1782390625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DkmJmDittXAYBnHFpAqmuE7kPMztE7vBYCLNl4CmZaw=;
 b=RUYEGJRk8XHC9Y2hIX0KtdZV+nNAQEgYV1xkDW0ZD+YmPUYzKg4EtliUZDP//47ceD
 8AAANZQ6HcjurLqA7C32sBmobSCdyis3vIToEBiz+9GJueFhsqv5IWKIOq5cp3tdWmLM
 wL/y9uqOe8/LhDm2h2DyavFV4fRP4S+/7PYwSEuAWu5kqs7h2gp1i42/nhehoWKUc8Dx
 nkgkBWNyHoMCWP/uhLsHkHdxlx3bSXQYYAM/b6ZlcyVyMZ0Md4BkiJTph92JczMlfEQm
 y/P2TK+ACRuOBhISn87IcgzrJQkxK+6GfWyobQo1w7FrspNyikbnRY/08AuTbfmO0pf8
 TfyA==
X-Gm-Message-State: AOJu0YzVHWtGEAcJ6B/eupnF+nen3bC7Y7N5MxYvGzNj5gmzMsFUsSAc
 +DeGHiHdFZawkPulZ7REZthKEw3ROA5SLEzGfm08wzwHzAjSpuIL1A7q+WKkQflt/OYMike6P3o
 xm4JalNOkxWrpSN4oAYiU8dd9ol1P24mVVc4ati4b6imI+/+08niCByhblWaF3CGrEA==
X-Gm-Gg: AfdE7ckiHpfLHym8uCm4NiIerF0SXgrrnZ4mmMNo79T2cDRi7BihhSQCkDKxIb3D2vF
 KtFOga+asG0ds9XqF1sX4TDCqYy9enPJwr5rMv6X0ZDlS1fqj91Vo4ZGcEPvgOG0oMPbTHfMvmJ
 GDxpz1NhPzwl9WLhIy2/Ki2WAXmH3Cu9tqwwxAfLnNWfE0NFFqmpSaYWV43QO9cP5/o9GMShHoW
 bOs26zWSSFoRspZ5ZGBLAR4Yq8IDVOcxfFCfo/y5ahsJxemnJA6ChKIm9wX1Ba8POFP5QLip7uf
 kpZTo9AwZ5pJaN2+01L9sd3Fddjpkj2eN3Y60M3tVydjMDMCGZp4Xih7iJiDHw5WKUhHlU0iqkh
 t9lzqIKQ0EtlqmxHKEGeJ+7EoaMmnq6Ive0t14o+92Wpeem6u0F7FfNIo14wWVLy252cq
X-Received: by 2002:a05:620a:370b:b0:916:411:a143 with SMTP id
 af79cd13be357-91d8baa7e7fmr1360885185a.21.1781785825237; 
 Thu, 18 Jun 2026 05:30:25 -0700 (PDT)
X-Received: by 2002:a05:620a:370b:b0:916:411:a143 with SMTP id
 af79cd13be357-91d8baa7e7fmr1360849285a.21.1781785823328; 
 Thu, 18 Jun 2026 05:30:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462e7fc53fasm11647527f8f.33.2026.06.18.05.30.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:30:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/48] tcg: Include missing 'qemu/bitops.h' header in
 tcg-gvec-desc.h
Date: Thu, 18 Jun 2026 14:27:53 +0200
Message-ID: <20260618122825.90331-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX7YJj412HsXfM
 u1DTRP4w0QnCtpQ3bO6lqtraJVySq/q9KGmxxg2snkjWj7dIQ3BBhNy0/ZGqEX6r5S47xi3cV9e
 fGgqtkno4G7/QXgB6uk5XXtdcyoxzJpcQ7VoxcgR/qQdPNV9nnvX0RD8hgzuI5Y59oNPV4qDvIn
 ycb8vop8dhFGdb3g5lC4MZtYZgdoEQ83BRMPkgW52U9FXESfW/9NwEZYzxN6RPIrh2D7bZcSgcZ
 mqzlVWBPO6sjdCZSzdEk8meLxu1mxyBTEe/ZcamoCqfm8M2xGyLRUZ8BuUKTvwH0StZWW8Yy1Od
 gq2g8+bqgZLbdzhsQcbz0lO92LTuVG/DpGTw6ftb84+CDY2508iKS71BtPDfmiiu5fRPbydmiS3
 q+ROkW5S5ub2aTUq0FpD7CDojMzQDHw5+Oq51MKfbYKspKKKRbyneCSQXxMk0sTSFu8ehFWQ4zH
 XYybhZizPxQ69gAiimQ==
X-Proofpoint-GUID: bzhrK2foHYhP6w82tz1XWzPPZiX6lXVw
X-Proofpoint-ORIG-GUID: bzhrK2foHYhP6w82tz1XWzPPZiX6lXVw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXzkWNtYNHmLWR
 gauALqEBhwP159pCT2kvIGFa7l4UPuy8j1IieYhkDAMbaAf4AI1rr9Kfg8GXPAse4LrxQ8ctfNL
 Revve/d+O3AUIYhSACIOsgQfBV7revI=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33e4e2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Include the missing 'qemu/bitops.h' header to avoid when refactoring
unrelated headers:

  In file included from target/arm/internals.h:34:
  include/tcg/tcg-gvec-desc.h:48:12: error: call to undeclared function 'extract32'
     48 |     return extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) * 8 + 8;
        |            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616153432.92939-2-philmd@oss.qualcomm.com>
---
 include/tcg/tcg-gvec-desc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
index 704bd864549..94c7d14b264 100644
--- a/include/tcg/tcg-gvec-desc.h
+++ b/include/tcg/tcg-gvec-desc.h
@@ -20,6 +20,8 @@
 #ifndef TCG_TCG_GVEC_DESC_H
 #define TCG_TCG_GVEC_DESC_H
 
+#include "qemu/bitops.h"
+
 /*
  * This configuration allows MAXSZ to represent 2048 bytes, and
  * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.
-- 
2.53.0


