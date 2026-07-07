Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7805EC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5bz-0000ug-8N; Tue, 07 Jul 2026 09:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bn-0000cM-Gk
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bk-0000Qz-Pb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8WSW3741892
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gRlOcSjspO3k/hRHSSU7lMB/KAIFGaY386Hcg35308o=; b=lKqBTUy9n1ETEM16
 7Xy1BdBQuRo/vpt5z2/9WAMdFXN01uq8Aet0JSKEoy+9D9t++ssojQ/zRzRcagEm
 OeJgd3KzV4EJAWS6T0kr2ca8Uo1CgTaciiJo6kjAsubn5tZJKfEVyeBAATTxuKZ7
 44PhhR4W++pgUd9EITXrtqJ4cMQ/vW3+eE7AXZd5KtOZKnk6iazcPkARBJd1ZOwS
 D7Nm6f4YrB1dkzv7l0Ph1HRfogxwu9vOtkZ7CO7XwbIln9u/mB+v4ysTe0bz09c2
 SwZ+r7UnYm4oqmoz27aRhvI8DY9PwHtRAXwK7BgoZENN6Xgy7WUhrHsDPqLCODyV
 39WaYg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0gpkq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:13:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso54717431cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783429981; x=1784034781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gRlOcSjspO3k/hRHSSU7lMB/KAIFGaY386Hcg35308o=;
 b=PUfXEVwbp5Turs/h1ssRQawtU80SDf23UW+IvacBen60zyFb//aniBFhc5O40e8Mnt
 icwVxs/XWzkzDcdsXGzxr9ON2B1D7aGslH6grsyad2//95e7hu5JHgTon0Q2GGagnN6X
 AVnUt35JdJypPkG+4WKuVpEH1I58iRRQMnVd860kzT9P5QlMhK88DLWuecEh+y3s1AtU
 NfQ3RGgTMQh3vphgN+MgY90qXfSEFenLuGE9v6q6HEOvNgfySXrs8rukI6uMaNVUozSQ
 3yhpI/htc7QYqwhlevLxa9HLsta8TWgRQLyzkdBtOiNxgxrI1Vk9FvBCsS1nsLZSe0pf
 fq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429981; x=1784034781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gRlOcSjspO3k/hRHSSU7lMB/KAIFGaY386Hcg35308o=;
 b=kBcod2pNpez7GY86AEOuYgl3ISTqRYmX2Dyc8wgUAR1yU48OvhBqLxSug7JGhJzCOk
 8KQSh8qijLcDusHghjnxwThAfu0BIJwfmdmnuuBfj5HUM5/2/MqOO0Y62dafTSLnbTiF
 hkyDIjI4XJNAL5yKvjtqeBhRbRm5eV3kiQtRMwGZ/sfvvsOoLPiw7OT8k4uDF8BqEdkA
 aKyc0vyE0pzyHTJZtruOiGyk0LtCLUI9gtzwG0tIFF6sjfsJ4xhLP6s2DTQ5c4H6ZrV+
 EXFEDm4ngCTh+gn9HDuFvFNoYlZKRPj6M5+iedEDSRRoPmKg9UQm9WE1S6r4oavoVTwP
 AmqQ==
X-Gm-Message-State: AOJu0YxyqfRTZd1AIZuzyQ75PzJu/NRLaWFnqbuQtcypQ3RUGZexHytV
 gaTkhBFiNP03ImtXfK0rBRUSo8DLYUxw8asnN6ObjGJqyRbL+93AXGy3EqUkB08MyjjawdzfRMG
 nz5HY6qXYAfBHXIQxRC1jWz8XVJmeP2TmRzF+KqXFpNH9KELligvvxfElJgTe0kzY+Q==
X-Gm-Gg: AfdE7cn8XK61LWTv3rOL+a416NVerHL8UfL6z6lp4vvNWRua8pcrY0UCWgEXEULjocD
 XTliYP2bwGIzBX5gT4EP04iieZtkgkQhAT7OTaedE1iwA3rDsEZ+bNv9pS+N7uEUyyq3g+Rydh9
 fB4ZpIty5TZFetKnRWtugQNZtA/PLRbzkO+g2H4xqGoCHguDZwkICk8d64anUyGVqqyESw24FXp
 S3JGrs9NugL/su+uEGuiohpOaKJqAjC1mQbzEjWPATHdJEp+rsWrok/XN7Oy8X9IdAULM/9Im0U
 9U4mJXyEknFN6l4vkfvVvRqMl/ugj+4Y7fjZtAG7LxZHUjCk0T4Apfu2BtwDzg3wavRICsFoIhM
 YHBEeOtMV5ODnEeFIdd192z2bvtkY51J1e1V36xvQOQUgiccZ2oAnbdntujWPkAP4m6MH
X-Received: by 2002:a05:622a:487:b0:51a:8c9c:7f52 with SMTP id
 d75a77b69052e-51c748dfd67mr52449301cf.69.1783429980943; 
 Tue, 07 Jul 2026 06:13:00 -0700 (PDT)
X-Received: by 2002:a05:622a:487:b0:51a:8c9c:7f52 with SMTP id
 d75a77b69052e-51c748dfd67mr52448871cf.69.1783429980327; 
 Tue, 07 Jul 2026 06:13:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9bca17sm140864766b.32.2026.07.07.06.12.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:12:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/32] hw/display/ati: Include vga state in the blit context
Date: Tue,  7 Jul 2026 15:11:55 +0200
Message-ID: <20260707131223.51505-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UE0FH6w5cm8jzH8N4Sdi6U_Jm0PYRqgy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXzl3WGk2Uj3tj
 kN7KpkoCt5P16bMG1aQHCR+K7b4nt8vCgbgjFmS9psjIEWSjnyiFXyPVXHDzDK3a+1t4rOU62/x
 M7hsUPFeV4pcOsDZz+JjNnS8/HfYzms=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4cfb5e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=57R0qBCtAAAA:8 a=EUspDBNiAAAA:8 a=-ILVhP4LZwuSKlsXNX4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=mR_gFduoMj4eUoa7Ntlv:22
X-Proofpoint-GUID: UE0FH6w5cm8jzH8N4Sdi6U_Jm0PYRqgy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXwvr15W79BkOx
 q8o8Wg1grTkTI6KkMlheXWhdr0UO6xvIemdLEq9RaRt60qEciOTQp0XpbIgv5FIPVKD1ce/DLgX
 9ps/n5D3Y24gjuYdj2QDP249ln4e9IdCXXHAUQcq0kxWmHKkWsndizqz/YUJSXScAw0xMZL5/pc
 7H4T315OQMm7O7/oHJsIlt6PLI3YX+dUjAonlZjA+x6wFyy/S/9dIJqliW5koUniSgu13JfP74f
 d4BPiCFlg7hNVjqznPCpWnjvK/I1B8DUAr2ZdjJEMGPsqE7WlMQH9plr7zxPjY23BSQj5rlC9Av
 ePNak5gnh7XPbAG3LUkj3zuTU6bQiYnfJwjknEsap+m6nQheX6UvDMns9ko8HHfEWx5va0vK7tF
 6zuWK8w4HKqQGiR7rtYGtDpcXiRY37isaV+04kmgUansPrP/v2Lzxx+mRlXDf3CSQNw3fCF59Nj
 EuS7muqVUtwb3usPiFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The vga state is needed by several functions using the blit context so
just include it in the context instead of passing it separately.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260619140408.6CF98596948@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/ati_2d.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 22dd811bd85..7a4a115aee2 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -45,6 +45,7 @@ static int ati_bpp_from_datatype(const ATIVGAState *s)
 }
 
 typedef struct {
+    VGACommonState *vga;
     int bpp;
     uint32_t rop3;
     bool host_data_active;
@@ -52,8 +53,6 @@ typedef struct {
     bool top_to_bottom;
     bool need_swap;
     uint32_t frgd_clr;
-    const uint8_t *palette;
-    const uint8_t *vram_end;
     QemuRect scissor;
 
     QemuRect dst;
@@ -66,8 +65,9 @@ typedef struct {
     const uint8_t *src_bits;
 } ATI2DCtx;
 
-static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
+static void ati_set_dirty(const ATI2DCtx *ctx)
 {
+    VGACommonState *vga = ctx->vga;
     DisplaySurface *ds = qemu_console_surface(vga->con);
     unsigned int bypp = ctx->bpp / 8;
     hwaddr dirty_start = ctx->dst_offset + ctx->dst.x * bypp +
@@ -94,8 +94,9 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
     }
 }
 
-static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
+static void setup_2d_blt_ctx(ATIVGAState *s, ATI2DCtx *ctx)
 {
+    ctx->vga = &s->vga;
     ctx->bpp = ati_bpp_from_datatype(s);
     ctx->rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
     ctx->host_data_active = s->host_data.active;
@@ -103,9 +104,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
     ctx->need_swap = (HOST_BIG_ENDIAN != s->vga.big_endian_fb);
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
-    ctx->palette = s->vga.palette;
     ctx->dst_offset = s->regs.dst_offset;
-    ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
 
     ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
     ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
@@ -153,10 +152,11 @@ static uint32_t make_filler(int bpp, uint32_t color)
     return color;
 }
 
-static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
+static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
 {
     QemuRect vis_src, vis_dst;
     unsigned int x, y, i, j, bypp = ctx->bpp / 8;
+    const uint8_t *vram_end = ctx->vga->vram_ptr + ctx->vga->vram_size;
 
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
@@ -167,9 +167,8 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         return false;
     }
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
-        ctx->dst_bits >= ctx->vram_end - bypp ||
-        ctx->dst_bits + ctx->dst.x * bypp + (ctx->dst.y + ctx->dst.height) *
-        ctx->dst_stride >= ctx->vram_end - bypp) {
+        ctx->dst_bits >= vram_end - bypp || ctx->dst_bits + ctx->dst.x * bypp +
+        (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= vram_end - bypp) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return false;
     }
@@ -206,9 +205,9 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         }
         if (!ctx->host_data_active &&
             (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
-            ctx->src_bits >= ctx->vram_end - bypp ||
+            ctx->src_bits >= vram_end - bypp ||
             ctx->src_bits + vis_src.x * bypp + (vis_src.y + vis_dst.height) *
-            ctx->src_stride >= ctx->vram_end - bypp)) {
+            ctx->src_stride >= vram_end - bypp)) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
         }
@@ -275,6 +274,7 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
     case ROP3_BLACKNESS:
     case ROP3_WHITENESS:
     {
+        const uint8_t *palette = ctx->vga->palette;
         uint32_t filler = 0;
 
         if (ctx->bpp == 24) {
@@ -286,14 +286,12 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             filler = make_filler(ctx->bpp, ctx->frgd_clr);
             break;
         case ROP3_BLACKNESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[0],
-                                                   ctx->palette[1],
-                                                   ctx->palette[2]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(palette[0], palette[1],
+                                                   palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[3],
-                                                   ctx->palette[4],
-                                                   ctx->palette[5]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(palette[3], palette[4],
+                                                   palette[5]);
             break;
         }
         DPRINTF("pixman_fill(%p, %ld, %d, %d, %d, %d, %d, %x)\n",
@@ -347,7 +345,7 @@ void ati_2d_blt(ATIVGAState *s)
     }
     setup_2d_blt_ctx(s, &ctx);
     if (ati_2d_do_blt(&ctx, s->use_pixman)) {
-        ati_set_dirty(&s->vga, &ctx);
+        ati_set_dirty(&ctx);
     }
 }
 
@@ -446,7 +444,7 @@ bool ati_host_data_flush(ATIVGAState *s)
         DPRINTF("blt %dpx span @ row: %d, col: %d to dst (%d,%d)\n",
                 pix_in_scanline, row, col, chunk.dst.x, chunk.dst.y);
         if (ati_2d_do_blt(&chunk, s->use_pixman)) {
-            ati_set_dirty(&s->vga, &chunk);
+            ati_set_dirty(&chunk);
         }
         idx += pix_in_scanline;
         col += pix_in_scanline;
-- 
2.53.0


