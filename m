Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CD9E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvdT-0006Ys-L1; Thu, 09 Jan 2025 11:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvdR-0006YJ-R0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:43:53 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvdP-0003Vv-Uy
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:43:53 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so1320339a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736441029; x=1737045829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hACR3wc4fY/kKLtIWBncjlVwPhtx79adSGiaa7XCXTM=;
 b=a8td7EnerOEn5XphEW990Jy2Ikmujdro3q6hbXDTaQajIv8xUxiCTQWaIaoulJKxld
 DZxffSyBvaz0p0StF2pn5DXejaJ0VDlo6U5EgSE6e09GgFE6DQsQC+Wz9LUfRDr+QkF8
 eFQwA1xBrYjQV0jLedPgEU1J2n3g2IVA2OAoEXT+ju2hXBwV0t05yOeTrzb93Yjf/LEk
 2Hb/hXl43h4//D+2jAphlB/DuaPq1Drsq3TD+RP4+j3HaVEGUpzm5KQ53K3oYWL40d+E
 dlT/wuxhEuE7oC+Mb75bW80vHTrppDktDjr4kXm4hS8UvzAlaOaz2m9JpwGeg0QY4QKw
 sMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736441029; x=1737045829;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hACR3wc4fY/kKLtIWBncjlVwPhtx79adSGiaa7XCXTM=;
 b=X/nVO19gg+mhsKdSTv+KfPQ2pAI4bqoTgzXUHadwuXeEfsOSJE71T9W24bgRaEzQow
 Vi1lcz2R/wtvEDgM5GISLxtIszd4/fUpTApM2JD1g3bgqo1ca3uPrPHklrxSMO87V7nk
 FMMcl3sX2dnY0zBdJ43fjauFbYTTf2jZ6tQ0IrFyHw5aLSxC4YB90axaxcCHqPXAFZTb
 QGVpnBtCUIsZ5yrq1WmcTu/5AI20jOoKXP+TJxgXw395yK80y56VcajSDhsdkkC2l8Hf
 bcaxs8/TGO9Yz1OK9r0tyuaF+r2EAmZ+XpX2IdUITakL2YuLlOnNZMirCCYtJ0YcX2B3
 yPdw==
X-Gm-Message-State: AOJu0YyL7F8DS9oUzWJFXW9WKLCnG2alNYl3Mx9OzDQh3LCn7FbLC9Cc
 RynIig+JrcVWbNlTLvuvJU9NQb3IG/OM/MyArv72zRtx95wy3PFB0ZKv2QNqwEVqAeRQKKZ9RKb
 Z2dk=
X-Gm-Gg: ASbGncvl7T6NGvqJrNxi5UNZqP/wemTSg7fqPOnMICIN3UXEB/bX9Jb8KPn7p2fLoar
 RhmDktSr63+lhWZsdP5OMJCywdpUK3w5B/6/wQkNREyo8E+DYPEVmqBPF1F9DUf6lkM/kR96ejm
 ppnY1aR6lh4dEyI9xAAIwANLHmNrAL6QuFhbA+ofvRU2BbqlVN8VeW+7g7MAnhM55pbrCoxJ/Ua
 s9bb7l10mIf3WRDzrrtqJs2N6Vta+OBwTtAro1/OCVh1F40ojJ905E=
X-Google-Smtp-Source: AGHT+IEZadd9gNoWFN0ULnIGeRdIZc/D4zNgWfRoC9HUkrobH2+B+NsdpJtUR1u4e7YgSJtgGECEIw==
X-Received: by 2002:a05:6402:210a:b0:5d9:a54:f8b4 with SMTP id
 4fb4d7f45d1cf-5d972e06cbcmr6868081a12.11.1736441029462; 
 Thu, 09 Jan 2025 08:43:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c4b74sm738250a12.31.2025.01.09.08.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:43:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 544C05F75D;
 Thu,  9 Jan 2025 16:43:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 00/11] tcg-plugins: add hooks for discontinuities
In-Reply-To: <cover.1733063076.git.neither@nut.email> (Julian Ganz's message
 of "Mon, 2 Dec 2024 20:26:41 +0100")
References: <cover.1733063076.git.neither@nut.email>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 16:43:47 +0000
Message-ID: <87y0zk5458.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Julian Ganz <neither@nut.email> writes:

> Some analysis greatly benefits, or depends on, information about
> certain types of dicontinuities such as interrupts. For example, we may
> need to handle the execution of a new translation block differently if
> it is not the result of normal program flow but of an interrupt.
>
> Even with the existing interfaces, it is more or less possible to
> discern these situations, e.g. as done by the cflow plugin. However,
> this process poses a considerable overhead to the core analysis one may
> intend to perform.
>
> These changes introduce a generic and easy-to-use interface for plugin
> authors in the form of a callback for discontinuities. Patch 1 defines
> an enumeration of some trap-related discontinuities including somewhat
> narrow definitions of the discontinuity evetns and a callback type.
> Patch 2 defines the callback registration function. Patch 3 adds some
> hooks for triggering the callbacks. Patch 4 adds an example plugin
> showcasing the new API. Patches 5 through 6 call the hooks for a
> selection of architectures, mapping architecture specific events to the
> three categories defined in patch 1. Future non-RFC patchsets will call
> these hooks for all architectures (that have some concept of trap or
> interrupt). Finally, patch 11 supplies a test plugin asserting that the
> next PC provided to the plugin points to the next instruction executed.
>
> Sidenote: I'm likely doing something wrong for one architecture or
> the other. These patches are untested for most of them.

I've finished my review pass. Overall I think the API is fine but I
would like the arch maintainers to be happy the individual hooks capture
the right semantics for their arches.

I think Pierrick has already picked up some compile failures, you can
see more from my gitlab CI run:

  https://gitlab.com/stsquad/qemu/-/pipelines/1618014020

As you have discovered with the discontinuity issue making sure the
execution state is consistent with JIT'ed code has a few landmines in
it. Given it is hard to trigger with our basic softmmu tests you should
consider a few more aggressive tests like:

  tests/functional/test_aarch64_tcg_plugins.py

where we can pick exactly which plugin we want to use and run something
that will have a lot of IRQs and exceptions in it. It doesn't have to be
Aarch64 - whichever arch you are most familiar with. A test that
includes a hypervisor would be ideal as that will trigger a wider range
of execution state changes.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

