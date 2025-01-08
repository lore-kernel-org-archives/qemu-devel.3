Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DEFE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 15:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXtG-0001sI-1n; Wed, 08 Jan 2025 10:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVXtD-0001s0-QA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:22:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVXtA-0005DY-AY
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736349750;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DKafLz+h5i5GDy2nSeWkvOJQqP+ftgTcSbAqPIfr7sk=;
 b=cKG/Gztdni9lj5+rA8+fR6UgVZK05G/uUR1V/v7bnbvIAhdDrW+uElK3DVUb0k+C9CieCW
 h+kArW3zHgk0yULLOUtefeb82mS+wW6PTzsqn30KdpEJIJNQZiFLwqfyDhZP8ZBWcemPGg
 +AW7ZKo6UA8SmC92Jo048KFTpTsLP1A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-jF3rOSeIMaujuhoR7t6SMQ-1; Wed,
 08 Jan 2025 10:22:28 -0500
X-MC-Unique: jF3rOSeIMaujuhoR7t6SMQ-1
X-Mimecast-MFC-AGG-ID: jF3rOSeIMaujuhoR7t6SMQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A891F19560AE; Wed,  8 Jan 2025 15:22:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.103])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBE54195608D; Wed,  8 Jan 2025 15:22:25 +0000 (UTC)
Date: Wed, 8 Jan 2025 15:22:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Adam <adam@rttst.com>
Cc: qemu-devel@nongnu.org
Subject: Re: 86_64 host is not supported by hypervisor - 2024
Message-ID: <Z36YLpjUxsLd7Ly2@redhat.com>
References: <3fd90b0c-ff50-4dc7-921d-bdecb82c7777@rttst.com>
 <Z36SpfwBeajgIWYZ@redhat.com>
 <5ac40944-367f-4898-ab07-df6ee56644b1@rttst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ac40944-367f-4898-ab07-df6ee56644b1@rttst.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Wed, Jan 08, 2025 at 09:13:47AM -0600, Adam wrote:
> I have backups of the xml and image, and they too report the same issue.
> 
> <domain type='kvm'>
>   <name>vFRANK</name>
>   <uuid>88c29f0e-0d18-42f9-a198-bc9c679fdf8d</uuid>
>   <metadata>

What is reported for

  virt-host-validate qemu
  virsh capabilities --xpath //guest
  virsh domcapabilities --virttype kvm --arch x86_64 --xpath //cpu/mode


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


