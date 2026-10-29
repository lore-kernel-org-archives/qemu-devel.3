Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11C3606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BMQ++dzx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=F/ZFkdYE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kF5usCJA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wCL0Y/Vw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQCQ-0003t8-0Z; Thu, 29 Oct 2026 09:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMQC9-0003rl-Nd
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:29:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMQC7-0000FY-Qm
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:29:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D5BBE1F800;
 Thu, 29 Oct 2026 13:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793280565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkqM0fnucumndUp7WrIt0GhQpQL+Hz/GM8Eyc9zqU4E=;
 b=BMQ++dzxxJcJV8io/qEgJJ/QIzTHMNj8IKDVeRelHzfRqmMS2ZcYAqUJ/a/f5kY+r4tjkF
 6voucV9C81IFgwZNDoTx2/C8qowwy9CgHOzwl6j96HqkHaaaFLzSt+cR32cel6zxf4CC+g
 IeQqXmQ8N+XH6aqOxctLn8leNVpuG7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793280565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkqM0fnucumndUp7WrIt0GhQpQL+Hz/GM8Eyc9zqU4E=;
 b=F/ZFkdYE8p9oU8WtH6Kp1WTQ0OVoSyfH1bnky68TIRQJB58yU81GiahGQ5iziNnSBda6e2
 da+cuuwzUR1IqXDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793280564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkqM0fnucumndUp7WrIt0GhQpQL+Hz/GM8Eyc9zqU4E=;
 b=kF5usCJAMdabFxZCLRUn6h2DTSpNiJnX2pqN9xvj8cfl0yHNa80gI7f5SodtboKyWljjQa
 uhllx63/wD9KwCdQV9LL+oXyZijtVO243sU/ZyZnT5ArOakydHfgCxAKFglBDQKOY6ER5S
 nPh3M1SLjRydwiqSdO8X4BuaHU4G2z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793280564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkqM0fnucumndUp7WrIt0GhQpQL+Hz/GM8Eyc9zqU4E=;
 b=wCL0Y/Vw3uBwYuEEa+2uYZI3qiYuEoCPuF0hemVPdNGyZsiHGWlEo2mmp+DISkCmX/AApQ
 u7oQK+SUKnWgksBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5659C1339F;
 Thu, 29 Oct 2026 13:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SnIQOzNK42qhAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 13:29:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, Alistair
 <alistair@alistair23.me>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: Re: QEMU Sashiko
In-Reply-To: <de5dd85c-e486-40b3-a0ce-613cc102089d@oss.qualcomm.com>
References: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
 <de5dd85c-e486-40b3-a0ce-613cc102089d@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 10:29:17 -0300
Message-ID: <87se1oiqj6.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[qualcomm.com:email,sashiko.dev:url,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url, imap1.dmz-prg2.suse.org:helo,
 qualcomm.com:email]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 29/10/26 00:32, Alistair wrote:
>> Hey,
>>=20
>> Sashiko just merged initial support for QEMU [1].
>>=20
>> For those who don't know, Sashiko is a LLM powered review bot used for
>> the Linux kernel. When people send patches to LKML Sashiko reviews the
>> patches and responds to the mailing list with any issue that it finds.
>>=20
>> Like all LLM tools, it is both useful, but also verbose, prone to
>> hallucinations and misses things (like humans do to though). The
>> general consensus in the kernel community is that it's a useful and
>> valuable tool.
>>=20
>> Sashiko is just a Rust application and prompts, it doesn't include a
>> LLM and you can use a range of different LLM backends.
>>=20
>> Google sponsors the development and runs a Linux instance. So you can
>> see the hosted Linux instance here: https://sashiko.dev/ and it uses
>> Gemini for the LLM which Google pays for. It seems like there is also a
>> GCC one starting up.
>>=20
>> The cool thing about Sashiko though is you can run it locally as well,
>> so you can use it to test your patches before sending them to LKML, as
>> long as you have a LLM backend you can use.
>>=20
>> So, now that Sashiko also supports QEMU there are two exciting use
>> cases:
>>=20
>> 1. Developers can run it locally to review their patches before sending
>> them to the list. This can catch issues before sending patches
>>=20
>> 2. Maintainers can run an instance to review patches. How you set this
>> up depends on the maintainer and how many tokens you have. Pointing it
>> at the list directly and running it for all patches might be too much,
>> but some combination of manually triggering it for certain patches
>> seems to work well. The Settings.toml file can be setup based on what
>> you want to do.
>>=20
>> The hope with this is to save maintainers time as Sashiko can catch
>> issues without requiring much time from a maintainer.
>>=20
>> QEMU support in Sashiko is very new, so it will take some tweaking to
>> improve things, but it is at least a good starting place.
>>=20
>> 1:
>> https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d4517385916=
e6c834d8176f70
>
> I'm glad you added projects/qemu/ directory there; some time ago
> Zhao and myself tried to leverage LLM to review QEMU and reduce
> maintenance burden but there was little community interest and
> some negative feedback so we didn't pursued on the list.
> https://lore.kernel.org/qemu-devel/afxbDjQEWJZ6P9oe@redhat.com/

Well, he had a point here^. There's things already outdated in this
sashiko change which we are hearing about after it's merged.

> https://lore.kernel.org/qemu-devel/arpINtziWCbjENeo@intel.com/




