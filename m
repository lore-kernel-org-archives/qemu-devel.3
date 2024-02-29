Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEF4C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfbKm-0001FA-2f; Thu, 29 Feb 2024 03:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfbKg-0001Cm-3U
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:59:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfbKe-0002qI-GI
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709193595;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=su0b1f6fP8XHE9SSrGoPIjF18KlfyPtazY+s9+EtBew=;
 b=ZyRnrtPOV8C7osPl3O2ZXKUfrw1pauf8OJq6XbAzGRv94hoF1NOhL43Nn1JYQPGoiULk8w
 JfizrYZfEgFqoialUxst29ZTYRFCQ7NjYZNdJiCBhtsAcUKrimB8jwBOJTHKj7U31ROWic
 8h2UFHhSpbxlC99UtCxZUoXu9NkBQbg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-w9r4TO-zPeS9hiWgY15nOQ-1; Thu, 29 Feb 2024 02:59:51 -0500
X-MC-Unique: w9r4TO-zPeS9hiWgY15nOQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1A1385A58E;
 Thu, 29 Feb 2024 07:59:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CB62492BC6;
 Thu, 29 Feb 2024 07:59:50 +0000 (UTC)
Date: Thu, 29 Feb 2024 07:59:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paz Offer <poffer@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: ISO C90 compilation error
Message-ID: <ZeA5ZbbHLy9mhmsa@redhat.com>
References: <MW4PR12MB6997B8D6225D08E8F3E2DE55A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR12MB6997B8D6225D08E8F3E2DE55A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 29, 2024 at 07:03:35AM +0000, Paz Offer wrote:
> Hi,
> 
> I am trying to build my code with QEMU and getting compilation error according to the ISO C90 standard:
> 
>       const size_t buf_size = 31;
>       char buffer[buf_size + 1];
> 
>       error: ISO C90 forbids array ‘buffer’ whose size can’t be evaluated [-Werror=vla]
> 
> I noticed that the code builds with '-std=gnu11', which is newer then
> C90, so this is not clear to me why I get this error.
> Where is the correct place to specify the language version for this?

QEMU has set compiler flags to explicitly /forbid/ use of variable
sized arrays on the stack, as it is a known dangerous language
feature. You must refactor your changes to avoid this by using either
a statically sized array, or allocating on the heap.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


