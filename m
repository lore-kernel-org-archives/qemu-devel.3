Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334FFC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkTa-0007AV-J4; Fri, 17 Jan 2025 06:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYkTX-00078l-5Y
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:25:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYkTU-0003vq-4B
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737113113;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70o8lwlnba1VdfhceppZGOKI1GBNHmICKHEIuaSNl/w=;
 b=KiM3OaC32Rv72sLd2btiGbAxoGyMOCE8BRSZhkEpiAc0redesF9AfEbcBVrxksj3NhPI0M
 JPK0VVR/4PfLmh9ytyaVJu3TkDJ2L2drLjK4LJodBdge4hSwJJ8rc2A5cjl7+1SbzK8lTg
 sR0YPSz1HllvspEBhANt6jwZ2h34arI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-VJnE6ed5OpOQVKo6apsrQw-1; Fri,
 17 Jan 2025 06:25:10 -0500
X-MC-Unique: VJnE6ed5OpOQVKo6apsrQw-1
X-Mimecast-MFC-AGG-ID: VJnE6ed5OpOQVKo6apsrQw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B3BE19560B1; Fri, 17 Jan 2025 11:25:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90E6830001BE; Fri, 17 Jan 2025 11:25:05 +0000 (UTC)
Date: Fri, 17 Jan 2025 11:25:02 +0000
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
Message-ID: <Z4o-DsOmfiKdnEkQ@redhat.com>
References: <20250117102738.59714-1-thuth@redhat.com>
 <Z4o55sRqJJtMd-zI@redhat.com>
 <9e64e7cf-eca9-4b9c-ba30-1ce1441e81f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e64e7cf-eca9-4b9c-ba30-1ce1441e81f7@redhat.com>
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

On Fri, Jan 17, 2025 at 12:14:43PM +0100, Thomas Huth wrote:
> On 17/01/2025 12.07, Daniel P. Berrangé wrote:
> > On Fri, Jan 17, 2025 at 11:27:35AM +0100, Thomas Huth wrote:
> > > While our new auto-disablement of old machine types will only kick
> > > in with the next (v10.1) release, the pc-i440fx-2.* machine types
> > > have been explicitly marked as deprecated via our old deprecation
> > > policy mechanism before (two releases ago), so it should be fine to
> > > remove them now already.
> > 
> > These were marked deprecated manually in 9.1.0 with:
> > 
> >    commit 792b4fdd4eb8197bd6eb9e80a1dfaf0cb3b54aeb
> >    Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> >    Date:   Wed Feb 28 10:34:35 2024 +0100
> > 
> >      hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
> >      Similarly to the commit c7437f0ddb "docs/about: Mark the
> >      old pc-i440fx-2.0 - 2.3 machine types as deprecated",
> >      deprecate the 2.4 to 2.12 machines.
> > 
> > but that commit was reverted a couple of weeks later in 9.1.0 dev
> 
> No, we did not revert that commit, the text is still there, so I think it
> still applies.

Oh, you mean the text in deprecated.rst. I just reverted the manual
deprecation in the code.

> > when I added the automatic deprecation/deletion logic
> > 
> >    commit 37193b7b43b6a973e56fa115098c5895ebdc7145
> >    Author: Daniel P. Berrangé <berrange@redhat.com>
> >    Date:   Thu Jun 20 17:57:41 2024 +0100
> > 
> >      hw/i386: remove obsolete manual deprecation reason string of i440fx machines
> > 
> > IOW, in terms of releases, these deprecations were introduced under
> > the new policy rather than the old policy.
> 
> Why should your generic policy override an explicit statement for those
> machines?

I guess that's matter of opinion. I considered the policy to apply to
all versioned machine types deprecated from 9.1.0 onwards. Having them
mentioned in deprecated.rst doesn't alter the policy, IMHO, it is merely
a bit of redundant documentation.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


