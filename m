Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93E9C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 06:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrY4F-0001ay-6g; Tue, 02 Apr 2024 02:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rv+n=LH=kaod.org=clg@ozlabs.org>)
 id 1rrY4D-0001ZY-26
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:56:21 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rv+n=LH=kaod.org=clg@ozlabs.org>)
 id 1rrY4A-0005oi-Et
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:56:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4V7zDp3fNTz4x0t;
 Tue,  2 Apr 2024 17:56:10 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7zDm3CwYz4x0q;
 Tue,  2 Apr 2024 17:56:08 +1100 (AEDT)
Message-ID: <c8a82773-04ff-44d4-9a75-1e1f9b4efa10@kaod.org>
Date: Tue, 2 Apr 2024 08:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] P11 support for QEMU
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20240401055503.1880587-1-adityag@linux.ibm.com>
 <c671fb5a-18d7-4c3a-beec-ad3f28114986@kaod.org>
 <7dpmvbcarr2lbbjih3n6d6kaj23dzrmtowqme4lnyhbjeexffw@u3agsb3prq7b>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <7dpmvbcarr2lbbjih3n6d6kaj23dzrmtowqme4lnyhbjeexffw@u3agsb3prq7b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=rv+n=LH=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
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

Hello Aditya,

On 4/2/24 08:39, Aditya Gupta wrote:
> Hello Cédric,
> 
> Thanks for reviewing this.
> 
> On Mon, Apr 01, 2024 at 10:25:31AM +0200, Cédric Le Goater wrote:
>> Hello Aditya,
>>
>> Please run ./scripts/get_maintainer.pl when sending a series. qemu-ppc should be
>> in Cc:
> 
> Tried it now, For some reason, get_maintainer.pl shows no maintainers:
> 
>      $ ./scripts/get_maintainer.pl -f 0002-ppc-powernv11-add-base-support-for-P11-PowerNV.patch
>      get_maintainer.pl: No maintainers found, printing recent contributors.
>      get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
>      
>      qemu-devel@nongnu.org (open list:All patches CC here)

Weird. I downloaded your series with b4 and ran the get_maintainer.pl script :

$ ./scripts/get_maintainer.pl 20240401_adityag_p11_support_for_qemu.patches/0001_ppc_pseries_add_p11_cpu_type.patch 20240401_adityag_p11_support_for_qemu.patches/0002_ppc_powernv11_add_base_support_for_p11_powernv.patch

Nicholas Piggin <npiggin@gmail.com> (odd fixer:sPAPR (pseries))
Daniel Henrique Barboza <danielhb413@gmail.com> (reviewer:sPAPR (pseries))
David Gibson <david@gibson.dropbear.id.au> (reviewer:sPAPR (pseries))
Harsh Prateek Bora <harshpb@linux.ibm.com> (reviewer:sPAPR (pseries))
"Cédric Le Goater" <clg@kaod.org> (odd fixer:PowerNV Non-Virt...)
"Frédéric Barrat" <fbarrat@linux.ibm.com> (reviewer:PowerNV Non-Virt...)
qemu-ppc@nongnu.org (open list:sPAPR (pseries))
qemu-devel@nongnu.org (open list:All patches CC here)

  
> I checked the MAINTAINERS file, will add maintainers in Cc, thanks.
> 
>>
>> Briefly looking at this, please separate the changes using one patch per model,
>> that is : first CPU (target), LPC, OCC, PSI, SBE, PnvCore, SpaprCore. Last the
>> PnvChip and the machines, powernv11 and pseries. A minimum commit log describing
>> the HW is required.
> 
> Sure, I will split the changes and improve my commit descriptions.
> 
>> I don't see PHB6 or XIVE3. Why ?
> 
> Power11 core is same as Power10, so it supports till PHB5 and XIVE2,
> same as P10. That's why I have not added any code for them.

ok. That's typically the info the commit log should have.

>> Also, you will need an OPAL update. The above changes are pointless without it.
>> The minimum for now is a git commit from the opal repo, then you will need to
>> update QEMU with a binary.
> 
> Agreed. I will consult when we push it to public. Will update this in
> next series.
> 
> There might be some days delay in the next patch series.

We have entered the QEMU 9.1 cycle. There is time. I will comment more
the next respin.

Thanks,

C.


