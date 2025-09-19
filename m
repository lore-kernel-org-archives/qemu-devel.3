Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2180CCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZBe-0007Ik-Ht; Fri, 19 Sep 2025 07:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uzZBa-0007IA-6d
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:21:54 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uzZBV-0007qg-Dt
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:21:53 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250919112136epoutp02bc63cc1aeb21a38f3a85f0a3811208b7~mqyjWKwEw0277102771epoutp02o
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 11:21:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250919112136epoutp02bc63cc1aeb21a38f3a85f0a3811208b7~mqyjWKwEw0277102771epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1758280896;
 bh=3yn/KW2bmWzYuUi5OwdjJHmz8YuJfw2lYQuZ5SWPnU0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CmJawpAVlWqPbLJFECnvRadnSz78D9A6NcGBx/ta7WP/MOQ6u+81gZtKaZRiA72ey
 uhhqFhQGwhdmXEQet3n/TnNYuAGcLb1WPtNyAIAn/SHFPYV9TiKqY/bytn6T05Vdgb
 VWM6rJUOZjvn3URiNn7/d9OcpeOmFjMBaTlVZKe0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20250919112136epcas5p18b92389ca22990174547eefa1a1b77e6~mqyi9xKvj1606216062epcas5p1u;
 Fri, 19 Sep 2025 11:21:36 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.92]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4cSqp70KPNz3hhT3; Fri, 19 Sep
 2025 11:21:35 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20250919112134epcas5p1e778db12a690be6d26ab97bde4c76ad7~mqyhfvjLe1862218622epcas5p1O;
 Fri, 19 Sep 2025 11:21:34 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250919112132epsmtip15be0f491d2f2a66440b823eeb6a3ee4e~mqygHHg-G1157411574epsmtip1b;
 Fri, 19 Sep 2025 11:21:32 +0000 (GMT)
Date: Fri, 19 Sep 2025 16:51:27 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, arpit.sysdev@gmail.com,
 cpgs@samsung.com
Subject: Re: [PATCH v4 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250919112127.moncriuj2fnatxl7@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <20250917172905.00005fa3@huawei.com>
X-CMS-MailID: 20250919112134epcas5p1e778db12a690be6d26ab97bde4c76ad7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----M3TZWmnaQcCgpq3P2cdOV_lud716KtFuwxspURBH1dZsF.eH=_1d428_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250916080808epcas5p23113551a9a0719d68a8c3efff15209cc
References: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
 <CGME20250916080808epcas5p23113551a9a0719d68a8c3efff15209cc@epcas5p2.samsung.com>
 <20250916080736.1266083-3-arpit1.kumar@samsung.com>
 <20250917172905.00005fa3@huawei.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------M3TZWmnaQcCgpq3P2cdOV_lud716KtFuwxspURBH1dZsF.eH=_1d428_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/09/25 05:29PM, Jonathan Cameron wrote:
>On Tue, 16 Sep 2025 13:37:36 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> -added assert-deassert PERST implementation
>>  for physical ports (both USP and DSP's).
>> -assert PERST involves bg operation for holding 100ms.
>> -reset PPB implementation for physical ports.
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>
>> @@ -4702,11 +4818,34 @@ static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
>>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>>                                    DeviceState *d, size_t payload_max)
>>  {
>> +    CXLUpstreamPort *pp;
>> +    uint8_t pn = 0;
>> +
>>      cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
>>      cci->d = d;
>>      cci->intf = intf;
>>      cxl_init_cci(cci, payload_max);
>>      cxl_set_phy_port_info(cci);
>> +    /* physical port control */
>> +    pp = CXL_USP(cci->d);
>This bit feels like it is wrongly located.  I ran into this whilst
>trying to add back the mctp variant as part of shuffling my cxl staging tree.
>
>Whilst this only gets used for the CCI commands, it is a USP thing not
>a mailbox thing as we only want this called once per USP, not once per CCI on the
>USP.
>
>Could we move this to a call from cxl_usp_realize?
>
>If something like that works would you mind sending me a patch on top of this
>series to do so? I'm not yet set up to test this series so better you do it.
>
>We don't need that upstream until the first MCTP support on USP so this doesn't
>block us on that front.
>
>
>Thanks,
>Jonathan
>
Hi Jonathan,
Sure, will look into it as this seems tricky and then send a patch on top of this series.
Also, it would be helpful if you have any suggestions for going about this change.

Thanks,
Arpit
>> +    for (int byte_index = 0; byte_index < (CXL_MAX_PHY_PORTS / BITS_PER_BYTE);
>> +         byte_index++) {
>> +        unsigned char byte = pp->pports.active_port_bitmask[byte_index];
>> +
>> +        for (int bit_index = 0; bit_index < 8; bit_index++, pn++) {
>> +            if (((byte) & (1 << bit_index)) != 0) {
>> +                qemu_mutex_init(&pp->pports.perst[pn].lock);
>> +                pp->pports.perst[pn].issued_assert_perst = false;
>> +                /*
>> +                 * Assert PERST involves physical port to be in
>> +                 * hold reset phase for minimum 100ms. No other
>> +                 * physical port control requests are entertained
>> +                 * until Deassert PERST command.
>> +                 */
>> +                pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
>> +            }
>> +        }
>> +    }
>>  }
>>

------M3TZWmnaQcCgpq3P2cdOV_lud716KtFuwxspURBH1dZsF.eH=_1d428_
Content-Type: text/plain; charset="utf-8"


------M3TZWmnaQcCgpq3P2cdOV_lud716KtFuwxspURBH1dZsF.eH=_1d428_--

