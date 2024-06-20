Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E4FC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKN5y-0005ze-Bz; Thu, 20 Jun 2024 15:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKN5x-0005yO-B1
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:05:17 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKN5v-0000pu-E7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:05:16 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57d106e69a2so2026628a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718910314; x=1719515114; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y0sYh65T6bPyB151APvra6MHPCYMv7NBuOxLgl0Uso4=;
 b=RaOAozkWGMUzUEyXW5R7eOJzFpn++EbcJ2US5HXxqNq9mARrOj3/BAMMirMxcxYtF/
 XWdr2r0rLlv9lXQ1yvG29zscjl2sln6aqaIJHKfSeU3d3axL/VheZef8sBmnuiQ6pMpg
 nj+b1ISidlEOQeBZptzl9zv4TSzTsdWcfDWt6yfsOY6IGZEIKJlQSJJweS+cTuAScTWK
 BHPPfQmrIf9BYLH+OCvNJHvRv+OolenVN+WD4LdPJOdJmoafMnsYKXlv4AtvX0reRHYX
 n88b1q96jWW9z8SZ4U6I7FyqigQ3nbWhZsEtTCEAD17xKKz30dPO0T5Gh1/lu0XEptEx
 iv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718910314; x=1719515114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y0sYh65T6bPyB151APvra6MHPCYMv7NBuOxLgl0Uso4=;
 b=c9hk4ckQYcaYComk/pNV8DvmzYsmwUJeGfTytn2l1IxtgenEpST0AqX/E9rA0c9VTb
 ZFYq+YJb7sZvHxF3zmzR27gDtanEkhDuInUzQVeT4/aO8XuYqezN3CYK+VbZHsDR4iY/
 +OqaHowJB30Miyb2EKoyUhkIvkr2GbNJ15ADkHhvrX15z+Xz6UjatmiflOOAWdnuU/s8
 ezO4uX6iBmlcWK1RO5nZYRfUv3YcBo1QacteFu+9WWw6/3HOvPlA5E27ArRN+BDcDj0y
 E4suwN+jXgTFMWeZQgbv/QWDLh9xaXC1Sjr7weRpc7cxjC9Heu02ApIOmSqSNpS8oep5
 bWng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVNFhW8L2pkKSng10rZ06Lsv/dhSkB0uyFQHoySjnAwI6jgNs4nsnmWx3fwF9+u4cV2UE5j+NBwo4hwYn3nzixrCKv0oU=
X-Gm-Message-State: AOJu0Yw7BNVLS48svKotPgBXDYPIFK1x0P2W3bpLxA+/XYGoXY91MCbe
 Sk8g0Jxm22npQ4Hq/hI9t6wySGFH3BA8ujHY+g3Bi9uTOa1xpB0C88WqnE4ns8YpEdPnHq57vn8
 sN9gWWYQJ1uoAvvMtWy14zIzNaMVtCN52rL1vHw==
X-Google-Smtp-Source: AGHT+IFX1lLm5tIgaf3acG1pLAn7bGEe3a/aZoGV/XW192WaxZQERUhot7h65QSatfT0Wxn6/xQo/HWieWw8nLKDrBA=
X-Received: by 2002:aa7:d1c3:0:b0:57d:3df:ba2d with SMTP id
 4fb4d7f45d1cf-57d03dfbc1emr5212756a12.2.1718910313669; Thu, 20 Jun 2024
 12:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <CADueUgQh-=vmoO9kqL589Xeuf_LOM_K2Rr-rBxwe8iArdNdzsA@mail.gmail.com>
 <6b1daa9c-6f37-4edb-86d4-782941f1bcca@redhat.com>
In-Reply-To: <6b1daa9c-6f37-4edb-86d4-782941f1bcca@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jun 2024 20:05:02 +0100
Message-ID: <CAFEAcA-Yda=XXspi49Z+-7bmBP-DzL2kFMg_XfNxMviHuAX18w@mail.gmail.com>
Subject: Re: How to use designware-root-port and designware-root-host devices ?
To: Thomas Huth <thuth@redhat.com>
Cc: Arthur Tumanyan <arthurtumanyan@gmail.com>, qemu-devel@nongnu.org, 
 qemu-arm <qemu-arm@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 20 Jun 2024 at 18:34, Thomas Huth <thuth@redhat.com> wrote:
>
> On 20/06/2024 10.28, Arthur Tumanyan wrote:
> >  From the other hand the device is declared as non pluggable:
> > dc->user_creatable = false;
>
> Well, that means that you cannot use those with "-device". They can only be
> instantiated via the code that creates the machine.
>
> > Can you please help me to use designware-root-host/port devices ?
>
> It seems like the i.MX7 SABRE machine is using this device, so instead of
> "-M virt", you could have a try with "-M mcimx7d-sabre" (and a kernel that
> supports this machine) instead.

Right -- these devices are the PCIe controller that's used on the i.MX7
and i.MX6 SoCs, and they're automatically created when you use a machine
type that uses one of those SoCs. The "virt" board doesn't use that
PCIe controller, it uses the "generic PCIe bridge" TYPE_GPEX_HOST
(and you automatically get a PCIe controller when you use the virt board).
You can't change the PCIe controller type of a QEMU machine from
the command line, you have to configure the guest to use the controller
the machine type provides.

thanks
-- PMM

