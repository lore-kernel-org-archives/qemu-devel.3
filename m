Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD301CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yrv-0006Lo-48; Wed, 01 Oct 2025 11:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v3yrZ-0005bl-HR; Wed, 01 Oct 2025 11:35:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v3yr9-0006SL-OJ; Wed, 01 Oct 2025 11:35:25 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5588D56F2FF;
 Wed, 01 Oct 2025 17:34:25 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id l6Eqi0KpxAaJ; Wed,  1 Oct 2025 17:34:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4E6F456FD27; Wed, 01 Oct 2025 17:34:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4C91656FD26;
 Wed, 01 Oct 2025 17:34:23 +0200 (CEST)
Date: Wed, 1 Oct 2025 17:34:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 02/22] disas/disas-mon: Get cpu first addr space with
 cpu_get_address_space()
In-Reply-To: <20251001150529.14122-3-philmd@linaro.org>
Message-ID: <543b8aa4-0fc4-7988-943c-55c3a462d07a@eik.bme.hu>
References: <20251001150529.14122-1-philmd@linaro.org>
 <20251001150529.14122-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-462952728-1759332863=:37311"
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

--3866299591-462952728-1759332863=:37311
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 1 Oct 2025, Philippe Mathieu-Daudé wrote:
> In order to remove the convenient CPUState::as field, access
> the vcpu first address space using the cpu_get_address_space()
> helper.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> disas/disas-mon.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/disas/disas-mon.c b/disas/disas-mon.c
> index 9c693618c27..f2e45d16021 100644
> --- a/disas/disas-mon.c
> +++ b/disas/disas-mon.c
> @@ -29,9 +29,10 @@ physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
>                      struct disassemble_info *info)
> {
>     CPUDebug *s = container_of(info, CPUDebug, info);
> +    AddressSpace *as = cpu_get_address_space(s->cpu, 0);
>     MemTxResult res;
>
> -    res = address_space_read(s->cpu->as, memaddr, MEMTXATTRS_UNSPECIFIED,
> +    res = address_space_read(as, memaddr, MEMTXATTRS_UNSPECIFIED,
>                              myaddr, length);

Does this now fit on one line?

Regards,
BALATON Zoltan

>     return res == MEMTX_OK ? 0 : EIO;
> }
>
--3866299591-462952728-1759332863=:37311--

