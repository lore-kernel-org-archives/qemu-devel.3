Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE66C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0JS-0006IT-I7; Fri, 16 Aug 2024 13:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sf0JQ-0006Hu-U0
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:00:28 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sf0JP-0006B4-7X
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:00:28 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ef7fef3ccfso24949111fa.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723827625; x=1724432425; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QoqIax5TMn9ljyO22efSTziFL6fODrW1w8ahgMH12Oc=;
 b=pky3wtHMF3cnFrqtyVxU5/G1fP7qSpuU5W6lxMvuneJHBO7MADDA731r6SCE/zFwc1
 D3Wfe9gY467ktJKvJpsiWp2D6jBrk3HEVM/4iMOcUZswp5sDupUTHVMnviOerJrIb6Qe
 j0igvchLaOE2EJMHvkwhfDG+14QHtSz1s9doT6EJ4qZwbk1m81cYKvO7eHalDCTC33hq
 DOXcRA6ffBCpwDsZWxIMPKNXzDKCgIGKLHKRgX6QsLAEP9fK99okogUJqCrsftroFqLO
 IbSOQ97fV3o2UKDWAmHOG0/QTuwlz7+8C6NeYj/IZc34traxnvW55jS4Zv8mKK5r1Mx2
 yTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723827625; x=1724432425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QoqIax5TMn9ljyO22efSTziFL6fODrW1w8ahgMH12Oc=;
 b=N6bUp1ZkgNEq+sWoCZ96qc3kkneIhAXNiGQHmQ7t3PfZS8KHqrTQD4WNSexB8PgnUs
 eb5gBhD3Uxo0s1IrEG7Lh+6SQIl+upg4RVOUOycH+20Cz6pgLQpic+Dw3K4W/acs/6yD
 OafblbCqk16mAwJBIVstNIQ5daKRI8EPgDL10W3a3BjkqbEhHe2M85/p3tGGRyaPsXVd
 3rFL2heSGGVodt8p+wSAwNh4zEON0tAgO4krnSO0ugKzK71ghzEQqv8Aez8AKbFwoFil
 lAhlzCylmOLTzeeLeTHuDIhggBxj+nqspWjO38H7bRNPxcvTVgmaEe9eTvTRY8OZz+Sj
 ds4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHz3yzvBF8bJlBpSEOPQOS+W8Af78nzqCNKzf27w8pFICdSEe5vx0VMQyvswU3vS+GPzCfbwwy32mTD2z5kVtX7gWvCJE=
X-Gm-Message-State: AOJu0Yy3p4ZRKaJScip351YzzK9LoAUQPyYbcURAzLqfvM5nxu7uS0hD
 zDqFkpFGcxPMqIzNHYc1TNoBNJgjY138j+yFyvMJqX6JX1qFheqdHfc+Z9DLWd5/Q6pXo5ww2DL
 FGfntkoJ9bLfEWhV8gnIv1yHtfnZR8baIFYlAyQ==
X-Google-Smtp-Source: AGHT+IFTuZwDGOcYhdVvKdNUH2kVUi+1ZxQc3KPze5h8PYYD4wEMzdHQboXuFmjH828Mb83HLLwwLUDUj+6v4xYXZzc=
X-Received: by 2002:a05:651c:1053:b0:2ef:26dc:efbe with SMTP id
 38308e7fff4ca-2f3c9133458mr755271fa.42.1723827624522; Fri, 16 Aug 2024
 10:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-25-salil.mehta@huawei.com>
 <87v800wkb1.fsf@draig.linaro.org>
 <CAFEAcA9A9Oq0nURkiLNWZNC=P7KQGyr8TjjfOmEq+squwF+xog@mail.gmail.com>
In-Reply-To: <CAFEAcA9A9Oq0nURkiLNWZNC=P7KQGyr8TjjfOmEq+squwF+xog@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2024 18:00:13 +0100
Message-ID: <CAFEAcA99RF2tY-9DfhdkCxrR=ayEjJYKEQ4xZSn3BBrXdOjU_Q@mail.gmail.com>
Subject: Re: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 mst@redhat.com, maz@kernel.org, jean-philippe@linaro.org, 
 jonathan.cameron@huawei.com, lpieralisi@kernel.org, 
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev, 
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, 
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
 gshan@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com, 
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk, 
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com, 
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com, 
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com, 
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com, 
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com, 
 zhao1.liu@intel.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Fri, 16 Aug 2024 at 16:50, Peter Maydell <peter.maydell@linaro.org> wrote:
> We shouldn't need to explicitly call cpu_address_space_destroy()
> from a target-specific unrealize anyway: we can do it all
> from the base class (and I think this would fix some
> leaks in current code for targets that hot-unplug, though
> I should check that). Otherwise you need to duplicate all
> the logic for figuring out which address spaces we created
> in realize, which is fragile and not necessary when all we
> want to do is "delete every address space the CPU object has"
> and we want to do that for every target architecture always.

I have a patch to do this now, but I need to test it a bit more
and confirm (or disprove) my hypothesis that we're currently
leaking memory on existing architectures with vCPU
hot-unplug before I send it out.

-- PMM

