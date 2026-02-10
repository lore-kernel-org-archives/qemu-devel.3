Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBCBEA3F0F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphxt-0004sw-IH; Tue, 10 Feb 2026 02:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vphxn-0004qy-3E; Tue, 10 Feb 2026 02:15:11 -0500
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vphxl-0006Vy-06; Tue, 10 Feb 2026 02:15:10 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.54])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f9CWG2bW3z5vSm;
 Tue, 10 Feb 2026 07:15:06 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 10 Feb
 2026 08:15:05 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00500093ebf-0899-468e-b51c-e80f866d328e,
 013E132ABECAD38B5622F7607EFF7317793E1520) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <35909807-640e-4c9a-889e-fc87ae6cba1b@kaod.org>
Date: Tue, 10 Feb 2026 08:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB
 machine
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
 <20260210051008.355149-5-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260210051008.355149-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: dd7e46d2-05ec-4119-a3ff-213a744df165
X-Ovh-Tracer-Id: 15778924246242069310
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEeUhYMNAkoaNIVXlLdTA4InSNstz2o9jwR2abWyVLSxYt1jhpynjy3L/DyFbfM+5ijESU98Rvq1tsPYXguckmMGg8IgtpdR7X2OeFOjbDM7YsW9nh0Ev6kTUcdYHd7G6OIFY14kHpjce4E/DDeXWtdmhngmXiw53TQVnKj2se2HotgKDw8Fp4gPiKZiaYe5YuqHYDr8RHXlHSy9ohGgGgd9qzl8pn44Iub8GeYYw0yhn9Vw1xPmAUz3OmrKHo8od02S968WCa79PSMQYMEyZOMj87FYuHe13YeQQ6h0qEzM3FwbRna3OdSP21uAC5uP6zHAVBUcWi2snC1ObySKAuWDIAE3cgTbC7itukfHS2CSNg2Lq3sYzf3/qdZmmhIPQMsC6okVt4fClzeJygUgJX3YjrHh7wslTHaJX/rsmhIodN6ZlZZouGau590sG5Sc/GAuc89EJDAkIn96UDU1UWk0TXAYAX3CyQ8EDPrsBaUCm6VHqCklYl5Btcg8y4GGqDehmW8P0w5jeBzgJvGyLyRjt2Be6XprTVBuob1nS7mBtayniZqmfDQIKT0fcuMrpR2DDV7Z/fFtFm4JBVi1ZtAIw8T+cV2n4iWebNfZTFy7PoGSx0dJGljTzWL7XHOnkkFYkt4gvB+jscfR3PI0yKRN6DOT0lCm5jrbqjN0DQJGA
DKIM-Signature: a=rsa-sha256; bh=6bTO0P8SYqPyRhLS6pG8/4DQ1TAxdMB36vk/Z5ldXpc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770707706; v=1;
 b=PGArlS0Om2ZKX281lTsxVLuibnD75H9bor/Lh1iifXTlgIvag7wzqRwmdxoj0QrJQelejebk
 TDyKZsjUc6Vhh9BQh7h/OS239tlsMg2f2spuiM7mHbOA32DXJG03TJcTxyDWQE+eVKxu81s1SGg
 4VpZgHdhnhu/KKL9X7M2YeKxkmSFpKmJ9KRQcAqc0Byf7bJ8hs65uin6G8fawEe9hyGFFPo0DHx
 K5/oDEWvZKu+mlLVXyrEUUKYr4P/ehl3rUzONwU7yX0gliPZD9P0gQUoVAlLtRkZ6pS9bbUqgwo
 b/7g1H4Nq57z8JZevdHIObbSxk9gmbNbHNYmh+xlGTE9w==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=clg@kaod.org;
 helo=3.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/10/26 06:10, Jamin Lin wrote:
> Add a new AST2700 A2 EVB machine to model the newer A2 silicon.
> 
> The ast2700a2-evb machine is largely identical to ast2700a1-evb.
> The only difference is the default DRAM size, which is increased
> to 2 GB.
> 
> This change adds a dedicated ast2700a2-evb machine by copying the
> existing ast2700a1-evb configuration and updating the DRAM size
> accordingly.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0_evb.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
> index 31f7d61117..32d944848e 100644
> --- a/hw/arm/aspeed_ast27x0_evb.c
> +++ b/hw/arm/aspeed_ast27x0_evb.c
> @@ -50,12 +50,39 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
>       aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
> +static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,
> +                                                    const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc = "Aspeed AST2700 A2 EVB (Cortex-A35)";
> +    amc->soc_name  = "ast2700-a2";
> +    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
> +    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
> +    amc->fmc_model = "w25q01jvq";
> +    amc->spi_model = "w25q512jv";
> +    amc->num_cs    = 2;
> +    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
> +    amc->uart_default = ASPEED_DEV_UART12;
> +    amc->i2c_init  = ast2700_evb_i2c_init;
> +    amc->vbootrom = true;
> +    mc->default_ram_size = 2 * GiB;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}
> +
>   static const TypeInfo aspeed_ast27x0_evb_types[] = {
>       {
>           .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_ast2700a1_evb_class_init,
>           .interfaces    = aarch64_machine_interfaces,
> +    },
> +    {
> +        .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_ast2700a2_evb_class_init,
> +        .interfaces    = aarch64_machine_interfaces,
>       }
>   };
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



