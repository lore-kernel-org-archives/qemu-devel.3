Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA6606A336
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c6482Brx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdIb-0008LC-VO; Wed, 21 Oct 2026 16:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xJdIW-0008J3-R7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:52:32 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xJdIV-0007aN-3R
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:52:32 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c4203bbb1e9so165730866b.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792615949; x=1793220749; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FQrt5kldsyRp7tVdq9tqAn592qt1PHD/jU6EhzeN8zY=;
 b=c6482BrxP3Xx2zBakwqlyha7qYECyA68uHHMQwhBDjqv4pZd7+gE5RkCZVzNb3sLzw
 YXYvEVJnD2zAR/Imu0EyHm4Xxyxl2hxXmSr+aD4/d+Hzxs0Przla74e1uZreVwr/g4k9
 QfTubfK02xfyUD+DG/n+l9/JuS0dDY/OD1spNlJFFqoYwXVdpPr3Seo+1q89EqOrO7MZ
 Ep1C7V2/ZIQ+kI7fOTViNX4oGV+qFgY3wWeUfCVVoOArViBAn0bkqwPuPqIbXFqyQruq
 P/uqYQUI8cUxGFoYu1GVKq0g1VaQQ7aepe7TizoPQxlVy9OPlM1tDr+2Bfr60faysFw0
 yJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615949; x=1793220749;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FQrt5kldsyRp7tVdq9tqAn592qt1PHD/jU6EhzeN8zY=;
 b=vgdi46rdj9kkdV2eyyarRtfEELXkA3nXg3Mh18fqUi+adoLfjOFjnLfHA8AfxLf5jp
 ihmqfBzlem5kMm2AOEpZneVowYqBkbN9lfiubb+hD7RgkqjNVS2ohBfMInXtq5TKQeap
 uJGxmlIO35C8NZRwy9gmUfDncmy5D1rYMX+APEPbiQs30pDqX32fbnQw/YQ0DJ+L87kQ
 /t3sYgXJK/D3YqjTeM0OyvR3IkaLG/58NGgqt60EaUdbiEuu4Qlk1NxAS7YyKvmbodJT
 HcAW+MCejRahax64b2vu/7YTbZIyjQtrkLeWtEueuE7+LUll3DMsRvuEhKoWrJ969K3b
 rz4w==
X-Gm-Message-State: AFq9FYKuaTwWT6QR6uYhKcVWyajbPT1mOthti/R9qvEwb7Myz3hKvWib
 G5mFUyrBu6iNV+W2Q6/Ih6z4u/zVdzjq3Tv7SxU+MV9wXbe/4SFv9bii
X-Gm-Gg: AYBFou0t2QDfB9w7752lZFmCNmwcYwF6XQu58vaffx/mHc/89GkzjY9G0KEPT9TsiTv
 pnmuLUpxAbStcPRf63r3Mwe5X0ay/PRd0iEbLiWTemmBL6p7m1f92F92Bg/wTxJ3rgJ67bKMXGH
 LSI9Ya1aeEWpHaSdC97RINl6gZBAe8LkGvJ/84WnwWSDLv9hQ0vJdcDjksx2iHy3caioVUowMiY
 NjD80TPmsxC/V/5Pdx5q3dKkt2jUuT+4lx7cAUl3HyMbgNfJb5vRRASqN74GIJIXjH4jTnHXQQz
 sv8z3oex30cjHM14zWOHYGq1eslupefppBZw065SqT2a6hHxVILD97CZ/mDGNPA5vKQNEXCWlXj
 oXcCmNAGAjHqMXrYcxy90wglw1ScsVo/06btrplMNGfUFglSl+6kAKjcNytdU+UN94YpRILtb0n
 juLKEzu15btKmbplVaR+JkI61mcFowk7pWOHZrVTK7A+JjVBIQErgxqJ0Op2SblnbdgKZUqkryQ
 4Y+6HDSSmf2rJQkjNXRkuZpSeMvWXuj5EUsZ7y1qFARI2OVSTEbUO2gOJBFlc2ssTYTZq6gNKOV
 oTyFNieGE6WSdVK9KAd8
X-Received: by 2002:a17:907:d489:b0:c45:c030:732c with SMTP id
 a640c23a62f3a-c467970065amr325046366b.41.1792615948966; 
 Wed, 21 Oct 2026 13:52:28 -0700 (PDT)
Received: from localhost (broadband-77-37-216-184.ip.moscow.rt.ru.
 [77.37.216.184]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a5dd548sm36448766b.65.2026.10.21.13.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:52:28 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:52:27 +0300
From: Alexander Epaneshnikov <aarnaarn2@gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille
Message-ID: <atkl1urA-NmtipAA@alex-pc>
References: <atNoDNz0dQucxzFN@alex-pc> <atNo9sk_7jCAi98u@end>
 <atPIRr46KvMoiCti@alex-pc> <atTzTVaSxUy5r95x@end>
 <atUU4HpVVI59QcLJ@alex-pc> <atUZr1LP8k5b78I8@end>
 <atUfTcaPUHqBQdno@alex-pc> <atUwxiof87wlNm83@end>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atUwxiof87wlNm83@end>
User-Agent: NeoMutt/20260616-dirty
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=aarnaarn2@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 18, 2026 at 10:49:10PM +0200, Samuel Thibault wrote:
> Re,
>
> Alexander Epaneshnikov, le dim. 18 oct. 2026 22:35:58 +0300, a ecrit:
> > On Sun, Oct 18, 2026 at 09:10:39PM +0200, Samuel Thibault wrote:
> > > Does the device sends the cell count first or the device identity
> > > first?
> >
> > I don't know for sure, as I don't have a real Baum display; mine is a
> > HumanWare Brailliant, which uses its own protocol. The comment in
> > NVDA's driver lists them as "device id, serial number and number of
> > cells", so the identity seems to come first, but that is the only hint
> > I have. BRLTTY's Baum driver doesn't use 0x15 at all, it asks for each
> > of them explicitly.
> >
> > NVDA itself doesn't depend on the order: it stores the cell count and
> > the identity separately as they arrive and continues once it has both.
> > I tested sending the identity first and then the cell count, and NVDA
> > detected the display.
>
> Ok, could you check the attached patch?

Thank you. This patch indeed fixes NVDA detection of emulated braille display.

> Thanks,
> Samuel

> diff --git a/chardev/baum.c b/chardev/baum.c
> index 166d6f2f09..db0a4fff75 100644
> --- a/chardev/baum.c
> +++ b/chardev/baum.c
> @@ -97,6 +97,7 @@ struct BaumChardev {
>      brlapi_fileDescriptor brlapi_fd;
>      unsigned int x, y;
>      bool deferred_init;
> +    bool protocol_on;
>
>      uint8_t in_buf[BUF_SIZE];
>      uint8_t in_buf_used;
> @@ -337,13 +338,27 @@ static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int len)
>      }
>  }
>
> +static void baum_send_cell_count(BaumChardev *baum)
> +{
> +    uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
> +    baum_write_packet(baum, cell_count, sizeof(cell_count));
> +}
> +
> +static void baum_send_device_identity(BaumChardev *baum)
> +{
> +    uint8_t identity[17] = { BAUM_RSP_DeviceIdentity,
> +        'B','a','u','m',' ','V','a','r','i','o' };
> +    identity[11] = '0' + baum->x / 10;
> +    identity[12] = '0' + baum->x % 10;
> +    baum_write_packet(baum, identity, sizeof(identity));
> +}
> +
>  /* Called when the other end seems to have a wrong idea of our display size */
>  static void baum_cellCount_timer_cb(void *opaque)
>  {
>      BaumChardev *baum = BAUM_CHARDEV(opaque);
> -    uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
>      DPRINTF("Timeout waiting for DisplayData, sending cell count\n");
> -    baum_write_packet(baum, cell_count, sizeof(cell_count));
> +    baum_send_cell_count(baum);
>  }
>
>  /* Try to interpret a whole incoming packet */
> @@ -441,17 +456,18 @@ static int baum_eat_packet(BaumChardev *baum, const uint8_t *buf, int len)
>          uint8_t protocol;
>          DPRINTF("SetProtocol\n");
>          EAT(protocol);
> -        /* ignore */
> +        if (!baum->protocol_on && protocol) {
> +            /* Switching on, answer with device identity and cell count */
> +            baum_send_device_identity(baum);
> +            baum_send_cell_count(baum);
> +        }
> +        baum->protocol_on = protocol;
>          break;
>      }
>      case BAUM_REQ_GetDeviceIdentity:
>      {
> -        uint8_t identity[17] = { BAUM_RSP_DeviceIdentity,
> -            'B','a','u','m',' ','V','a','r','i','o' };
>          DPRINTF("GetDeviceIdentity\n");
> -        identity[11] = '0' + baum->x / 10;
> -        identity[12] = '0' + baum->x % 10;
> -        baum_write_packet(baum, identity, sizeof(identity));
> +        baum_send_device_identity(baum);
>          break;
>      }
>      case BAUM_REQ_GetVersionNumber:


--
Sincerely, Alexander

