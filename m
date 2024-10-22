Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB73BD2C54B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Ejz-0001SX-L0; Tue, 22 Oct 2024 09:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3Ejv-0001Rl-7j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3Ejs-0006Qh-W4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729602955;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4GTO7085v2TIPI4FXf0ih1lKiDeK6IWhXYTPmsSmqw=;
 b=hXl3YK/HopUEDCP41UZ9djQDeHzEXwMhIdRl39iRShFBk79zj57AYLyibSsXuRtUBsAKT/
 0UsW5pqXWwjiP3ZASlwLdKWOmxPafWZfS2U24Cxmfbr870R1AsyispbjdzafDuQ7l+z0Om
 w2kdm/m8RKAk7qUvB+fuelVc4EFb+nc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-nXWwGzj9MJizXkKa06nA8A-1; Tue,
 22 Oct 2024 09:15:53 -0400
X-MC-Unique: nXWwGzj9MJizXkKa06nA8A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BDAD1955F45
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 13:15:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 176251956056; Tue, 22 Oct 2024 13:15:47 +0000 (UTC)
Date: Tue, 22 Oct 2024 14:15:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, vchundur@redhat.com,
 rjarry@redhat.com
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <ZxelgDeuZaia-Vqf@redhat.com>
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
 <ZxJbtkMO1QcoiqVn@redhat.com>
 <20241022144615.203cf0da@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022144615.203cf0da@imammedo.users.ipa.redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 22, 2024 at 02:46:15PM +0200, Igor Mammedov wrote:
> On Fri, 18 Oct 2024 13:59:34 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Fri, Oct 18, 2024 at 02:25:26PM +0200, Igor Mammedov wrote:
> > > On Wed, 16 Oct 2024 14:56:39 +0200
> > > "Anthony Harivel" <aharivel@redhat.com> wrote:
> [...]
> 
> > > 
> > > This also leads to a question, if we should account for
> > > not VCPU threads at all. Looking at real hardware, those
> > > MSRs return power usage of CPUs only, and they do not
> > > return consumption from auxiliary system components
> > > (io/memory/...). One can consider non VCPU threads in QEMU
> > > as auxiliary components, so we probably should not to
> > > account for them at all when modeling the same hw feature.
> > > (aka be consistent with what real hw does).  
> > 
> > I understand your POV, but I think that would be a mistake,
> > and would undermine the usefulness of the feature.
> > 
> > The deployment model has a cluster of hosts and guests, all
> > belonging to the same user. The user goal is to measure host
> > power consumption imposed by the guest, and dynamically adjust
> > guest workloads in order to minimize power consumption of the
> > host.
> 
> For cloud use-case, host side is likely in a better position
> to accomplish the task of saving power by migrating VM to
> another socket/host to compact idle load. (I've found at least 1
> kubernetis tool[1], which does energy monitoring). Perhaps there
> are schedulers out there that do that using its data.

The host admin can merely shuffle workloads around, hoping that
a different packing of workloads onto machines, will reduce power
in some aount. You might win a few %, or low 10s of % with this
if you're good at it.

The guest admin can change the way their workload operates to
reduce its inherant power consumption baseline. You could easily
come across ways to win high 10s of % with this. That's why it
is interesting to expose power consumption info to the guest
admin.

IOW, neither makes the other obsolete, both approaches are
desirable.

> > The guest workloads can impose non-negligble power consumption
> > loads on non-vCPU threads in QEMU. Without that accounted for,
> > any adjustments will be working from (sometimes very) inaccurate
> > data.
> 
> Perhaps adding one or several energy sensors (ex: some i2c ones),
> would let us provide auxiliary threads consumption to guest, and
> even make it more granular if necessary (incl. vhost user/out of
> process device models or pass-through devices if they have PMU).
> It would be better than further muddling vCPUs consumption
> estimates with something that doesn't belong there.

There's a tradeoff here in that info directly associated with
backends threads, is effectively exposing private QEMU impl
details as public ABI. IOW, we don't want too fine granularity
here, we need it abstracted sufficiently, that different
backend choices for a given don't change what sensors are
exposed.

I also wonder how existing power monitoring applications
would consume such custom sensors - is there sufficient
standardization in this are that we're not inventing
something totally QEMU specific ?

> > IOW, I think it is right to include non-vCPU threads usage in
> > the reported info, as it is still fundamentally part of the
> > load that the guest imposes on host pCPUs it is permitted to
> > run on.
> 
> 
> From what I've read, process energy usage done via RAPL is not
> exactly accurate. But there are monitoring tools out there that
> use RAPL and other sources to make energy consumption monitoring
> more reliable.
> 
> Reinventing that wheel and pulling all of the nuances of process
> power monitoring inside of QEMU process, needlessly complicates it.
> Maybe we should reuse one of existing tools and channel its data
> through appropriate QEMU channels (RAPL/emulated PMU counters/...).

Note, this feature is already released in QEMU 9.1.0.

> Implementing RAPL in pure form though looks fine to me,
> so the same tools could use it the same way as on the host
> if needed without VM specific quirks.

IMHO the so called "pure" form is misleading to applications, unless
we first provided  some other pratical way to expose the data that
we would be throwing away from RAPL.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


