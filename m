Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D926FCD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 22:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRdxC-0001D5-73; Mon, 25 May 2026 18:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRdxA-0001CY-MR
 for qemu-devel@nongnu.org; Mon, 25 May 2026 18:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRdx7-0000R7-0K
 for qemu-devel@nongnu.org; Mon, 25 May 2026 18:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779748756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=82ObKUiFZmoZpz9qpW2c3fGc/c2CPMzq0cMUXtqE5dg=;
 b=Rzl2szW4hwkMK5GxBK+ElLOekYfKGiX+Y+6YtrncnKdPEIIZjIN38wjntxT0kBXniweSod
 xAI4ifpdJ0nZj6xBS+rwbuG1JUiAr/3T8UbfYJO4/REifJaYuEc5weIwsxSebabb7lc9WC
 hxqot8WZBRQsJnIupC9nLIJ78WzNoVU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-yrKN7M1wNXuw2RqP7IP3cA-1; Mon, 25 May 2026 18:39:14 -0400
X-MC-Unique: yrKN7M1wNXuw2RqP7IP3cA-1
X-Mimecast-MFC-AGG-ID: yrKN7M1wNXuw2RqP7IP3cA_1779748753
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45dbbbf8d57so11738367f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779748753; x=1780353553; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=82ObKUiFZmoZpz9qpW2c3fGc/c2CPMzq0cMUXtqE5dg=;
 b=hAa1zW1KUrBTmtVI3IRmBCIyh0uR+2ulDvesJzamWHawBdOCQSe8pCrl9LgTRQQ+Iw
 rA6Wranv5G2CJ03hVl+kAnLCaL14nHm6i2ARCejQ6LF3GKPmJE6cdo2ZgH5ls2oNDa8g
 VYoiWMjGSWjeVDdXZIWyeIC+oXuJ7moewrtSZV8OzG0aj1PSqe4IIG73+hPUQhXwOKNk
 /mRoiT3tfp6jkUDwCRbEIf+MSdRfxEdkTkUdodmjjQt1M+I6lUHNAvmDP9MkQ6mVGUgM
 ho5sRz00v/CnjuPgDskelU7Iz+icxn5ySqTBde5GjWxDrT6ICilTTyOkWzjjA0WFLuOx
 mcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779748753; x=1780353553;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82ObKUiFZmoZpz9qpW2c3fGc/c2CPMzq0cMUXtqE5dg=;
 b=eQLGidoq9YidV8tMmZrU8R58M2cPJz8+ltsKnVOaCUJFk4c5TLqUj6ObHnw0JZgc0S
 CKTtUD+vYbH39FNST9rbJY6PmUt+9pxmKM1x5oiC4SJyTKLV8t2vc2kkFQv9Wt8AtX/V
 0IhdMpIi/i59AywQcTA5+l2vR30C+P2uLV66Xzhx5HRefdcLPTLzcvmKwB4SDBfuUgdu
 jyCdmKf9oVmsjvUpY1cpuq7klAsGwU1mwOHWcHT9nIK04pPyS4/5RLLkdGwF5Z8tOjl8
 LRYD+75Tb859Y4A5f7M+u9z1ylEDwF+ISIRkLsikhTOZeVkyK11Xuxwd/UfevIi/DNCJ
 jixA==
X-Gm-Message-State: AOJu0YxZEgCF00t7NyPeyc5Bl3VLScDQn3O2IpjS/UkHjn/s9BqNyk3x
 iXjVz/8L+A+r0r72Nz5I8vt0Rl23BZD3EzAlQfjUaK5Bdq5kWcyBj6IUKTrF9RoHG2OOya7STiD
 22Hyj1b7IcYUCu06NQHVUk80SsOiQURy3THhbratFVX4n2rN9mVMZ8AvmZTG+kLSz
X-Gm-Gg: Acq92OH19abiMLB+0lK0FgvghNYtjyRzaBchOfd0u6riz1o2OnTSsrCDvDE1Cv4MWl3
 1q0OdslN9kKEZeIMAoVTNlm9uLRn8PbXvdWxtxBNHdi6uwePqZS6C6SqIDqaYF35Tx7Sozpi4m4
 ZeqWDEa/Eved0LmtrKkcgfYYlnYL9SxInSfaABuqTL5Irtq3lHzaoTdYp36h0JeqKqotIMFmaq2
 NV60IY1E8gpGYR3IpSPCJ6Wkwf9zm0Zvz42FTs7DazdW/Hk1BmomXYwiYC2VzKwFQ9eqZiGmADs
 MfzrcjAld365Pm/GapI1EvqyqDmCy0dPn/P6Pz6BusBQb800JJIprJ0Rk55ca7cwfZ/1dO27juA
 gTDFQsUk5U2BPdLyXpSYEPUoqIzSZQV7lAxcVyfw57xs2mM6oNoWw
X-Received: by 2002:a5d:6f0f:0:b0:453:f951:4e5b with SMTP id
 ffacd0b85a97d-45eb369c88dmr31885764f8f.13.1779748753100; 
 Mon, 25 May 2026 15:39:13 -0700 (PDT)
X-Received: by 2002:a5d:6f0f:0:b0:453:f951:4e5b with SMTP id
 ffacd0b85a97d-45eb369c88dmr31885721f8f.13.1779748752567; 
 Mon, 25 May 2026 15:39:12 -0700 (PDT)
Received: from redhat.com (bzq-79-177-147-143.red.bezeqint.net.
 [79.177.147.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5e363sm31135234f8f.28.2026.05.25.15.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:39:11 -0700 (PDT)
Date: Mon, 25 May 2026 18:39:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Quan.Sun@windriver.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net,
 sgarzare@redhat.com
Subject: Re: [PATCH] hw/scsi/vhost-scsi: fix build with older kernel headers
Message-ID: <20260525183656-mutt-send-email-mst@kernel.org>
References: <20260525182730.4098543-1-Quan.Sun@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525182730.4098543-1-Quan.Sun@windriver.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 25, 2026 at 11:27:30AM -0700, Quan.Sun@windriver.com wrote:
> From: Quan Sun <Quan.Sun@windriver.com>
> 
> On build hosts with kernel headers older than 6.0, the system's
> <linux/vhost_types.h> does not define struct vhost_vring_worker or
> struct vhost_worker_state, causing compilation of vhost-scsi.c to
> fail:
> 
>   error: storage size of 'vq_worker' isn't known
> 
> Fix by including standard-headers/linux/vhost_types.h before the
> system's <linux/vhost.h>, matching the existing pattern used in
> hw/virtio/vhost-backend.c. QEMU's bundled header provides the
> struct definitions, and its include guard prevents redefinition
> when the system header pulls in its own vhost_types.h.
> 
> Signed-off-by: Quan Sun <Quan.Sun@windriver.com>


Hmm. maybe replace linux/vhost.h with standard-headers/linux/vhost.h then?


> ---
>  hw/scsi/vhost-scsi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 699863cc10..10e8fbe503 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "standard-headers/linux/vhost_types.h"
>  #include <linux/vhost.h>
>  #include <sys/ioctl.h>
>  #include "qapi/error.h"
> -- 
> 2.43.0


