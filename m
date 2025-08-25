Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390F4CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTE8-0007Fk-IU; Mon, 25 Aug 2025 05:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqTE6-0007Fa-RP
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:10:54 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqTE3-0005uL-Du
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:10:53 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-61c5272afbfso2066273a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756113047; x=1756717847; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVs5lbKDxwXzJhBSXIXY8cc13DAY/gkeOBxZH6b1zEE=;
 b=xdSp3eQ1B/Fu4UolDWjW6474rQ89RPeC+4oFAoM/5JjqyKiXHx2jEclRhKA1zBFOoT
 vAJQxnpbZeWY2xb45XgmKqwBnK/IkjZkydoGegpAST8aJsbfwXRgbWarTJuE7x94QBeA
 4+3gHzt6qDBcBoDWxuXLmF8Vg4bbYUGAVO58l3ylGIOUDyAwEO9etcAMoBQDc02xxrA4
 JPvOLdCN6FWwqBU7ESOfp6nAdO7bkhXjR5DhbBXlAUIx5J0lSZCeUyhv1jBOmJ2R/xq3
 xGxC97f45egzkojCYs6/d41Ro05+/bBHvS3pzV3p8MQKZUG7WVQINfvKAbifXS/0FtHH
 7E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756113047; x=1756717847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVs5lbKDxwXzJhBSXIXY8cc13DAY/gkeOBxZH6b1zEE=;
 b=Fgr86AD7Hhgb6n7auJZB7V3UPIFaXJ6gxPkV3eWEJIBK4wZijvRGVKazLs6rtNlbYr
 gkaRKpBIneDbvzuLSOv2c+TyEqC9b8HDldrqx7Elzvcd1cAz4/UJ6/SdIhIihRVumC6h
 oX9cSQQmhz41lSHpwqUWXi6tENbOnchFyMQ2dCMaSiFqhTRiX4DrTZCP3nn32e+pzn0v
 IDNyWerRvpPIVvZVpUBRtjdL4jD7fyv7CWN9hYT2VDuZR5/NHt+oNRVO1MGLSor3nM+H
 rQHc9uRjEscCzno9kRlEOwWhjdxuOuGKlXBqPAueVJub4qLvqzsiQLcYwBDhk2b9xDnH
 EzYA==
X-Gm-Message-State: AOJu0Yzq9+F0GN6sVkbUNhAd2jZz8+pfGjUVQctuhx1gkHqxRiX/Za8C
 Z41KsEgQErZr5tkp3Ri5WO/ZT79GsjImfXhJd1VwiM0be4d+8glmyK0WSrxA1F53MqmAYQiofzQ
 z3rywbL/MZq3Rz5rsWKMfZpiQiCQBKzRM4E97MGA1Hw==
X-Gm-Gg: ASbGncuQ5J8Jzw5sBcQOu4pj0vWi4obfPN54C5qN5KRbVo3Fz8f+D/09+ilc5NcSRQP
 0zbEQAju1MxKHYoSp0YppsNV/3nHGxUXxzaGYsVl/W7vVJrvmXXU6WxyWNykcpv3Qdfod2LVW1m
 Wa57gz8hcOnKZuxRb3vdX661XvpoSj17T+EuO9+3W3flZ9R3zoC6+stgXvVxj6LM1jeKC5dqkBW
 ThJL3/Lj6MgKWj+7F8=
X-Google-Smtp-Source: AGHT+IEL4OpV6FIeXb9j+ilBp+jSBmrh7ZYLCLxy3HVQ2FB6mrS4CDYlvMtL0UiwsI9ZQcigt6kI0S0flYs5/ozamNI=
X-Received: by 2002:a05:6402:234e:b0:61c:527b:1cda with SMTP id
 4fb4d7f45d1cf-61c527b1f86mr3920986a12.18.1756113046628; Mon, 25 Aug 2025
 02:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250821094735.804210-1-thuth@redhat.com>
 <CAAjaMXYt4UBS-2wB2OiSCE_DA77STWAjWvPdv=NtEGsUoSyFPA@mail.gmail.com>
 <b60a9e7e-6f79-442d-8a4c-2acfbbf0688b@redhat.com>
 <CAAjaMXY1fcTZ517dmrd+nAt4WUEcR3U2bbmM3ZytDkXREEX6TA@mail.gmail.com>
 <c6b38976-6fbc-41e4-a051-36025cb9c297@redhat.com>
In-Reply-To: <c6b38976-6fbc-41e4-a051-36025cb9c297@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 12:10:20 +0300
X-Gm-Features: Ac12FXxxkMuJVop_g_ALiS8HBP_HiCOdDj2hdDshfX9XFqisq0wJjKT8lKtanH4
Message-ID: <CAAjaMXYccR=Smz2NQDM=tN=0xodTJ+9_f74fqZ+z=MUO-vHTVQ@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Use more fine-grained locking when
 looking for free ports
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, Aug 25, 2025 at 12:04=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 25/08/2025 10.51, Manos Pitsidianakis wrote:
> > On Mon, Aug 25, 2025 at 11:47=E2=80=AFAM Thomas Huth <thuth@redhat.com>=
 wrote:
> >>
> >> On 25/08/2025 09.30, Manos Pitsidianakis wrote:
> >>> On Thu, Aug 21, 2025 at 12:49=E2=80=AFPM Thomas Huth <thuth@redhat.co=
m> wrote:
> >>>>
> >>>> From: Thomas Huth <thuth@redhat.com>
> >>>>
> >>>> Currently, we have one lock that is held while a test is looking for
> >>>> free ports. However, we are also using different ranges for looking
> >>>> for free ports nowadays (PORTS_START is based on the PID of the proc=
ess),
> >>>> so instead of using only one lock, we should rather use a lock per
> >>>> range instead. This should help to allow running more tests in paral=
lel.
> >>>>
> >>>> While we're at it, also create the lock files without executable bit
> >>>> (mode is 0o777 by default).
> >>>>
> >>>
> >>> (Unrelated to this patch but the file itself)
> >>>
> >>> Hm. AF_INET supports binding to port 0 to connect to any available
> >>> port (see man 7 ip). Is this not portable?
> >>
> >> No clue ... but in that case, we'd need to go back to only use one loc=
k for
> >> all tests that are running in parallel, so it might cause some more co=
ntention?
> >
> > IIUC there would be no need for locking, since the kernel would return
> > a free port for each process.
>
> That only works within a process, doesn't it? The problem here is that th=
e
> test itself does not open the port, it just first needs to figure out a f=
ree
> port that will be used later.
> The test then launches QEMU with that port number, which will then open t=
his
> port. Then the test connects to that port number (which it must know) to
> interact with QEMU.
> If QEMU is using port 0 for that, the test might not have a way to retrie=
ve
> the final port number from QEMU in all cases.
>
>   Thomas
>

Ah yeah, correct. It depends on what the test wants to do with that port.

Thanks

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

