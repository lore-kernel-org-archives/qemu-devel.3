Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB32FC54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjL-0005Oz-JT; Fri, 01 Mar 2024 23:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgDKo-00081I-Ii
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 19:34:38 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgDKm-000837-Vg
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 19:34:38 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso1682732b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 16:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709339675; x=1709944475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XpJrB5ct4rQ3tjBR5Uke9KdALSQm1ESN+KjjBjX/cQk=;
 b=K25FbGf4oR49YAYltzLaK4l2AYPGl+V9uut3eXX2XkOnmCBviBMDiBBsihBHzLw9z9
 tKbSHjlSDNFttT58hyuXMIxOb7FYKMzNAZ8L9Wqje5InfeyNoX89xPZbunWzC40Xcn2y
 inXdeRUoPpt1dwJWghcmegzCO1Hz5mZaS9CtX6rvAtYZPuq+T20haIxxxHWqJ04O0sUE
 UdjSIqBcgj/A7m57N+yW4avEZ0Z43bcpTs429EGlSRE06Ib5apL1cp9FnP+twzxgaI8i
 Laf8t4SWHZPcaPG0MOZ2R5c1i6xRb62tnD1Iz2pUcU9GH/VKtFzOu5ELyU0jCdvQzqA3
 8tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709339675; x=1709944475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XpJrB5ct4rQ3tjBR5Uke9KdALSQm1ESN+KjjBjX/cQk=;
 b=HkmYww+Foq+o9PVikIcAZf+n4/T5oJ+4LwiEVyXfgnTO/f6tCgW+YAckLwo7AGgojm
 gm6fLbXvPxwg8pCSCInvnV/inSCiaPRJQPmwfXDoBNuIs5pzSHV8H9z6Y7MubJ7c0EMq
 u2tE0oI7veZO17Xm3qW0zR3ii7PZFicKFCVtIC0/jG5OwsxaUq6aGuINadOYIm8Xmj0q
 lX5yJ9csNvexEnvHvjOkbnIzPdIlvi+m4GCfxLMxClENb+lqpOPM0kif38/v1GCXMPS8
 /leKaHs3eLGvcr/Buo6KlRhToevLivfEAY0GnkUsQ+3f3A+2kXx2fYxIYefCvEELrWKC
 cjRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa0F2zglgoAEIzFj0AY84Gu2M0DtMX2kF55oZp7OcApKhGfzY+o6nXjNg29c28af37C2nv4ywGxSxUsNsegendSd3e5OQ=
X-Gm-Message-State: AOJu0YxPr0RdaE/UrsNSOFJi48WujQHx3YQokkVSygD/VafefQD6Q8gq
 6iRBDv9rHEIG15yuwqm56G0ngkVF1hG7m1QoqJvzwIGa2b5NbeSojx/7bYLMa2vLijGp6wf4RoN
 R
X-Google-Smtp-Source: AGHT+IFuPmtaEfSj+wgq7r1nZlhiVF9BPMes8QxWAkL1NGRL3ltI4paUyqbdLzp/MG+JknUlxZQHWw==
X-Received: by 2002:a17:902:be03:b0:1dc:297d:b621 with SMTP id
 r3-20020a170902be0300b001dc297db621mr3253128pls.16.1709339675028; 
 Fri, 01 Mar 2024 16:34:35 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 cp12-20020a170902e78c00b001dcfaab3457sm144942plb.104.2024.03.01.16.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 16:34:34 -0800 (PST)
Message-ID: <cd9ed599-3bac-4353-8513-2a125701bd17@linaro.org>
Date: Fri, 1 Mar 2024 14:34:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add FIFREEZE and FITHAW ioctls
To: Michael Vogt <michael.vogt@gmail.com>, qemu-devel@nongnu.org
References: <20240220105726.8852-1-michael.vogt@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220105726.8852-1-michael.vogt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/20/24 00:57, Michael Vogt wrote:
> Add missing FIFREEZE and FITHAW ioctls.
> 
> Signed-off-by: Michael Vogt <michael.vogt@gmail.com>
> ---
>   linux-user/ioctls.h       | 6 ++++++
>   linux-user/syscall_defs.h | 3 +++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 071f7ca253..1aec9d5836 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -134,6 +134,12 @@
>        IOCTL(FICLONE, IOC_W, TYPE_INT)
>        IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))
>   #endif
> +#ifdef FIFREEZE
> +     IOCTL(FIFREEZE, IOC_W | IOC_R, TYPE_INT)
> +#endif
> +#ifdef FITHAW
> +     IOCTL(FITHAW, IOC_W | IOC_R, TYPE_INT)
> +#endif

I suspect these are old enough that they should be unconditionally available.
However, quite a lot of the ioctls here are in the same boat, and it's not worth quibbling.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied to lu-next.


r~

