Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C5BD29DEF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaRU-0000YG-Qq; Tue, 13 Jan 2026 04:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vfaRF-000084-EW
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:11:46 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vfaRD-0007De-Lw
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=0e+y0OEJJGwj96u/ZqTmfKvv9FWYoI7vEqfWvPiw1TQ=; b=ducX0M22QwKIEDr
 vJnaLLz+DOnlPFzX7RTePezXhcZZKS99s4S+jcaHlME/oISgNuBAjzN72dgFHSit6dmkYSEJzIZ9L
 p830CVgefGoyruA67LyjDKj5lvr8m12GBHs99GmYsib0NMKlFsVjcANiVAJE7ceLaEZDtTDV15wRf
 jU=;
Date: Tue, 13 Jan 2026 10:15:14 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 3/7] target/xtensa: Replace TARGET_BIG_ENDIAN ->
 target_big_endian()
Message-ID: <3ohpo3iwesovvwhurfm4olpq2tzlx2ymcly66eq5l3sep72znl@3fjs7ow32dr3>
References: <20260107202556.55787-1-philmd@linaro.org>
 <20260107202556.55787-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107202556.55787-4-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 07/01/26, Philippe Mathieu-Daudé wrote:
> Check endianness at runtime to remove the target-specific
> TARGET_BIG_ENDIAN definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/xtensa/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index bb8d2ed86cf..36f069d70ca 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -34,6 +34,7 @@
>  #include "tcg/tcg-op.h"
>  #include "qemu/log.h"
>  #include "qemu/qemu-print.h"
> +#include "qemu/target-info.h"
>  #include "exec/translator.h"
>  #include "exec/translation-block.h"
>  #include "exec/target_page.h"
> @@ -1381,7 +1382,7 @@ static void translate_bb(DisasContext *dc, const OpcodeArg arg[],
>      TCGv_i32 tmp = tcg_temp_new_i32();
>  
>      tcg_gen_andi_i32(tmp, arg[1].in, 0x1f);
> -    if (TARGET_BIG_ENDIAN) {
> +    if (target_big_endian()) {
>          tcg_gen_shr_i32(tmp, tcg_constant_i32(0x80000000u), tmp);
>      } else {
>          tcg_gen_shl_i32(tmp, tcg_constant_i32(0x00000001u), tmp);
> @@ -1394,7 +1395,7 @@ static void translate_bbi(DisasContext *dc, const OpcodeArg arg[],
>                            const uint32_t par[])
>  {
>      TCGv_i32 tmp = tcg_temp_new_i32();
> -    if (TARGET_BIG_ENDIAN) {
> +    if (target_big_endian()) {
>          tcg_gen_andi_i32(tmp, arg[0].in, 0x80000000u >> arg[1].imm);
>      } else {
>          tcg_gen_andi_i32(tmp, arg[0].in, 0x00000001u << arg[1].imm);
> -- 
> 2.52.0
> 

What about the two remaining uses of TARGET_BIG_ENDIAN? The one in cpu.c
is straight forward

  static void xtensa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
  {
      XtensaCPU *cpu = XTENSA_CPU(cs);
  
      info->private_data = cpu->env.config->isa;
      info->print_insn = print_insn_xtensa;
      info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
                                       : BFD_ENDIAN_LITTLE;
  }

I guess for the one in overlay_tool.h we can register all cores
unconditionally and filter for endianness mismatch with target_big_endian()
later?

  #if TARGET_BIG_ENDIAN == (XCHAL_HAVE_BE != 0)
  #define REGISTER_CORE(core) \
      static void __attribute__((constructor)) register_core(void) \
      { \
          static XtensaConfigList node = { \
              .config = &core, \
          }; \
          xtensa_register_core(&node); \
      }
  #else
  #define REGISTER_CORE(core)
  #endif

