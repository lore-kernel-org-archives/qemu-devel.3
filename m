Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B105DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh8lx-0005ix-Jq; Tue, 07 Jul 2026 12:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh8lt-0005iR-KG
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh8lr-0003pH-GY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783442142;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUEXje23F2Uj4VPRMzXqFEoH1A0rwil4OjB+w9qljAs=;
 b=NOn6fDHN7y2VXprnzCRsFbmVtym+KiNzR58eKl8f/8RP30yjurBY+E+NPDyU7u3YKQAjs5
 GO7OkZa1ZeQYbQSZdAqgo92N7EBSkOofuk6kEU4nGTXMVa/ZIZ0BMkyS2Erj1hfX9BjyOy
 OZD/IDI5eWNTMrT4EzpE9jdgGtn1YtY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-wVY-AThFOxu4z7lhyR-voQ-1; Tue,
 07 Jul 2026 12:35:38 -0400
X-MC-Unique: wVY-AThFOxu4z7lhyR-voQ-1
X-Mimecast-MFC-AGG-ID: wVY-AThFOxu4z7lhyR-voQ_1783442137
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63BA919540D2; Tue,  7 Jul 2026 16:35:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2319180075D; Tue,  7 Jul 2026 16:35:33 +0000 (UTC)
Date: Tue, 7 Jul 2026 17:35:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <ak0q0vOeFVJsDBcL@redhat.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Tue, Jul 07, 2026 at 04:43:43PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jul 7, 2026 at 2:59 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Beyond the overall virt/non-virt use case classification, there are
> > a number of scenarios which we have decided will not be treated as
> > security issues. Start to document some of these to give consistency
> > in our treatemnt of incoming disclosures.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >
> > Mauro / Michael: please suggest any other rules which we have applied
> > historically on qemu-security disclosures that we should capture here.
> >
> > The vfio-user/vhost-user addition is a new one based on discussions
> > in some GitLab issues today/yesterday
> >
> >  docs/system/security.rst | 63 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >
> > diff --git a/docs/system/security.rst b/docs/system/security.rst
> > index 53992048e6..fbbca50f95 100644
> > --- a/docs/system/security.rst
> > +++ b/docs/system/security.rst
> > @@ -75,6 +75,69 @@ Bugs affecting the non-virtualization use case are not considered security
> >  bugs at this time.  Users with non-virtualization use cases must not rely on
> >  QEMU to provide guest isolation or any security guarantees.
> >
> > +Security boundary scope
> > +'''''''''''''''''''''''
> > +
> > +Even where a flaw affects the virtualization use case described above,
> > +not all scenarios will be considered in scope. The following guidelines
> > +are used to evaluate whether to apply the full security process, or treat
> > +an issue as a normal bug.
> > +
> > +* **assert** / **abort**. If triggering the code path requires kernel
> > +  privileges (or root account access) in the guest, asserts/aborts in
> > +  QEMU are a self inflicted denial of service. These will **not** be
> > +  treated as security flaws, at most hardening bugs. If triggering the
> > +  code path can be done by an unprivileged guest OS account, this
> > +  **may** justify handling as a security bug.
> > +
> > +* **vhost-user/vfio-user backends**. The backend processes have
> > +  shared memory regions co-mapped with the QEMU process. The intent
> > +  of the process separation is operational resilience & flexibility
> > +  and allowing for independent software suppliers. There is not
> > +  considered to be security boundary between QEMU and the vhost-user
> > +  & vfio-user backends. Thus flaws in the backends which can cause
> > +  crashes / undesirable behaviour in QEMU will **not** be treated as
> > +  security flaws, but should be fixed as hardening bugs.
> > +
> > +* **memory allocation bounds**. There are many ways in which a QEMU
> > +  process can legitimately consume an amount of memory that is
> > +  significantly larger than the assigned guest RAM. QEMU's worst
> > +  case memory usage should be considered effectively unbounded. As
> > +  such the QEMU deployment on the host should account for the
> > +  possibility of large memory peaks and apply countermeasures to
> > +  provide continuity of host operations. It is typical for the Linux
> > +  OOM killer to reap the process triggering host memory overcommit
> > +  in the case of exccessive usage, offering a degree of protection.
> > +  As such, bugs which can lead to excessive/unbounded memory allocations
> > +  will usually not be classified as security flaws, but should be
> > +  fixed as hardening bugs.
> > +
> > +* **degraded guest behaviour**. There are a set of bugs which can
> > +  lead guest hardware devices to misbehave. For example, a flawed
> > +  virtual IOMMU operation may not offer the guest device isolation
> > +  that would otherwise be expected. If a guest triggered exploit
> > +  requires kernel privileges (or root account access), and leads
> > +  to sub-optimal behaviour of the virtual device this is considered
> > +  a self inflicted service degradation. These will **not** be
> > +  treated as security flaws, at most hardening bugs. If triggernig
> > +  the code path can be done by an unprivileged guest OS account,
> > +  this may justify handling as a security bug.
> > +
> > +* **nested virtualization**. The scope for nested virtualization
> > +  is to prevent a level 2 guest from breaking out into a level
> > +  1 guest. As noted above, a number of scenarios exclude security
> > +  handling for flaws only exploitable by the guest kernel / root
> > +  account with affect the guest's own service/availability. In the
> > +  context of nested virtualization with PCI device assignment, it
> > +  may may be possible for a level 2 guest kernel to trigger flaws
> > +  that affect the level 0 QEMU process. While these bugs should be
> > +  fixed, they will not be triaged as security flaws at this time.
> > +
> > +* **low severity impact**. As a catch all rule, issues which
> > +  are judged to have a "low" severity impact on the system will
> > +  usually not justify handling as security bugs, nor assignment
> > +  of CVEs. They will be fixed as routine bugs when time allows.
> 
> Should we have a section about management-plane protocols? (migration,
> QMP, monitor), since they already require trusted network access?

There is a section later about QMP/monitor

  https://www.qemu.org/docs/master/system/security.html#sensitive-configurations

For migration we do need to think of something to explain our approach
more clearly, and indeed document our expectations for configuration
for migration (trusted LAN vs TLS + certs).

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


