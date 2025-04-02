Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD584C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 11:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzwan-0004gE-6Z; Wed, 02 Apr 2025 07:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1tzwae-0004ZH-G3
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1tzwac-0006kf-RC
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743594541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DF3j9iD8iV3IjjVAHSJRzvOowoWKV1uIAYmTzBweQhI=;
 b=VnDSO21izs9AoNVodE8iolvZnc5otPJMsLH8IVlXFs8u+2fJchN+Zp/pfe2hf1jXJmiGiC
 OuEHFcJIoqvckjNcFZPod4UndDlZCDBdRrzJ7siEHbBRjIgO9JQgFHGdZePydfth6+Pqe5
 n63SpTv7K2LJpiDJ93dWku+PbbZHnbM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-_rJsc2BZOcm8JdN3YQ2TwQ-1; Wed,
 02 Apr 2025 07:47:45 -0400
X-MC-Unique: _rJsc2BZOcm8JdN3YQ2TwQ-1
X-Mimecast-MFC-AGG-ID: _rJsc2BZOcm8JdN3YQ2TwQ_1743594464
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43E0F180899B; Wed,  2 Apr 2025 11:47:44 +0000 (UTC)
Received: from orkuz (unknown [10.43.3.115])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAB72180094A; Wed,  2 Apr 2025 11:47:42 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:47:41 +0200
From: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, devel@lists.libvirt.org
Subject: Re: [PATCH v8 55/55] docs: Add TDX documentation
Message-ID: <Z-0j3Urolt56QBdo@orkuz.int.mamuti.net>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-56-xiaoyao.li@intel.com>
 <Z-0WclTZ-e-sTjzO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-0WclTZ-e-sTjzO@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 02, 2025 at 11:50:26 +0100, Daniel P. Berrangé wrote:
> CC libvirt / Jiri, for confirmation about whether the CPUID restrictions
> listed below will have any possible impact on libvirt CPUID handling...
..
> > +Feature check
> > +~~~~~~~~~~~~~
> > +
> > +QEMU checks if the final (CPU) features, determined by given cpu model and
> > +explicit feature adjustment of "+featureA/-featureB", can be supported or not.
> > +It can produce feature not supported warning like
> > +
> > +  "warning: host doesn't support requested feature: CPUID.07H:EBX.intel-pt [bit 25]"
> > +
> > +It can also produce warning like
> > +
> > +  "warning: TDX forcibly sets the feature: CPUID.80000007H:EDX.invtsc [bit 8]"
> > +
> > +if the fixed-1 feature is requested to be disabled explicitly. This is newly
> > +added to QEMU for TDX because TDX has fixed-1 features that are forcibly enabled
> > +by TDX module and VMM cannot disable them.
> 
> This is where I'm wondering if libvirt has anything to be concerned
> about. Possibly when libvirt queries the actual CPUID after launching
> the guest it will just "do the right thing" ? Wondering if there's any
> need for libvirt to be aware of CPUID restrictions before that point
> though ?

Yes, it will do the right thing.

Unless a user explicitly requests check='full'. Libvirt will use
check='full' on its own only during migration and at that point the CPU
definition is already modified according to what QEMU changed when the
domain was started. So this will just work.

For explicit check='full' to be usable we'd need a way to tell users
which features are required/forbidden with TDX. But to be honest I don't
think this is needed.

Jirka


