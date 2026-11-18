Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D34B606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iishrfHb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GbGKbIRU;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cNCN68hR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gCDUO1IG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTkSc-0001D3-Vz; Wed, 18 Nov 2026 13:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTkSb-0001Cu-Sk
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 13:32:45 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTkSZ-0005VM-Uk
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 13:32:45 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1C5D223DE;
 Wed, 18 Nov 2026 18:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795026760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cq21hS9aDuyLfvy/56aXppNvajsCFBqnj0aUfOo1Kc=;
 b=iishrfHbtnNxyqbqqm42lbqFJu14SqJCwXtIcLOaLZtQsjKnfN1JLIgLxw4GZNnuLmyITn
 N8kOTRG3FYosnS+0JvoQR00vYvCwe0rVM+WHBFWHaQjJAhbSy3lRTQHg0gCfFhvRzdIbkP
 wzpv4F6pVjKT1YCvGW+1vHJPWxmHD3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795026760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cq21hS9aDuyLfvy/56aXppNvajsCFBqnj0aUfOo1Kc=;
 b=GbGKbIRUXsLe3rrR9+PR07HXPKhDEFxbdCBCmJwqvNodNXeBVWXBB0D1DV/E1bZFGr8w1I
 oTRJpmif2S1UWyAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cNCN68hR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gCDUO1IG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795026758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cq21hS9aDuyLfvy/56aXppNvajsCFBqnj0aUfOo1Kc=;
 b=cNCN68hRIXr5+5co7Stycsj0NT/+AJO+/Pnt6qyHnChsWLFSKksoI2WVosgsQ3/fYfjPCs
 LbucUhmSjbQMUlgKH3vAAMYlg4AnLJPEcyCd/cuJpMnu9aNrsbm0nnSwQkmHVo0oZ5yEEY
 B6R/1Q0owB8ZP5dSlxeDlBVp5/iA1o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795026758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cq21hS9aDuyLfvy/56aXppNvajsCFBqnj0aUfOo1Kc=;
 b=gCDUO1IGvBrFX9duQV9Q9TZuTIkzgNnmCbbL00zt8VycbuXE+eFkOAhOk2/OJZQ5C3Q3lF
 YTq5fTt0uLYZfPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D936134E9;
 Wed, 18 Nov 2026 18:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UecCLkXv/WpTPgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 18 Nov 2026 18:32:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Dongli Zhang <dongli.zhang@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, alex@shazbot.org, clg@redhat.com,
 yi.l.liu@intel.com, eric.auger@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: Re: [PATCH 00/21] migration/cpr: introduce cpr-luo mode to support
 KHO/LUO
In-Reply-To: <fa74f48d-dfd2-4336-8ea2-a53d46004e72@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
 <95d4d77e-7b30-463e-96a1-6add4495e451@oracle.com> <875wxvs2na.fsf@suse.de>
 <avyqPuj7jz3QKM7K@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <fa74f48d-dfd2-4336-8ea2-a53d46004e72@oracle.com>
Date: Wed, 18 Nov 2026 15:32:35 -0300
Message-ID: <87se0yq9bw.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Rspamd-Queue-Id: C1C5D223DE
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dongli Zhang <dongli.zhang@oracle.com> writes:

> Hi Fabiano and Peter,
>
> On Tue, Nov 17, 2026 11:25:50AM -0800, Peter Xu wrote:
>> On Tue, Nov 17, 2026 at 04:=E2=80=8A01:=E2=80=8A45PM -0300, Fabiano Rosa=
s wrote: > Sorry for the
>> delay, we're all swimming in slop these days. The only > feedback I have=
 at the
>> moment is that this feature needs tests. What's > your plan in this rega=
rd?
>>=20
>> On Tue, Nov 17, 2026 at 04:01:45PM -0300, Fabiano Rosas wrote:
>>> Sorry for the delay, we're all swimming in slop these days. The only
>>> feedback I have at the moment is that this feature needs tests. What's
>>> your plan in this regard? Can this run with nested virtualization? Or
>>> perhaps is there a way to mock the kernel interfaces and ensure QEMU
>>> does the right thing even without them? We don't need much, but the code
>>> definitely needs to be exercised somehow.
>
> Thank you very much for the response and suggestion. I will follow this t=
o make
> the feature more robust.
>
> So far, the only way to test it is through kexec, which not only takes ti=
me but
> also isn't friendly to unit testing.
>
> Based on my understanding of LUO/KHO, with the latest mainline Linux kern=
el,
> once the fds are preserved, there is no way to retrieve them until after =
kexec.
>
> Therefore, perhaps we could implement the LUO API functions in QEMU throu=
gh an
> ops interface.
>
> 1. The first idea is to implement an emulator so that the ops interface c=
an
> support both the real API and a test API. The test API would talk to the
> emulator to emulate the preserve/retrieve procedure.
>

Where does that emulator sit exactly? Because the problem of
transfering state will be the same as in 2 below, no? Since QEMU source
needs to exit.

> 2. The second idea is to implement a set of test ops, with QEMU launched =
by a
> parent process. The source QEMU could preserve fds, and the target QEMU c=
ould
> retrieve them through the parent process.
>

Something like migration-test as the parent process sounds easy enough.

> 3. The third idea is to implement something in the kernel to emulate a qu=
ick
> switch between outgoing and incoming fds so that we can retrieve them
> immediately after preserving them.
>

Anything in-kernel would have to be part of a larger LUO testing
approach I think. Otherwise we waste effort. I don't suppose the kernel
side has any sort of selftests (or similar) for this?

What can we get from /dev/liveupdate in the host without having to
kexec? On a quick look, I see systemd has a test-luo program, I wonder
if they have a way to test outside of a VM.

One other aspect aside from the normal functioning of the feature is how
does QEMU behave when the host doesn't support LUO or the configuration
is not quite right. Although easy to fix, those issues tend to be
numerous when the support for a kernel feature is first implemented in
QEMU. A test that doesn't access the host at all might miss those.

> Options (1) and (2) seem better. While (2) looks easier to implement for =
quick
> unit testing, (1) would be better for testing with arbitrary devices and
> configurations in cpr-luo mode.
>

Let's understand a bit better what the options are, but we don't need to
do anything fancy, we can improve the testing as the work evolves.

> Thank you very much!
>
> Dongli Zhang
>
>>=20
>> Apologize from my side too on being slow, I'm going to start reading mai=
ls
>> on the list this week, but it'll still be slow, together with other thin=
gs.
>> Just to say, this one is on my review list.  Sorry again.
>>=20
>> --=20
>> Peter Xu
>>=20

