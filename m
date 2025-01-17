Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D1FC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkCR-0000IZ-Ix; Fri, 17 Jan 2025 06:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYkCO-0000GD-LT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:07:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYkCN-0001X1-2Y
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737112052;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9b7K8QteWYX8b5ZKtc6AtfKS5KI6GtIF3lNxlJpR1uY=;
 b=S+bj21cDxQRxNEIUgrHNyPOuVnrvz8PjXvPG81SP05bC5oZvN9eEZyE1eoEXCOWxDGmaZM
 aqNqVOlg3QoIwoIPfsBH3Gfnl683+PieflbnuVdtF8dETcN5X0mJxW4erGJiPsppKv4YgZ
 fvFMJv7U19yv6yJ8142T+rqJH5o2BJ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-1CqDuJ4XMqmwwp0Co-dNoQ-1; Fri,
 17 Jan 2025 06:07:27 -0500
X-MC-Unique: 1CqDuJ4XMqmwwp0Co-dNoQ-1
X-Mimecast-MFC-AGG-ID: 1CqDuJ4XMqmwwp0Co-dNoQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DFCE195605A; Fri, 17 Jan 2025 11:07:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B96C43003FD3; Fri, 17 Jan 2025 11:07:21 +0000 (UTC)
Date: Fri, 17 Jan 2025 11:07:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/3] Remove deprecated machines pc-i440fx-2.4 up to
 pc-i440fx-2.12
Message-ID: <Z4o55sRqJJtMd-zI@redhat.com>
References: <20250117102738.59714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117102738.59714-1-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 17, 2025 at 11:27:35AM +0100, Thomas Huth wrote:
> While our new auto-disablement of old machine types will only kick
> in with the next (v10.1) release, the pc-i440fx-2.* machine types
> have been explicitly marked as deprecated via our old deprecation
> policy mechanism before (two releases ago), so it should be fine to
> remove them now already.

These were marked deprecated manually in 9.1.0 with:

  commit 792b4fdd4eb8197bd6eb9e80a1dfaf0cb3b54aeb
  Author: Philippe Mathieu-Daudé <philmd@linaro.org>
  Date:   Wed Feb 28 10:34:35 2024 +0100

    hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
    
    Similarly to the commit c7437f0ddb "docs/about: Mark the
    old pc-i440fx-2.0 - 2.3 machine types as deprecated",
    deprecate the 2.4 to 2.12 machines.

but that commit was reverted a couple of weeks later in 9.1.0 dev
when I added the automatic deprecation/deletion logic

  commit 37193b7b43b6a973e56fa115098c5895ebdc7145
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Thu Jun 20 17:57:41 2024 +0100

    hw/i386: remove obsolete manual deprecation reason string of i440fx machines

IOW, in terms of releases, these deprecations were introduced under
the new policy rather than the old policy.

> Note that we can not do much additional clean ups on top yet since
> the corresponding q35 machines (which share the same compatibility knobs)
> are still around and only will be removed for the 10.1 release instead.
> So the bigger clean-up can only be done for 10.1, but removing the i440fx
> machine types now will still have at least a small benefit of accelerating
> our CI a little bit (since we don't have to run tests for these old machine
> types anymore).

FYI Philippe had a series removing i440fx 2.4 & 2.5 which includes alot of
the extra cleanups:

  https://lists.nongnu.org/archive/html/qemu-devel/2025-01/msg02710.html


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


