Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A554C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7u2z-0003Mn-7A; Thu, 24 Apr 2025 06:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7u2w-0003MJ-VH
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:43:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7u2s-0008W5-Oc
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:43:09 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjsvt6jVNz6L56y;
 Thu, 24 Apr 2025 18:41:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1A42B1402EF;
 Thu, 24 Apr 2025 18:43:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:43:00 +0200
Date: Thu, 24 Apr 2025 11:42:59 +0100
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 3/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <20250424114259.000000a0@huawei.com>
In-Reply-To: <20250317164204.2299371-4-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-4-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 17 Mar 2025 16:31:30 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> Add dsmas_flags field to DC Region struct in preparation for next
> command, which returns the dsmas flags in the response.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 2 ++
>  include/hw/cxl/cxl_device.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 731497ebda..452a0c101a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -237,6 +237,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>                                            ct3d->dc.regions[i].len,
>                                            false, true, region_base);
>              ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> +            CDATDsmas *dsmas = (CDATDsmas *) table[cur_ent + CT3_CDAT_DSMAS];
> +            ct3d->dc.regions[i].dsmas_flags = dsmas->flags;

This is relying to much on the ordering of creating fields in
ct3_build_cdat_entries_for_mr().

I'd rather you just stored the information flags is built from in CXLDCRegion
and then built the field that is wonderfully called 'Note' in the DC region
configuration in 6.2 spec.   I've sent a mail to see if we can clean that
'what is the field called' question for future spec releases.

Whilst the flag definitions cross refer the CDAT spec, the actual locations
of those flags matches, but doesn't cross refer so maybe in the future
we will have other flags in here and locations might not match.

>  
>              cur_ent += CT3_CDAT_NUM_ENTRIES;
>              region_base += ct3d->dc.regions[i].len;
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index bebed04085..81b826f570 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -609,6 +609,7 @@ typedef struct CXLDCRegion {
>      uint8_t flags;
>      unsigned long *blk_bitmap;
>      uint64_t supported_blk_size_bitmask;
> +    uint8_t dsmas_flags;
>  } CXLDCRegion;
>  
>  typedef struct CXLSetFeatureInfo {


