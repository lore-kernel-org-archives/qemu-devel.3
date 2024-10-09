Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003B8CEE343
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 20:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sycqy-0007YB-20; Wed, 09 Oct 2024 16:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sycqv-0007Wv-Bx
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 16:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sycqt-00040H-8P
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 16:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728504004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4X6HjnXe9MyJ7kOIonXr2IedQ9tDn72mTp4fhP/tbcs=;
 b=Q4FCQLB1ZBY9TXwuOpC7rI1eHsg5HGz7xGS2F31c4cyeXB7xwI8THCdtM4c7XiwWAbO79h
 BzIo9hELIRDdtnSE1ngBHX/7vyAL+L1VqD8wDrdg+200fiA7OY8qY8RSWqm67DDa1lryL2
 dxAn9ojE85hUKkqyX6X4Cf8gKgkVuDE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-cfcDH5lKPnWpNzY_Cw1BCA-1; Wed, 09 Oct 2024 15:59:59 -0400
X-MC-Unique: cfcDH5lKPnWpNzY_Cw1BCA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cb2e0f3242so2482726d6.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 12:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728503999; x=1729108799;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4X6HjnXe9MyJ7kOIonXr2IedQ9tDn72mTp4fhP/tbcs=;
 b=JfM+xWbAkpFBQdTmdHeLOrTrK+PmBNwcxfbAYpEiUIsuXAxpeQ7DYz8CgllTM+zKKS
 XpciT4M3auRztr/hI+IlTX3iMbo8bWaJPS1gvpKKyeBvPBTyeZzZp7y3ezTROMz8TSuy
 RamBQQ1SUhRUXl1rz7rCACQaE1Pv26UqFeF6Xe8LIBDFgO52fajVQyDNBq6rVMtHCYMC
 ejKG5WlJ9o2wCLf45bruVPiLNXAoWzd+3MHfK5We1kFjbkZLZkMPCcT45RGEtOdlk0TU
 VeOFMlnoC4ohwSsZpTTyvoL/Xrh9Jr0tP4aqXviQ2bPmbpA1wV32Oli/HvfxMmYCWAnM
 fwoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2+7RznPkQWFbrRkbq1eVlVpxNUUhcueSF0B1IqILY8gxXSfFuSMiuHcYekt7ZDzYYx6kSjwqw35RD@nongnu.org
X-Gm-Message-State: AOJu0Yz+NBMBTfD+sflCFReYYo/eyA5ApiL/GsZO42SdKtRle4EJbIE8
 K+tK9ffH4AMAjq5lkiO0GaRNgyJD7Yoa0IY15j9yqBHvsfGS/Wd15LgB8uNOp+XK4uoyy1em/Zb
 a6RJQUCXmNRzy7VONqpXTcx73ompQVUoBBcS7grieZ+/rcDeoTquX
X-Received: by 2002:a05:6214:419d:b0:6cb:904c:478d with SMTP id
 6a1803df08f44-6cbc942f026mr53635186d6.16.1728503998995; 
 Wed, 09 Oct 2024 12:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlAlwhXHxfBXUCBc1w/Bo0KGAgeaJCz/m/KgTkn1onJnP77rW78qWlANrIm5edzgx9AzCwLA==
X-Received: by 2002:a05:6214:419d:b0:6cb:904c:478d with SMTP id
 6a1803df08f44-6cbc942f026mr53634596d6.16.1728503998461; 
 Wed, 09 Oct 2024 12:59:58 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbd52c47dasm4635336d6.104.2024.10.09.12.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 12:59:58 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:59:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
Message-ID: <Zwbgur3d0cImLV99@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n>
 <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n>
 <877caitno5.fsf@suse.de> <ZwWMj4FYYpOSnPbe@x1n>
 <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
 <ZwbUTXCxxl4heZYV@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwbUTXCxxl4heZYV@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 09, 2024 at 03:06:53PM -0400, Peter Xu wrote:
> On Wed, Oct 09, 2024 at 02:43:44PM -0400, Steven Sistare wrote:
> > On 10/8/2024 3:48 PM, Peter Xu wrote:
> > > On Tue, Oct 08, 2024 at 04:11:38PM -0300, Fabiano Rosas wrote:
> > > > As of half an hour ago =) We could put a feature branch up and work
> > > > together, if you have more concrete thoughts on how this would look like
> > > > let me know.
> > > 
> > > [I'll hijack this thread with one more email, as this is not cpr-relevant]
> > > 
> > > I think I listed all the things I can think of in the wiki, so please go
> > > ahead.
> > > 
> > > One trivial suggestion is we can start from the very simple, which is the
> > > handshake itself, with a self-bootstrap protocol, probably feature-bit
> > > based or whatever you prefer.  Then we set bit 0 saying "this QEMU knows
> > > how to handshake".
> > > 
> > > Comparing to the rest requirement, IMHO we can make the channel
> > > establishment the 1st feature, then it's already good for merging, having
> > > feature bit 1 saying "this qemu understands named channel establishment".
> > > 
> > > Then we add new feature bits on top of the handshake feature, by adding
> > > more feature bits.  Both QEMUs should first handshake on the feature bits
> > > they support and enable only the subset that all support.
> > > 
> > > Or instead of bit, feature strings, etc. would all work which you
> > > prefer. Just to say we don't need to impl all the ideas there, as some of
> > > them might take more time (e.g. device tree check), and that list is
> > > probably not complete anyway.
> > 
> > While writing a qtest for cpr-transfer, I discovered a problem that could be
> > solved with an early migration handshake, prior to cpr_save_state / cpr_load_state.
> > 
> > There is currently no way to set migration caps on dest qemu before starting
> > cpr-transfer, because dest qemu blocks in cpr_state_load before creating any
> > devices or monitors. It is unblocked after the user sends the migrate command
> > to source qemu, but then the migration starts and it is too late to set migration
> > capabilities or parameters on the dest.
> > 
> > Are you OK with that restriction (for now, until a handshake is implemented)?
> > If not, I have a problem.
> > 
> > I can hack the qtest to make it work with the restriction.
> 
> Hmm, the test case is one thing, but if it's a problem, then.. how in real
> life one could set migration capabilities on dest qemu for cpr-transfer?
> 
> Now a similar question, and also what I overlooked previously, is how
> cpr-transfer should support "-incoming defer".  We need that because that's
> what Libvirt uses.. with an upcoming migrate_incoming QMP command.

Just to share some more thoughts below..

So fundamentally the question is whether there's some way cpr can have a
predictable window on dest qemu that we know QMP is ready, but before
incoming migration starts.

With current design, incoming side will sequentially do: (1) cpr-uri
load(), (2) initialize rest of QEMU (migration, qmp, devices, etc.), (3)
listen port ready, then (4) close(), aka, HUP.  Looks like steps 1-4 will
have no way to control when kicked off, so after cpr-uri save() data dump
they'll happen in one shot.

It might make sense because we assumed load() of cpr-uri is during the
blackout window, and enlarge that is probably not good.

But.. why do we keep cpr_state_save/load() in the blackout window?  AFAIU
they're mostly the fds sharing so they can happen with VM still running on
src, right?

I still remember the vhost/tap issue you mentioned, but I wonder whether
that'll ever change the vhost/tap fd at all if we forbid any device change
like what we do with normal migrations. IOW, I wonder whether we can still
do the cpr_state_save/load() always during VM running (but it should still
be during an ACTIVE migration, IOW, device hotplug and stuff should be
forbidden, just like a live precopy phase).

Iff that works, then maybe there's a way out: we can make cpr-transfer two
steps:

  - DST: start QEMU dest the same, with -cpr-uri XXX, but now let's assume
    it's with -incoming defer just to give an example, and no migration
    capabilities applied yet.

  - SRC: send 'migrate' QMP command, qemu should see that cpr-transfer is
    enabled, so it triggers sending cpr states to destination only.  It
    doesn't run the rest migration logic.

    During this stage src VM will always be running, we need to make sure
    migration state machine start running (perhaps NONE->SETUP_CPR) so
    device plug/unplug will be forbidden like what happens with generic
    precopy, so as to stablize fds.  Just need to make sure
    migration_is_running() returns true.

  - DST: receives all cpr states.  When complete, it keeps running, no HUP
    is needed this time, because it'll wait for another "migrate_incoming".

    In the case of "-incoming unix:XXX" in qemu cmdline, it'll directly go
    into the listen code and wait, but still we don't need the HUP because
    we're not in blackout window, and src won't connect automatically but
    requires a command later from mgmt (see below).

  - DST: the mgmt can send whatever QMP command to dest now, including
    setup incoming port, setup migration capabilities/parameters if needed.
    Src is still running, so it can be slow.

  - SRC: do the real migration with another "migrate resume=true" QMP
    command (I simply reused postcopy's resume flag here).  This time src
    qemu should notice this is a continuation of cpr-transfer migration,
    then it moves that on (SETUP_CPR->ACTIVE), migrate RAM/device/whatever
    is left.  Same to generic migration, until COMPLETED.

Not sure whether it'll work.  We'll need to still properly handle things
like migrate_cancel, etc, when triggered during SETUP_CPR state, but
hopefully not complicated to do..

-- 
Peter Xu


