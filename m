Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2B9FEFB52
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyQw-0000xK-1G; Fri, 27 Feb 2026 09:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvyQr-0000wq-Am
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:03:06 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvyQp-0008Bi-QO
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:03:05 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43987b97701so1583163f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772200982; x=1772805782; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xC5q7+Jl5yzUXyZ7Rjqp6heIFJmNCHKyWEH47SenFGQ=;
 b=WVi7kOx1ps7WzVlW31smD0tbvJsF4qpRT4hBf0frmg4kitFHtZHkwlxkZ6xnn4MoyE
 creJ4G5qJBM+YxTDg+HUI0cfc7XNGGV/P1uFnhZw54ZoaJSqdW211oZ+MTQRA/HFn22X
 nSgOoDTeh+UFuxGbGfTk0pUmPLlM+YeuLFd6RyiOiMzCKcNYBxNwfPc4OvQsB+j9iKpH
 r5b5tr4xE/kfb+xOcmnDXiVIwmPI5Jl2TpoOYzEVxGY309zUslH3Sq6hWCcBW+SyQZpu
 2GIGpEewxlqlS2cClSbe3eZeUa8paiisvqfcuAFuHkbnvjD6CgIj4Zg7+slXot6e+QBS
 RdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772200982; x=1772805782;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xC5q7+Jl5yzUXyZ7Rjqp6heIFJmNCHKyWEH47SenFGQ=;
 b=JA0nO7dF1RHBW4MgiamI/L72MT70mab5V4KoEL+9kRXuUECupU1So6lPOADMpccMoA
 YRXZwH962+z2NbaKEIvmHGi3GlyJdWfDXiZ3gF1fHThr3X25NfaLMsfS0lbZuX7Igegz
 uzAIBUt82FpAdjbVfOlhdpbLj/ao6SEEGghc094Ti5UqKVTDGM8dHSsdSvAOjaI6VPd3
 yvnd6jEBILnnbrLT67hTOVZTCTkeZ6/gjmZcXxUz+Uk50Ug36rUGQp1qscHAql5pbAW9
 L1OFGpmBrwnywOOCfXjWEMFUBx9GYeE/3O1MtsIdE9SzMqytgVV5ZqpHomDANuavcSoJ
 Wocg==
X-Gm-Message-State: AOJu0YxrIk/1vTmR8ebJshkdi/lhkc/X+VCbkaEAmDSO6IjtjC/ldRHw
 64VaD2vITTcr7HESoJGoXEKB01V/myAsIqXgcazaOJsxowqCKRismMkd1ph1BOS6p6s=
X-Gm-Gg: ATEYQzyCqb/Slcokabske3W2s9mCyHcOEvbt+x0X25jhFXCJyCSOt6KCBpItNGlA/Ty
 i4cxQgUaQsHxQlHLUJVwHKYEIru6muKv+oFdU3TVWNvBw/20Bxc0XXlft+iTlrltukm7xJfjcqN
 aeM/arL2IdlzRm/3dStElgIcsMDMOBW7FpiP7PNUjOsXfCCj1u4nISD7QuRDU8HCfsv8zYQmZNM
 nv3iMzm0dzyGbuAZW9H/8RACqTYdrll5X7Adwg9pgi+j/Jf254nYaLHWTWEYAJQXKhcjURmAzwv
 RaR+e8L2LvguIIZyaPXNKSxCfAhHsOurGlw8Xr5S8mGfWJEJjCBKfwQPYqgLASfGFgZmW1ssnMK
 07nVq+dQzGEY395sU+SwjSfItwg693AlgKi92fWewFP8xy3NftzNVAkoHgp49GkwX6UXXKC03Np
 gUyExof6/dC2DA8Hsdm+Z4PzHmJ2yWkHJVi5Xb
X-Received: by 2002:a05:6000:2901:b0:431:67d:53b3 with SMTP id
 ffacd0b85a97d-4399de30feemr4731998f8f.43.1772200979307; 
 Fri, 27 Feb 2026 06:02:59 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:cb34:dc61:bb8e:b406])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c76b20bsm7473024f8f.35.2026.02.27.06.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:02:58 -0800 (PST)
Date: Fri, 27 Feb 2026 14:02:57 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: Re: Record/replay thread determinism
Message-ID: <aaGkER6O-1eTtUh_@linaro.org>
References: <aZhuzUi4P0-mB-FH@linaro.org>
 <87zf534fpv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zf534fpv.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 20, 2026 at 03:06:20PM +0000, Alex Bennée wrote:
> Jim MacArthur <jim.macarthur@linaro.org> writes:
> 
> > It looks like we have a solution to the RCU patch which was causing problems with the func-alpha-replay test (see 20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp).
> > While this was going on I spent a bit of time investigating repeatability in record/replay and I think there may be broader problems with record & replay.
> >
> > While running the func-alpha-replay test we have two threads reading
> > or writing the replay event log; the "main" thread running
> > qemu_main_loop and the "RR" (round robin) thread running
> > rr_cpu_thread_fn. Both of these use replay_mutex_lock() and bql_lock()
> > to synchronize some actions. There's a third thread running RCU
> > maintenance which also uses bql_lock(), but not replay_mutex_lock().
> >
> > replay_mutex_lock() has some extra logic to improve fairness of
> > locking. This means that the first caller of replay_mutex_lock()
> > should obtain the lock first. However, so far as I can see, this
> > doesn't make the scheduling of the Main and RR threads deterministic.
> > I have observed times when neither of those threads holds the lock,
> > and as such, there's no way to predict which will call
> > replay_mutex_lock() first. This means the ordering of events during
> > either recording or replay is not deterministic.
> 
> The replay_lock was a kludge we added when we did the original
> transition to multi-threaded TCG which involved nailing down the BQL
> calls that had previously kept everything in sync.
> 
> However if we could keep all replay events in the single RR thread we
> could get rid of replay lock because everything should behave serially.

With these modifications:
  * Move qemu_clock_run_all_timers into the RR thread
  * Disable calling qemu_soonest_timeout in the main thread

... the number of record/replay events generated by the main thread falls drastically, and also the remaining events generated by the main thread are always at the very start and end of the log, so should not affect the ordering much.

Rather than removing calls to qemu_soonest_timeout altogether, another option is to modify its calls to qemu_clock_get_ns such that they do not record the clock times in the log. Since these functions only affect how long main waits while polling FDs, I would *guess* that they do not need to be recorded.

I have no idea how safe these modifications are yet, only that they remove the occasional errors we used to see while running the func-replay-alpha test.

Jim



