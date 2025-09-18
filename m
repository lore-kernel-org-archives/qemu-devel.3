Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361BCCA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 14:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzFRh-0005wP-Nt; Thu, 18 Sep 2025 10:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uzFRc-0005vF-A1
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uzFRZ-0000Yw-I9
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758205022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OIsP9TPx87p4QUtmgrg/3bbFIhAKEMjvE168VeV1IA=;
 b=EI0REajqEz1mZvcy2CKYHHCRLgUvY8CVDQtIVplRbYcM3d8VlZui4gY6h//kQZOj7zZMYB
 h4jvxRt/hYOWDI18Nm5Y+pNTW4iMpduZKAb32V4Sm5WYLW1M1l5I+8lBMGqzceuOyj5kZi
 WwACiyY9fnBEHbHsAob7phHSFLlwtfY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-OkpXpxqDNiew3xJ3pFzegQ-1; Thu, 18 Sep 2025 10:17:01 -0400
X-MC-Unique: OkpXpxqDNiew3xJ3pFzegQ-1
X-Mimecast-MFC-AGG-ID: OkpXpxqDNiew3xJ3pFzegQ_1758205020
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45f2b9b99f0so6320295e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 07:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758205020; x=1758809820;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0OIsP9TPx87p4QUtmgrg/3bbFIhAKEMjvE168VeV1IA=;
 b=QY53vHcyuH7MRZg7btkrSSmxlavueQgUDOQbo8mS93pNaOSXLjuoCF9wITTSlpJXWk
 xiQNAY2C7k+ptulsiLJ5amuKyi4tQcVk72/cBjnRXsPEp2DC1eIc1L/zJRP0cBULBJh6
 FlqFvUcid+lNe0l2MBc+4tRWeQ5wmyKAB5lykltzmfHEg7VgWPPoDJA7wVeQCEmskLnp
 pSnAK9G/rXylxsi0TFN/n/9ZCb/wicBAn2gLAezEh+H3t7Dz5/+o/TZxto6TI71FR+O+
 NhyOXsFEi+k3vXCa7GobsSbVz94FEWw1gZaLqk+IzPMc168Cxd0qo9bHuJuKAgFn8uCA
 /bUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUovT8cKtpU8wldwe1cqa22+J32G9Qc0OeKLOolHPtODmivCuqnPkMto9gRyUcKEGJH8GYCqCJAbzIA@nongnu.org
X-Gm-Message-State: AOJu0Yx5XQXcbwy1w0Xpof01W39TCDnnyJ0oVxVo06feiMIMhrHCSb+x
 TInZTCMfKfleyMplgAcCawat/rF7buf9bvJLavbSZRIOqT1Aroy75MnAWwPZlCdRiYrDL0kxd6Z
 RX2fZZV4NjOZsvFHlcVNFX4GgizclRIbhZHvGy16RydTfswZK894LUwUW
X-Gm-Gg: ASbGncvhNuc57jzU1g9x47QNNxha4YS8siK2s/Q1KVozBOIbNfx4q+bSPrsZb3etcf9
 1Nm5X7aWeI20XMhQGQbEB4409dRdw/EhwLTv+0zvFeo33V0hXntP4sVqPXJC3hv7kiOK+M4s8xs
 mmGIXqaEipzIVvM31Q3UWAEml3iXR7105NG5/SvKaw8eqlmM87mBiwcuuD7hXalz+WUGviAmbm6
 yXBO3eTYJmBzh2SBMI59TJsOZJqVXblstEZ5azSTM7eMlec3eJRuD1tDd6d8Xk70fBfm1AXJrI8
 ivW4XhYChfHwpltJmHP803kyhgiFTA==
X-Received: by 2002:a05:600c:c16b:b0:45d:e775:d8b8 with SMTP id
 5b1f17b1804b1-464f7027f08mr35020765e9.1.1758205019667; 
 Thu, 18 Sep 2025 07:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjpE3Y0vnFnByoyHLbAsBrEF/0+RXfD51T5vEfmaiZXw3cEZzjBbF6fD+NqctnV2/ps5Uz8A==
X-Received: by 2002:a05:600c:c16b:b0:45d:e775:d8b8 with SMTP id
 5b1f17b1804b1-464f7027f08mr35020345e9.1.1758205019091; 
 Thu, 18 Sep 2025 07:16:59 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f32114c62sm62290655e9.2.2025.09.18.07.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 07:16:58 -0700 (PDT)
Date: Thu, 18 Sep 2025 16:16:56 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <r2tnbymosv7kxj7h4x6mnrczy7jdn66voiodlakivovu7lhwv4@eudkicvqwefc>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
 <aMBDIwKDxTVrBJBQ@redhat.com> <aMCjGVUiM3MY-RM3@x1.local>
 <aMEkY3N9ITwH_Y8Z@redhat.com> <aMGpHBGth05JY2hl@x1.local>
 <aMPz0WFmstNmKBQc@redhat.com> <aMQ19NmgFkLs8jkA@x1.local>
 <aMhZn-fbq67WQX8u@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMhZn-fbq67WQX8u@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel and all,

On 2025-09-15 19:23, Daniel P. Berrangé wrote:
> On Fri, Sep 12, 2025 at 11:02:12AM -0400, Peter Xu wrote:
> > On Fri, Sep 12, 2025 at 11:20:01AM +0100, Daniel P. Berrangé wrote:
> > > On Wed, Sep 10, 2025 at 12:36:44PM -0400, Peter Xu wrote:
> > > > On Wed, Sep 10, 2025 at 08:10:57AM +0100, Daniel P. Berrangé wrote:
> > > > > On Tue, Sep 09, 2025 at 05:58:49PM -0400, Peter Xu wrote:
> > > > > > On Tue, Sep 09, 2025 at 04:09:23PM +0100, Daniel P. Berrangé wrote:
> > > > > > > On Tue, Sep 09, 2025 at 05:01:24PM +0200, Juraj Marcin wrote:
> > > > > > > > From: Juraj Marcin <jmarcin@redhat.com>
> > > > > > > > 
> > > > > > > > Usual system defaults for TCP keep-alive options are too long for
> > > > > > > > migration workload. On Linux, a TCP connection waits idle for 2 hours
> > > > > > > > before it starts checking if the connection is not broken.
> > > > > > > > 
> > > > > > > > Now when InetSocketAddress supports keep-alive options [1], this patch
> > > > > > > > applies migration specific defaults if they are not supplied by the user
> > > > > > > > or the management software. With these defaults, a migration TCP stream
> > > > > > > > waits idle for 1 minute and then sends 5 TCP keep-alive packets in 30
> > > > > > > > second interval before considering the connection as broken.
> > > > > > > > 
> > > > > > > > System defaults can be still used by explicitly setting these parameters
> > > > > > > > to 0.
> > > > > > > 
> > > > > > > IMHO this is not a good idea. This is a very short default, which
> > > > > > > may be fine for the scenario where your network conn is permanently
> > > > > > > dead, but it is going to cause undesirable failures when the network
> > > > > > > conn is only temporarily dead.
> > > > > > > 
> > > > > > > Optimizing defaults for temporary outages is much more preferrable
> > > > > > > as that maximises reliability of migration. In the case of permanent
> > > > > > > outages, it is already possible to tear down the connection without
> > > > > > > waiting for a keep-alive timeout, and liveliness checks can also be
> > > > > > > perform by the mgmt app at a higher level too. The TCP keepalives
> > > > > > > are just an eventual failsafe, and having those work on a long
> > > > > > > timeframe is OK.
> > > > > > 
> > > > > > For precopy it looks fine indeed, because migrate_cancel should always work
> > > > > > on src if src socket hanged, and even if dest QEMU socket hanged, it can
> > > > > > simply be killed if src QEMU can be gracefully cancelled and rolled back to
> > > > > > RUNNING, disregarding the socket status on dest QEMU.
> > > > > > 
> > > > > > For postcopy, we could still use migrate_pause to enforce src shutdown().
> > > > > > Initially I thought we have no way of doing that for dest QEMU, but I just
> > > > > > noticed two years ago I added that to dest QEMU for migrate_paused when
> > > > > > working on commit f8c543e808f20b..  So looks like that part is covered too,
> > > > > > so that if dest QEMU socket hanged we can also kick it out.
> > > > > > 
> > > > > > I'm not 100% sure though, on whether shutdown() would always be able to
> > > > > > successfully kick out the hanged socket while the keepalive is ticking.  Is
> > > > > > it guaranteed?
> > > > > 
> > > > > I don't know about shutdown(), but close() certainly works. If shutdown()
> > > > > is not sufficient, then IMHO the migration code would need the ability to
> > > > > use close() to deal with this situation.
> > > > > 
> > > > > 
> > > > > > I also am not sure if that happens, whether libvirt would automatically do
> > > > > > that, or provide some way so the user can trigger that.  The goal IIUC here
> > > > > > is we shouldn't put user into a situation where the migration hanged but
> > > > > > without any way to either cancel or recover.  With the default values Juraj
> > > > > > provided here, it makes sure the hang won't happen more than a few minutes,
> > > > > > which sounds like a sane timeout value.
> > > > > 
> > > > > Sufficient migration QMP commands should exist to ensure migration can
> > > > > always be cancelled. Short keepalive timeouts should not be considered
> > > > > a solution to any gaps in that respect.
> > > > > 
> > > > > Also there is yank, but IMHO apps shouldn't have to rely on yank - I see
> > > > > yank as a safety net for apps to workaround limitations in QEMU.
> > > > 
> > > > The QMP facility looks to be all present, which is migrate-cancel and
> > > > migrate-pause mentioned above.
> > > > 
> > > > For migrate_cancel (of precopy), is that Ctrl-C of "virsh migrate"?
> > > > 
> > > > Does libvirt exposes migrate_pause via any virsh command?  IIUC that's the
> > > > only official way of pausing a postcopy VM on either side.  I also agree we
> > > > shouldn't make yank the official tool to use.
> > > 
> > > virsh will call virDomainAbortJob when Ctrl-C is done to a 'migrate'
> > > command.
> > > 
> > > virDomainAbortJob will call migrate-cancel for pre-copy, or
> > > 'migrate-pause' for post-copy.
> > 
> > Would it call "migrate-pause" on both sides?
> 
> Not 100% sure, but with virDomainAbortJob I think libvirt only calls
> migrate-pause on the source host.
> 
> > I believe the problem we hit was, when during postcopy and the NIC was
> > misfunctioning, src fell into postcopy-paused successfully but dest didn't,
> > stuck in postcopy-active.
> 
> If something has interrupted src<->dst host comms for QEMU it may well
> impact libvirt <-> libvirt comms too, unless migration was being done
> over a separate NIC than the mgmt LAN.  IOW, it may be impossible for
> libvirt to call migrate-pause on both sides, at least not until the
> NIC problem has been resolved.
> 
> > We'll want to make sure both sides to be kicked into paused stage to
> > recover.  Otherwise dest can hang in the stage for hours until the watchdog
> > timeout triggers.
> 
> Once the network problem has been resolved, then it ought to be possible
> to get libvirt to issue 'migrate-pause' on both hosts, and thus be able
> to recover.
> 
> Possibly the act of starting migration recovery in libvirt should attempt
> to issue 'migrate-pause' to cleanup the previously running migration if
> it is still in the stuck state.
> 
> > 
> > > 
> > > 
> > > > OTOH, the default timeouts work without changing libvirt, making sure the
> > > > customers will not be stuck in a likely-failing network for hours without
> > > > providing a way to properly detach and recover when it's wanted.
> > > 
> > > "timeouts work" has the implicit assumpton that the only reason a
> > > timeout will fire is due to a unrecoverable situation. IMHO that
> > > assumption is not valid.
> > 
> > I agree adjusting timeout is not the best.
> > 
> > If we can have solid way to kick two sides out, I think indeed we don't
> > need to change the timeout.
> > 
> > If not, we may still need to provide a way to allow user to try continue
> > when the user found that the network is behaving abnormal.
> > 
> > Here adjusting timeout is slightly better than any adhoc socket timeout
> > that we'll adjust: it's the migration timeout, and we only have two cases:
> > (1) precopy, which is ok to fail and retried, (2) postcopy, which is also
> > ok to fail and recovered.
> 
> Fail & retry/recover is not without cost / risk though. Users can have
> successful migrations that are many hours long when dealing with big
> VMs. IOW, returning to the start of pre-copy could be a non-trivial
> time delay.
> 
> Consider if the reason for the migration is to evacuate workloads off
> a host that is suffering technical problems. It could well be that
> periodic unexpected network outages are what is triggering the need
> to evacuate workloads. If we timeout a migration with keepalives they
> may never be able to get through a migration op quickly enough, or
> they can be delayed such that the host has a fatal error loosing the
> workload before the retried migration is complete.
> 
> IMHO, once a migration has been started we should not proactively
> interrupt that with things like keepalives, unless the admin made a
> concious decision they wanted that behaviour enabled.
>

maybe I should reiterate on the original problem this is trying to
solve. I have also talked to @jdenemar how libvirt currently handles
such things (but if I still missed something, please correct me).

If there is no outgoing traffic from the destination side (this can be
caused for example by a workload with no page faults or paused machine),
QEMU has no way of knowing if the connection is still working or not.
The TCP stack doesn't treat no incoming traffic as a sign of a broken
connection. Therefore, QEMU would stay in postcopy-active waiting for
pages indefinitely.

Also, libvirt might not be aware of a connection dropout between QEMUs,
if libvirt's connection is intact, especially if libvirt daemons are
communicating through some central entity that is managing the migration
and not directly. And to do postcopy migration recovery, libvirt needs
both sides to be in postcopy-paused state.

Alternatively, there also might be an issue with the connection between
libvirt daemons, but not the migration connection. Even if the libvirt
connection fails, the migration is not paused, rather libvirt lets the
migration finish normally. Similarly, if the libvirt connection is
broken up due to, for example, libvirt daemon restart, the ongoing
migration is not paused, but after the libvirt daemon starts again, it
sees an ongoing migration and lets it finish.

Additionally, libvirt uses its own internal keep-alive packets with much
more aggressive timeouts, waiting 5 - 10 seconds idle before sending a
keep-alive packet and then killing the connection if there is no
response in 30 seconds.

I think, if we enable keep-alive in QEMU, but let the default timeouts
be longer, for example idle time of 5 minutes and 15 retries in 1 minute
intervals (which would mean, that connection would be considered broken
after 20 minutes of unsuccessful communication attempts), that would be
an acceptable solution.

Finally, normal TCP packets already have a default system timeout and
limited retransmission attempts, so if a TCP packet cannot be delivered
in 20 minutes (or even less)[1], the whole connection times out and the
migration is paused/cancelled. So, this patch doesn't really introduce
any new or uncommon behavior, just merely tries to make both scenarios
(with dst->src traffic and without dst->src traffic) behave similarly -
they would time out after some time.

[1] Linux man-pages, tcp(7) on TCP timeouts: "Otherwise, failure may
    take up to 20 minutes with the current system defaults in a normal
    WAN environment."


Best regards,

Juraj Marcin

> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 


