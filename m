Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7B5C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlQm-0005Ww-T3; Tue, 16 Jul 2024 12:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTlQi-0005Cd-4m; Tue, 16 Jul 2024 12:53:32 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTlQf-0003YK-Ck; Tue, 16 Jul 2024 12:53:31 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNlWW0dfMz4w2N;
 Wed, 17 Jul 2024 02:53:27 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNlWT0kMkz4wc4;
 Wed, 17 Jul 2024 02:53:24 +1000 (AEST)
Message-ID: <e58aa5f8-d6f5-4683-aaae-9ee2e8f8e91f@kaod.org>
Date: Tue, 16 Jul 2024 18:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/19] ppc/pnv: Implement Power9 CPU core thread state
 indirect register
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240716162617.32161-1-npiggin@gmail.com>
 <20240716162617.32161-14-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240716162617.32161-14-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/16/24 18:26, Nicholas Piggin wrote:
> Power9 CPUs have a core thread state register accessible via SPRC/SPRD
> indirect registers. This register includes a bit for big-core mode,
> which skiboot requires.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   target/ppc/misc_helper.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 692e48e6bc..e69236d2de 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -319,6 +319,23 @@ target_ulong helper_load_sprd(CPUPPCState *env)
>       case 0: /* SCRATCH0-3 */
>       case 1: /* SCRATCH4-7 */
>           return pc->scratch[(sprc >> 3) & 0x7];
> +
> +    case 0x1e0: /* core thread state */
> +        if (env->excp_model == POWERPC_EXCP_POWER9) {
> +            /*
> +             * Only implement for POWER9 because skiboot uses it to check
> +             * big-core mode. Other bits are unimplemented so we would
> +             * prefer to get unimplemented message on POWER10 if it were
> +             * used anywhere.
> +             */
> +            if (pc->big_core) {
> +                return PPC_BIT(63);
> +            } else {
> +                return 0;
> +            }
> +        }
> +        /* fallthru */
> +
>       default:
>           qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
>                                     TARGET_FMT_lx"\n", sprc);


