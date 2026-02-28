Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A650FEE4EE
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 17:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwOF6-0004Wi-4H; Sat, 28 Feb 2026 12:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vwOF4-0004UM-Fy
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 12:36:38 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vwOF2-0003bb-ON
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 12:36:38 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2C1765969FC;
 Sat, 28 Feb 2026 18:36:35 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id irCsp4ltkLua; Sat, 28 Feb 2026 18:36:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 161E95969F2; Sat, 28 Feb 2026 18:36:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 144405969E4;
 Sat, 28 Feb 2026 18:36:33 +0100 (CET)
Date: Sat, 28 Feb 2026 18:36:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v9 12/18] ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
In-Reply-To: <20260227203944.746471-13-chad@jablonski.xyz>
Message-ID: <94d3f9e9-458d-9a9c-6594-88a3da2daa0d@eik.bme.hu>
References: <20260227203944.746471-1-chad@jablonski.xyz>
 <20260227203944.746471-13-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-410397030-1772300193=:13605"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-410397030-1772300193=:13605
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 27 Feb 2026, Chad Jablonski wrote:
> setup_2d_blt_ctx is responsible for knowing how to retrieve the state
> needed by ati_2d_blt from the registers and assigning it to the ATI2DCtx.
> This will be useful in a future patch when HOST_DATA needs to make small
> modifications to the ctx.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> hw/display/ati_2d.c | 75 ++++++++++++++++++++++++---------------------
> 1 file changed, 40 insertions(+), 35 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index d43268ba5f..ebcec07334 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -25,7 +25,7 @@
>  * possible.
>  */
>
> -static int ati_bpp_from_datatype(ATIVGAState *s)
> +static int ati_bpp_from_datatype(const ATIVGAState *s)
> {
>     switch (s->regs.dp_datatype & 0xf) {
>     case 2:
> @@ -80,76 +80,81 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
>     }
> }
>
> -void ati_2d_blt(ATIVGAState *s)
> +static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
> {
> -    /* FIXME it is probably more complex than this and may need to be */
> -    /* rewritten but for now as a start just to get some output: */
> -    bool use_pixman_fill = s->use_pixman & BIT(0);
> -    bool use_pixman_blt = s->use_pixman & BIT(1);
> -    ATI2DCtx ctx_;
> -    ATI2DCtx *ctx = &ctx_;
> +    ctx->bpp = ati_bpp_from_datatype(s);
>     ctx->rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
>     ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
>     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
>     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
>     ctx->palette = s->vga.palette;
>     ctx->dst_offset = s->regs.dst_offset;
> +    ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
> +
>     ctx->dst.width = s->regs.dst_width;
>     ctx->dst.height = s->regs.dst_height;
>     ctx->dst.x = (ctx->left_to_right ?
>                  s->regs.dst_x : s->regs.dst_x + 1 - ctx->dst.width);
>     ctx->dst.y = (ctx->top_to_bottom ?
>                  s->regs.dst_y : s->regs.dst_y + 1 - ctx->dst.height);
> -    ctx->bpp = ati_bpp_from_datatype(s);
> +    ctx->dst_stride = s->regs.dst_pitch;
> +    ctx->dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +        ctx->dst_bits += s->regs.crtc_offset & 0x07ffffff;
> +        ctx->dst_stride *= ctx->bpp;
> +    }
> +
> +    ctx->src.x = (ctx->left_to_right ?
> +                 s->regs.src_x : s->regs.src_x + 1 - ctx->dst.width);
> +    ctx->src.y = (ctx->top_to_bottom ?
> +                 s->regs.src_y : s->regs.src_y + 1 - ctx->dst.height);
> +    ctx->src_stride = s->regs.src_pitch;
> +    ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +        ctx->src_bits += s->regs.crtc_offset & 0x07ffffff;
> +        ctx->src_stride *= ctx->bpp;
> +    }
> +    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
> +            s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
> +            ctx->src_stride, ctx->dst_stride, s->regs.default_pitch,
> +            ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
> +            ctx->dst.width, ctx->dst.height,
> +            (ctx->left_to_right ? '>' : '<'),
> +            (ctx->top_to_bottom ? 'v' : '^'));
> +}
> +
> +void ati_2d_blt(ATIVGAState *s)
> +{
> +    /* FIXME it is probably more complex than this and may need to be */
> +    /* rewritten but for now as a start just to get some output: */

I think we can drop this comment here, this series rewrites it enough to 
not be relevant any more.

Regards,
BALATON Zöltan

> +    bool use_pixman_fill = s->use_pixman & BIT(0);
> +    bool use_pixman_blt = s->use_pixman & BIT(1);
> +    ATI2DCtx ctx_;
> +    ATI2DCtx *ctx = &ctx_;
> +    setup_2d_blt_ctx(s, ctx);
>     if (!ctx->bpp) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
>         return;
>     }
> -    ctx->dst_stride = s->regs.dst_pitch;
>     if (!ctx->dst_stride) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
>         return;
>     }
> -    ctx->dst_bits = s->vga.vram_ptr + ctx->dst_offset;
> -
> -    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> -        ctx->dst_bits += s->regs.crtc_offset & 0x07ffffff;
> -        ctx->dst_stride *= ctx->bpp;
> -    }
>     int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
> -    ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
>     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff
>         || ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x
>          + (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
>         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>         return;
>     }
> -    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
> -            s->regs.src_offset, ctx->dst_offset, s->regs.default_offset,
> -            ctx->src_stride, ctx->dst_stride, s->regs.default_pitch,
> -            ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
> -            ctx->dst.width, ctx->dst.height,
> -            (ctx->left_to_right ? '>' : '<'),
> -            (ctx->top_to_bottom ? 'v' : '^'));
>     switch (ctx->rop3) {
>     case ROP3_SRCCOPY:
>     {
>         bool fallback = false;
> -        ctx->src.x = (ctx->left_to_right ?
> -                     s->regs.src_x : s->regs.src_x + 1 - ctx->dst.width);
> -        ctx->src.y = (ctx->top_to_bottom ?
> -                     s->regs.src_y : s->regs.src_y + 1 - ctx->dst.height);
> -        ctx->src_stride = s->regs.src_pitch;
>         if (!ctx->src_stride) {
>             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
>             return;
>         }
> -        ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
> -
> -        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> -            ctx->src_bits += s->regs.crtc_offset & 0x07ffffff;
> -            ctx->src_stride *= ctx->bpp;
> -        }
>         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
>         if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff
>             || ctx->src_bits >= ctx->vram_end
>
--3866299591-410397030-1772300193=:13605--

