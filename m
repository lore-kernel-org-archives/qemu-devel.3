Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037AFC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEnao-0005JK-62; Tue, 13 May 2025 07:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEnam-0005JC-Iy
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:14:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEnak-0006SW-JH
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:14:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so63194125e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747134873; x=1747739673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84dCeypP7NHvHY71PW84LFsdDpsiAsS4J6CFVx9jUoI=;
 b=LRR6npcsG+oETSVQLN6Vb0K8GhfuT3rJNxe0KI6kA8HPC6oza10fJrByApr2usKKig
 deE6O+62R559avR4xMB0ToiNQO+Eam5yzubCCrkGVjS0QCjh0Edxoi0z7n75093UxtRR
 EUJHhezok9nxLVE07C+9EVQ7bzL7DNm3YiIIHTvQi4Wprf2mdWLquVB2HCXrois4SkQJ
 vvHOd6QMNRXbFaweB6jidNAESpaeRgZQfw7eUtaWpkt73DmsWsxh+87Zuruj5bT02yS/
 TYwU6j2z8stnOvQwqIEwkMO4VxkWOwACR+fRmfQxBsYuq4amLZtrq6v+w2nEQxFIQRrE
 FkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134873; x=1747739673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84dCeypP7NHvHY71PW84LFsdDpsiAsS4J6CFVx9jUoI=;
 b=HFmb2e3QvIkQau0yDszVw1p/Re9b/CmBDdysopqALAWy/7JRU9KPaapMY7QajTeo2e
 015KhndXeUieoU4MnBVz5LopdXs6/Lg+wQ3EQgsuGA9PZ7kDwIvlAV/U6jbSeOoczIG7
 kx0az+pPirO+EvdfKz4c7GxDTDnBox8kZ++v+3Z55yCFfqupRDigrBidCZc0PZxbtpvy
 4FcjtVWhbQrieB1dMelg6VcsOMeuqwzoupX+fZy1KkScRNpbIFfIfoDLeAybuW7XAnSD
 srhzrAJfVji99tocugXbZ0Lz+fKrbTuoDcUIsqaaz+k/zikabWvjL8vxUpS0Yo+jtd/l
 i0aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqfCcmFHsjpr/kDHIlNN6wXCNK6nC9lNni6Ib2EAlzEjIOD5NmAnAxbdqQAyij3Q/7lawwLu4VqxRf@nongnu.org
X-Gm-Message-State: AOJu0YxT1fzXlM7SBWCOvKTYM9GAucnaqxRQhZ2y56WmUeGe3UQHV27I
 QbSRDFhjCKdVZQ5OBaJpiypGLvYTrya8vPO5nWrpAsKvW14+FXQbKxwfRykTf61Eji1JBUnNNcj
 dHvzSeMfa
X-Gm-Gg: ASbGncuoFdpVkhppfmRIg/iIa3aT0g7XMrAwqZxOtUp69BcaRO/v7rPTjFNz7jRS/Qb
 2RFdNzPhMbp3Xxo/92AvuWMxq03I/9E6WogtoDtEJikSAIIeoQ5/BJeg8Zd6QCPw2WbskbQkwJ/
 ReGSre4vfvBkOkk2Il57cxSDlregpLLHn/dLmKaMvVDlSwmgQd3b02aVnl5H9jH2v+1lPKHkgM+
 O+7t5nwD7+8l1cZI5RnLbmssgr8X6q9+Ey7nzzioMoUKy8w2baN9PlaQnrr3Tc/NBCGzSLn1JJj
 K03iQDK4rrEfNzcuY6QuoZJE6sUgfUaPkAl0ihSwoKNkPwEAb+/RmyUihqajCOHCQZZEfWYol2e
 4zTBuwkwUrYjB
X-Google-Smtp-Source: AGHT+IGGWyMeHJwkha/TU3oYySfCXdQFkgwYvCZfWqU1cOTC711T8NsKj8GGMQkJRp73zvYHCw0BEw==
X-Received: by 2002:a05:600c:5299:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-442d6d44960mr157200505e9.14.1747134872726; 
 Tue, 13 May 2025 04:14:32 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ebd6fe86sm17308025e9.0.2025.05.13.04.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 04:14:32 -0700 (PDT)
Message-ID: <12efedf5-3cea-49ff-aef0-f5da851b14ed@linaro.org>
Date: Tue, 13 May 2025 12:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ui/vnc: take account of client byte order in pixman
 format
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250513100819.1179249-1-berrange@redhat.com>
 <20250513100819.1179249-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250513100819.1179249-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/5/25 12:08, Daniel P. Berrangé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The set_pixel_conversion() method is responsible for determining whether
> the VNC client pixel format matches the server format, and thus whether
> we can use the fast path "copy" impl for sending pixels, or must use
> the generic impl with bit swizzling.
> 
> The VNC server format is set at build time to VNC_SERVER_FB_FORMAT,
> which corresponds to PIXMAN_x8r8g8b8.
> 
> The qemu_pixman_get_format() method is then responsible for converting
> the VNC pixel format into a pixman format.
> 
> The VNC client pixel shifts are relative to the associated endianness.
> 
> The pixman formats are always relative to the host native endianness.
> 
> The qemu_pixman_get_format() method does not take into account the
> VNC client endianness, and is thus returning a pixman format that is
> only valid with the host endianness matches that of the VNC client.
> 
> This has been broken since pixman was introduced to the VNC server:
> 
>    commit 9f64916da20eea67121d544698676295bbb105a7
>    Author: Gerd Hoffmann <kraxel@redhat.com>
>    Date:   Wed Oct 10 13:29:43 2012 +0200
> 
>      pixman/vnc: use pixman images in vnc.
> 
> The flaw can be demonstrated using the Tigervnc client by using
> 
>     vncviewer -AutoSelect=0 -PreferredEncoding=raw server:display
> 
> connecting from a LE client to a QEMU on a BE server, or the
> reverse.
> 
> The bug was masked, however, because almost all VNC clients will
> advertize support for the "tight" encoding and the QEMU VNC server
> will prefer "tight" if advertized.
> 
> The tight_pack24 method is responsible for taking a set of pixels
> which have already been converted into client endianness and then
> repacking them into the TPIXEL format which the RFB spec defines
> as
> 
>    "TPIXEL is only 3 bytes long, where the first byte is the
>     red component, the second byte is the green component,
>     and the third byte is the blue component of the pixel
>     color value"
> 
> IOW, the TPIXEL format is fixed on the wire, regardless of what
> the VNC client declare as its endianness.
> 
> Since the VNC pixel encoding code was failing to honour the endian
> flag of the client, the tight_pack24 method was always operating
> on data in native endianness. Its impl cancelled out the VNC pixel
> encoding bug.
> 
> With the VNC pixel encoding code now fixed, the tight_pack24 method
> needs to take into account that it is operating on data in client
> endianness, not native endianness. It thus may need to invert the
> pixel shifts.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/ui/qemu-pixman.h |  4 ++--
>   ui/qemu-pixman.c         | 15 ++++++++-------
>   ui/vnc-enc-tight.c       |  2 +-
>   ui/vnc.c                 |  3 ++-
>   4 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
> index 193bc046d1..2ca0ed7029 100644
> --- a/include/ui/qemu-pixman.h
> +++ b/include/ui/qemu-pixman.h
> @@ -75,12 +75,12 @@ PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format);
>   pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_endian);
>   pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format);
>   uint32_t qemu_pixman_to_drm_format(pixman_format_code_t pixman);
> -int qemu_pixman_get_type(int rshift, int gshift, int bshift);
> +int qemu_pixman_get_type(int rshift, int gshift, int bshift, int endian);

Too bad there is no GLib enum. Maybe name 'g_endian'?

>   bool qemu_pixman_check_format(DisplayChangeListener *dcl,
>                                 pixman_format_code_t format);
>   
>   #ifdef CONFIG_PIXMAN
> -pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf);
> +pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf, int endian);

(Ditto)

>   pixman_image_t *qemu_pixman_linebuf_create(pixman_format_code_t format,
>                                              int width);
>   void qemu_pixman_linebuf_fill(pixman_image_t *linebuf, pixman_image_t *fb,
> diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
> index 6ef4376f4e..9ca420ff78 100644
> --- a/ui/qemu-pixman.c
> +++ b/ui/qemu-pixman.c
> @@ -126,33 +126,34 @@ uint32_t qemu_pixman_to_drm_format(pixman_format_code_t pixman_format)
>       return 0;
>   }
>   
> -int qemu_pixman_get_type(int rshift, int gshift, int bshift)
> +int qemu_pixman_get_type(int rshift, int gshift, int bshift, int endian)
>   {
>       int type = PIXMAN_TYPE_OTHER;
> +    bool native = (endian == G_BYTE_ORDER);

Preferably "native_endian" like in qemu_default_pixman_format().

>   
>       if (rshift > gshift && gshift > bshift) {
>           if (bshift == 0) {
> -            type = PIXMAN_TYPE_ARGB;
> +            type = native ? PIXMAN_TYPE_ARGB : PIXMAN_TYPE_BGRA;
>           } else {
> -            type = PIXMAN_TYPE_RGBA;
> +            type = native ? PIXMAN_TYPE_RGBA : PIXMAN_TYPE_ABGR;
>           }
>       } else if (rshift < gshift && gshift < bshift) {
>           if (rshift == 0) {
> -            type = PIXMAN_TYPE_ABGR;
> +            type = native ? PIXMAN_TYPE_ABGR : PIXMAN_TYPE_RGBA;
>           } else {
> -            type = PIXMAN_TYPE_BGRA;
> +            type = native ? PIXMAN_TYPE_BGRA : PIXMAN_TYPE_ARGB;
>           }
>       }
>       return type;
>   }
>   
>   #ifdef CONFIG_PIXMAN
> -pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf)
> +pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf, int endian)
>   {
>       pixman_format_code_t format;
>       int type;
>   
> -    type = qemu_pixman_get_type(pf->rshift, pf->gshift, pf->bshift);
> +    type = qemu_pixman_get_type(pf->rshift, pf->gshift, pf->bshift, endian);
>       format = PIXMAN_FORMAT(pf->bits_per_pixel, type,
>                              pf->abits, pf->rbits, pf->gbits, pf->bbits);
>       if (!pixman_format_supported_source(format)) {
> diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
> index f51f618e46..c6e8d71d4f 100644
> --- a/ui/vnc-enc-tight.c
> +++ b/ui/vnc-enc-tight.c
> @@ -891,7 +891,7 @@ static void tight_pack24(VncState *vs, uint8_t *buf, size_t count, size_t *ret)
>   
>       buf8 = buf;
>   
> -    if (1 /* FIXME */) {
> +    if (vs->client_bo == G_BYTE_ORDER) {

More explicit as:

   bool native_endian = (vs->client_endian == G_BYTE_ORDER);
   if (native_endian) {

>           rshift = vs->client_pf.rshift;
>           gshift = vs->client_pf.gshift;
>           bshift = vs->client_pf.bshift;
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 2c640d8be4..c0b8ad9cc1 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2240,7 +2240,8 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
>   
>   static void set_pixel_conversion(VncState *vs)
>   {
> -    pixman_format_code_t fmt = qemu_pixman_get_format(&vs->client_pf);
> +    pixman_format_code_t fmt = qemu_pixman_get_format(&vs->client_pf,
> +                                                      vs->client_bo);
>   
>       if (fmt == VNC_SERVER_FB_FORMAT) {
>           vs->write_pixels = vnc_write_pixels_copy;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


