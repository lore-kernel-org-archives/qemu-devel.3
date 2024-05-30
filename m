Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5CEC27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCflD-0001Ny-49; Thu, 30 May 2024 09:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCflB-0001NF-94
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:24:01 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfl9-0000Mh-EL
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:24:00 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63a96so535444a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075436; x=1717680236; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J/MBztJN6ThOSFG8xXp37+4/Hcus86L7wVDlYwV/IH4=;
 b=vYyiccZVfhbj0V4JgairAvKV8wV6QNyCOqFqHol//eKKkVe1bvK97k7xrj116jX1cA
 SHxeFFJMizMpbaLuySRxZ2LSTPVFxFvMj9KVfbdRasFKJqpCnNgBpE978UOEXij9kd+W
 idYjvp2b8IALj6NrWwXSv1KHhv63La2SZnRC8hjAR6s1z813cpqQV52eYPYbjdQpyIBq
 P8ytD5WvU+jm3EY/QkYtttL7zuVQq9Az3b1jMKwZdWkZcfWsUsdbxdJg/sy88YVtjODu
 UbVRgdA4FksfkgqooddlObKqVtWBtWatxNUFpmv3zXNaqMYimdY3XObudflufbmKIjru
 n7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075436; x=1717680236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J/MBztJN6ThOSFG8xXp37+4/Hcus86L7wVDlYwV/IH4=;
 b=LQ+FXsFg+Mg8z48sAOnb8ZNbuU0h/sbD9koUXdFhy0JmnpsY6sA/QZx7Fk+XO+uh/0
 djLbSwDB21GS8b4FF96t9fsrT8ehbAD4V2jMQ3dvr/pDkISHvW5wp6oIzxyn8BVf+Szh
 tLHkimjxHv2P3m7kH6fgHkvxLL0mwKT5P/l9KrFZaECeQ/1Haqy6Lu2ZJ2IBg82uWxX/
 WRTLV3TmbEr8aecSPS9DJboQ0Euv1YTpFL2Bk+ETDsKIA1y5sL5lOWkxg7wqBEX+bPcJ
 QaHf6uvE07i4OlzHzBeHJg3jtfO3iqWTrt+CtI7ujWY8+o1FB+elnP5aSiKxXk12CzlM
 YAdg==
X-Gm-Message-State: AOJu0YyVvg50NYTRo7WMQcZiQERkkb7abF5cwBSoHh2MS4ddeWnXXmQr
 7DzglA/H0d4u9oPGpgSjQr+zLIkWcLLn3/kcoNN7x4Krdbst/YI/PpbVsolNaJRglq++pA7uuOW
 hVzKr8aCuKgcAUA1+L5yICD8hTYpy5eSKe5hqKg==
X-Google-Smtp-Source: AGHT+IGwPC8mGB87lwnTNW9WPMsQOb+jLpVgSC8cdd6NyN/eDCCNlsKFElcL6aX0RU2lUCYxLYhW9id6O6Jcxp6JbK4=
X-Received: by 2002:a50:cc0c:0:b0:57a:212a:a21b with SMTP id
 4fb4d7f45d1cf-57a212aa2e3mr1160298a12.7.1717075435680; Thu, 30 May 2024
 06:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-7-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:23:44 +0100
Message-ID: <CAFEAcA-5QQjbJN=JS5MQvL9405eJRsuo1myaAXfN_7p9Lemx9g@mail.gmail.com>
Subject: Re: [PATCH RISU v2 06/13] risugen: Add sparc64 support
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sun, 26 May 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  risugen            |  10 +-
>  risugen_common.pm  |  50 +++++-
>  risugen_sparc64.pm | 385 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 443 insertions(+), 2 deletions(-)
>  create mode 100644 risugen_sparc64.pm

I'm not super-enthusiastic about making running risugen now
require an appropriate cross-toolchain for the target.
Since almost all of what risugen is doing is "write
these exact values to the test binary" we don't really
need an assembler to do that.

At any rate, an explanation in the commit message of the
advantages of doing it this way would be helpful in
deciding, I think.

> +sub open_asm($)
> +{
> +    my ($basename) = @_;
> +    my $fname = $basename . ".s";
> +    open(ASM, ">", $fname) or die "can't open $fname: $!";
> +    select ASM;

I think that using Perl select like this is liable to be
rather confusing, because it has "action at a distance"
effects on every other print statement. I would prefer it
if we passed in the filehandle to the print statements
explicitly. (We can use a global if handing the filehandle
around to all the functions is annoying.)

> +}
> +

> +sub gen_one_insn($)

(One day we should see if we can move most of gen_one_insn and
write_test_code to common code, because an awful lot of these
functions is identical across architectures. But that day
doesn't need to be today :-))

-- PMM

