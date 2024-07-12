Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D429C3DA50
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSG9u-0005MV-JH; Fri, 12 Jul 2024 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sSG9l-0004nY-Jd
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:17:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sSG9g-0001wy-Hb
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:17:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WLBtc2zChz67ClN;
 Fri, 12 Jul 2024 21:16:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 89A59140C72;
 Fri, 12 Jul 2024 21:17:40 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Jul
 2024 14:17:38 +0100
Date: Fri, 12 Jul 2024 14:17:36 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
 <linuxarm@huawei.com>
CC: <shiju.jose@huawei.com>, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v6 4/4] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS
 control feature
Message-ID: <20240712141723.000067d8@huawei.com>
In-Reply-To: <20240705123039.963781-5-Jonathan.Cameron@huawei.com>
References: <20240705123039.963781-1-Jonathan.Cameron@huawei.com>
 <20240705123039.963781-5-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 5 Jul 2024 13:30:38 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
> control feature.

Hi Michael / all,

Silly stray white space issue inline that checkpatch will catch.

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index dda35f2528..222db7032d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -829,6 +829,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      uint8_t *pci_conf = pci_dev->config;
>      unsigned short msix_num = 6;
>      int i, rc;
> +    uint16_t count;
>  
>      QTAILQ_INIT(&ct3d->error_list);
>  
> @@ -901,6 +902,19 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>                             CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
>                             (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
>      ct3d->patrol_scrub_attrs.scrub_flags = CXL_MEMDEV_PS_ENABLE_DEFAULT;
> +    

Sorry - stray whitespace here.  I'll not send a new version for just this though.


> +    /* Set default value for DDR5 ECS read attributes */
> +    for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
> +        ct3d->ecs_attrs[count].ecs_log_cap =
> +                            CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
> +        ct3d->ecs_attrs[count].ecs_cap =
> +                            CXL_ECS_REALTIME_REPORT_CAP_DEFAULT;
> +        ct3d->ecs_attrs[count].ecs_config =
> +                            CXL_ECS_THRESHOLD_COUNT_DEFAULT |
> +                            (CXL_ECS_MODE_DEFAULT << 3);
> +        /* Reserved */
> +        ct3d->ecs_attrs[count].ecs_flags = 0;
> +    }
>  
>      return;
>  


