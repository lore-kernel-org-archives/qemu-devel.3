Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A3FCF259D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0IjT-0008Il-8Q; Mon, 14 Oct 2024 06:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0IjR-0008IU-9z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:55:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0IjP-00076G-C6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:55:20 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a99ebb390a5so312386566b.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728903316; x=1729508116; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u9rGVTNoNbab8SZPsqzjrWU1GiF+nKdIQyvQOWuRifI=;
 b=qVsBesfW1Fj9U7G0tGIkLeWVThPCcx2oaWvD25dvGFtAbVXOoQzE2ZagIFxH2+ZnXJ
 CBcvXBWN1k6frs64vxuYqtNZfAJYBqpF72aqZHDZ9kSE9vfMf5g3KMQT9IBMCyBzAzKS
 TMfJiV+pFHqwY2EkLy2TfFOo+4LLubk7DKYCUa/dYo6n2FHivsa4XySsa1uCrvBqkleD
 pZ0F4MB1309NWUxFNQK5Rn1LmpAj6+Zah7s9LVHE9lasGtlrSzoIZ4E22aJ0PKMmP/zy
 GBOh7a7tpugCtkIzxlu6lGatg7BYnMKHjCSbQDaxOPhDM2gxLp37slOH9ATw4jyUh9wY
 THnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728903316; x=1729508116;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9rGVTNoNbab8SZPsqzjrWU1GiF+nKdIQyvQOWuRifI=;
 b=JeyycvKZNSXVbPs9item4gd/Exw7h+x7wri+8CA0bQiZChv6cv3k5IueN/cZEUWJK3
 OH7Kj3XMLNXdRQez5wi+I8+zl6keB1gv6RIMYg7AI2vcULcL/Axc9ZKw0r1Coi29ywwL
 EwhvSarxuUWgp2ecQK4jsHgPIE4hCC74grYxRmfAhDKLRSzs1cpRi3SEe3AKT8aN69Hs
 X7HzCfA2MJOBKv5TZaunAmuN/XsApWqreKpPoKN3q1aYwakebkamWJpGBNhYP4vTHHNZ
 8huysZRKdb/NKvrCPVB3suKKzHHiHAAsCYl6NaLLBb+B5tdZ6mHv2TOQHixqCZFjQM51
 FZdA==
X-Gm-Message-State: AOJu0Yw4nvdWwV2Lr+3o6x7B9jKGqNdzcL2LH7V9rXmJthojtiV34UXl
 LunPFkAwsIeeDHvCRawa3mAkgibuw2yPAVPa0bIR2ZOGZwhOZN2ALC4mULLl6AU=
X-Google-Smtp-Source: AGHT+IFXN247jKTp2MQQL5Byd5VRnCYNXlg5k8XQHsx+ZDtoAYbmFc7zYelymZzG6QBth5XH7De8nw==
X-Received: by 2002:a17:907:96a0:b0:a99:f298:c235 with SMTP id
 a640c23a62f3a-a99f298f43amr477680066b.7.1728903316327; 
 Mon, 14 Oct 2024 03:55:16 -0700 (PDT)
Received: from meli-email.org (adsl-161.109.242.225.tellas.gr.
 [109.242.225.161]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a1016c370sm124148866b.86.2024.10.14.03.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 03:55:16 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:54:04 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/18] Rust initial PoC + meson changes for 2024-10-07
User-Agent: meli 0.8.7
References: <20241011153227.81770-1-pbonzini@redhat.com>
 <CAFEAcA-2dR26AvpbV0dRob-Gc=wbN0Mh9rYYB19WH4Yr6ugXHQ@mail.gmail.com>
 <CAFEAcA-hhdXwfD6Bn5yR6by3h-SkYaNd6dsj8d7J-zc2zK7E8Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-hhdXwfD6Bn5yR6by3h-SkYaNd6dsj8d7J-zc2zK7E8Q@mail.gmail.com>
Message-ID: <lcec3.dfw38kpupgt@linaro.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

On Mon, 14 Oct 2024 13:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>On Mon, 14 Oct 2024 at 11:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Fri, 11 Oct 2024 at 18:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > v2->v3: new patches
>> > - scripts/archive-source: find directory name for subprojects
>> > - docs: fix invalid footnote syntax
>> > - docs: avoid footnotes consisting of just URLs
>> > - docs: use consistent markup for footnotes
>> >
>> > ----------------------------------------------------------------
>> > * first commit for Rust support
>> > * add CI job using Fedora + Rust nightly
>> > * fix detection of ATOMIC128 on x86_64
>> > * fix compilation with Sphinx 8.1.0
>
>> Applied, thanks.
>
>With this applied, I find that on one of my personal
>local dev branches an incremental rebuild fails, because
>meson complains about not finding a new enough bindgen,
>even though I did not --enable-rust. Meson also complains
>about a bogus coredata.dat and we end up running meson
>three times before it eventually decides the error is fatal.
>
>It looks like meson is incorrectly defaulting to "rust
>enabled" rather than "rust disabled" here ?
>
>[trimmed]

In this pull request, meson_options.txt has:

 +option('rust', type: 'feature', value: 'auto',

So it's not disabled by default. It sounds like meson enables the Rust 
feature because it found the rustc binary.

