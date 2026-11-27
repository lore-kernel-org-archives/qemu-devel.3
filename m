Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E7606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=e1HNkf9S;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Vq7ognk5;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=e1HNkf9S;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Vq7ognk5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWvuz-0004eD-JB; Fri, 27 Nov 2026 08:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWvuv-0004dw-S4
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:23:10 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWvus-000777-10
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:23:08 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30616227AB;
 Fri, 27 Nov 2026 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795785782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cw5rsvM5Cqx8aZxePO8n/oyCfrscJCsH82A2dkbJiak=;
 b=e1HNkf9SqHw5+XNbqgmn9b+MiLG0dGYFVJDWJ7R+LtX53UbOGyZPhzmqTzYiYR7cTvKsGI
 6o5P10nCytJuOI/GnXVe3G6900M/QQosSlBq5EogsjdYgq3TRrae1TF4XSxoOqOpGpDXDx
 bivvYc9BGkHjhYV1BxiqGIF298B2ack=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795785782;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cw5rsvM5Cqx8aZxePO8n/oyCfrscJCsH82A2dkbJiak=;
 b=Vq7ognk5zcXcZIva0XJa15ezm9BmchzLKKI/VekDistJds1sHm8hvZl2Eo0qawnMfr1i/y
 FMOmStjWW7Y0wZAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795785782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cw5rsvM5Cqx8aZxePO8n/oyCfrscJCsH82A2dkbJiak=;
 b=e1HNkf9SqHw5+XNbqgmn9b+MiLG0dGYFVJDWJ7R+LtX53UbOGyZPhzmqTzYiYR7cTvKsGI
 6o5P10nCytJuOI/GnXVe3G6900M/QQosSlBq5EogsjdYgq3TRrae1TF4XSxoOqOpGpDXDx
 bivvYc9BGkHjhYV1BxiqGIF298B2ack=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795785782;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cw5rsvM5Cqx8aZxePO8n/oyCfrscJCsH82A2dkbJiak=;
 b=Vq7ognk5zcXcZIva0XJa15ezm9BmchzLKKI/VekDistJds1sHm8hvZl2Eo0qawnMfr1i/y
 FMOmStjWW7Y0wZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C7FB134E8;
 Fri, 27 Nov 2026 13:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2yq+DTWECWsaEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Nov 2026 13:23:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, peterx@redhat.com, Gavin Shan
 <gshan@redhat.com>
Subject: Re: [PATCH for-12.0 v2 7/9] arm/machine: Convert cpu_post_load() to
 take Error**
In-Reply-To: <20261126231631.3392756-8-peterx@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
 <20261126231631.3392756-8-peterx@redhat.com>
Date: Fri, 27 Nov 2026 10:22:50 -0300
Message-ID: <87se0mquhh.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Xu <peterx@redhat.com> writes:

> Convert it to post_load_errp() version, so as to be able to report verbose
> errors when hit.
>
> A few things to mention:
>
> - The old "fail" count won't work with Error**, switch to fail and return
>   immediately, assuming we should stop migration immediately hitting the
>   1st error.
>

You could keep the handle_cpreg* untouched and just create a new generic
Error when fail > 0 like you did for !kvm_arm_cpu_post_load() and
!write_list_to_cpustate(), no? That way we don't lose the reporting of
the other bugged registers.

> - Alone the way, handle_cpreg_only_in_incoming_stream() return value is
>   flipped to make it match QEMU's normal coding style (return true for
>   success, false for error, not vice versa).
>
> - Provide simple error strings for the cases where the lower function
>   doesn't yet take an Error**.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  target/arm/machine.c | 52 ++++++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 02a2b78506..e86fa85a9b 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -11,6 +11,7 @@
>  #include "migration/qemu-file-types.h"
>  #include "migration/vmstate.h"
>  #include "target/arm/gtimer.h"
> +#include "qapi/error.h"
>  
>  static bool vfp_needed(void *opaque)
>  {
> @@ -1151,10 +1152,11 @@ static void handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx
>   * Handle the situation where @kvmidx is in the incoming
>   * stream but not on destination. This fails the migration if
>   * no cpreg mig tolerance is matched for this @kvmidx
> - * Return true if the migration should eventually fail
> + * Return true if success, false otherwise.
>   */
>  static bool
> -handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx, uint64_t value)
> +handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx, uint64_t value,
> +                                     Error **errp)
>  {
>      g_autofree gchar *name = print_register_name(kvmidx);
>  
> @@ -1163,18 +1165,17 @@ handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx, uint64_t valu
>          arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
>                                            value, 0, ToleranceOnlySrcTestValue)) {
>          trace_tolerate_cpreg_only_in_incoming_stream(name);
> -        return false;
> +        return true;
>      }
> -    error_report("%s: %s in the incoming stream but unknown on the "
> -                 "destination: fail migration", __func__, name);
> -    return true;
> +    error_setg(errp, "cpreg %s in the incoming stream but unknown on the "
> +               "destination", name);
> +    return false;
>  }
>  
> -static int cpu_post_load(void *opaque, int version_id)
> +static bool cpu_post_load(void *opaque, int version_id, Error **errp)
>  {
>      ARMCPU *cpu = opaque;
>      CPUARMState *env = &cpu->env;
> -    bool fail = false;
>      bool ignore_s_regs;
>      int i, v;
>  
> @@ -1229,9 +1230,11 @@ static int cpu_post_load(void *opaque, int version_id)
>              continue;
>          }
>          if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
> -            fail = handle_cpreg_only_in_incoming_stream(cpu,
> -                                                        cpu->cpreg_vmstate_indexes[v],
> -                                                        cpu->cpreg_vmstate_values[v]);
> +            if (!handle_cpreg_only_in_incoming_stream(
> +                    cpu, cpu->cpreg_vmstate_indexes[v],
> +                    cpu->cpreg_vmstate_values[v], errp)) {
> +                return false;
> +            }
>              v++;
>              continue;
>          }
> @@ -1278,21 +1281,22 @@ static int cpu_post_load(void *opaque, int version_id)
>       * still regs in the input stream, continue parsing the vmstate array
>       */
>      for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
> -        fail = handle_cpreg_only_in_incoming_stream(cpu,
> -                                                    cpu->cpreg_vmstate_indexes[v],
> -                                                    cpu->cpreg_vmstate_values[v]);
> -    }
> -    if (fail) {
> -        return -1;
> +        if (!handle_cpreg_only_in_incoming_stream(
> +                cpu, cpu->cpreg_vmstate_indexes[v],
> +                cpu->cpreg_vmstate_values[v], errp)) {
> +            return false;
> +        }
>      }
>  
>      if (kvm_enabled()) {
>          if (!kvm_arm_cpu_post_load(cpu)) {
> -            return -1;
> +            error_setg(errp, "kvm_arm_cpu_post_load() failed");
> +            return false;
>          }
>      } else {
>          if (!write_list_to_cpustate(cpu)) {
> -            return -1;
> +            error_setg(errp, "write_list_to_cpustate() failed");
> +            return false;
>          }
>      }
>  
> @@ -1307,7 +1311,8 @@ static int cpu_post_load(void *opaque, int version_id)
>       * thumb_tr_translate_insn().
>       */
>      if (!is_a64(env) && env->thumb && (env->regs[15] & 1)) {
> -        return -1;
> +        error_setg(errp, "Misaligned thumb pc");
> +        return false;
>      }
>  
>      if (tcg_enabled()) {
> @@ -1325,7 +1330,8 @@ static int cpu_post_load(void *opaque, int version_id)
>                        FPCR_LTPSIZE_SHIFT, FPCR_LTPSIZE_LENGTH) != 4 ||
>              extract32(env->v7m.fpdscr[M_REG_S],
>                        FPCR_LTPSIZE_SHIFT, FPCR_LTPSIZE_LENGTH) != 4) {
> -            return -1;
> +            error_setg(errp, "Bogus fpdscr[] values");
> +            return false;
>          }
>      }
>  
> @@ -1337,7 +1343,7 @@ static int cpu_post_load(void *opaque, int version_id)
>          arm_rebuild_hflags(env);
>      }
>  
> -    return 0;
> +    return true;
>  }
>  
>  const VMStateDescription vmstate_arm_cpu = {
> @@ -1347,7 +1353,7 @@ const VMStateDescription vmstate_arm_cpu = {
>      .pre_save = cpu_pre_save,
>      .post_save = cpu_post_save,
>      .pre_load = cpu_pre_load,
> -    .post_load = cpu_post_load,
> +    .post_load_errp = cpu_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(env.regs, ARMCPU, 16),
>          VMSTATE_UINT64_ARRAY(env.xregs, ARMCPU, 32),

