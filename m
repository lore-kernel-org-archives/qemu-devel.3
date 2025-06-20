Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8F4C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uScYU-0003Rb-MA; Fri, 20 Jun 2025 10:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uScYH-0003QB-KQ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:17:13 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uScYB-0006v9-BS
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:17:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNzxp5Qt1z6L5cB;
 Fri, 20 Jun 2025 22:14:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 892DC140446;
 Fri, 20 Jun 2025 22:16:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 16:16:57 +0200
Date: Fri, 20 Jun 2025 15:16:55 +0100
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 5/7] hw/cxl/cxl-mailbox-utils: Move declaration of
 scrub and ECS feature attributes in cmd_features_set_feature()
Message-ID: <20250620151655.00001cea@huawei.com>
In-Reply-To: <20250619151619.1695-6-shiju.jose@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
 <20250619151619.1695-6-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

On Thu, 19 Jun 2025 16:16:17 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Move the declaration of scrub and ECS feature attributes in cmd_features_set_feature()
> to the local scope where they are used.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Local scope is fine, but I'm fairly sure that style wise these
files always use variable declarations at start of scope (except
for when g_auto_free is in use where it gets more complex).



> ---
>  hw/cxl/cxl-mailbox-utils.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4d0c0b3edc..83668d7d93 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1459,10 +1459,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                             CXLCCI *cci)
>  {
>      CXLSetFeatureInHeader *hdr = (void *)payload_in;
> -    CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
> -    CXLMemPatrolScrubSetFeature *ps_set_feature;
> -    CXLMemECSWriteAttrs *ecs_write_attrs;
> -    CXLMemECSSetFeature *ecs_set_feature;
>      CXLSetFeatureInfo *set_feat_info;
>      uint16_t bytes_to_copy = 0;
>      uint8_t data_transfer_flag;
> @@ -1508,8 +1504,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        ps_set_feature = (void *)payload_in;
> -        ps_write_attrs = &ps_set_feature->feat_data;
> +        CXLMemPatrolScrubSetFeature *ps_set_feature = (void *)payload_in;
Move the declaration to start of scope.

You can do assignment there as well as I don't think we care if we cast them
to the wrong type as header version isn't what we think it should be.

> +        CXLMemPatrolScrubWriteAttrs *ps_write_attrs =
> +                                &ps_set_feature->feat_data;
>  
>          if ((uint32_t)hdr->offset + bytes_to_copy >
>              sizeof(ct3d->patrol_scrub_wr_attrs)) {
> @@ -1535,8 +1532,8 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        ecs_set_feature = (void *)payload_in;
> -        ecs_write_attrs = ecs_set_feature->feat_data;
> +        CXLMemECSSetFeature *ecs_set_feature = (void *)payload_in;
> +        CXLMemECSWriteAttrs *ecs_write_attrs = ecs_set_feature->feat_data;
>  
>          if ((uint32_t)hdr->offset + bytes_to_copy >
>              sizeof(ct3d->ecs_wr_attrs)) {


