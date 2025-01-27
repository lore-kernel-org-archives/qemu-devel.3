Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CDDC0218D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 00:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcD0h-0003kI-DT; Sun, 26 Jan 2025 19:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1155a3140=graf@amazon.de>)
 id 1tcD0g-0003k3-2Z; Sun, 26 Jan 2025 19:29:50 -0500
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1155a3140=graf@amazon.de>)
 id 1tcD0e-0003vI-7q; Sun, 26 Jan 2025 19:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1737937788; x=1769473788;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1CW7QrQuY535yIxYdxvZyKWa4nCyH6ZLrqRFGNx49Oc=;
 b=ZWwZdrfGEkK0EsxLbivYU/8+sF/Mt3v9fcRRGfSIj9uc2jaPp+VQUsRQ
 QR68hbUIXU+LF6NmRjBCpjxNUxOgs//v0h6f6kxGdw0cdvv0E+25ow5K6
 2OJas9R6l1nAlHZ7Rd6KkM1R0Y1DvB5KnOBKno1z4RnQ8616Fiq9KX13H o=;
X-IronPort-AV: E=Sophos;i="6.13,237,1732579200"; d="scan'208";a="372062737"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80007.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 00:29:41 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:16822]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.79:2525] with
 esmtp (Farcaster)
 id cfa39458-8857-455d-858b-eff9b0664ce4; Mon, 27 Jan 2025 00:29:41 +0000 (UTC)
X-Farcaster-Flow-ID: cfa39458-8857-455d-858b-eff9b0664ce4
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 27 Jan 2025 00:29:41 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Mon, 27 Jan 2025
 00:29:33 +0000
Message-ID: <890f3e12-a511-40a0-a3c3-d7134b470a1f@amazon.com>
Date: Sun, 26 Jan 2025 16:29:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/sysbus/platform-bus: Introduce
 TYPE_DYNAMIC_SYS_BUS_DEVICE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Anthony PERARD
 <anthony@xenproject.org>, Gustavo Romero <gustavo.romero@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, <qemu-ppc@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, <xen-devel@lists.xenproject.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex Williamson
 <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20250125181343.59151-1-philmd@linaro.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=99.78.197.218;
 envelope-from=prvs=1155a3140=graf@amazon.de; helo=smtp-fw-80007.amazon.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.027, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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


On 25.01.25 10:13, Philippe Mathieu-Daudé wrote:
> Some SysBus devices can optionally be dynamically plugged onto
> the sysbus-platform-bus (then virtual guests are aware of
> mmio mapping and IRQs via device tree / ACPI rules).
>
> This series makes these devices explicit by having them implement
> the DYNAMIC_SYS_BUS_DEVICE class, which only sets 'user_creatable'
> flag to %true but makes the codebase a bit clearer (IMHO, at least
> now we can grep for DYNAMIC_SYS_BUS_DEVICE).


I love it. Thank you! This is clearly much more readable than the 
magical hint swizzling I did :).

Reviewed-by: Alexander Graf <graf@amazon.com>


Alex


