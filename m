Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF053CE8347
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGmt-0003rF-4q; Mon, 30 Sep 2024 09:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1svGmr-0003l4-Pw; Mon, 30 Sep 2024 09:50:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1svGmq-0004Ah-3R; Mon, 30 Sep 2024 09:50:05 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7B5D14E6010;
 Mon, 30 Sep 2024 15:50:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id fPl3r7gBlzan; Mon, 30 Sep 2024 15:50:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8735F4E6004; Mon, 30 Sep 2024 15:50:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 85693746F60;
 Mon, 30 Sep 2024 15:50:00 +0200 (CEST)
Date: Mon, 30 Sep 2024 15:50:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, 
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 3/3] hw/ppc/virtex_ml507: Replace tswap32() by
 stl_endian_p()
In-Reply-To: <20240930125323.54671-4-philmd@linaro.org>
Message-ID: <807e337f-5ad9-3ba6-8485-e5fe65766789@eik.bme.hu>
References: <20240930125323.54671-1-philmd@linaro.org>
 <20240930125323.54671-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1673666391-1727704200=:41097"
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

--3866299591-1673666391-1727704200=:41097
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Mon, 30 Sep 2024, Philippe Mathieu-Daudé wrote:
> Replace the target-specific tswap32() call by stl_endian_p()
> which does the same but takes the endianness as argument, thus
> is target-agnostic.
> Get the vCPU endianness calling ppc_cpu_is_big_endian().

I don't know about virtex but maybe the same comment applies as for 
sam460ex.

Regards,
BALATON Zoltan

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/ppc/virtex_ml507.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index c49da1f46f..135dcbde06 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -141,7 +141,7 @@ static void main_cpu_reset(void *opaque)
>
>     /* Create a mapping for the kernel.  */
>     mmubooke_create_initial_mapping(env, 0, 0);
> -    env->gpr[6] = tswap32(EPAPR_MAGIC);
> +    stl_endian_p(ppc_cpu_is_big_endian(CPU(cpu)), &env->gpr[6], EPAPR_MAGIC);
>     env->gpr[7] = bi->ima_size;
> }
>
>
--3866299591-1673666391-1727704200=:41097--

