Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48077CCF9F1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 10:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPkV-00020h-Ci; Thu, 30 Oct 2025 06:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEPkQ-00020N-VN
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:19:15 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEPkG-00042n-Dx
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:19:14 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CB6645972E3;
 Thu, 30 Oct 2025 11:18:57 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id dy_xkkD1kS2L; Thu, 30 Oct 2025 11:18:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8140F5972E8; Thu, 30 Oct 2025 11:18:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F7F85972E4;
 Thu, 30 Oct 2025 11:18:55 +0100 (CET)
Date: Thu, 30 Oct 2025 11:18:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 15/32] hw/ppc/pegasos2: Change device tree generation
In-Reply-To: <e41be786-df4c-41e5-ae29-c9e8875ee0d2@linux.ibm.com>
Message-ID: <25b1b618-589c-10fa-b0ec-4d29382080d3@eik.bme.hu>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
 <20251023121653.3686015-16-harshpb@linux.ibm.com>
 <CAFEAcA8qbC-1LhHXxiYXZjiCvstch1UFtMNxGdR1fquLB9i2PA@mail.gmail.com>
 <e41be786-df4c-41e5-ae29-c9e8875ee0d2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-634874362-1761819535=:43010"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-634874362-1761819535=:43010
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 30 Oct 2025, Harsh Prateek Bora wrote:
> Would you be taking care of this coverity issue?

Yes. As this is a fix it's OK to fix during the freeze. I was waiting for 
the rename patch to get merged to not need to rebase that so once that 
lands I'll send a patch on top.

Regards,
BALATON Zoltan

> On 10/27/25 18:44, Peter Maydell wrote:
>> On Thu, 23 Oct 2025 at 13:22, Harsh Prateek Bora <harshpb@linux.ibm.com> 
>> wrote:
>>> 
>>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>> 
>>> We generate a flattened device tree programmatically for VOF. Change
>>> this to load the static parts from a device tree blob and only
>>> generate the parts that depend on run time conditions such as CPU
>>> type, memory size and PCI devices. Moving the static parts in a dts
>>> makes the board code simpler and more generic.
>>> 
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Link: 
>>> https://lore.kernel.org/qemu-devel/383891fc2696609b27d2de9773efe1b4f493e333.1761176219.git.balaton@eik.bme.hu
>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> 
>> Hi; Coverity points out (CID 1642027) that this change
>> accidentally introduces a memory leak:
>> 
>>> @@ -780,7 +675,10 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, 
>>> void *opaque)
>>>                                        pci_get_word(&d->config[PCI_VENDOR_ID]),
>>>                                        pci_get_word(&d->config[PCI_DEVICE_ID]));
>>> 
>>> -    if (pci_get_word(&d->config[PCI_CLASS_DEVICE])  ==
>>> +    if (!strcmp(pn, "pci1106,8231")) {
>>> +        return; /* ISA bridge and devices are included in dtb */
>>> +    }
>> 
>> In this function we define at the top:
>>      GString *node = g_string_new(NULL);
>> 
>> This change introduces an early-return which does not free
>> the GString.
>> 
>> The simplest fix is probably to declare node as
>>     g_autoptr(GString) node = g_string_new(NULL);
>> 
>> and delete the now-superfluous g_string_free() from the
>> bottom of the function.
>> 
>> thanks
>> -- PMM
>
>
--3866299591-634874362-1761819535=:43010--

