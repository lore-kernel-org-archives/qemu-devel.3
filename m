Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F81CD6E78
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV9tU-0003fa-1w; Thu, 04 Jun 2026 11:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wV9tR-0003en-Gv
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wV9tL-0001YO-Nw
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780586512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9NVYmFMyezAxKXudZZRcpQ4KsxMwYPsvEikT6JBaxXo=;
 b=RPQ7qnKtf5Wh2QXciqwEgkm1bi0ratHC+OBzRnqkf1y2JehJkXk40xQX20lTaCQ3tWBurn
 Tw7/O+9WTMD0gWmesW6oZ7Y/v+O6xoKytFq+5u3CZZoHj582sWWFk7wLCGxW+rwzsPbc1P
 9tJ68uuNhxi0sXfGZCZSuI3v7RG9Zvg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-I3JVW0kgPfyzhKxn9gTtpw-1; Thu, 04 Jun 2026 11:21:48 -0400
X-MC-Unique: I3JVW0kgPfyzhKxn9gTtpw-1
X-Mimecast-MFC-AGG-ID: I3JVW0kgPfyzhKxn9gTtpw_1780586508
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9157db42dd8so205361385a.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780586508; x=1781191308; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9NVYmFMyezAxKXudZZRcpQ4KsxMwYPsvEikT6JBaxXo=;
 b=G5Kpjdi9OoPnx4gxu6fAjPztpAqFSOtzDDWct8kX6yaRDmRRw3pWX56jPISSfQPSut
 jtGZuOzKAEdiFoUX2kcuecoSD2kwbbY/9vrgVWluDcmTOeRlYtdRxePLWApdPTpgiyZ0
 MK1DjC+M2Aa2wkbAoiJxLrWMhin8GlH7hJznvPokW0hjf1Ljr9ehmpFGJg9T9XgHtijH
 o9P5coVWGCwA6dMscWX0wIBvHOKQcYo5wozVXvntrAyluIz8ErJbdqDV+o0ndrWgeQ/j
 XhwXvveb/t+KPik15PcQpH72xTysq6Pt+2kL4mmZUf+3kY+BnPvVJKoWvGrPg3lQgZ4z
 EDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780586508; x=1781191308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NVYmFMyezAxKXudZZRcpQ4KsxMwYPsvEikT6JBaxXo=;
 b=R4gDdOK3BdEjSZlLW0pC5jchzVbJKxIzirdjPcwXP3X/5nimO/qVcoV9+aDFilaUZ6
 A9R90rr63N26atPJe7O60+hEMROnrrvgxf6mGo/E8kpH2ijSSmtYY9SAlGgKw27iZMPo
 nnS8UfDdcvcPCsRoJ75it3/epb2/1a218MlclCRcgYZrM5aT+DIrM5Q11vxJNrYGGMjK
 dMSQ8cN+Ox71uzeJyDzUlLh0BfNSEZ1WdPulcp/DJAEhB2Pv5jPbQtJeneEchTHTY8GL
 7iiBEc/2YYzwyuC8NEHyaK/7XfREiywRLDbVmw9PlLiRHZ3CyonFbOYlgN3XFnb4kme1
 ehgA==
X-Gm-Message-State: AOJu0Yzkp/MxN+JNYEonI0tkuFibCryz9b29bH4HiDz5Hed/EXs+jeFi
 vNbsgvUxUrpa+p5li7TI1nPo4oo0a3LZNdwnd6tAnPkAHOsrKNcSwOJQfGNgZKrfph5C7DiX4ia
 V+dXDsf3AI4CbOJS3oKYTmDCxKcA2EStxnEY3XE6SMRoJZq7x0lEKL6ZG
X-Gm-Gg: Acq92OEomsG/SGpkz4PaYxzNuhr3IjjHXiRPj3F2H0vlBoGmvS7ywU22KZKGpLPOqzM
 Ob7pEziBZfKEOBzhu/cww0oq6IvA+j9bhlbBEXbxS4MDehHsPMWUDWxI5y2m2VAzPmKXpuV1Rux
 9u0Oh4JgXwSyX59I3gG2YTq9+Y8mZpCiqk+HDFQRa5yWCWO+y2k59onH1PGCsbnnmVR8DFD06ye
 uk0Eh9yfIawfJG68y3R+NnPnxmI1ufiEAiBHRMYDOJDJSG7ZLnma++C8mMyiSPLwT74cqKnrkZX
 Eh2R4xLPKgEziLXy+gx8isgt49EM5SqjqiIzlpS88F0bcKya+ZEKxjwVG6UsaruRogzlRXQCGwG
 ZtULTtoAHlMfj2bF+fN6ncjsKnA==
X-Received: by 2002:a05:620a:2592:b0:911:3e08:23fa with SMTP id
 af79cd13be357-9158a6c84b4mr1388668285a.19.1780586507975; 
 Thu, 04 Jun 2026 08:21:47 -0700 (PDT)
X-Received: by 2002:a05:620a:2592:b0:911:3e08:23fa with SMTP id
 af79cd13be357-9158a6c84b4mr1388661585a.19.1780586507303; 
 Thu, 04 Jun 2026 08:21:47 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a2359ecsm611122985a.14.2026.06.04.08.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:21:46 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:21:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v2 01/13] migration: Propagate errors in
 migration_completion_precopy()
Message-ID: <aiGYCVUVwtsdgrWu@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-2-avihaih@nvidia.com>
 <aiCEuAmX3qpWDS5n@x1.local>
 <cdd8c52b-74f3-44a9-8d84-917b363cad4d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdd8c52b-74f3-44a9-8d84-917b363cad4d@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 04, 2026 at 06:12:11PM +0300, Avihai Horon wrote:
> 
> On 6/3/2026 10:47 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, Jun 02, 2026 at 12:26:09PM +0300, Avihai Horon wrote:
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
> > >   migration/migration.c | 11 +++++++----
> > >   1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 074d3f2c69..7488a94206 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -2814,7 +2814,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
> > >       return true;
> > >   }
> > > 
> > > -static int migration_completion_precopy(MigrationState *s)
> > > +static int migration_completion_precopy(MigrationState *s, Error **errp)
> > >   {
> > >       int ret;
> > > 
> > > @@ -2823,11 +2823,12 @@ static int migration_completion_precopy(MigrationState *s)
> > >       if (!migrate_mode_is_cpr()) {
> > >           ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> > >           if (ret < 0) {
> > > +            error_setg_errno(errp, -ret, "Failed to stop the VM");
> > >               goto out_unlock;
> > >           }
> > >       }
> > > 
> > > -    if (!migration_switchover_start(s, NULL)) {
> > > +    if (!migration_switchover_start(s, errp)) {
> > >           ret = -EFAULT;
> > >           goto out_unlock;
> > >       }
> > IIUC this patch overlooked the follow up call:
> > 
> >      ret = qemu_savevm_state_complete_precopy(s);
> > 
> > We should make sure ret!=0 will always set Error*.  Better pass Error**
> > into qemu_savevm_state_complete_precopy() too.
> 
> Yes, that was intentional, because this requires more plumbing in
> qemu_savevm_state_complete_precopy() (as mentioned in the commit message).
> Although not clean, I thought it was OK to do this one-time exception since
> we explicitly check for local_err in migration_completion().
> 
> I can give it a shot and try adding Error **errp to
> qemu_savevm_state_complete_precopy(), but I think it'll be opening a can of
> worms.
> Do you have any thoughts?

If we want to keep the min change, we can consider setting errp at least
when qemu_savevm_state_complete_precopy() returned non-zero in the path of
migration_completion_precopy(), to make sure errp is always set when error
happened.  Otherwise it's error prone.

Thanks,

> 
> Thanks.
> 
> > 
> > Thanks,
> > 
> > > @@ -2869,7 +2870,7 @@ static void migration_completion(MigrationState *s)
> > >       Error *local_err = NULL;
> > > 
> > >       if (s->state == MIGRATION_STATUS_ACTIVE) {
> > > -        ret = migration_completion_precopy(s);
> > > +        ret = migration_completion_precopy(s, &local_err);
> > >       } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> > >           migration_completion_postcopy(s);
> > >       } else {
> > > @@ -2900,7 +2901,9 @@ static void migration_completion(MigrationState *s)
> > >       return;
> > > 
> > >   fail:
> > > -    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> > > +    if (local_err) {
> > > +        migrate_error_propagate(s, local_err);
> > > +    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> > >           migrate_error_propagate(s, local_err);
> > >       } else if (ret) {
> > >           error_setg_errno(&local_err, -ret, "Error in migration completion");
> > > --
> > > 2.40.1
> > > 
> > --
> > Peter Xu
> > 
> 

-- 
Peter Xu


