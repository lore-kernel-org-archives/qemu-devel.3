Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE73AD29FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 11:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfzPr-0003bC-VP; Wed, 14 Jan 2026 06:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vfzPj-0003Vu-2h
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:51:55 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vfzPg-0002i1-Ib
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:51:50 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b872de50c91so402400166b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 03:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768391506; x=1768996306; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZW46qC+KjQrZpFG+imn0fOacc1NDIublk+rlApwKI8=;
 b=sbEb6Y8KUZs4bmU8B10tPKvdhwIUAlVnfO0D5DzvkDRzqWLdYntVk/R7MdVEQd4Q2R
 z0jLi4chc/5SH+mwtQgZ2Rvp2jDrQv0lgWdUmKvnhW5haOncr2aFuL7fpqay6KsMpM7e
 BIuoTVqmwIe0Xg4D9h9Mtnofd0Xe2Gt9/+67Q+vVphZzq2OXWt4zmbByoItnYeOQTaJG
 QMmKYysY6KadD3VY++n1AsFg/Fq8x5D1YCoHOumxstE7EDMCxdaoERaaTIakvSbpFqsR
 Tq/uRc9aOs/O4YMdCKiQUPeZawaFRAT6eujgWJfk126TwKXffYXWGFZQKHtTdMsHm3B/
 SmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768391507; x=1768996307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VZW46qC+KjQrZpFG+imn0fOacc1NDIublk+rlApwKI8=;
 b=BNd2IgJIvcYbAQZcgNtIa1w0jy72wMDPGX33EBVv323WPBYGFORhoqd8IM8sXD8ea/
 bneFEegzdtEt0Ow+gDc/6aeJpZw40jemwjqouMnVVipzr2SjvSnqrgPEu3kQcpOrwXPN
 gPpKDiVY5GFaTaU22u+79qI4d/vAGukit9yAccxHEDKHIXjCTMCZiGlgUW0WOX+qjT6B
 0x/KvV1guSN7gB39+kA+bEuCjBJvvj/GyCGMqqlOCtV0fSicqk0m4Jmx7iAXIOqj3sEz
 Y/7o5q30tsH+UkUO0fAGaAVm+vCmLxPhnKnfe6siVNV4bzIO5zw6esLvw3QWoZpYBBhI
 NeFw==
X-Gm-Message-State: AOJu0YxGbZJkNcKhF818ZADZXNWMk3UebHH/sG03Hfvxj8rdaFNdXK8M
 Iqj+UZbgRzwGO4Wr4TB9woEIirRHRP/j+26VkN7+rSTb1pMKeS1cC6vEHqAGK0nDgyDm9hncWa/
 Q9B+5t3gIX5KXkcIOWbdFF4LHyzxlwCD4EP8gDlQR8w==
X-Gm-Gg: AY/fxX7zunKXxUFcDD+KEX+WkhirO2r42KWMZSNvRCQMVHHHVKGojfAfToWF02d+lRi
 Xv1/soDtLtEo1Mw8ABYNwN+17TgVvjUy/RivEx6peUa+97BoL8ehRSrhrPl2Jb8XhHF41lI7qtl
 6FVLVr2uSruxhDtEitbEoSqGKHhs/XqxgZkvSlF4dQXgUi7YFFbg7AZ+rhPR4AbFUvJng6d9zRj
 ycoRJSYFr72yd36wyC0ekMQ9NVHazhQhRReMM/nsO2CU4+2Y6r/+Jy0OBgGADhoyScxtltxgZM+
 guu4aDeNZDxFvVTcFVh0dyh27S6+fLZNAi6i
X-Received: by 2002:a17:907:2d13:b0:b87:2f29:206e with SMTP id
 a640c23a62f3a-b8760fe0fd4mr186365666b.16.1768391506500; Wed, 14 Jan 2026
 03:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20260114-sme2-hvf-v1-0-ce9599596736@linaro.org>
 <20260114-sme2-hvf-v1-1-ce9599596736@linaro.org>
 <6edbbdd7-8992-420e-9aee-7596afbcf00d@csgraf.de>
In-Reply-To: <6edbbdd7-8992-420e-9aee-7596afbcf00d@csgraf.de>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 14 Jan 2026 13:51:20 +0200
X-Gm-Features: AZwV_QinTEIb0AP_BWEA7DhKGuvKW1Cp2RuUqHsY2fJwbwPTYVs3GiIj_ZDElMA
Message-ID: <CAAjaMXZehMtdZC+7obmRZgfE+T2Dn64GTY2MqncPq9grKGcSsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hvf/arm: handle FEAT_SME2 migration
To: Alexander Graf <agraf@csgraf.de>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 14, 2026 at 1:19=E2=80=AFPM Alexander Graf <agraf@csgraf.de> wr=
ote:
>
> Hi Manos!
>
> On 14.01.26 09:35, Manos Pitsidianakis wrote:
> > SME2 support adds the following state for HVF guests:
> >
> > - Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
> >    not support it)
> > - Predicate registers P0, .., P15 (also FEAT_SVE)
> > - ZA register
> > - ZT0 register
> > - PSTATE.{SM,ZA} bits (SVCR pseudo-register)
> > - SMPRI_EL1 which handles the PE's priority in the SMCU
> > - TPIDR2_EL0 the thread local ID register for SME
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
>
> Thanks a lot for the patches. I don't have an M4/M5 handy (yet), so I
> can't test the code works correctly. But it sounds like you did that, so
> I have no concerns on functionality.

Yes, I tested it on Linaro's M4 machine. Adding a functional test
using Arm's benchmark is possible, but I couldn't be bothered to
create vm image assets just for this :)

Note: testing migration is tricky because the CPU has to be in SME
mode for the Z/P registers to have meaningful values, so you need to
savevm while SME instructions are executed to get a useful migration
state. I modified Arm's benchmark to compare the SME matrix
calculations against the non-SME calculation to ensure they are the
same and I savevm/loadvm a bunch of times while it ran with added
printfs in the get/put methods to print whether SME was active or not.

>
> However, I have concerns on a few maintainability aspects. You #ifdef
> out a lot of code conditionally on the target macOS version. Any of that
> code that is in ifdef may or may not end up getting compiled in CI or
> other test builds, which means you are missing out on a lot of
> compilation test coverage. As a general rule of thumb, please reduce
> #ifdef to the bare minimum.

I agree completely, the problem is two-fold here: the HVF exposes APIs
with API_AVAILABLE(...) (clang's availability attribute) and also with
plain ifdefs (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200), and
specifically the HV_SME_FOO_REG variants, which cannot be protected
with the availability attribute. )

So every time an SME type such as hv_vcpu_sme_state_t is used, it has
to be guarded :/ __builtin_available(...) check is not sufficient
because it will not compile due to undefined types.


>
> One thing I like to do (when possible) is to use the ifdef to define a
> global const variable or an inline function. That way the compiler's
> dead code analysis will eliminate the non-active aspects of your code,
> but all previous compiler phases still run which means you get syntax
> checks.
>
> How much of the code down here really does require #ifdefs? And if it's
> a lot, maybe we just bump the minimum required macOS version instead.
>

The missing type definitions and missing function declarations will
still raise compiler errors unfortunately. We could add those missing
type definitions as stubs if they are not defined so that it compiles,
but I chose to ifdef instead. What would you prefer?
>
> Alex
>


--
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

