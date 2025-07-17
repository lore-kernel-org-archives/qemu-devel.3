Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE7EC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucJkA-0005H7-Cw; Thu, 17 Jul 2025 04:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucJk3-0005DT-9J
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucJk0-0007q6-Bf
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752739998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WDpDILwzZUkrrQxKj9TLtWpMTSW3/T9PPQRIslPdeeo=;
 b=NV++MaSzYAAjRgWR45eV2m2u+fngukLPzIn8qzQHUp0+1A4Cjd1RYg6vqrXZPA4yzALRig
 9p8msRBOm2n1d+9QEcjRYZYTUfZOdnI07H+szpfAtET6uSmAC1xaQu3EK+NG82+jIZpg6f
 zu8GPNO1bjPzZDGqeGcSmHsfy1Q68BI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-9IIAiturOrORGJ1JG5l7hg-1; Thu, 17 Jul 2025 04:13:17 -0400
X-MC-Unique: 9IIAiturOrORGJ1JG5l7hg-1
X-Mimecast-MFC-AGG-ID: 9IIAiturOrORGJ1JG5l7hg_1752739997
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-235eefe6a8fso5963415ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 01:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752739996; x=1753344796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDpDILwzZUkrrQxKj9TLtWpMTSW3/T9PPQRIslPdeeo=;
 b=F1LUiAhS0GGf8dXn97/fGKy9w8PcGebIMiKC/aNJRw7qWSKLKeycdlb0UOX/Q0+fDC
 A7g+Ji0mMExfO3bfgMw5fVpWz/AH7B51uW23rgUyVR3Qe6kt9ckzGYyzZnf87WWV28zW
 jzpXiby/4dOzSakdCJ0qZoSQXb63z1dvRboIvwzq6wkGq9nGTDpoM1ckGU8c3yiWaANx
 WhNC2GpBOiap92XlF+sbXZeshB3blyz9ypp89ESSnsZq/IuJ5VezFd77UJBX9fDEq7s3
 Y8uB44TYosLKEu3lj6QmyjFGDMw9Y0k4OHdJhjb9Y9bLUChssLi8uUAPuPGV3XtqYA+v
 V1kw==
X-Gm-Message-State: AOJu0YyAkZcX/Dg7UmKzdlT/nP56/JvES+8a1SoTu2NEkfXX8Y62O+Xh
 pR6i8MkuybP2kFI1i9dTnAb+2U8ufLGygKUezZ76lytZL3Oa/cPscauvzV2CkrgB8c0VAJPBA1p
 ce0QZlCY+NdS6PoNOLWUK52c6rC5or/R1I3dyFFR1J6j7MSlpaooN/X3g
X-Gm-Gg: ASbGncsosgXBLyullpy2Ib+WffOTtJDc5X5fBxIR8G5u0UVQl7IdzgkpcGHYtF63IjN
 /7bMfv/QC/wziuyp/w3w1cyViw1Dtgf4UCpnuQlt2hiPddECBnSe4rT8Zz3HdMtxwPRwy3G7RtI
 /27QN8/eq+vwPIlNPUfG1vwJhhKijxyyB65Oj9eqiFTybELXolqPP/6SsWAa8+CN5RBf8TnzjZX
 QnsAKHGOFvdT8UyZ8HGRDUyrypTrmm+H75751UjPgm/1DXrbTSHAI8+N6EGvfCp0Yk3f+rKzmw2
 zR9ZK+BIOwFNeytsGBZE8ur1CK6dObE6yoYq1WWSjCRU1ZFp7690EA==
X-Received: by 2002:a17:902:f791:b0:235:225d:3087 with SMTP id
 d9443c01a7336-23e24f44acemr82062755ad.30.1752739996393; 
 Thu, 17 Jul 2025 01:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkJMxkMrOA80mX3PxXHiX4U9rT8XxgI4RTXCdIyK+W2blYM2J+ofxJYwv2K8cqQ/J9xtvnWA==
X-Received: by 2002:a17:902:f791:b0:235:225d:3087 with SMTP id
 d9443c01a7336-23e24f44acemr82062365ad.30.1752739995978; 
 Thu, 17 Jul 2025 01:13:15 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de42847e0sm142611165ad.7.2025.07.17.01.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 01:13:15 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:43:04 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v5 16/23] migration: push Error **errp into
 loadvm_process_enable_colo()
Message-ID: <aHiwkKqmmx2w6CuZ@armenon-kvm.bengluru.csb>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-16-1f406f88ee65@redhat.com>
 <172e1d7c-e603-46fe-8ce4-fd60f28f6f35@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172e1d7c-e603-46fe-8ce4-fd60f28f6f35@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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

On Thu, Jul 17, 2025 at 12:26:16PM +0900, Akihiko Odaki wrote:
> On 2025/07/17 9:37, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that loadvm_process_enable_colo() must report an error
> > in errp, in case of failure.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   include/migration/colo.h |  2 +-
> >   migration/migration.c    | 12 ++++++------
> >   migration/ram.c          |  8 ++++----
> >   migration/ram.h          |  2 +-
> >   migration/savevm.c       | 25 ++++++++++++-------------
> >   5 files changed, 24 insertions(+), 25 deletions(-)
> > 
> > diff --git a/include/migration/colo.h b/include/migration/colo.h
> > index 43222ef5ae6adc3f7d8aa6a48bef79af33d09208..d4fe422e4d335d3bef4f860f56400fcd73287a0e 100644
> > --- a/include/migration/colo.h
> > +++ b/include/migration/colo.h
> > @@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
> >   bool migration_in_colo_state(void);
> >   /* loadvm */
> > -int migration_incoming_enable_colo(void);
> > +int migration_incoming_enable_colo(Error **errp);
> >   void migration_incoming_disable_colo(void);
> >   bool migration_incoming_colo_enabled(void);
> >   bool migration_incoming_in_colo_state(void);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 10c216d25dec01f206eacad2edd24d21f00e614c..326487882c8d41e2f89f99f69df0d9d4d42705e4 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -623,22 +623,22 @@ void migration_incoming_disable_colo(void)
> >       migration_colo_enabled = false;
> >   }
> > -int migration_incoming_enable_colo(void)
> > +int migration_incoming_enable_colo(Error **errp)
> >   {
> >   #ifndef CONFIG_REPLICATION
> > -    error_report("ENABLE_COLO command come in migration stream, but the "
> > -                 "replication module is not built in");
> > +    error_setg(errp, "ENABLE_COLO command come in migration stream, but the "
> > +               "replication module is not built in");
> >       return -ENOTSUP;
> >   #endif
> >       if (!migrate_colo()) {
> > -        error_report("ENABLE_COLO command come in migration stream, but x-colo "
> > -                     "capability is not set");
> > +        error_setg(errp, "ENABLE_COLO command come in migration stream"
> > +                   ", but x-colo capability is not set");
> >           return -EINVAL;
> >       }
> >       if (ram_block_discard_disable(true)) {
> > -        error_report("COLO: cannot disable RAM discard");
> > +        error_setg(errp, "COLO: cannot disable RAM discard");
> >           return -EBUSY;
> >       }
> >       migration_colo_enabled = true;
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 8223183132dc0f558f45fbae3f4f832845730bd3..607c979cc15a3d321e5e3e380ac7613d80d86fc9 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3576,7 +3576,7 @@ static void colo_init_ram_state(void)
> >    * memory of the secondary VM, it is need to hold the global lock
> >    * to call this helper.
> >    */
> > -int colo_init_ram_cache(void)
> > +int colo_init_ram_cache(Error **errp)
> >   {
> >       RAMBlock *block;
> > @@ -3585,9 +3585,9 @@ int colo_init_ram_cache(void)
> >               block->colo_cache = qemu_anon_ram_alloc(block->used_length,
> >                                                       NULL, false, false);
> >               if (!block->colo_cache) {
> > -                error_report("%s: Can't alloc memory for COLO cache of block %s,"
> > -                             "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
> > -                             block->used_length);
> > +                error_setg(errp, "%s: Can't alloc memory for COLO cache of "
> > +                           "block %s, size 0x" RAM_ADDR_FMT, __func__,
> > +                           block->idstr, block->used_length);
> >                   RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >                       if (block->colo_cache) {
> >                           qemu_anon_ram_free(block->colo_cache, block->used_length);
> > diff --git a/migration/ram.h b/migration/ram.h
> > index 275709a99187f9429ccb4111e05281ec268ba0db..24cd0bf585762cfa1e86834dc03c6baeea2f0627 100644
> > --- a/migration/ram.h
> > +++ b/migration/ram.h
> > @@ -109,7 +109,7 @@ void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset,
> >                                      bool set);
> >   /* ram cache */
> > -int colo_init_ram_cache(void);
> > +int colo_init_ram_cache(Error **errp);
> >   void colo_flush_ram_cache(void);
> >   void colo_release_ram_cache(void);
> >   void colo_incoming_start_dirty_log(void);
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 1cbc44a5314043a403d983511066cf137681a18d..755ba7e4504d377a4649da191ad9875d9fd66f69 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2510,15 +2510,19 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
> >       return 0;
> >   }
> > -static int loadvm_process_enable_colo(MigrationIncomingState *mis)
> > +static int loadvm_process_enable_colo(MigrationIncomingState *mis,
> > +                                      Error **errp)
> >   {
> > -    int ret = migration_incoming_enable_colo();
> > +    int ret;
> > -    if (!ret) {
> > -        ret = colo_init_ram_cache();
> > -        if (ret) {
> > -            migration_incoming_disable_colo();
> > -        }
> > +    if (migration_incoming_enable_colo(errp) < 0) {
> > +        return -1;
> 
> Returning -1 here while colo_init_ram_cache() returns -errno results in an
> inconsistent semantics of this function's return value.

If I understand correctly, you mean, if migration_incoming_enable_colo() fails, it should 
return the errno instead of -1. Will do.
Thanks

> 
> Ideally, I think this function (and other similar functions) should stop
> returning -errno and instead return a bool value to prevent callers to make
> any assumption based on the return value other than success/failure. But
> that could be done later; let it return -errno until then.
> 
yes


