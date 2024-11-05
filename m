Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AD8D3E76A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Qj1-0000l3-NI; Tue, 05 Nov 2024 16:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Qj0-0000kr-4K
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:04:30 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Qiy-0005S0-MU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:04:29 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e2918664a3fso246247276.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 13:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730840667; x=1731445467; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=noY2bbayWon0kk66SxDlIazndIr82AwdxwcFGXTlqdc=;
 b=IMLPsU51rFqYXeJ9Qm2nxhrGd/Veok8Dn72UUrvDeApXQ7eTI+N+7IEZ1n0sRJUkqJ
 YpysatfdK5+ZWe5nZa5M5QixhAj5iwb/ulxzf7HVQQc4IyqIfvj84prtgWCbxacVLlHM
 KskIZG60XkrSBdCZQ8DsCEoiRD1Y8aFoAwOWiTf1MgAyfx2Iklt74lf88/TfAffRyAsa
 EjvbpWKRXybOcRM+pBNYLPZwDx9PBwqXxFVSCXNv+sTJwC1Fz4/eLRSLh9d3uENB5JIy
 p9i4zAn/9xlUBULFyophGkMZNA/t+T1GnOLezohOE3kJB6p6bBFgboeOGDVe5vgorUyZ
 ssBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730840667; x=1731445467;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=noY2bbayWon0kk66SxDlIazndIr82AwdxwcFGXTlqdc=;
 b=xCh3xKE/1+8vmHXef0MGSetTGzJNVlBE5xr7tattQGG+J9oFsoNA5isxtZdLjJN0xO
 /14lw+XpwrgQQFuaK3jwgcKL0qI+IUAFrs13knwcsfLmX/OtHVtBO02EjKv3NGPDzru+
 /0Uvikzdce1PrJPkYPcST/ZfmmdxLRSonLvD7o1A7LsB4IKvMQvTuCNMVPgUJ/w50Us+
 VLgQ32+TMgEOVbjb+e5kU6P+8AjB1kQljEe9RtofAU+g8cFFqTyKWNpnOBLzWYDFmQWJ
 DU1D+hOIjZjo207Tg67HvEQ2Cxcj9ealB5TmsAboQsx9Rqy6oEZ5IQIjmZsoXOHWHs7k
 tnhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpNqgzJ70/XU34BEgmtMjBkY7eG9YsPc2EHkkaYLv4GK1hHL+kBi6cQEq5GMEPOg+/A2+8F7PCiJSn@nongnu.org
X-Gm-Message-State: AOJu0YwWH82AI8UjOyTq7t+8iJ48znKprlCAEYDCXYQ2CaDnqWndNRW7
 skMRa+QuFvm6oe+4LB4Qnn88/o/s/QdYmiP5U+aTKBGlwKN9DsOt
X-Google-Smtp-Source: AGHT+IFbm8n9GmKArvIQ1qteK4fLi0OpvBJrYmhg6D1YhI9wwIBUjaMq6jBRxc4GkqiirzMt5RBKIA==
X-Received: by 2002:a25:5f11:0:b0:e29:7e27:dad5 with SMTP id
 3f1490d57ef6-e335ad7175dmr44845276.23.1730840667499; 
 Tue, 05 Nov 2024 13:04:27 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e30e8adffd8sm2601283276.60.2024.11.05.13.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 13:04:27 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:04:25 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 04/10] hw/cxl: Check enough data in
 cmd_firmware_update_transfer()
Message-ID: <ZyqIWRP_ynMsb34n@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-5-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2e.google.com
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

On Fri, Nov 01, 2024 at 01:39:11PM +0000, Jonathan Cameron wrote:
> Buggy guest can write a message that advertises more data that
> is provided. As QEMU internally duplicates the reported message
> size, this may result in an out of bounds access.
> Add sanity checks on the size to avoid this.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 3cb499a24f..27fadc4fa8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -705,6 +705,10 @@ static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
>      } QEMU_PACKED *fw_transfer = (void *)payload_in;
>      size_t offset, length;
>  
> +    if (len < sizeof(*fw_transfer)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      if (fw_transfer->action == CXL_FW_XFER_ACTION_ABORT) {
>          /*
>           * At this point there aren't any on-going transfers
> -- 
> 2.43.0
> 

-- 
Fan Ni

