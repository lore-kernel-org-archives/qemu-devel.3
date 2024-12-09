Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A26E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgl4-0004Wm-6J; Mon, 09 Dec 2024 11:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tKgl3-0004We-3W
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:37:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tKgl1-0004vh-8e
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733762233;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZJ1+9yXD0/RiOd+oBVnjbeo66kC3HjqcBMm5RLmhDM=;
 b=NMVizQ9UIQ/HlqhwGQwVNNXsUfMptbjOMnsdWfphEr8Cd9ZuzwqxyDZiCTYTJ9CSAkz2hg
 oTa6A/4NF+eK0i9ML/nIbSvkwuTkKMlHkJ/TgQQfzLHLReB3XoeJ5p0+WzkEzgJ4ra1NpI
 Az8qhCJ4jBwZ6cZ0C7OaNgRfZBjOhhk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-3ybJw9seP8m8cQRASh4a-Q-1; Mon,
 09 Dec 2024 11:37:12 -0500
X-MC-Unique: 3ybJw9seP8m8cQRASh4a-Q-1
X-Mimecast-MFC-AGG-ID: 3ybJw9seP8m8cQRASh4a-Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08BAD195D032; Mon,  9 Dec 2024 16:37:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32161195605A; Mon,  9 Dec 2024 16:37:04 +0000 (UTC)
Date: Mon, 9 Dec 2024 16:37:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 eric.auger@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH for-10.0] tests/functional: Convert the intel_iommu
 avocado test
Message-ID: <Z1ccrYDMVLo9vZF6@redhat.com>
References: <20241206181728.1241169-1-thuth@redhat.com>
 <d07f4ade-716c-4d58-b6d9-a95b4ffe58ab@redhat.com>
 <7e81c4a2-cc76-4d8c-b14a-fd008eff0c09@redhat.com>
 <Z1az26HxcIHVlB-d@redhat.com>
 <4fa944df-ddf2-48be-bbb0-7b24f63263e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fa944df-ddf2-48be-bbb0-7b24f63263e6@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Dec 09, 2024 at 05:31:37PM +0100, Philippe Mathieu-Daudé wrote:
> On 9/12/24 10:09, Daniel P. Berrangé wrote:
> > On Mon, Dec 09, 2024 at 09:26:21AM +0100, Thomas Huth wrote:
> > > On 09/12/2024 09.12, Eric Auger wrote:
> > > > Hi Thomas,
> > > > 
> > > > On 12/6/24 19:17, Thomas Huth wrote:
> > > > > Convert the intel_iommu test to the new functional framework.
> > > > > This test needs some changes since we neither support the old 'LinuxTest'
> > > > > class in the functional framework yet, nor a way to use SSH for running
> > > > > commands in the guest. So we now directly download a Fedora kernel and
> > > > > initrd and set up the serial console for executing the commands and for
> > > > > looking for the results.
> > > > > 
> > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > ---
> > > > >    MAINTAINERS                                   |   1 +
> > > > >    tests/functional/meson.build                  |   1 +
> > > > >    .../test_intel_iommu.py}                      | 119 ++++++++----------
> > > > >    3 files changed, 51 insertions(+), 70 deletions(-)
> > > > >    rename tests/{avocado/intel_iommu.py => functional/test_intel_iommu.py} (41%)
> > > > >    mode change 100644 => 100755
> 
> 
> > > > > -        self.launch_and_wait()
> > > > > -        self.ssh_command('cat /proc/cmdline')
> > > > > -        self.ssh_command('dmesg | grep -e DMAR -e IOMMU')
> > > > > -        self.ssh_command('find /sys/kernel/iommu_groups/ -type l')
> > > > > -        self.ssh_command('dnf -y install numactl-devel')
> > > > I understand you cannot use ssh yet but the bulk of the test was the
> > > > execution of the dnf install meaning we lose the main substance of it
> > > > through the conversion.
> > > 
> > > Ah, I see, so this was exercising the virtio-net device with the IOMMU ...
> > > and I already wondered why there was this "dnf install" at the end without
> > > doing anything with  the numactl-devel package ... (a comment would have
> > > been helpful here)
> > 
> > FYI, I find 'dnf instal' to be a *highly* undesirable thing todo in
> > our test functional. Its performance is highly non-deterministic
> > depending on what mirror you happen to get sent to, such that it could
> > easily push us over the timeouts. It is also susceptible to periodic
> > broken mirrors, and instability around time of Fefdora EOL. I can't
> > remember if it was this test case, or a different one, but I've seen
> > problems before in avocado with 'dnf install'.
> > 
> > If we want to test working networking, then can we arrange for something
> > more simple & targetted to run, with better worst case performance.
> 
> Could we use 2 virtio-net interfaces inter-connected and stress with
> https://linux.die.net/man/1/ab ?

Do we actually need to stress this ? IMHO for a functional tests we just
need to prove that the device is working at a fairly basic level.
"wget example.com"

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


