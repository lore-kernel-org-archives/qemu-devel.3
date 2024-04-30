Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B4DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 18:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1sRG-0002Vm-R6; Tue, 30 Apr 2024 14:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1sRF-0002VE-C8
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:42:49 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1sRA-0004bI-CR
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:42:49 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e1bbdb362so6513212a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714502562; x=1715107362; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8mCUSCLmgKzNcOyOr98vFPv0pYjXNNAruAUVA2i3+os=;
 b=hxFVVeLdCwZmHYXYNtKRnYN9yEv66xefyDS51rKYbt/tW1c9t8U6Huz9Bqn2pR+Buy
 8fvv1Dh0mri8uxu4c6u9AaQMTph2wBKqiwKKFbY9puf5Hjh5iHUuSGpUBsStLhljX5b+
 AukHREH77W2I5GWGscBq6wbUnx6zPrdoBw7fMPCLyseGrdiax3bpu2yVqpJQdNsaDSNY
 iDsgBQqT+rvdM07czuwfbx6IMMhRx3PuwHjVKCr7S3Wf8Y4XCEMeylM6OL1Orgs7IkL4
 qGhS8FKuH7Jy4qL/e8kMEuGbl9Lqf+WWNWRgoXckkNLUenK1sybtkp3Pqm1vHORKGW0L
 KvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714502562; x=1715107362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8mCUSCLmgKzNcOyOr98vFPv0pYjXNNAruAUVA2i3+os=;
 b=lcIH5XTmrjE+HeWyBKjlVsQxbobTara9WXLLmfZY6g185a/VF7xxc41Mtsm8tbRecW
 Q+crx79X8LJ68/2DasJKEI30Ngxl4fyJ+TjlREOMqWgXmm2DstVoEw99WVkPG3TkmHFi
 Opu6gqhWb6F2kJkw8gba5FU8kaGaeV3+k9upc9IBmkvtOT+CEjoDWXwSJXlNwsyfIJmD
 IaZ2QVM+Kjg0P2ZqEHAX2Fu+buJinTLFQ/igY4+bZrP0cH/lztfj0I+o7dMSgGOaKgMb
 vyKsVCYfVBANb04lVZNxV0HBzAQbHbCkhZ5gMivDxOwDZYUaq2VQ+4wO0yVJBmetYwKC
 ocYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwr6WlCUDVe/7gaCJaSkTeL4c7kOY1+PAYylGhGJWQ/bqegz3NoovPSaRquQDXSbCMiqzG0xeiF7qUGioni4HbJxadxeI=
X-Gm-Message-State: AOJu0YwkZWRbnt7UAaOyaccnxHcp/DiVEK4phxOzStw0IYU8ANm3EX5C
 Og3osRYhq839o77oWqflLYvs/GkKf/KBY+JN73OmZFwx16ZJcovcQ+1ABXH4P7jRIeoWPb7ef2s
 cWyUxqfR06ZBcYllaVlOTXrEKf2hIw5tHfBDBtA==
X-Google-Smtp-Source: AGHT+IHBMSe0uN87S9NyP63HeEW5wlQOEweBeWg48H7/W38FGQ59of0iNRE8Nv0fpvce9TnjF0gM4PIVe4ZSTfJ36ek=
X-Received: by 2002:a50:d6c2:0:b0:56e:22a1:a9a2 with SMTP id
 l2-20020a50d6c2000000b0056e22a1a9a2mr415339edj.33.1714502562360; Tue, 30 Apr
 2024 11:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240430140035.3889879-1-peter.maydell@linaro.org>
 <20240430140035.3889879-3-peter.maydell@linaro.org>
 <8004c7bf-3185-4eba-8e1b-4a913bc1143f@linaro.org>
In-Reply-To: <8004c7bf-3185-4eba-8e1b-4a913bc1143f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 19:42:31 +0100
Message-ID: <CAFEAcA-G2YAArmV7Ttg_-iRoh43n5YeXiBafqsjeAyu_9u8saA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Implement FEAT WFxT and enable for '-cpu
 max'
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Apr 2024 at 18:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/30/24 07:00, Peter Maydell wrote:
> > +    if (uadd64_overflow(timeout, offset, &nexttick)) {
> > +        nexttick = UINT64_MAX;
> > +    }
> > +    if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
> > +        /*
> > +         * If the timeout is too long for the signed 64-bit range
> > +         * of a QEMUTimer, let it expire early.
> > +         */
> > +        timer_mod_ns(cpu->wfxt_timer, INT64_MAX);
> > +    } else {
> > +        timer_mod(cpu->wfxt_timer, nexttick);
> > +    }
>
> The use of both UINT64_MAX and INT64_MAX is confusing.  Perhaps
>
>      if (uadd64_overflow(timeout, offset, &nexttick) ||
>          nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
>          nexttick = INT64_MAX;
>      }
>      timer_mod(cpu->wfxt_timer, nexttick);

I'm following here the pattern of the logic in gt_recalc_timer()
(which could admittedly also be considered confusing...).

Also note that timer_mod_ns() and timer_mod() aren't the
same thing. The latter calls timer_mod_ns() on its argument
multiplied by ts->scale, so if you pass it INT64_MAX
the multiply is liable to overflow.

thanks
-- PMM

