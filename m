Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F25C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 16:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpW0i-0008EO-I5; Wed, 27 Mar 2024 12:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ScIh=LB=kaod.org=clg@ozlabs.org>)
 id 1rpW0Y-00081g-HM; Wed, 27 Mar 2024 12:20:11 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ScIh=LB=kaod.org=clg@ozlabs.org>)
 id 1rpW0U-0001iU-2j; Wed, 27 Mar 2024 12:20:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4V4X1y6S87z4wcF;
 Thu, 28 Mar 2024 03:19:50 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4V4X1t10K6z4wjF;
 Thu, 28 Mar 2024 03:19:45 +1100 (AEDT)
Message-ID: <365e7b19-3ed9-4739-934c-234f2338c3fd@kaod.org>
Date: Wed, 27 Mar 2024 17:19:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] pnv/phb4: Mask off LSI Source-ID based on number of
 interrupts
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
 <20240321100422.5347-11-saif.abrar@linux.vnet.ibm.com>
 <26c7a63d-78fe-4378-b950-0673f0c96114@kaod.org>
 <4777474d-fc4b-4ef1-8847-b6568bec4937@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <4777474d-fc4b-4ef1-8847-b6568bec4937@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ScIh=LB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/27/24 10:59, Saif Abrar wrote:
> Hello Cedric,
> 
>>   }
>>   +static void pnv_phb4_fund_A_reset(PnvPHB4 *phb)
>>
>> What is fund_A ?
> 
> I used 'fund_A' as an abbreviation to "Fundamental Register Set A".
> 
> Please let know if you suggest another abbreviation to name this method.

pnv_phb4_reset_xsrc may be ?


Thanks,

C.

> 
>>> +{
>>> +    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);
>>
>> Is this mask the default value for HW ?
> Yes, the spec defines the bits[04:12] of LSI Source ID having reset value: 0x1FF
> 
> 
> Regards,
> 
> Saif
> 
> 
> On 25-03-2024 07:04 pm, Cédric Le Goater wrote:
>> On 3/21/24 11:04, Saif Abrar wrote:
>>> Add a method to reset the value of LSI Source-ID.
>>> Mask off LSI source-id based on number of interrupts in the big/small PHB.
>>
>> Looks ok.
>>
>>
>>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>>> ---
>>>   hw/pci-host/pnv_phb4.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>>> index f48750ee54..8fbaf6512e 100644
>>> --- a/hw/pci-host/pnv_phb4.c
>>> +++ b/hw/pci-host/pnv_phb4.c
>>> @@ -489,6 +489,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
>>>         lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
>>>       lsi_base <<= 3;
>>> +    lsi_base &= (xsrc->nr_irqs - 1);
>>>         /* TODO: handle reset values of PHB_LSI_SRC_ID */
>>>       if (!lsi_base) {
>>> @@ -1966,6 +1967,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4 *phb)
>>>       /* TODO: Add more RO-masks as regs are implemented in the model */
>>>   }
>>>   +static void pnv_phb4_fund_A_reset(PnvPHB4 *phb)
>>
>> What is fund_A ?
>>
>>> +{
>>> +    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);
>>
>> Is this mask the default value for HW ?
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>>> +    pnv_phb4_update_xsrc(phb);
>>> +}
>>> +
>>>   static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
>>>   {
>>>       STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
>>> @@ -2023,6 +2030,7 @@ static void pnv_phb4_reset(void *dev)
>>>       pnv_phb4_cfg_core_reset(phb);
>>>       pnv_phb4_pbl_core_reset(phb);
>>>   +    pnv_phb4_fund_A_reset(phb);
>>>       pnv_phb4_err_reg_reset(phb);
>>>       pnv_phb4_pcie_stack_reg_reset(phb);
>>>       pnv_phb4_regb_err_reg_reset(phb);
>>> @@ -2102,8 +2110,6 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
>>>           return;
>>>       }
>>>   -    pnv_phb4_update_xsrc(phb);
>>> -
>>>       phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
>>>         pnv_phb4_xscom_realize(phb);
>>


