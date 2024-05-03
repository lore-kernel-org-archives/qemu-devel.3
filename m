Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8196DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s30Gx-00055i-3s; Fri, 03 May 2024 17:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s30Gs-00054b-P8
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s30Go-0004p5-2K
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714771000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IpOvXDGSiMfVhSXdIXjDeuDt7s5bhOiAZsA/RZbY0Nw=;
 b=AEjF9fJy29cIjMlMGn5xRZJwFZbglCaR44Uz86JBTZFfw5r8e2ib5D4yu7yoYg3zk+/cDu
 xz4ssoQlYX/EIqq4HaHg8akqx95sHr4u/v9mr7kEIAM7E2FmvFDmOQX2LFh3XHirRkpxSC
 BC8yxYv+1KfTayG8DCIyUv43EDXa35o=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-JYqP3uN9OeCPgg_FadLj2w-1; Fri, 03 May 2024 17:16:39 -0400
X-MC-Unique: JYqP3uN9OeCPgg_FadLj2w-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c95154adedso29636b6e.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 14:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714770998; x=1715375798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IpOvXDGSiMfVhSXdIXjDeuDt7s5bhOiAZsA/RZbY0Nw=;
 b=ajFq7ekcr2ukcYD6uLju9vI0yw9Xm66Rlrr+/kb9MROEkQ2f5CW+nb5rN7IRfpGadl
 zumIr+ejw6Pm+ldntnYN1weW9hRtBr32qI7ij3A944DRuwelfrQngMxGOaX49fjCXqeC
 PNvA6Cx1XHoOYJIXTPTxlOWTjIaumvbmxZG72rsRT+MbsRGMaZFmXmIbfFQ/1U46rmAU
 2xkCVPgPsnQkg+WZBe2ECiw2xpvGIUfEZ4BROkS7TShf8WMh+/zpqohCLGXFtjk6za0n
 g1mG/UlqG2rT6DodhJY0kBhqc592CXcKJJ7K568vcXB3FvzCYsBKHoOGqk50JplbigUQ
 9eoA==
X-Gm-Message-State: AOJu0YyoRnNtbK6SCAdG8CUYV72U3a4NViuXXV1M0E01GWPOYrlIr7hf
 V7WQjSRE0z2BRqcKYpbczO2K3g3fZ5esQ4YCt26Q9yEa6vpAkb1KBY4oXhFDN5DNYN0MyJx1qJH
 hqv9uU55CHN0RDAkkOpTAToBNGhiKYNEOmQszRQots0i83aUDmIGW
X-Received: by 2002:a05:6808:16a3:b0:3c8:54ca:511d with SMTP id
 bb35-20020a05680816a300b003c854ca511dmr4648998oib.1.1714770997855; 
 Fri, 03 May 2024 14:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBOCRiA1kDcz68D21+3HDpx3c0ATkKuk0cidb263ja00Awvm/vI42TJJwCzlWbnUFEG8O90w==
X-Received: by 2002:a05:6808:16a3:b0:3c8:54ca:511d with SMTP id
 bb35-20020a05680816a300b003c854ca511dmr4648965oib.1.1714770997246; 
 Fri, 03 May 2024 14:16:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 mg7-20020a056214560700b006a0d46d13bfsm1505727qvb.69.2024.05.03.14.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 14:16:36 -0700 (PDT)
Date: Fri, 3 May 2024 17:16:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 4/9] migration: Add direct-io parameter
Message-ID: <ZjVUKCafjreLtLmm@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-5-farosas@suse.de> <ZjUnghSvdy-wWtnN@x1n>
 <871q6ioc2r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871q6ioc2r.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 03, 2024 at 05:49:32PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Apr 26, 2024 at 11:20:37AM -0300, Fabiano Rosas wrote:
> >> Add the direct-io migration parameter that tells the migration code to
> >> use O_DIRECT when opening the migration stream file whenever possible.
> >> 
> >> This is currently only used with the mapped-ram migration that has a
> >> clear window guaranteed to perform aligned writes.
> >> 
> >> Acked-by: Markus Armbruster <armbru@redhat.com>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  include/qemu/osdep.h           |  2 ++
> >>  migration/migration-hmp-cmds.c | 11 +++++++++++
> >>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
> >>  migration/options.h            |  1 +
> >>  qapi/migration.json            | 18 +++++++++++++++---
> >>  util/osdep.c                   |  9 +++++++++
> >>  6 files changed, 68 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> >> index c7053cdc2b..645c14a65d 100644
> >> --- a/include/qemu/osdep.h
> >> +++ b/include/qemu/osdep.h
> >> @@ -612,6 +612,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
> >>  bool qemu_has_ofd_lock(void);
> >>  #endif
> >>  
> >> +bool qemu_has_direct_io(void);
> >> +
> >>  #if defined(__HAIKU__) && defined(__i386__)
> >>  #define FMT_pid "%ld"
> >>  #elif defined(WIN64)
> >> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> >> index 7e96ae6ffd..8496a2b34e 100644
> >> --- a/migration/migration-hmp-cmds.c
> >> +++ b/migration/migration-hmp-cmds.c
> >> @@ -397,6 +397,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
> >>          monitor_printf(mon, "%s: %s\n",
> >>              MigrationParameter_str(MIGRATION_PARAMETER_MODE),
> >>              qapi_enum_lookup(&MigMode_lookup, params->mode));
> >> +
> >> +        if (params->has_direct_io) {
> >> +            monitor_printf(mon, "%s: %s\n",
> >> +                           MigrationParameter_str(
> >> +                               MIGRATION_PARAMETER_DIRECT_IO),
> >> +                           params->direct_io ? "on" : "off");
> >> +        }
> >
> > This will be the first parameter to optionally display here.  I think it's
> > a sign of misuse of has_direct_io field..
> >
> > IMHO has_direct_io should be best to be kept as "whether direct_io field is
> > valid" and that's all of it.  It hopefully shouldn't contain more
> > information than that, or otherwise it'll be another small challenge we
> > need to overcome when we can remove all these has_* fields, and can also be
> > easily overlooked.
> 
> I don't think I understand why we have those has_* fields. I thought my
> usage of 'params->has_direct_io = qemu_has_direct_io()' was the correct
> one, i.e. checking whether QEMU has any support for that parameter. Can
> you help me out here?

Here params is the pointer to "struct MigrationParameters", which is
defined in qapi/migration.json.  And we have had "has_*" only because we
allow optional fields with asterisks:

  { 'struct': 'MigrationParameters',
    'data': { '*announce-initial': 'size',
              ...
              } }

So that's why it better only means "whether this field existed", because
it's how it is defined.

IIRC we (or say, Markus) used to have some attempts deduplicates those
*MigrationParameter* things, and if success we have chance to drop has_*
fields (in which case we simply always have them; that "has_" makes more
sense only if in a QMP session to allow user only specify one or more
things if not all).

> 
> >
> > IMHO what we should do is assert has_direct_io==true here too, meanwhile...
> >
> >>      }
> >>  
> >>      qapi_free_MigrationParameters(params);
> >> @@ -690,6 +697,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
> >>          p->has_mode = true;
> >>          visit_type_MigMode(v, param, &p->mode, &err);
> >>          break;
> >> +    case MIGRATION_PARAMETER_DIRECT_IO:
> >> +        p->has_direct_io = true;
> >> +        visit_type_bool(v, param, &p->direct_io, &err);
> >> +        break;
> >>      default:
> >>          assert(0);
> >>      }
> >> diff --git a/migration/options.c b/migration/options.c
> >> index 239f5ecfb4..ae464aa4f2 100644
> >> --- a/migration/options.c
> >> +++ b/migration/options.c
> >> @@ -826,6 +826,22 @@ int migrate_decompress_threads(void)
> >>      return s->parameters.decompress_threads;
> >>  }
> >>  
> >> +bool migrate_direct_io(void)
> >> +{
> >> +    MigrationState *s = migrate_get_current();
> >> +
> >> +    /* For now O_DIRECT is only supported with mapped-ram */
> >> +    if (!s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM]) {
> >> +        return false;
> >> +    }
> >> +
> >> +    if (s->parameters.has_direct_io) {
> >> +        return s->parameters.direct_io;
> >> +    }
> >> +
> >> +    return false;
> >> +}
> >> +
> >>  uint64_t migrate_downtime_limit(void)
> >>  {
> >>      MigrationState *s = migrate_get_current();
> >> @@ -1061,6 +1077,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
> >>      params->has_zero_page_detection = true;
> >>      params->zero_page_detection = s->parameters.zero_page_detection;
> >>  
> >> +    if (s->parameters.has_direct_io) {
> >> +        params->has_direct_io = true;
> >> +        params->direct_io = s->parameters.direct_io;
> >> +    }
> >> +
> >>      return params;
> >>  }
> >>  
> >> @@ -1097,6 +1118,7 @@ void migrate_params_init(MigrationParameters *params)
> >>      params->has_vcpu_dirty_limit = true;
> >>      params->has_mode = true;
> >>      params->has_zero_page_detection = true;
> >> +    params->has_direct_io = qemu_has_direct_io();
> >>  }
> >>  
> >>  /*
> >> @@ -1416,6 +1438,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
> >>      if (params->has_zero_page_detection) {
> >>          dest->zero_page_detection = params->zero_page_detection;
> >>      }
> >> +
> >> +    if (params->has_direct_io) {
> >> +        dest->direct_io = params->direct_io;
> >
> > .. do proper check here to make sure the current QEMU is built with direct
> > IO support, then fail QMP migrate-set-parameters otherwise when someone
> > tries to enable it on a QEMU that doesn't support it.
> 
> I'm already checking at migrate_params_init() with
> qemu_has_direct_io(). But ok, you want to move it here... Is this
> function the correct one instead of migrate_params_check()? I see these

Oh I perhaps commented on the wrong line.  migrate_params_check() is the
place where we should throw such error and check for O_DIRECT for sure..

> TODO comments mentioning QAPI_CLONE(), we can't clone the object if this
> one parameter needs special treatment. I might be getting all this
> wrong, bear with me.

Nah, I think I just wanted to comment inside migrate_params_check() but I
did it all wrong, sorry.

-- 
Peter Xu


