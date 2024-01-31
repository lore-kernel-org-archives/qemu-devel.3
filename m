Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D045FC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV8Ec-0004Qn-Mu; Wed, 31 Jan 2024 05:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1rV8Ea-0004QQ-Rb
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:54:24 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1rV8EZ-0000rD-19
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:54:24 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id B39C83200AB5
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 05:54:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 31 Jan 2024 05:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1706698458;
 x=1706784858; bh=82GAa7sMq6k5g13pNyubGL89H0m6dpAzh9ArXQ0lDvE=; b=
 EcUvbAousQFprdVCAZXssaXRSoH6sDPO3XoSpLprleqWswp8ZAfVM7L2qN+5I3PY
 2/zST+xYni8kTqBTRBIbm8KN+U472Dzght7FEnZBPj1uWlqGglU3t0RIDXS7Hr9N
 qrIkQna4zmWj3GTeD9jki6t6GA/rvQYCjj0g9Jn0MEy4smCAhhpblkRjPv6NLt+O
 cuSCr3wX4XKx3WUuaA35+QeyigsjLV5MDokDTUX7B0ZCNOhCYZKBuShnD5Krrqyy
 wj2r13RrS+B/G6epDAjbiTIFPztP+Z5DN9LYYp7hD8EXxyVf1LG6LViOOFcnhrrO
 Pnr0QtltmjPZVPIJmMdYEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706698458; x=
 1706784858; bh=82GAa7sMq6k5g13pNyubGL89H0m6dpAzh9ArXQ0lDvE=; b=M
 McdBelj9ZmS7ChFvvc6KUD1ZgQ8hGs/2RACz1BlbsZcq/f01Ub045VJVSFijCtGE
 xl8GwpwXUs4ZhlkgvkhF8MPJbmoMaXnZVz9rJJHbKvSBLdZoYFjjj+3d9gw46vfG
 4/MgH628xkmh2t+Ox7tZGtHkDn69SFyTsKkiAQ4gdPY056weamQVFcYNg6bcxOEk
 z5YwDoCx4LRC6ITIRNWopwwgRGceMdLWWbwVJiQcZPeC9ggXV4B/seiRxh5lvHvJ
 LMNATlrzgNtt9XvR/jvph05kmhSCF1iInVtxdVrScvIgsxg1a49U6BxRL6jyebJm
 iK/dTlfOQ/QWhmN/6Wl4g==
X-ME-Sender: <xms:2Sa6ZfL6kkTl1xCsYXCC7zJjcw9C6YzvwaRjd57WxyjiXy6JyRtf2A>
 <xme:2Sa6ZTJhGLtI31Ot0QIR5ArJWYw1vwawpEtqgAyFjOU0-lZSlMzRwd3zy9gRINgdO
 c_FfyWmud5QBBf4ggk>
X-ME-Received: <xmr:2Sa6ZXumLH5fG0o8JhDlBxdLEqN8Cp30mWWuJX9b2myLf-McAFcG-q7AGEtzSNNPt92dhJKgbUOkSmAYmJMTzYsx2X2K6sFdyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledgvddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtke
 ertddtvdejnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeegjeevheeufeehje
 dvgeeigedugeethfeugfejteetheeugeehteduffeludefnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomh
X-ME-Proxy: <xmx:2ia6ZYbQ3D7bh6ulMAHNkcgfgKjixHHg0AZxV5Wcjs44s19BHUUlcQ>
 <xmx:2ia6ZWbxKNOx36HWF2cv_WsrHTqXtiD1c_EpBq3K59c0iAEovsL76w>
 <xmx:2ia6ZcAIPzDCLv2U_sjjfiwDwt441-WVQr5X3Agw3faAa2bdWo0dkg>
 <xmx:2ia6ZU3IgMwVmRqJ91L86LJNGgfPtq_Apfi2Yrs50QAOU7pKxXEy5g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 05:54:17 -0500 (EST)
Message-ID: <adf88341-b7a2-4c83-bf34-b2aac0dc82cb@flygoat.com>
Date: Wed, 31 Jan 2024 10:54:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: why various devices are loading x86 roms on non-x86 architectures?
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <8e838817-8b55-4275-a199-0562216d2d1d@tls.msk.ru>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com; keydata=
 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
 HVO98ZmbMeg=
In-Reply-To: <8e838817-8b55-4275-a199-0562216d2d1d@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.19;
 envelope-from=jiaxun.yang@flygoat.com; helo=wout3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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



在 2024/1/31 10:28, Michael Tokarev 写道:
> Hi!
>
> qemu-system-aarch64 -device virtio-vga
>
> this one loads vgabios-virtio.bin.  Why?
> Does this bios work on aarch64 (or any other non-x86 arch)?
> Should there may be some conditional in this and similar places?
> The same is true for x86 pxe roms and other x86-only roms.

FYI on some systems they use x86emu (or biosemu) to run x86 only
OpROMs, this is at least true for u-boot (u-boot/drivers/bios_emulator),
PMON (MIPS/Loongson) and coreboot.

Thanks
- Jiaxun

>
> Thanks,
>
> /mjt
>

-- 
---
Jiaxun Yang


