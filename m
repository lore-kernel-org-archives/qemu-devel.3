Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7C606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zyrp+1O/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMT1j-0006zI-Nr; Thu, 29 Oct 2026 12:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMT1i-0006yr-70
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:30:54 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMT1g-0002QP-Eu
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:30:53 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ab432273c5so22845077b3.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793291451; cv=none;
 d=google.com; s=arc-20260327;
 b=cDLo5iJy7QqxYZnibfxhyQIM5G+ax5QJ6HNbb6XhzEvx7J5sFUT174lV+0TgdEyjQZ
 z+QCI7uZurw6qwYWlzDEpQWUofsoL/8r44dwjBXULgrsSOoYsxWWTFoeRwItWA9Ciq3P
 gUspjNoO52+igG577hgyt6yzU5pwQ/i9GOscLqcShsIjElRP0Y9ExsFmF7qX9zv02aWc
 USr8muj52PDe61omqqgPBebjjuTsNm2OPT2aet7YiJJFvlbcTVoygmzi+x3B06RxO4BP
 3N0Un6ZCZfgqIgYbQ+FnnHuNFhMsnAmQL9E3C6lfWaDyWkkE2N0IVFeWjmYQuCYqMK8V
 jOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ALQagMtWf7GCqJQAFi2UBRYxmhKmnnsb9HsHQ+zOXZw=;
 fh=awQMMknHcj1HIuFUrvcecN0YXHDVa/EdgcU1qdAHEHg=;
 b=RGltHg20LM95B4C/y40iqv8ovYTtfqfMrlJbgxZF+4dI74S5APEELgeoO/3J5hjrpO
 PnSU//M1f/xG6hPhFeG9YuNIh4WXYJGDiDbK9eNNEW0qxY4XikKvnB+rZCFMJFmQaG7N
 +Vb7HrDLXyzQCfbWUTZSbN0CkkYsnPWReRnN2L3PK4Jjc0HjIJK117P5+LoeZIQF6iZd
 i+Cfmsf/sZr168AjgHMMfjlI1D3xc5J6imYIt2n6j51kkeTrC5hsj8SLvWAJcwSbbNFW
 zKItTMIkrwXXj3WWDfggy2Yptj1ZkARYjvaJk3+f4GAAyeercjjk19WJW70ZlotcWczr
 0MFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793291451; x=1793896251; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ALQagMtWf7GCqJQAFi2UBRYxmhKmnnsb9HsHQ+zOXZw=;
 b=zyrp+1O/t4hY1uoWAOub10z7SO9FAXG2/v/yck1et+G9Q52ogLTY3nVt1vbpjfnNVk
 x5kBGq87DCWE43++JxbPfQgwNZBEqew6HcqNYDqPF9XcnTP1Id3XE6AzEz/ukebrwPDp
 f1PRnLBfHhXtVpu5V+GifxQ1giZjf9t1FWcgRnq6B/q7xItwxVOyDKItNgCU0s2EUmBX
 lECoJ59VbBo6pEkmUAWDNkLEp26mhZ4OXTXrxiuW40DvmHsK1yot46jKa00j6we4MBOm
 0as2ZUEQbBVZpeXUvuEvOf8cJnKGK8kUaL3cOGTEmCgo7f+UtSH2pnM82ZvCpvWk39GM
 NFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793291451; x=1793896251;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ALQagMtWf7GCqJQAFi2UBRYxmhKmnnsb9HsHQ+zOXZw=;
 b=fYmSd70am3qsCgfu+X1F2Yovw7JOr6yQka4Max1WAacbnplaSvSJfVnjxQPEFlfqhI
 4XkA06AsTqeFNHkVhjbHiM7uTKKv/uyyrDxTDXE31liJeD9qJpV5bIDACvaTOqze4KdW
 EFjhI1bQK25IlAzbiAk5TUNe2VxJh7u9X3RL+2DmCh8tkpJPdWyUodSs2EGhHTinDODX
 aksbNseB2vHxdbwmS+b5JL8aECMIXv2bFPzJBojM4aK51gqqGm9x03sy5mIJfZuI5GND
 rc38NIqaJsRIkTSs520jTTFRdhT+WYXknyZDHaBPmKsP6mRWlHqnN90lHPGxwMc7wW4N
 qCzA==
X-Gm-Message-State: AFq9FYLQVKozqt2GWd8kCt/auqkJaxm6vLjc26oAEIXcgmaqewqMR7Sx
 DiMlZGb4kguCTI7iUgiTsxkTppIeFK76OE5RUq83ImFLI5aAT7HUin15bcJVgIU0g8juDrHkIoA
 ySg0icAsh4v/KUi6DPHOZXggXzKP45VZvsUdfEdg3vA==
X-Gm-Gg: AYBFou3CqjC0UzSeJpio3hrsRiLU2SCyvhSrZvooGpSCG6Mk5YByXZBFgeu0OhVL+Kb
 JKqpK+/WQ3izLiMj7XyaLF7nr9FmkvmKkw8dsB14fBaCEcc+hyvFDlJ2ZJcEV2Lji6gtO6RcdKi
 4ANcjVMt5eeWR9WSOV66f7kGEvWox4x6Kp8PW9DJ5OXMrGRnrOiTfh2zTMk5CDmMzAoCC5Aes5q
 MNvxmc09m5vw2Zt8y9uPzoedIBBwz5Ti8plc8cJgVbuRrSPTh+bJBbmv7AHGyRz36158XhUkK5y
 h4Y3Dc1vSp//iH7OOuWWGsBBfKC4KfUtwoSLUrabHqxz3ngFgBNBY3SGpXDKgtDhkpe1LB6JPjx
 g0Vk53/AyU96EwtbCDyqGCA7fsBo2BeDHS1RuBizvLsbdF/IYRFjdlhRgAffco/ak+puV9yQ2Vv
 BWARSBp210/Z+JQV6K6Bq9
X-Received: by 2002:a05:690c:a:b0:8b0:9def:97ff with SMTP id
 00721157ae682-8b1b5d0f34dmr48524777b3.46.1793291450790; Thu, 29 Oct 2026
 09:30:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-6-alex.bennee@linaro.org>
In-Reply-To: <20261029161310.2065290-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 16:30:38 +0000
X-Gm-Features: AclHuK8fuI1RJkOglTAO1LqC0wX5xGGaemm5802pAkywOTpuW7Jpk3tVMWp5R8E
Message-ID: <CAFEAcA_n38tLnwzwNpOaQjoa92k0X0_zwtvzZ-+j5H5qvXKGbw@mail.gmail.com>
Subject: Re: [PATCH 5/8] target/arm: simplify wfxt_timer_cb to only trigger
 cpu_interrupt
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Chao Liu <chao.liu@processmission.com>, Tyrone Ting <kfting@nuvoton.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 at 16:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> HALT_WFE will always be cleared when leaving halt via
> arm_cpu_leaving_halt so we don't need to worry about atomic games in
> the asynchronous timer callback. Furthermore, a WFET timeout or
> event-stream expiration is not an event that sets the event register;
> doing so causes a subsequent WFE to wake up immediately.

It is the case that WFET timeouts don't set the event register.
But an event-stream expiration does: R_XRZRK lists
"An event from a Generic Timer event stream, see Event streams."
in its set of things that set the event register.

thanks
-- PMM

