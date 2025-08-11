Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22212C87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulS9B-0001HU-In; Mon, 11 Aug 2025 09:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ulS8n-0001CG-Ks
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ulS8e-0005bh-Tr
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754917224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1uvDE0FNU7sDa+nEjqR17CZgai5QHyzHIqoCLPFLr2o=;
 b=VpyKvrD0+ns4+W2V/O4okoSE9JcMp71fjLWB6aw9yenmnU5yB3GcACkT0ylwlCRGMK3kuh
 ygF9VMFQQ8onO8G0RPfErX0evWP57fSG2WQ0u3VlljRIdGI1sbNHdhPhbOcNU8TS6RL5w4
 C9QzUisOshGfTg26USHguAFHZxEFuIY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-sLW7qkJUMTGvRvs-yPuoQw-1; Mon, 11 Aug 2025 09:00:22 -0400
X-MC-Unique: sLW7qkJUMTGvRvs-yPuoQw-1
X-Mimecast-MFC-AGG-ID: sLW7qkJUMTGvRvs-yPuoQw_1754917222
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e6a5428a76so1363673385a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 06:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754917221; x=1755522021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uvDE0FNU7sDa+nEjqR17CZgai5QHyzHIqoCLPFLr2o=;
 b=cui3U9pOWbx9r8xa8G+0hVhkTUr7YKMRnXv9t+Oh9uLpAnukRnlli8DdCHrdrVKKLV
 5A1A7R6HlvfA92uVtrnCWsASrcMWWTiuXuIXNDana8dlVD+CKc71ndEmBXm1gZKecQo9
 M5CZAS5iumkagjj8Ae6yOyuvAoZkLm+NYOBoNyOMSluZX041o6cxeXg5ex9h14Zseavx
 /L2A7O9O1mXd5+cTZvwrf43Uk4oOCSBKJKfgQbnJbcjvGcMeWiULjgtgu2PrAMbB6Fnd
 X9GEXRAtJHk3R6oyzScWeN1idvAyF0B6pR0xhArd6p5XUaAGqR6IoDqFHq6FyVmo5feB
 dHow==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Tc7nV+UfHvZHfAeQvC+VnlVLOyw0kpK6au50wPoX8bQXmVOnmk1vln+MafzUiMQkfC3uYIQFJ7Xv@nongnu.org
X-Gm-Message-State: AOJu0YwLRsElOme8UEhetg2BcMcAkFbrc451haL5nrz9+EgC3RUYJAHW
 wwmy8XVffM0vGPlW4CcmAlseibtL5R+aQfakkmQ0kXLRpBFujxczej6KBd0Q+sNsvtUn86nHOfV
 wDe+6hsD8zcrgwFEafhN93X+QezdMTz3QWyguuAhgp7lJa3q/RpTke8xx
X-Gm-Gg: ASbGncsRIcrZsdtdrV43eS4nzR1c3+zjpDOKWdZVm60aoZTlux4dmNO1dn867pNHXZI
 Vr8TLS3zNGJqUfx84vZvmeUx8f6hdKsgfT5RedFX1w+Hr95xLqLULviBSlLfq77Dn/tHX3V0PbD
 uz1whNM/9JpEDLHoqR3YRVN9NJY2OCQ7j0PxhZ9BTRqQ8efhw9JcizznHBYoBYueZ4jmFr66FgY
 LnZZzz6uQOCNAsLpd4wv2m9jUKZdHVNnt/2wrYWjU3fIS7V77rRuwv0s4ko9uAOOAZXQgMQkq+S
 XDIdPvH8AClFscDKXtKuV02UfoHu/8JuMjrh1+0LHVlG2dI6J9p07E6NuA==
X-Received: by 2002:a05:620a:17a6:b0:7e3:2bb9:be81 with SMTP id
 af79cd13be357-7e82d3d2c2emr1719123385a.15.1754917221383; 
 Mon, 11 Aug 2025 06:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQsyf88Grpmy/IkyjHuMhhuhdmVEiC+i+MlckbcHVVcHn1ddvRDGQ1QPYyozPHg6TbrGtrZA==
X-Received: by 2002:a05:620a:17a6:b0:7e3:2bb9:be81 with SMTP id
 af79cd13be357-7e82d3d2c2emr1719113185a.15.1754917220591; 
 Mon, 11 Aug 2025 06:00:20 -0700 (PDT)
Received: from fedora (78-80-81-60.customers.tmcz.cz. [78.80.81.60])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e823fddc10sm658169085a.16.2025.08.11.06.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 06:00:19 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:00:16 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Jiri Denemark <jdenemar@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/4] migration: Fix state transition in
 postcopy_start() error handling
Message-ID: <xdugt5mbafgh5kvwj6e5rke4zlapjp7biky4x6vzbeejj6opjb@zfkqvlwgjryb>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <20250807114922.1013286-3-jmarcin@redhat.com>
 <aJUSeOIKfQ47uliY@x1.local> <87ectl1vj7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ectl1vj7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Fabiano

On 2025-08-08 16:08, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Aug 07, 2025 at 01:49:10PM +0200, Juraj Marcin wrote:
> >> From: Juraj Marcin <jmarcin@redhat.com>
> >> 
> >> Depending on where an error during postcopy_start() happens, the state
> >> can be either "active", "device" or "cancelling", but never
> >> "postcopy-active". Migration state is transitioned to "postcopy-active"
> >> only just before a successful return from the function.
> >> 
> >> Accept any state except "cancelling" when transitioning to "failed"
> >> state.
> >> 
> >> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> >> ---
> >>  migration/migration.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 10c216d25d..e5ce2940d5 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -2872,8 +2872,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
> >>  fail_closefb:
> >>      qemu_fclose(fb);
> >>  fail:
> >> -    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> >> -                          MIGRATION_STATUS_FAILED);
> >> +    if ( ms->state != MIGRATION_STATUS_CANCELLING) {
> >> +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> >> +    }
> >
> > Hmm, this might have been overlooked from my commit 48814111366b.  Maybe
> > worth a Fixes and copy stable?
> >
> > For example, I would expect the old code (prior of 48814111366b) still be
> > able to fail postcopy and resume src QEMU if qemu_savevm_send_packaged()
> > failed.  Now, looks like it'll be stuck at "device" state..
> >
> > The other thing is it also looks like a common pattern to set FAILED
> > meanwhile not messing with a CANCELLING stage.  It's not easy to always
> > remember this, so maybe we should consider having a helper function?
> >
> >   migrate_set_failure(MigrationState *, Error *err);
> >
> 
> We didn't do it back then because at there would be some logical
> conflict with this series:
> 
> https://lore.kernel.org/r/20250110100707.4805-1-shivam.kumar1@nutanix.com
> 
> But I don't remember the details. If it works this time I'm all for it.

Thanks! I will look into that.

Best regards,

Juraj Marcin

> 
> > Which could set err with migrate_set_error() (likely we could also
> > error_report() the error), and update FAILED iff it's not CANCELLING.
> >
> > I saw three of such occurances that such helper may apply, but worth double
> > check:
> >
> > postcopy_start[2725]           if (ms->state != MIGRATION_STATUS_CANCELLING) {
> > migration_completion[3069]     if (s->state != MIGRATION_STATUS_CANCELLING) {
> > igration_connect[4064]        if (s->state != MIGRATION_STATUS_CANCELLING) {
> >
> > If the cleanup looks worthwhile, and if the Fixes apply, we could have the
> > cleanup patch on top of the fixes patch so patch 1 is easier to backport.
> >
> > Thanks,
> >
> >>      migration_block_activate(NULL);
> >>      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
> >>      bql_unlock();
> >> -- 
> >> 2.50.1
> >> 
> 


