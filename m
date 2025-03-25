Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BDBC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 18:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx9J5-0002kD-6a; Tue, 25 Mar 2025 14:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tx9If-0002fT-FP
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tx9IX-0002Ih-L6
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742928406;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hKa7QnrXX6+uetxxUeYkejthJ5t555o/0s469UnOHVg=;
 b=Yv1r0u2HgTU1xWgOhurEK70CR5OHyPuraaQyrnx1/EoQhW8UXgDMUamv0CNcpKw2UGAEnB
 ocW8c4asFodbaenwhDpsejNPU8iKK9LJDx9wYWa5y9MFdjISpSMPgNahDOXcFYMNvb8FQV
 xY19/o9REH+7nz8gUCAZ1HushNyOeWI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-4C4bLYNMPJ-qjfR7jXaPDA-1; Tue,
 25 Mar 2025 14:46:43 -0400
X-MC-Unique: 4C4bLYNMPJ-qjfR7jXaPDA-1
X-Mimecast-MFC-AGG-ID: 4C4bLYNMPJ-qjfR7jXaPDA_1742928402
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9574180AF50; Tue, 25 Mar 2025 18:46:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD9DD1801756; Tue, 25 Mar 2025 18:46:36 +0000 (UTC)
Date: Tue, 25 Mar 2025 18:46:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v7 52/52] docs: Add TDX documentation
Message-ID: <Z-L6CSajU284qAJ4@redhat.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-53-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124132048.3229049-53-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Jan 24, 2025 at 08:20:48AM -0500, Xiaoyao Li wrote:
> Add docs/system/i386/tdx.rst for TDX support, and add tdx in
> confidential-guest-support.rst
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---

> ---
>  docs/system/confidential-guest-support.rst |   1 +
>  docs/system/i386/tdx.rst                   | 156 +++++++++++++++++++++
>  docs/system/target-i386.rst                |   1 +
>  3 files changed, 158 insertions(+)
>  create mode 100644 docs/system/i386/tdx.rst


> +Launching a TD (TDX VM)
> +-----------------------
> +
> +To launch a TD, the necessary command line options are tdx-guest object and
> +split kernel-irqchip, as below:
> +
> +.. parsed-literal::
> +
> +    |qemu_system_x86| \\
> +        -object tdx-guest,id=tdx0 \\
> +        -machine ...,kernel-irqchip=split,confidential-guest-support=tdx0 \\
> +        -bios OVMF.fd \\
> +
> +Restrictions
> +------------
> +
> + - kernel-irqchip must be split;

Is there a reason why we don't make QEMU set kernel-irqchip=split
automatically when tdx-guest is enabled ?

It feels silly to default to a configuration that is known to be
broken with TDX. I thought about making libvirt automatically
set kernel-irqchip=split, or even above that making virt-install
automatically set it. Addressing it in QEMU would seem the most
appropriate place though.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


