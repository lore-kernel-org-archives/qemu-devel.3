Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2A606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=g7AbcToi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT1Xg-0005Jt-9x; Mon, 16 Nov 2026 13:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xT1XZ-0005JC-48
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:34:53 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xT1XW-0002A8-Mn
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:34:52 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b0d126f631so34530997b3.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 10:34:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794854087; cv=none;
 d=google.com; s=arc-20260327;
 b=kNMRPZL8lndPiJ7TtuiQAoIp94XM0zrgQ3FjEV9QY0by5kQY2eOwm+WhQVKApX3gne
 lST++LzFnJOVnuCA8lzf6tkOQng3qMAPb4qDsl5EqDcR9gI0PH9fnMCyDM53HCJjna0z
 0mP6lUPSUhwEAMt9zlq5y793CsVmJ8U9Ca67iTgscFY1413/DDz7NU4+N+0jGT6lP5NQ
 8Tk+uviKy4mt0KIEuP+aOL7yD224P5jm+UakVCE/n/T5vGdUYlusMEeoRcLJglAje5TE
 uD2rvxvHO4ir2H7lD1mD/IZXnMOcKf5u0OQSk4JRpCHpYyMAOHACvjYMKHHDubenk4qO
 F3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VuTuxQfl5NArYExShj36N8I527uWdtoSUOxSKrWFzYs=;
 fh=TUtDHcpMQL4Nds+5uYqWwB9npkUmkuEQ3GJWKeG/QEU=;
 b=GZMHViWf5ZnlDuwaz8kZdxbhhjzKarCeDIl6yRkkVbqaN2Zj0SNPbqA8i70bJO8+gp
 2093IReID3sUaGQfTqUanfufPsf4RSAfAAeLwQPzpSiatNu7FNIqu++NNeUBISyVvljG
 lGr1lOUEay25xo28Slv5IRwQif3TJ8kJ84xWF9VAqFDZbQ/ES4ZyLTd2akWMA3fGj81t
 NNWkpUpAob9eRPrPmNThYrgHTgiZH6BO8/OshxW+fEMlWD9ZLfDCNoET9OaHmrrM9oLQ
 xX/tvY15nmQ1KEtXnDZ4zOCtyaoU30OPYzQpQ3Ru6YPecVuW87xElBuFgrc4eOGrnePS
 Endw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794854087; x=1795458887; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VuTuxQfl5NArYExShj36N8I527uWdtoSUOxSKrWFzYs=;
 b=g7AbcToilqV7JIyGrjIEPyQqEMKVxZ8eRb2yb7WXXA3xO9sis7MhQkrBF5yxhenJIN
 VqDNywG5ER8URT02RS+Pu5aWI6HZ8p63feWcHxfPcDZMBcQnl9PcvEgVVZ6u3DoZuE+F
 OtxmO/sf2exhqmlbGL6X6kZ0Z+oJJ22loJu3XwAU0CvHwcR7HA0yBbeGt296hF+Cta3a
 8noZiSkDdug8FpXw717FkhgKmDnlC77qQUG2IlYgq/6J7MXG6jVub9aDepTNQ0IdI/DO
 8/4anPSrhRqlIfXjJ58h0PgwYjQ9r5KmQC2ZilIG/CGW8HeZw6gkVtx2i7nW2q4yavqA
 XYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854087; x=1795458887;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VuTuxQfl5NArYExShj36N8I527uWdtoSUOxSKrWFzYs=;
 b=naA7wzeaHUGpnfqfgzmC1xPLKLYlAEDscwI1BAJJcEv5psZHnLnNgiSqKdWu6+Qh/P
 q1+jB4fI8InHcJnFFaYnG7QDkMTEor+I4ZdH4e77DrVYEcswGqKkJifu11gBgExzVktx
 68Ua9KjFO0s2F70srxHlj58m47jAKHBxag0MWgXMZsNtc6nZZk7tVSyDKD46Be0AaJty
 nJyZUWAteiqhdr6lbz+kDrr9K7gQLmqCf19FSXf9yJBwKWdwB64zAli3FrJJyjC1yhLU
 n+KAhI6WB6TAfBb2w4w7iaHxHFMXJVNda8ypskOfTw99HbKlvPRC5m6v3ozTcGV08mVb
 nT4g==
X-Gm-Message-State: APuU4Z+ldXBnbXH+RmcALo+AGubqP7ibULQsrEYbzldgSL4kHBWBNjF8
 ORu/kYW33xiouUz8TlAAoGvopuYl3FnvSKkUI/+jGr5ArUobL4q1OsvnSDTXeESm4nGuvtrysj5
 Ibi/oeuLGOd5wynlEwnN1y+XSD/w68OE=
X-Gm-Gg: AZFdTZfg1KV9aJ5fiSZJyqS+zSUSwdj2c82pvC81kibMKIyAvvlQM51z+D+wdvLc3SK
 PvAPR/qW3EU2UdMSh64kAuEXSrGc3vqCf1Xa2p0kr8A1Y67dSQDvQuA6Kby8M1ZToSpyhrvK7WN
 ztU1MIXdgoYLvBn0VeMfCl1b/rw/peeJEyGwxFr3gngMSMKm/sDQHeGn1NA1THcbRkKDcPL9nkp
 q5tybXeyZbe79bICemDTco0bmU0dw/bZdiueaKTOxXPPMq5JxSLqUnpKyoemb/1Cj7TUGv88ouL
 TH445DSjLxYnWE39pSkyyMZOhALqnLZIX/DzFtYiOTelysuWjObdqzqlMiDmZNE71JNPq12Ycxl
 rrlF84v1hB+vCJVbEvh4DjJcvEWzKPyVJ34qUJAfixFg/noRKUs2JL4keIBECZxHF5One
X-Received: by 2002:a05:690c:6d84:b0:8b4:e258:3dd with SMTP id
 00721157ae682-8b4e2581868mr12219647b3.9.1794854086591; Mon, 16 Nov 2026
 10:34:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116155409.300888-1-chris.bainbridge@canonical.com>
In-Reply-To: <20261116155409.300888-1-chris.bainbridge@canonical.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Nov 2026 22:34:33 +0400
X-Gm-Features: Aa3M54o_gPgHAXAKDcKnmyc00hB6dXZCaeGPPGnl3mN7vI9hOzY_FH3MzAdVRfU
Message-ID: <CAJ+F1CJ+mbTpCTKqz_eLRUD2DcknXTM2WjF42ash0F-uYfnY4g@mail.gmail.com>
Subject: Re: [PATCH] ui: fix screendump PPM corruption when the width is not
 4-aligned
To: Chris Bainbridge <chris.bainbridge@canonical.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 8:11=E2=80=AFPM Chris Bainbridge
<chris.bainbridge@canonical.com> wrote:
>
> ppm_save() writes pixman_image_get_stride(linebuf) bytes per row, but
> the P6 header declares the image as width x height, i.e. width * 3
> bytes per row for the PIXMAN_BE_r8g8b8 line buffer.
>
> pixman rounds scanlines up to 32-bit boundaries, so the line buffer's
> stride is 4 * DIV_ROUND_UP(width * 3, 4), which is larger than
> width * 3 whenever (width * 3) % 4 !=3D 0.  Every row then carries up to
> 3 extra padding bytes that PPM consumers do not expect: readers which
> trust the header see progressively misaligned pixels (a diagonally
> sheared image, with the row padding interpreted as pixel data), and
> the file ends up height * (stride - width * 3) bytes larger than the
> header describes.
>
> All standard display widths are multiples of 4 (and so is their
> width * 3), which has kept the artifact invisible for years; any
> non-aligned width triggers it.  Example: after a VNC client requests a
> desktop resize to a non-aligned size (SetDesktopSize), or with
> -device virtio-vga,edid=3Don,xres=3D1050, the screendump of a healthy
> guest is diagonally sheared at the correct resolution, while every
> other display path (e.g. VNC) shows the correct image.
>
> Write exactly width * 3 bytes per row, matching the header.  The PNG
> path is unaffected: it uses the same padded r8g8b8 line buffer, but
> png_write_row() only consumes the width * 3 bytes described by the
> IHDR.
>
> Verification: on QEMU 10.2.1 with virtio-vga and a 1050-pixel-wide
> scanout, stock screendump emits a sheared PPM whose size exceeds the
> header by height * (stride - width * 3); with this patch the PPM is
> exactly header + width * 3 * height bytes and renders identically to
> the PNG screendump.  scripts/checkpatch.pl reports 0 errors, 0
> warnings.
>
> Fixes: b12f32c408ef ("pixman: switch screendump function.")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Chris Bainbridge <chris.bainbridge@canonical.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/ui-qmp-cmds.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
> index 753cc2bf52..64027da2c0 100644
> --- a/ui/ui-qmp-cmds.c
> +++ b/ui/ui-qmp-cmds.c
> @@ -309,9 +309,10 @@ static bool ppm_save(int fd, pixman_image_t *image, =
Error **errp)
>      linebuf =3D qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
>      for (y =3D 0; y < height; y++) {
>          qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
> +        /* Write width * 3 bytes, not the 4-byte-aligned linebuf stride =
*/
>          if (qio_channel_write_all(QIO_CHANNEL(ioc),
>                                    (char *)pixman_image_get_data(linebuf)=
,
> -                                  pixman_image_get_stride(linebuf), errp=
) < 0) {
> +                                  width * 3, errp) < 0) {
>              return false;
>          }
>      }
> --
> 2.53.0
>
>

