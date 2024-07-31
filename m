Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8804C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAO7-0008TW-58; Wed, 31 Jul 2024 10:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZAO5-0008So-Sz
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:33:10 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZAO4-0001kY-B9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:33:09 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc346ceso8224838a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722436384; x=1723041184; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YCN/rAfJQlh0rVEFLX4lBzMCM/vq0DJ6IDayn0JoJk=;
 b=QEv5I7Les8IOpJIPCO70/M4vkARquEEn02KrP8Ib7QfHO6TBFPBy95BfibCUJaTm+F
 WiPGIT28l7lguYgJmB3fL54vewhsDERq8PVZngaANPydrnhaAE+D5W1bf7B+9TqcrVxn
 GfUXowuQ0e6Qzz5T6oimgrjY7XvQc9g7revoNzQplLBgLPH9p6Mf0Y0HsQlVyqcEV3kS
 V1gsfSneQg+LKPldFmQsHkkScT4281U91tRJSMr274xpzZfL7MAsnvT6GMs29NMjnmX9
 p982fzzUylDGcVBA4LJw+6l4a9Ir0X4F5I2kgF1rGE8DMLHQdkBPeYX8SAsJhYIM6FWS
 8qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436384; x=1723041184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YCN/rAfJQlh0rVEFLX4lBzMCM/vq0DJ6IDayn0JoJk=;
 b=clxNWLElrHmHjk1MDezYjQzc6UjidZRmoALh5GK4CHycuymRHSKbCHxBus8wQM2NUP
 QEuEhty0gslaj8ApwhX+f9RPRSTIjHEqwpaRcPjnsKRhlw65Nt6a/1W0X7p+3tP6DLya
 RF1N+DEy7a3nCLsDEzjKQM5mKEvn/XRxCq49iyiuuOis0cbB+NYqLPDILaG4lNiDjp12
 DhVbegnf0km/fq3iMKWHaPt501rHqfodUbZpfG7UGT/c9somxtoQA+3a844RbNkeXil1
 EHPGlENkh8G1Co7SXLda3ifeNq52E2FsLiLXAEOA9AEdcy9svqBCGkbJ6D6qvQS1IA1W
 BkUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWffi1hP390alv01cD3BmK6kEFAqfxfFNeOmadg8cdyZHanaN2Yr0ihRP4hrTFg2VzWBOgoCThkqwTatmBHqwXt/8xxFNs=
X-Gm-Message-State: AOJu0YyyLaLbF9qqwAoy0gb5tjB7hG5ALFVhzdGQrg7EWCbKjw6Tv54r
 hsv4wwCurYGk5iKpSfDt9hnchQ8w1o3jFZn3fgFcHUHaHLU/EzeULnyFKXIYXoT0bai+RQh8Apb
 TzShjQc+gQWpD5x5E7U2ZYkIuHhmL/SpfYqotqw==
X-Google-Smtp-Source: AGHT+IF863RjCgYdVYznzmle4Jyr0l/hPNBqjAGaY9VOrzNlLECym8I2dhLnnqmpMEw5oeSeAV/jtnaqaxKF6i7f6eA=
X-Received: by 2002:a05:6402:40d2:b0:5a1:f9bc:7f17 with SMTP id
 4fb4d7f45d1cf-5b02010339bmr11547922a12.5.1722436384016; Wed, 31 Jul 2024
 07:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240731132524.308273-1-philipp.reisner@linbit.com>
 <ZqpF6VoZgFsfhhl7@redhat.com>
In-Reply-To: <ZqpF6VoZgFsfhhl7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 15:32:52 +0100
Message-ID: <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
Subject: Re: [PATCH] util: retry open() when it gets interrupted by a signal
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Wed, 31 Jul 2024 at 15:11, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Jul 31, 2024 at 03:25:24PM +0200, Philipp Reisner wrote:
> > As with many syscalls, open() might be interrupted by a signal.
> >
> > The experienced logfile entry is:
> >
> > qemu-system-x86_64: -device virtio-blk-pci,bus=3Dpci.0,addr=3D0x7,drive=
=3Dlibvirt-2-format,id=3Dvirtio-disk0,bootindex=3D2,write-cache=3Don,serial=
=3D1b990c4d13b74a4e90ea: Could not open '/dev/drbd1003': Interrupted system=
 call
> >
> > Retry it until it is not interrupted by a signal.
>
> As you say, many syscalls can be interruptted by signals, so
> special casing open() isn't really a solution - its just
> addressing one specific instance you happened to see.
>
> If there are certain signals that we don't want to have a
> fatal interruption for, it'd be better to set SA_RESTART
> with sigaction, which will auto-restart a large set of
> syscalls, while allowing other signals to be fatal.

This is why we have the RETRY_ON_EINTR() macro, right?

Currently we have some places that call qemu_open_old() inside
RETRY_ON_EINTR -- we should decide whether we want to
handle EINTR inside the qemu_open family of functions,
or make the caller deal with it, and put the macro uses
in the right place consistently.

I agree that it would be nicer if we could use SA_RESTART,
but presumably there's a reason why we don't. (At any
rate code that's shared with the user-mode emulation
has to be EINTR-resistant, because we can't force the
user-mode guest code to avoid registering signal handlers
that aren't SA_RESTART.)

thanks
-- PMM

