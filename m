Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F29CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVic-00072Y-T7; Tue, 16 Jun 2026 11:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVia-00072I-SI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:28:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZViZ-00030C-Hr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:28:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxYLb3969957
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6sxPUaTNqv0S0KW4mH4UYG
 cRKg1L5tLqP10Nv8f82s4=; b=pO25UkzJzXEqp5FTwADxX2TmzyjjoigZmBA+NC
 QJ45N1Xy3JRn2QxdCRjS+ooI7lvIYCKl9rRi8ZZtHFmmD8Sn90UYTZ7md90p0Al5
 wawKzP9IzS3mPGLFz37unrXBd0S2Fgvpo4mgeH0rIk+crDoLd+olFVaJ8PPsxOJM
 K++OoUjcE2GqT1hP4/RHM8BgsxzxsXb/nz9SRrRsgiEspruiU2kv/2yxseLddBxE
 neO9eKi01QYPaiJ/GTwWZ5CCsCj9dOz4mAIJG7OSi5c8Orue5ciOFfXwGSgdIMel
 SbcsOILk6EMbxNJWkhgy6EUrNf4lAK50M3DfZkUKg9FIaZtg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkhfum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:28:45 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-963eeb6f2baso4604887241.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781623725; x=1782228525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6sxPUaTNqv0S0KW4mH4UYGcRKg1L5tLqP10Nv8f82s4=;
 b=Zz5hLu7tfHsLAVscm1LtTpQf/3Rflatn0Hw7uXGQqPv6zhJSy88iKzgyZjtXRYq8Bm
 oOaclJocaKXwVQkgXHPLnAymsSwWRb/e6cVNCrQm196ZiaD9NySBwh7L4/x+eSjYmZNr
 LpvkSzVGWSFleZprrggpwFVB9Jwbd2X6LHW42DHpHDsZMajaWwtKScVvmWwdWKZc/JmQ
 cctkzzj+fOmiIEgtvzPaQohAwilr9dHYLFa9VBpmCsUJXjnaTASl3YpIgvmnvQMkKahi
 05o8me9rEBYz/Iz1diw0Kil7ZFSAgj9A8P8gkn/AO3gdT9t4sC2Oi6RAGRyZUAX4HQMl
 Q6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781623725; x=1782228525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sxPUaTNqv0S0KW4mH4UYGcRKg1L5tLqP10Nv8f82s4=;
 b=I2/X4l0wHDFAPIqOzN8rPpZC0wGs+sRZz/1tzyiadYa9ixojUpPm3K4pOvCukJ47VQ
 OMF0p4S7CjTu7iBiXMY7M887lu6E1snZQucf5jgsycsYQ7yVcguTs8Y32yvppuKkyWHs
 lVZGZ6SZ6Suo6MI6KnZnrF7T42ew+dmnTESAAOGN0IL2YwH6krXF0M/AUh8AhliAAW+m
 qdh+xhgVt1TUajf7i6Diuu5zTcH1+YdFtnjRwT/DbRLKl/ahZiO+0R5D1NkVocq6z5yq
 w4+6eWoxPKLcq9P3YKDvWnBAp8Av9FGtk1l4IUGnebqSSu/j1bsGxmYoSvAmwcUJ7qWP
 G91w==
X-Gm-Message-State: AOJu0Yy+a6IZX+BTQZGRLi8Mz/foDMA+q1ipdFdfdbEs5pAZjTvP6mYX
 HydmZDb8dKMWogs5cl+B67L4IubR7pis+Nta4zBmmRsdsmVT9tcalUqG2UAiBmRnf33UZ16oPE9
 mr6mXLCfToXKaNe3+7LOab5xvQzvAT00cyh5kkBrS4GlS/WhVUjO/sKBPkLQcJ2k/bg==
X-Gm-Gg: Acq92OH1EhRRViqQlsEyJ8a2S4ePS6izYcuwGjVC4b0NrueOVYybXKbFZt08zKkaGkB
 u7lfwo6t9F2Cenbr2LvIF5L6Gnqu0gSJVOfLKUEAF0rsNMt505WMB6mdfWKJkifGPc9I0OlnThP
 I8LkzUvOck5apsgHjK05VA5LXNPef96Oc5CSBLC5/dAlXqG0tUEbqBuv49hJ7sblxw4cmsHjcYA
 J4D8mZmWj/VdQjI0je91+/qH0IJLTRK75oyQt7Zb9qPOjY85f/Dz0S4UeCLq3ruXJwkTLAFmlv4
 2u3O4DhloWg/32JjBk6IP/0599zjbCQBODJ381fa52eJL6Yj853XHVdeKY0MPs7IuYXriJ/DqNN
 1Cw5OJNsXu95dks0vMJtoHLgkL7w/ZuMNAG1axy0JdcmcislcHH1x2iBfMX7S6zXiWDkwVCj4R2
 kHg2U=
X-Received: by 2002:a05:6102:3e82:b0:631:3bbb:f25f with SMTP id
 ada2fe7eead31-722d9d9078fmr2806774137.15.1781623725247; 
 Tue, 16 Jun 2026 08:28:45 -0700 (PDT)
X-Received: by 2002:a05:6102:3e82:b0:631:3bbb:f25f with SMTP id
 ada2fe7eead31-722d9d9078fmr2806760137.15.1781623724856; 
 Tue, 16 Jun 2026 08:28:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619a041986sm21346794f8f.23.2026.06.16.08.28.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:28:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2] accel/tcg: Restrict IOMMU declarations
Date: Tue, 16 Jun 2026 17:28:42 +0200
Message-ID: <20260616152842.92275-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PtKpURpevtu4cSTlJBFYidqRjFxsXU1q
X-Proofpoint-ORIG-GUID: PtKpURpevtu4cSTlJBFYidqRjFxsXU1q
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a316bad cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=y6NlWC8qergzHZo4iq8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX0Bdzo1VhxiED
 q+otO6AmN1P6HBk8zdh2s6JlvRNItElyia1D4XPJI94uacDwDNh63P0+Ns35dur1NjL1Frh9zXF
 0S/EfpNus6rqQXkAOra+2mt0iPsSA40CZ+LgBWI9nqPjz42L0BV6meR5/tTWF3nB8Y+oE7vpNMl
 IXNDr0RfgpCRsKlZXnargOahV+zWvkLrcudO9P4ma8Omc50S5w/ycwPkbgbz5sqsY+UCs5Wy8jj
 zST0xJZLCzF6T3npwilftnl3ZumebnQ+z5E+XomavEMq9SRdge7t9+xV6BLcCw442VJr9Qjb7pf
 c1DIDhpw9sk1mNrwpwqdDf1aBLj6r5p49UDUQbsDEqZ2cTnOxlhxQVbRQiyOHybXKCG7Xnfb8UM
 1XBYFp85vTcGPDAZ7JWi8O22WLSZT48V7YImkkkdEEoSfdk542UWcSs0t7IERPP1sTB7M0PJy4n
 017ys7KCPPbgkRq78bQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX3h28EIhRz4ad
 DQ1kpkQam/Sgki30GQCA946TXAUHgGoI4ZWbTgpyiUF+iMJswf3xR76hch4mW9gnCrHHsCV3SaB
 WNN3Qabh6atO9ATRiDJB+wJH4OcwSDs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160159
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

Move the two TCG-specific IOMMU method declarations from the
generic "exec/cpu-common.h" header to "accel/tcg/iommu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
index 2b6d0ff7282..a4032a292e5 100644
--- a/include/accel/tcg/iommu.h
+++ b/include/accel/tcg/iommu.h
@@ -7,6 +7,10 @@
 #ifndef ACCEL_TCG_IOMMU_H
 #define ACCEL_TCG_IOMMU_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #ifdef CONFIG_USER_ONLY
 #error Cannot include accel/tcg/iommu.h from user emulation
 #endif
-- 
2.53.0


