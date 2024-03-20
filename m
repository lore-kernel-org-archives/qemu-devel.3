Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7542AC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 04:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmnc2-0006ro-CF; Wed, 20 Mar 2024 00:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmnc0-0006rS-0f; Wed, 20 Mar 2024 00:31:36 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmnby-0003qf-Hk; Wed, 20 Mar 2024 00:31:35 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29ddfd859eeso4919004a91.1; 
 Tue, 19 Mar 2024 21:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710909092; x=1711513892; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T72dsARsFUwokdWrHWTAHyyAKs+ZzAavegmX3rwZfKI=;
 b=T5YpStlljYhXKrYlcL4MNwuY8R+sL8ENfcqxbH+Mu/ef8w5kRy0cEcC5+7CxePJSt4
 Nx4c5EPTiyfVYGaT7l8jmw8QhUv1TtBYj9WITijxLR+sTMXWDPWYjlj750vNMfNAkyzr
 AFIwlqPFzRVJ6Zd0AqzQgx523DKir/0b/rcuQPNV0vHuW+5EsQqwgUg3goRvdSXBP8gL
 Byp0xAYw+DvjaY3wcdEGBocVCbZ7IBQliK4GZUdzf2FVV8UNaE9cGkJGRfoOtevOpsES
 fmO/38og3ECVgI6DhD9VcQOQQkWdTmtlvciuLcxFQfnU9mGOyYnT+MaML4Hrs863Ll0s
 5iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710909092; x=1711513892;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T72dsARsFUwokdWrHWTAHyyAKs+ZzAavegmX3rwZfKI=;
 b=RwEC4OUgxDjpLVTmWv+PgElxP3g2IOTCJDV/agSYhXi5zIXOGV/iMXRaHOayAFZ7bo
 44rke/ASlJZhiz+Z0deUf+6AV+PzOP/cdBZOpFvAAnQq0b/s4KSoOO6DhNt8FBSCx82G
 9enfLLaf2m2zN3Q2kLjmCSDr6mlanZN01Ujf9hvxeGLKt7VQAXv/Puhwn2emOdtqU36F
 KVZSxDnn8DeuMD4X47kPm3nWUpYHD5rDKjnChfXHbbtUVK2SqxegSwIgaBOj5a/2UmQ5
 ezWBg+JPU9C44Bufax9C8Pqw/zSoXZsj8KIUOcs4BkzJGfmeefd3u819yEBQhAnVhwJ3
 F94g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtRtOxkXATf3PyHilZAUWZTCrcu77rS22KEbpPq0UzpqtZ11E1irdgmLW7FtfLwBDtfFd8ym2Cwqwv1vyiB5s1JtqIUw0SDwfzXWXznEcMSsLpkgGZf2fb5OY=
X-Gm-Message-State: AOJu0Yyio3qSSvKWroqq7ZDBJrDIN+K8Gdtb7ro3IZoajfJvjGgVba58
 8wXp09lUPmCnq31v7BU2wUbDm48vJgy8uhLBEuHZo3gA3QSNijZ8OYSEBKLfZsw=
X-Google-Smtp-Source: AGHT+IEHhMR4cZia2Y7kN6FDx+/eZDKTmBVv6zx2GuFeC3KlV7JDa2FgsE+UbrpCL7UZOXngVTsVTA==
X-Received: by 2002:a17:90a:cb92:b0:29f:b11f:8a85 with SMTP id
 a18-20020a17090acb9200b0029fb11f8a85mr1038718pju.35.1710909092169; 
 Tue, 19 Mar 2024 21:31:32 -0700 (PDT)
Received: from localhost (193-116-208-39.tpgi.com.au. [193.116.208.39])
 by smtp.gmail.com with ESMTPSA id
 eu16-20020a17090af95000b00299101c1341sm462973pjb.18.2024.03.19.21.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 21:31:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 14:31:27 +1000
Message-Id: <CZYANK3U3EOT.2S7V8APCPDKSS@wheely>
Subject: Re: [PATCH 1/2] target/ppc: Restore [H]DEXCR to 64-bits
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Benjamin Gray" <bgray@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240320015025.372056-1-bgray@linux.ibm.com>
In-Reply-To: <20240320015025.372056-1-bgray@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Mar 20, 2024 at 11:50 AM AEST, Benjamin Gray wrote:
> The DEXCR emulation was recently changed to a 32-bit register, possibly
> because it does have a 32-bit read-only view. It is a full 64-bit
> SPR though, so use the corresponding 64-bit write functions.
>

Thanks, paper bag for me.

> Fixes: c9de140c2171 ("target/ppc: Fix width of some 32-bit SPRs")

Should that hash be fbda88f7abdee?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> ---
>  target/ppc/cpu_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7e65f08147..22fdea093b 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5820,7 +5820,7 @@ static void register_power10_dexcr_sprs(CPUPPCState=
 *env)
>  {
>      spr_register(env, SPR_DEXCR, "DEXCR",
>              SPR_NOACCESS, SPR_NOACCESS,
> -            &spr_read_generic, &spr_write_generic32,
> +            &spr_read_generic, &spr_write_generic,
>              0);
> =20
>      spr_register(env, SPR_UDEXCR, "UDEXCR",
> @@ -5831,7 +5831,7 @@ static void register_power10_dexcr_sprs(CPUPPCState=
 *env)
>      spr_register_hv(env, SPR_HDEXCR, "HDEXCR",
>              SPR_NOACCESS, SPR_NOACCESS,
>              SPR_NOACCESS, SPR_NOACCESS,
> -            &spr_read_generic, &spr_write_generic32,
> +            &spr_read_generic, &spr_write_generic,
>              0);
> =20
>      spr_register(env, SPR_UHDEXCR, "UHDEXCR",


