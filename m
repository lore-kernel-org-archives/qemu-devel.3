Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAE3EF8FE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxm06-000086-RS; Wed, 04 Mar 2026 08:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxm00-0008WN-1n
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxlzy-0006QM-Lm
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772629845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/taBkgk4GyRt9Jiije89BDJCQLgnvJQ3OI3xa7yYyU=;
 b=Lqzy1GUacS62gb7wLvp7N4QXO/ismnNgSP81kfnRtzDnt+QKDZ8Y+Mx1Azh6265GDcxZo1
 EJmq6uGnLAsXK1SSJIiqt49GSyqbXEgbXuGT3tx/L57ooKB0+bLbPrPecYAXwHZ5q8gCcZ
 rGpKV9k882Sp7zPfJZy4zIPHtJw7SPg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-c97QbCfAPjyiHS-0UkFFGA-1; Wed, 04 Mar 2026 08:10:44 -0500
X-MC-Unique: c97QbCfAPjyiHS-0UkFFGA-1
X-Mimecast-MFC-AGG-ID: c97QbCfAPjyiHS-0UkFFGA_1772629843
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439c5cce2deso1115939f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772629843; x=1773234643; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9/taBkgk4GyRt9Jiije89BDJCQLgnvJQ3OI3xa7yYyU=;
 b=oWYTTaHx652+ZavROEo4qSzi+ni0riXAfHe1lW+sM7MlS7sSX0O/FelJxYYlUisaHX
 9Loy7Z/X6jjany76mKc0b6qz6d5hnyeAJLhv9N4WID/qYhnYCSAWsY1ABhLvbQi1wt1L
 W8FiqqDKlvqNNTmVwcvoq2Y08/j+MrZzHKsIbTiFP7tHg7aSOkSGWJImBxlXbxE6OLNX
 NuKKup6dP2oXXXymlgAaI8FAyx/V34D2PMyqbDGK/UFWnWKhLEJnfQTL+swthDfKYDZO
 sGQ1J1WbJmCBsuEgeVwYGUvk79dERRg5EhxC0Tk2Ng3cA5AylUmwLRYKrYN1eTe8Wg8p
 zXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772629843; x=1773234643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/taBkgk4GyRt9Jiije89BDJCQLgnvJQ3OI3xa7yYyU=;
 b=naweOx2/93xplxtUzijUgbAB0NW9616duQ9Uc3Bk2XphajZxFIESWRxdrc+VqkZ3gK
 d4Vk7ln5RHkaCy9n7wpNX+Q4bWKgzGxyNXEU7+d2qElWs0JhIIHYpASEIHpT/80gnlwW
 ENrSwUq3VZMg3cQUfVCKrdA/4QVprbpsjn0VolGHyTnWeXkS+ZkIX0m6LgTBM4Rf24HY
 8hLoPLEoTIxd4XZe/hJWzrULQFJgkmVIwVLDLUAhipJJOZx4OTDyxn5L4eIMlSwr8NAr
 rcYDlzT35EEwwEX8JKDly306tCJENCCJ7q+shldOhS9NHDj7GbmVbBxq6f3j2sKXfXY2
 yPOA==
X-Gm-Message-State: AOJu0YyXfoL9IHPCOjTvOC10/YfeITj3Qyc53deQ/wsrF3QjnTi0uCY6
 vgsG8NACurWTLXZngUEzZLeA+1PXRULivzvGcRIj8mUvQ6ihgsUsa5+d65wA66tGnL0J89T67la
 Tw3dAwQHVSAROSP/oE4ahCn6R3sq8u1XmRZFAUI3w3cOud7vtw2FuTv1V
X-Gm-Gg: ATEYQzxbmSv00Ljr+vOwhgaNLSwhYIlE4JpTxnBo5sUe7V+gOv22kPtv0VyvxvATF1X
 zH18GM4lO8B4En3mru+ACAm1aEMOIaqic9zcoMWV68FO7t7MlTi0lqJaL+TTd8iHJh/0IsPd+LX
 00I2EpOTbM2gE++XqIUYtQyVKpErqYkm+ScA79KcJgniYuqKWmhjXT+9u2JtIRWwk9VLOs5rS7E
 3jjX64sOAwpCeKRiYRFPc5Fe6VXuPH4wQMQ7BpAe9vIeP/XZNhFhqgBrutyMDYNyShzstPrP6rD
 EmFLOs6DhQP9p2yIxRWPn0/kdAdZPKp1cRVaV6JQqcWQam7gEo3RbWunAXBtKMIpVN+H/G0Ax9l
 +D7kGLVYBIjsMCX0mE7/F0+Aeqw48zZ4S4mTBPatNnsEbAeKQjj1vgmy/uM7Yz1627cFhe2s=
X-Received: by 2002:a05:6000:26c9:b0:439:b9bd:51f with SMTP id
 ffacd0b85a97d-439c7fc490emr3872235f8f.25.1772629843239; 
 Wed, 04 Mar 2026 05:10:43 -0800 (PST)
X-Received: by 2002:a05:6000:26c9:b0:439:b9bd:51f with SMTP id
 ffacd0b85a97d-439c7fc490emr3872171f8f.25.1772629842727; 
 Wed, 04 Mar 2026 05:10:42 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it.
 [82.53.134.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439bb686a32sm17569561f8f.13.2026.03.04.05.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:10:42 -0800 (PST)
Date: Wed, 4 Mar 2026 14:10:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org, jasowang@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, 
 slp@redhat.com, hi@alyssa.is, stevensd@chromium.org
Subject: Re: [PATCH v13 2/7] vhost_user.rst: Align VhostUserMsg excerpt members
Message-ID: <aagvRbFeb5mLpCfE@sgarzare-redhat>
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-3-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260219130334.787858-3-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 19, 2026 at 02:03:29PM +0100, Albert Esteve wrote:
>Add missing members to the VhostUserMsg excerpt in
>the vhost-user spec documentation.
>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> docs/interop/vhost-user.rst | 4 ++++
> 1 file changed, 4 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>index 93a9c8df2b..17a68a62eb 100644
>--- a/docs/interop/vhost-user.rst
>+++ b/docs/interop/vhost-user.rst
>@@ -366,11 +366,15 @@ In QEMU the vhost-user message is implemented with the following struct:
>           struct vhost_vring_state state;
>           struct vhost_vring_addr addr;
>           VhostUserMemory memory;
>+          VhostUserMemRegMsg mem_reg;
>           VhostUserLog log;
>           struct vhost_iotlb_msg iotlb;
>           VhostUserConfig config;
>+          VhostUserCryptoSession session;
>           VhostUserVringArea area;
>           VhostUserInflight inflight;
>+          VhostUserShared object;
>+          VhostUserTransferDeviceState transfer_state;
>       };
>   } QEMU_PACKED VhostUserMsg;
>
>-- 
>2.52.0
>


