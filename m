Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268D4C2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 09:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJrNq-0002mQ-1W; Wed, 19 Jun 2024 05:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJrNo-0002m6-3y
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:13:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJrNm-0003No-Ii
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:13:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42278f3aea4so56148785e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718788412; x=1719393212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eLK3g93NTMrJNRZcmoVhRsBAbfba74cZvVdhjZXLXnQ=;
 b=o/upzZuL91b9brxxRySvHBERBl5uD3XNLv6FpcIwTDCfp1wCBjMPpY+LaN+E59TdZ5
 H3oDNr0evKlWdSEySlL8jeTfehbbOCF9TqDJ3rEabFnqRh7LnxPygu5oASnAjRye+RHy
 3HVgt93U1dMg77sxAf/OR5GXbaXmRPhDE+e/bB16XAnoOVu37BesxK9UKwuWvCgYnccr
 gxtTw35iYjhRBL5VlwkeI42x8iMC2e7h+bFEUoVQkBmwYRj+wEsqDzLELcJqKqhSQTSy
 YGPUVf2RUgxcSjSC8GUaDGz2xkYD77e0+NgBgtnkuAT+ZwXv7HcYPFZnRKSShU3uqbuM
 mG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718788412; x=1719393212;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLK3g93NTMrJNRZcmoVhRsBAbfba74cZvVdhjZXLXnQ=;
 b=Ja/jFueE2Od2Mz98HozTts6Ws7BYT1/vSqFePJpyicL8dVwQE76q7ZJggA54b1aRq6
 lc3njpylvTBFDkPmeohG9IaNdmZWUKt0j5zzSYWviC2k1YtHm9LIbY0391skfcGF0OUf
 KUyHL91sHlxewZ3b1mLXQpQLeEdxPegnhLYHbqDhj9oNF+z//Vy/OirGSP4R6PM8BKqc
 0JqNTBsf1El66aJDjAmS3hLppONVYEWTQRwUmtgzD1Vai0mgTdP//uUpf20gJAUQ6pz8
 BW/uGNwHfVPB6Or5nh/7+FDtJo/q9iJfrFtuN7SW7uY6UiqLTnkPlDKUe6I/EGzM/Ffj
 w+sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7KHDatKiC6HxIFJAYsggS5F+wLtpz2czjpF7ceO6877F4V4+/oktg6n8/M2FxLM7C4bIGlJc13+cvKyLE34k3xeoqiII=
X-Gm-Message-State: AOJu0YxxeFFmGxQ1IvRnE+fvLjYLf7WWHmFgZgO3KErQebjXKwvM9CdW
 HLInTOGdsiU2hIybPxn1JimxkxcKhAilTY4FQL7iQbD93GHOyfjfm69XgEFxxj4=
X-Google-Smtp-Source: AGHT+IHqVlVIMn/rRgrcurpbXtSUOdtqzsTIK8PiNAV82htIMjSMlD3N19/zxG6IY/e2o8/08yw2uA==
X-Received: by 2002:a05:600c:214c:b0:422:6e65:a4bb with SMTP id
 5b1f17b1804b1-4247507a10cmr11529995e9.5.1718788412506; 
 Wed, 19 Jun 2024 02:13:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eef70csm261627325e9.3.2024.06.19.02.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 02:13:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 856105F919;
 Wed, 19 Jun 2024 10:13:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nabih Estefan <nabihestefan@google.com>
Cc: peter.maydell@linaro.org,  qemu-devel@nongnu.org,  kfting@nuvoton.com,
 wuhaotsh@google.com,  jasowang@redhat.org
Subject: Re: [PATCH] hw/net: Fix Coverity Issue for npcm-gmac
In-Reply-To: <20240618172527.3450098-1-nabihestefan@google.com> (Nabih
 Estefan's message of "Tue, 18 Jun 2024 17:25:27 +0000")
References: <20240618172527.3450098-1-nabihestefan@google.com>
Date: Wed, 19 Jun 2024 10:13:27 +0100
Message-ID: <87o77xcn2g.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Nabih Estefan <nabihestefan@google.com> writes:

> There is an extra `buf=3D` set that is not used by npcm-gmac. Remove it
> for coverity to be happy.

Have you go the coverity reference to include in the commit message?

>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  hw/net/npcm_gmac.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
> index 1b71e2526e..b397fd5064 100644
> --- a/hw/net/npcm_gmac.c
> +++ b/hw/net/npcm_gmac.c
> @@ -614,7 +614,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *=
gmac)
>              net_checksum_calculate(tx_send_buffer, length, csum);
>              qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer, =
length);
>              trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, le=
ngth);
> -            buf =3D tx_send_buffer;

So coverity is saying that buf starts at tx_send_buffer and none of the
other legs that can mess with it are possible for the tx_desc.tdes1 &
TX_DESC_TDES1_LAST_SEG_MASK leg?

Or that buf should always start at tx_send_buffer and only ever advance
if we grow the size of the tx_send_buffer?


>              length =3D 0;
>          }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

