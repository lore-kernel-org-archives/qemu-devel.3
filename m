Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D87D39410
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FXP-0002xk-3L; Thu, 02 Apr 2026 06:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w8FXL-0002x6-M0
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w8FXJ-0007Eg-Gy
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775126668;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i3XB0Rv4IKJ2gT/uRlL59t1/ptp/3MqrPjmYMiTVF/A=;
 b=KzzbrTeYRGuLkBSH1F4WlpG+b60hZyuJY/mrKIGG/4kCIa+LQNHo2QlX0dFuB9dc7tmDIX
 qEWFnvugdNKAxSh48B8MyQIqdBkQWpAlm3evf/JlbviNxpWnMvkbt+Bjx4Ig1XWTWOTxwP
 Fz+Uq8R1sO9h7iQixXQZ5XQPFwB5MPc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-XGUCKl8FOUe4sxmDhGA6Yw-1; Thu,
 02 Apr 2026 06:44:25 -0400
X-MC-Unique: XGUCKl8FOUe4sxmDhGA6Yw-1
X-Mimecast-MFC-AGG-ID: XGUCKl8FOUe4sxmDhGA6Yw_1775126664
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31114195609E; Thu,  2 Apr 2026 10:44:24 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F38A19560A6; Thu,  2 Apr 2026 10:44:21 +0000 (UTC)
Date: Thu, 2 Apr 2026 11:44:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 10/10] docs/about/deprecated: Deprecate the
 qemu-system-i386 binary
Message-ID: <ac5Ig5e6g7IwQjCB@redhat.com>
References: <20260402095132.29245-1-thuth@redhat.com>
 <20260402095132.29245-11-thuth@redhat.com>
 <ac4_kKUYE00oRr9j@redhat.com>
 <a47f39f1-c881-4130-ba0b-18edf7816bcd@redhat.com>
 <ac5Hvr0sqapKlMxl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5Hvr0sqapKlMxl@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 02, 2026 at 11:41:02AM +0100, Daniel P. Berrangé wrote:
> On Thu, Apr 02, 2026 at 12:11:37PM +0200, Thomas Huth wrote:
> > On 02/04/2026 12.06, Daniel P. Berrangé wrote:
> > > On Thu, Apr 02, 2026 at 11:51:32AM +0200, Thomas Huth wrote:
> > > > From: Thomas Huth <thuth@redhat.com>
> > > > 
> > > > Aside from not supporting KVM on 32-bit hosts, the qemu-system-x86_64
> > > > binary is a proper superset of the qemu-system-i386 binary. And with
> > > > the 32-bit x86 host support being removed now, it is possible to
> > > > deprecate the qemu-system-i386 binary now, too.
> > > > 
> > > > With regards to 32-bit KVM support in the x86 Linux kernel,
> > > > the developers confirmed that they do not need a recent
> > > > qemu-system-i386 binary here:
> > > > 
> > > >   https://lore.kernel.org/kvm/Y%2ffkTs5ajFy0hP1U@google.com/
> > > > 
> > > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >   docs/about/deprecated.rst | 19 +++++++++++++++++++
> > > >   1 file changed, 19 insertions(+)
> > > > 
> > > > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > > > index a6d6a713265..2de51337d75 100644
> > > > --- a/docs/about/deprecated.rst
> > > > +++ b/docs/about/deprecated.rst
> > > > @@ -301,6 +301,25 @@ machine must ensure that they're setting the ``spike`` machine in the
> > > >   command line (``-M spike``).
> > > > +System emulator binaries
> > > > +------------------------
> > > > +
> > > > +``qemu-system-i386`` binary (since 11.1)
> > > > +''''''''''''''''''''''''''''''''''''''''
> > > > +
> > > > +The ``qemu-system-i386`` binary was mainly useful for running with KVM
> > > > +on 32-bit x86 hosts, but most Linux distributions already removed their
> > > > +support for 32-bit x86 kernels, so hardly anybody still needs this. The
> > > > +``qemu-system-x86_64`` binary is a proper superset and can be used to
> > > > +run 32-bit guests by selecting a 32-bit CPU model, including KVM support
> > > > +on x86_64 hosts. Thus users are recommended to reconfigure their systems
> > > > +to use the ``qemu-system-x86_64`` binary instead. If a 32-bit CPU guest
> > > > +environment should be enforced, you can switch off the "long mode" CPU
> > > > +flag with ``-cpu max,lm=off``, or rename/symlink ``qemu-system-x86_64``
> > > > +to ``qemu-system-i386`` -- QEMU will then run with the 64-bit extensions
> > > > +disabled.
> > > 
> > > Why don't we just have our install rules create the symlink from
> > > qemu-system-x86_64 to qemu-system-i386. That gives us near zero
> > > ongoing maint cost, without need to deprecate stuff / impact users
> > 
> > I think we should do that once the deprecation period is over and we don't
> > allow to build QEMU in this mode anymore. I would rather not jump directly
> > to that state to provide people some time for experimenting whether this new
> > approach works as expected in all scenarios that are in use.
> 
> This feels a bit wierd as a deprecation though.  We're telling people
> not to use  qemu-system-i386 and yet we intend to continue providing
> it via a symlink and expect full back compatibility and people can
> carry on with it forever.
> 
> 
> I think this is probably something better handled via a build time
> option & messages from
> 
>   * Step 1: full i686 binary by default but have --enable-i686-compat
>             to switch to symlink. Issue hint message that symlink will
> 	    become the default in future & asking for feedback if
> 	    --enable-i686-compat is not given
> 
>   * Step 2: symlink i686 binary by default but have --disable-i686-compat
>             to switch to full binary. Issue *WARNING* that full binary
> 	    will be soon removed if --disable-i686-compat is given
> 
>   * Step 3: remove full binary

Having said that, I guess this should still be expressed in a deprecation
note, if we rephase it to describe this plan.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


