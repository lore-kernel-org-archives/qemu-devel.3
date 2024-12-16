Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF184E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 10:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7yj-0004Er-1H; Mon, 16 Dec 2024 05:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tN7yT-000424-7B
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:05:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tN7yQ-0007bU-Vw
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:05:12 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBbBK3Mxgz6LDCw;
 Mon, 16 Dec 2024 18:03:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 333CE140D1A;
 Mon, 16 Dec 2024 18:04:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 11:04:54 +0100
Date: Mon, 16 Dec 2024 10:04:52 +0000
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH 23/71] hw/cxl: Constify all Property
Message-ID: <20241216100452.0000328f@huawei.com>
In-Reply-To: <20241213190750.2513964-28-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-28-richard.henderson@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.168, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 13 Dec 2024 13:06:57 -0600
Richard Henderson <richard.henderson@linaro.org> wrote:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/cxl/switch-mailbox-cci.c | 2 +-
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
> index 4f419443ab..3fde0f8aae 100644
> --- a/hw/cxl/switch-mailbox-cci.c
> +++ b/hw/cxl/switch-mailbox-cci.c
> @@ -65,7 +65,7 @@ static void cswmbcci_exit(PCIDevice *pci_dev)
>      /* Nothing to do here yet */
>  }
>  
> -static Property cxl_switch_cci_props[] = {
> +static const Property cxl_switch_cci_props[] = {
>      DEFINE_PROP_LINK("target", CSWMBCCIDev,
>                       target, TYPE_CXL_USP, PCIDevice *),
>      DEFINE_PROP_END_OF_LIST(),


