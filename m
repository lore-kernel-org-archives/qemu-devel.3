Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1D3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL1lu-0007dV-Jc; Tue, 10 Dec 2024 10:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL1lt-0007dF-Hc
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:03:33 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL1lr-0005mX-U8
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:03:33 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso2806915a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733843010; x=1734447810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIqvOj2Ag1pkyQNkamUunetFCJNsO59C9/GhBShPoUo=;
 b=donTNwGgenDFK8ML68EcnM1SvJ6Ed9qKgEW6Ww0O5xWkQPQA5Ca1uE6C37iTdm5Cvq
 /3G0sTPubzGc8fgA8wZhf8JldYxGEmH7HkcKTPqLddC1m8u8BS0G0r6VzIQBAa+2tqrC
 kjXc8r5i45UxGY0yvdXSogsRzBYByqpf/LZogHwO0mIJ2DFAozUASFy/dTe1tdMtdIb/
 edyVxeprYKHjit6nu7j6TW4hKw9OpU1Dxv8Dv5ftL/d/MHhwp3BNU7Pj7KNjqVqbWdM0
 eJeoWLxw2A2e3WUdhvMPqJUyVU4LAg6LZpWpl+DAdOrvsP1eFMoXWe0hquIx2NG/YQnN
 Nygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733843010; x=1734447810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIqvOj2Ag1pkyQNkamUunetFCJNsO59C9/GhBShPoUo=;
 b=CrxjA0vTL00CS/PhyHd8YxND7UU7bvT6GughrSZcAcYZmhZHDmngVfDfj3mKhW5vfX
 vUGAjSGRPnX/cUgEHapGslfNiOjOb807gkH48EQWNrjDM1ci/WDgiIFbuQEVDyuM5ngu
 p+CqTBFqVyR4DEzk9s8SH3c07dMZxV76nl/wi+n29I/Y5cVHYGLkaHrg4vjvCzabai91
 IywTWSv3qZRSNakt55X2GjKBZyiuKyvNnxytWXwC3OxoQMKdexK3FXeSwodeQ5Ocn9lT
 V8z8xZbuBA3pFLlSUPyyNp7/OCBCJXrsMnXUHI0i/nBSa6NLq5jDDPqohBnopVa0y0oV
 8j5w==
X-Gm-Message-State: AOJu0Yzv8ISL9p/3+k+KlRR66Q7wsMsMsKVhES43smsv1R52oa/XfpQ+
 1t2K8xBCiTlaCR/4mrZmKPacR+tRvH1dDv8LDWQkqtpWGaSW/cCxr1NQ4VhSgfGdiR7959j09lX
 wS4Giiu+ndaJJU2eoVVzU2ZwuslxGDCy4ZmeqbQ==
X-Gm-Gg: ASbGncs855PhOj+aTl/8VFgcN5ajsXs/Qa9Hfp8gmdp4Y1c0OOUE0fxwmg0/3JAFEOH
 JpNFhM+HV+MbvONhPWRWmhmng5oUapnqSwtsT
X-Google-Smtp-Source: AGHT+IFK3XztzMpE8PAm6wx9N2bpAw+SxXABUadPcjxP6Bxe1OuQ1K28G2Nrqr2EnMersKBv1G3b1uGgq1AWjuMXTsk=
X-Received: by 2002:a05:6402:2350:b0:5d0:e570:508d with SMTP id
 4fb4d7f45d1cf-5d3be695c67mr18009431a12.17.1733843008739; Tue, 10 Dec 2024
 07:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20241210140112.43313-1-philmd@linaro.org>
 <CAFEAcA_ZpeLop95ELDHn696cN-6OL3pC95Dwea934RLH3SpSAw@mail.gmail.com>
In-Reply-To: <CAFEAcA_ZpeLop95ELDHn696cN-6OL3pC95Dwea934RLH3SpSAw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 15:03:17 +0000
Message-ID: <CAFEAcA8qNrsViuQrCeCeh=2s-2GF2yXOc9d1qFxAcc+Knw0PDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] bulk: Remove legacy cpu_physical_memory_rw() API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 10 Dec 2024 at 15:00, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 10 Dec 2024 at 14:01, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > cpu_physical_memory_rw() API is documented as legacy
> > since 2017 (commit b7ecba0f6f6). Replace it by a more
> > recent API. Noticed while discussing with Peter:
> > https://lore.kernel.org/qemu-devel/e979b3ba-e701-4ac6-962a-19e4598ba947=
@linaro.org
>
> I'm not sure we want to do this as a bulk automated
> transformation, because in each case there is likely
> a better thing we can do with the call than to use
> address_space_memory. For example most of the uses in
> devices probably want to have the device have an
> AddressSpace property that the board wires up.

Also, examining each use gives us an opportunity to
consider the error handling (cpu_physical_memory_*()
drop errors silently) and whether there's an appropriate
MemTxAttrs we want to use.

thanks
-- PMM

