Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EADFC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKmy-0007PV-Qq; Mon, 27 Jul 2026 08:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woKmw-0007KN-5p
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woKmt-0004IX-UH
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785156630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x0rLaDAi5KlijnkCnuqS97k0mLitSR/GOJxO5gH6eys=;
 b=cj/aJ7FPeoCwj6Ezhi/u5U0mMm0plAmTw19NgPcK17/vAozQFN/bYE8HFgJV3A37KSHzhK
 aiEE4Q3X1d2kPg/Mug+hsjw8b6ui7bofkzM6//3JBwKTVShkcu3WaVpfQeBvZAZbFWOw3T
 xVe9ExW04Ozf6yq2u38HOXE7TP47Vbc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-bqdFRah6OHari6RDB_L5NQ-1; Mon, 27 Jul 2026 08:50:28 -0400
X-MC-Unique: bqdFRah6OHari6RDB_L5NQ-1
X-Mimecast-MFC-AGG-ID: bqdFRah6OHari6RDB_L5NQ_1785156628
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e82060977so279685685a.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785156628; x=1785761428; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x0rLaDAi5KlijnkCnuqS97k0mLitSR/GOJxO5gH6eys=;
 b=Zp3AiSf1YFaixjyoIr1JulSasCp45HKLnGt81io2GaHH2wtH0+4u2+HN/4Y+Zo7NNb
 E33MVlrgJmiyZJmf3+IwJ9N4brL+170gJ6YdQKjUy2q6yYo9V3W3FAYMeqCbVwuCzRf9
 p8DqW5m0QGdFyrFyWxqCdIhd7seKin0PoJnTmtcaQnaaS8dVjdY8e3uANiwTTONN5x/Z
 8wfpouoASiFLEIhL535p+xK7NnzlKYPUeoNJvuEuHT59eiXW64DkVNsWTJGIgfhPK9vi
 BpEwyqjHgTYx4ZmMPr7LCFZCcGlGowibnflxFqSK/XLoo6336atY4RMUucYgBI3/6Pi8
 NUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785156628; x=1785761428;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x0rLaDAi5KlijnkCnuqS97k0mLitSR/GOJxO5gH6eys=;
 b=RxePWFciZ2mWXmc2aS/WukQNIqr/NvOWbsgKNLwjjuL/39tUD693iAR7WFIcyOr1Ut
 5yBvODwlbXsI+k6ZwGiVTCreb/Yk9TgJUy4zjsyjMnDcqWbkAnXFLVvz2NeG2n7AgiWg
 zAVSyoWO4wRgMjmSOR/D6CYSk5qjHK0E30gegDWXiCHu2SOSC2zy/ICMhpYSGz/YejEV
 z47wr+TmXyEGU6X6YY0XQ0tuDY/CSRVyVeJi3ihPCb8vsfNjjcx1mlu+YudZCIe4dAwn
 jRBOpGGy3/xL23vEi4RoUGNkt/ylyj0C5IUS0lVpngP+KV1TyONcyJrZj324smSlIwt5
 Bgkg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFNpTEvzYeJBL5crbIUs8lj/0+ZgkxIFldU61CqejmMokJ2bKmMNRensA93gEeEzWCBpJGEP6YeXwV@nongnu.org
X-Gm-Message-State: AOJu0Yxk/znsZDtILDsvVBULmDauSZI92p1uS63MiXIfT3IEV4Pi23SY
 lgdFE2w79xW/JJHEg184QhhSGvPcM6KEQJzcYfDyevleEoaUU91LAQUAKUd69bcJU54Zz9wMWv5
 LLlCBStcb58M5NklUHysIpuDHUbIaoiHBE4OfLzc9vUh/IEkTN6t51/Hj
X-Gm-Gg: AR+sD11jsvPHV3DMHotqbJ/L0RGvFXk6oZA3sYhBNcfDZHEHvwW51GnaFQTUX9mkqWn
 aDFv5xR5SVzcv85j3ZWQxizcpAnG2PMYwGMo3s3lkCQ/vw907S1eLi7XXZyju1AWxvP0Ei+WBJq
 gXMZhnCMtC83vK+G9DyrvOY/r743z3s2yO8SEzX7MuKk0buS3xN6xg6oW89pkuhv9N7cDOI/t6o
 QaaurDYVeAYR2gMmTc8mLChUwf4HwzhVsIKfnQ9BWuntxWwSKzGyTnkULxyJ4IpcoMkb1slKtsB
 6UgMxs2IpIYECbqOSRIalloSbEAPvkX2yZYngfbB6qA7oj4O+90l/RhJa+FMJp9V43zx
X-Received: by 2002:a05:620a:2906:b0:92e:e307:5122 with SMTP id
 af79cd13be357-932918e14aamr1118664385a.28.1785156627498; 
 Mon, 27 Jul 2026 05:50:27 -0700 (PDT)
X-Received: by 2002:a05:620a:2906:b0:92e:e307:5122 with SMTP id
 af79cd13be357-932918e14aamr1118660185a.28.1785156626947; 
 Mon, 27 Jul 2026 05:50:26 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de6729ebsm609880585a.42.2026.07.27.05.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 05:50:26 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:50:23 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 farosas@suse.de, mark.kanda@oracle.com, bchaney@akamai.com
Subject: Re: [PATCH v2 1/1] migration/cpr: Add HMP support for cpr-transfer
Message-ID: <amdUD8Q2alnR4yBs@x1.local>
References: <20260724094119.90581-1-dongli.zhang@oracle.com>
 <amaqaePN2wAWoUCN@gallifrey>
 <793f2d27-cf2e-4e27-ac4e-e94fa6db0e05@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <793f2d27-cf2e-4e27-ac4e-e94fa6db0e05@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 27, 2026 at 02:14:27PM +0200, Maciej S. Szmigiero wrote:
> On 27.07.2026 02:46, Dr. David Alan Gilbert wrote:
> > * Dongli Zhang (dongli.zhang@oracle.com) wrote:
> > > Currently the cpr-transfer source QEMU instance cannot be driven entirely
> > > via HMP.  The source must use QMP in order to specify both the
> > > main migration channel and the CPR channel.
> > > 
> > > Extend the HMP migrate command with an optional CPR channel URI. When the
> > > migration mode is cpr-transfer, HMP uses this URI to build a
> > > CPR MigrationChannel in addition to the main migration channel. The new
> > > option is rejected unless the migration mode is cpr-transfer, so existing
> > > HMP migrate usage is unchanged.
> > > 
> > > For example, source QEMU HMP commands can be something like below. The
> > > "-c unix:/tmp/cpr.sock" is for CPR URI.
> > > 
> > > (qemu) migrate_set_parameter mode cpr-transfer
> > > (qemu) migrate -c unix:/tmp/cpr.sock tcp:0:50002
> > > 
> > > Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> > > ---
> > > v1->v2:
> > >    - Use the '-c' option in the HMP command reference.
> > >    - Use "a second uri can only be used in cpr-transfer mode" as error
> > >      message.
> > 
> > Thanks for making those changes; minor note below.
> > 
> > >   hmp-commands.hx                | 12 ++++++++----
> > >   migration/migration-hmp-cmds.c | 19 +++++++++++++++++++
> > >   2 files changed, 27 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > > index 7ae2468a3d..7f43cf537f 100644
> > > --- a/hmp-commands.hx
> > > +++ b/hmp-commands.hx
> > > @@ -928,16 +928,17 @@ ERST
> > >       {
> > >           .name       = "migrate",
> > > -        .args_type  = "detach:-d,resume:-r,uri:s",
> > > -        .params     = "[-d] [-r] uri",
> > > +        .args_type  = "detach:-d,resume:-r,uri-cpr:-cs,uri:s",
> > > +        .params     = "[-d] [-r] [-c uri-cpr] uri",
> > >           .help       = "migrate to URI (using -d to not wait for completion)"
> > > -		      "\n\t\t\t -r to resume a paused postcopy migration",
> > > +		      "\n\t\t\t -r to resume a paused postcopy migration"
> > > +		      "\n\t\t\t -c to specify a CPR URI for cpr-transfer mode",
> > >           .cmd        = hmp_migrate,
> > >       },
> > >   SRST
> > > -``migrate [-d] [-r]`` *uri*
> > > +``migrate [-d] [-r] [-c uri-cpr]`` *uri*
> > >     Migrate the VM to *uri*.
> > >     ``-d``
> > > @@ -945,6 +946,9 @@ SRST
> > >       query an ongoing migration process, use "info migrate".
> > >     ``-r``
> > >       Resume a paused postcopy migration.
> > > +  ``-c`` *uri-cpr*
> > > +    Specify the CPR URI for cpr-transfer mode. It must be a UNIX domain
> > > +    socket.
> > >   ERST
> > >       {
> > > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> > > index b04fc4489f..4ca2c962c2 100644
> > > --- a/migration/migration-hmp-cmds.c
> > > +++ b/migration/migration-hmp-cmds.c
> > > @@ -837,9 +837,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
> > >       bool detach = qdict_get_try_bool(qdict, "detach", false);
> > >       bool resume = qdict_get_try_bool(qdict, "resume", false);
> > >       const char *uri = qdict_get_str(qdict, "uri");
> > > +    const char *uri_cpr = qdict_get_try_str(qdict, "uri-cpr");
> > >       Error *err = NULL;
> > >       g_autoptr(MigrationChannelList) caps = NULL;
> > >       g_autoptr(MigrationChannel) channel = NULL;
> > > +    g_autoptr(MigrationChannel) channel_cpr = NULL;
> > >       if (!migrate_uri_parse(uri, &channel, &err)) {
> > >           hmp_handle_error(mon, err);
> > > @@ -847,6 +849,23 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
> > >       }
> > >       QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
> > > +    if (uri_cpr) {
> > > +        if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
> > > +            error_setg(&err,
> > > +                       "a second uri can only be used in cpr-transfer mode");
> > 
> > That should probably be changed to something like
> >    "-c can only be used in cpr-transfer mode"
> > 
> > but other than that,
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > (Feel free to take it via cpr or migration).
> 
> Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for CPR
> 
> I am fine with this going in through migration tree if that's not
> a problem since there's currently nothing else for CPR.

Yep I'll pick this up for 11.2, thanks all.

-- 
Peter Xu


