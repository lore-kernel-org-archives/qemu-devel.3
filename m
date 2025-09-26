Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DBDCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2A7j-0002Kz-Ng; Fri, 26 Sep 2025 11:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2A7e-0002Jo-7H
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2A7a-0004Wz-M0
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758899546;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxgggfqQ4UUnuDlxz53/dtmyD6yUdZkhScBhNkYEio8=;
 b=DZqQ7xvo4mswbUZL77zoDVXsUnh4NqWQKQTaUZDEHx3Te/bG+tq6f+7x2nTZGh1ehXRWgr
 IPwbH2MetqyoDEw5D0t/C0dz58C8eC6vTM+0QuZrEPnTRp+jzHUhn+UQvcv4NjRDNLhQLU
 PtajZnH8iqD1JA8yINWk0UNJXF+u9+w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-sOpALhTqPMezvoeggXRqRg-1; Fri,
 26 Sep 2025 11:12:22 -0400
X-MC-Unique: sOpALhTqPMezvoeggXRqRg-1
X-Mimecast-MFC-AGG-ID: sOpALhTqPMezvoeggXRqRg_1758899541
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E356197740B; Fri, 26 Sep 2025 15:12:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCC1A19540EB; Fri, 26 Sep 2025 15:12:16 +0000 (UTC)
Date: Fri, 26 Sep 2025 16:12:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Markus Armbruster <armbru@redhat.com>, imammedo@redhat.com,
 philmd@linaro.org, jdenemar@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] hw/i386/isapc.c: remove support for -cpu host and
 -cpu max
Message-ID: <aNatTdDfJw4FL4Is@redhat.com>
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20250925160453.2025885-2-mark.caveayland@nutanix.com>
 <87wm5lo37q.fsf@pond.sub.org> <aNaJl3J5dZEt6n4_@redhat.com>
 <70ff12c0-9ed7-4c19-a7cb-d14a5176d3f7@nutanix.com>
 <aNabaxWyioLXgfFH@redhat.com>
 <0c125c3e-001c-40fc-b2d9-7ef3c1d0451d@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c125c3e-001c-40fc-b2d9-7ef3c1d0451d@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 26, 2025 at 04:01:23PM +0100, Mark Cave-Ayland wrote:
> On 26/09/2025 14:55, Daniel P. Berrangé wrote:
> 
> > On Fri, Sep 26, 2025 at 02:49:00PM +0100, Mark Cave-Ayland wrote:
> > > On 26/09/2025 13:39, Daniel P. Berrangé wrote:
> > > 
> > > > On Fri, Sep 26, 2025 at 01:36:25PM +0200, Markus Armbruster wrote:
> > > > > Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
> > > > > 
> > > > > > Following recent discussions on the mailing list, it has been decided
> > > > > > that instead of mapping -cpu host and -cpu max to a suitable 32-bit x86 CPU,
> > > > > > it is preferable to disallow them and use the existing valid_cpu_types
> > > > > > validation logic so that an error is returned to the user instead.
> > > > > > 
> > > > > > Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > > > > > ---
> > > > > >    hw/i386/isapc.c | 27 ---------------------------
> > > > > >    1 file changed, 27 deletions(-)
> > > > > > 
> > > > > > diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
> > > > > > index 44f4a44672..6c35a397df 100644
> > > > > > --- a/hw/i386/isapc.c
> > > > > > +++ b/hw/i386/isapc.c
> > > > > > @@ -41,31 +41,6 @@ static void pc_init_isa(MachineState *machine)
> > > > > >        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> > > > > >        int i;
> > > > > > -    /*
> > > > > > -     * There is a small chance that someone unintentionally passes "-cpu max"
> > > > > > -     * for the isapc machine, which will provide a much more modern 32-bit
> > > > > > -     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
> > > > > > -     * been specified, choose the "best" 32-bit cpu possible which we consider
> > > > > > -     * be the pentium3 (deliberately choosing an Intel CPU given that the
> > > > > > -     * default 486 CPU for the isapc machine is also an Intel CPU).
> > > > > > -     */
> > > > > > -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
> > > > > > -        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
> > > > > > -        warn_report("-cpu max is invalid for isapc machine, using pentium3");
> > > > > > -    }
> > > > > > -
> > > > > > -    /*
> > > > > > -     * Similarly if someone unintentionally passes "-cpu host" for the isapc
> > > > > > -     * machine then display a warning and also switch to the "best" 32-bit
> > > > > > -     * cpu possible which we consider to be the pentium3. This is because any
> > > > > > -     * host CPU will already be modern than this, but it also ensures any
> > > > > > -     * newer CPU flags/features are filtered out for older guests.
> > > > > > -     */
> > > > > > -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
> > > > > > -        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
> > > > > > -        warn_report("-cpu host is invalid for isapc machine, using pentium3");
> > > > > > -    }
> > > > > > -
> > > > > >        if (machine->ram_size > 3.5 * GiB) {
> > > > > >            error_report("Too much memory for this machine: %" PRId64 " MiB, "
> > > > > >                         "maximum 3584 MiB", machine->ram_size / MiB);
> > > > > > @@ -162,8 +137,6 @@ static void isapc_machine_options(MachineClass *m)
> > > > > >            X86_CPU_TYPE_NAME("pentium2"),
> > > > > >            X86_CPU_TYPE_NAME("pentium3"),
> > > > > >            X86_CPU_TYPE_NAME("qemu32"),
> > > > > > -        X86_CPU_TYPE_NAME("max"),
> > > > > > -        X86_CPU_TYPE_NAME("host"),
> > > > > >            NULL
> > > > > >        };
> > > > > >        PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> > > > > 
> > > > > This reverts the "smart" part of recent
> > > > > 
> > > > > commit e1e2909f8e74051a34a044940f90d4650b6e784a
> > > > > Author: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > > > > Date:   Thu Aug 28 12:09:44 2025 +0100
> > > > > 
> > > > >       hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
> > > > >       The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
> > > > >       possible to specify any CPU via -cpu on the command line, it makes no
> > > > >       sense to allow modern 64-bit CPUs to be used.
> > > > >       Restrict the isapc machine to the available 32-bit CPUs, taking care to
> > > > >       handle the case where if a user inadvertently uses either -cpu max or
> > > > >       -cpu host then the "best" 32-bit CPU is used (in this case the pentium3).
> > > > 
> > > > What is written here made sense from the POV of use of isapc with
> > > > qemu-system-x86_64, but in qemu-system-i686, both 'max' and 'host'
> > > > where already 32-bit CPUs IIUC. Both this original patch and
> > > > the new patch block them from being used in qemu-system-i686
> > > > which feels wrong given the justification above.
> > > 
> > > I tried stepping through with -cpu host/-cpu max on qemu-system-i386 and
> > > it's a bit confusing: I think we end up with some kind of custom AMD vendor
> > > CPU but with LM disabled. I can't easily see a way to understand what
> > > features are currently enabled?
> > > 
> > > I must admit I'm struggling to see the usefulness of -cpu host/-cpu max for
> > > isapc given that older OSs can be quite picky when it comes to hardware.
> > 
> > But x86 CPU vendors go to ridiculous levels of complexity to retain
> > historical back compat over many decades. If anything, I'd be surprised
> > about the opposite - an OS that didn't work with -cpu max.
> 
> It's not the CPU vendor I'd be worried about, but the OS vendor who may for
> example execute CPUID and become confused if it returns an AMD vendor ID
> instead of an Intel vendor ID.

IIRC/IIUC, AMD sold i486 CPUs with CPUID present in the ISA era, so I
would have thought anything checking vendor ID should expect to see
more than just Intel ?

> What do you think is the best way forward? I'm still not convinced of the
> utility of -cpu host/-cpu max for isapc, so what if instead of mapping them
> to the pentium3 CPU we follow the standard deprecation path and emit a
> warning on startup, and then remove them from valid_cpu_types in 2 releases
> time? The advantage to this approach is that if people are actually using
> -cpu host/-cpu max with the isapc machine then they would at least file an
> issue in Gitlab and make us aware of it.

If we want to deprecate it the formal route, that's fine.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


