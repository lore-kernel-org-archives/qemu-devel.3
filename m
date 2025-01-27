Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0A3C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcOjO-0000Vw-8g; Mon, 27 Jan 2025 08:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tcOjK-0000Ot-0W; Mon, 27 Jan 2025 08:00:42 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tcOjI-0008RM-41; Mon, 27 Jan 2025 08:00:41 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AA7354E600E;
 Mon, 27 Jan 2025 14:00:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ed1xDBco8JDT; Mon, 27 Jan 2025 14:00:31 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AA3FD4E6004; Mon, 27 Jan 2025 14:00:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A7F7274577C;
 Mon, 27 Jan 2025 14:00:31 +0100 (CET)
Date: Mon, 27 Jan 2025 14:00:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/6] hw/loader: Clarify local variable name in
 load_elf_ram_sym()
In-Reply-To: <20250127113824.50177-4-philmd@linaro.org>
Message-ID: <6c51f4a7-ae43-fadb-cf3b-191d4b59975c@eik.bme.hu>
References: <20250127113824.50177-1-philmd@linaro.org>
 <20250127113824.50177-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1921631016-1737982831=:99138"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-1921631016-1737982831=:99138
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 27 Jan 2025, Philippe Mathieu-Daudé wrote:
> load_elf_ram_sym() compares target_data_order versus
> host data_order. Rename 'data_order' -> 'host_data_order'
> to ease code review.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/core/loader.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index ead10fb6cb5..fc2e8f91267 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -443,7 +443,7 @@ ssize_t load_elf_ram_sym(const char *filename,
>                          int clear_lsb, int data_swab,
>                          AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)
> {
> -    int fd, data_order, target_data_order, must_swab;
> +    int fd, host_data_order, target_data_order, must_swab;
>     ssize_t ret = ELF_LOAD_FAILED;
>     uint8_t e_ident[EI_NIDENT];
>
> @@ -462,11 +462,11 @@ ssize_t load_elf_ram_sym(const char *filename,
>         goto fail;
>     }
> #if HOST_BIG_ENDIAN
> -    data_order = ELFDATA2MSB;
> +    host_data_order = ELFDATA2MSB;
> #else
> -    data_order = ELFDATA2LSB;
> +    host_data_order = ELFDATA2LSB;
> #endif
> -    must_swab = data_order != e_ident[EI_DATA];
> +    must_swab = host_data_order != e_ident[EI_DATA];
>     if (big_endian) {
>         target_data_order = ELFDATA2MSB;
>     } else {
>
--3866299591-1921631016-1737982831=:99138--

