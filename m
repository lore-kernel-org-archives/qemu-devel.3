Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6642606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=plOdV3IG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQlEc-0001kz-Ae; Tue, 10 Nov 2026 07:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQlEU-0001jb-26
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:45:50 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQlER-0007jb-8T
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:45:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so20508715e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 04:45:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794314745; cv=none;
 d=google.com; s=arc-20260327;
 b=lVUyn5qFbY+xjgGb+zCTfclg88EbgMZJGgSsVWnG6DoHw0wybvBZ+jFSxnxKfdL66K
 uBg7F6dtzwpkZdACktiF3fqMGijxdEx6uRhVpY78PY6cg4co2iAnVXNx5/YdapjujOLX
 oSS2KPS4edAWQbjMEEnzxHISKWwJ3TYZRw6h+UPRD3w/HDdbFBsafhFQCSlBJeRhF1pD
 0jfAkgUujVaiRa207GbYyof/U1+dNgdIJ9/BQdGWb9kaD9xUV/lhwZqQvCBBVSZVzj3a
 Rv5BOE1s19j3Q1oINL0AbEl3nYEqVf09YrlIpOznNnXNNJus9e/COUNjDJUHgSgiLnp4
 jSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5s+/k+G1Xcl4RUUlLM+neJOVV7++JiO4RxsU/4bPuaM=;
 fh=6Ljc6nMZvz6gk11eSifo2Zp/x/qA0SqgpGVCyOs8MbY=;
 b=QdqZ54bXTOfwUcjgczCiwYNyWs3vBDrCpvVkKBMz8UpjUPNNLnPzaRGH8RUc4brqHj
 HCsbJyfZa3oD9WHNTPZH5842Yl5ksyYE5+GmDdD9F3SDVvdZuLmIpnnFyztAQqgnUz0a
 huKs0sZOmDOvGkvabfJmiOzKbcA6aKlnbRX14u1sfh/Axuui6H6V/E2qJVaC4oRqXZ4U
 IDutxPO7V6Fh/2UZ2fHxAHJ+iSl04mfW1sQmBwvqgkPhNGuWTZgv+VF/yJTzxE2AAjTm
 p7/N84ANNGgfieOTSeZLEiaztE0t7o/Bc47xFyL7soDpau2zCfiZ0ADTF4bxzdE9YSjt
 7yag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794314745; x=1794919545; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5s+/k+G1Xcl4RUUlLM+neJOVV7++JiO4RxsU/4bPuaM=;
 b=plOdV3IGOu1/p22hGuUVKovdpgQY4Lu8wBtWKXGZlZ8q3D+71pVTrLsfIAYP46EfmD
 K2xHFjkL13kr1CWmId/N5m1xdoi6zOk7eJPRA5iY8+dKjJEUQyT0+YB8RZ7kdLGaZGs8
 ddrHucYUUpmWFpduO+jSHTXJKU00CKs3R5/f9AQuwiCZi2mdu5SryTR+MBrizkXnZ1VE
 Nl2QMG2aiDcnZF39Pggg13YfnEhtmmsx8WbuLT81jdtULablNkGH6js/floFWhkOTUkw
 4X57l/KeWPYLNzaDQQaVEPuv7hi3McfzcoTybFYFPyBxm1Flsf3b0n/ZLs+IM+Cr51JO
 uqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314745; x=1794919545;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5s+/k+G1Xcl4RUUlLM+neJOVV7++JiO4RxsU/4bPuaM=;
 b=DFPnwJLM9QR9frrP/L8TLiGNLbYuBByhThYF+qzah/T3RqAvSVV2udLZ6EydM82FBQ
 08G6/pbQoQ6oq1EZ86IWdTtscewkNbiCn4uxdj/8QJwzRPCP+wwZn4hb9Schkm9qYOcH
 snqtu0l1LmKgXI+8fFJyYJkoz5FMAbIAyBQbKdK1JXKN4fv922FeAr0ZG1I3ajMC9OYg
 SSbDYba5S2uGT5owl4ZusDJfEXUzSNHLopXlUhBR6L79I6r/ZfCfFCdwioqAO8J0iy+x
 6IZxoNulHwcFZkLkHtwF4GVzNX8GG+moHCGNjhCsqNkSgJWhpH8l1a6sBfRRbj8GDukL
 snkQ==
X-Gm-Message-State: APuU4Z+X/507JxY2a8plqB+sqkAUuRQXp5PFpxyqUwo7T+vwQmMQX9cP
 14J0vb4pBQlp30MOBR6iiBWYy/6C9shYocBzC7KR8tZPPbKPyDS96aNs71RPzVL4MOF2eQ2Zmwu
 EGGQjucLnH9ADoz9Bh/sw+mbwPygvSCLR128vgj+Sl4DF6InM/i7e67w=
X-Gm-Gg: AYBFou0hS76zzU1s7hcLVc8D9coSng6SfNUb9oEsK73yHTIDHZBpuyR8cV27UytK/6Q
 N+6y/p/OhEHuZPWnGDvxd6xpA7xch0DQxrOvJT+T8mvzNO8OdF3zdWjrGMbqM3gauKV09lZVWUK
 0OolJLnlWEMjxRcoj6FqfyPDCM8m4rtxbWoQdT44WoYkEF7Le8fYvtt3/tNS55GO6KgqarnEqpP
 glXT0fwIbrNO/nj6kxntQiZvP+L6KEqLE+nIaX1Uxu1yyMZbc0aaLapmGmhX4yVIK3ZiiplScwc
 vUvC3P0u1lsO39mnqk2HGWYGunkRyjdUl6Up93tiJMn+QPgPpp9FeZ0/8PXOpT9gNenW25dKRr4
 gO9qZ6I3f0SfzT9gZSpBC8Doyr0yQemZqFik/d+hzXIoD5S3nbbb2RfLZA7Kf1PcqUXEvi9ucOE
 vJSdI1dl2ooUmiq4jdGbxK09ipQvOxMFgfFxX5bgy3nMXIcA7pklGeOYQ/UHncy7EVvX5uBOFG2
 AeqM5A11XAPBW8jsQ==
X-Received: by 2002:a05:600d:82c9:b0:4ba:a5:b920 with SMTP id
 5b1f17b1804b1-4ba0234950bmr52318795e9.16.1794314744560; Tue, 10 Nov 2026
 04:45:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
 <20261110-virtio-snd-fixes-v1-4-544d6f9eca38@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v1-4-544d6f9eca38@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 14:45:18 +0200
X-Gm-Features: AclHuK93q1Lr06zsVzbAqod-WgcRFCdWck3lf924c7uJylJpCddVBe8rjmJsi_Q
Message-ID: <CAAjaMXZSsuHO61Jis-6+VQO5b71e+jfp3wgmWcydjDeH275f0g@mail.gmail.com>
Subject: Re: [PATCH 4/6] virtio-snd: don't allocate pcm_info zero-count buf
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 12:31=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> g_new0() might return NULL, which is UB if passed to a memcpy
> implementation that does not expect it (not in the usual case).
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3778
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/audio/virtio-snd.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 8695a4651b..a7d749f24f 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -267,6 +267,11 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *=
s,
>          return;
>      }
>
> +    if (count =3D=3D 0) {
> +        cmd->payload_size =3D 0;
> +        cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_OK);
> +        return;
> +    }
>      pcm_info =3D g_new0(virtio_snd_pcm_info, count);
>      for (uint32_t i =3D 0; i < count; i++) {
>          stream_id =3D i + start_id;
> @@ -352,15 +357,16 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>      }
>      if ((le32_to_cpu(params->features) & ~(stream->info.features)) > 0) =
{
> -         error_report("%s: invalid stream features. "
> -                 "Stream %d offers 0x%"PRIx32", "
> -                 "guest requested 0x%"PRIx32
> -                 " (invalid: 0x%"PRIx32")",
> -                 VIRTIO_DEVICE(s)->name, stream_id,
> -                 stream->info.features,
> -                 le32_to_cpu(params->features),
> -                 le32_to_cpu(params->features) & ~(stream->info.features=
));
> -         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +        error_report("%s: invalid stream features. "
> +                     "Stream %d offers 0x%"PRIx32", "
> +                     "guest requested 0x%"PRIx32
> +                     " (invalid: 0x%"PRIx32")",
> +                     VIRTIO_DEVICE(s)->name, stream_id,
> +                     stream->info.features,
> +                     le32_to_cpu(params->features),
> +                     le32_to_cpu(params->features)
> +                     & ~(stream->info.features));
> +        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);

Squashed the fixup to the wrong commit... sent a v2 fixing this.

>      }
>
>      st_params =3D virtio_snd_pcm_get_params(s, stream_id);
>
> --
> 2.56.0
>

