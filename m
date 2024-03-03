Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD4BC48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 19:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgrSJ-0003LI-ER; Sun, 03 Mar 2024 14:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <greg@gpanders.com>) id 1rgrSC-0003Ks-Rp
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 14:24:58 -0500
Received: from out-183.mta0.migadu.com ([91.218.175.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <greg@gpanders.com>) id 1rgrS9-0002MF-DA
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 14:24:54 -0500
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
 s=key1; t=1709493882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkgbXCAMOJL1wiK1NohnzTDPO02sXNE1fc6BKW7BUv4=;
 b=kRslD0hgytJFVCfw/Lwjmwg91T3lQcaI22IInWl9O2Ig1Zt+K4aU7upfssKqhi28bV+sX3
 rAfNZGRRfZl+lHMfZYNXPVTby5fU3F6fYyBDmx0FJ8g2zpD4XbvIoqwg8hoL2gKVXO5eit
 b4n9jzIhxr7Aza149fd3W55pfaOp0ATCfYJn7xvUrhd3+i/IAIhz7JHnG8lo0JjBXdpFW3
 KFDL8znYtjejA9exDGHmw7AZcWbQlMGMVHXWdF2VYE/zD6o4+ZtsgLOjs+v1dOsaQrvVv0
 2OsUA4A7PelxQUDVJUeEdDa13w4voYsz2DS0SLQ8MKutpC1sgTnymsFrdLr4cw==
Date: Sun, 03 Mar 2024 13:24:39 -0600
Message-Id: <CZKD06O0WZK7.30UAMU1R3DWCD@gpanders.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "Peter Maydell"
 <peter.maydell@linaro.org>
Cc: <qemu-devel@nongnu.org>, "Alistair Francis" <alistair@alistair23.me>
Subject: Re: [PATCH] hw/misc: zynq_slcr: set SLC_RST bit in REBOOT_STATUS
 register
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Gregory Anders" <greg@gpanders.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20240227222227.74935-1-greg@gpanders.com>
 <CAFEAcA-wrdUaH55ZmoCQAQ=zV=seaCo2hciXys_p4tKE08Tf3w@mail.gmail.com>
 <CAJy5ezo20Hh7QN6S70fu+akYjhiB_RR=teo+UPigMwzyyb6NzA@mail.gmail.com>
In-Reply-To: <CAJy5ezo20Hh7QN6S70fu+akYjhiB_RR=teo+UPigMwzyyb6NzA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.183; envelope-from=greg@gpanders.com;
 helo=out-183.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri Mar 1, 2024 at 5:55 PM CST, Edgar E. Iglesias wrote:
> Hi,
>
> I don't have great answers unfortunately...
>
> We haven't been super consistent with these things but on the ZynqMP we
> sometimes require the user to apply ROM behaviour using -device loader on
> the command-line (not great for this case since we wouldn't want the mask
> to be set until a soft reset) or we conditionalize the ROM behaviour
> checking if we're doing direct Linux boots..
>
> Best regards,
> Edgar
>

Hi Edgar,

Perhaps it would be helpful if I explained my use case.

In our design we use the soft reset feature of the Zynq to reboot the
computer into one of two different applications. We use the persistent
bits in the REBOOT_STATUS register to store a small amount of state
which is then read in the bootloader to determine which application to
boot into.

As part of that process we also test the SLC_RST bit in the
REBOOT_STATUS register so that those bits are only considered when a
soft reset was performed by the software.

We would like to test this code path in QEMU, but it is not possible at
present since QEMU does not set the SLC_RST bit. So when QEMU performs
the soft CPU reset, our boot code does not consider the persistent bits
in the REBOOT_STATUS register.

If there is another way to do this (e.g. using a -device option, as you
mentioned) then I will gladly consider it, but setting the bit in QEMU
seems simplest to me (we have a fork of QEMU that we maintain with some
other patches, so we can apply this patch ourselves if required, but of
course it's easier for us to upstream and can hopefully benefit others
as well).

Thanks,

Gregory

