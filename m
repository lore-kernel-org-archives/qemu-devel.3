Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D8BFCB61B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXUq-0002ZR-ND; Fri, 06 Mar 2026 10:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyXUo-0002Yh-Fl; Fri, 06 Mar 2026 10:53:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyXUm-00039B-6Y; Fri, 06 Mar 2026 10:53:46 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS9sm0bhSzJ46Ds;
 Fri,  6 Mar 2026 23:53:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 4CB4240585;
 Fri,  6 Mar 2026 23:53:38 +0800 (CST)
Received: from localhost (10.48.149.21) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 15:53:37 +0000
Date: Fri, 6 Mar 2026 15:53:36 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 08/65] hw/intc/arm_gicv5: Define macros for config frame
 registers
Message-ID: <20260306155336.00006937@huawei.com>
In-Reply-To: <20260223170212.441276-9-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-9-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.149.21]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

On Mon, 23 Feb 2026 17:01:15 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Define constants for the various registers in the IRS config frame
> using the REG and FIELD macros.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Hi Peter,

I think one tiny error, with that tidied up.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/intc/arm_gicv5.c | 243 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 243 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 7ef48bb450..db754e7681 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -7,6 +7,7 @@
>   */

> @@ -22,6 +23,248 @@ static const char *domain_name[] = {
>      [GICV5_ID_REALM] = "Realm",
>  };
>  
> +REG32(IRS_IDR0, 0x0)
> +    FIELD(IRS_IDR0, INT_DOM, 0, 2)
> +    FIELD(IRS_IDR0, PA_RANGE, 2, 5)

Bits 2-5 so
FIELD(IRS_IDR0, PA_RANGE, 2, 4)
Otherwise overlaps with VIRT

> +    FIELD(IRS_IDR0, VIRT, 6, 1)

...


> +
> +REG32(IRS_AIDR, 0x44)
> +    FIELD(IRS_AIDR, ARCHMINORREV, 0, 4)
Style wise the GICV5 spec does like to mix it up with
underscores camelCase and just generally smashing words
together.  Ah well :)


> +    FIELD(IRS_AIDR, ARCHMAJORREV, 4, 4)
> +    FIELD(IRS_AIDR, COMPONENT, 8, 4)


