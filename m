Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AA0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBio-0006JE-PF; Fri, 12 Apr 2024 03:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rvBil-0006Dx-AL
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rvBij-0002J8-6N
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712908391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lFSOZh3K0g68XIpp4i2jC3/kkxxLC4ls39D6hyUFkLk=;
 b=MRPHWrd45USMyhGZ3bEFeXsddk7kC96YXrvctDhdUzV0Asj2PVlqdSdd1gzrXsKOnbiSU/
 6rM7kQ0v0l1leRJsoTFaNBWcw3NyPIbgOvNgGp0k/v4xFpBedd6dL65AV7PIG6oFlRcNVk
 6s9fR/aWr/kLcOck9DtTpz5jfIGGu+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-CG8nu0xBPDKFgXPP3JqMjQ-1; Fri, 12 Apr 2024 03:53:09 -0400
X-MC-Unique: CG8nu0xBPDKFgXPP3JqMjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50C8C10499A0;
 Fri, 12 Apr 2024 07:53:09 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC5A92026D06;
 Fri, 12 Apr 2024 07:53:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: JianChunfu <chunfu.jian@shingroup.cn>, mst@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, JianChunfu <chunfu.jian@shingroup.cn>
Subject: Re: [PATCH] linux-headers: change the annotation of
 VFIO_IOMMU_SPAPR_REGISTER_MEMORY in vfio.h
In-Reply-To: <20240411113404.1274855-1-chunfu.jian@shingroup.cn>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240411113404.1274855-1-chunfu.jian@shingroup.cn>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 12 Apr 2024 09:53:07 +0200
Message-ID: <877ch3hva4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 11 2024, JianChunfu <chunfu.jian@shingroup.cn> wrote:

> The ioctl(VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA) won't be called
> in SPAPR machine, which is replaced by VFIO_IOMMU_SPAPR_TCE_CREATE/
> VFIO_IOMMU_SPAPR_TCE_REMOVE, so change the description.
>
> Signed-off-by: JianChunfu <chunfu.jian@shingroup.cn>
> ---
>  linux-headers/linux/vfio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Instead of editing things under linux-headers directly, the kernel
source file needs to be changed instead so that a headers sync will
update the file here. [No opinion on the actual change.]


