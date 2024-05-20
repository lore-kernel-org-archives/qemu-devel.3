Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E841C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 07:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8xN2-0003GI-8g; Mon, 20 May 2024 03:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8xMM-0003CA-UE; Mon, 20 May 2024 03:23:03 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8xML-0005Ya-FA; Mon, 20 May 2024 03:23:02 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ed0abbf706so62952255ad.2; 
 Mon, 20 May 2024 00:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716189779; x=1716794579; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJnbX2mtdII7ODMq5CbLWOa7BrZExz71TQrzy2YaRI0=;
 b=ZD5jsBw/94WrEYpSQv5PMOxGFSCEBSOcU9yM7fP4lIV1ObGW18zsYj6zCL7RLGH8XO
 LmViXOTBWxyrH7pU2uE+eQaStDIKTUJJKK6ExhCIrCzBB1gBd+cYFi0ZF8GD4rSsmUvF
 2FXYGe5GaE8KfQLnc5heMdCD2LywMIJ8Z5uzFYNYuJHPc/7me5ftbQdIsF25ZzFKDrLJ
 4wXb/qyrTKEAPME7eqMV0mn9f98oer0UyWiIB4vKfwwtkEfQ27Czjaf/RhvhvuljdpBd
 2Cx3orx6HG8pMSqcUULZbN46bOd1qj06itahqU93DB5DqTz0jfrMvv/Xx3ZhUXn6hbl+
 YiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716189779; x=1716794579;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GJnbX2mtdII7ODMq5CbLWOa7BrZExz71TQrzy2YaRI0=;
 b=YaHqfUlkQxS3vepfI7rN6RppVesq81UOa+dDKKLkGwVdl4ZrJ/SlZfsHJ/XIBkq/oc
 kWo8Y7Qe42MMkdkNYqa9h5xsyfqowBFzvsV7XlyV65fRFpNedZpKs5GJcvvZ9V8UU/02
 vcD475CyLl+AMTMp0jmO8/SqNFbCtm7bUeuL2rp+stWP75+T4dnc/pDnl9tMlxolW7/m
 xFjVBhT1mKDbSb2aTU7wOz+6t9HmpJlKoxILfTMo4hFSK2K2gttCOipN9CLs/PfeVuSo
 Af+cA+u/GioV0tQmy49+HS/viHnZCkJl0Bf972bOlP1um39d5BYb781eWmDNTPRmeXcm
 2pgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6cLRNGEhQb+0wXvIZDx3DcVmZVtKAONRDqFtlEsm0MgcjqVc0I6U8HD8EuUvv2EXENCF7dGMyAhv6fYQ8H61zlIq9
X-Gm-Message-State: AOJu0Yx2MSAZ0tUKu6Ai21FZC696JzuOYM19PB8VgmhGsmnf+gs+zPhi
 eIeuJf8uwS+hX/WWMLbpD7gH6CcUVYYYUUmINK2sdkAGg1mquuG9
X-Google-Smtp-Source: AGHT+IG10skXJ14bY3OxPDUzbbE211uyi+h5kt6FmW46bUfJc/rywQenC390TRVLrpW41fXzqfLpkw==
X-Received: by 2002:a17:903:11d0:b0:1f0:9964:c35f with SMTP id
 d9443c01a7336-1f09964ce45mr147731095ad.26.1716189779594; 
 Mon, 20 May 2024 00:22:59 -0700 (PDT)
Received: from localhost ([1.146.114.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef49cf8d5csm179583935ad.95.2024.05.20.00.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 00:22:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 May 2024 17:22:54 +1000
Message-Id: <D1EAI24RN4GX.2MLW19HGNCJFQ@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Glenn Miles" <milesg@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/14] target/ppc: Implement attn instruction on BookS
 64-bit processors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240518093157.407144-1-npiggin@gmail.com>
 <20240518093157.407144-6-npiggin@gmail.com>
 <9e431f9a-10db-4fb2-b2b7-a4deeff5dfa5@linaro.org>
In-Reply-To: <9e431f9a-10db-4fb2-b2b7-a4deeff5dfa5@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat May 18, 2024 at 9:07 PM AEST, Richard Henderson wrote:
> On 5/18/24 11:31, Nicholas Piggin wrote:
> > +static void gen_attn(DisasContext *ctx)
> > +{
> > +#if defined(CONFIG_USER_ONLY)
> > +    GEN_PRIV(ctx);
> > +#else
> > +    gen_helper_attn(tcg_env);
> > +#endif
> > +}
>
> You forgot to check priv in system mode.
> Better as
>
>      GEN_PRIV(ctx);
> #ifndef CONFIG_USER_ONLY
>      gen_helper_attn(...)
> #endif

Good catch again.

I'm actually wrong there too, it should be treated as illegal
unless it is enabled with a system SPR, in which case it's
unprivileged (it can be inserted by external hardware debuggers
to stop the CPU and get notified).

Thanks,
Nick

