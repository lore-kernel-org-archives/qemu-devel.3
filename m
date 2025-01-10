Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAF0E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEDi-0005VF-VZ; Fri, 10 Jan 2025 07:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEDf-0005Ui-Au
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:34:32 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEDd-0006iu-NO
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:34:31 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so2987960276.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736512468; x=1737117268; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3x9LW72fIXku6a+jEamZTn0B9GuFfWKBRcYWlgMfvA4=;
 b=J31yfREILOk/SaND69WavQXYnLP25pSTj2JxOTV2n173anMZQzwVAlwGAT4z9PE/WT
 4zGC9HeDL01e6jgLY8nx5jVsz4yEq+F4wgatrT9b7qdU3V2B1Bw0Q/OQ0VIR31WVmuam
 jgBk3QtumVSQpq3eajJk4/k68eCJ9RrGnZfYI76nC8eSex8Dj28KlVgvFSqNVCBONRek
 PiVeEj51OmUzHjM3ecnzEQIHzPCyxiWGanl5hLiIDNX2wpnH5fJxnEkfiLgneN7vrsu2
 gJetyIGUvSbBK6jKV97eOxxUANf/aHMjRY078QMNXasIABnY4nPC1irzSIKL8cKyYHFS
 OjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736512468; x=1737117268;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3x9LW72fIXku6a+jEamZTn0B9GuFfWKBRcYWlgMfvA4=;
 b=cdq5gSEfmRH9CjkXlv2OBbkL84YKA+9/KWNb+v9AeYhNalfL8nr9PvPNJkReKRvpeZ
 luTpN7YZzRDCHd9hiW4Qfz53TOSyMTkWSHhrpF6DPQkpRWRwsiuabew9FYASSRdDI6tz
 rHddtcfZJ+Z4w70Mv4iDj5A9CJhYGBHx0jbzwrHr3H/0rSpuOOyegWU/I957keU7AAAu
 7EgOCHGje2tI2tagSlX6pS8Ox2004D4dmz+TLek0ofpyIF+Ywiwuu1pgFayebDsAGE0m
 XWHUHJv1ebqgkyceJbIBmRzEiH3IXl+6Yfm3rTH2jRDAqtCC/Eebv69lMzhn1cXpXkBh
 BQvQ==
X-Gm-Message-State: AOJu0YwktkP41WKYI2YbUTEXhKyEntAjRhVxwIvjzU56/mx4JpRnG4sI
 D+f08bv57SlPSZmaqLTC8dZDwHuNLYcskKtRNHvGIa5wP4Uk044QToldLAtGbYHqGrSjsN28F6d
 c9ALUNtQHzYeioem/DVWu61aHDJwgai1f++qrKx1gQZ9std6y5DM=
X-Gm-Gg: ASbGnctWcB+9crMW2TE3RQKhNQcq0x/q1hCChEGBxIMD4LhkctVWXENK1+/YrCEZkBE
 dtuiweCn+hDmadjgozhnXeXzll4tfGqR4ELbwuQ0=
X-Google-Smtp-Source: AGHT+IEXSBM+5OzVqP1ICHLIj2OyhzoetnZlrEo27/uetto/FfotAriFPN/8VXIWuqXYpIj/GkBowlLqAigQicw/1hY=
X-Received: by 2002:a05:690c:9c0f:b0:6ef:641a:2a7b with SMTP id
 00721157ae682-6f5312068abmr95015617b3.2.1736512467762; Fri, 10 Jan 2025
 04:34:27 -0800 (PST)
MIME-Version: 1.0
References: <CAOYM0N1sbP=xRfNPaNK6ZzzhD3A-5PKimaeSrDzXHGxAYH3oCQ@mail.gmail.com>
In-Reply-To: <CAOYM0N1sbP=xRfNPaNK6ZzzhD3A-5PKimaeSrDzXHGxAYH3oCQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 12:34:16 +0000
X-Gm-Features: AbW1kvYrWPojJYDSk39ggWzPxGG7WmwQlbLCWQrBb3VDWp1W6f1TtOmVjqC7cr8
Message-ID: <CAFEAcA-jc3jC2ovUrpzhwc+etJxKL4490uUb+akrWn+7=0X-9g@mail.gmail.com>
Subject: Re: macaddr: ignore the checking from index to 0xFF
To: Liu Jaloo <liu.jaloo@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 24 Dec 2024 at 03:27, Liu Jaloo <liu.jaloo@gmail.com> wrote:
>
> bash-5.1$ git diff net/net.c
> diff --git a/net/net.c b/net/net.c
> index c1bb19a523..af68029428 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -173,6 +173,7 @@ static void qemu_macaddr_set_used(MACAddr *macaddr)
>      for (index = 0x56; index < 0xFF; index++) {
>          if (macaddr->a[5] == index) {
>              mac_table[index]++;
> +           return;
>          }
>      }
>  }
> @@ -188,6 +189,7 @@ static void qemu_macaddr_set_free(MACAddr *macaddr)
>      for (index = 0x56; index < 0xFF; index++) {
>          if (macaddr->a[5] == index) {
>              mac_table[index]--;
> +           return;
>          }
>      }
>  }

Hi; thanks for this patch. Unfortunately we can't accept it
without a Signed-off-by: line from you (which tells us that you're
OK for it to be contributed to QEMU under our usual license:
for more details see:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line

Could you also provide a commit message explaining the reason
for the change?

(The code changes themselves seem sensible; I would use "break" rather
than "return", personally, but the effect is the same.)

thanks
-- PMM

