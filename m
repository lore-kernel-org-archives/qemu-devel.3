Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59494CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvw1-0000va-9w; Thu, 23 Oct 2025 10:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBvvy-0000v1-LX
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBvvu-00065l-Nz
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761228288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P77pi1wKutGKL4BNucJ0kfBnD5+r5bOHi46pn6dbPvw=;
 b=VwOuxwvK7VJRbw6X7jPbN0pJLCd8i5B6SJGhtBFGOa3urQbueCj3SRKEb/OxGFYcJ1SjUV
 kyQsKOP5nbqguoNvKdylQx3LI7GI4ZJGNn213G0R8ZUiSciHZ184EmKsTjckdlQ6wsZA1p
 1YjPmUtaSyt1/6cEPQ8Pl4cNYNWpxis=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-IfeQZtJpP2uw4yEX_otCUA-1; Thu,
 23 Oct 2025 10:04:44 -0400
X-MC-Unique: IfeQZtJpP2uw4yEX_otCUA-1
X-Mimecast-MFC-AGG-ID: IfeQZtJpP2uw4yEX_otCUA_1761228283
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A6B0180A997; Thu, 23 Oct 2025 14:04:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 219CD1800597; Thu, 23 Oct 2025 14:04:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D51D21E6A27; Thu, 23 Oct 2025 16:04:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] migration/qmp: Update "resume" flag doc in "migrate"
 command
In-Reply-To: <aPozyk9Do9iu32G4@x1.local> (Peter Xu's message of "Thu, 23 Oct
 2025 09:55:22 -0400")
References: <20251022190425.2730441-1-peterx@redhat.com>
 <87cy6eb25c.fsf@pond.sub.org> <aPozyk9Do9iu32G4@x1.local>
Date: Thu, 23 Oct 2025 16:04:40 +0200
Message-ID: <87sef94suf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Oct 23, 2025 at 07:47:11AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > It wasn't obvious how the resume flag should be used when staring at the
>> > QAPI doc.  Enrich it to be crystal clear.
>> >
>> > Reported-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  qapi/migration.json | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index be0f3fcc12..48856078db 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -1732,7 +1732,10 @@
>> >  # @detach: this argument exists only for compatibility reasons and is
>> >  #     ignored by QEMU
>> >  #
>> > -# @resume: resume one paused migration, default "off".  (since 3.0)
>> > +# @resume: when set, resume one paused postcopy migration, using the new
>> 
>> Scratch "one" unless there can be more than one.
>
> Sure.
>
>> 
>> > +#     URI/channels specified to replace the old/broken channels.  The user
>> > +#     should make sure the migration is in "postcopy-paused" state before
>> > +#     the resume request.  Default "off".  (since 3.0)
>> >  #
>> >  # Features:
>> >  #
>> 
>> What happens when migration is not in state "postcopy-paused"?
>
> The QMP command "migrate" with resume=true set will be rejected,
> corresponds to:
>
> migrate_prepare():
>         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
>             error_setg(errp, "Cannot resume if there is no "
>                        "paused migration");
>             return false;
>         }

Makes sense, thanks!

I'd suggest something like 'Resume fails unless migration is in
"postcopy-paused" state.  (default: false, since 3.0)'

>> Remind me, how can migration get into and out of this state?
>
> It can happen if any interruption happened during a postcopy migration.  So
> it needs to be postcopy-active state first, then something wrong happened
> e.g. the network is down.  Then the channel will break on both sides of
> QEMU, and both QEMUs will jump into postcopy-paused.
>
> To get out of the state, one needs to explicitly recover the migration, the
> core steps are:
>
>   - (optional) Run migrate_recover on dest QEMU to re-establish the ports,
>     if the old listening ports are not available anymore.
>
>   - Run migrate on src QEMU with resume=true flag here to resume the
>     postcopy migration.
>
> If the recover succeeded, it'll switch from postcopy-paused finally back to
> postcopy-active.
>
> Thanks,

Got it, thanks!


