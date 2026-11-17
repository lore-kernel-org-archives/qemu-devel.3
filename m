Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79567606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V1Znv6S6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMMJ-0005cm-89; Tue, 17 Nov 2026 11:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xTMMB-0005cV-UN
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 11:48:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xTMM9-0004J8-1h
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 11:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794934107;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4H9VYaB/Sl/q4Q4gwwVRQrhoWjt2lx3Cj91SRMycjqc=;
 b=V1Znv6S6Ipu8qc5zQuYpEEQ0xMdnfkN8Y8AlyrgqAdgwDJNZG0HK0bmRDdzJ4rBHdr4qma
 6Q/YSCZQzDmyHZqFouSdOQpkDRjdKXCylJWKfkO9smtpl8VRdxgGJOW0g9eJykxvIc06Tc
 MBjmNn/f/4FMoGa9A4UYXpS28eQLmRw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-zxt803evMZuwgWwrSAMfCw-1; Tue,
 17 Nov 2026 11:48:25 -0500
X-MC-Unique: zxt803evMZuwgWwrSAMfCw-1
X-Mimecast-MFC-AGG-ID: zxt803evMZuwgWwrSAMfCw_1794934103
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 514561956088; Tue, 17 Nov 2026 16:48:23 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 311A1195B3C8; Tue, 17 Nov 2026 16:48:20 +0000 (UTC)
Date: Tue, 17 Nov 2026 16:48:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Lamprecht <t.lamprecht@proxmox.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH for-12.0 0/2] hw/i386/microvm: add versioned machine types
Message-ID: <avyFUmm2NDu66vXz@redhat.com>
References: <20261116235010.3622909-1-t.lamprecht@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116235010.3622909-1-t.lamprecht@proxmox.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 12:30:12AM +0100, Thomas Lamprecht wrote:
> Proxmox VE wants to use microvm with PCIe and ACPI for long-lived Linux
> guests, i.e. like Linux containers but with better isolation. Our
> cluster upgrades and host maintenance rely on live migrating guests to
> hosts that already run a newer QEMU, which is currently not really
> possible with microvm, as it is not versioned.
> 
> When microvm was added, versioning was ruled out on purpose [1], as it
> targeted short-lived guests. Since then, Paolo noted that microvm could
> start having versioned variants [2]. So this series adds microvm-X.Y
> machine types, starting with 12.0, as 11.2 is already in freeze.

If you're going to the trouble of enabling PCIe and ACPI for
microvm, and also wanting versioning, then why are you not
picking 'q35' ?

IIRC, since microvm was introduced more pieces of q35 are now
configurable to allow disabling at runtime, further reducing
the difference between a minimal q35 and microvm  w/ PCIe+ACPI.



> Noteworthy points that migth be up for discussion:
> 
> - Following Paolo preference [2], "microvm" does not become an alias of
>   the latest version, rather, it is left as it is. Unversioned machine
>   types are meant to be a moving target [2], which includes defaulting
>   to the latest version of a CPU model. The versioned types need a fixed
>   default and use version 1, like pc and q35 do, and an alias cannot
>   differ from the type it refers to.

I think that would be a bad idea, as it would make 'microvm' work
differently to every other machine type where we have versioning.
The standard pattern is that the unversioned name is always an
alias for the latest version.

Defining an unversioned name as a full machine, separate from the
latest versioned machine esentially gives you two things which are
identical. The burden of versioned machines comes from ensuring the
existing versions get the right compat properties set to keep their
ABI unchanged and from wiring up the boilerplate for new versions
at the start of each release.

> 
> - The x86 CPU compat properties are part of pc_compat_X_Y in
>   hw/i386/pc.c, which is only built with CONFIG_PC. Once microvm-12.0
>   needs them, they would have to move, for example to
>   hw/i386/x86-common.c (but I'm happy to use another place, just say
>   the word).
> 
> - With KVM, microvm uses the host's physical address width, so
>   migration also needs the same width on both hosts. This is not new,
>   the series only documents it for now.
> 
> Tested with the x86_64 CPU model and migration functional tests,
> bios-tables-test and qom-test, and by live migrating Linux guests on
> microvm-12.0 with TCG and KVM.
> 
> [1] https://lore.kernel.org/qemu-devel/af3acd26-f114-5889-182a-7dbd025393b9@redhat.com/
> [2] https://lore.kernel.org/qemu-devel/004396c0-8370-4015-b746-3c800f45984f@redhat.com/
> 
> Thomas Lamprecht (2):
>   hw/i386/microvm: make the default CPU model version a class field
>   hw/i386/microvm: add versioned machine types
> 
>  docs/system/i386/microvm.rst                  | 21 ++++++++-
>  hw/i386/microvm.c                             | 47 ++++++++++++++++++-
>  include/hw/i386/microvm.h                     |  3 ++
>  .../x86_64/test_cpu_model_versions.py         | 41 ++++++++++++++++
>  4 files changed, 110 insertions(+), 2 deletions(-)
> 
> 
> base-commit: f71afb409a87c4ecd0f9d63a5963eb645dfab780
> -- 
> 2.47.3
> 
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


