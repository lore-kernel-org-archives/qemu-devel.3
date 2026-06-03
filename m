Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7876CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfhu-0002S8-Ca; Wed, 03 Jun 2026 03:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfhs-0002S0-A1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:04 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfhq-00008z-Ff
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780470192; bh=yt8J1rwxZAUmrZtiYCQ1hzYzZju2UL20sBs8Al7tqFA=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=c9RDhYwG/gPLgNW327xwYm5nC7ZOLNfzUEzaGyoW6saq7G5Fn1pyzKbvrXjxBSym1
 /iGR0xcj4NK97uhs8ddh2kXg6MrT9/3BWKXD0LGguD8lLBloBtpA0COskpZtfXTQb1
 8+40YrDNwp1scMjsawObbN1m9HTtag4RQSqd37iQ=
Received: by be1-2.in.mailobj.net [192.168.91.12] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:03:08 +0200 (CEST)
X-EA-Auth: 4Nw0URQj7uPkczvBXVqvHNNkx3xc4E9leBket7ns3si5A4JDRle7F/xVrIls7rY36YuSgD5VbuHUAvm5ZvL3pxgtxZFSWUCR
Message-ID: <931c8511-8c13-4134-b562-d4766d1a101c@mailo.com>
Date: Wed, 3 Jun 2026 09:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] docs/specs/fw_cfg: Document all architecture register
 layouts
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
 <20260529174639.451353-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260529174639.451353-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.182.54.8; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi Peter,

On 29/5/26 19:46, Peter Maydell wrote:
> We implement the fw_cfg device for more architectures and machines
> that we let on about in our documentation.  Luckily most of the new
> ones (notably riscv and loongarch) have followed the straightforward
> layout that the Arm virt board picked.
> 
> Restructure the documentation to present this as the "standard"
> layout, followed by the other layouts used by various other boards
> for historical reasons.  This adds PA-RISC, SPARC, PPC and MIPS.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/specs/fw_cfg.rst | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/specs/fw_cfg.rst b/docs/specs/fw_cfg.rst
> index 31ae31576b..7e2fe0851d 100644
> --- a/docs/specs/fw_cfg.rst
> +++ b/docs/specs/fw_cfg.rst
> @@ -84,15 +84,35 @@ increasing address order, similar to memcpy().
>   Register Locations
>   ------------------
>   
> +For a memory-mapped fw_cfg device, the standard register layout is:
> +
> +    * base address : Data Register (64 bit)
> +    * base address + 8 : Selector Register (16 bit)
> +    * base address + 16 : DMA Address Register (64 bit)
> +
> +Some architectures or machines have a different layout for historical reasons:
> +
>   x86, x86_64
>       * Selector Register IOport: 0x510
>       * Data Register IOport:     0x511
>       * DMA Address IOport:       0x514
> +64-bit SPARC:
> +    * base address : Selector Register (16 bit)
> +    * base address + 1 : Data Register (8 bit)

IIUC they have both the same base address.


