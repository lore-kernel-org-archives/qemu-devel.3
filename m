Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FAE607884E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pYzPH7YD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIopJ-0004oc-Ra; Mon, 19 Oct 2026 10:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIopG-0004nw-JP
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:58:58 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIopE-00014r-Lw
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:58:58 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b0db268bd8so12333527b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 07:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792421935; cv=none;
 d=google.com; s=arc-20260327;
 b=WI7gwKTz3IMqUUkI/aFefjobR0DZMdFpKtyBhWu3zkLCd9KMoS+sX3hqt11C0bhvjF
 V6DkfeH9uUEIPxLdk4ak/pCYrGEKKoGR3FQg39gYpG1Q2v6QD6qsO47oH3hchD0YKhnd
 0vLyP8/tRT8X0utZ89Gi4DNFj1eyx5J0/zr081w8nOf86LYSLPQLy1ZPhsRz7AEEuqta
 OYJMsjrSv6wGsVi16UjR4o6XFAWynWZiXZnETLzk9rxUClXfC7gB8OMk3OcuX0VA8gh6
 9XS9dP3wgxSZ6pWvwso0rRKecyjGmXWPzIS4Z475ydrZzqupfMXlan5W5qg79NwJNaGr
 LycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xdg7xfsiw5iZLYqEgH6XOhgYRIpyBH446pqEJMZEqNc=;
 fh=yaRpupCpe09uS6tUw5Q+41A3gfzk2ZwJDl5ZdO7Dtbw=;
 b=rxNL+du8w/daXrlacQVUFQtyEeYsOwTR0TBS9YgXVwi2vbmaxuLIaW3mL1Pzn2Rvye
 7/0BrMYndGbCSFNXP4xZalEjpQwM3TDJBl6ZfBD2S2YMww6lWwEuc/UB86bepyyPwUgh
 cB2LOvNKzUhy5l79qF1MAXvVNOc5DiWvDT2loorYwe6sg/7bKoc84X+jXLQCWXhxdiiV
 tlKvf8G85roginIWenas2DSbd7zZ06CmhR2CA3VXVcC0fMir0cm7IFRpXyjmpAciONA4
 7u2RrA2fMD5+EnPgrMBPy9GXwKHUSrE21bv1kmk8bij0AQPzsAE1eu/blgTDmNfUxnsp
 jl1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792421935; x=1793026735; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xdg7xfsiw5iZLYqEgH6XOhgYRIpyBH446pqEJMZEqNc=;
 b=pYzPH7YDWMrjiO/u3FQ1Lts2vp2RMHZ4q5ioN/FgdKLFpM7doT49SFKBRfk0Wpir+6
 nXJJpQh9KDuT/jBoLDeefPjf8xiJxNw4UGTBSkayd6E8wKNu6rLGeFTlo1gdhse+ZG2U
 LXSWBHk3eT80PAT3P9TlPFmrPmNlEwa5yOhOY9siHEPRLZuvPfGVQE9v3zytzRwiuV0w
 osXgiCOLOPOkxE9KIO8GDZ6e+VpodTEMx+EoA12ob5dH/dkFiO51ZJODy8Wj0kcuJ2lb
 HouVEfyb/N9/MoEWjVwVDHIEzMoQMMvXe8Hrm/OFEPS6XdACb0yS1vZljxX7PTltR9c/
 Uo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792421935; x=1793026735;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xdg7xfsiw5iZLYqEgH6XOhgYRIpyBH446pqEJMZEqNc=;
 b=qUq+j0RZUGBo93EvttjniyISgZFDsiSUKZ90soS2QK1YetCMsjTkymR1ZcUamue2c2
 9ZP18hDC0YSIiTi3613GEdX8QCFe0dRnjxc+qvIFxrEBrXxe5HAEMdmhCVO6TdoLR5yI
 XcIEMF9MZN+dDSM7CGWZ2Wbq6b+MOoZo4ka4MC19XZVuDRxYMlcjg2S7Uo0cMGSTOqb2
 hwxtblqJWmnE8wRHixQ/Rm/6heN3tIwtKnrvJ/ToonXF+y4EPdLIzltR82HhiYz8C0Jc
 +Gk6sSAgNgec85POmRECVILkm/RY+TZ0nLu/H1tYpucbqlu16DTai3zrrv8TqIyJ58RD
 sAVw==
X-Gm-Message-State: AFq9FYJN52VYPhm6AJfgV981FOjdRe3XW/XW1QiDiQifsyc4DsPEyEOc
 7x6LORHC7S9JE0fpDtdIOJZkZ5SOmVvv9I0uHuvMOJ/H/SzE8jZU8J0jqxiiMW3pzBaPeB8mz10
 8ECmxmUQBJMXjNUKFdpqXyFNmf9QqrQ0/M6XGWMgOETHKtS18Lq6RvJc=
X-Gm-Gg: AYBFou1tIwYmWScL8nnrNq+pYVY80Q8Eq87rdIPESwLx0doV72E+KOLQM5ObXakJjRg
 /du7hGN1qTZvUoHlMuFaAOk21ur3UKddDpfnBKxfkoja94IcQ1Jt3tLqFR9pL7xD+CxR2UCUEmn
 inWxrxOCKKiw1Z3HtvZv/2R35Ci8VBYjDOxN9m5i4WIIKIK+tqLnOa87yABtzKV+SG6A1F15xoI
 1IHo2MMTCTzr+rTeS1yqLfH2G1Xs7bE+9AmN6YOSwX1ZL45zPQ5GWqKTpgDOPA1VlqmwbnI1lPk
 hZlD35UExieveDgv903IJjRchcTTcca1vFvRSdi7GrgjRHUcLGf29Eq63WKUY10FYoFkM7LNPd3
 1XjGs+MCh6CCXOLYt+6oVjvIHT+WbEtQZIS858y+yN/UpTlEpyMg=
X-Received: by 2002:a05:690c:ec6:b0:8b0:da2e:7a12 with SMTP id
 00721157ae682-8b0f21a2165mr25262447b3.46.1792421934571; Mon, 19 Oct 2026
 07:58:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019131608.3155474-1-peter.maydell@linaro.org>
In-Reply-To: <20261019131608.3155474-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 15:58:41 +0100
X-Gm-Features: AclHuK_csNWnB-J0jNwFti71yzzVXfBtb78dRvKXvYorPpxWk8Dp0KymvvIyOq4
Message-ID: <CAFEAcA_GmyC=zY65pc12idvo0JNk8KpA8vQY5UL8SWAmX3PNRA@mail.gmail.com>
Subject: Re: [PATCH] include/hw/core/ptimer.h: Fix 'version' argument of
 VMSTATE_PTIMER
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 at 14:16, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The VMSTATE_PTIMER macro is defined to pass a 'version' argument of 1
> to VMSTATE_STRUCT_POINTER_TEST_V.  This means that the field will
> only be used in migration when the vmstate struct that uses
> VMSTATE_PTIMER has a version_id of at least 1.  This doesn't match
> how we define other VMSTATE_FOO which don't take an explicit
> version_id, which is to use a version argument of 0 (e.g. all the
> common macros like VMSTATE_UINT32 are written to pass 0 to their
> VMSTATE_UINT32_V counterparts, and so on). It also doesn't match
> how we define VMSTATE_PTIMER_ARRAY.
>
> The practical effect of this is that users of VMSTATE_PTIMER in
> vmstate structs which explicitly or implicitly have a version_id of 0
> were actually not getting their ptimers migrated.
>
> This affects:
>  vmstate_xlnx_csu_dma in wh/dma/xlnx_csu_dma.c
>  vmstate_k230_wdt in hw/watchdog/k230_wdt.c
>  vmstate_imx2_wdt in hw/watchdog/wdt_imx2.c
>
> which are used in:
>  * Arm imx-based machines
>  * Arm Xilinx versal and zynq machines
>  * RISC-V K230 machine
>
> Most ptimer users are unaffected because they took the usual approach
> of explicitly setting their starting version_id to 1.
>
> Fix the version_id in this field.  This is a migration compatibility
> break for all the above listed devices/machines.  Since the timers
> involved are in devices where the timer is usually stopped (e.g.  the
> watchdogs only have the timer active when the watchdog is enabled and
> counting down), the consequences of the bug are likely not visible to
> most users.
>
> We could perhaps attempt to preserve migration compatibility here,
> but none of the affected machine types are versioned and so we do not
> promise cross-version compatibility, so do the simple thing.
>
> Fixes: 852f771ec9e5c ("vmstate: port pmtimer")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4705
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not cc: stable because it's a migration format change and we
> don't generally backport those.
>
> As an aside, is the expected way to write a new vmstate to give it
> an explicit version_id of 1? If so, maybe we should look at the
> vmstate structs which don't define one and so get the default 0.
> Or is that just some odd quirk I've picked up because lots of
> existing code uses 1 as its first version ID value?
>
> ---
>  include/hw/core/ptimer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/core/ptimer.h b/include/hw/core/ptimer.h
> index 4dc02b0de47..8513f8917e3 100644
> --- a/include/hw/core/ptimer.h
> +++ b/include/hw/core/ptimer.h
> @@ -300,7 +300,7 @@ void ptimer_stop(ptimer_state *s);
>  extern const VMStateDescription vmstate_ptimer;
>
>  #define VMSTATE_PTIMER(_field, _state) \
> -    VMSTATE_STRUCT_POINTER_V(_field, _state, 1, vmstate_ptimer, ptimer_state)
> +    VMSTATE_STRUCT_POINTER_V(_field, _state, 0, vmstate_ptimer, ptimer_state)
>
>  #define VMSTATE_PTIMER_ARRAY(_f, _s, _n)                                \
>      VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, 0,                   \

Followup query: should we also bump the version_id on the three
affected vmstate structs, to make it clearer that the migration
compat break has happened? Or does it not matter?

thanks
-- PMM

