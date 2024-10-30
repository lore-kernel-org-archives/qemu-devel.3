Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9ACD6B6B7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 17:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6CrZ-0006Wq-7n; Wed, 30 Oct 2024 13:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6CrV-0006WY-RL
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 13:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6CrS-0006UA-9F
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 13:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730310720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlXNLkKxvHsRM/JOHDzZuWqb58eatlp5OochxzRKsrc=;
 b=FOU0EY7JiIdMhbvW7okgTJUFqP2zAQtuQl64VrGsdfX8VBJ/dzKCdX+Tg/9L07ZF/sHdeT
 SRjB7riJm4mz00aXByOmXrDc88Q3odFV1fyoxfGosBpaCEJ68yYIyKuuzntnrBGlQG6wn5
 HPeKcuACYx2JRnuVfqkbZem1LY+1Pdo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-8J_Xzo0PMQKWY1Fb3r6z2w-1; Wed, 30 Oct 2024 13:51:58 -0400
X-MC-Unique: 8J_Xzo0PMQKWY1Fb3r6z2w-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b154948b29so29767885a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 10:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730310718; x=1730915518;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QlXNLkKxvHsRM/JOHDzZuWqb58eatlp5OochxzRKsrc=;
 b=XD0F6xaSLp0DhSIxGXJeDvJcRa+EZXKXQQdvJsQHG2rLT62QJlpaZwWDcypBRJfFZQ
 fAODQ+LuwF8/QWev921GGs5BCSr+wnn+UMDdWNJbUbOznVjb/RF8PjopfBLDdh1wxVXZ
 cFKzl+N88UnJlt9zIqWYHuTYAeGbYVXtIygD5WVw7EeQd9vCsFfnOxqXDiYozh5z2ywZ
 cvTnK480AeViQ3WHJ0yyZO42j4AeX58OEJl7PCNBZrj4SdjGgoKpVUWD26rPTHKUS0u3
 iCrCEakh2xPFYgAzHQSmmCPiwUVlRljdMd8Hi0SI8CU+kBuw0MAKCf1dHkyy9oIRRrkz
 zUAw==
X-Gm-Message-State: AOJu0YykgtaEqxKrmhu/OOZif44Z5O4mR4s2Tna45HfxYUdQn0dxs678
 4U3J7Sf8NH7MeIP6YCo1njhcOzr1zJJTCWT2vczzgEde27XaGJNS3b65iQQmcn+xV0Hm1Y6tki0
 Xm8BdZoUCuB56MTNA7CnaX+GGl+pMZe11ISdeE4TFvCgeFH29gAoT
X-Received: by 2002:a05:620a:2904:b0:7b1:53ed:ae61 with SMTP id
 af79cd13be357-7b2f24ef37dmr67373185a.33.1730310718242; 
 Wed, 30 Oct 2024 10:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXXeIBDq2oU0hNtA6NxWOdIQYTRdodTrY7tDzQfjm58BmjpRDGyg9hXy/UvRzToJ+yx8aIWQ==
X-Received: by 2002:a05:620a:2904:b0:7b1:53ed:ae61 with SMTP id
 af79cd13be357-7b2f24ef37dmr67369885a.33.1730310717868; 
 Wed, 30 Oct 2024 10:51:57 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d2aac97sm528617485a.62.2024.10.30.10.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 10:51:57 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:51:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 0/7] QOM: Singleton interface
Message-ID: <ZyJyOnHidTsPAXrR@x1n>
References: <20241029211607.2114845-1-peterx@redhat.com>
 <ZyIA1zruTAxHfGcn@redhat.com> <ZyIw6Rt8kgrFRtXs@x1n>
 <ZyJbRZ02wX4XM-iR@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyJbRZ02wX4XM-iR@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 30, 2024 at 04:13:57PM +0000, Daniel P. Berrangé wrote:
> On Wed, Oct 30, 2024 at 09:13:13AM -0400, Peter Xu wrote:
> > On Wed, Oct 30, 2024 at 09:48:07AM +0000, Daniel P. Berrangé wrote:
> > > On Tue, Oct 29, 2024 at 05:16:00PM -0400, Peter Xu wrote:
> > > > v1: https://lore.kernel.org/r/20241024165627.1372621-1-peterx@redhat.com
> > > 
> > > > Meanwhile, migration has a long standing issue on current_migration
> > > > pointer, where it can point to freed data after the migration object is
> > > > finalized.  It is debatable that the pointer can be cleared after the main
> > > > thread (1) join() the migration thread first, then (2) release the last
> > > > refcount for the migration object and clear the pointer.  However there's
> > > > still major challenges [1].  With singleton, we could have a slightly but
> > > > hopefully working workaround to clear the pointer during finalize().
> > > 
> > > I'm still not entirely convinced that this singleton proposal is
> > > fixing the migration problem correctly.
> > > 
> > > Based on discussions in v1, IIUC, the situation is that we have
> > > migration_shutdown() being called from qemu_cleanup(). The former
> > > will call object_unref(current_migration), but there may still
> > > be background migration threads running that access 'current_migration',
> > > and thus a potential use-after-free.
> > 
> > migration thread is fine, it takes a refcount at the entry.
> > 
> > And btw, taking it at the entry is racy, we've just fixed it, see (in my
> > next migration pull):
> > 
> > https://lore.kernel.org/qemu-devel/20241024213056.1395400-2-peterx@redhat.com/
> 
> Yep, acquiring the refcount immediately before thread-create
> is what I meant.
> 
> > The access reported was, IIUC, outside migration code, but after both
> > main/migration threads released the refcount, hence after finalize().  It
> > could be a random migration_is_running() call very late in device code, for
> > example.
> 
> 
> 
> > 
> > > 
> > > Based on what the 7th patch here does, the key difference is that
> > > the finalize() method for MigrationState will set 'current_migration'
> > > to NULL after free'ing it.
> > 
> > Yes.  But this show case series isn't complete.  We need a migration-side
> > lock finally to make it safe to access.  For that, see:
> > 
> > https://lore.kernel.org/qemu-devel/20241024213056.1395400-9-peterx@redhat.com/
> > 
> > > 
> > > I don't believe that is safe.
> > 
> > I hope after the other series applied it will be 100% safe, even though I
> > agree it's tricky.  But hopefully QOM is very clean, the trickly part is
> > still within migration, and it should be less tricky than migration
> > implement a refcount on top of Object..
> 
> Ok, so with the other series applied, this does look safe, but
> it also doesn't seem to really have any dependancy on the
> single interface code.  Patch 7 here looks sufficient, in combo
> with the other 2 series to avoid the use-after-free flaws.

Patch 7, when applied without patch 6 and prior, will crash in
device-introspect-test, trying to create yet another migration object when
processing the "device-list-properties" QMP command.  And it turns out
that's also not the only way QEMU can crash by that.

Fundamentally it's because patch 7 has global operations within
init()/finalize() to fix the migration dangling pointer, hence it must not
be instanciated more than once.

It's also probably because I always think singleton can be useful in
general to QEMU's device model where can be special devices all over the
places that I'm not aware of.  I didn't work on a lot of QEMU devices, but
with that limited experience I still stumbled upon two devices (if taking
migration object as one..) that might benefit from it.

That leads to this whole series, which is also the cleanest so far I can
think of to solve the immediate migration UAF.

Thanks,

> 
> > I think the question is whether things like migration_is_running() is
> > allowed to be used anywhere, even after migration_shutdown().  My answer
> > is, it should be ok to be used anywhere, and we don't necessarilly need to
> > limit that.  In that case the caller doesn't need to take a refcount
> > because it's an immediate query.  It can simply check its existance with
> > the lock (after my patch 8 of the other series applied, which depends on
> > this qom series).
> 
> Agree, and from a practical POV, I think it would be impossible to
> require a ref count be held from other non-migration threads, so the
> locking around 'current_migration' looks like the only practical
> option.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

-- 
Peter Xu


