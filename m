Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDA6C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 21:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSOFW-0008V4-PN; Tue, 23 Jan 2024 16:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSOFO-0008UO-30
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 16:23:55 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSOFI-0006hn-AG
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 16:23:53 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cf1fd1cc5bso76191fa.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 13:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706045026; x=1706649826; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TyxkbOp2hplD3Yn6XW8pzAsdTTFoZaSbz6e9yJIbJYQ=;
 b=ldjytA38B5opebtROa0jswWRkqwkJNSF++UOi7o7uGuATSiqcmaWB7An6JUDNK4NPk
 AVkqWSv3s7PQPMJwwUP0soakHlFJdMX4gCqxUUB+ZPwbehNj0sbUzZi/eg/nFVvuU3z/
 3Gx0LoFGJ/LdgOlc7xtF1aP23JmjFOIYfkhpkLIEhyrtC7fj2VQRmkEcrv6G4niLGqd7
 WeHMmqC+addKxG6LQVyps/aKO6yxyKeXSys/f8BC/D7xt2z2xCOZJZ1iw7YdpkXxikIh
 vs8rzedHkQ1KwcVUAL8ylVbdKofy2dET692+XdcMV19yc7om8kNRzfHbe732tObJFQ6a
 mbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706045026; x=1706649826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TyxkbOp2hplD3Yn6XW8pzAsdTTFoZaSbz6e9yJIbJYQ=;
 b=PIoXtK+ArdjPvZbs2APPcuoKpjzaMHbGx2R1butuboM0Ywi3mgdPUTY+ejG8KPV0T8
 gwn0w68tjyOPPoEuq03Vab1QlSwJW5CH7XCPZ9iF+sKXv4WXjaoj0rtpMGmlLt0sDGyO
 52nY6MTyZOGMCAlXZT3vY4DbFCfY0+cGRpWHzXaOpqTxJmryfwl/8FQS70M4uIXU3xTO
 wGtNt/WKNEwX7z9g5VlaU8CmBc2igAxmmjnbQhkTRZM8d1AZuPJnTwm1nMexoTE5lTPp
 rqjRKTSAgAffHdQRPHjiV72M9/bwrhtDC1qpvLTMlLzIMdQXJDrmmlHj6xsqLheF3JmR
 c9/Q==
X-Gm-Message-State: AOJu0YzKE7cz20zO5cj43RY2vnnTuQs6Qdz8HsEdoIk71CIMtMv7YO/C
 6mRoIWsckM/5WH067K6pTySbQt/z5QMsiOV/g8LIevF0Y/YDZg9B8XEfyn5/YnfbaaVCv9XfszP
 zFIJ4ih9ZAP9i3RiHeRGHyILyoXp5+0sBGuy5RQ==
X-Google-Smtp-Source: AGHT+IFk66upI90/RT9r0MLvKcEyQc/qKuFAR7rLpn0nxbOqHZYI8DqMtR+FtJTX/mKJopY+wZ+aS1NAhhjDRMkSvEU=
X-Received: by 2002:a2e:8199:0:b0:2cd:d7eb:4fce with SMTP id
 e25-20020a2e8199000000b002cdd7eb4fcemr255645ljg.80.1706045026325; Tue, 23 Jan
 2024 13:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20231215070357.10888-1-thuth@redhat.com>
 <db19cdd7-4049-4b9a-9108-c1f05f992d89@tls.msk.ru>
 <2a8e7077-0603-4455-8b4c-69a4200dd280@redhat.com>
 <6d279ebd-fa9f-4839-97ca-7921679392f5@tls.msk.ru>
In-Reply-To: <6d279ebd-fa9f-4839-97ca-7921679392f5@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2024 21:23:15 +0000
Message-ID: <CAFEAcA98EEpavYbZmy8WgJ2-Aq5uyhft626qNk8Jt17BM+7Z7g@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] tests: enable meson test timeouts to improve
 debuggability
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 23 Jan 2024 at 20:52, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 23.01.2024 20:47, Thomas Huth:
> > On 23/01/2024 17.50, Michael Tokarev wrote:
> ..
>
> >> I'm picking this up for stable branches too, since there we have the same
> >> problems in CI environment. In particular, bios-tables-test almost always
> >> times out, even hitting retry doesn't help.  Let's see how it goes..
> >
> > Uh, wait, that does not make too much sense ... if bios-tables-test already times out *without* the additional meson-based timeouts, then adding the
> > meson timeouts won't help. bios-tables-test uses the manually coded timeout from boot_sector_test() that is currently set to 600 seconds. If you hit
> > that timeout, that likely means that something is really broken in your branch - or is it sometimes still succeeding?
>
> I mistyped the test name as I was dealing with bios-tables-test at that
> time in another context (unrelated).  Actual failing test in this case,
> among others, is avocado acpi_smbios_bits, eg
>   https://gitlab.com/qemu-project/qemu/-/jobs/5991505589#L231 which timed
> out on multiple attempts.  In this example it took a bit less than 65s.

The fix for that flakiness is commit 7ef4c41e91d59
("acpi/tests/avocado/bits: wait for 200 seconds for SHUTDOWN event
from bits VM").

thanks
-- PMM

