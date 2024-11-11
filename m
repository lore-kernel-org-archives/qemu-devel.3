Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02BED3ABCF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 22:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAd2V-00047f-5t; Mon, 11 Nov 2024 17:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1tAd2T-00047R-Am
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:37:41 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1tAd2R-0007YK-Ur
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:37:41 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e29047bec8fso4660710276.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 14:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731364658; x=1731969458; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rIo50m0in8Z4wlkZ0261BWOCfXUT7KLdlhX4Ym2Pe1k=;
 b=cY3w5UGZDF7xbMdOugAuKxzggVdHfi4twcsJb3Q6+JMPhXp/RdG7ljthGUqfSt43yB
 JFrc5a7Rei/LdzgIPmdBlHmjtEDH0Y0U2WCGvdVnCQSm+A0bEgIWyJI7PjR6KCyMRwbD
 Dana88mUhMOI2lPlSlepoqqFRvYl7n8v2xguvvhEAzm+vGdSLcyZY8IFLx4NEeT/j9rB
 fpAB7feNxR5erNIBKClxtNxmmvVlpyFykyJHI2waRi/Y9shO0ryPhoMC+eKEsyiOjPm9
 qjWfdzwxoRtKVNG7g3dqgGJONVCrybMkIzwFEtGA9UU2mGAy7zFvdjLgJDl/3VAcIuDB
 2tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731364658; x=1731969458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIo50m0in8Z4wlkZ0261BWOCfXUT7KLdlhX4Ym2Pe1k=;
 b=JsangvHAvkoUlN2W/Nq5PpUzZVaB67f7W6KG+QM+BSNEywyBfAp1byofnZVUCwFa3H
 2iOXOIg8sLJ9qTEBDlfugINe/7+u7ibIziyscZpQTxATfZHvyV54IOCmCBXFah+1TepX
 RSlRn0+Tst25wxGuDd8Uw/xqfn770pjGi/hykmfuoQyqm3BLwkNBu0+RnACb/2hyr/XV
 umxPlWFnGxnLYMIrBblutST0eZg4liTSvU/KwC60BvtsEA0iDNffRHFytCkDk/V0nYLJ
 g4RhJ9y66CbBRB/7C+4vsYyvyu3OEeUaN/3mu70uzsSwawMK5Ekk0aF7LX0gPpRbOUvy
 2aqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNpKCxtF8uccRctZFucrbYkZeK+i8vAUED4NUdwo6mroUwHSKyZ0gwb5tawHoaxU+8NNXU+TJtoR8j@nongnu.org
X-Gm-Message-State: AOJu0YwyiRByO1Q8fRzInGD8RtKN7pSvAftqhSV8bgCm9MuKUktnbKS9
 FuVg+54xj/nkJJkdWuvzePZWMWi39oh6+ieYCbyoCtZ1Vm1uKAjT
X-Google-Smtp-Source: AGHT+IHUTtEUNPkruAHlebfeluDRcnDJ4V3w2CfmWj/VH5Ik9RanGwO9toGON2FgbbQMdWt8M+M82w==
X-Received: by 2002:a05:690c:fcf:b0:6e2:451c:df02 with SMTP id
 00721157ae682-6eade50eb4amr114154657b3.16.1731364658581; 
 Mon, 11 Nov 2024 14:37:38 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6eaceb65b76sm22250647b3.71.2024.11.11.14.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 14:37:38 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 11 Nov 2024 14:37:35 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, shiju.jose@huwei.com,
 qemu-devel@nongnu.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu] hw/cxl: Check for zero length features in
 cmd_features_set_feature()
Message-ID: <ZzKHL9msnqMSv8WE@fan>
References: <20241108175814.1248278-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108175814.1248278-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Nov 08, 2024 at 05:58:14PM +0000, Jonathan Cameron wrote:
> Zero length data for features doesn't make any sense so exclude that case
> early. This fixes the undefined behavior reported by coverity for a zero
> length memcpy().
> 
> Resolves CID 1564900 and 1564901
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 2d4d62c454..ce9aa18364 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1288,6 +1288,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>      set_feat_info->data_offset = hdr->offset;
>      bytes_to_copy = len_in - sizeof(CXLSetFeatureInHeader);
>  
> +    if (bytes_to_copy == 0) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
>          if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION) {
>              return CXL_MBOX_UNSUPPORTED;

-- 
Fan Ni

