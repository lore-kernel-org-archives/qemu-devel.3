Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D249CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyv2E-0005bN-8x; Wed, 17 Sep 2025 12:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uyv28-0005Z3-OI
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:29:28 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uyv25-0002NT-DD
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:29:28 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRkff1b2Mz6M5JB;
 Thu, 18 Sep 2025 00:26:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1010F14033F;
 Thu, 18 Sep 2025 00:29:07 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 18:29:06 +0200
Date: Wed, 17 Sep 2025 17:29:05 +0100
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
 <krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
 <alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v4 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250917172905.00005fa3@huawei.com>
In-Reply-To: <20250916080736.1266083-3-arpit1.kumar@samsung.com>
References: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
 <CGME20250916080808epcas5p23113551a9a0719d68a8c3efff15209cc@epcas5p2.samsung.com>
 <20250916080736.1266083-3-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 16 Sep 2025 13:37:36 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> -added assert-deassert PERST implementation
>  for physical ports (both USP and DSP's).
> -assert PERST involves bg operation for holding 100ms.
> -reset PPB implementation for physical ports.
> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>

> @@ -4702,11 +4818,34 @@ static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>                                    DeviceState *d, size_t payload_max)
>  {
> +    CXLUpstreamPort *pp;
> +    uint8_t pn = 0;
> +
>      cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
>      cxl_set_phy_port_info(cci);
> +    /* physical port control */
> +    pp = CXL_USP(cci->d);
This bit feels like it is wrongly located.  I ran into this whilst
trying to add back the mctp variant as part of shuffling my cxl staging tree.

Whilst this only gets used for the CCI commands, it is a USP thing not
a mailbox thing as we only want this called once per USP, not once per CCI on the
USP.

Could we move this to a call from cxl_usp_realize?

If something like that works would you mind sending me a patch on top of this
series to do so? I'm not yet set up to test this series so better you do it.

We don't need that upstream until the first MCTP support on USP so this doesn't
block us on that front.

 
Thanks,
Jonathan

> +    for (int byte_index = 0; byte_index < (CXL_MAX_PHY_PORTS / BITS_PER_BYTE);
> +         byte_index++) {
> +        unsigned char byte = pp->pports.active_port_bitmask[byte_index];
> +
> +        for (int bit_index = 0; bit_index < 8; bit_index++, pn++) {
> +            if (((byte) & (1 << bit_index)) != 0) {
> +                qemu_mutex_init(&pp->pports.perst[pn].lock);
> +                pp->pports.perst[pn].issued_assert_perst = false;
> +                /*
> +                 * Assert PERST involves physical port to be in
> +                 * hold reset phase for minimum 100ms. No other
> +                 * physical port control requests are entertained
> +                 * until Deassert PERST command.
> +                 */
> +                pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
> +            }
> +        }
> +    }
>  }
>  

