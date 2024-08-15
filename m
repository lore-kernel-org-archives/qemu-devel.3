Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450ACC52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 22:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seixZ-0001lF-FN; Thu, 15 Aug 2024 18:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seixX-0001j3-Fa
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 18:28:43 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seixV-0002Bf-OI
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 18:28:43 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d3b595c18dso1379128a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723760919; x=1724365719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/YSj/aM0KsA1xAad1iUk/mCdrhCou0Er3c0WRTrBiZk=;
 b=AWlQCNwDiIKdiKLQY4mes6kP9GzW300bw+cHRSkZ15aUwN6bLYBi01yQQtnXpYtIiu
 4ePR8z8Jl4DxdYXvT/gN9yf99Rkz6RKiUQUFPrqCWaJ7bP4XcCoEw8FMGTFsiQd/Pqkp
 +UvQYy59GBRnRE2lsi9QLQnpjxp5T3Hea33nejbpwri1hUGTLoYfnzJiQx4XmVSytLWL
 aU45XDuTLrKPS5cR5mH8cIpceg6DVGmVa6WdD7xt6N1wxdcjH6F233X5P1KkXipq1Mrj
 rOE0cQ88tZyKZm+1Bbso9nYK9WSNvkjVOZhV36SwWqqryTRJv7BG409KyTHUoGBPgl0R
 8feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723760919; x=1724365719;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/YSj/aM0KsA1xAad1iUk/mCdrhCou0Er3c0WRTrBiZk=;
 b=YBdXga9IrdFbVEtpodogCGdGDb91dmiluFNMXNG1qph8ryIeylkdgE7ngkdWvT/WKe
 uw7aPYOSKjbEEPMSaFGBDVDPmqLzhEVD/GQZpKtYuv6GojzG9pV93KUu845qu5/8rp11
 bNCvkkh59S2368l/OfhPskZw9dIO9YZh1hoPFGqScf3ejNRv4+bBxrJooPD19VEMZENz
 U7rceNEcqkmU0VfKoSrDJ3H6QDHCSCrvfpOtjWZFjvn5S7n60fRBdkTySMah/UfUNiZW
 oKP06Xgu5Zc6Oa6WmBiH79Nsk8jfjel5Qwj8ffHN2N9GTiiVeewhKa9Phkfqk8CZj/J2
 fvvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLz12jutccSVNCeTgZnY9SFjxZ0Weko8RqwoyrVmKJEwaDldKEfp7gh3R38Onhtub1R2shgvHWJd8FChQYMekgRnzL89g=
X-Gm-Message-State: AOJu0YyqwA+WmdqSLFYNeFxluuTlU/SfSiIB9sVacDNynZ46fkVhppmv
 yY9q0i+FrQ+Nqsde7i/XMZ5V1nicQsIf299EsA0sjzcvFozd1uhMMxW81m5sI7HWzc8Ef+gEMbd
 WWwA=
X-Google-Smtp-Source: AGHT+IGEGDQuXPGZhEbh+/+CGIdyyVWzmcZOPNi65hmmMXbeU+jBrZ8j65C6JtnevJy5kkoHAyHHiQ==
X-Received: by 2002:a17:90b:1083:b0:2cb:4c30:51bd with SMTP id
 98e67ed59e1d1-2d3e45f6011mr1022522a91.19.1723760918999; 
 Thu, 15 Aug 2024 15:28:38 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca327sm4110126a91.12.2024.08.15.15.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 15:28:38 -0700 (PDT)
Message-ID: <f0f5f04b-9ffa-46ad-bb2a-a497de3c1c41@linaro.org>
Date: Fri, 16 Aug 2024 08:28:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for 9.1 00/21] Some fixes for 9.1-rc3 (build, replay, docs, 
 plugins)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 8/16/24 00:48, Alex Bennée wrote:
> The following changes since commit b0d6c037ea0a825192285f149af72a73a1baaa04:
> 
>    Update version for v9.1.0-rc2 release (2024-08-15 20:32:37 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-9.1-rc3-150824-1
> 
> for you to fetch changes up to f39cbfc9f8dcb17e8168735acb6fb75638d9904f:
> 
>    plugins: fix race condition with scoreboards (2024-08-15 12:10:23 +0100)
> 
> ----------------------------------------------------------------
> Some fixes for 9.1-rc3 (build, replay, docs, plugins)
> 
>    - re-enable gdbsim-r5f562n8 test
>    - ensure updates to python deps re-trigger configure
>    - tweak configure detection of GDB MTE support
>    - make checkpatch emit more warnings on updating headers
>    - allow i386 access_ptr to force slow path for plugins
>    - fixe some replay regressions
>    - update the replay-dump tool
>    - better handle muxed chardev during replay
>    - clean up TCG plugins docs to mention scoreboards
>    - fix plugin scoreboard race condition
> 
> ----------------------------------------------------------------
> Alex Bennée (2):
>        Makefile: trigger re-configure on updated pythondeps
>        target/i386: allow access_ptr to force slow path on failed probe
> 
> Gustavo Romero (3):
>        configure: Fix arch detection for GDB_HAS_MTE
>        configure: Avoid use of param. expansion when using gdb_version
>        configure: Fix GDB version detection for GDB_HAS_MTE
> 
> Nicholas Piggin (10):
>        scripts/replay-dump.py: Update to current rr record format
>        scripts/replay-dump.py: rejig decoders in event number order
>        tests/avocado: excercise scripts/replay-dump.py in replay tests
>        replay: allow runstate shutdown->running when replaying trace
>        Revert "replay: stop us hanging in rr_wait_io_event"
>        tests/avocado: replay_kernel.py add x86-64 q35 machine test
>        chardev: set record/replay on the base device of a muxed device
>        virtio-net: Use replay_schedule_bh_event for bhs that affect machine state
>        virtio-net: Use virtual time for RSC timers
>        savevm: Fix load_snapshot error path crash
> 
> Philippe Mathieu-Daudé (2):
>        tests/avocado: Re-enable gdbsim-r5f562n8 testing U-Boot
>        buildsys: Fix building without plugins on Darwin
> 
> Pierrick Bouvier (2):
>        docs/devel: update tcg-plugins page
>        plugins: fix race condition with scoreboards
> 
> Stefan Weil (1):
>        docs: Fix some typos (found by typos) and grammar issues

Patch 19:

ERROR: pull request includes commits attributed to list

Please re-spin.


r~

