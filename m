Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5DAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 18:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1W8S-00009v-Ta; Mon, 29 Apr 2024 14:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1W8R-000080-9H
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1W8P-00012G-En
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714416832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sy776144xV0oqZJKQzybkiRAB8DgdEn3vbj01tReeG8=;
 b=JeHH9HzfzAUePWlzjH2uAkf7Ik8mcEyJFtDnn86osZxdbUpVuxhOQ+alN+x+OHsM5onNUM
 Jl9xfqb+MGCZgmk8NYtse2mVQ4Em9sHrbZGd10hJb27+ha/QRSjxmRNpALttqVhRBhpSZ4
 6S9O2/ng0Rb6HMGNyrDts2rEZz1E13M=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-t4nrkT5rMAitaU6OmIHARg-1; Mon, 29 Apr 2024 14:53:50 -0400
X-MC-Unique: t4nrkT5rMAitaU6OmIHARg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6ecfaccf30aso530077b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 11:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714416829; x=1715021629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sy776144xV0oqZJKQzybkiRAB8DgdEn3vbj01tReeG8=;
 b=Es8coHktEqD68rdKHQAe9v+LoFo7eu2In4X6Laxg9Sw7+dePITfT63dC2eqiVSHX4p
 5oxHFRqf1jZJL9ruym/5aJlCdO58t/s5G1xaoKaJ2jMrvat3lH6RDmWksL8vT1kV7uUD
 9GHZ1KynMWoePjchJDRhTSJGS7zbjkIMmGNZmIVIsnZJV61wk5cG5sBNGkpbSu6o4G4R
 wPHuYchY9zbZ2DvZxVR+zktKVzK5wfG+Q7G38OhFCf2slJskaF/GL1Wd9S9n0tnH4Niq
 0Wp6BngAgHwrpnk28lIIXlodb0I/UJC7bB4EMrk4uiyQz3mMV8LZCYMMNcTMvsoWxoG6
 fPnw==
X-Gm-Message-State: AOJu0YxwRVR0bFs3QPEEtOL9q+X11K7h/UdjnRDV9EevCZ331IS+/InL
 6ch6LP1eOb969DPuUQpqPAymE8b+nfeLTltyEQSNZLjLKtJsFc4FXJ4p9XlPMJmM9qGl5THzeVE
 lcmVE1YzscmK6xvKuugcprnuUXYx8C1ctjwo40Mfs/4RedvM5EnWXZ242ZF+I
X-Received: by 2002:a05:6a00:987:b0:6ea:df65:ff80 with SMTP id
 u7-20020a056a00098700b006eadf65ff80mr12343537pfg.3.1714416829302; 
 Mon, 29 Apr 2024 11:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwsdKEJo8JImk7g8WhimWzZz3RncPa5MYOW0fJAqGJggSx+eY8eB77IhMWt3z4fP+K9lmTTA==
X-Received: by 2002:a05:6a00:987:b0:6ea:df65:ff80 with SMTP id
 u7-20020a056a00098700b006eadf65ff80mr12343509pfg.3.1714416828712; 
 Mon, 29 Apr 2024 11:53:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 h3-20020a056a00230300b006e6be006637sm19632091pfh.135.2024.04.29.11.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 11:53:48 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:53:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 devel@lists.libvirt.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 3/6] migration: Remove 'blk/-b' option from migrate
 commands
Message-ID: <Zi_suPZDZIJ8f6FI@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-4-farosas@suse.de> <Zi_CNIYAi6UbxJ0j@x1n>
 <875xw0f5oe.fsf@suse.de> <Zi_mmpmW4XIKpXmo@x1n>
 <8734r4f25l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734r4f25l.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On Mon, Apr 29, 2024 at 03:35:02PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Apr 29, 2024 at 02:18:57PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Fri, Apr 26, 2024 at 10:14:05AM -0300, Fabiano Rosas wrote:
> >> >> @@ -2003,21 +1997,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool resume,
> >> >>          }
> >> >>      }
> >> >>  
> >> >> -    if (blk) {

[1]

> >> >> -        if (migrate_colo()) {
> >> >> -            error_setg(errp, "No disk migration is required in COLO mode");
> >> >> -            return false;
> >> >> -        }
> >> >> -        if (migrate_block()) {
> >> >> -            error_setg(errp, "Command options are incompatible with "
> >> >> -                       "current migration capabilities");
> >> >> -            return false;
> >> >> -        }
> >> >> -        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, errp)) {
> >> >> -            return false;
> >> >> -        }
> >> >> -        s->must_remove_block_options = true;
> >> >> -    }
> >> >> +    s->must_remove_block_options = true;
> >> >
> >> > Can we drop this var too?  Perhaps with block_cleanup_parameters()?
> >> 
> >> Yes, Markus mentioned it in v1 already. Take a look there. There's
> >> several other declarations I missed. v3 is coming soon.
> >
> > Right, noticed that it's removed actually in the next patch.
> >
> > But iiuc it can already been removed in this patch.  If we want to remove
> > it in the next, logically we should set must_remove_block_options=false
> > here, though..  So maybe easier to just drop it here.
> 
> Ah I see what you mean. I thought you're just asking for the removal
> overall.
> 
> But block_cleanup_parameters sets the block capability to false and the
> whole block migration only goes away in the next patch. I think we need
> to keep this as true to preserve behavior. In theory, after this patch
> people could still use the block migration just fine by setting the cap.

I'm reading this patch the same as "blk==false" always above [1].  In that
case, only if we keep must_remove_block_options=false could we maintain the
behavior?  Otherwise at the end of migration (or cancellations) QEMU can
wrongly clear MIGRATION_CAPABILITY_BLOCK bit if the user set it manually?

(But hey, we're discussing whoever applies this patch only without the
 rest..  definitely not a huge deal :)

-- 
Peter Xu


