Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0C2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ysP-0006k4-8h; Wed, 01 Oct 2025 11:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v3ys8-0006Z5-Gn; Wed, 01 Oct 2025 11:36:06 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v3yrt-0006pL-QY; Wed, 01 Oct 2025 11:36:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B240356FC02;
 Wed, 01 Oct 2025 17:35:23 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id v17iwLDMpHUJ; Wed,  1 Oct 2025 17:35:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9D57656F327; Wed, 01 Oct 2025 17:35:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9B44E56F320;
 Wed, 01 Oct 2025 17:35:21 +0200 (CEST)
Date: Wed, 1 Oct 2025 17:35:21 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 03/22] monitor/hmp-cmds: Get cpu first addr space with
 cpu_get_address_space()
In-Reply-To: <20251001150529.14122-4-philmd@linaro.org>
Message-ID: <2b87c3ee-2b25-bea5-3f73-bd089848d19e@eik.bme.hu>
References: <20251001150529.14122-1-philmd@linaro.org>
 <20251001150529.14122-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-943157711-1759332921=:37311"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--3866299591-943157711-1759332921=:37311
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 1 Oct 2025, Philippe Mathieu-Daudé wrote:
> In order to remove the convenient CPUState::as field, access
> the vcpu first address space using the cpu_get_address_space()
> helper.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> monitor/hmp-cmds-target.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index e9820611466..602af851328 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -128,6 +128,8 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>     uint8_t buf[16];
>     uint64_t v;
>     CPUState *cs = mon_get_cpu(mon);
> +    AddressSpace *as = cs ? cpu_get_address_space(cs, 0)
> +                          : &address_space_memory;

Why move from local scope to an upper level?

Regards,
BALATON Zoltan

>     if (!cs && (format == 'i' || !is_physical)) {
>         monitor_printf(mon, "Can not dump without CPU\n");
> @@ -174,7 +176,6 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>         if (l > line_size)
>             l = line_size;
>         if (is_physical) {
> -            AddressSpace *as = cs ? cs->as : &address_space_memory;
>             MemTxResult r = address_space_read(as, addr,
>                                                MEMTXATTRS_UNSPECIFIED, buf, l);
>             if (r != MEMTX_OK) {
>
--3866299591-943157711-1759332921=:37311--

