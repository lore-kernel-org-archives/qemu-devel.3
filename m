Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFCECAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 10:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBil-0002cN-6K; Thu, 18 Sep 2025 06:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzBia-0002be-76
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:18:24 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzBiX-00086P-7t
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:18:23 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-724b9ba77d5so8202647b3.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 03:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758190697; x=1758795497; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QL9qvoO0yEsXagKRYRqyO0cOEeL/c3hjTrZb8xNl1ok=;
 b=dmIkpqAS/82uTktd91V39YV+v+VyuWKYiKz4kBGTbglLhmKqkqiXOTeGGKfwaq08f4
 qfJvbxjsApf54auKJKvFHl9hMFjt/LWSmh6UKKBWR0k0EtSN0IiwivNM52bFlkOIDHds
 l+ACJlwrpxXKDDmDnvsRcTUzngr9dA5IhSPRug710lcaWptHm+wNvjcRiJBtWzxjqG+P
 VhQaW0jAtEioZas8wf0JEMxccaS7Yu+v7c7PbbJtmUcKJQzpaIZCqpRjFSM1X/XHkwo1
 XXkPMhVmRKbbeybmc7wst8dwzzyb97vNNFXUd6W9/7kf21agUhlqi0Ao1DPtxBQngt3H
 trJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758190697; x=1758795497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QL9qvoO0yEsXagKRYRqyO0cOEeL/c3hjTrZb8xNl1ok=;
 b=jqOEIXuucbVK2UttoFTTZI9/cIsDdXBDI3kH3bjccemaU9mNhgn4s0FyY/o4ice5rl
 klybEiCRKshuQVrj8c6u5cl+4JPpCCWYaMGjsiZAueE3/VEYn6qZDvyscZ8bKvTD3vv+
 IzP+Cwf1zCy62O0k6hPZn3mmcTyt7HmzyMM30gcrmfg6N8rhcMQJjT0i7BeYM78z5skQ
 /nludXnrsGTnR0CeiOtHd4HAdgg7Ek+s19NmzzRugjPl0ZDqzYMCSVIq9V8h64lUenzO
 7m3GNC5+OwqVtRpOOXxgPqEhXU1o2gYtDQVp3U36ijPyPRQd2BnG2+TaLI0alKRSf6nB
 +EUw==
X-Gm-Message-State: AOJu0YxMa8hmy+z5jyIh3UeShQtET6DUE4BVT+f7m8f38iH5ORwJOzzf
 Pou6xgXFBLz4/wMpKpU1jRdBs1b6qSyVLXE0G79GjmAieqqot5pnwlst/HKTBakkIwOjlP4PAdq
 fuk86ipCY9ZACmCjLM7hhV+nJTEARVNr1zmV0Rnk28A==
X-Gm-Gg: ASbGncuhL/m/gpiCt0Tp2eZiLkRnED6t6WS90ECgr/lVG22NnKh0oU/Fk2YNWc1qj1U
 7TdZvYm0IA/DMn1sbb2/zMDykJb0pCMRc0SEwPsawW6OaNlpr1BzLWN/el+fB/qCDq7XkayGSA+
 UlN61nAljtavr+mQ5bdcECWSOfhPl06UwMcdIEgyJzmZkjMKpQifLwQtQuhtE0Fg0Lx7l7bSUX4
 vKDfoU/iE3euw9PwJOfBH2pTGY=
X-Google-Smtp-Source: AGHT+IEo+bnvRzQY0GM9wKRoEJ6MCbdfsMVm87XXl/V+1p/0LyuxwJ9GVvUx2Rl1YiTV9BQUMOJ8FX4gchQRsLGiHHE=
X-Received: by 2002:a05:690c:c1b:b0:729:62ec:9185 with SMTP id
 00721157ae682-73892161ce2mr48081377b3.39.1758190697114; Thu, 18 Sep 2025
 03:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
 <ae07bd23-724a-4925-801c-d1f2b6d9abee@linaro.org>
 <e3f9275a-999e-4114-9950-68e3925aab7a@linaro.org>
 <CAFEAcA9ZP01pX56GCATOTmmy=uorJ3jaHRq6rx9OAeF-B3rU3g@mail.gmail.com>
In-Reply-To: <CAFEAcA9ZP01pX56GCATOTmmy=uorJ3jaHRq6rx9OAeF-B3rU3g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Sep 2025 11:18:04 +0100
X-Gm-Features: AS18NWCNumj3qevWviOa5Qc4v926xPRTopc6r5RYeXr4R34QE6hO9SIdCBxeDD0
Message-ID: <CAFEAcA9KqtBDz1iNs6ug9m0SqHvTCdDikdt=deBmBV6zzBjZJQ@mail.gmail.com>
Subject: Re: [PULL 00/36] target-arm queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 18 Sept 2025 at 10:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 17 Sept 2025 at 18:51, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 9/16/25 18:43, Richard Henderson wrote:
> > > I don't understand why, but this causes failure on s390x host for hppa guest:
> > >
> > > https://gitlab.com/qemu-project/qemu/-/jobs/11379271029
> > >
> > > ...
> > > # Testing device 'elroy-pcihost'
> > > Broken pipe
> > > ../alt/tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signal 11
> > > (Segmentation fault) (core dumped)
> > > Aborted (core dumped)
> > >
> > > Even more bizzarely, the failure bisects to
> > >
> > > Author: Nicolin Chen <nicolinc@nvidia.com>
> > > Date:   Fri Aug 29 09:25:27 2025 +0100
> > >
> > >      hw/arm/virt: Add an SMMU_IO_LEN macro
> > >
> > >      This is useful as the subsequent support for new SMMUv3 dev will also
> > >      use the same.
> > >
> > > which makes no sense at all.  But it's repeatable, so...
> >
> > Ho hum.  It appears to be flaky.  I now see it without this patch set at all:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/11391070227
>
> asan reports a heap-use-after-free in the dino PCI controller
> when running the device-introspect-test, which may be relevant.
> The subtest the segfault happens on is half a dozen or so
> devices after the dino-pci one, so it's plausible that heap
> corruption leads to the subsequent crash.

...and fixing that one shows that the elroy-pcihost device
has the identical bug, so even more likely to be the culprit.

-- PMM

