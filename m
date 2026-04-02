Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7ABD6AAF0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 16:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8L3G-0005bF-RZ; Thu, 02 Apr 2026 12:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w8L39-0005aW-6y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 12:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w8L36-0001tE-0E
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 12:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775147858;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eRCVNUzJXTwZ8sxX43Hq3rlrlKTCOtpRajH+lTV+wvE=;
 b=BBzIsOpU1D1olr+UduRZxYhDbssf/WEb6vzRJasKJPdywfVeRIUdLf9PGw8aHIfRYnOGIU
 Uh5HIcj52Mbz8hFKLOWxOnQjIi1Lzq/fAEH+u8W3SVOSDonSVExxCIkHpCmRnCKf8XNTW3
 EDuwXGXkmuKewssZ1c+aLCoE5QRXDMk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-0kLW25QsMNqsZSfaIawLeg-1; Thu,
 02 Apr 2026 12:37:37 -0400
X-MC-Unique: 0kLW25QsMNqsZSfaIawLeg-1
X-Mimecast-MFC-AGG-ID: 0kLW25QsMNqsZSfaIawLeg_1775147856
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED1A818002C9; Thu,  2 Apr 2026 16:37:35 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 860AE30002D2; Thu,  2 Apr 2026 16:37:33 +0000 (UTC)
Date: Thu, 2 Apr 2026 17:37:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH for-11.1 00/10] Deprecate the qemu-system-i386 binary
Message-ID: <ac6bSqRgUviOyXtF@redhat.com>
References: <20260402095132.29245-1-thuth@redhat.com>
 <CAFEAcA8EyCn83zEcysm=4Py-BsQKSBV0KcBUMjMm4Df-pF2BoA@mail.gmail.com>
 <988641b4-9e93-40eb-9742-63d8c1e17547@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <988641b4-9e93-40eb-9742-63d8c1e17547@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Thu, Apr 02, 2026 at 03:02:17PM +0200, Thomas Huth wrote:
> On 02/04/2026 13.20, Peter Maydell wrote:
> > On Thu, 2 Apr 2026 at 10:52, Thomas Huth <thuth@redhat.com> wrote:
> > > 
> > > This is a follow-up to my 3-years old patch series here, now with the
> > > universal binary initiative in mind:
> > > 
> > >   https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg04541.html
> > > 
> > > This patch series allows to run qemu-system-x86_64 in 32-bit-only mode
> > > (by renaming or symlinking the binary to "qemu-system-i386" or something
> > > similar with a "-i386" suffix). After doing this, qemu-system-x86_64
> > > should be a full superset of qemu-system-i386 (apart from 32-bit KVM
> > > support, which however is not required anymore now that we removed support
> > > for 32-bit hosts). It is now possible to migrate a guest that has been
> > > started with an old "qemu-system-i386" binary to a qemu-system-x86_64
> > > binary that has been renamed with a "-i386" suffix.
> > 
> > I think my reaction here is similar to what it has been when
> > the similar idea has been raised for qemu-system-arm : we should
> > have a coordinated plan that is considering all architectures,
> > not just dropping a single binary for one architecture where
> > it happens to be more straightforward.
> 
> Sure, I'm open for suggestions ... how should that coordinated plan look like?
> Maybe we could simply stop adding new versioned machine types to the 32-bit
> flavor binaries, and then let the old machine types expire? And when there
> is no versioned machine type left anymore, we could remove the 32-bit
> binaries?

On i686 the versioned machine types are shared with x86_64
and likewise  arm7  'virt' machine is shared with aarch64.
So there's no concept of "stop adding machines" unless we
go out of our way to block what we're already doing for
64-bit from being used on 32-bit.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


