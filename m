Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E15606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cJ/LEqJx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULWd-0005Sh-Gh; Fri, 20 Nov 2026 05:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xULWU-0005SE-Bk
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xULWS-0001I3-BC
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795169230;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zvj/w0wHUe6TbFEt8JrQTao1YWRuYSUUzzr9fMXYuxI=;
 b=cJ/LEqJxQ/Rgu8QJGFPyMdqGXdgEZIj/NbK8PzuGuvOm6q7JQds6JAAJscOLufwnNipeRH
 Whpom3iaXQHBHoUtu5iSXpv6RuqCHRyuUgxDNGnFMw1GX/VjFSqf8xqT/9LB2CZiNehuE/
 qyPWtLHF2Vd3k9sc5Py3j23j3+yWFMs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-5dGIx_q2Ni2ws9YtRz5VDw-1; Fri,
 20 Nov 2026 10:07:06 +0000
X-MC-Unique: 5dGIx_q2Ni2ws9YtRz5VDw-1
X-Mimecast-MFC-AGG-ID: 5dGIx_q2Ni2ws9YtRz5VDw_1795169224
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BA221800359; Fri, 20 Nov 2026 10:07:04 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80AE61956059; Fri, 20 Nov 2026 10:07:00 +0000 (UTC)
Date: Fri, 20 Nov 2026 10:06:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Aniket Sahu <asahu1x@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, peterx@redhat.com,
 farosas@suse.de, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 gautam@linux.ibm.com, thuth@redhat.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH 2/5] tests/functional/ppc64: pin machine types for
 hypervisor tests
Message-ID: <awAbwZ_w992RXUDY@redhat.com>
References: <20261120095854.35941-7-asahu1x@linux.ibm.com>
 <20261120095854.35941-9-asahu1x@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120095854.35941-9-asahu1x@linux.ibm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 03:28:55PM +0530, Aniket Sahu wrote:
> Pin machine types to avoid CPU compatibility issues:
> - Use pseries-8.2 (POWER9) for pseries tests instead of generic 'pseries'
>   alias which resolves to pseries-11.2 (power11_v2.0)
> - Use powernv9 for powernv test to ensure consistent PCIe topology
> - Fix test_hv_pseries_kvm to use TCG accelerator (L1 runs under TCG,
>   L2 uses KVM inside L1)
> 
> The generic 'pseries' alias now resolves to a machine whose default CPU
> (power11) is not known to the qemu-system-ppc64 packaged by Alpine,
> causing the L2 guest to fail with "Register sync failed" error.
> 
> Signed-off-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
> ---
>  tests/functional/ppc64/test_hv.py | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/ppc64/test_hv.py b/tests/functional/ppc64/test_hv.py
> index 8a1fca2cb1..d977038271 100755
> --- a/tests/functional/ppc64/test_hv.py
> +++ b/tests/functional/ppc64/test_hv.py
> @@ -125,7 +125,12 @@ def do_test_kvm(self, hpt=False):
>      def test_hv_pseries(self):
>          self.require_accelerator("tcg")
>          self.require_netdev('user')
> -        self.set_machine('pseries')
> +        # Pin to pseries-8.2 (default CPU power9_v2.2) so that kvm-hv.ko inside
> +        # the L1 Alpine guest sees a POWER9 register set.  The generic 'pseries'
> +        # alias resolves to pseries-11.2 (power11_v2.0) which Alpine's packaged
> +        # qemu-system-ppc64 does not recognise, causing the L2 "Register sync
> +        # failed" error.  The L2 script passes '-cpu POWER9' to match.
> +        self.set_machine('pseries-8.2')

If the guest needs POWER9, why not add a "-cpu POWER9" flag to the L1
QEMU here, instead of making assumptions about what the machine type
exposes.

Using old versioned machine types in functional tests is undesirable
as we automatically delete versioned machines after 6 years, at
which point we'll need to address the CPU model choice anyway.

>          self.vm.add_args("-accel", "tcg,thread=multi")
>          self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
>          self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on")
> @@ -135,10 +140,13 @@ def test_hv_pseries(self):
>          self.do_stop_alpine()
>  
>      def test_hv_pseries_kvm(self):
> -        self.require_accelerator("kvm")
> +        # L1 runs under TCG; L2 is launched with accel=kvm inside L1
> +        # (see do_test_kvm).
> +        self.require_accelerator("tcg")
>          self.require_netdev('user')
> -        self.set_machine('pseries')
> -        self.vm.add_args("-accel", "kvm")
> +        # Same CPU pinning rationale as test_hv_pseries above.
> +        self.set_machine('pseries-8.2')
> +        self.vm.add_args("-accel", "tcg,thread=multi")
>          self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
>          self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on,cap-ccf-assist=off")
>          self.do_start_alpine()
> @@ -149,7 +157,9 @@ def test_hv_pseries_kvm(self):
>      def test_hv_powernv(self):
>          self.require_accelerator("tcg")
>          self.require_netdev('user')
> -        self.set_machine('powernv')
> +        # Pin to powernv9 so the PCIe topology matches (pcie.0, pcie.2) and
> +        # kvm-hv.ko runs with the POWER9 CPU model.
> +        self.set_machine('powernv9')
>          self.vm.add_args("-accel", "tcg,thread=multi")
>          self.vm.add_args('-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234,drive=drive0',
>                           '-device', 'e1000e,netdev=net0,mac=C0:FF:EE:00:00:02,bus=pcie.0,addr=0x0',
> -- 
> 2.52.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


