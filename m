Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87779606A339
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fRabIGIL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvAk-0000uh-Ni; Tue, 24 Nov 2026 13:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVvAi-0000tB-Ka
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:23:16 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVvAg-0001N5-VD
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:23:16 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b894a5ce3dso6608747a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795544593; x=1796149393; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MP+m4Asao+3RWB2CqcWF0+IoZJje9lNxxgSHgbGIP0o=;
 b=fRabIGILkCMohrlbcXm3xYjCwJ09y0VW4HFl2SOUjFu2n0uFdRHILINwkDsxOevNV1
 CVUZtxcT4Td6+uL8a5EbrypEUMiA2+T7sAOppqX0FJJ570Ihj7X93XNWtKHERACMbTM+
 egEegLKEhb11FkjnOMZQZ7nD+swwCT6dWrWm+yg8w+AeP7BVC7TwcrqmimFsxyA3h7/R
 6d00f9OOLoOff5/d/W9dZrOGNZLuXpdPY7uqzhjqFZ9efpZm9TfMO/CxDMx3df59PrUM
 eUNUwIlebIOeISG9TbjEqhlleAqlIXwyOiNRN2qZyA6jUbgjn1tEdg9+nErUJohKQ8LS
 pe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795544593; x=1796149393;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MP+m4Asao+3RWB2CqcWF0+IoZJje9lNxxgSHgbGIP0o=;
 b=v759TV9B/0/MGMz4uiQP/E3YmKdbOj1OhK/rZKFmYBp1DdLsbO6XMp2Ku5yeW44o0+
 K6cYaqtPX9fm85mqlcIS5CSfmQ5j68HiOm/qaww4VjM5/wFixYLiMuXZX963x32+ZZ0L
 ymJ4hsou34sga2y7JnplI5IDgTUR3Iwnd1WTwLXcXfLXYledzDkG2Xrt61oEYH++4tiU
 AN1Kza0VqkEFhBG3Ds31sjxJsw4hlf9i7k9J6YitNgSt9SukRcDlzwAPeT/1ASdL9Edj
 iBpj7BlDGXHggEl1YRtaI+6gnnV0Z7j1HaxX9YduMyfDX9PjCZaumMqYJ8xisivYKbeE
 BBvw==
X-Gm-Message-State: APuU4Z84h4XtsYLVOSX4se/fRi5MB/M20Xnx+Y/kKEMQwVgTvefuqtpp
 ggg627WgqxRe49mv35Kct5SZJCSnMvQYg2kLrcu9EE2tnPbfq8m9IhVa
X-Gm-Gg: AZFdTZfznlyx6rbhwJPQVguKiC9aMzyi51IzCTTYzUv/0Ef6LJiCO5nI1Kqk4QYfw5u
 h13/A/BsC5flCAF/E5/u9bdtGMKCG3OvOtXrpj0ToVt3kLsgd5vY9Tn44I4gBRr7G1ZGcapyAXm
 Je1IDT6y6tZ3xRDYG78dp7R+vQB0EBs0wV34U3MepiVaUJk3hFNLGzNIgeRKiTKuFKTobN5liRb
 EadGM/tXWZUvDhybF6EFpsXFyLGx0xXVl/WtR2Eme/+HtaeaeyybuY6y+FWGXq+Wk7eX9nnV2aL
 4SPmwqBdTcC3D36AvRF7SH0V3BA+hsmXedgycgZAvHRBkpJt8cG9BTtdtofUpzIuz/S8kJpQKEP
 xew9JyOkJ+9XKGgjLPeOFxpFaNoSepmAjlsYPxbcMx9KS28gtUE+qewssQhmz8ydZ851Ju59QjC
 1rWkDQFxzd6cHLFp/Uh/nvd3FLLWTExgrSJwMd+Um1+MCx9QSHzMXU3cO3WNJQmWwajdHaC77Bd
 BhB0kUsf6H8SI8pazUa7WyVazMn/tQ1hVy0glj0zP7o2sZw0/Xv9KB8TvMBmNfS/M+6V3aawO1d
 Oc9T5dDCw00x2G35br/YeNOxbg5iuxT2p5DXi/g7tFqLd/wMC52jbjbUl+yGZQaoQ/VEfLV2NT8
 nbghrG9yqnShbmmIhnoEBQQK5zw==
X-Received: by 2002:a05:6402:2744:b0:6ba:9b98:7235 with SMTP id
 4fb4d7f45d1cf-6ba9b9875c9mr6669858a12.19.1795544592177; 
 Tue, 24 Nov 2026 10:23:12 -0800 (PST)
Received: from tulp
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8adbsm7145753a12.17.2026.11.24.10.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:23:11 -0800 (PST)
Date: Tue, 24 Nov 2026 19:22:36 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Markus Armbruster <armbru@pond.sub.org>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 3/5] qga: implement 'guest-get-disks' for FreeBSD
Message-ID: <awXV7HO6PXkc8XPC@tulp>
References: <20261122090511.15121-1-bogorodskiy@gmail.com>
 <20261122090511.15121-4-bogorodskiy@gmail.com>
 <87ld6ifr14.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ld6ifr14.fsf@pond.sub.org>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Markus Armbruster wrote:

> Roman Bogorodskiy <bogorodskiy@gmail.com> writes:
> 
> > The implementation uses the "kern.geom.conftxt" sysctl.
> > It resides under the "#ifdef __FreeBSD__" block as
> > other BSDs do not have GEOM.
> >
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> 
> [...]
> 
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index 4856a549a6..35aaa040cf 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -947,7 +947,7 @@
> >             'media-errors-hi': 'uint64',
> >             'number-of-error-log-entries-lo': 'uint64',
> >             'number-of-error-log-entries-hi': 'uint64' },
> > -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
> > +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
> >  
> >  ##
> >  # @GuestDiskSmart:
> > @@ -961,12 +961,12 @@
> >    'base': { 'type': 'GuestDiskBusType' },
> >    'discriminator': 'type',
> >    'data': { 'nvme': 'GuestNVMeSmart' },
> > -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
> > +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
> >  
> >  ##
> >  # @GuestDiskInfo:
> >  #
> > -# @name: device node (Linux) or device UNC (Windows)
> > +# @name: device node (Linux, FreeBSD) or device UNC (Windows)
> >  #
> >  # @partition: whether this is a partition or disk
> >  #
> > @@ -987,7 +987,7 @@
> >    'data': {'name': 'str', 'partition': 'bool', '*dependencies': ['str'],
> >             '*address': 'GuestDiskAddress', '*alias': 'str',
> >             '*smart': 'GuestDiskSmart'},
> > -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
> > +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
> >  
> >  ##
> >  # @guest-get-disks:
> > @@ -995,13 +995,14 @@
> >  # Returns: The list of disks in the guest.  For Windows these are only
> >  #     the physical disks.  On Linux these are all root block devices
> >  #     of non-zero size including e.g. removable devices, loop devices,
> > -#     NBD, etc.
> > +#     NBD, etc.  On FreeBSD these are nonzero-size GEOM DISK and PART
> > +#     providers (since 12.0).
> 
> The (since 12.0) applies just to the sentence about FreeBSD.  Rather
> subtle.
> 
> Elsewhere in this series, you don't add (since 12.0) when you implement
> something for FreeBSD.  How useful is it here?

Yes, I have to admit that I was having a hard time deciding where to put
that.

This series actually adds "@bsd: FreeBSD (Since 12.0)" to
"@GuestCpuStatsType" but that was an easy one as it's definitely useful
to know that the new type has appeared.

For the rest of the entries I'm not really sure. The example you're
referring too can be confusing indeed.

Should I use something like:
 
# Since 5.2 (Linux only); 12.0 (FreeBSD)

or omit these completely? 

> >  #
> >  # Since: 5.2
> >  ##
> >  { 'command': 'guest-get-disks',
> >    'returns': ['GuestDiskInfo'],
> > -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
> > +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
> >  
> >  ##
> >  # @GuestFilesystemInfo:

