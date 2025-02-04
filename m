Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5F1C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 08:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfE3F-0001Jj-UO; Tue, 04 Feb 2025 03:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfE3E-0001JB-18
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 03:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfE3C-0008FC-Eu
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 03:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738656773;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+l//LIVHDCsF3HWAH0IiwFCI2Gb8nvC5mYrbRnLnfI=;
 b=auS84j9QDJbpeom1jNikdxr5KMREUI+XBO5dUljsRDJ8BAUoX7SZtQsevODh0ZmIPl+wBh
 myFU+qJNEga726bSQM9Sg/Cm3nsSvXnG0TsYDzrrlSNZBaHgu5W/+SJ2og9JCWZdwQKSQF
 nD5/GbkzkXqxRbDu2uf8V4kGe5gAerA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-ZPsErN4rPwqlB70V-6Egrg-1; Tue,
 04 Feb 2025 03:12:50 -0500
X-MC-Unique: ZPsErN4rPwqlB70V-6Egrg-1
X-Mimecast-MFC-AGG-ID: ZPsErN4rPwqlB70V-6Egrg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4EC819560B8; Tue,  4 Feb 2025 08:12:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 394E019560BC; Tue,  4 Feb 2025 08:12:43 +0000 (UTC)
Date: Tue, 4 Feb 2025 08:12:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 mark.cave-ayland@ilande.co.uk, philmd@linaro.org, thuth@redhat.com,
 andrew.cooper3@citrix.com, anthony.perard@vates.tech,
 michal.orzel@amd.com, jbeulich@suse.com, julien@xen.org,
 roger.pau@citrix.com, xen-devel@lists.xenproject.org,
 bertrand.marquis@arm.com
Subject: Re: [PATCH v2 00/14] meson: Deprecate 32-bit host support
Message-ID: <Z6HL5PHL3JzTQBpr@redhat.com>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <467a5a58-952e-4930-8e91-744eda6d87d9@redhat.com>
 <e40c39d4-425c-4566-af41-373941894045@linaro.org>
 <alpine.DEB.2.22.394.2502031438170.11632@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2502031438170.11632@ubuntu-linux-20-04-desktop>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Feb 03, 2025 at 02:43:05PM -0800, Stefano Stabellini wrote:
> +Xen maintainers
> 
> 
> On Mon, 3 Feb 2025, Richard Henderson wrote:
> > On 2/3/25 04:54, Paolo Bonzini wrote:
> > > On 2/3/25 04:18, Richard Henderson wrote:
> > > > v1: 20250128004254.33442-1-richard.henderson@linaro.org
> > > > 
> > > > For v2, immediately disable 64-on-32 TCG.
> > > > 
> > > > I *suspect* that we should disable 64-on-32 for *all* accelerators.
> > > > The idea that an i686 binary on an x86_64 host may be used to spawn
> > > > an x86_64 guest via kvm is silly and a bit more than niche.
> > > 
> > > At least Xen used to be commonly used with 32-bit dom0, because it saved
> > > memory and dom0 would map in guest buffers as needed.  I'm not sure how
> > > common that is these days, perhaps Stefano knows.
> > 
> > As a data-point, debian does not ship libxen-dev for i686.
> > We cannot build-test this configuration at all.
> > 
> > I can build-test Xen for armhf, and I guess it would use i386-softmmu; it's
> > unclear whether x86_64-softmmu and aarch64-softmmu are relevant or useful for
> > an armhf host, or as an armhf binary running on an aarch64 host.
> 
> 
> On the Xen side, there are two different use cases: x86 32-bit and ARM
> 32-bit.  
> 
> For x86 32-bit, while it was a very important use case in the past, I
> believe it is far less so now. I will let the x86 maintainers comment on
> how important it is today.

If the Xen project needs an excuse to justify stopping 32-bit host
support, QEMU would be happy to act as the excuse :-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


