Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7572BC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYk6V-0007IP-24; Fri, 17 Jan 2025 06:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYk6N-0007I2-UN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYk6L-0000mm-Uv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737111680;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4opUbAhPeDpMc4HGkna32ivLpdJsbrXGWy+UyBGTIUQ=;
 b=G4RlqmodaXMQJzvM8eGgtmfwFRjiKDjmFL1z8900zSUU4wwcgjKHauJLVZ03jSPmCXIUU+
 FWpMYpMkl0L9tnlWFDHhg0VqhZBW8Qsg01HfcroOrjcvp9QuBRPey6cRSP9K6yc+2sIiTB
 DZGHorEuasXEkSMCL4yS5+iwd54EcI4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-X2IQ4hXwPWm2PNw1h8L9cQ-1; Fri,
 17 Jan 2025 06:01:13 -0500
X-MC-Unique: X2IQ4hXwPWm2PNw1h8L9cQ-1
X-Mimecast-MFC-AGG-ID: X2IQ4hXwPWm2PNw1h8L9cQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B49E1955D80; Fri, 17 Jan 2025 11:01:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 841A019560BF; Fri, 17 Jan 2025 11:01:05 +0000 (UTC)
Date: Fri, 17 Jan 2025 11:01:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH-for-10.1 v2 00/13] hw/arm: Remove virt-2.6 up to
 virt-2.12 machines
Message-ID: <Z4o4bkxPbFOWOF74@redhat.com>
References: <20250116145944.38028-1-philmd@linaro.org>
 <823a0892-e9d9-4d26-b862-83ffd60c2ad1@linaro.org>
 <d9f97b63-dbfc-4322-b7a1-8759d6be5cd7@redhat.com>
 <Z4oP9YEBc-opiL4K@redhat.com>
 <70342038-6bd6-4c80-b46f-69a3c58fb5b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70342038-6bd6-4c80-b46f-69a3c58fb5b5@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 17, 2025 at 09:29:40AM +0100, Thomas Huth wrote:
> On 17/01/2025 09.09, Daniel P. Berrangé wrote:
> > On Fri, Jan 17, 2025 at 07:47:15AM +0100, Thomas Huth wrote:
> > > On 16/01/2025 22.13, Philippe Mathieu-Daudé wrote:
> > > > Hi Peter,
> > > > 
> > > > On 16/1/25 15:59, Philippe Mathieu-Daudé wrote:
> > > > > The versioned 'virt' machines up to 2.12 been marked as deprecated
> > > > > two releases ago, and are older than 6 years, so according to our
> > > > > support policy we can remove them. Remove associated dead code.
> > > > 
> > > > > Philippe Mathieu-Daudé (13):
> > > > >     hw/arm/virt: Remove deprecated virt-2.6 machine
> > > > >     hw/arm/virt: Remove VirtMachineClass::no_pmu field
> > > > >     hw/arm/virt: Remove VirtMachineClass::disallow_affinity_adjustment
> > > > >     hw/arm/virt: Remove deprecated virt-2.7 machine
> > > > >     hw/arm/virt: Remove VirtMachineClass::no_its field
> > > > >     hw/arm/virt: Remove deprecated virt-2.8 machine
> > > > >     hw/arm/virt: Remove VirtMachineClass::claim_edge_triggered_timers
> > > > >       field
> > > > >     hw/arm/virt: Remove deprecated virt-2.9 machine
> > > > >     hw/arm/virt: Remove deprecated virt-2.10 machine
> > > > >     hw/arm/virt: Remove deprecated virt-2.11 machine
> > > > >     hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver field
> > > > >     hw/arm/virt: Remove deprecated virt-2.12 machine
> > > > >     hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam field
> > > > 
> > > > Please ignore this (reviewed) series for now. I'll rebase it and
> > > > repost after the 10.0 release.
> > > 
> > > Why? IMHO it should be ok to include them now already. While Daniel's macro
> > > only starts the automatic disablement for 10.1, it should be ok to remove
> > > them now already according to our normal deprecation policy: The machines
> > > have been marked as deprecated in the 9.1 release already (via commit
> > > https://gitlab.com/qemu-project/qemu/-/commit/ce80c4fa6ff ), and thus they
> > > have been deprecated since two releases already. So it should be fine to
> > > remove them now, shouldn't it?
> > 
> > No, because as of 9.1.0 we documented that machine types are under the
> > new policy, and these were only deprecated in 9.1.0, hence the new policy
> > applies to them.
> 
> Hm, I guess we could argue now about the wording (I don't see a spot in
> ce80c4fa6ff that says that this only happens starting with 10.1), but in the
> long run, it doesn't really matter much whether we remove these machines
> with 10.0 already or just with 10.1, so let's go with 10.1 instead.

That's the wrong commit - I documented the delayed impl of deletion
in a separate commit, so that we could just revert that part on its
own in 10.1 dev:

  commit c9fd2d9a48ee3c195cf83cc611b87b09f02f0013
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Thu Jun 20 17:57:37 2024 +0100

    include/hw: temporarily disable deletion of versioned machine types
    
    The new deprecation and deletion policy for versioned machine types is
    being introduced in QEMU 9.1.0.
    
    Under the new policy a number of old machine types (any prior to 2.12)
    would be liable for immediate deletion which would be a violation of our
    historical deprecation and removal policy
    
    Thus automatic deletions (by skipping QOM registration) are temporarily
    gated on existance of the env variable "QEMU_DELETE_MACHINES" / QEMU
    version number >= 10.1.0. This allows opt-in testing of the automatic
    deletion logic, while activating it fully in QEMU >= 10.1.0.
    
    This whole commit should be reverted in the 10.1.0 dev cycle or shortly
    thereafter.
    
    Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
    Reviewed-by: Thomas Huth <thuth@redhat.com>
    Message-ID: <20240620165742.1711389-10-berrange@redhat.com>
    Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


If a machine type was deprected *before* the 9.1 release cycle, I think
it is fair game to delete it under the historical deprecation rules.

If a machine type was deprecated in 9.1, or later cycles, I think that
deletion is gated until 10.1.0 under the policy applied by that commit
above.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


