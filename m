Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5909ACD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNuLL-00026c-Eb; Fri, 15 May 2026 11:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNuL6-00026D-MI
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNuL3-0003Tp-S2
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778858432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nGV+BOWuEe/oQrdlUll1NxXT5oZnj7KB2q4j+NI4LHw=;
 b=Wcne1COxc85FQl7K2kdQTE6/pnJ6RHzQd3up/1w7UZwu9JAX2UgyXOoVFVkMj+UmJJhX8+
 Fdrr0otxDPxCLpHC6hoT8GZOBRXRQ8fIO+g4tesM2k2pQ0Q6uyasrgmliDyB5Xlh4OksAf
 tL5wWTg/L8BAaczCGn16J4d2toslbuI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-0uszXhboPYuJEJkz5LGeSQ-1; Fri, 15 May 2026 11:20:30 -0400
X-MC-Unique: 0uszXhboPYuJEJkz5LGeSQ-1
X-Mimecast-MFC-AGG-ID: 0uszXhboPYuJEJkz5LGeSQ_1778858429
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ca1295e3a9so25202726d6.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778858429; x=1779463229; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nGV+BOWuEe/oQrdlUll1NxXT5oZnj7KB2q4j+NI4LHw=;
 b=G9mJXUiFplsjPaSpJwqxmN2tAnLtvfaFdpCeUVBbQwC/daQRqliOlGCG/bAiFrjKI5
 rsUAIXa9onCpvYeBZBh4fY9eevAN3AAd1uMhyby5zBWIgHuchdc0dzTsGJA7VLk5dNwI
 ZUCDbLlCkdi7u7Yha9kdslg0xAAt/s+tQC248tdo+Z8BC4jNrBVpiu1LT9h9ouudMiKm
 UEqazKF65x5Dov7FlCqHEYX6+OqBxzZKHfzYL7dlovSq0MKylAi3hry8SUL6dC3UmMI3
 uVaomwU91JvHGNu0ACxRTPHHX68JTtr60uLlyws6RT0mmljePk+k+cKmBbT12FwyDNEm
 DizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778858429; x=1779463229;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nGV+BOWuEe/oQrdlUll1NxXT5oZnj7KB2q4j+NI4LHw=;
 b=OWJR026nxxIfwLJkrLiOSdE5DIXMRx76GkPOXhJHQYKjEb+TEirxFvJNs8uTv6Vsvf
 8qBE8hpOXkfhUFyBXUP6W8OBKXU7/hv6rkEx2h/wD/Ds/Z1S9CmWssmdCr3j/9BBeC5O
 FGCcUeJQU+fmhf1QEQoxYABU4RlFm4UQydAcT0NCQgTM35Ap7jBLtcqhtx6zEX5ehUPj
 jf6AwazOHlsg6tudQ0rUp2Zb00iPFb5Du8gTZqSSADHSccBREvueLrHsGg/VmYVndLSt
 oiK0VMaZ83oO3zld52l+b8yKBMGxl3nAZl80B2UNCyqmjntr/0Tl8lJFH9XFZPCr0UAB
 cNWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HA5siw08Z9kieTsOePARskywrFQr9I3ikJRUqFdCNlL3p0glCPMAEjxkFgahapxZ4llIwGTS90u0U@nongnu.org
X-Gm-Message-State: AOJu0YwmOkXg1WPgDf/P77vBtmz9tbVTv4laHFGP4y/2++dhKVqz4Ndh
 ZYIkF4FBrNdW8ZYxdFhuKX1tt8X1bN9MeiynRJ2sZh6aPBmVIveQ07vqHDVD/zmTdi6XkgYPRNG
 28Lf7nx1ukvnOcfKZl7V6U4GAG7Z4D2SRWPTYaYJgpe9+Ggu/bVRNaitR
X-Gm-Gg: Acq92OHizfjw5AOKtT2vZnZYpZTdeiZu69qxEYcOhO+lyemtksJuppRobKuswm1J/Uv
 T6sThWN9MUmhx7W3rxQ98msXErZD+wmIAQh+LkoXP5dzfiUUYPDU70nob/ZGekXwMSIwLYHl3PT
 N4kByns7b984FKEAPQgANNZQQIZaj3tzMQs0mgrnkPSJQfGhyLJeUi2u71JILWPyYeRA4wuWiSY
 cWyyOOeuMI4GOT/wqE7pVvfRHdn7yMhJNC7JW0WuZUaVjwb7fjaOuYLQ05w0sOFB/C1OtmKbSAL
 vfuWlKDsC3314/8/L8Te2HNO7LxT7+AzXhTvi0rwlKzx/RcKEKKxt3X1KSs9BjLVRMAIoj3wfnD
 JqUuLPMnAx2/OLGh2G6oMVAkNcPB91ZUIkKb1rY0i1Rnyp6o=
X-Received: by 2002:ac8:59d6:0:b0:50d:900e:c1c1 with SMTP id
 d75a77b69052e-5165a06fba1mr61692131cf.7.1778858429199; 
 Fri, 15 May 2026 08:20:29 -0700 (PDT)
X-Received: by 2002:ac8:59d6:0:b0:50d:900e:c1c1 with SMTP id
 d75a77b69052e-5165a06fba1mr61691401cf.7.1778858428632; 
 Fri, 15 May 2026 08:20:28 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51645856d4esm45901691cf.27.2026.05.15.08.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:20:28 -0700 (PDT)
Date: Fri, 15 May 2026 11:20:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 03/14] migration: Propagate errors in
 migration_completion_precopy()
Message-ID: <agc5u6udcw4gRxQp@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-4-avihaih@nvidia.com>
 <c439b516-b8f2-49de-907c-9dfa2edd9e2e@redhat.com>
 <f3031406-7146-4045-bc5e-720fa4bf69a7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3031406-7146-4045-bc5e-720fa4bf69a7@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 08, 2026 at 04:01:43PM +0300, Avihai Horon wrote:
> 
> On 5/7/2026 11:03 AM, Cédric Le Goater wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 5/5/26 10:14, Avihai Horon wrote:
> > > migration_completion_precopy() doesn't propagate errors to migration
> > > core which leads to error information loss. Fix that.
> > > 
> > > This prepares for a follow-up where migration_switchover_start() can
> > > fail on switchover-ack and still report a useful error. Errors from
> > > qemu_savevm_state_complete_precopy() are not propagated yet as it
> > > requires more plumbing.
> > > 
> > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > ---
> > >   migration/migration.c | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 6fd89995a2..a5c7ca6796 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -2780,23 +2780,28 @@ static bool
> > > migration_switchover_start(MigrationState *s, Error **errp)
> > >   static int migration_completion_precopy(MigrationState *s)
> > >   {
> > >       int ret;
> > > +    Error *local_err = NULL;
> > > 
> > >       bql_lock();
> > > 
> > >       if (!migrate_mode_is_cpr()) {
> > >           ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> > >           if (ret < 0) {
> > > +            error_setg_errno(&local_err, -ret, "Failed to stop the
> > > VM");
> > >               goto out_unlock;
> > >           }
> > >       }
> > > 
> > > -    if (!migration_switchover_start(s, NULL)) {
> > > +    if (!migration_switchover_start(s, &local_err)) {
> > >           ret = -EFAULT;
> > >           goto out_unlock;
> > >       }
> > > 
> > >       ret = qemu_savevm_state_complete_precopy(s);
> > >   out_unlock:
> > > +    if (local_err) {
> > > +        migrate_error_propagate(s, local_err);
> > > +    }
> > >       bql_unlock();
> > >       return ret;
> > >   }
> > 
> > Instead, I would modify migration_completion_precopy() to use the Error
> > variable in migration_completion() :
> > 
> >   static void migration_completion(MigrationState *s)
> >   {
> >       int ret = 0;
> >       Error *local_err = NULL;
> > 
> >       if (s->state == MIGRATION_STATUS_ACTIVE) {
> >           ret = migration_completion_precopy(s);
> > 
> >       ...
> > 
> I'd rather keep this change limited and not involve migration_completion().
> The error reporting in this path is a bit convoluted (mixing error reporting
> via qemu_file) and I think it deserves a separate series cleaning things up
> there.
> 
> Unless I am missing something here and the above should be easy?

Not easy to keep everything as before, but I tend to agree with Cedric.

The hard part is to maintain the same error when something failed in
migration_completion(), but IMHO that's a legacy problem we'll need to
tackle with, sooner or later.  We can do it now, facing risk that some
error message might change: I think it's worthwhile to try.

So it also avoids introducing yet another migrate_error_propagate() call
deep in the stack..  Ideally we move it upper and upper so the invokation
should be less as time goes.

The old priority to handle errors in migration_completion() is:

  1. if qemu_file_get_error_obj() succeeded, use it first, otherwise,
  2. if ret!=0, generate an error for retval

Side note: (1) is currently slightly off when qemu_file_get_error_obj()
returns non-zero but without an Error attached.. but let's ignore it for
now.

After this patch, we could prioritize Error* whenever set, hence:

  1. if error non-null, use it directly,
  2. if qemu_file_get_error_obj() succeeded, use it first, otherwise,
  3. if ret!=0, generate an error for retval

I think this order makes sense because neither qemufile error nor retcode
is better than a literal error passed over.

Thanks,

-- 
Peter Xu


