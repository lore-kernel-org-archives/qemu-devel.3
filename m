Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866F7C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vTc-000209-9F; Mon, 31 Aug 2026 02:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vTa-000200-Nb
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:26:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vTY-00017n-Mo
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:26:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52KnF1933573
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Ehu7iO1P/seM1O7KgWYkPx
 HJtfxyIT/OFqvccH9ISBU=; b=kJgpuD6R+PSrmT/L5AIA3SkuN/4THKPYMO2yRz
 EXdlACOSmCa176cWvaVkTJ5j97rWL7RhnQHXCUg3YJi9l23SnZq7njsyVH5bF5v+
 3jFNvcFsWOW9ferxPaxxalAY2Ql1LoziHPzIkyxrgb9v2SdnkKInIBmNwLMbOVN8
 FvHV5a4E521nK4AEQxxhHzHibBpWEOCLUgd7/Q0IhBNy9dcRN4ra/m7AwvdG7PyJ
 2r8olye5K6ojGxbFfLInCLFJX5pG6mNhEfVZEzQlENTPjIWqXLJicudmzc6HcbFS
 Ed0Ip5nZrqhdGZlknCYbJ311ZYI3ZJbUA0SYJT1DJheHgUOw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrq84q60-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:26:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936e393061dso339166685a.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788157594; x=1788762394; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ehu7iO1P/seM1O7KgWYkPxHJtfxyIT/OFqvccH9ISBU=;
 b=MwyfNBALHZtNzJ7LR/v41S/UmE82EW3we2OLS3xNtDP1I09Cl+CEsOkRWwCGAWBDYh
 8lGLRH+VFfwM1GgLte1Q6wG0kYDiQ6skVB/StTFT6f0a+ZIzK83Bc9siTlDGC4RyCWHg
 BLwDIjh7ah9HyZxEwgkjvC0B+GxYujH6VfSKk3Km3lGm4O0S30SVOXJ7F4/OaOOM8Tro
 zmqD/zh9oP6fshchths7yBkRX+efFPJmqEJR4mTWejK1ZJiBNCnl98cfnL0ToCOp+JwH
 9AmWo0kS2IQIku+qGgcaSdidtGNeas+UD1VCypUKCdLrd+kjfLtu839FsQrv1PIgCWto
 8oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788157594; x=1788762394;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ehu7iO1P/seM1O7KgWYkPxHJtfxyIT/OFqvccH9ISBU=;
 b=Zpp+FnUvkAYClVxQzfzpzXukPLo7unQrqcoLdVacon1hZHrjONov9MTp5o1Fjn5tyq
 Tljp1hxigFFxZfuG+i6QRy+0+afW9a83CAOmDSJDzqYNoo40QWwI1bH9k/s0PyDsHn7r
 +9GJ/GIBe2OCvhTV2Gc/7/BeiTlUe0YoWXmHri9+i9QrMu8nhBhu9EwHI0fOBYPR6xLy
 SdSsunckyS+lQ8O0MLVWCzT7BpwOG9TY5nXThifGRRH1qfEJKkw7OuqNE41idLfKHvkp
 GMnmizXZRxR+Q6PwrI87EQcnT1d34ozBSHWPsNGa0O2QIEBhP8m2jMly2XIPRHyRIutb
 IeUA==
X-Gm-Message-State: AFuF++lcDMQ1f+UJm4XoQUOZmnvkxocBmn/oMFblFyvHyja1jwUcB3yI
 QqfkCsR4P6AQBITwXTC+KiQVJh2ykiUn3BVxcyJqY5Ee5nt8+2SKl4JKvfdxSyVPq5CP3kvKMJX
 QWNOdSldKgD/4FOZVP+tNZmJqZQgOpk9O4VQxFzaXunti2SHG7zDA/WvgE3HlL5KnSA==
X-Gm-Gg: AR+sD13Dc8EseqhO33gnjuPXtJzbE6+8H3OnGffrzRRbHr+zQHiraAt1EEsEnFgGRdg
 HiysaMGgxmIUZoBiGo/VJxAxQ+F05ry1XTR7E5If/AmW2pXNGAwnP95Rp5OnCPUDw/X6Wi4yqG1
 ZB7xojiM8Sn1kg+/XKabJrumH/jZFyU/DnbNojK1HvAXqt25bySeNwvKv1XqfLYftldQ6xytSlv
 EfXHjP0OJadC1YlEoxz4TQuqFq124VF3yBdTMmYjN3NawD7aOJhjQLVsD1m6LsAHHEmtPjIiq27
 DpoCUKrT4HmP5UWQqb+48bBOiPcaWMm0oZ3glaWSX6eDKviweNSuQ4ARG66UZFz95A6X654rCOD
 QE//2fW/c8xAnrBkmoo8T37+LkfHayA+uoyHvnJAM
X-Received: by 2002:a05:620a:d94:b0:92e:d7c7:7de9 with SMTP id
 af79cd13be357-939137498f6mr2498289985a.8.1788157593584; 
 Sun, 30 Aug 2026 23:26:33 -0700 (PDT)
X-Received: by 2002:a05:620a:d94:b0:92e:d7c7:7de9 with SMTP id
 af79cd13be357-939137498f6mr2498287185a.8.1788157593083; 
 Sun, 30 Aug 2026 23:26:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91c5790csm218787995e9.0.2026.08.30.23.26.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 30 Aug 2026 23:26:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/mips: Use tcg_gen_lea() for [D]LSA and MXU S32LD*V
 opcodes
Date: Mon, 31 Aug 2026 08:26:30 +0200
Message-ID: <20260831062630.58771-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nLNS8wanA3vYLOSIRjoTPouZg6LDFAEe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1MyBTYWx0ZWRfX6pu/Gvqg/2LY
 0MzIOEThtiHq0y2EuYU7KL3CVyYR5yQ7mCTczavqntKSRsWQvaaESdGLoWrJKiK+8KbNRi2Fewe
 h7r31Hgf3kRXL2eVxZ2Cx1m0pGO/rMg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1MyBTYWx0ZWRfXz6mz2aJczh7x
 lZdC4mpUQa3ei06VTqUXWDanL9WN3eI+AqGGMnAeYzoqc3m7b2tyY51SM3oIMckyAyqMXZiXqjV
 cxKkQos/lYNaP+3aVyKAqtLXcRbwGyOMt0AX1bBtS3kVpAzjDkPtMmQ3qYTD33yFeHGeF2fZP0v
 YtDtPmiKnW/TNbO3/63/sjDRUH+fmES1MBs/ZLVwoH9X8oKEmVUQP2szM7i5LvlVnHkXos+X0q0
 pLAOgB1M+tvC3Egx1OiYFWZ3FBcf4YBvg8w3VmNDz6umHUUjTWZ1wgNbH5wMGPygG9eOWVra9jX
 lWmad20ULYoX95J+U8nLsTgh3ErQ48JRB3P3n7GinWpXJngSKHEwr++Hhd0TKDOyNMp9nOrW29j
 q9A6JAhZUGUaqFVC2sy03TVBD/ZcYg1t9fv0Ygyigi/pG00/lysKi5amRZBDzHlZL+SjcUZVt6H
 BgZP+X1iZ2OiUjnCuIg==
X-Authority-Analysis: v=2.4 cv=ZOPnX37b c=1 sm=1 tr=0 ts=6a951e9a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=24akEc9vXKGNmYZ-wZwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nLNS8wanA3vYLOSIRjoTPouZg6LDFAEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310053
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Based-on: <20260828224451.1564072-1-richard.henderson@linaro.org>
---
 target/mips/tcg/mxu_translate.c        | 3 +--
 target/mips/tcg/translate_addr_const.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 7961b073144..05074476efd 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1601,8 +1601,7 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
 
     gen_load_gpr(t0, Rb);
     gen_load_gpr(t1, Rc);
-    tcg_gen_shli_i32(t1, t1, strd2);
-    tcg_gen_add_i32(t0, t0, t1);
+    tcg_gen_lea_i32(t0, t0, t1, strd2, 0);
 
     tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx,
                        MO_SL | mo_endian_rev(ctx, reversed) |
diff --git a/target/mips/tcg/translate_addr_const.c b/target/mips/tcg/translate_addr_const.c
index 1d140e918da..910177e43bc 100644
--- a/target/mips/tcg/translate_addr_const.c
+++ b/target/mips/tcg/translate_addr_const.c
@@ -26,8 +26,7 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa);
-    tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_lea_tl(cpu_gpr[rd], t1, t0, sa, 0);
     tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
     return true;
 }
@@ -47,7 +46,6 @@ bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa);
-    tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_lea_tl(cpu_gpr[rd], t1, t0, sa, 0);
     return true;
 }
-- 
2.53.0


