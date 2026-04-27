Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC06BFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHQxs-0003YM-Fd; Mon, 27 Apr 2026 14:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wHQxq-0003Y2-UX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:45:51 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wHQxp-0002zw-04
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:45:50 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2d8fa0fadfeso5762846eec.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777315547; x=1777920347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrP8N0Kqzi52kg9uWLeb5pWndyrGgYxvvDEjOX0XXgM=;
 b=US9YODJyidPiFpAqf93pvbfMQ2QDPwXpbJ0ZGqch/WZ94XBCbfllzwT462O4uAFW2c
 DHAYAsQH/a7OqChtDXJ9LY8O8G1TkRjHfxiwjJ8Ivp2KIWFZDUxt/sQgiaJw6Yq6e8Bu
 3LsJpvjfaimAdORZH+IX0B8HsiriOLV1S/QkG9pWhjaxvaOdmAZm7k7F8zpz6drNx3dq
 U0IxrWrcpcZKHPZPFjNmkfy9M0xk1XNVcEZACmP/WJo5O+kD544SII7sXtAsHDyFM0zL
 ExP8KHNfY6XlIoRBKw2HMApeFcDR6h7fHnnejXvu0CpVOPiTKsM3HtEKGVOPAKcfEHqs
 9gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777315547; x=1777920347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IrP8N0Kqzi52kg9uWLeb5pWndyrGgYxvvDEjOX0XXgM=;
 b=oYvIO+KIP+qRFainhduLFLgF/N9o++i+VvNEgwq28MTdkCiNG3cTalWlMdzh6reIbI
 gdWhUsDaMjASK6FGRzpudgO81qto6rbtJ92jP18KYxZRGtPiIG8A6pWBpvDvKR6tH/As
 saeWKFSpBz8cS+wnvVF+nMvf+41i5QawGQ3LGHKDHTS8DMmtivQ1CEozFBDE3jy/bA2/
 IEyIYHPX0aEwtZeLvpILRxuWNawQdniTBcfYwAlPktySFRH7D4ShIJfybgSqUrRscI59
 4Y9H7cWQJid+cEwxhYU+7oC04CPt/L0r/htn70sD1dHy3gRyjUH1xHPcXz18gYfdFwQ7
 rgzA==
X-Gm-Message-State: AOJu0Yx+unI2KzERHOs3HACVBFrI09aS7rtYRC/IB16vdRxKdv0Kr2aD
 +BNwtSZT5YwkS30fcx7SVCzk5J0AXe+5DsOH0jqgUGBZ2Hfdaxa8wpKe
X-Gm-Gg: AeBDietSKgwUfz37jsjvVgC02wv3FixRoUzbAEvwfMJpDXeJ/krY86dWTaMpfYR15N/
 DLnKKLsSuSvfRhECyOaaTVoTR0lkNbQzC1gkkEakPFsTJoYDndwJ6OQME6f6CBFKufphPcXHfR8
 mR2hFBVZokfW3510P5h9dkceM6V42IYf0De7VnHxNFIZK5xzRCnM63Kl01KMHgY2LK4hmhkgEnO
 1dA65R3IZRDKZ+91pajdJwg8LKkGRi1WcxXcXeuTMTT2wyDq6z0ptH5WSpmdNjicwIoaWN2cMF5
 JteVOI3Pd1ymctj++etfxWQhjxDvAISFczHTLvPwuTUKj/IN2lHPg/zNxqj/4aB1o3k4qkhE9hG
 XygWr1YPr1xdlm/eX32A0z+5uC7EzIDpXQflJppDC5dQhUsdOXpTeq87snmqKo9lZGMUyeTEZUQ
 bzstk91F+GjYSIhvjYAfOREtCs+OMHAyPBmCg4Y9Um0L9BmYWL/+RfNZ4ulCvHUwIUnqi+5UkDL
 w==
X-Received: by 2002:a05:7300:d70d:b0:2be:9c19:b34b with SMTP id
 5a478bee46e88-2ed097b91f1mr103317eec.4.1777315546820; 
 Mon, 27 Apr 2026 11:45:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:44a8:bc8a:495b:f1cd:ad63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed09fd6e19sm76230eec.13.2026.04.27.11.45.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 11:45:46 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
Date: Mon, 27 Apr 2026 15:45:40 -0300
Message-ID: <20260427184540.80415-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAFEAcA-8BeBte6CxH._5F5Zsk3wvs0zJJW6+=8cNaroRTBegK-M5A@mail.gmail.com>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <CAFEAcA-8BeBte6CxH._5F5Zsk3wvs0zJJW6+=8cNaroRTBegK-M5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2026-04-27, Peter Maydell wrote:
> looking at this I share Mohamed's question about how much of the
> atomics/etc we really need. This is a thousand lines of code
> handling instructions that in a lot of cases the guest really
> ought not to be using on MMIO regions in the first place.
>
> If we have real examples of this being needed, that's one thing,
> but I'm not very enthusiastic about implementing 'doesn't actually
> have the atomic properties' instructions otherwise.

Some empirical data first.  This series was motivated by an
observed workload: the original Venus development capture (Ubuntu
24.04 ARM64 + vulkaninfo + vkmark) showed ~1.8M SIMD/FP load-pair
(vLDP) ISV=0 faults plus a few thousand other ISV=0 hits on
LDR/LDP/STP/STR variants — guest-side accesses into virtio-gpu
blob memory that the renderer had been forced to map via the
subregion fallback (MAP_FIXED rejected as unaligned), trapping as
MMIO with a syndrome that can't encode pair semantics.  Without
this series, those 1.8M hits land on the assert(0) in HVF and the
guest is dead.

Patches 4/6 and 5/6 (exclusives, atomics, CAS, PAC) were included
for correctness against the ARM spec rather than to satisfy any
observed traffic — same capture had zero hits on LDXR/STXR/STXP/
LDXP/LDADD/LDCLR/LDEOR/LDSET/LDSMAX/LDSMIN/LDUMAX/LDUMIN/SWP/CAS/
CASP.  The intent was to cover every load/store class the spec
permits with ISV=0, so that paths I haven't observed (different
device, different driver, different guest OS) don't fall through
to assert(0) either.

I instrumented every trans_*() and the HVF data-abort dispatch,
then re-ran the same workload on top of the MAP_FIXED alignment
fix currently in flight:

  https://patchew.org/QEMU/20260424000544.9617-1-lucaaamaral@gmail.com/

Result: zero ISV=0 faults across the run (2.68M ISV=1 dispatches).
The alignment fix resolves at source: blob now lands in mapped RAM,
no MMIO trap, the ISV=0 path goes silent on this workload.

So the question is what role this series plays going forward.  My
intent was a defensive path covering the load/store classes that
can legitimately fault with ISV=0 per the ARM spec, so QEMU degrades
gracefully — emulate when meaningful, inject a clean data abort when
not — instead of the current assert(0) the moment a guest happens to
touch MMIO with an instruction the syndrome can't describe.  The
same wiring covers WHPX, which has the same syndrome limitation.

I want to make sure I'm addressing the right concern before
respinning.  Two readings of your and Mohamed's comments:

(a) Scope: trim instruction classes with no observed use case.
    Smaller series, less spec coverage at decode level.

(b) Correctness: keep full spec coverage at decode, but per-class
    handlers do what's actually correct: emulate where we can
    preserve semantics, inject a fault where we can't.  Atomics
    (LDADD/SWP) and exclusives' store half (STXR/STXP) go to the
    fault path — we can't honor RMW atomicity, since the read→write
    window can be observed by other vCPUs if BQL doesn't cover it
    continuously, and STXR claiming success without an exclusive
    monitor lies to the guest.  Plain loads (LDXR by itself) could
    legitimately emulate since they make no atomicity claim.

If it's (a), I'd respin trimming patches 4/6 and 5/6 entirely,
keeping framework + immediate + pair.

If it's (b), I'd respin replacing the atomic/exclusive/CAS/PAC
trans_*() bodies with `return false` (UNHANDLED → inject data
abort).

Either way the existing wiring in hvf.c already error_report()s on
every UNHANDLED before injecting, so operator visibility is
covered.  Happy to downgrade that to warn_report_once() so a guest
spinning on an unsupported insn doesn't flood the host log — that
addresses Mohamed's earlier "warn somewhere" suggestion in a place
where it actually fires.

If it's both, the (b) shape covers both — explicit fault on the
classes you don't want emulated, framework still in place to handle
the legitimate cases without an assert.

Could you and Mohamed confirm which reading is correct?  Happy to
respin either direction once I know.

Thanks,
Lucas

