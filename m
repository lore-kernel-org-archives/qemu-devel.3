Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945C8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 16:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgRaw-0000g2-4m; Tue, 20 Aug 2024 12:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgRao-0000ew-PD
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:20:24 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgRan-0001Ty-2U
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:20:22 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5bec4e00978so4894834a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724170818; x=1724775618; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLh8kDNq5B8Vs01X51mf0lX2ziXMe9AqqPVMnFmXo8c=;
 b=wTavolm++aoiXZSyZrMCs7EgKJEtsAfoKtS9OR1ffM/8Huv9OdiUDyucuw8QwUMvaG
 FgIVLvJlG9OE7IN1rkoi0UyU86y+krLEZk/Qh4WUAQ2GYJYK9Iz411XgCpUhMw0fCFn/
 B1GEGUY2xU30AQlbUIb6p1hkHIBC3rytTc8pY5jgv0sYPi9OkTEV65VA9yr3V6NpHr5e
 4XGngQ8JoOMUpd3+zKzp+TJoCLwTBAExR+BsCwpp01E4qi/KDcbcXpIpCFegBBFkm6XZ
 4gAz8SypIhoAfhAdvI78RvmpafetdQZvkdKoMR/ub8nrSDc8SVA5HBY6v4dg8Mnx0otE
 Kfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724170818; x=1724775618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZLh8kDNq5B8Vs01X51mf0lX2ziXMe9AqqPVMnFmXo8c=;
 b=hABfTP7KQlvDWBL0SflKyk3izBsqq3RayDCYeLrjDoqkaWwCmMIhoM2GPB7pRo44Cm
 jpRrIWeVVFj7lEo33vhrb2FqLwgkVCsUmeYvKmGF8hwD/QksjvVdWY+Ryw8agpH6TNIZ
 sOaq/dUna6NrP2GeZfA3LCmoL0AwBft9VLVK5utezu0M9K9JLx3igNGZWU6e/ottgps2
 zv4aZht4vroqgKEQP7G7E++Ydu3juFdTChiOLOomPlBSItvq5S98vsAHezQBVEmYibfT
 KhMjo71X0cIx3IGCqWXCT0xwJlOks+KmlK1gaZtb7QhdqY1eHGpRY5S40CJqPxudyyUL
 ZFyw==
X-Gm-Message-State: AOJu0YwbK1QNwZgdOk1PwqQjlX40H8sPdfymF9T9Pw2xHDkuQrq+eNsU
 2mQ94UFePEz5prnasiBN5J+uFt8pHlteev/qAyVVus8AU6BRq5EhfObj27FWYl/o8y+36/eu/+L
 BuzcGyy8Ey0idlymzik/4po4P74wn0YsLhX2MVa1OszHCXwx1
X-Google-Smtp-Source: AGHT+IH5pTsiX6bNxCN9UB23/pfR7Y+pOluVlFbl4vBjkoxFdKsTKvIGGBjs1aU8GNyE4zkhe218vRxwZUPX4DBvFAg=
X-Received: by 2002:a05:6402:5187:b0:5a0:c6bc:9f5a with SMTP id
 4fb4d7f45d1cf-5bf0d2d4df4mr2139022a12.38.1724170818387; Tue, 20 Aug 2024
 09:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240820145514.63046-1-nabiev.arman13@gmail.com>
In-Reply-To: <20240820145514.63046-1-nabiev.arman13@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2024 17:20:06 +0100
Message-ID: <CAFEAcA8WPfynQyjB1_S5z=OA6k-xhxr7DNOZBR0mC9gtD-mCnA@mail.gmail.com>
Subject: Re: [PATCH] ppc: fixed incorrect name filed in vmstate_tlbemb_entry
To: nabiev.arman13@gmail.com
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 20 Aug 2024 at 17:03, <nabiev.arman13@gmail.com> wrote:
>
> From: armanincredible <nabiev.arman13@gmail.com>
>
> Signed-off-by: armanincredible <nabiev.arman13@gmail.com>

[cc'd the ppc maintainers and list]



> ---
>  target/ppc/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 731dd8df35..d433fd45fc 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -621,7 +621,7 @@ static bool tlbemb_needed(void *opaque)
>  }
>
>  static const VMStateDescription vmstate_tlbemb = {
> -    .name = "cpu/tlb6xx",
> +    .name = "cpu/tlbemb",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = tlbemb_needed,

This does look clearly a mistake, but on the other hand the
name field in a VMStateDescription is part of the on-the-wire
format, so changing it breaks migration compatibility.

Before we make this change we need to confirm that it is
not used on any machine types where we care about cross
version migration compat.

Alternatively if we need to keep the compatibility across
versions we could leave it as is and add a comment about
why. (I don't think we'll have a problem with incorrectly
interpreting a tlbemb as a tlb6xx, it will mismatch for
other reasons.)

thanks
-- PMM

