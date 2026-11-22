Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5A606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fCjptVRn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV3pa-00060s-0O; Sun, 22 Nov 2026 04:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xV3pW-00060g-QM
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:25:51 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xV3pV-0006xJ-08
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:25:50 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67dae7d3f7dso2828926d50.2
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 01:25:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795339547; cv=none;
 d=google.com; s=arc-20260327;
 b=sJgfq7Lt9ICLfcjYVuIHnrbBzKPKcugJuuk5lJuJy+nbN6qWs6/xt00wTcDlcOgsKB
 V/aSQ2dYceiTWP80AbCTl7kXqOqIxQAqvVcalQ0ay7dmqsECwAXxJ2Gpxd8TvzM/BmOn
 ugYfWshWgVkrMEsDwCWcmr73gwcZhOSgxs4MVw7aUDmdhPm7sSlXymeDFLtVB+mwtbc/
 ijyjeQGtbjFeDMPVJV04XjFkNNY5qwrQPsJWmt0/t+Put10tD2MsuXphdM1JeyLIRUVT
 3kv+W25Oia72EXOOMCKKt93iPfrwdtjEWnbc9reIdqijBPPqesln8VZc0NZQWV5iRVmC
 rCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ps869aHsO96rvkQt2O2vx6xO+s30w8hXFUCM6/Ckzas=;
 fh=Qph2jk63x1lfk6l1bsZP8aNHVrvi2CZcm30+sz1vSNY=;
 b=buoyyMjufqc/V8kOscLDg4lZSWphLCU77gDj9lelCM+ki57dFTYHQ12/2ZykJC/RIt
 4A6c58W3FVUR3UxbFVij+FpA22OgaTarRO39tqXGFsdanli2CQ++qhKWCAlgIQLQID98
 OwmIrjDqzEHIiaA95fhIS8HV0O8rCASoerAutok2yaeLe3WdgNixtoAipXEn6UFNvNFc
 cafiMBt1PPZf4l85D/j8i+q4KwfOwJFCMhPxIrcYZ9lln+oEs2s4EdQuQgFuFf5/wwS2
 EF93wsl2kt14qdSJFQpWBOR5oD1buKuTEjEOVxO0Vt4IyuAMLGerGq2kfWOQB37MFQZp
 sSJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795339547; x=1795944347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ps869aHsO96rvkQt2O2vx6xO+s30w8hXFUCM6/Ckzas=;
 b=fCjptVRn9h/D/pyxkua7FOsyFu4hpd+SurXvOnrpAN5uyNUroDD3n+AmeVUdwRqnfQ
 GTET/D7wWKQDefsQJP2ug//g2D9LLoujxRFpiIKnnvZSH9H9ONOi2yakdJ06YeJj6fFj
 eAP8aJLVg2Kt6ogf9KF+BBR2NrICHphOMZ5siU+AdO7gkG0WTI8TtMXtSw0gUHd4Q1mt
 maXy0rDdSAHTsePBA0QrPPbUlLVVB1HdeqP0htkmCZeUshrrfZIbOXJYx7yFmJFAfXXE
 pJTM/D73sT/6zrodP/0dkNm12gdZybRDlTXOsDfYDOtBdFQDct9vQXtTNuCKhRsbr83w
 3Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795339547; x=1795944347;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ps869aHsO96rvkQt2O2vx6xO+s30w8hXFUCM6/Ckzas=;
 b=GUR6TljN1/tNBWj1MQAYPJo+xaCJ0QWrJu2bVxSqoWeOKvLfQPn69kX83t6/JaAULp
 ED2s30YPbNzxETurYh8tEBuj5RIPp+K7y9cHgJFNn8plHT9xPVHMj122+gCvqKhKHE/0
 cGyLgpjPIf/kl/2ZA2X+9E5jbvCPiwRKW/P6wCA41paxKpsqPXUos+XPXbLP/3aU7ldu
 DZmVv6KVU/ujbZEsWLn4heiih1DLET93Srt08+vw76/aYYML0GjpKkyGL2DaZlB+bKSk
 y09pLNnQOMloRVzHMNHV11UQisRmHwqZNHsrt6IoD8ZpXz1hbE6x7kIUOlayeU58yUbO
 NQ+A==
X-Forwarded-Encrypted: i=1;
 AL+hErEkm2ySLbQHWBrtMih674QqpBsqHfPQzVtZUs6nlySOtqqxtPgtFceP1OTRaKFG6mSMZl9lKDOcq4gu@nongnu.org
X-Gm-Message-State: APuU4Z9Dk/jR7DyKP7SGKo1FzaZtg3A86a8GsEIJ0tOWmCAglqb/HcPc
 zQPbTSYuym1TEmFim2RXZVgjtxsGI2LZNJvuNv5eN9UVkqoNL/GESgtSwn9wWkzlsxpXuBxP6Gq
 FrV8GEUGfckLvvseQ9UHPeuzYTMMjLkju8QEr0kC9UA==
X-Gm-Gg: AZFdTZdeOefCBCwfpUC03bS9sbxucrqXAUMByDeIqOR2cdy/23J7XAjIyut1ViohoqP
 AMfjIKdW9PtySrTHpf8xR06q43VDqOONGP02S3qggEGCfzdcj9+G3nHITpMcbgzFP8s5S4Jq9Lm
 0qk0U6zxNcOO0RX42RSmFlq2Io0hIwrzTxHKBn1OghGYwZIdVmnrKio5SJJMhD0KiEF12qyffTv
 HI3P7zY/gDFftDKE3uPEgAkcX4ToSneYqjANX3murs3arMcL0JaT55Bd/xIUtM7PTx15X91Ttqv
 6QnceXCRVIRPWee68ru+B5ARSK+S5SISFSB6zJ+RgQ6V1HJs7B6bVJwHrle6NzgpFIDBYmjbrBV
 KD7S3J6bmgr9JjmIVJFGwtTEB8bF/0AZaj6LSvekLb6mtGHqNB4rlMKyOsqMz5rYsb/3yJvfWMM
 z3v4aQ7nLHl60Q2LBTKcFd
X-Received: by 2002:a05:690e:1697:b0:67d:a31c:4f8 with SMTP id
 956f58d0204a3-67df44162dcmr2491355d50.58.1795339547500; Sun, 22 Nov 2026
 01:25:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-3-den@openvz.org>
 <CAFEAcA-Bc_Lev19s7=UjokZKjxTgDkZRYO-hbPMexj9BXqs2xQ@mail.gmail.com>
 <awBzF9i3fo1KRGMk@redhat.com>
In-Reply-To: <awBzF9i3fo1KRGMk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Nov 2026 09:25:35 +0000
X-Gm-Features: Aa3M54rUjOchfJHFz5-MeRcPEMdKaKfjY7Zr1GNi2hI4SnEs4aJf3vAGF41TVOU
Message-ID: <CAFEAcA-WddxT4s+aAuyuz7SzgQeMT2zEPeix2x_7RCMByEWY9A@mail.gmail.com>
Subject: Re: [PATCH 02/10] oslib: add qemu_debugger_attached()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Fri, 20 Nov 2026 at 16:19, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Nov 17, 2026 at 02:38:44PM +0000, Peter Maydell wrote:
> > On Tue, 15 Sept 2026 at 21:36, Denis V. Lunev <den@openvz.org> wrote:
> > >
> > > From: Denis V. Lunev <den@openvz.org>
> > >
> > > Code that watches for a hang has to tell a hang apart from a debugger
> > > stop, because under a debugger every thread stops and whatever livene=
ss
> > > signal the watcher samples stops changing with them.
> > >
> > > Linux reports the tracer in /proc/self/status and Windows has
> > > IsDebuggerPresent(). Answer false elsewhere, which leaves the caller
> > > behaving as it did before the check.
> > >
> > > Match the Linux field at the start of a line. The Name: line holds
> > > fifteen characters of comm, enough to spell the field name and appear
> > > ahead of the real one.
> >
> > Should we have a mechanism for the user to force this to
> > claim "no debugger present" ? You might want to debug the
> > watchdog mechanism itself, for instance, or maybe you're
> > running QEMU under something that looks like a debugger or
> > process tracer but which isn't going to do user-controlled
> > "stop for arbitrary time" (e.g. does the record-and-replay
> > tool "rr" appear as a tracer for these purposes?)
>
> "strace" is going to be detected as a debugger this way, but it does
> not  halt execution of the program, merely slow it down a bit.

Right, so it would be nice to be able to strace the watchdog.
At the moment with this patch that wouldn't be possible.

-- PMM

