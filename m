Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA89C55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrWdI-00074Y-1p; Wed, 05 Aug 2026 04:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wrWdG-00073w-48
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 04:05:46 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wrWdE-0007Y0-EQ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 04:05:45 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so149316266b.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785917143; x=1786521943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OSQz8cl/kbv4E/ljGHzlVr+FqNT8OBNIrd2dy+lAbXY=;
 b=FXbPKP2FA3bqfu49SK2Whyrbqnmm25fztIru5xpCaFBGd8ZnGBPo380kP/grd5WBmu
 l/ZeM5Z56PAdgf7ORnVMZHXWm+MRxvdJEAXmrmri10hQGdCNWpt8+w1sMEoDm7ul/MWK
 JzDUZApdrId/I34JRY/e5hLiSeb/Z6JFo7xE85OTmQCf2uSSSNQAB4FtYKM4OrA9Dpkf
 7R5myklGwr2s2BLo9x2I0IYPWMePNtxWwlXZK2JhE4NN2kSwpUfn6cqMOUPzwEXKlLm8
 z0PRfdwlT9JCo7/FXulj/ZqmqgVL1Qtm8vEy75FpVCwVP7d+d2Fw4lQLAIeivv0O3gkK
 Hffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785917143; x=1786521943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OSQz8cl/kbv4E/ljGHzlVr+FqNT8OBNIrd2dy+lAbXY=;
 b=YlDFTrI/s7oL8678I0rXDCXvvgnaln2wvP9iR0PIEXNsX6DrTPdn90H6jsn7qmxMlj
 ds3RFeBAMsWwphImIlNZ1AgmUbIhPBFCoc/vj8jS6lBv1a0qKYMVPTNDcCWT38db98dP
 7Co+mRwCaRyVSskRWxwWwM/zOcFeWUPkpWj1ML0HvAV2N8dyeHt1u3hiNBJ9c9wgWZJG
 3XDknvW3wrVbA/mmWnGkfFRoCnP5aAjmYH8bBY3uvEHvmszkJWHo5XFsWp+/COEFuw0G
 2hA1p3LgHIzOYpAvTKXOlSyeaveyztg2MzKzsSE/3JN7cIUPm0vnSwbFEd6ZqIXiS+tL
 oxWA==
X-Gm-Message-State: AOJu0YyQyxabvb49ZwQJQE5Kuz6GQ4xYN5DFQ4LKALhf2e5JhxvE4NfX
 PUCzpY9vG8WTNwTtRWp7baGOzuWEIfDHInJ2mu16tzDwqi6h1b6P3g0r
X-Gm-Gg: AR+sD12/gbKErZjfwaJVOCJVNp1PCDPsMjaW9v9O2wHXlb1U78DTPnlYrMqiP9dk4eh
 3Rn6aMK7V+s/Iyk9zGtmnox21l0CPS5QpDwEFxzgNslrjunYwVz5H1NpE7kK0BjsACRNLxFBpvC
 xoQ44veyMa52H4NmFMq7USUQsFVUWYnFA+LgSSDJ3OcbIG0AJ/0OWH6hUClMSbWdoq8ZX4Yl7Gw
 5vo+rxLabL6YCGv/se1HiN/VbfGQbXf0gYmI26SIXXV/VH6Vnr+mjv6InSJ+kcIyronEDQT710Q
 99Hu7kphktQcRP32Wes9bLxGmSwuiyiX3lNYk0Oz9yqYw6a2/ExKs/47/+CY2/9DXF543En+pa5
 VbhhTD05Tpkqn1m+qnxWlIOaeM6/f7WdOWWgUboIVVAfuyFVIRHfGV28CiJM/CghA55+WSXHaC+
 8VrGbJwM+qRufKIcDehgwkvqePxcVLgvcPx8Bh6fBzyukp8E7dzlfNiAAr795oOtanMCgcwRyS1
 Tkw1DuOQy79
X-Received: by 2002:a17:907:d12:b0:c15:ee17:47a with SMTP id
 a640c23a62f3a-c202488d435mr717813866b.15.1785917142395; 
 Wed, 05 Aug 2026 01:05:42 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a1462c5d4bsm1498323a12.30.2026.08.05.01.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 01:05:42 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	qemu-block@nongnu.org
Subject: Re: [PATCH] hw/sd/sdhci: complete non-interrupt ADMA descriptor
 chains in one pass
Date: Wed,  5 Aug 2026 10:05:23 +0200
Message-ID: <20260805080540.323431-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEUhbmVOkPeMzZGpgJ6WMk07xmf9oGL25jp7uw3uQtPt4LE93g@mail.gmail.com>
References: <20260804081459.8007-1-wafgo01@gmail.com>
 <CAEUhbmVOkPeMzZGpgJ6WMk07xmf9oGL25jp7uw3uQtPt4LE93g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=wafgo01@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Bin,

Thanks a lot for the pointer -- I gave it a go. Let me share what I saw,
with a couple of caveats up front, since I'm not sure I tested it fairly.

Caveat 1: series 515264 doesn't apply on the tree I'm on -- it seems to
build on earlier SD/SDHCI rework I don't have yet (e.g.
SDHCIState.sdma_boundary_paused, sdhci_sdma_transfer_active, the Host
Control 2 migration), so patches 07-11 and 13 didn't build against my
base. So I couldn't test the series as-is.

Caveat 2: to still get a data point I hand-applied only what I understood
to be the core idea of patch 12 -- driving ADMA purely from the transfer
timer and no longer resuming it from MMIO reads/writes -- on top of my
AM64x tree. That's my approximation of your change, so I may well be
misrepresenting it; please correct me if so.

With that approximation, over 15 hands-off boots each of the same
unmodified image (a ~28 MiB CMD18 ADMA2-64 read), counting the U-Boot
"Timeout for status update" failures:

  baseline (sliced sdhci_do_adma, ADMA resumed from MMIO):    7/15 time out
  patch-12 approximation (ADMA timer-only, MMIO-decoupled):  10/15 time out
  my patch (complete non-INT chains in one pass):             0/15

I don't want to read too much into 7 vs 10 (small sample, overlapping),
but what I take from it is that the timer-only approximation still timed
out in most boots here, i.e. it doesn't seem to cover this particular
failure, whereas completing the chain in one pass avoided it in every run.

My guess as to why -- and this is only a guess -- is that the two things
might be different facets of the same symptom:

 - Your patch, as I understand it, targets a status *read* itself
   executing a pending ADMA batch and thus returning late.

 - What bites us on AM64x looks more like the *batched* transfer racing a
   guest-side timeout: sdhci_do_adma still does only
   SDHC_ADMA_DESCS_PER_DELAY descriptors per call and reschedules
   SDHC_TRANSFER_DELAY ns later on QEMU_CLOCK_VIRTUAL, so a big transfer
   is spread over many virtual-clock round-trips and U-Boot's timeout (in
   guest time) can expire mid-transfer. If that's right, keeping the
   per-batch reschedule would leave that race in place, which might be why
   the approximation didn't help here.

So my hunch is the two changes may be complementary rather than
alternatives -- but I could easily be wrong about your patch given I only
approximated it. Would it help if I rebased onto a base with the
prerequisite SD rework and tested the actual series, or if I shared the
AM64x reproducer? Whatever's most useful to you.

Thanks again,
Wadim

