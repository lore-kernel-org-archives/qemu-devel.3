Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3AED58D4D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZrd-00039C-F3; Mon, 25 Nov 2024 09:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFZrc-00038r-Cr
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:14:56 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFZrZ-0007kG-9V
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:14:56 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cfaeed515bso5914762a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732544091; x=1733148891; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5JI26MUfY0fAjY406AyXISP927U8rd4rJLhvGPhZIw=;
 b=FJwoZmbhUJk67sKJcSHyNES0BOasRILMukhZEjJlU/+us9HA2Jj1DMuGM51tEIwksd
 14bF9sB2HUDbxmpWKkxp+wtgQCXm1aBfc7spgRnHsPutLnqFjhz7cThdbYOTCKYzNdTI
 6hb1kZkijA4dyQpCGY3wJbcvYLvW7j5QLv8o1d9NpN/1xIo+KuvSMxW5FBDtlGAg2Mdb
 u6E9zV8sh65gFCBAE2zE46AHmXyemMQ3Hja123L/lk3HkS5lCISYXU9Y3WRXCvjdpUOn
 PeMcA305qvcrJAtd9rp/DNHM8uC0cdJAMoy7Y4Neu5FX5XxBku3eaHAOPDA1HxOApSHn
 3hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732544091; x=1733148891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5JI26MUfY0fAjY406AyXISP927U8rd4rJLhvGPhZIw=;
 b=l2daIXdlugeDwK/svUIEn6SoyvOWd5QJNCqSs+CshkGRNBMFhExvuTllmp2WmtAUS8
 hZhrCbp/LeQsdHV4Aea3h8mRYk/5ofmIaGBpLw51ETIMG9TBYRmgWHTw/xoUNtxOhag/
 lnpErID2zjVhrRJCsRD1NcSO75+ZoXWZY4z2wbj/payP31RwrguhjhEPsN8P5YpYN/Ik
 49OSHIbmxxrsHK+pOjETcdJ9FWLcNAr85hzV1iikLlinUHb5Sb30tv8UxBBdQUY3Ivce
 tCWKxHcEdnhRbi+wf8LuanWDmSVdoUeRr/KSUt5kZ0VXF1MzBgDAT7Y9xlR9cUHpnDP6
 zmsA==
X-Gm-Message-State: AOJu0YyIa9OcRdqRGq7fPYcfHiwK/MhtA/9pl1GetOz9zBLSoGoy2OCX
 Dg20nS/elpaXgAJG2+0yMtYQaAsdZWfa69ocybD0hmw0UzAKZRoZvDMaBy5gP1ru89kDi240BQG
 3ltT9lPaxDWVbwBlQQR/+iS+dW6G/NNS06h+XLQ==
X-Gm-Gg: ASbGncuIDxaUYajF+x+PlLmMdojMriFiR5UO3VEuINWnAL9pXD4/9rTzz5rDOLoQMws
 6+tViVbULhhjmvkukGZz9dntQuCaK18tV
X-Google-Smtp-Source: AGHT+IGhmpHqCWRuvw905euyBRNmqDEVNGl4A8J9RMK+OifJ4fjBNO4TQlhOukX08a0qXjY6d6nsYkFlD//Yu19Kmjc=
X-Received: by 2002:a05:6402:4404:b0:5cf:be01:d7e9 with SMTP id
 4fb4d7f45d1cf-5d02062ab3emr9561084a12.16.1732544091492; Mon, 25 Nov 2024
 06:14:51 -0800 (PST)
MIME-Version: 1.0
References: <20241125140535.4526-1-philmd@linaro.org>
In-Reply-To: <20241125140535.4526-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2024 14:14:40 +0000
Message-ID: <CAFEAcA9vS-9u282Jr+_QaGZT6vD4cpmh0wjuYPQSPLZQw30e4Q@mail.gmail.com>
Subject: Re: [PATCH-for-10.0 0/8] hw/boards: Remove legacy
 MachineClass::pci_allow_0_address flag
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Thomas Huth <thuth@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 25 Nov 2024 at 14:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> This series aims to remove a legacy field from
> MachineClass.
>
> Rather than a global exposed to all machines,
> use a pci-bus specific flag on each machine
> requiering it.

Should this be a property of the PCI controller, rather
than on the PCI bus? Presumably on the machines that
don't allow a 0 PCI BAR address this happens because the
PCI controller refuses to map BARs at that address.

TBH the commit message for e402463073 suggests to me
that "allow address zero" should be the default and
either specific machines should forbid it or else we
should figure out what goes wrong with them, if the
problem is caused by some bug in QEMU. The commit message's
mention of "fix PCI memory priorities" suggests to me
that this is a QEMU bug, and that it ought to be possible
to have the machine set up such that you *can* map the
BAR at address 0, it's merely invisible to the guest because
some other machine devices have higher priority and are
visible "on top" of it instead.

thanks
-- PMM

