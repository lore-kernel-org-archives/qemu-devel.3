Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535FFC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGja-0007EL-W7; Mon, 14 Jul 2025 06:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubGiO-0006ga-6b
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:47:25 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubGiL-0007DX-4q
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:47:19 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-717b580ff2aso34342457b3.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752490036; x=1753094836; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7zW9BdP+iWwUNifc/+YSmce2H3wcNzFu018ZMLhSB3M=;
 b=bwdofn5PRYEoEP45unihi99oGknUUyHzxz/r3rkxaK0cJE5JoFqzhA0AJG7EWV+Hew
 sFa7vwitAAaV83SjbE0Qb8tICMFEPi0mIlQFmWvRtWblp0zia4lyyCuanyWgmb8WBZxw
 MX/Uy+UnbMT8Ysr27kEDa3d/TC05J0JCPF69L5QZxZyvM5V5RgT1fvSiHhOdNlp2mkSS
 vd0w2i+xPLzEEr5XeC62Qa393m+ptHLQvt5NWYjVMCfD38ErZ430/npR3aozFMoViuDO
 YKoVQGol26hGESFHCNTUHTApPEyjrEnNJO2RCWcbMESMHl2WEDGSbv1M/2vWBZBgkGex
 PWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752490036; x=1753094836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7zW9BdP+iWwUNifc/+YSmce2H3wcNzFu018ZMLhSB3M=;
 b=gvLcY3mIAVCHZ32Ry5/hpBnXYXT3KXQR3Bel60bHatXJ6Xs3Ttv1HvA+gTLRq61PvN
 Rm4GUFZZ+WJMyqBi06JGWl8cUPivLW+D1eKaZ8YB3WQZWa2otcutCP0HwroVVTWRrFrC
 ceAbUC/GlhW2cpvpVBxtOZxDrM3pNZankzmOuN/xvLBb1yvtrnR3e16Ckxm1JPGdgqmb
 uJbQWxxfmdOP352Uf789P0FO7osEVgpWdLftQkr841L78G3F4YQW8RwLpTohI7lsC4ZE
 uYxqJfxLTk0g5WQT7GjRs8yVAJSL6l9DE/lvajbBEm2dz7ArMzkeL5+MQSrjjtmfRFDD
 eJsg==
X-Gm-Message-State: AOJu0YxMpaUdsQbf0PFNYjaRrdBaIRvS/qW/LG+586J2al3AQRdkY327
 0l/xcW7tu30k6wHKrzQlaypnUtYx3Fp8WCLIIVEaV6MWG868s4Sk62QTKmvBkGQc6w/kWd0hxd2
 pXOAhnnzAdsxZy6s1ziJRhkPed4mYAoV9N4kLtVjwAQ==
X-Gm-Gg: ASbGncvoi6Z8+6aYVfkzr4BjBwYnDlrwxV086q0IwI4xMpNj+/Zzd5u5fJqK1b4iiFG
 nm4T8mRQJj/b2K/TruzTGtDFDMyEels5/0DwYx1uO+mltbHOPcBwW2pvFrGnm6g6f8OEnsSsQRX
 PBkaFdPNtUpzP+tBE+Gszx1b95uc84+rGnIVysabtNbMrlTHdfxZ4SGJZ+2yL87pjAK95LXUWCJ
 dN7451wFtRVxeOYpLU=
X-Google-Smtp-Source: AGHT+IEExIuUGWsNkhb77avZpYO4dIuZ14TigNRUb+0z7OC5SVqM6MTggLbvCNTUBTeJXXLwL/W5VqjAmUDDhHRcsss=
X-Received: by 2002:a05:690c:30b:b0:70e:779:7e6a with SMTP id
 00721157ae682-717dae75f30mr145024697b3.22.1752490035591; Mon, 14 Jul 2025
 03:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250711141031.423-1-farosas@suse.de>
 <20250711141031.423-26-farosas@suse.de>
In-Reply-To: <20250711141031.423-26-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jul 2025 11:47:03 +0100
X-Gm-Features: Ac12FXxIl9Iet-t7iLJkdxbTWCgyo-VYsD_NtMJtshKfrbmS8zOJWv8fInxgvps
Message-ID: <CAFEAcA-_2a5CUspXhy8UErA86EnZ3_s=P2DQ9DPdrMDwNWF4FQ@mail.gmail.com>
Subject: Re: [PULL 25/26] migration/postcopy: Add latency distribution report
 for blocktime
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 11 Jul 2025 at 15:20, Fabiano Rosas <farosas@suse.de> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> Add the latency distribution too for blocktime, using order-of-two buckets.
> It accounts for all the faults, from either vCPU or non-vCPU threads.  With
> prior rework, it's very easy to achieve by adding an array to account for
> faults in each buckets.
>
> Sample output for HMP (while for QMP it's simply an array):
>
> Postcopy Latency Distribution:

Hi; Coverity points out that there is a bug here (CID 1612248):

> +static const gchar *format_time_str(uint64_t us)
> +{
> +    const char *units[] = {"us", "ms", "sec"};
> +    int index = 0;
> +
> +    while (us > 1000) {
> +        us /= 1000;
> +        if (++index >= (sizeof(units) - 1)) {

sizeof(units) is the size in bytes, which in this case is
24, as it is an array of three 8-byte pointers. So it's
not the right thing to use in bounds checking the array index.

You probably wanted ARRAY_SIZE(units). Also, the ++index
inside the comparison here seems unnecessarily confusing.
I would suggest something like

    while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
        us /= 1000;
        index++;
    }

which puts into the while condition the two conditions under
which we are OK to shift down a unit, and keeps it
clear that we maintain the invariant of "when we shift
down a unit we also divide the value by 1000".

> +            break;
> +        }
> +    }
> +
> +    return g_strdup_printf("%"PRIu64" %s", us, units[index]);

Otherwise this units[index] access could be off the end of
the array.

> +}

thanks
-- PMM

