Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323FDCF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 06:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svswf-0001Zj-BS; Wed, 02 Oct 2024 02:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org>)
 id 1svswc-0001ZA-Pj; Wed, 02 Oct 2024 02:34:43 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org>)
 id 1svswb-00013a-5f; Wed, 02 Oct 2024 02:34:42 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XJQ5T3MRHz4wcj;
 Wed,  2 Oct 2024 16:34:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XJQ5R3bVPz4wc1;
 Wed,  2 Oct 2024 16:34:35 +1000 (AEST)
Message-ID: <528e7681-09fc-48bf-b9c2-18247deba513@kaod.org>
Date: Wed, 2 Oct 2024 08:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] ppc/spapr: remove deprecated machine pseries-2.2
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241001092910.1030913-1-harshpb@linux.ibm.com>
 <20241001092910.1030913-3-harshpb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241001092910.1030913-3-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=nzkv=Q6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/1/24 11:29, Harsh Prateek Bora wrote:
> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
> deprecated with reasons mentioned in its commit log.
> Removing pseries-2.2 specific code with this patch for now.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/spapr.c | 17 -----------------
>   1 file changed, 17 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ec906e1d77..3c7d251356 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -5364,23 +5364,6 @@ static void spapr_machine_2_3_class_options(MachineClass *mc)
>   }
>   DEFINE_SPAPR_MACHINE(2, 3);
>   
> -/*
> - * pseries-2.2
> - */
> -
> -static void spapr_machine_2_2_class_options(MachineClass *mc)
> -{
> -    static GlobalProperty compat[] = {
> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0x20000000" },


Keep in mind that when the pseries-2.7 machine will be removed later in
this patchset, more cleanup could be done in spapr_phb_realize().


Thanks,

C.


> -    };
> -
> -    spapr_machine_2_3_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_2, hw_compat_2_2_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -    mc->default_machine_opts = "modern-hotplug-events=off,suppress-vmdesc=on";
> -}
> -DEFINE_SPAPR_MACHINE(2, 2);
> -
>   static void spapr_machine_register_types(void)
>   {
>       type_register_static(&spapr_machine_info);


