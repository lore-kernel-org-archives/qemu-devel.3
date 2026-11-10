Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EC606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BNcF52cJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQodB-0007NE-Vj; Tue, 10 Nov 2026 11:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xQodA-0007MG-0q
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:23:32 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xQod8-0004dW-Ft
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:23:31 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c49c32650adso144350866b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794327809; x=1794932609; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gdJSOqxwGZiY5LbvHFmA8nRsQrtTKVchWkfMISbRfL4=;
 b=BNcF52cJBvBkG3Cri65OjQBQih3jXNDEmwwGjbPbZX45lq8XvIAaJLC9N8JzeUqbmZ
 3efSIVH24lRQh0xzUsCdJwp4N24ABDPjoljzVEuCZQS+N4czUQufOQjZRTaEFilpERvu
 TDjhqwxomm6xwslcEMvUtvbXGhoxrC11l7mIpco91QLXBfLP91hloB0umrerPHTffNhw
 c9VahJFYdlPjR5vw670Arza+ABMX5UwVAvZgf/I/nfhSgLAHR2oa4Nc8XhUXBCoih+nN
 nmVi9tkQbM2rBPMvp85Eat1KA+XTsugJMlkTdMf7OT9NLHCEBCdyVxdg6T21zYYBkLU6
 leoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794327809; x=1794932609;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gdJSOqxwGZiY5LbvHFmA8nRsQrtTKVchWkfMISbRfL4=;
 b=oV4uqBlRSNCosxGLVUuqJriifEJdb1XQ1AEHqwBKIUHX+MQ52Z+nzkA7WIwibL+doD
 z+++unVusArjfXmajyJKwdiifPxcLXXEJ8JjtaCyNx5s7Bpd1VJ6PoYi1TbWcYHRUi/u
 ypWqVP88xu6Ws1CHbnxTV9NHQODrfigU05nPbFZK9MkrH6ai5FcxboOk790gontQwQPZ
 0jZBhdTkcOJFwoHE5uMDeWCOH57KsPyevjHSqKtcr8c4ZfnM4cC+DwmyS7JNVoobSXpr
 vfMhCXe39xcBTpaODzqQdaxo57Zo1AfkjO8UO2aibkTfRQ0kObBZix6MMBxVDZDdBRZU
 LVOQ==
X-Gm-Message-State: APuU4Z9s5xUZuCGPubGyMwoNqoRBg/ZfkyhPFcmYuwboAFyBlGXxiYQq
 luM7Af9o5a688GY6dJUKKCQmqIeomsOGZ0Xd9gxB4g8WaCgkL3av856zpb1RIosP6Z7z6pwY9Lm
 3/WfUUBk=
X-Gm-Gg: AYBFou2TWzYDurpMtAQGWHFZ4ItZcLHxkmg3bLIzZ9FfEBcm/ERWVPjGSCsgTUHkMdG
 pziFEKEE29AcJQvYeHZO2OOfj7me+2PU0eRAx9qqi7dFTvXCKNQmJbemIH2XUYDMWqk67UUI2p0
 Vp3uEa86y7nfSg/RimtLG216bW0VGBHZ5u7lcdp71NLoHjlTswuH4f8OpaQecNlD3pNMOgkC/8/
 z16HHxSCtEKID3667g5IlLrBmzee6tLSk69dv140aAJVirgfZL6zlkabcOA0P+KxcJh0D6u5jyO
 9NJNd/i/TpLa8U/OoAFGjEssZTqdGkzqvPDds76z/0VAYW5/cznjp9sT1Gy6QWMDUS+1rrVrmdh
 gzvyY7xVt9vJpeC7SZhilUfwHReTZjQqgTUB+a2Fr8RuJgNOKc43ZDPn8vViLFsR4tghkd7iQpz
 Ab3xcK/GEWRqIOa3WlMf2MfLJM5NNr8ibsD867oRvZ21usI/nH54yRyjwvLISef08s97Bte25AH
 7zycu3tDU8W+oQPLUAvCfTz91Ff0YAbWARdAnwtoxbVl7GPOeE9aoUf+jbFDtj5gBZfUthwRJLK
 RR4d2Z+GUfWxa/Xbdz0cOsfw3lZg6s2Q
X-Received: by 2002:a17:907:c1e:b0:c40:dfec:50b6 with SMTP id
 a640c23a62f3a-c504974fe2dmr275100366b.49.1794327808640; 
 Tue, 10 Nov 2026 08:23:28 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:aa96:7f3b:af27:16e8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a57085fsm131968566b.22.2026.11.10.08.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 08:23:27 -0800 (PST)
Date: Tue, 10 Nov 2026 16:23:25 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: Re: [PATCH for-11.2 1/4] hw/intc/arm_gicv5: Use cached
 IRS_IST_BASER.VALID state
Message-ID: <avNE_fHfwLISriHr@linaro.org>
References: <20261103172616.2400758-1-peter.maydell@linaro.org>
 <20261103172616.2400758-2-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103172616.2400758-2-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Nov 03, 2026 at 05:26:13PM +0000, Peter Maydell wrote:
> When the guest writes to IRS_IST_BASER we effectively cache the value
> of the VALID bit in the GICv5ISTConfig valid field entry.  In a few
> places we check whether the IST is valid by doing a bit extract on
> the register value; switch those to look at cfg->structure instead.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv5.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 5d0a50ab6aa..d0a8574916b 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -1222,8 +1222,7 @@ static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
>      uint64_t l1_iste;
>      MemTxResult res;
>  
> -    if (!FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID) ||
> -        !cfg->structure) {
> +    if (!cfg->valid || !cfg->structure) {
>          /* WI if no IST set up or it is not 2-level */
>          return;
>      }
> @@ -1293,7 +1292,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
>  {
>      GICv5Common *cs = ARM_GICV5_COMMON(s);
>  
> -    if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
> +    if (s->phys_lpi_config[domain].valid) {
>          /* If VALID is set, ADDR is RO and we can only update VALID */
>          bool valid = FIELD_EX64(value, IRS_IST_BASER, VALID);
>          if (valid) {
> @@ -1604,7 +1603,7 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
>                              deposit64(cs->irs_ist_baser[domain], 32, 32, data));
>          return true;
>      case A_IRS_IST_CFGR:
> -        if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
> +        if (s->phys_lpi_config[domain].valid) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "guest tried to write IRS_IST_CFGR for %s config frame "
>                            "while IST_BASER.VALID set\n", domain_name[domain]);

That makes sense.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


