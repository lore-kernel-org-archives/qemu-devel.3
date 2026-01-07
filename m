Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5728CD5858
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 11:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdRjX-00038c-0x; Wed, 07 Jan 2026 06:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <buenocalvachejoel@gmail.com>)
 id 1vdRjV-000387-OT
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:29:45 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <buenocalvachejoel@gmail.com>)
 id 1vdRjU-0002P9-0E
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:29:45 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-34f634a01e1so126711a91.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 03:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767785382; x=1768390182; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ra2VNP09MDv+TkpTI8FRcFKf7IxfmzJhhAYA1pL3Avc=;
 b=kpmhIQH9Zp6WQiW0avR5E1LzI6QBCXKdp8PWokR3WUncFfFIJJ6DYUzjNUqAiXWEAT
 mnoHmEPZM0vwTs7bnwcbvSrI9XGY4112MlXOU+ff0eHr0QLNDo9TN/ylmie6E9iOWMs8
 gAFJlyM5J1tzXP4wWKrFV7gcAK0yc1+y6rI/18qY0LJsKyxQAOAsKVO06iVBHbNBSz1q
 DzgB6h31qLQs3exIp/0/AwVhfce3Ghy/ZFcIQDpMO0w981/B5UDkqE8kZ0k1a/m4Xc4b
 aBxilmBQ41qZ/QmUj64OyKFunCdNfWd98ALNRTAFmQfe+u6PQ3hI6X3L4WxN/+CxKbNG
 RI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767785382; x=1768390182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ra2VNP09MDv+TkpTI8FRcFKf7IxfmzJhhAYA1pL3Avc=;
 b=YuV7v4KGZkU9EzSKeih+QRUANZuD+2jXxzgs9y1ahmOXktCyYgmoXXsntv6EvNKlxk
 EjFPqQXxErquoxlol7k+ATytieqT3DkEnVu7f92I4e80YEJ3iFO4otEoqt7rwHPMEZe5
 qnPrt6xY1vPZF5QsEPFgGon2lYpqlOHWlme5J7naaDGCHd95x/SPBHe/NLUowdxruTVr
 95FiabTVkwZh6JyQDhgR1XROoAGBcJUQwMINqEibwezV1ze13GX596RpjxeGgisyrZoe
 wF5IlOs3RbcbpbOer1TP1BYLxGjRBjWVZmKOAYRZCRJVZUSLhLyEk3K4UjGJoDhdEgbi
 wHBg==
X-Gm-Message-State: AOJu0Yx9LGuekrA4e7iE8h6D8NAynafmhPnl/uMaXZB3Q4anM0Dp/1LW
 SVcbth6/Rq0rdoWNez1DCF2eIxZegu2HfCwxdcXTCZbITPZ6ZCItvmHDyAY0SvZzi0LS3ZCKbHf
 Hog3OhM05dXUv9GgZNz004B3PZJu2tl8NBzu6nwA=
X-Gm-Gg: AY/fxX4INSmZ5HkqRhmhUNWcZc7Jt7UhvxWXdrockWD+M85CCksqZp9DuJf1mieRvDf
 xmmAqM33ugIwb9YMaTxuSywzD1+HSKLwqmF34jsaMy8EfyhLxMadN0a3Qgnt0B+a+/+Yox/2a3b
 3BMaAA7FuKC0yDWP1HSa0w+zFTd6+5RYmWUmF82TEYFnz7MCZZQpkktY7DYCxHMVMEAjDMAFbTp
 Lb1wqmEu+gPqDUfQxDQfkz2tZrp3DtTyomqrT2r9L+9Aj4M1DAWamHAIvW9Cy5FZ5AdWZVtAer+
 J9eGfpMB1NkCjKDIlJrmD99SKpRkKOm0uvScYtef
X-Google-Smtp-Source: AGHT+IE9aK5sis7NoZzjVjNVqGGYnuRXIdzm3oZI3dUDllbVlw7ef6pmk/Ee4m8e2yG0hV1JlT7A0bHdEYEgqFT7jvo=
X-Received: by 2002:a17:90a:fc46:b0:340:b8f2:250c with SMTP id
 98e67ed59e1d1-34f68b47b08mr1516549a91.1.1767785382003; Wed, 07 Jan 2026
 03:29:42 -0800 (PST)
MIME-Version: 1.0
References: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
In-Reply-To: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
From: Joel Bueno <buenocalvachejoel@gmail.com>
Date: Wed, 7 Jan 2026 12:29:31 +0100
X-Gm-Features: AQt7F2qR6rT7-6OMQrmy-quNF3S_-Tq5nZHVLxw0Jo_TxmWx2e_Tjs4P6QxDQ2o
Message-ID: <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
Subject: Re: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000bbc78c0647ca9b22"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=buenocalvachejoel@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000bbc78c0647ca9b22
Content-Type: text/plain; charset="UTF-8"

Is there any feedback on this patch series?

On Sun, Dec 21, 2025 at 11:53 Joel Bueno <buenocalvachejoel@gmail.com>
wrote:

> The Fast Read (0Bh) instruction requires 8 dummy clock cycles
> according to Winbond datasheets (e.g., W25Q256JV Section 8.2.12).
> However, the current code adds 8 to needed_bytes, which represents
> bytes, not clock cycles. Since 8 clock cycles equals 1 byte in SPI
> communication (1 bit per clock edge), this results in 64 dummy
> clock cycles instead of 8.
>
> Change the Winbond case to add 1 byte (8 clocks) instead of 8 bytes
> (64 clocks), matching the existing implementation for SST flash and
> the datasheet specifications.
>
> Signed-off-by: Joel Bueno <buenocalvachejoel@gmail.com>
> ---
>  hw/block/m25p80.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index a5336d92ff..21c2118b33 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -1001,7 +1001,7 @@ static void decode_fast_read_cmd(Flash *s)
>          s->needed_bytes += 1;
>          break;
>      case MAN_WINBOND:
> -        s->needed_bytes += 8;
> +        s->needed_bytes += 1;
>          break;
>      case MAN_NUMONYX:
>          s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
> --
> 2.51.0
>
>

--000000000000bbc78c0647ca9b22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Is there any feedback on this patch series?</div><div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Sun, Dec 21, 2025 at 11:53 Joel Bueno &lt;<a href=3D"mailto=
:buenocalvachejoel@gmail.com">buenocalvachejoel@gmail.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">The Fast Read (0Bh) instruction requi=
res 8 dummy clock cycles<br>
according to Winbond datasheets (e.g., W25Q256JV Section 8.2.12).<br>
However, the current code adds 8 to needed_bytes, which represents<br>
bytes, not clock cycles. Since 8 clock cycles equals 1 byte in SPI<br>
communication (1 bit per clock edge), this results in 64 dummy<br>
clock cycles instead of 8.<br>
<br>
Change the Winbond case to add 1 byte (8 clocks) instead of 8 bytes<br>
(64 clocks), matching the existing implementation for SST flash and<br>
the datasheet specifications.<br>
<br>
Signed-off-by: Joel Bueno &lt;<a href=3D"mailto:buenocalvachejoel@gmail.com=
" target=3D"_blank">buenocalvachejoel@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/block/m25p80.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c<br>
index a5336d92ff..21c2118b33 100644<br>
--- a/hw/block/m25p80.c<br>
+++ b/hw/block/m25p80.c<br>
@@ -1001,7 +1001,7 @@ static void decode_fast_read_cmd(Flash *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;needed_bytes +=3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case MAN_WINBOND:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needed_bytes +=3D 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needed_bytes +=3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case MAN_NUMONYX:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;needed_bytes +=3D numonyx_extract_c=
fg_num_dummies(s);<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--000000000000bbc78c0647ca9b22--

