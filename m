Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A56CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBuB-0004aw-UG; Thu, 18 Jun 2026 08:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBuA-0004Ws-99
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBu8-0000t7-MW
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAraC9981280
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o387TdhFT0x3T0ROAYi1UdAOL9quvqZVAslX4OJWGj8=; b=gImR9tPNpTGhvtyl
 QLQu9nxgvn70tFz6UBYmcrAPeB7NeAwN6kSiUNV44Bq84mWD33Ynq85bBQ0yNS6G
 jysHcj4eibvhfBMtBhiL7oYumEXssTIXqehP7AzepuscZork/foX60SzKGgSEYAo
 A5CSRF3U7BiZeDgZ3bVD5eDUByC+3vwfxGFyVU5TWx9Jz3mk3zgLqhfKmhyCYIDf
 XsCR2GQ3A3lANV+nyYJSXO7NuHM5yPQD695dDB26y9URqcGct59a64RtAad6XtMf
 T5VLhC9d5UQ6C38zCrTxWj36PcxJ3DC2lB4iT32AiRjt5P4xukaA1H4frOHAP6Rx
 dzunWA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn40p0b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:31 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-728f9ecd022so741881137.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785890; x=1782390690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o387TdhFT0x3T0ROAYi1UdAOL9quvqZVAslX4OJWGj8=;
 b=V5K8jHXvuiZCSL2ifAeCRrZK7qWKh+9DdGRYCIEooBaumVoQOUyJkylHdic4l2iZVn
 a28AP/rVCrlQOmg1IvPyk6eqLOTt7GPbpY4CyokhPzmTmgKf5anp4ARbKq97SCwi5MX7
 e3X35VU7L1mqhqNXrCtxg7uaAQMEcLXN1MgUzzhS+9l+tKVpnPuvWcZfijfvBBCfD4nw
 9umZl0rYS5LsmvFeLQUAf1B2WQ2jgoKxCPdiUC4hx0FAYo6Wfbq0Z4bqiRjkcalXo59E
 Vc4yZkBi3SryMgBF3csPh2T5/HHZxE1zS7yGO3zhFxdHkcV1j4OoNVt5YO4Y8gk9E8Nt
 AlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785890; x=1782390690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o387TdhFT0x3T0ROAYi1UdAOL9quvqZVAslX4OJWGj8=;
 b=NFqvipqcxD/7GVw1unY3nprVqLY5/Dwa1ifvAqRSj47C1hcf3nlV1wSzTPn4LM7J6N
 x4IeIoPgyvCoajQ3D12svnRIJp2WInxfFLzJCRGO8/I278rYyjFz4sx4pwxOSlpGkcFW
 GAOOaz+7Fecb77Z3tBwpEVgCaBqF8bWLE03OM30mg2moWVLcF4xApQmWZNCcYE8UBEDS
 NgZc+g7Vc0spfpJRilHEY8na7btQGiy95fFms1YjAF47jPq3MuHTVtd50dr25/kZhrfM
 0fBIdySx2nUjYIy2syBB0xxJza+ddFgxHipRhYawriFGG/ZD4HOMZ1XftNf5vqzjgEMg
 iGAQ==
X-Gm-Message-State: AOJu0Yzm8mwne082bC5TRzpONFfW2S/YxQ976tQuKVH3wvdazoY923tM
 eFGiaGrlWROfLUFm4vMqQPbn3DuP4JR6cZXuyGM2MPifDMVtReYFpMIzp54djxE1R0JBULG4qvd
 R7WCH1aetQp8nQkinyrqA0HykJ76JBwQrQ8AuXyuwUJOPC3+70aHFrZZdQoS9dyKTlA==
X-Gm-Gg: AfdE7clg2UMmZo9xlaKiEInm9vD0og9oByuKMX/JKEh3pfa7CcYOzHztnCOCLC+uUqy
 PfHJdoAevu3qj5VzX8kmpZzoV5see5IN7eRLPiqkoNFFnRn5MvnRuHsWMnvn7LEwLkeFWCUexp4
 Vr30RqnXMNJxwzNGqNzaKCARmKn6Ad2SwiFBilxYxwvF/RlFOAFy0YMCKrGqIukRIz8WYoh0jLK
 fMzxr9ZAYrr9DZZCn2zOzxkEZT1EOCfe3ZnFtTEtpAX3b250N7xxQGKNF7SqBfKih38coIi2Jjf
 dAWTx5vsIzC6PffrUh7RMZOoLuIJbH4G1GsDqYlp7YYTVOUFDWrW9ChHxH5sEpvAbjffL2z/EDQ
 Ney2o8kPjhaLCaV2TMV56RB+4+M5wzx8MiISL3MfY5pG0AaB9kPPkgw0LLHfCq5TyMyBI
X-Received: by 2002:a05:6102:580c:b0:6cd:84ba:6f51 with SMTP id
 ada2fe7eead31-727c706ff28mr1813370137.19.1781785890204; 
 Thu, 18 Jun 2026 05:31:30 -0700 (PDT)
X-Received: by 2002:a05:6102:580c:b0:6cd:84ba:6f51 with SMTP id
 ada2fe7eead31-727c706ff28mr1813299137.19.1781785889759; 
 Thu, 18 Jun 2026 05:31:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462e7fc53fasm11654382f8f.33.2026.06.18.05.31.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:31:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/48] target/sparc: Include missing 'accel/tcg/cpu-ops.h'
 header in cpu.c
Date: Thu, 18 Jun 2026 14:28:02 +0200
Message-ID: <20260618122825.90331-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX81OMsn5rfDEH
 /H7Gs1T/YvkM0NoI+GM1HtigbgzsRbUaJqNiuHsRpqGbAuWr5+eq8psc2HhTVPmx7g8msrcQiW6
 iuZc3KMqBnhy+/fhJMCiUqi8N15EXhX33aobwJrBgvNMPcVp8gx8etKVTPOxwyhwsXg19Iywc+L
 76GBebaA30dYc7G7eyBB+1kidk2WDfUjeTkKFibNjFSFohqNfOzbnEyKbVLG8Z+UR5QP3reKHET
 F1nQ/5AP+w60olF61BrxiLjo500UNMc6Q2zwan+Wm0bbP62Jrk+QlaFt07BUj5pLrF0n3AcFsYV
 0T0EQdbWkyQ+M/Ld6uJW1tUuj6mLp1zSmFAO0RZQO2Q7JpV3gEE7q433SL/uUpseVHdapICUdtR
 8eTAyZYXCS0LOUKE8WewxWqi0S5dkQJRA/LLbDzTkIe0pt6Xa7tgxzn5p6zqM8TFs0Z3xhdf5W2
 W6hLEhPCDe/C47Ja/rA==
X-Proofpoint-ORIG-GUID: 2oDjfmEJFqoulnd901GDP6OPKBzSgXJk
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a33e523 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=-aSRE8QhW-JAV6biHavz:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2oDjfmEJFqoulnd901GDP6OPKBzSgXJk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXzCf9GjGGgqht
 Vb89KVfvEkARk6XMyg2NWM+gsIPEaOBJuCH8KR9MnbkkhpqclOto+UwCYz9PtebP4F3xLOtNQG3
 BmuerhYGcTMqklncT61tHveb7NmaDKE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

target/sparc/cpu.c implement a TCGCPUOps structure, which is
defined in "accel/tcg/cpu-ops.h":

  1040 static const TCGCPUOps sparc_tcg_ops = {
  ...

While this header is currently included indirectly, make the
inclusion explicit to avoid issue when refactoring unrelated
headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617160426.64461-2-philmd@oss.qualcomm.com>
---
 target/sparc/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 3df199ada7b..13ebb122a38 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "accel/tcg/cpu-ops.h"
 #include "exec/translation-block.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/visitor.h"
-- 
2.53.0


