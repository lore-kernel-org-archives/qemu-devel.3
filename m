Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83AACFC273
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 07:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0c1b-0006Sf-FF; Tue, 15 Oct 2024 03:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Jj9V=RL=kaod.org=clg@ozlabs.org>)
 id 1t0c14-0005Wt-No; Tue, 15 Oct 2024 03:30:58 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Jj9V=RL=kaod.org=clg@ozlabs.org>)
 id 1t0c0y-0003xi-SK; Tue, 15 Oct 2024 03:30:47 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XSQk10Ptcz4x8b;
 Tue, 15 Oct 2024 18:30:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XSQjz0h5Kz4x89;
 Tue, 15 Oct 2024 18:30:30 +1100 (AEDT)
Message-ID: <96cdd92b-1861-4ae7-94f3-266d6a150b75@kaod.org>
Date: Tue, 15 Oct 2024 09:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/13] ppc/spapr: remove deprecated machine
 pseries-2.12-sxxm
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241014122729.1136809-1-harshpb@linux.ibm.com>
 <20241014122729.1136809-13-harshpb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241014122729.1136809-13-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Jj9V=RL=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/14/24 14:27, Harsh Prateek Bora wrote:
> Commit 0cac0f1b964 marked pseries-2.12 machines as deprecated
> with reasons mentioned in its commit log.
> Removing pseries-2.12-sxxm specific code with this patch.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/spapr.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index faf88a177b..aba0ad26f1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4731,8 +4731,6 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>       DEFINE_SPAPR_MACHINE_IMPL(true, major, minor)
>   #define DEFINE_SPAPR_MACHINE(major, minor) \
>       DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
> -#define DEFINE_SPAPR_MACHINE_TAGGED(major, minor, tag) \
> -    DEFINE_SPAPR_MACHINE_IMPL(false, major, minor, _, tag)
>   
>   /*
>    * pseries-9.2
> @@ -5042,18 +5040,6 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
>   
>   DEFINE_SPAPR_MACHINE(2, 12);
>   
> -static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -
> -    spapr_machine_2_12_class_options(mc);
> -    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_WORKAROUND;
> -    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_WORKAROUND;
> -    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_FIXED_CCD;
> -}
> -
> -DEFINE_SPAPR_MACHINE_TAGGED(2, 12, sxxm);
> -
>   static void spapr_machine_register_types(void)
>   {
>       type_register_static(&spapr_machine_info);


