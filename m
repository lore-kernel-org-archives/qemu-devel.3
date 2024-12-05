Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786DAE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJCDz-0004Ka-SB; Thu, 05 Dec 2024 08:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJCDx-0004KF-Ot
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:48:57 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJCDw-0004Q5-3F
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:48:57 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aadb1so1215984a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733406533; x=1734011333; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JJu8HG022438+eSrfzcZEwDhDCKrpNHcYbZSKmOoQ9g=;
 b=HHcse/ez2ge2/9qhO3fO/KGj6dsjL2v5EAc+8wkvJfwmxF5OwsS0i1wQHCMSHWiM9d
 M2V9ksjRmSPqpY0303aSMDnL5Xf/uOq0IKWmGErYP20QQINx72OpNYBmhH5bhDkFyqwr
 TbjB4xEnYTNbfkqF5pG601YGx6BId9C2UlRPrOwdW5b1dIpRp7djYLj4yW9a/zwafIc1
 myiuLFuEtt10qVXHB9NzLjMRX6qzzeEhOtgBp6fqOVIZN6BwQ0o8GPYGepwM6+NxhhBD
 66Tpy85J23p9MtJCCQW/rpyVHU1iOetQDdFNL/4TsbHhwAVHe8Ij2lPpcAOdBpfVKr7A
 PBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733406533; x=1734011333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JJu8HG022438+eSrfzcZEwDhDCKrpNHcYbZSKmOoQ9g=;
 b=QPcUzbeXEBwGMb3clhTB2nX1KIqLCD/xc1krjO4zKKQBsnUJaZfsm7wEIE+86Trv9p
 dGzlv6JKmdSlitSuUZJpuQcGYVEm6NKTJzm5m4YKu97qnsBqPA1fVNnSGVfyYltIoLT5
 M3q7i1F6Ax5UnCp1cB/2EeA7tOedxNcnw7ifml/uac0MiiPOWYS2ryRt7Ax5IX5cfji2
 UpBitUO0tgXZj8TMM4/NEPqvdatggIB53ljRRHaMxr45mmJULuM+qJTybcDz6BgIdo2E
 +g2KvRcJDXJWGzFPpp9tNotq4H1jwPYXLksdATYcernGu9yVyAlg0MpWEyNJjITqHTa8
 TyQQ==
X-Gm-Message-State: AOJu0YxI6UiHakjVgl7A2eYk6CEvyBVmCe483vAqpGLKR80SPVApoBh4
 Hdwyg20FxNabnKpnycYnqL+dOj4KNK1Y+tEjFQgFlUSGIy8ALe3IZ8s2W4g/LC0mQpjakPmeed5
 FuzOuZXdUGrsN118amY5VjujJ7PoC5KUcYegK7A==
X-Gm-Gg: ASbGncufHB4WChxUxFNb7y5N66eLOk3ObeeC0gaShcwJ5K3od+akluGt48OSE/nBv6N
 d8C1H/MqDe0sfk/HB7RiUQ6gvruIRXjMO
X-Google-Smtp-Source: AGHT+IEdT9haYFIp44DRlrjoq2rgtoLK8WpHkgfn/errjl6Nk0xeF1w3NEAE7o39o+NtBsQ/ea7SBMmkCkTLI4DRYdY=
X-Received: by 2002:a05:6402:3714:b0:5d2:7270:6135 with SMTP id
 4fb4d7f45d1cf-5d272706625mr1839391a12.33.1733406533625; Thu, 05 Dec 2024
 05:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-11-richard.henderson@linaro.org>
In-Reply-To: <20241203203949.483774-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 13:48:42 +0000
Message-ID: <CAFEAcA9_HncJBCbEFb_804uZ0YCk18jz_9P54b74umWO8tPGSA@mail.gmail.com>
Subject: Re: [PATCH 10/11] softfloat: Sink frac_cmp in parts_pick_nan until
 needed
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 3 Dec 2024 at 20:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the fractional comparison to the end of the
> float_2nan_prop_x87 case.  This is not required for
> any other 2nan propagation rule.  Reorganize the
> x87 case itself to break out of the switch when the
> fractional comparison is not required.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

> @@ -89,20 +84,24 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
>           * return the NaN with the positive sign bit (if any).
>           */
>          if (is_snan(a->cls)) {
> -            if (is_snan(b->cls)) {
> -                which = cmp > 0 ? 0 : 1;
> -            } else {
> +            if (!is_snan(b->cls)) {
>                  which = is_qnan(b->cls) ? 1 : 0;
> +                break;
>              }
>          } else if (is_qnan(a->cls)) {
>              if (is_snan(b->cls) || !is_qnan(b->cls)) {

Pre-existing code, but isn't
   is_snan(X) || !is_qnan(X)
the same as
   !is_qnan(X)
?

thanks
-- PMM

