Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=H1vkTcOG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=y1Y+XUFg;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GccfAura;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TK9GmAon
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMREZ-0005hF-B6; Thu, 29 Oct 2026 10:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMREX-0005gx-OM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:36:01 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMREV-0007Hn-LB
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:36:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3FD64220BB;
 Thu, 29 Oct 2026 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793284557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyMJQXnYku4UJMifBqIxkkpLNJtbyHEbS1e7G3i94YY=;
 b=H1vkTcOGRbAbvRM9voQ9Gf+Ec10y7ESuETmciiUZ/rEiriZgsZ2L5/X6LV3VJ3JWX2er1V
 QG++rUFZniLDRagolLkEGDThwlftVRL1K3KSwPZwanJC4P11Wt+S4IsdT/Q7fiuRqhTvG8
 n4uIzrUkLwDPKgLtNLgGn2S+CfwyVNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793284557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyMJQXnYku4UJMifBqIxkkpLNJtbyHEbS1e7G3i94YY=;
 b=y1Y+XUFgXzcE+4ZufJio+HNt/vMUb7+Z02nE+z0QAc57/5xxpskE6nW0fqUpDD6lazcU9l
 HVYnSPjiG/p42KBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GccfAura;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TK9GmAon
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793284556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyMJQXnYku4UJMifBqIxkkpLNJtbyHEbS1e7G3i94YY=;
 b=GccfAuraGXTlhobdTvWrvVAT0rZfiBeq7jvoSgs6DoS/aUpk4YlJCR+CgD/m/NNOCgGhCR
 GVBtNbAHLCEWhAu3xZWNHHOSN1x8oAdWDgHswOKROvUzUkkEr3cNLNiax/eJ4+gEybWjbm
 Y1/r1seQX0j/tdMiwAXoYgGKfj0htbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793284556;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyMJQXnYku4UJMifBqIxkkpLNJtbyHEbS1e7G3i94YY=;
 b=TK9GmAonffatW7PY9dE4f4E5lrYNckc/LV8hRFucvPt6oNH3JYOpaBO3n/twRrTigTc9H2
 aPvAxt9SB44DLVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADCD91339F;
 Thu, 29 Oct 2026 14:35:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id apZmFMtZ42qMSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 14:35:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] include/hw/core/ptimer.h: Fix 'version' argument of
 VMSTATE_PTIMER
In-Reply-To: <CAFEAcA8Lr5j6XjPqUPJzCDkBRhcyPivyRHEB30aLEYHmcWnXNQ@mail.gmail.com>
References: <20261019131608.3155474-1-peter.maydell@linaro.org>
 <CAFEAcA_GmyC=zY65pc12idvo0JNk8KpA8vQY5UL8SWAmX3PNRA@mail.gmail.com>
 <CAFEAcA8Lr5j6XjPqUPJzCDkBRhcyPivyRHEB30aLEYHmcWnXNQ@mail.gmail.com>
Date: Thu, 29 Oct 2026 11:35:49 -0300
Message-ID: <87pkwsinga.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gitlab.com:url,linaro.org:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Rspamd-Queue-Id: 3FD64220BB
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> Ping for review from the migration folks on this one, and especially
> on the followup query at the bottom about version_ids in the
> vmstates using this macro.
>
> thanks
> -- PMM
>
> On Mon, 19 Oct 2026 at 15:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 19 Oct 2026 at 14:16, Peter Maydell <peter.maydell@linaro.org> wrote:
>> >
>> > The VMSTATE_PTIMER macro is defined to pass a 'version' argument of 1
>> > to VMSTATE_STRUCT_POINTER_TEST_V.  This means that the field will
>> > only be used in migration when the vmstate struct that uses
>> > VMSTATE_PTIMER has a version_id of at least 1.  This doesn't match
>> > how we define other VMSTATE_FOO which don't take an explicit
>> > version_id, which is to use a version argument of 0 (e.g. all the
>> > common macros like VMSTATE_UINT32 are written to pass 0 to their
>> > VMSTATE_UINT32_V counterparts, and so on). It also doesn't match
>> > how we define VMSTATE_PTIMER_ARRAY.
>> >
>> > The practical effect of this is that users of VMSTATE_PTIMER in
>> > vmstate structs which explicitly or implicitly have a version_id of 0
>> > were actually not getting their ptimers migrated.
>> >
>> > This affects:
>> >  vmstate_xlnx_csu_dma in wh/dma/xlnx_csu_dma.c
>> >  vmstate_k230_wdt in hw/watchdog/k230_wdt.c
>> >  vmstate_imx2_wdt in hw/watchdog/wdt_imx2.c
>> >
>> > which are used in:
>> >  * Arm imx-based machines
>> >  * Arm Xilinx versal and zynq machines
>> >  * RISC-V K230 machine
>> >
>> > Most ptimer users are unaffected because they took the usual approach
>> > of explicitly setting their starting version_id to 1.
>> >
>> > Fix the version_id in this field.  This is a migration compatibility
>> > break for all the above listed devices/machines.  Since the timers
>> > involved are in devices where the timer is usually stopped (e.g.  the
>> > watchdogs only have the timer active when the watchdog is enabled and
>> > counting down), the consequences of the bug are likely not visible to
>> > most users.
>> >
>> > We could perhaps attempt to preserve migration compatibility here,
>> > but none of the affected machine types are versioned and so we do not
>> > promise cross-version compatibility, so do the simple thing.
>> >
>> > Fixes: 852f771ec9e5c ("vmstate: port pmtimer")
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4705
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > ---
>> > Not cc: stable because it's a migration format change and we
>> > don't generally backport those.
>> >
>> > As an aside, is the expected way to write a new vmstate to give it
>> > an explicit version_id of 1? If so, maybe we should look at the
>> > vmstate structs which don't define one and so get the default 0.
>> > Or is that just some odd quirk I've picked up because lots of
>> > existing code uses 1 as its first version ID value?

Well, the version difference is compatibility mechanism, so I don't
think there can be any prescription on which version to use. The vmsd
version_id should match or be greater than the field->version_id for the
fields contained in that version.

>> >
>> > ---
>> >  include/hw/core/ptimer.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/include/hw/core/ptimer.h b/include/hw/core/ptimer.h
>> > index 4dc02b0de47..8513f8917e3 100644
>> > --- a/include/hw/core/ptimer.h
>> > +++ b/include/hw/core/ptimer.h
>> > @@ -300,7 +300,7 @@ void ptimer_stop(ptimer_state *s);
>> >  extern const VMStateDescription vmstate_ptimer;
>> >
>> >  #define VMSTATE_PTIMER(_field, _state) \
>> > -    VMSTATE_STRUCT_POINTER_V(_field, _state, 1, vmstate_ptimer, ptimer_state)
>> > +    VMSTATE_STRUCT_POINTER_V(_field, _state, 0, vmstate_ptimer, ptimer_state)
>> >
>> >  #define VMSTATE_PTIMER_ARRAY(_f, _s, _n)                                \
>> >      VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, 0,                   \
>>
>> Followup query: should we also bump the version_id on the three
>> affected vmstate structs, to make it clearer that the migration
>> compat break has happened? Or does it not matter?
>>

We should, otherwise the old src QEMU (field_id=1,version_id=0) won't
save the state that the new dst QEMU (field_id=0,version_id=0) will
expect to be able to load. That errors out migration in the best case
and causes a crash in the worst.

Bumping both version_id and minimum_version_id, results in the old src
QEMU (field_id=1,version_id=0) not saving the state, but the new dst
QEMU (field_id=0,minimum_version_id=1) will reject the load because of
the (old)version_id vs. (new)minimum_version_id mismatch.

We could also keep compatibility old->new by bumping version_id only and
adding a field->exists function that returns false when
version_id==0. Then the old src QEMU (field_id=1,version_id=0) does not
save the state, and the new dst QEMU
(field_id=0,version_id=1,minimum_version_id=0) will not attempt to load
because fiels->exists() returns false.

The field->exists() function is only there when version_id=1 so it will
never skip its own save.

There's no chance for full compatibility because when new->old, the new
src QEMU (field_id=0,version_id=1) already has a version_id too new for
old dst QEMU (field_id=1,version_id=0). The migration will fail.

>> thanks
>> -- PMM

