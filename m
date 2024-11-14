Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AFAD65C6C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXkC-0007Mz-KN; Thu, 14 Nov 2024 06:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tBXkA-0007M8-JC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tBXk8-0001tD-BR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731582629;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KGwAQepdKT1uv2IiJcFoOnIjB/3YgWbiaRdBdojWPP4=;
 b=XJi2D9O70UZDHHDAX7RHP0skxXiUudvI8HyDjAQbyGb8BCEal1cDWN/KZjUeWwtemkKoin
 TmmYzMnD0lSRp0Wx0ZaTJ/FAsF5aScc6eAv6qeW1iHZthAoenLDmULUsi4/foHViItoIWf
 Tp0GkD7RHD9YRlGxLaqKtaWU5A+I/0c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-J-cdOZMaNiq4S7zmDG32vw-1; Thu,
 14 Nov 2024 06:10:26 -0500
X-MC-Unique: J-cdOZMaNiq4S7zmDG32vw-1
X-Mimecast-MFC-AGG-ID: J-cdOZMaNiq4S7zmDG32vw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C105195419D; Thu, 14 Nov 2024 11:10:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.209])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE7111956054; Thu, 14 Nov 2024 11:10:16 +0000 (UTC)
Date: Thu, 14 Nov 2024 11:10:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PULL 0/5] Firmware 20241114 patches
Message-ID: <ZzXak8gl-IksvLkQ@redhat.com>
References: <20241114110101.44322-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114110101.44322-1-kraxel@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 14, 2024 at 12:00:56PM +0100, Gerd Hoffmann wrote:
> The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d022432:
> 
>   Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/kraxel/qemu.git tags/firmware-20241114-pull-request
> 
> for you to fetch changes up to 5916a3b20fdbfbfc2f987f1121e945100c8c3cd2:
> 
>   x86/loader: add -shim option (2024-11-14 11:55:39 +0100)
> 
> ----------------------------------------------------------------
> loader: fix efi binary loading via -kernel
> loader: support secure boot verification with direct kernel boot

Hard feature freeze was two days ago, so I would have thought
the new secure boot feature should wait until 10.0 cycle ?

Their commits say they depend on new OVMF features and we've
not updated the OVMF binaries in this cycle, so do we even
have the OVMF feature needed for this to work[1] ?

With regards,
Daniel

[1] admittedly not an issue for distros packaging ovmf separately
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


