Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD6ECAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 15:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvdVO-0003M5-O8; Mon, 08 Sep 2025 11:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvdVI-0003IW-PN
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvdVD-0007u1-8p
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757344192;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=iaArHLIm+HQViU6EUVTSbwazgK+zLFD+CZ0G8y2/KCQ=;
 b=LyrK/oSiz6h81Hauj4m2MBOGIPqE6qB7YNHFWERUgAf1iRsxZIXfvR8e+L6m86mJOG6e6v
 KEilMw6Hj3frj4oMbLZzk37JvH4MWLXYftrS8b87rDynRVv52NHyhpQoQ/4YMsz+WcD5um
 CpWg8ubjjwfkIB9o5Bgq+SB+6ow+BjI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-3JKR8efiM8iDTFQGmbTbzg-1; Mon,
 08 Sep 2025 11:09:50 -0400
X-MC-Unique: 3JKR8efiM8iDTFQGmbTbzg-1
X-Mimecast-MFC-AGG-ID: 3JKR8efiM8iDTFQGmbTbzg_1757344187
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D10C81800366; Mon,  8 Sep 2025 15:09:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E361519560B4; Mon,  8 Sep 2025 15:09:38 +0000 (UTC)
Date: Mon, 8 Sep 2025 16:09:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Message-ID: <aL7xrilR-gyByKEM@redhat.com>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908125058.220973-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
> Currently our security policy defines a "virtualization use case"
> where we consider bugs to be security issues, and a
> "non-virtualization use case" where we do not make any security
> guarantees and don't consider bugs to be security issues.
> 
> The rationale for this split is that much code in QEMU is older and
> was not written with malicious guests in mind, and we don't have the
> resources to audit, fix and defend it.  So instead we inform users
> about what the can in practice rely on as a security barrier, and
> what they can't.
> 
> We don't currently restrict the "virtualization use case" to any
> particular set of machine types.  This means that we have effectively
> barred ourselves from adding KVM support to any machine type that we
> don't want to put into the "bugs are security issues" category, even
> if it would be useful for users to be able to get better performance
> with a trusted guest by enabling KVM. This seems an unnecessary
> restriction, and in practice the set of machine types it makes
> sense to use for untrusted-guest virtualization is quite small.
> 
> Specifically, we would like to be able to enable the use of
> KVM with the imx8 development board machine types, but we don't
> want to commit ourselves to having to support those SoC models
> and device models as part of QEMU's security boundary:
> https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
> 
> This patch updates the security policy to explicitly list the
> machine types we consider to be useful for the "virtualization
> use case".
> 
> This is an RFC partly to see if we have consensus that this change
> makes sense, and partly because I was only able to identify the
> machine types we want to cover for some of our target architectures.
> If maintainers for the other architectures could clarify which
> machine types work with KVM that would be helpful.

The split of "virtualization" vs "non-virtualization" use case
in the docs was always as rather a crude hack.

"Virtualization uses cases" was more or less a code phrase to
mean "the subset of QEMU that we traditionally shipped in RHEL"
as that is approximately what we have reasonable confidence
about.

Personally I wouldn't assign strict equivalence between "machine
can use KVM" and  "virtualization use case".

Case in point - the "isapc" machine type can use KVM but I would
not consider that to be a virtualization use case, and would likely
reject a security report if it /only/ affected isapc, and not 'pc'
/ 'q35'.

We didn't want to undertake the work to annotate every QOM/QDev
impl in QEMU with info about whether we considered it in scope
for security fixes or not, which is what we really ought to do
at some point. The main challenge is someone having the time
to do the audit & annotation work.

> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index f2092c8768b..395c2d7fb88 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -35,6 +35,34 @@ malicious:
>  Bugs affecting these entities are evaluated on whether they can cause damage in
>  real-world use cases and treated as security bugs if this is the case.
>  
> +To be covered by this security support policy you must:
> +
> +- use a virtualization accelerator like KVM or HVF
> +- use one of the machine types listed below
> +
> +It may be possible to use other machine types with a virtualization
> +accelerator to provide improved performance with a trusted guest
> +workload, but any machine type not listed here should not be
> +considered to be providing guest isolation or security guarantees,
> +and falls under the "non-virtualization use case".
> +
> +Supported machine types for the virtualization use case, by target architecture:
> +
> +aarch64
> +  ``virt``
> +i386, x86_64
> +  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``, ``isapc``
> +s390x
> +  ``s390-ccw-virtio``
> +loongarch64:
> +  ``virt``
> +ppc, ppc64:
> +  TODO
> +mips, mips64:
> +  TODO
> +riscv32, riscv64:
> +  TODO

Currently 'virtualization use case' is reasonably vague such that we can
bend its scope as we desire, at the time it is questioned in a possible
security report.

Machine types are only one aspect of this. Devices are the other, and
the area where it gets significantly more fuzzy and difficult because
essentially any device can be used with KVM, and where we draw the
line is fairly arbitrary.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


