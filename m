Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0B6CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 15:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux5If-0007r8-Vm; Fri, 12 Sep 2025 11:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ux5IH-0007lh-De
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ux5IE-0001Mj-QX
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757689348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDxmmQsdbNV57qc1x1BPb7pLiW147Xk9IM+S2sdl7nY=;
 b=Gq32Pgmpav5ChRxgSS2+H+YwV4dAnPwaNeeSbm6RMeYVLesLSBiW8mdxVFFB/j+K5CZRRp
 njxprUuhqTGXUwC9oOvxXKf+P+TqimFsnuYNyHMyKTKTUxFFkNas+VX45RgVfn4pDpOOAY
 ToXO61WMijQ1fHny34pVOhLKRBgEK8I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-CBYHx_DdMBiAEdVbem6Qzw-1; Fri, 12 Sep 2025 11:02:27 -0400
X-MC-Unique: CBYHx_DdMBiAEdVbem6Qzw-1
X-Mimecast-MFC-AGG-ID: CBYHx_DdMBiAEdVbem6Qzw_1757689346
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-81b8e3e2a5dso520138585a.1
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 08:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757689346; x=1758294146;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xDxmmQsdbNV57qc1x1BPb7pLiW147Xk9IM+S2sdl7nY=;
 b=uSbxHmnC4XBeSEOjtEPUBtuSg5EGl2jIvjt90DDsf092LLCfHZq51OaIwFBZIhQRYj
 Nu3k0gwHdj7kQ6FE88AXxXcxDkGeczWCHQAIc4oVal/QuO3m60dwrIDeWYhrVzbrvrIw
 cyY2se4gZnOJo+JyYyBlR+NeYUTD0AcbVy1AsGkhUps8T/4h2uZ1Hc9LWSbY6rBuE+6K
 jkkoZ7uLQZ07b3YCz+ACvuA/VQBA8RZbovgz9r8Zix+klFeVFxmTYGKM01HW3KF9KvU5
 RPslCBliyP+RCGKsyJ2NIPkmKNR7JMEgAbVkWLYU/L8u1b14lEpOK2y8X3z6dfBqtBnJ
 2GRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD6M9P1ImAwZniYMTD5lpk5USNqxykXLyLPPjw5D9lBh5JeM8J+NTntdVEy3vTsTQofJwO3R6DVDnA@nongnu.org
X-Gm-Message-State: AOJu0YwVeoK8mb47+eCxBA8WUpNudvGBU8uNMKRZyKCXBPJUqJhloTwM
 0/wXFhkH++T2w5Wi9lLcEkQVNxtdIQhYlRye/qfhV+MNmG/UGEsNLTAy8hqLH+wf36p5SLoEHll
 u7MUORXWUMfnemNOm60d/TcS/G6nje9FEzgSX+5CMx3YyL+xZXuTr40d+
X-Gm-Gg: ASbGnctKZvfBBKmwAs4ekeeAFFT5ry2QdcK2UAJXeeGhaGEXSF62n/IWkrK0Kuztm3l
 iUPlje4lcJVYqSnlp9QBWLgjFBCE7Vmv/9D7xYq6UH4bEgKXbQs9FhGLl2m/G67YPcTViFES3sj
 AuZWxRwm9ylf4qS07FgjSOPwvzLrkiu6KQGy+/XbTDJLTeLswIeaU6DtUmNKY3srMTotpMj5IVO
 l0wlw3xM7P5Y5v6HLjT3IHcZS4hu+mcWBDRd+Vb+xEqnx/VNssaoWWMSWAGeRnKheibgLT807sl
 1uMW5j8lnTEA8Pi81Gvp/eV/7JYWsfl8
X-Received: by 2002:a05:620a:bc2:b0:816:492c:875a with SMTP id
 af79cd13be357-824017b0159mr346070085a.78.1757689346151; 
 Fri, 12 Sep 2025 08:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV3o/+NhbEdQ5mGCCB39UvAJmhQKSdEiegiJ436g/lOM2HDc2rsmY8jmyDkdzSuDUMits23w==
X-Received: by 2002:a05:620a:bc2:b0:816:492c:875a with SMTP id
 af79cd13be357-824017b0159mr346062985a.78.1757689345354; 
 Fri, 12 Sep 2025 08:02:25 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c8bb8daasm285673085a.6.2025.09.12.08.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 08:02:24 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:02:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aMQ19NmgFkLs8jkA@x1.local>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
 <aMBDIwKDxTVrBJBQ@redhat.com> <aMCjGVUiM3MY-RM3@x1.local>
 <aMEkY3N9ITwH_Y8Z@redhat.com> <aMGpHBGth05JY2hl@x1.local>
 <aMPz0WFmstNmKBQc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMPz0WFmstNmKBQc@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 12, 2025 at 11:20:01AM +0100, Daniel P. Berrangé wrote:
> On Wed, Sep 10, 2025 at 12:36:44PM -0400, Peter Xu wrote:
> > On Wed, Sep 10, 2025 at 08:10:57AM +0100, Daniel P. Berrangé wrote:
> > > On Tue, Sep 09, 2025 at 05:58:49PM -0400, Peter Xu wrote:
> > > > On Tue, Sep 09, 2025 at 04:09:23PM +0100, Daniel P. Berrangé wrote:
> > > > > On Tue, Sep 09, 2025 at 05:01:24PM +0200, Juraj Marcin wrote:
> > > > > > From: Juraj Marcin <jmarcin@redhat.com>
> > > > > > 
> > > > > > Usual system defaults for TCP keep-alive options are too long for
> > > > > > migration workload. On Linux, a TCP connection waits idle for 2 hours
> > > > > > before it starts checking if the connection is not broken.
> > > > > > 
> > > > > > Now when InetSocketAddress supports keep-alive options [1], this patch
> > > > > > applies migration specific defaults if they are not supplied by the user
> > > > > > or the management software. With these defaults, a migration TCP stream
> > > > > > waits idle for 1 minute and then sends 5 TCP keep-alive packets in 30
> > > > > > second interval before considering the connection as broken.
> > > > > > 
> > > > > > System defaults can be still used by explicitly setting these parameters
> > > > > > to 0.
> > > > > 
> > > > > IMHO this is not a good idea. This is a very short default, which
> > > > > may be fine for the scenario where your network conn is permanently
> > > > > dead, but it is going to cause undesirable failures when the network
> > > > > conn is only temporarily dead.
> > > > > 
> > > > > Optimizing defaults for temporary outages is much more preferrable
> > > > > as that maximises reliability of migration. In the case of permanent
> > > > > outages, it is already possible to tear down the connection without
> > > > > waiting for a keep-alive timeout, and liveliness checks can also be
> > > > > perform by the mgmt app at a higher level too. The TCP keepalives
> > > > > are just an eventual failsafe, and having those work on a long
> > > > > timeframe is OK.
> > > > 
> > > > For precopy it looks fine indeed, because migrate_cancel should always work
> > > > on src if src socket hanged, and even if dest QEMU socket hanged, it can
> > > > simply be killed if src QEMU can be gracefully cancelled and rolled back to
> > > > RUNNING, disregarding the socket status on dest QEMU.
> > > > 
> > > > For postcopy, we could still use migrate_pause to enforce src shutdown().
> > > > Initially I thought we have no way of doing that for dest QEMU, but I just
> > > > noticed two years ago I added that to dest QEMU for migrate_paused when
> > > > working on commit f8c543e808f20b..  So looks like that part is covered too,
> > > > so that if dest QEMU socket hanged we can also kick it out.
> > > > 
> > > > I'm not 100% sure though, on whether shutdown() would always be able to
> > > > successfully kick out the hanged socket while the keepalive is ticking.  Is
> > > > it guaranteed?
> > > 
> > > I don't know about shutdown(), but close() certainly works. If shutdown()
> > > is not sufficient, then IMHO the migration code would need the ability to
> > > use close() to deal with this situation.
> > > 
> > > 
> > > > I also am not sure if that happens, whether libvirt would automatically do
> > > > that, or provide some way so the user can trigger that.  The goal IIUC here
> > > > is we shouldn't put user into a situation where the migration hanged but
> > > > without any way to either cancel or recover.  With the default values Juraj
> > > > provided here, it makes sure the hang won't happen more than a few minutes,
> > > > which sounds like a sane timeout value.
> > > 
> > > Sufficient migration QMP commands should exist to ensure migration can
> > > always be cancelled. Short keepalive timeouts should not be considered
> > > a solution to any gaps in that respect.
> > > 
> > > Also there is yank, but IMHO apps shouldn't have to rely on yank - I see
> > > yank as a safety net for apps to workaround limitations in QEMU.
> > 
> > The QMP facility looks to be all present, which is migrate-cancel and
> > migrate-pause mentioned above.
> > 
> > For migrate_cancel (of precopy), is that Ctrl-C of "virsh migrate"?
> > 
> > Does libvirt exposes migrate_pause via any virsh command?  IIUC that's the
> > only official way of pausing a postcopy VM on either side.  I also agree we
> > shouldn't make yank the official tool to use.
> 
> virsh will call virDomainAbortJob when Ctrl-C is done to a 'migrate'
> command.
> 
> virDomainAbortJob will call migrate-cancel for pre-copy, or
> 'migrate-pause' for post-copy.

Would it call "migrate-pause" on both sides?

I believe the problem we hit was, when during postcopy and the NIC was
misfunctioning, src fell into postcopy-paused successfully but dest didn't,
stuck in postcopy-active.

We'll want to make sure both sides to be kicked into paused stage to
recover.  Otherwise dest can hang in the stage for hours until the watchdog
timeout triggers.

> 
> 
> > OTOH, the default timeouts work without changing libvirt, making sure the
> > customers will not be stuck in a likely-failing network for hours without
> > providing a way to properly detach and recover when it's wanted.
> 
> "timeouts work" has the implicit assumpton that the only reason a
> timeout will fire is due to a unrecoverable situation. IMHO that
> assumption is not valid.

I agree adjusting timeout is not the best.

If we can have solid way to kick two sides out, I think indeed we don't
need to change the timeout.

If not, we may still need to provide a way to allow user to try continue
when the user found that the network is behaving abnormal.

Here adjusting timeout is slightly better than any adhoc socket timeout
that we'll adjust: it's the migration timeout, and we only have two cases:
(1) precopy, which is ok to fail and retried, (2) postcopy, which is also
ok to fail and recovered.

The timeout made some corner cases more aggressive to converge to a
failure/retry condition, but since we know exactly the property of the
sockets so it's better than when we know nothing about what the sockets are
used for.

Thanks,

-- 
Peter Xu


