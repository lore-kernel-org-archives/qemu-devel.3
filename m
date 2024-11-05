Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE8ED3E762
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8QeM-0006sL-2G; Tue, 05 Nov 2024 15:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8QeK-0006mL-3D
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 15:59:40 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8QeI-0004qy-Me
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 15:59:39 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e291cbbf05bso5810045276.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 12:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730840377; x=1731445177; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nP21VhhtAN4bMtCwZaYVPKl9ELon3gECWfWvivPbdhc=;
 b=QWsgKXdWRBGs274RUBIHKiy8IX0XJFpWaqSFLxIQFMnEC2sQk6N83iFwDTlHrW2cIV
 0PBIJM0FHOtZdPASUokFKEnaTXfp0RF76oxeG0i5j0hux3Pp0e3nD5gvrlW5WHjP6VUk
 ccVA8v8wSEZxxBu2g8p/xzaOsprp8PHWU8SVNr3wAKuGsmNmV2ljWfi9oQC5yx2a4HPq
 jrXGqQlamhR+IoaTW6b/rGRUvgvofQQF+dhYegWvNahqCpYvLxSe7DC4JIR3gg4q0ECW
 b6fJTcDP+OMJ7yimS04plciSWPtyYuDLG5jOB4gj65zN2Jj7fiy64ci0QgjQOUcYG0+/
 NF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730840377; x=1731445177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nP21VhhtAN4bMtCwZaYVPKl9ELon3gECWfWvivPbdhc=;
 b=uQspyz962UKFd7BhVsusJkENmSQ07Giu7awp9yUDDyLPld++7Wp3YAEiY/kv2lYfd+
 Jptb7YWOqleywMVOfhTYrCLQYh7nifvC0APMOzcU+rtlbVBA6LVcFTieKGWrmKJtf4Ae
 9djfoyWEycGA0dKng/4NjPXKeMJi8Blzejb/R9chjJTqemcdmHZ6B1gVQEHEB/9/q/m0
 U7QOT0PQlUlwtVFwlMjsI+aFZWPN1Xt935m/hHJkBqu1i5KHqqpXuU3BkmJhdAYijOdH
 UO5zAEofwsnU0SU2iUYTU0SPTQc1KsQAP+QXeeZdDQ3/JRFofYvuBPIA/DLIxhO100OR
 UOuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQcTHPCTWGMQoVEmkzDro31u6Z3vhbCzk9gnQLvm2KkGttyWh3dVsZO6iep90bVyAC4wqch5O9n3SX@nongnu.org
X-Gm-Message-State: AOJu0YyvAnlmyqpnbFCTbfz1ieOf+6LcWRJoNZTldfsE52TwszJfQLIb
 sXoo96/mSH1WNDVh2L7stWV5Iv2VfMYG2GV6d6ME5ubhrGB/Sge/
X-Google-Smtp-Source: AGHT+IH6cu6bhcBmJTsqaVBEUTndllLxTwmnlDRoWST3Nr9aoAJUHpBX+kdr0XyR56Ec6zLatQmubw==
X-Received: by 2002:a05:690c:6289:b0:6ea:7afd:d8f2 with SMTP id
 00721157ae682-6ea7afddd75mr128765917b3.15.1730840377364; 
 Tue, 05 Nov 2024 12:59:37 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ea7c26d7dcsm17123617b3.54.2024.11.05.12.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 12:59:36 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 12:59:35 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 02/10] hw/cxl: Check input includes at least the
 header in cmd_features_set_feature()
Message-ID: <ZyqHN42zJeg6inGr@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-3-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2f.google.com
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

On Fri, Nov 01, 2024 at 01:39:09PM +0000, Jonathan Cameron wrote:
> A buggy guest might write an insufficiently large message.
> Check the header is present. Whilst zero data after the header is very
> odd it will just result in failure to copy any data.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 17924410dd..e63140aefe 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1238,6 +1238,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>      CXLType3Dev *ct3d;
>      uint16_t count;
>  
> +    if (len_in < sizeof(*hdr)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
>  
>      if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
>          return CXL_MBOX_UNSUPPORTED;
> -- 
> 2.43.0
> 

-- 
Fan Ni

