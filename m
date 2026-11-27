Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDA606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CcQeg35k;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L4NGKMnm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxQ6-0000kZ-Ky; Fri, 27 Nov 2026 09:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWxPw-0000iU-Ci
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:59:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWxPu-0000j8-Hn
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795791553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lXQ9Dnqk/I/Tg/CDwmHQbjlMeLlLy3kkvvjaenG5sNI=;
 b=CcQeg35kZ1TZq3M5W6J0+zz05X6bNHCizrrMBWbaBLujXygjQqsDhQe0za+CpdBoRvh65X
 dVHjGX7uo28P5NJyn80+FrCkb5n/v6jB23bQ2eQEiHGHU56SLMYkP4dIp4vgyWxwVxqOBc
 IOoSYbBI2EjSZEwv5uQckC54opurHgY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-0LJreuiKNy2q0-SgSeb4Dg-1; Fri, 27 Nov 2026 14:59:11 +0000
X-MC-Unique: 0LJreuiKNy2q0-SgSeb4Dg-1
X-Mimecast-MFC-AGG-ID: 0LJreuiKNy2q0-SgSeb4Dg_1795791551
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-949b0d3232fso1117379385a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795791551; x=1796396351; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lXQ9Dnqk/I/Tg/CDwmHQbjlMeLlLy3kkvvjaenG5sNI=;
 b=L4NGKMnmYyhVAguAyjeL3erh8qI8aQjWPfkshrBB30Bf/Sa6sgsu1b//wAfcC8BOcc
 CGeLtbMaBsrE6zgcTsj1LX7uBVBXYVRWn0iP8AYEoqk+ouSZH0Jq2vvZDzmyfjbPOj9k
 72WpoBY/96w8Lgl2aX82m4N0Mj+hCwKPu2fEZmbTWjbDpGO7DtaU9y3RDeDo9EyRgGDg
 Lku/67vJl9s9Q8wnyy69/vWTphHThUxKDy8IxH+iCXuj/kOIZpOEGGPEAxEnCkVUuabL
 zWleTfxZ6MiQUjF6yg7YTei05s2b1/mpzEc3o5/kPhNKj9sxyuv/tLEa/tZSUOcKUxzX
 vHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791551; x=1796396351;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lXQ9Dnqk/I/Tg/CDwmHQbjlMeLlLy3kkvvjaenG5sNI=;
 b=EnZCS+ZYhQQQ+A9EJJJzvHOxuH9IQc4MOzbpR9JtRCUkL29H/ItJfvOYQhnrGN5Fhf
 IBId2YXETGmQ4BSrf5b1MUmI2040ChXlg/oPrhEAv6MY0L35HU4dMw0N7TCMo+w8tA2d
 bGdTKpMY3Jo5EkNCcpdKeZG1fpP4SZURyb+nR4XJ1YsdA1qGj2kl3bM4b7LtJG1M+l+e
 VVvWvoOzVqla5bB4BzriiYW74nRbGhDXiC1hkAI+UfPWagkjbsbX35+4LVz5zVKgwd07
 Hhy7viOqGj42k+BQCRpVGSjkxcZov82sj5/jT0nWfecKwOelQBEB2DyM5HeQpGHGWnUv
 CYfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGAeW0lCvgVYt2PuI/zWiFydsm79HAxnePoy9YCvWipD+sL6r+16WNR7DXysXWPnzgROHuy9FNyXZld@nongnu.org
X-Gm-Message-State: APuU4Z/IPB1qX3EygnptqZx5fPdVOpFbHnqqfk3OQ9ek4ejYqR3udJfq
 TRhEiQvOtvIBOHjP6l6LjwVZKgIwJEjHZ9hUpSG9RVkYoonkKwN2E/JgRSFNZUDRDd3go6jGHtk
 RMQ6G5UfH/8HynPsCorQX5mVxUHVniLW3IXUe3TlZfqepvcJGWtuonOYR
X-Gm-Gg: AZFdTZeJ8ZOciq9oEZkA9oRllNJTD2eICh+mx0PWPveA69CJYss0BuoX2SYVFjY03Km
 kZiVN98ggueVsUTi1/KpJlUQGZXBszg/F+yyTzThvLUTCE24DctX6HmMppo/gJcij0Yg7OXri2J
 qVjbjwf2kmKzGuHZvchKB9dYkCxnMpX0fqVj0arWYDO/JFe3SmznWeZZYgXTUQGZPEXSBIN77QO
 YFj9I+3202G1lA6td3vpb5Du4Qu9eewuW4S2ZEeLLBOiYEdbefXetKD93gQD48ky6OhZQu7eTQL
 sOZ5QmNqTj81ZPJ3Q1gYTRVUJ94w3m8P/S1yAAXu1KTaxSRYMgqVDZhiE6GA+WKzPOCS6pW9DLf
 aKAf1ruubyJasjZyQuICWRqcOZpBLtvou0V+/30J8vTD1EQ==
X-Received: by 2002:a05:620a:8398:b0:93f:22f4:f0cb with SMTP id
 af79cd13be357-949bab1dae7mr4559581185a.43.1795791550608; 
 Fri, 27 Nov 2026 06:59:10 -0800 (PST)
X-Received: by 2002:a05:620a:8398:b0:93f:22f4:f0cb with SMTP id
 af79cd13be357-949bab1dae7mr4559574685a.43.1795791550052; 
 Fri, 27 Nov 2026 06:59:10 -0800 (PST)
Received: from localhost ([2605:8d80:6cc7:75f8:8c4a:4476:f571:f0d6])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb40ea12sm1853464085a.35.2026.11.27.06.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:59:09 -0800 (PST)
Date: Fri, 27 Nov 2026 09:59:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/2] migration: fix a source hang on cancel before the
 channel connects
Message-ID: <awmauxutUY7F_kfp@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261125193102.1423555-1-den@openvz.org> <878q2gsdak.fsf@suse.de>
 <6314eded-6904-4722-92f8-8db90cc4688b@virtuozzo.com>
 <8733snslnt.fsf@suse.de>
 <awiJUEoMb3WxUjPo@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87y0afqoho.fsf@suse.de>
 <awl2GemtkJBdjcXk@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87v75iqw0h.fsf@suse.de>
 <awmFhmY655FPdXI8@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87jylyqrsb.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jylyqrsb.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 11:21:08AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Nov 27, 2026 at 09:49:50AM -0300, Fabiano Rosas wrote:
> >> >> One of the cancel tests issues migrate_cancel(to), that puts the error
> >> >> in s->error and since QEMU keeps running, a subsequent migration
> >> >> crashes. We free the error at migrate_init() and migrate_prepare() for
> >> >> similar reasons I think.
> >> >
> >> > But this is migrate_incoming, which means if something got wrong, instead
> >> > of retrying, we should kill the qemu and re-initiate?  I don't know if we
> >> > could have other loopholes on this path to be invoked more than once.. as I
> >> > never expected it to run twice (either success and take over, or halted for
> >> > query error only, or killed).
> >> >
> >> 
> >> I think this is only about calling cancel _without_ any migration:
> >> 
> >> $ (echo "migrate_cancel"; echo "quit") | ~/qemu-system-x86_64 -S -monitor stdio -incoming defer -trace migration_cancel
> >> QEMU 11.1.92 monitor - type 'help' for more information
> >> (qemu) migrate_cancel
> >> migration_cancel 
> >> (qemu) quit
> >> migration_cancel
> >> 
> >> So a state check in there could be good enough.
> >
> > Ouch, so it runs through even without migration? :(
> >
> > If the "state check" you mentioned means failing migrate_cancel() when
> > !migration_is_running(), I definitely agree.
> 
> Are there any consequences for the user in failing the command? We could
> also simply skip.

The thing is migrate_cancel() with no migration at all is more or less,
wrong...

If some test runs it and succeeded assuming it cancelled something, but in
reality the migration didn't ever start, it could be a test race / bug,
there's OTOH benefit changing the ABI to start let tester notice something
wrong with the test.

So if we don't breat libvirt in any way (hopefully!), then I think we can
still do the ABI break, considering in good way, at start of dev cycle opens.

> 
> I'll pickup patch 2 from Denis and put into a series along with this^
> check.

Sounds good!

-- 
Peter Xu

