Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA05C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcOzX-0003Ev-Te; Tue, 20 Feb 2024 07:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rcOzU-0003E7-Ej; Tue, 20 Feb 2024 07:12:52 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rcOzS-000302-2y; Tue, 20 Feb 2024 07:12:52 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C3A124E6005;
 Tue, 20 Feb 2024 13:12:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ihrLosSy3V1K; Tue, 20 Feb 2024 13:12:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8C1E94E6013; Tue, 20 Feb 2024 13:12:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 89A1C7456FE;
 Tue, 20 Feb 2024 13:12:39 +0100 (CET)
Date: Tue, 20 Feb 2024 13:12:39 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, 
 Michael Tokarev <mjt@tls.msk.ru>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v1 06/21] ppc: correct typos
In-Reply-To: <95ffc19d9c3877052a1a6dabf91e139fda183427.1708419115.git.manos.pitsidianakis@linaro.org>
Message-ID: <237221f1-8c57-5535-8ca1-0a1205ac2854@eik.bme.hu>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <95ffc19d9c3877052a1a6dabf91e139fda183427.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 20 Feb 2024, Manos Pitsidianakis wrote:
> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> include/hw/ppc/ppc4xx.h             | 2 +-
> hw/ppc/ppc405.h                     | 2 +-
> target/ppc/translate/vmx-impl.c.inc | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index ea7740239b..c4ecb1652f 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -75,7 +75,7 @@ struct Ppc4xxMalState {
>     uint8_t  rxcnum;
> };
>
> -/* Peripheral local bus arbitrer */
> +/* Peripheral local bus arbiter */
> #define TYPE_PPC4xx_PLB "ppc4xx-plb"
> OBJECT_DECLARE_SIMPLE_TYPE(Ppc4xxPlbState, PPC4xx_PLB);
> struct Ppc4xxPlbState {
> diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
> index 9a4312691e..a39f0caea1 100644
> --- a/hw/ppc/ppc405.h
> +++ b/hw/ppc/ppc405.h
> @@ -41,7 +41,7 @@ struct Ppc405PobState {
>     uint32_t besr1;
> };
>
> -/* OPB arbitrer */
> +/* OPB arbiter */

These two aren't actually typos. The PPC docs call it that. Somebody tried 
to fix these before but this spelling is also valid and what is used in 
the docs.

> #define TYPE_PPC405_OPBA "ppc405-opba"
> OBJECT_DECLARE_SIMPLE_TYPE(Ppc405OpbaState, PPC405_OPBA);
> struct Ppc405OpbaState {
> diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
> index 4b91c3489d..b56e615c24 100644
> --- a/target/ppc/translate/vmx-impl.c.inc
> +++ b/target/ppc/translate/vmx-impl.c.inc
> @@ -1183,7 +1183,7 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
>
> /*
>  * Support for Altivec instructions that use bit 31 (Rc) as an opcode
> - * bit but also use bit 21 as an actual Rc bit.  In general, thse pairs
> + * bit but also use bit 21 as an actual Rc bit.  In general, these pairs

This one is a typo.

Regards,
BALATON Zoltan

>  * come from different versions of the ISA, so we must also support a
>  * pair of flags for each instruction.
>  */
>

