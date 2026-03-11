Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEF7FD0651
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0KLz-0004BG-5O; Wed, 11 Mar 2026 10:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0KLq-00049Y-8b; Wed, 11 Mar 2026 10:15:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0KLn-000746-Cm; Wed, 11 Mar 2026 10:15:53 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWCSz3jLGzHnGh6;
 Wed, 11 Mar 2026 22:15:31 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 548574056A;
 Wed, 11 Mar 2026 22:15:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 14:15:38 +0000
Date: Wed, 11 Mar 2026 14:15:37 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 20/65] hw/intc/arm_gicv5: Implement remaining set-config
 functions
Message-ID: <20260311141537.00003ce9@huawei.com>
In-Reply-To: <20260223170212.441276-21-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-21-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 23 Feb 2026 17:01:27 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Implement the GICv5 functions corresponding to the stream protocol
> SetEnabled, SetPending, SetHandling, and SetTarget commands.  These
> work exactly like SetPriority: the IRS looks up the L2TE and updates
> the corresponding field in it with the new value.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Trivial formatting and naming comments only.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/intc/arm_gicv5.c                | 133 +++++++++++++++++++++++++++++
>  hw/intc/trace-events               |   4 +
>  include/hw/intc/arm_gicv5_stream.h |  68 +++++++++++++++
>  include/hw/intc/arm_gicv5_types.h  |  15 ++++
>  4 files changed, 220 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index af27fb7e63..3c6ef17573 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -492,6 +492,139 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id,
>      put_l2_iste(cs, cfg, &h);
>  }
>  
> +void gicv5_set_enabled(GICv5Common *cs, uint32_t id,
> +                        bool enabled, GICv5Domain domain,
> +                        GICv5IntType type, bool virtual)
Seems like wrapping as:
void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
                       GICv5Domain domain, GICv5IntType type, bool virtual)

might be better. I'm not seeing clear reason to do the 3 line version
unless maybe another parameter turns up in a later patch.
Same applies to other cases.


> +{
> +    const GICv5ISTConfig *cfg;
> +    GICv5 *s = ARM_GICV5(cs);
> +    uint32_t *l2_iste_p;
> +    L2_ISTE_Handle h;
> +
> +    trace_gicv5_set_enabled(domain_name[domain], inttype_name(type), virtual,
> +                            id, enabled);
> +    if (virtual) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
> +                      "enable state of a virtual interrupt\n");
> +        return;
> +    }
> +    if (type != GICV5_LPI) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
> +                      "enable state of bad interrupt type %d\n", type);
> +        return;
> +    }
> +    cfg = &s->phys_lpi_config[domain];
> +    l2_iste_p = get_l2_iste(cs, cfg, id, &h);
> +    if (!l2_iste_p) {
> +        return;
> +    }
> +    *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ENABLE, enabled);
> +    put_l2_iste(cs, cfg, &h);
> +}

> +void gicv5_set_handling(GICv5Common *cs, uint32_t id,

Might be worth throwing _mode in there as set_handling almost
feels like 'set that it is being handled'  Also aligns better
with the HM naming in the spec.

Not that important though give from the actual code it is easy to
see this is HM.

> +                        GICv5HandlingMode handling, GICv5Domain domain,
> +                        GICv5IntType type, bool virtual)
> +{
> +    const GICv5ISTConfig *cfg;
> +    GICv5 *s = ARM_GICV5(cs);
> +    uint32_t *l2_iste_p;
> +    L2_ISTE_Handle h;
> +
> +    trace_gicv5_set_handling(domain_name[domain], inttype_name(type), virtual,
> +                            id, handling);
> +    if (virtual) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
> +                      "handling mode of a virtual interrupt\n");
> +        return;
> +    }
> +    if (type != GICV5_LPI) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
> +                      "handling mode of bad interrupt type %d\n", type);
> +        return;
> +    }
> +    cfg = &s->phys_lpi_config[domain];
> +    l2_iste_p = get_l2_iste(cs, cfg, id, &h);
> +    if (!l2_iste_p) {
> +        return;
> +    }
> +    *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, HM, handling);
> +    put_l2_iste(cs, cfg, &h);
> +}



