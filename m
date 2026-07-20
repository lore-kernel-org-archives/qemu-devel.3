Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D339C44527
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlkxf-0007jo-Fg; Mon, 20 Jul 2026 06:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlkxe-0007jY-IU
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:10:58 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlkxd-0005Zz-1G
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:10:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so1913310f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784542255; x=1785147055; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OVGBUEeGZFo1W42u0kpF0dOOfKXrEoxpF7TLf/LckLI=;
 b=K1o7aQPP3EOAxmICYPyCZ0GgBOsFpP+N4xRXxdKP37ZhYPt01FnthtIgnMctettJjH
 DAmYPYUi1C4nyD7tgG8lwXRgCXENn0PCIQ4QWJZmmVKQ6fVrM3Baut6WO9t2/c2B0GGf
 E5fnHfEXs4FFdjnh50nKKkovWMCENlThAjiydVhn2nx8h36gsVwvgdUzbOX9d8bzUeaY
 LakD89JH653wYVu4T9hVyPd04C4x6hUuSV3AOfUjcmWYCzB6ntu1g4/jD5MleOXBBqkL
 tCHlO3j+0pyySVkvGs8B9amTRNybpcb3XJlMWVpxUaHtg0QYGTLPYommipTsOhjaCw7x
 RJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784542255; x=1785147055;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OVGBUEeGZFo1W42u0kpF0dOOfKXrEoxpF7TLf/LckLI=;
 b=CW60JMpOhEXBkImYXGZw6e82XHLw1QbwGu2Vumbk6Ibi5rrSMEww2BmTqVXCE6/S3p
 3CkY2AgkD+A9+ILDOpIgVe1QCocVLHTFSEPwcxEZY5iVHLfXYgOBMnGlLaiY54UIiH4x
 b2EKwrJnkG5tUc3bHyPnioEtuiTqtKH/3sXsNEJ+dKNFYs4++Ftzh0DLAuL+sko1FoSO
 ZYw7IkE4aynKJBGAG9EXSuaUu/j8gbfIR93Uxg8xYB5GZS7O8TwRsJ3ByR5ZB5TQrkTu
 mgfpua/e1kVV1SnF7ifooWUzutBxROL3bpwFRUPV5wv18a60ybPF/s3SthSP7vdy0xAt
 a2wQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFyUZ42uElYFRJCEbOtrjmnl10b6S5gzj48PL65hACbkBLnXtlQX8DLUK/YSVR9hebXInk7UYRnHif@nongnu.org
X-Gm-Message-State: AOJu0YwmOHP9VXDDauogkK8RezwUFsGTHvBi/hGIdQa3pJeBhp1NMilW
 WE//PK93mdQ9Ezzh41HaJ/8I1C5d6Tgec+cc8j6AE5Sc47i3N3SiBp//TDMLC6ibdRE=
X-Gm-Gg: AfdE7ckObecoHlhwiJXX8ltyLG3PNafdhanhIrXtH6t/ovQ/N1Yi6W0ab/U3CDXR28Y
 HeSeOjdNEsAhrud5WqJrkJ6MwO121CNLablcpBvgtrGAXS+eQIUKolf6Ta4inMgovHYZGwfmSRx
 8KV6WXGpDvOOBqa1x7aOyXJbN8xYq6YcaDpLMCLzH5TwRXF+1VZEcdXZEVE/ZLVNLyTKSKtAgw/
 moHoW4qvZ5nBvAH3HhwKdoBEuIK812qGKYc78dSSxGLPn26tH4bX8bHbMytRZjcDkhBuPLD2Za+
 OJikXJdxLBaPY1xh+5koy7SwrvmM8sYXVZXyKu3ZA/9QLcu9UaUAMiQgvXxataZEN/EUxmiahh6
 2Zp2WdZpUpvkuMWI49k+u7B35JcpVR2EDit6OloCAExkoGwQpjAqaRQuP3CbpbY0hIlGU1zyzvJ
 8lRA==
X-Received: by 2002:a05:600c:4f0e:b0:495:4f84:7280 with SMTP id
 5b1f17b1804b1-4954f847354mr118124475e9.4.1784542255037; 
 Mon, 20 Jul 2026 03:10:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49562709500sm34499205e9.14.2026.07.20.03.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 03:10:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5214D5F911;
 Mon, 20 Jul 2026 11:10:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Jim MacArthur
 <jim.macarthur@linaro.org>
Subject: Re: [PATCH 2/9] hw/dma/soc_dma: Simplify soc_dma_ch_update()
In-Reply-To: <20260710105907.2570621-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 10 Jul 2026 11:59:00 +0100")
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
 <20260710105907.2570621-3-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Mon, 20 Jul 2026 11:10:53 +0100
Message-ID: <8733xet1hu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> Now we only have "mem" and "other" as soc_dma_port_type values, we
> can simplify soc_dma_ch_update(): either both src and dst are mem, in
> which case we use transfer_mem2mem and set update to 1 to tell
> omap_dma_transfer_setup() to update all the guest-visible
> src/dest/count information to indicate a completed transfer; or else
> we use the omap_dma_transfer_generic() function, and we set update to
> 0 to tell omap_dma_transfer_setup() that the transfer function will
> be updating the src/dest/count.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/dma/soc_dma.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
> index 8ba531feea..ff51338388 100644
> --- a/hw/dma/soc_dma.c
> +++ b/hw/dma/soc_dma.c
> @@ -121,19 +121,14 @@ void soc_dma_ch_update(struct soc_dma_ch_s *ch)
>      enum soc_dma_port_type src, dst;
>=20=20
>      src =3D soc_dma_ch_update_type(ch, 0);
> -    if (src =3D=3D soc_dma_port_other) {
> +    dst =3D soc_dma_ch_update_type(ch, 1);
> +    if (src =3D=3D soc_dma_port_other || dst =3D=3D soc_dma_port_other) {
>          ch->update =3D 0;
>          ch->transfer_fn =3D ch->dma->transfer_fn;
> -        return;
> -    }
> -    dst =3D soc_dma_ch_update_type(ch, 1);
> -
> -    if (src =3D=3D soc_dma_port_mem && dst =3D=3D soc_dma_port_mem)
> +    } else {
> +        ch->update =3D 1;
>          ch->transfer_fn =3D transfer_mem2mem;
> -    else
> -        ch->transfer_fn =3D ch->dma->transfer_fn;
> -
> -    ch->update =3D (dst !=3D soc_dma_port_other);
> +    }
>  }

heh the diff is messy and the soc_dma_ch_update_type could do with some
clean-up but for this patch:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>=20=20
>  static void soc_dma_ch_freq_update(struct dma_s *s)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

