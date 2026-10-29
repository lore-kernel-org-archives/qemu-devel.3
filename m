Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F8606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nM9Dg1GX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ3l-0003b5-3K; Thu, 29 Oct 2026 09:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMQ2F-0002kI-OZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:19:21 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMQ2D-0007Kv-H5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:19:15 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b09e07e149so18476187b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793279951; cv=none;
 d=google.com; s=arc-20260327;
 b=KKbdNoKuCA3klFCXx5BF5W1xlcuDNFOP/jsoTcbgHvPTqMhJliOa/oHaKvFEAh63cU
 m60BQPdDetGjvKlwZ+Mj1sPsyE1fmNam5vN20JrQm7vxfKzKrAf4HGZDLdZ7BXfGV1c2
 jPvmGr9LL57B8JIaIo4T8+xj6WOWwhgBuH6axqxjKoqgFV/euSrT0+nESmhf/JElV4EN
 VfZrhXMegUr6CwjaRY+7RSk+8zEw2dVwO6csgmyaxOnuceHm2YIAOXQUHrSO7U4mVWi1
 hoCv6EX1DI/o2l+n14XS9+EZezd7NAOY2k6sv4kH4dWW88Gh/SOMrm/10BGHLD8XHxlh
 LrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AJrebZE93jVzVf4A2TxOWrfWvWEZoMu9JCFtZsr59y0=;
 fh=yaRpupCpe09uS6tUw5Q+41A3gfzk2ZwJDl5ZdO7Dtbw=;
 b=dlVVpstn2kLMzTzoatrcrM/qZG6ThnQL9dha5ncYBEYR8pYoocWiMVI+C3XbYcismy
 tQdASJ4zTI5J/E1wc6Dy1ujRfEmgpBamrmhR7HQaPEJOYS5GcwZSigE1y7au64x8s1sR
 7/Au86dY6dFKkVsJoPfZDJBD3V5PQsQ+XVz3v79VEk9it6n4cWT0DlkZHB0gkFzASRU6
 kkFM1Zw5FmLLJ/N5c59/t/EE6zFbGj2FuVFeRFJ2IA/2Vt01ivlfgd3FrhOaX8Brl4ND
 pqju2NryMaD5afTtCLMMT7YfyppLkRSBxGhAXW16ljaAcPgd+9bVi2IzKPoMJLfGPWZe
 i8FQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793279951; x=1793884751; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AJrebZE93jVzVf4A2TxOWrfWvWEZoMu9JCFtZsr59y0=;
 b=nM9Dg1GXItjcbKSa/N/c/v6LovhJX43q+kMpXPXlYvXgJR8cOUFfV3y950BNi9mJBe
 3YPvkbbor1ef7ggyBbGwbp4qJvfFZYXal/Cb1KwuLvKzf7phJdDh9iq1eYOFJ7VxLUUl
 CUy1DbycClNGi2/9s1k0Qld5OJxRVWguwbokNoiuwTWsZEjx22nfURBK3S0dt5wz+br6
 lpmhAURz+uvkIGN7RlZt1lTWSYJe6TN+5n5eXXDUHCcsWSbTW/bqg1oKgUyXQJv50t6h
 Ap43wBfMCxy55DahfHSLT0lTHxlTQt6Q+EIshza3tmmVUBDawMNv7v0RKicncnf0safM
 f/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793279951; x=1793884751;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AJrebZE93jVzVf4A2TxOWrfWvWEZoMu9JCFtZsr59y0=;
 b=ZBTabCNz/3K8xV5aLTpa75Sp8OEhQlWyhWl0z0LUCS831rvERueDNslYffuUovvuwq
 Zz+sH/CiQO7jGsmBSwfL391A6ZsHXtyCRYf0dKrqCKYAEhPsuW48O2Cqni3Cxwg0202j
 +bVb69av+bOXxI1eHsLUwoqkF/DJnsRuPjr2fGfYlWMmI1DX8XVeeqeXzZarUtjH33Ko
 mGxKrx3Df/cLm7+uRWeIKBu6WGqZzM87AQir77we0t+/mAL+0MhOxgX2L9bafgqEYyDq
 LLZ9r+DfeSXjoMtREgnJiaLDw0jNDxZ5tWv2FkQEw8uE5CdiUghMkCEQbWUBwkke4lnq
 hQuw==
X-Gm-Message-State: AFq9FYIdCDumxJ6eMf0poG/i3fmwgJGZgRfSJDxAtgNeWl4viJ06IEj2
 eM2XHQjeXUBNGVrmv28oZ+Iqp/vGw47mkzVfD7LiiQx1JPc8bSX7JPb/Awd7Hr93zxrOLQ4w6zV
 UyMH0jcqcfs+o815K6abWAdVami8ZAiFcIf+kxPcSvAFIGv4Y2BOds70=
X-Gm-Gg: AYBFou1Fkeh5Lx3u+JuJ0VQVdAnI08UL4F0C6feqcZdoGmSkll0CxRxDe3Rjt+zSpxV
 w/xkjtJVfiJUbgg1+bImwDKQtyPOIcQKPUPhZmywxPtVF5FR3Qj5sopnEC2LxddPQIZjbZa+UDr
 oIQoV8wZJcUweEE93kmqtmHp3XjcifLT6rFLFJDavQSxHaP002fS4WldMCf9aKUA602ZTIgJyMZ
 SUcWac9xMVMT7TaOnxOrMPby3C8AH6cfo1AIi3HVK46LH9aBxCILstwnmKB7WO1JTKaJt6ZG8K2
 tGeJ0esN5Bh7UaQHgBxP8WIkaLC7wDDegLcUfxVnSqsjVj4HJeWUPU5QHJMfzFZEoitZecruWnK
 oHCMife3MAyITQiGoC3mcpDuiNzz7EKm6nvY1bwOe3WHYthxV31rBZvvgqYxkwkzRNIM846GgVc
 di+BwEGJdsFkzzwesM3fKy
X-Received: by 2002:a05:690c:79b:b0:8b1:10ee:cc5d with SMTP id
 00721157ae682-8b1b5ccb34fmr35371297b3.43.1793279951091; Thu, 29 Oct 2026
 06:19:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019131608.3155474-1-peter.maydell@linaro.org>
 <CAFEAcA_GmyC=zY65pc12idvo0JNk8KpA8vQY5UL8SWAmX3PNRA@mail.gmail.com>
In-Reply-To: <CAFEAcA_GmyC=zY65pc12idvo0JNk8KpA8vQY5UL8SWAmX3PNRA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 13:18:59 +0000
X-Gm-Features: AclHuK_IxF5jV8OukgLGeHThulqw6GolUJ8US0oQ5QdvUpvTBS4eVcXVKvoU-2I
Message-ID: <CAFEAcA8Lr5j6XjPqUPJzCDkBRhcyPivyRHEB30aLEYHmcWnXNQ@mail.gmail.com>
Subject: Re: [PATCH] include/hw/core/ptimer.h: Fix 'version' argument of
 VMSTATE_PTIMER
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping for review from the migration folks on this one, and especially
on the followup query at the bottom about version_ids in the
vmstates using this macro.

thanks
-- PMM

On Mon, 19 Oct 2026 at 15:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 19 Oct 2026 at 14:16, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > The VMSTATE_PTIMER macro is defined to pass a 'version' argument of 1
> > to VMSTATE_STRUCT_POINTER_TEST_V.  This means that the field will
> > only be used in migration when the vmstate struct that uses
> > VMSTATE_PTIMER has a version_id of at least 1.  This doesn't match
> > how we define other VMSTATE_FOO which don't take an explicit
> > version_id, which is to use a version argument of 0 (e.g. all the
> > common macros like VMSTATE_UINT32 are written to pass 0 to their
> > VMSTATE_UINT32_V counterparts, and so on). It also doesn't match
> > how we define VMSTATE_PTIMER_ARRAY.
> >
> > The practical effect of this is that users of VMSTATE_PTIMER in
> > vmstate structs which explicitly or implicitly have a version_id of 0
> > were actually not getting their ptimers migrated.
> >
> > This affects:
> >  vmstate_xlnx_csu_dma in wh/dma/xlnx_csu_dma.c
> >  vmstate_k230_wdt in hw/watchdog/k230_wdt.c
> >  vmstate_imx2_wdt in hw/watchdog/wdt_imx2.c
> >
> > which are used in:
> >  * Arm imx-based machines
> >  * Arm Xilinx versal and zynq machines
> >  * RISC-V K230 machine
> >
> > Most ptimer users are unaffected because they took the usual approach
> > of explicitly setting their starting version_id to 1.
> >
> > Fix the version_id in this field.  This is a migration compatibility
> > break for all the above listed devices/machines.  Since the timers
> > involved are in devices where the timer is usually stopped (e.g.  the
> > watchdogs only have the timer active when the watchdog is enabled and
> > counting down), the consequences of the bug are likely not visible to
> > most users.
> >
> > We could perhaps attempt to preserve migration compatibility here,
> > but none of the affected machine types are versioned and so we do not
> > promise cross-version compatibility, so do the simple thing.
> >
> > Fixes: 852f771ec9e5c ("vmstate: port pmtimer")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4705
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Not cc: stable because it's a migration format change and we
> > don't generally backport those.
> >
> > As an aside, is the expected way to write a new vmstate to give it
> > an explicit version_id of 1? If so, maybe we should look at the
> > vmstate structs which don't define one and so get the default 0.
> > Or is that just some odd quirk I've picked up because lots of
> > existing code uses 1 as its first version ID value?
> >
> > ---
> >  include/hw/core/ptimer.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/hw/core/ptimer.h b/include/hw/core/ptimer.h
> > index 4dc02b0de47..8513f8917e3 100644
> > --- a/include/hw/core/ptimer.h
> > +++ b/include/hw/core/ptimer.h
> > @@ -300,7 +300,7 @@ void ptimer_stop(ptimer_state *s);
> >  extern const VMStateDescription vmstate_ptimer;
> >
> >  #define VMSTATE_PTIMER(_field, _state) \
> > -    VMSTATE_STRUCT_POINTER_V(_field, _state, 1, vmstate_ptimer, ptimer_state)
> > +    VMSTATE_STRUCT_POINTER_V(_field, _state, 0, vmstate_ptimer, ptimer_state)
> >
> >  #define VMSTATE_PTIMER_ARRAY(_f, _s, _n)                                \
> >      VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, 0,                   \
>
> Followup query: should we also bump the version_id on the three
> affected vmstate structs, to make it clearer that the migration
> compat break has happened? Or does it not matter?
>
> thanks
> -- PMM

