Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C20606A332
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X775BE9q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVSHw-0004Bl-6P; Mon, 23 Nov 2026 06:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSHE-00046L-CX
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:32:15 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSHC-0004Bu-27
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:32:03 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67da62357acso4001355d50.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 03:31:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795433518; cv=none;
 d=google.com; s=arc-20260327;
 b=o3QZJrZG3FKN7RHtfes5XcN7qGIUp+0XhqVEvniIpQm9T3oA1Z1+5T6i9zllApIjKt
 0cKTe/yIf5gifpzDiuPCRgHOaFHB4p0k/8VWTjBw7QIbOuyPspUHSJ9jWdKU5M4fpwxP
 iFrulOFMgPfOcKm5RAYwtB/Jg1sfihKTo+B5sI0CLC9cNiWmFkamtJ4jHA3T95mpZ1u8
 KNYk/CaOG6o0bviHqmYVUWux/93men9zMGaClWGtyxghTk8hZ/NT1383pBwoGmrqTdB0
 s4JtH7xaT8Mup0d2ihjzLN/NysJUWDOCeQJCH6rLs2U4WSeIFGFKu811ebGfRKXOsWqp
 wPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TU370y7R5L29omjWNVlDL5In78ul3RsztEX0Ft93XdQ=;
 fh=aLOfZDL/fTNv+EiSAGsBoNpEPI8QeKj8HW4LiUIKllo=;
 b=KRwijiSUiegvCHBot5lHVkt+B1I/8DtfEoznx5ozOGHhILTTieYchsTQYlA4B4FwTB
 zOSAzXAPESjp182bXEOXKAByp4EDB3FTQQUEmArDIhhmE/IX23B9yERz1Ydr/eAsAqzO
 HFHm2KV8AOOdEDRk0QPe4m/i+Fs3AOarP3C2lJiWtcJM7GiXYyAQjg3UWFaH9mbedrj7
 atKWvw+aTdDMZhpwZ7GiuxRXCCE9vw85dJ0X/NVlx5TArgGbKe01GohM4zdRELy/Jbg2
 kYQCqn+IA+ZYroKJXOr8Qp3tMTM1dWiwKsbs4tSIWxVmC/HG5uDIwY9AmnglqUdFmUrB
 qlTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795433518; x=1796038318; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TU370y7R5L29omjWNVlDL5In78ul3RsztEX0Ft93XdQ=;
 b=X775BE9qy6mioqDEEOQ2USPgsMmKR+4dS2d5dUEwLerjGpPArknDkfXn/fWS6cFCuf
 k+PQ96Lzz45/InDSNXIdSRZRlGhmRSLpFAkU528CZ4aUK3OKCUjY/pRvoUmyF3H6X+xq
 /c0uf8VOcqk8VKF0HKI/tllTats+hvo+UHb5pxxhHCEKd4PbAVxRYI0z48AEu+cNIJl3
 Y6hp1IKB5JeaQFPEfLg91J9FgIqbL2KAUJBG3R0TGk4IgeJfPDouq6iaoIMRkbhs/21J
 85QRFZHiW6/KhyvLe+a23zM7DeEX1YFcy61V+HlLrZ2FZP39wnVH4sWUMG7OW6oGHybh
 jTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795433518; x=1796038318;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TU370y7R5L29omjWNVlDL5In78ul3RsztEX0Ft93XdQ=;
 b=XJoFz+AZmFnTZbWFiTCHzMbktjgF4CWmCxUEv/jTahXzIm+6of/6f59uFDCnyegwlg
 hkX7G/buab0IYNa/19GB2cLIxmNAYXVOIX6rmzt5d8+7Z9hOHtCOQk3E58gDiathmFKW
 sbIBKb8yuOqq76MqE+4VA82IMLoj7ifUx7OKkEe+2bqWCZSBOHAVimNf2gGrkYxZCaZI
 w2l6E4U4chV2/dTK32TeQikyi+LziDQajobvhCtmdEXbWcxvhzGQR/cUPAY7BPTFGkUz
 9iSAT5/WDXjI/RH+hZjf/UqkQ3AOA+EGMY7ht0Az1ico4HTLWUnwGIp2TrmbqQzhvVlc
 8E3g==
X-Forwarded-Encrypted: i=1;
 AL+hErGxReb9Ifg/w1KcidSyez1Ec7SpUJLUxzF3YILgLS8QK+oLm40YSKiD3zOucEDXbgj0zlX8ZhFv3lKs@nongnu.org
X-Gm-Message-State: APuU4Z9g9MViIwMzZvOXNAYSDoM+pTP/T9Ho1XsAcsSadI+CslsuSGZh
 k0ocy7EQ+QsaLi0/71Isi9oH9jBXpZrDcBJUWbVenKZf6Ydefi3Pq8QZH9Cw4v+YW5IkxTILUVc
 /wuyyRA4KzEKsj/P4OwuVpr5lV4br0rhVpkFsZF0WRA==
X-Gm-Gg: AZFdTZfUq79QmwPAD1YWpmubhorpYPiHApif7nGjma9chojdXUJsbAE3bN4x8E8UMQ3
 BHnUf1sA+wuc9KJ70DwVBL1hK53v8NSp/tx2JImHiq6aGmY7SYKNAmRKEfcR1KJ3XBvwMye4t77
 2j1VsKvCiBkwPZXIccib4e+yNnpR70PB1IRZsasw7U3el3vEaGOJFinhZe45kwqqcLu4I4P2MTp
 s0yftBvjteJWfGGc0dUyzZmTJeid/4Bz0nJgr5lkuHVC9wNgY2XpPuX9Fw0r71/Ur8XQt7DeedT
 HTJsjt1tOMIVLX6ulyWjatEoO/iw24CbIk8xwH2eH4AGhflWi2qCRw8YHveH2/N0Ag7cmrJs+RU
 WvtYavcO59RPSCu9w5QjK3H7yn7+ncMtsy0PrRU7xx0DKdeEajA2AmbWqLtV1dMyZ9wp/1V6F9e
 zLwURxcKQ9sO/il1ENklxr
X-Received: by 2002:a05:690e:47d9:20b0:679:b313:137f with SMTP id
 956f58d0204a3-67df44107aamr3263674d50.24.1795433518297; Mon, 23 Nov 2026
 03:31:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116114641.1799526-1-peter.maydell@linaro.org>
In-Reply-To: <20261116114641.1799526-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 11:31:47 +0000
X-Gm-Features: Aa3M54oZc21ZeJxN0KTDhbfO6CCXWLukZNzGqP0wU78Kqjb-7lYDlKLx8dUw_QY
Message-ID: <CAFEAcA-Vns8Ho9h1B726=L31ug+Jht1jy9xtiEP1Bf4=E0=iXQ@mail.gmail.com>
Subject: Re: [PATCH for-11.2] hw/watchdog/wdt_imx2: Fix migration when
 pretimeout-support not enabled
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

Could I get a review on this, please? I'd quite like to be
able to put it in the pullreq I intend to send for the next rc.

thanks
-- PMM

On Mon, 16 Nov 2026 at 11:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The wdt_imx2 device has optional support for pretimeouts, which are
> present on most i.MX SoCs but not on i.MX31.  If the QOM property
> 'pretimeout-support' is not set to true then we don't create the
> ptimer associated with that feature.  However, the migration vmstate
> unconditionally lists that ptimer, with the result that trying to
> save the vmstate of an i.MX31-based machine like "kzm" will hit an
> assertion.
>
> Move the migration of 'itimer' into its own subsection which we only
> send when pretimeout support is enabled.
>
> This bug has existed in the code for a long time, but it was hidden
> until commit d9abd0253be ("hw/watchdog/wdt_imx2: Remove redundant
> attributes)" because a bug in the VMSTATE_PTIMER() macro together
> with the fact that the vmstate_imx2_wdt version_id was 0 meant that
> we weren't trying to migrate the device's ptimers at all, and so
> we avoided the assertion (but didn't migrate correctly).
>
> This is a migration compatibility break for this device, but it isn't
> used in any versioned machine types, and we've already decided to
> break compat on it this release cycle.
>
> Fixes: daca13d495a11 ("hw/watchdog: Implement full i.MX watchdog support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4876
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Based-on: 20261106163657.3825938-1-peter.maydell@linaro.org
> ("Fix 'version' arg of VMSTATE_PTIMER")
>  -- the patch in that which sets minimum_version_id to 1 in
>     the wdt_imx2 vmstate would otherwise be a conflict
> ---
>  hw/watchdog/wdt_imx2.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
> index abb8edfae25..b4196de7021 100644
> --- a/hw/watchdog/wdt_imx2.c
> +++ b/hw/watchdog/wdt_imx2.c
> @@ -221,13 +221,31 @@ static const MemoryRegionOps imx2_wdt_ops = {
>      },
>  };
>
> -static const VMStateDescription vmstate_imx2_wdt = {
> -    .name = "imx2.wdt",
> +static bool pretimeout_state_needed(void *opaque)
> +{
> +    /* The itimer is only present if pretimeout-support is enabled */
> +    IMX2WdtState *s = opaque;
> +
> +    return s->pretimeout_support;
> +}
> +
> +static const VMStateDescription vmstate_imx2_wdt_pretimeout = {
> +    .name = "imx2.wdt/pretimeout",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .needed = pretimeout_state_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_PTIMER(itimer, IMX2WdtState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_imx2_wdt = {
> +    .name = "imx2.wdt",
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (const VMStateField[]) {
>          VMSTATE_PTIMER(timer, IMX2WdtState),
> -        VMSTATE_PTIMER(itimer, IMX2WdtState),
>          VMSTATE_BOOL(wicr_locked, IMX2WdtState),
>          VMSTATE_BOOL(wcr_locked, IMX2WdtState),
>          VMSTATE_UINT16(wcr, IMX2WdtState),
> @@ -236,6 +254,10 @@ static const VMStateDescription vmstate_imx2_wdt = {
>          VMSTATE_UINT16(wmcr, IMX2WdtState),
>          VMSTATE_UINT16(wicr, IMX2WdtState),
>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_imx2_wdt_pretimeout,
> +        NULL
>      }
>  };
>
> --
> 2.43.0

