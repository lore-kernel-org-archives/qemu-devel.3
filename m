Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D213D5CCAA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 13:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t68Vq-0001gr-4e; Wed, 30 Oct 2024 09:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t68Vo-0001gY-CD
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t68Vl-00017W-KZ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730293999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gYM7D7t/qhNl2VpV8UdTK3uyUFH70xXFbdDYuNehzU=;
 b=CJws+yKmlkkTKwGfsQcUw0/hXw2zkfdLPri1QFkth7RbvskGq/AO5N/zu1+9RF0rGb3HQv
 kaImN+0BK2Lj2IxeZCm0ZgwMR1ajV2IFrXTEHpDLB7CxVSvdUIaDqp4+u5S8F/cIgw6rY9
 6Gitin0o65+74otXrZNP7IH5XzXBAG0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-RAsgcoaXMxmKm_3t7dOpGQ-1; Wed, 30 Oct 2024 09:13:16 -0400
X-MC-Unique: RAsgcoaXMxmKm_3t7dOpGQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b17e90d16fso1044644785a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 06:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730293996; x=1730898796;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2gYM7D7t/qhNl2VpV8UdTK3uyUFH70xXFbdDYuNehzU=;
 b=TYP+6DMwEpG5cAPHHPoKfXXvxmA/TeAe7+0GkzEpdXCzhDlBWFIHOG1FeH0YAPXbPF
 zijXRA5Y9Sc+OnhSR2w6jw+c8+mN5BLnWpXz4L6zNGM/yWgYRJ74kDa1HTnU5h4bXpVJ
 8nGZmRjZBJEAAECbMr9EsIhLymniBBgIQtmjFJZ0KENH+XPZnZXK1oUwjlOpuJ+GIgP2
 kJC1rj0tDrljvf/0bJmN4hepDePhkn0tn3tWmJUV0lTsEe/oF83oDMcvUaOw0SfNQu9d
 Rmk7VDi8DQWhHRomImHu+4KgOq8gBiP+bDG3G1TDmLiC/sGt4WzdYh5EYPVvwU760JBE
 bbbQ==
X-Gm-Message-State: AOJu0Yz5oNXoNkc6UrjPs/pZD3Wn/HPyBW5murVL+3aStFTt/jnsLD7t
 4B9POjMyBFppTEF5l6kwQdBfw6lEViMdU+HtqWDyFIaS8C21Sl4OxW6CdmN0xaztERD83R8LcnT
 4O00vwhSzsQSGvHrsv8azz3gbjs60bKw/uvRFJNkTXzKE5+wZQVIt
X-Received: by 2002:a05:620a:248c:b0:7b1:4869:38db with SMTP id
 af79cd13be357-7b193f04428mr2150129385a.32.1730293996159; 
 Wed, 30 Oct 2024 06:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnEmK8+r2/7hE6SMZ2euvkrtMk2/P+bNLTbrZHjPD/5MWe5R8RjgsdTjqJRfG2LTTPJRYeiQ==
X-Received: by 2002:a05:620a:248c:b0:7b1:4869:38db with SMTP id
 af79cd13be357-7b193f04428mr2150125685a.32.1730293995811; 
 Wed, 30 Oct 2024 06:13:15 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d343a38sm508609585a.102.2024.10.30.06.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 06:13:15 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:13:13 -0400
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
Message-ID: <ZyIw6Rt8kgrFRtXs@x1n>
References: <20241029211607.2114845-1-peterx@redhat.com>
 <ZyIA1zruTAxHfGcn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyIA1zruTAxHfGcn@redhat.com>
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

On Wed, Oct 30, 2024 at 09:48:07AM +0000, Daniel P. Berrangé wrote:
> On Tue, Oct 29, 2024 at 05:16:00PM -0400, Peter Xu wrote:
> > v1: https://lore.kernel.org/r/20241024165627.1372621-1-peterx@redhat.com
> 
> > Meanwhile, migration has a long standing issue on current_migration
> > pointer, where it can point to freed data after the migration object is
> > finalized.  It is debatable that the pointer can be cleared after the main
> > thread (1) join() the migration thread first, then (2) release the last
> > refcount for the migration object and clear the pointer.  However there's
> > still major challenges [1].  With singleton, we could have a slightly but
> > hopefully working workaround to clear the pointer during finalize().
> 
> I'm still not entirely convinced that this singleton proposal is
> fixing the migration problem correctly.
> 
> Based on discussions in v1, IIUC, the situation is that we have
> migration_shutdown() being called from qemu_cleanup(). The former
> will call object_unref(current_migration), but there may still
> be background migration threads running that access 'current_migration',
> and thus a potential use-after-free.

migration thread is fine, it takes a refcount at the entry.

And btw, taking it at the entry is racy, we've just fixed it, see (in my
next migration pull):

https://lore.kernel.org/qemu-devel/20241024213056.1395400-2-peterx@redhat.com/

The access reported was, IIUC, outside migration code, but after both
main/migration threads released the refcount, hence after finalize().  It
could be a random migration_is_running() call very late in device code, for
example.

> 
> Based on what the 7th patch here does, the key difference is that
> the finalize() method for MigrationState will set 'current_migration'
> to NULL after free'ing it.

Yes.  But this show case series isn't complete.  We need a migration-side
lock finally to make it safe to access.  For that, see:

https://lore.kernel.org/qemu-devel/20241024213056.1395400-9-peterx@redhat.com/

> 
> I don't believe that is safe.

I hope after the other series applied it will be 100% safe, even though I
agree it's tricky.  But hopefully QOM is very clean, the trickly part is
still within migration, and it should be less tricky than migration
implement a refcount on top of Object..

> 
> Back to the current code, if there is a use-after-free today, that
> implies that the background threads are *not* holding their own
> reference on 'current_migration', allowing the object to be free'd
> while they're still using it. If they held their own reference then
> the object_unref in migration_shutdown would not have any use after
> free risk.
> 
> The new code is not changing the ref counting done by any threads.
> Therefore if there's a use-after-free in existing code, AFAICT, the
> same use-after-free *must* still exist in the current code.
> 
> The 7th patch only fixes the use-after-free, *if and only if* the
> background thread tries to access 'current_migration', /after/
> finalize as completed. The use-after-free in this case, has been
> turned into a NULL pointer reference.
> 
> A background thread could be accessing the 'current_migration' pointer
> *concurrently* with the finalize method executing though. In this case
> we still have a use after free problem, only the time window in which
> it exists has been narrowed a little.
> 
> Shouldn't the problem with migration be solved by every migration thread
> holding a reference on current_migration, that the thread releases when
> it exits, such that MigrationState is only finalized once every thread
> has exited ? That would not require any join() synchronization point.

I think the question is whether things like migration_is_running() is
allowed to be used anywhere, even after migration_shutdown().  My answer
is, it should be ok to be used anywhere, and we don't necessarilly need to
limit that.  In that case the caller doesn't need to take a refcount
because it's an immediate query.  It can simply check its existance with
the lock (after my patch 8 of the other series applied, which depends on
this qom series).

Thanks,

-- 
Peter Xu


