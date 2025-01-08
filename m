Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568B2E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXWM-0008Mk-Hq; Wed, 08 Jan 2025 09:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVXWK-0008MU-Mi
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:58:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVXWI-00050n-N0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736348332;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtCnnHyptjn6gzvNmGYFSlO9m5Im8cWKxGyQCFiFilE=;
 b=CJ6E4FJQWo3XMWUuBj2azDjHQxWci7/aKQHORUpiW3xzerYHx5elElQ64rNtdI7+vnw7WI
 QdkusB7hV5hgzYevR9CKzgmLpuoS2maYu3+F5sO000uwPLUAzzM2UkG/Q79RWbrtqhP//O
 IveSQ/axAE7Bh6b6wiupabBgisZcpBY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-ObdOM636PiOmkU6JhhPxAQ-1; Wed,
 08 Jan 2025 09:58:51 -0500
X-MC-Unique: ObdOM636PiOmkU6JhhPxAQ-1
X-Mimecast-MFC-AGG-ID: ObdOM636PiOmkU6JhhPxAQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5D021956054; Wed,  8 Jan 2025 14:58:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.103])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA97D1956054; Wed,  8 Jan 2025 14:58:48 +0000 (UTC)
Date: Wed, 8 Jan 2025 14:58:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Adam <adam@rttst.com>
Cc: qemu-devel@nongnu.org
Subject: Re: 86_64 host is not supported by hypervisor - 2024
Message-ID: <Z36SpfwBeajgIWYZ@redhat.com>
References: <3fd90b0c-ff50-4dc7-921d-bdecb82c7777@rttst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fd90b0c-ff50-4dc7-921d-bdecb82c7777@rttst.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Jan 08, 2025 at 08:51:52AM -0600, Adam wrote:
> TWIMC:
> 
> Had an issue with VM networking that turned out to be the host. In the
> process of troubleshooting, I
> 
>     sudo apt reinstall libvirt   (and other QEMU/KVM virtualization
> dependencies)
> 
> Now I am getting this particular error when trying to use the
> host-passthrough for the CPU.
> 
> "error: unsupported configuration: CPU mode 'host-passthrough' for x86_64
> qemu domain on x86_64 host is not supported by hypervisor"
> 
> This was working previously.  I found that two other domains are responding
> the same.
> 
> The configuration in xml file is:
> 
>     <metadata>

You've omitted the part of the config that shows whether the
guest is configured for 'tcg' or 'kvm'. Given your error
message my guess is that you've got a 'tcg' based guest,
for which '-cpu host' is not available.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


