Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980AAC52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbylo-0005z6-Iw; Thu, 08 Aug 2024 04:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sbylm-0005tZ-45
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:45:14 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sbylk-0006fh-BW
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:45:13 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso698867a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723106711; x=1723711511; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QCj3w+RtFY2Bad5vNqvlX6DlPWT5CNj2qTsSSR9YarA=;
 b=RIDQK6TIH49wDgJXHypyAdY31DYccDuw2qb57bqhCQnJbDLDj7DwzEaNyADl/vyyzb
 ZyJKQN1KJSZGBJs9MYHdEPVRLPjc3LGafnX3RKKGs5WHymdI5TMvsn0wbH2Wgi8A7cFU
 giHRTkN/3RXlkKfUJOjxYf35Rzy/4NtWgR2sgLiRJ1yoOTnfGFlSf9Q/id60dfD1ePiw
 ANzvzaOSUiPJ5Rs1jyX6EN4+RptMwX2wOeYdIBlbDYbnZ3doCyltnk7iytxNhK+s98Dx
 1mww2mi8kuKiVqZpWOC4MdfbIxqfPqJ46KZD8RvGd0q8YrIncrKcNF7exPn+STflf35I
 YhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723106711; x=1723711511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QCj3w+RtFY2Bad5vNqvlX6DlPWT5CNj2qTsSSR9YarA=;
 b=C8ibRYy5Ezvya0cT3b1Hv0LkVNepLEAY1FllHZ0uKXXxqwpgNFIOBR5324hoeDSQlL
 682sXj/8MABZN5HuQc2hOX9k3tMq2i1gZDfrpG7rhUZQyV+sGR+O7NsGn4swfU/KQb89
 mVVcvp3ONSpwoDZk5D9bwPxUUyX4KUxfT3bdp1ahLJcSFFQ+BgwVW/vdY0n0rrh7dWDk
 Jm8hQjHXjyOpqBrWLW33r/JiogfSlxwAQsyH7qtLc8o/9GIV0m3G4OIRBxq9x4ziTD8c
 yPHZhDgniSjPsJgaRG/HUyDYZwhR4h50Eh62CvjWexwlGIAiyZ1S9ZXm5hEJMVfMHeOM
 xGSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcuqExgV6+xElGoVHeQ7KMeeKyfy6I/vZCHFZTjzsedPKvjzm8/mS4KApOqLGZOMBdn7bB76TpVlsq@nongnu.org
X-Gm-Message-State: AOJu0Yz9V++TmGSRA6AZdtu1kcrlhKz4/TBpY48cQQNcWtqVexT1fTXz
 5s3J+OemSpoM6pT9ZeNRLKbHP3R+KcVxxP0fO8d/I32nd1UBnv7Wcb7Yuwani2tw7lyn/1tXv1Q
 WwOwwt+LarxxchzJiTHhwP03tGuGVYfALykbDlg==
X-Google-Smtp-Source: AGHT+IGrbY8Qv5oDrhdtQHBm+W4MCXCaPQkJ0C1EEBSyyq/5YebHyhCiAWpzYvyGQpTBsO/MRZ/n0+mRlvfgskePJsk=
X-Received: by 2002:a05:6402:1d55:b0:5bb:9ae0:4a41 with SMTP id
 4fb4d7f45d1cf-5bbb2338672mr833902a12.28.1723106710524; Thu, 08 Aug 2024
 01:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
 <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
 <CAFEAcA9emwsK07+itUzMxReOLG8gHaxNdDE8ymuwyuBfsoY2Pg@mail.gmail.com>
 <87bk23skhq.fsf@pond.sub.org>
In-Reply-To: <87bk23skhq.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 09:44:59 +0100
Message-ID: <CAFEAcA8J4i-81rOEHBpqbV=c4F26o6qd3Lg9dZV+BuNyZPGg7Q@mail.gmail.com>
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
To: Markus Armbruster <armbru@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 8 Aug 2024 at 05:32, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> [...]
>
> > The QAPI command which this code is implementing is
> > also (a) target-specific and (b) unfortunately
> > designed so that it doesn't get passed a particular
> > CPU or particular device to query, it's just assumed
> > to be a part of the whole simulation.
>
> We can fix (b) if we care: add a suitable optional argument, default to
> the sole GIC in the system, fail if there's more than one.  I assume we
> have no machines with more than one now.

The exynos4210 SoC (board types 'nuri', 'smdkc210') has
two GICs. (It's a rather odd design -- there's the
interrupt controller that's part of the main CPU
cluster, and then they used a second "external" GIC
that feeds into that one.)

-- PMM

