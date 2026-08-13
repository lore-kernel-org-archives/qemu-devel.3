Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF08C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wucCy-0002Fd-3J; Thu, 13 Aug 2026 16:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wucCw-0002FR-6I; Thu, 13 Aug 2026 16:39:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wucCt-0000rU-LF; Thu, 13 Aug 2026 16:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786653523; bh=1INQlZ0UVuxeCzbSGwc2Gkl44IaYGUkpPGHTrTNRsUA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OlMcAVPTQb3yEm2et0AnzH2NrbXEjkONrNZgOGj054YDa7VHELcBG8rgglB46xAt1
 RgGz2rMvYaCTn9sSdoMs4Ai0o3KZE86CHOoVsLvjn7QXnZW74CS8hF15EoDTJ/ApZe
 O0R2GWoENjQNFEXWsv9dfDRg0+NGNFD7+XdKcyZHchQoQWkhfR4G28fbznNMdUjI81
 dcQ1yEoP8k6ATjNizorvQu7t6Ej99KeBgT9Zx8KAfrd8Ak5aGWyis3fgeutoNntgOe
 Ez8nZOBlbPiX1E+fLChSKZZEtKvlmhnfVxLM54U0GQNH/hdq9cwkYVUCsiBg7vT1Cs
 BlDnPQhaGFRbg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EFB121CAE25;
 Thu, 13 Aug 2026 23:38:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D78B40AA00;
 Thu, 13 Aug 2026 23:38:57 +0300 (MSK)
Message-ID: <4aecc479-d63e-4b84-8278-44db0e6d82ee@tls.msk.ru>
Date: Thu, 13 Aug 2026 23:38:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/15] pc-bios/s390-ccw.img: update s390x bios
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
 <20260812171707.1605637-16-farman@linux.ibm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260812171707.1605637-16-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/12/26 20:17, Eric Farman wrote:
> Update the s390 bios with recent fixes for out-of-bounds accesses.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   pc-bios/s390-ccw.img | Bin 104136 -> 104216 bytes
>   1 file changed, 0 insertions(+), 0 deletions(-)

How do you guys build s390x-ccw.img - which compiler version(s) are
used for that?

Since we're updating source files in the stable series, where this
image is not the same as in current master, I'll have to rebuild
it after patching.  Now I wonder how should I build it.

In official debian we always build it from source, and there were no
complains - maybe because no one uses debian to run qemu-system-s390x? :)

Anyway, on debian stable we have gcc-14.2.0, -- is it okay to use it for
building the image?

Also, there's little changes in s390-ccw.img between qemu 11.0 and 11.1,
here's the list:

  b2b5dec9295 s390x: Enable boot menu for virtio pci device
  d0473643803 pc-bios/s390-ccw: write IPLB location for non-net virtio devices
  e26dafb207b pc-bios/s390-ccw: Verify virtio support when booting from virtio PCI device on s390x
  084feb90980 pc-bios/s390-ccw: Add per-queue notification offset for multi-queue virtio configurations
  730173107a9 pc-bios/s390-ccw/virtio.c: Fix missing break for PCI notifications
  c12bb74fd57 pc-bios/s390-ccw: Refactor byte swapping

I think I can pick all that stuff for 11.0.x series just fine, to avoid
(re)building the image for 11.0.x series.

For 10.0.x, things are really much larger:

  14c29f29064 pc-bios/s390-ccw: Fix compiler warning when compiling with DEBUG enabled
  d72fb5e6b2e pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
  40d80aedd5a pc-bios/s390-ccw: Introduce virtio-pci functions
  5ed17bb32ab pc-bios/s390-ccw: Introduce PCI device
  d3da8afd1dd pc-bios/s390-ccw: Introduce CLP Architecture
  4ff1499adab pc-bios/s390-ccw: Split virtio-ccw and generic virtio
  ada7a60056c pc-bios/s390-ccw: Store device type independent of sense data
  4228a92b2a3 s390x: Remove duplicate definitions of IPL types
  dd8c8f16c02 pc-bios/s390-ccw: Always reset virtio device on failed boot attempt
  5dbabcfee89 pc-bios/s390-ccw: Remove redundant vring schid attribute
  1ef532cbcfc pc-bios/s390-ccw: Fix misattributed function prototypes
  acb00a7aae4 pc-bios/s390-ccw: link statically
  fc24fd9342e pc-bios/s390-ccw: Add a boot menu for booting via pxelinux.cfg
  47d68f7475f pc-bios/s390-ccw: Make get_boot_index() from menu.c global
  108977796fb pc-bios/s390-ccw: Allow up to 31 entries for pxelinux.cfg
  a4adf071dc7 pc-bios/s390-ccw: Allow to select a different pxelinux.cfg entry via loadparm

basically it's whole virtio and pci support added, which might be too much?
Please note that 10.0.x is an LTS series, also used in current debian stable
(trixie), so maybe it is also okay to pick everything up to this series, to
bring the image in-line with current development.

In this case I'll just pick the commits updating the image too :)

What do you think?

Thanks,

/mjt

