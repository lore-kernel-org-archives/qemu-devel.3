Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B613CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU9rb-0004hI-5q; Mon, 01 Jun 2026 17:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wU9rX-0004gn-Oi
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wU9rU-0008Eo-MW
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780348068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PsFam362ubese9gGiHBA3kwAT7GbDoBwsOcTzymT1A4=;
 b=ZawJ4qbAU6uVuPfyJJF8ieJlx9AHPH+FzMFpThUFyqJM5MC34vniZutrIeaqo5D8QFcTgK
 qNTxRvFXyWcCEo4nl2yYLzGmV84xoq0NjIVs5yT66fVm1dDaw7lSGnlakAojVLSvlkmdV4
 MJLSr1K+pgh/0j8RpiKDxMO++NFPpeI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-HZj3BY7wMJyxbcxp6JxbXA-1; Mon, 01 Jun 2026 17:07:47 -0400
X-MC-Unique: HZj3BY7wMJyxbcxp6JxbXA-1
X-Mimecast-MFC-AGG-ID: HZj3BY7wMJyxbcxp6JxbXA_1780348067
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51760f997fdso18890261cf.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780348067; x=1780952867; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PsFam362ubese9gGiHBA3kwAT7GbDoBwsOcTzymT1A4=;
 b=TiFqrtdQZmrY4Da9dAKOavBa61E+hVy+xyb3UOMYZNMECXhVGFJgpxJRghNyfRbPAB
 0o2e9aiwJuUvrthhQQ5KmLXZjnpp7lZBD8RL9yyUc0NJ0yHZIk1RbIoKbHCjcz1+WgwN
 cUJYm/DjN93G5FqtpAVsYYxKjG7dro1wpXLKL8Ciyvrx+i9x26O+AUWJgjxEwJ5WKwy9
 T0hkIrBeTZ6nr52W7/RT3/bdTICpn4K528sO4lqjl3vToXmvgtXyPm5FCok7ZAqmwgc+
 gLmAktSoLFNz1dIZxFQ2WC5DBFNQ+eRTKBHdTe1Y8OD9gq45qtB0t2HnvGyteZ1M2i6z
 jY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348067; x=1780952867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PsFam362ubese9gGiHBA3kwAT7GbDoBwsOcTzymT1A4=;
 b=VywlTfI7lB/KJgeeAm3pSNwWKe3wo5CeMeaNEDxTc6cyF5tIg0q6+lQimLLMX5eiZj
 DKGHQpIAueCAjhDNFaAfWPz6Z0oWBTqmjpNSZRbRsalImDLAlFzXsjcoaJUWERlB2TJB
 WvBp67bG7pZk25aZ+rd/pfdzH4e6rQZaVgN8aJy/GA7wUZGN8OWpAN8f+pcueAEgLBX+
 a4TpqSwmOsjt5xqqAt9Rt5Bzv5OAkuUKq5qT4mpfrt5PdMRo/2dD819fLjQ55XhOBGhD
 ZEYxX8umMwRipxCVg8AUFJT/PZ6FcnW8ItrVIs5yUW+/d+4dti2ORH6DpcCl5IjIhI1+
 Fz1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8A0GJj6RtrtKzjdoK7f+6JejAVeyjUyfMc+e9LR4Tc9VUsUrgIxPTpxZxcPTu+eTLsJvQoGAh8wpiY@nongnu.org
X-Gm-Message-State: AOJu0YyFsWKpH2QSF+NYHZRW9G2uS6s/ibVyVFdJ1q1JwfrMOdBpGdQ/
 havuFVWZNUCMDF3RviLXWblaxTXCGiQ30OxqCNBfCa9aye8GE1uKMIgQ1tFsEO75dEa49EKVU1J
 0bcVcQ5POddXz0cMfq7U0EP4KPLxmDr98M1hexOvxw4TzXLJp4thWI8ow
X-Gm-Gg: Acq92OF3uLwUUEkVznhvlZGOjsQO44G1nToFIVrYP1mP3Wo2zSd9Hn414OA2rC6R56U
 UtRK/yyw5bYKscljaHu4yDeFp/EPVgZhhE2L0jkxylwWaqi7+RZbo411Xg1uxFpU76et7IIFwr7
 hFmmn4K/DvOo13v/1MI0qbyQMbiVCC3xKSqX9qlPU6kfvPUzLK3XnfC+YD53b4DtqN4UajMRyf7
 5g8SwsUe9KyASSm3mqr2uNv2f+ozq5NFpeuA3BPeIoORJkbLlGVJrtZNwh3NiCgXVsQ0LY2acdv
 KMEnLtYt+ENYPxj9fVtHqrhNnvTn+M2lb/oToJMrRTxarAJUFz7Hy6upzy9pexyl9mDrayCcwIN
 19Hox+fBvVl3XG7HvXqyTJ1iBKA==
X-Received: by 2002:a05:622a:17cf:b0:50e:a1ab:67ea with SMTP id
 d75a77b69052e-5173a7d7d8cmr183933711cf.40.1780348066973; 
 Mon, 01 Jun 2026 14:07:46 -0700 (PDT)
X-Received: by 2002:a05:622a:17cf:b0:50e:a1ab:67ea with SMTP id
 d75a77b69052e-5173a7d7d8cmr183932851cf.40.1780348066344; 
 Mon, 01 Jun 2026 14:07:46 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51741de5b6esm68380521cf.30.2026.06.01.14.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 14:07:45 -0700 (PDT)
Date: Mon, 1 Jun 2026 17:07:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <Alistair.Francis@wdc.com>, Zishun Yi <vulab@iscas.ac.cn>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] target/riscv: Add mseccfg to VMStateDescription
Message-ID: <ah30oAWataEPHDfu@x1.local>
References: <20260511124828.3210477-1-vulab@iscas.ac.cn>
 <bcc0aaa1-8d1c-4f52-a681-85bc903c8d66@tls.msk.ru>
 <6e42ecc1026a057e07e73386463bd57e1467a46f.camel@wdc.com>
 <bf46f39c-6173-4cfd-b374-63529892a1fb@tls.msk.ru>
 <87ecix59j9.fsf@suse.de>
 <da24799f-dd23-49b6-8e7f-65d757721d3d@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da24799f-dd23-49b6-8e7f-65d757721d3d@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 29, 2026 at 10:43:13AM +0300, Michael Tokarev wrote:
> [Trimmed the Cc list a bit]
> 
> On 27.05.2026 15:20, Fabiano Rosas wrote:
> 
> > There are no migration compatibility guarantees for an unversioned
> > machine type. Only migration and snapshots from same-version QEMUs are
> > expected to work in this case. Other scenarios may or may not work.
> ..
> > 
> > The addition from this patch is in a subsection, so .needed will
> > determine whether it will be put on the stream. If we backport the
> > change, then the stable QEMU build will (likely) start sending this
> > subsection, which the old, non-stable QEMU will not recognize and
> > migration will fail. Migration from stable-stable would likely work.
> > 
> > So any stable versions that (would) contain this patch are likely to
> > block migration from that version into an unpatched QEMU.
> > 
> > Note that since the machine is unversioned, migration from QEMU x to
> > QEMU x+1 is already prone to being broken.
> 
> Yeah, this was my understanding too.
> 
> And given all the above, I think we should apply the fixes to the
> stable series, and treat this as changing version (the version is
> actually changed, but only the minor version).  Yes, the VMs wont
> be migratable between 10.0.9 and 10.0.10, exactly like it was
> not-migratable between 10.0.x and 10.1.x.  Because basically, with
> no versioned machines, there's basically no migration capability
> between different qemus *at all*.
> 
> When we do have versioned machines, we can't add fields to previous
> versions anymore, exactly because of the migration guarantees.  But
> as long as we don't, there's no guarantees at all.  And the only
> place where migration can be done is between different hosts with
> the same qemu versions.
> 
> The above description leaves one question still.  What happens when
> migrating from unpatched qemu to a patched qemu?  Will the migration
> fail due to missing field, or succeed, making the missing field to
> have a default value?
> 
> If it will succeed, then we definitely should add the field to fix
> the original issue.
> 
> BTW, can't we just skip, at the receive end, fields we don't know about?

We don't have enough info to skip.

We have headers for VMSD, we don't have headers for VMSD fields.  We
currently dump fields with pure binary streams.  It means when there's a
new field added to migration stream, dest QEMU has no way to know it's a
new field, it'll treat it as the next thing it expects to see, which can be
anything.  We still have the VMSD footer to guard us making sure it don't
bleed outside of the current VMSD, though.

> 
> But all this is.. well... sort of moot for this very change already.
> 
> I haven't realized that this discussion is about a change which I
> *already* applied (I wanted to revert it until this question settles,
> but I forgot to do that!).  And meanwhile, I released the next set
> of stable qemu releases, with the changes in question (two of them)
> applied.  It wasn't my intention (or else I'd not start this
> discussion in the first place, obviously).
> 
> So we do have this migration breakage already, "thanks" to my sloppiness.
> 
> And I don't want to break things for users for no reason.  The original
> issue were described as a security issue even, so there's a reason to
> fix it.  I think.
> 
> But in the future I'll try to be more careful about such things.
> Again, understanding the machinery and consequences helps here too.

Before machine versioning is introduced, this looks like the right thing to
do.

Thanks,

-- 
Peter Xu


