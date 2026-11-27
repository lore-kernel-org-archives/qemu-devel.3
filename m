Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5309606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iytn65eL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=91bsUcKw;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iytn65eL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=91bsUcKw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwDT-0004WF-Ma; Fri, 27 Nov 2026 08:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1xWwDK-0004V5-1q; Fri, 27 Nov 2026 08:42:10 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1xWwDH-0003W0-Ss; Fri, 27 Nov 2026 08:42:09 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45F742292F;
 Fri, 27 Nov 2026 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795786925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Wnt4l2DTsWCPZeyj+ZYlqJWpAVjCgKbDO3USm42dDw=;
 b=iytn65eLhZyDjNy1Hfmf3JNf2Wi4lM5gnW60q8aYYYvUkW1aY0SuGGutTGXEiHR3YVsj1y
 bZPh6W9UjQE7jwbBGk/WGEUvv9Kx6YLBtEjcyrsusXJJe3dE67bETEDIvqEwELEyqD21c4
 0EHoLnydrMXZ8vI5HGwSlBwnr5pcrEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795786925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Wnt4l2DTsWCPZeyj+ZYlqJWpAVjCgKbDO3USm42dDw=;
 b=91bsUcKwcNndpBXUjBcTqWPmgt9+SiW2HlqHT/UtgaEm1GzPCAAmb1+OegEMtcOOgS5oUE
 CrWQ+djRGn6e9iAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795786925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Wnt4l2DTsWCPZeyj+ZYlqJWpAVjCgKbDO3USm42dDw=;
 b=iytn65eLhZyDjNy1Hfmf3JNf2Wi4lM5gnW60q8aYYYvUkW1aY0SuGGutTGXEiHR3YVsj1y
 bZPh6W9UjQE7jwbBGk/WGEUvv9Kx6YLBtEjcyrsusXJJe3dE67bETEDIvqEwELEyqD21c4
 0EHoLnydrMXZ8vI5HGwSlBwnr5pcrEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795786925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Wnt4l2DTsWCPZeyj+ZYlqJWpAVjCgKbDO3USm42dDw=;
 b=91bsUcKwcNndpBXUjBcTqWPmgt9+SiW2HlqHT/UtgaEm1GzPCAAmb1+OegEMtcOOgS5oUE
 CrWQ+djRGn6e9iAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75D7613432;
 Fri, 27 Nov 2026 13:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +24xBKyICWuLIwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Nov 2026 13:42:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, peterx@redhat.com, Gavin Shan
 <gshan@redhat.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH for-12.0 v2 8/9] arm/machine: Move all
 VMSTATE_VALIDATE() usages into post_load
In-Reply-To: <20261126231631.3392756-9-peterx@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
 <20261126231631.3392756-9-peterx@redhat.com>
Date: Fri, 27 Nov 2026 10:41:57 -0300
Message-ID: <87pkvqqtlm.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[7]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[nongnu.org:email,linaro.org:email,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Xu <peterx@redhat.com> writes:

> To pave way removing VMSTATE_VALIDATE(), move all four such uses into a
> post_load hook instead.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  target/arm/machine.c | 90 ++++++++++++++++++--------------------------
>  1 file changed, 37 insertions(+), 53 deletions(-)
>
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index e86fa85a9b..b401593496 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -407,14 +407,6 @@ static const VMStateDescription vmstate_m_faultmask_primask = {
>   * just non-secure, we transfer both banks here rather than putting
>   * the secure banked version in the m-security subsection.
>   */
> -static bool csselr_vmstate_validate(void *opaque, int version_id)
> -{
> -    ARMCPU *cpu = opaque;
> -
> -    return cpu->env.v7m.csselr[M_REG_NS] <= R_V7M_CSSELR_INDEX_MASK
> -        && cpu->env.v7m.csselr[M_REG_S] <= R_V7M_CSSELR_INDEX_MASK;
> -}
> -
>  static bool m_csselr_needed(void *opaque)
>  {
>      ARMCPU *cpu = opaque;
> @@ -429,7 +421,6 @@ static const VMStateDescription vmstate_m_csselr = {
>      .needed = m_csselr_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(env.v7m.csselr, ARMCPU, M_REG_NUM_BANKS),
> -        VMSTATE_VALIDATE("CSSELR is valid", csselr_vmstate_validate),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -590,18 +581,6 @@ static bool pmsav7_needed(void *opaque)
>             !arm_feature(env, ARM_FEATURE_V8);
>  }
>  
> -static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_id)
> -{
> -    ARMCPU *cpu = opaque;
> -
> -    /*
> -     * Check MPU_RNR in-bounds. If no MPU, we still migrate this field
> -     * but number of regions == 0 and MPU_RNR is RAZ/WI so also 0
> -     */
> -    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion ||
> -        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_NS] == 0);
> -}
> -
>  static const VMStateDescription vmstate_pmsav7 = {
>      .name = "cpu/pmsav7",
>      .version_id = 1,
> @@ -614,7 +593,6 @@ static const VMStateDescription vmstate_pmsav7 = {
>                                vmstate_info_uint32, uint32_t),
>          VMSTATE_VARRAY_UINT32(env.pmsav7.dracr, ARMCPU, pmsav7_dregion, 0,
>                                vmstate_info_uint32, uint32_t),
> -        VMSTATE_VALIDATE("rgnr is valid", pmsav7_rgnr_vmstate_validate),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -695,31 +673,6 @@ static const VMStateDescription vmstate_pmsav8 = {
>      }
>  };
>  
> -static bool s_rnr_vmstate_validate(void *opaque, int version_id)
> -{
> -    ARMCPU *cpu = opaque;
> -
> -    /*
> -     * Check MPU_RNR in-bounds. If no MPU, we still migrate this field
> -     * but number of regions == 0 and MPU_RNR is RAZ/WI so also 0
> -     */
> -    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion ||
> -        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_S] == 0);
> -}
> -
> -static bool sau_rnr_vmstate_validate(void *opaque, int version_id)
> -{
> -    ARMCPU *cpu = opaque;
> -
> -    /*
> -     * Check SAU_RNR in-bounds. If no SAU regions are implemented,
> -     * we still migrate this field, but number of regions == 0 and
> -     * SAU_RNR is RAZ/WI so also 0
> -     */
> -    return cpu->env.sau.rnr < cpu->sau_sregion ||
> -        (cpu->sau_sregion == 0 && cpu->env.sau.rnr == 0);
> -}
> -
>  static bool m_security_needed(void *opaque)
>  {
>      ARMCPU *cpu = opaque;
> @@ -749,7 +702,6 @@ static const VMStateDescription vmstate_m_security = {
>          VMSTATE_VARRAY_UINT32(env.pmsav8.rlar[M_REG_S], ARMCPU, pmsav7_dregion,
>                                0, vmstate_info_uint32, uint32_t),
>          VMSTATE_UINT32(env.pmsav7.rnr[M_REG_S], ARMCPU),
> -        VMSTATE_VALIDATE("secure MPU_RNR is valid", s_rnr_vmstate_validate),
>          VMSTATE_UINT32(env.v7m.mpu_ctrl[M_REG_S], ARMCPU),
>          VMSTATE_UINT32(env.v7m.ccr[M_REG_S], ARMCPU),
>          VMSTATE_UINT32(env.v7m.mmfar[M_REG_S], ARMCPU),
> @@ -761,7 +713,6 @@ static const VMStateDescription vmstate_m_security = {
>          VMSTATE_VARRAY_UINT32(env.sau.rlar, ARMCPU, sau_sregion, 0,
>                                vmstate_info_uint32, uint32_t),
>          VMSTATE_UINT32(env.sau.rnr, ARMCPU),
> -        VMSTATE_VALIDATE("SAU_RNR is valid", sau_rnr_vmstate_validate),
>          VMSTATE_UINT32(env.sau.ctrl, ARMCPU),
>          VMSTATE_UINT32(env.v7m.scr[M_REG_S], ARMCPU),
>          /* AIRCR is not secure-only, but our implementation is R/O if the
> @@ -1177,11 +1128,48 @@ static bool cpu_post_load(void *opaque, int version_id, Error **errp)
>      ARMCPU *cpu = opaque;
>      CPUARMState *env = &cpu->env;
>      bool ignore_s_regs;
> +    bool valid;
>      int i, v;
>  
>      trace_cpu_post_load(cpu->cpreg_vmstate_array_len,
>                          cpu->cpreg_array_len);
>  
> +    if (env->v7m.csselr[M_REG_NS] > R_V7M_CSSELR_INDEX_MASK ||
> +        env->v7m.csselr[M_REG_S] > R_V7M_CSSELR_INDEX_MASK) {
> +        error_setg(errp, "CSSELR is invalid");
> +        return false;
> +    }
> +
> +    /*
> +     * Check MPU_RNR in-bounds. If no MPU, we still migrate these fields
> +     * but number of regions == 0 and MPU_RNR is RAZ/WI so also 0
> +     */
> +    valid = env->pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion ||
> +        (cpu->pmsav7_dregion == 0 && env->pmsav7.rnr[M_REG_NS] == 0);
> +    if (!valid) {
> +        error_setg(errp, "rgnr is invalid");
> +        return false;
> +    }
> +
> +    valid = env->pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion ||
> +        (cpu->pmsav7_dregion == 0 && env->pmsav7.rnr[M_REG_S] == 0);
> +    if (!valid) {
> +        error_setg(errp, "secure MPU_RNR is invalid");
> +        return false;
> +    }
> +
> +    /*
> +     * Check SAU_RNR in-bounds. If no SAU regions are implemented,
> +     * we still migrate this field, but number of regions == 0 and
> +     * SAU_RNR is RAZ/WI so also 0
> +     */
> +    valid = env->sau.rnr < cpu->sau_sregion ||
> +        (cpu->sau_sregion == 0 && env->sau.rnr == 0);
> +    if (!valid) {
> +        error_setg(errp, "SAU_RNR is invalid");
> +        return false;
> +    }

Shouldn't you guard these blocks with the result of what .needed would
have returned on the source? Otherwise we may not migrate a value but
still try to validate it here? I haven't checked if the unmigrated field
may end up with a value that will cause these checks to pass.

> +
>      /*
>       * Handle migration compatibility from old QEMU which didn't
>       * send the irq-line-state subsection. A QEMU without it did not
> @@ -1426,10 +1414,6 @@ const VMStateDescription vmstate_arm_cpu = {
>          &vmstate_vfp,
>          &vmstate_m,
>          &vmstate_thumb2ee,
> -        /* pmsav7_rnr must come before pmsav7 so that we have the
> -         * region number before we test it in the VMSTATE_VALIDATE
> -         * in vmstate_pmsav7.
> -         */
>          &vmstate_pmsav7_rnr,
>          &vmstate_pmsav7,
>          &vmstate_pmsav8,

