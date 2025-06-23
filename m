Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCC5C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkCv-00078Z-DD; Mon, 23 Jun 2025 12:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTkCg-00076m-32
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:39:36 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTkCe-0006Fs-6C
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:39:29 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-710f39f5cb9so43632687b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750696763; x=1751301563; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GOsiO35p5XF2nrDxHygV6SaVQmMYX7wYD/JUQSxoToQ=;
 b=T1uGI9gMHxJXklaLUCEAPbRGD0NsVbxAjI7cnn7OuV/HrBjf9Bf69r0HaCT7v8aPZE
 ieEdz+YyHnfF5fVBPSngXfnlzNVBbX4fh+LYTaRRWW/uYYMLtuLpIsIV/yN1vjan3wg2
 STd6yfkJCtt7EkhPiUo5lOXWOAu+wlXOlBmaG9pC2LHvDWDV8SsblZc+wpC0FJhfqi2n
 B8YmUWaMLGZdhOPt3+OzSfADF+5/NBr8qWUsoQTayAZC3JLnVvHKEUN/9axPrO5fzbD8
 PeOgQ8xby0o95FhPqz94IvOoPCUlwn6l3LEhjz47LStzj5xY+yB1C51X8GNm+/jXelK4
 IKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750696763; x=1751301563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GOsiO35p5XF2nrDxHygV6SaVQmMYX7wYD/JUQSxoToQ=;
 b=sVwDGqVhMRLFEBGlIqBGTGB/b3LpLJNKf4dmornu4HUBAzckyN858UWoHQvHfkrTbN
 layguJvz0v9YJtRG0747g4tvbHYmjf+41Zz5cpd43AEDjboxZ77r1Xyv73CybwByeyZC
 16P1lngDV1aaNiM9oeAbZ+Vg/C6HOZhPT2Z6bWadqseAugzGrvlWNp8XmrHiBQUC1LII
 e8LInx1Q2u8/EJHmgLXfm7wxzgRT8aYu285poFQfBg7x08aaPCvv/FmsJFH2wY65kLoZ
 Z8dgNdRtcPreijOKOmCRQs6+usV9kDr50dbVcfK3z7xCbLx9wxqp6ig3gyyi5PDz0LjQ
 4VJA==
X-Gm-Message-State: AOJu0YyTmVt3hVpukAbLFP+0UHL/Ka3zcirKSuG4z0z02etj24bNZCTj
 O4vwHvIS1GqP0dnCGS6trsCHhE9x2HUwNgaKHVurZmQX0ZKxzVywl9JP/2jvcaCLiMFPJKw2CeP
 L295o91tAa9Xq4zabQcLk+k7x0e5CF6jfVDy1TbgA5g==
X-Gm-Gg: ASbGncuGK0TiEvnEbc7Zx8j2EEBKVh7GfFym7rLVRmZgWMNCrelDzIUZHvFRKhSry/H
 Uva7Cjel0P3uNP+p4EehRz+2T6Xotw4dPJ5K/b++i4xXJQIqNS2hcxME1p/5a7PaTMRKhiwVbFY
 mdTbsZtRc3q5gU4B4l1iFJw/fwvV6+YasWJjX3x5zHnei3
X-Google-Smtp-Source: AGHT+IHRRpVd02TmUm5YkrnZZ+FLDO7T2fS8Sc1JA2CHlAov0Pu4hl/r6X2yJVPdxmDxf7Oq8tPISpIKQs2pCsh38Ws=
X-Received: by 2002:a05:690c:931c:10b0:711:16d4:60dd with SMTP id
 00721157ae682-712c673b6a3mr141762707b3.19.1750696763135; Mon, 23 Jun 2025
 09:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-37-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 17:39:10 +0100
X-Gm-Features: AX0GCFsrI1pZtlz3Q4sDQn7MSZsgUj7HACp9FRf1gTtf8DfYIYfDfP0nTRS4Enw
Message-ID: <CAFEAcA8ggJr9y4Ppc_d=UcN4zKh7R7t29x6xugT316L7G2jkEw@mail.gmail.com>
Subject: Re: [PATCH v2 036/101] target/arm: Implement SME2 BFDOT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Sun, 22 Jun 2025 at 00:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 17 +++++++++++++++++
>  target/arm/tcg/sme.decode      |  9 +++++++++
>  2 files changed, 26 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

