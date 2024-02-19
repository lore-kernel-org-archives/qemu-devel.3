Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCBCC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6fH-00018C-6Z; Mon, 19 Feb 2024 11:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc6fF-00017T-H9
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:38:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc6fC-0002qi-QC
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:38:44 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdp670819z6K60P;
 Tue, 20 Feb 2024 00:34:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id EA95C140F2F;
 Tue, 20 Feb 2024 00:38:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 16:38:35 +0000
Date: Mon, 19 Feb 2024 16:38:34 +0000
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v4 1/3] hw/cxl/cxl-mailbox-utils: Add support for
 feature commands (8.2.9.6)
Message-ID: <20240219163834.00005d6e@Huawei.com>
In-Reply-To: <20240219150025.1531-2-shiju.jose@huawei.com>
References: <20240219150025.1531-1-shiju.jose@huawei.com>
 <20240219150025.1531-2-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Feb 2024 23:00:23 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get Feature and
> optionally modified using Set Feature.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Hi Shiju,

Sorry I've taken so long to get to this!

Looks good. One small comment inline.

Jonathan

> +
> +/* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
> +static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint32_t count;
> +        uint16_t start_index;
> +        uint16_t reserved;
> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in = (void *)payload_in;
> +
> +    struct {
> +        CXLSupportedFeatureHeader hdr;
> +        CXLSupportedFeatureEntry feat_entries[];
> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
> +    uint16_t index;
> +    uint16_t entry, req_entries;
> +    uint16_t feat_entries = 0;
> +
> +    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> +        get_feats_in->start_index > CXL_FEATURE_MAX) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    req_entries = (get_feats_in->count -
> +                   sizeof(CXLSupportedFeatureHeader)) /
> +                   sizeof(CXLSupportedFeatureEntry);

I'm struggling a bit with the Specification text.
I says that count is
"Count in bytes of the supported Feature data to return in the
output payload."

I suppose that includes the header but it's not entirely clear
to me. Let's go with what we have here unless we get a spec
clarification.

> +    req_entries = MIN(req_entries, CXL_FEATURE_MAX);
> +    index = get_feats_in->start_index;
> +
> +    entry = 0;
> +    while (entry < req_entries) {

Given it's a known set of bounds a for loops should be
easier to read.

       for (index = get_feats_in->start_index;
	    index < req_entries;
	    index++) {
           switch (index) {
	   default:
		__builtin_unreachable();
           }
       }  
> +        switch (index) {
> +        default:
> +            break;
> +        }
> +        index++;
> +        entry++;
> +    }
> +
> +    get_feats_out->hdr.nsuppfeats_dev = CXL_FEATURE_MAX;
> +    get_feats_out->hdr.entries = feat_entries;
> +    *len_out = sizeof(CXLSupportedFeatureHeader) +
> +                      feat_entries * sizeof(CXLSupportedFeatureEntry);
> +
> +    return CXL_MBOX_SUCCESS;
> +}


