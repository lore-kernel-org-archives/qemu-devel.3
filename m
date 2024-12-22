Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DB3E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 19:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPRJd-0001Aj-Nx; Sun, 22 Dec 2024 14:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tPRJb-0001AB-IO; Sun, 22 Dec 2024 14:08:35 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tPRJY-0003XP-DJ; Sun, 22 Dec 2024 14:08:34 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3ED484E6000;
 Sun, 22 Dec 2024 20:08:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id NHfmHnZauRAB; Sun, 22 Dec 2024 20:08:21 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F01B44E6004; Sun, 22 Dec 2024 20:08:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EE019746F60;
 Sun, 22 Dec 2024 20:08:21 +0100 (CET)
Date: Sun, 22 Dec 2024 20:08:21 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v4 6/6] hw/ppc/epapr: Do not swap ePAPR magic value
In-Reply-To: <20241220213103.6314-7-philmd@linaro.org>
Message-ID: <7a550018-7bf5-0926-c30b-608730334634@eik.bme.hu>
References: <20241220213103.6314-1-philmd@linaro.org>
 <20241220213103.6314-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1276269339-1734894501=:15324"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1276269339-1734894501=:15324
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 20 Dec 2024, Philippe Mathieu-Daudé wrote:
> The ePAPR magic value in $r6 doesn't need to be byte swapped.
>
> See ePAPR-v1.1.pdf chapter 5.4.1 "Boot CPU Initial Register State"
> and the following mailing-list threads:
> https://lore.kernel.org/qemu-devel/CAFEAcA_NR4XW5DNL4nq7vnH4XRH5UWbhQCxuLyKqYk6_FCBrAA@mail.gmail.com/
> https://lore.kernel.org/qemu-devel/D6F93NM6OW2L.2FDO88L38PABR@gmail.com/
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

The Linux image I have still seems to boot on sam460ex so

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/ppc/sam460ex.c     | 2 +-
> hw/ppc/virtex_ml507.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 78e2a46e753..db9c8f3fa6e 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -234,7 +234,7 @@ static void main_cpu_reset(void *opaque)
>
>         /* Create a mapping for the kernel.  */
>         booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1 << 31);
> -        env->gpr[6] = tswap32(EPAPR_MAGIC);
> +        env->gpr[6] = EPAPR_MAGIC;
>         env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
>
>     } else {
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index f378e5c4a90..6197d31d88f 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -119,7 +119,7 @@ static void main_cpu_reset(void *opaque)
>     /* Create a mapping spanning the 32bit addr space. */
>     booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1U << 31);
>     booke_set_tlb(&env->tlb.tlbe[1], 0x80000000, 0x80000000, 1U << 31);
> -    env->gpr[6] = tswap32(EPAPR_MAGIC);
> +    env->gpr[6] = EPAPR_MAGIC;
>     env->gpr[7] = bi->ima_size;
> }
>
>
--3866299591-1276269339-1734894501=:15324--

