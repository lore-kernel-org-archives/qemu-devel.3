Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2017CCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXPgh-0004Yj-0r; Wed, 10 Jun 2026 16:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wXPga-0004W2-GD
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:38:04 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wXPgX-0005jA-Le
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:38:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 716C775D5E;
 Wed, 10 Jun 2026 20:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781123879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpdZXVO3jlCGnfaH6s77jIoCVRX3D9kae9H03tCDqy4=;
 b=blwTDnT1y1Ox7tzdaVZXZUz9cChGdSYLlMRhf9ut61vlpk7K2gMVXvN0y6wDlAUaX8I9Y+
 D+jjID3GIGiXqdvv40Vvz0Rav9eCcuXUHOqK8ceA2VU51yYFzrktKJ2jsDv+aqnPzLIHom
 vvfI6piYE8eIl8yLcO0HspBaXU80sVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781123879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpdZXVO3jlCGnfaH6s77jIoCVRX3D9kae9H03tCDqy4=;
 b=hKPpb0ejLCg4sDnG99M2lpQxK8XDmwW2BxnmL2p9DmD3DqZDp7sxkMRJ5m1qlsGRazogB8
 tOBg8ZELwg+Ja9Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781123879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpdZXVO3jlCGnfaH6s77jIoCVRX3D9kae9H03tCDqy4=;
 b=blwTDnT1y1Ox7tzdaVZXZUz9cChGdSYLlMRhf9ut61vlpk7K2gMVXvN0y6wDlAUaX8I9Y+
 D+jjID3GIGiXqdvv40Vvz0Rav9eCcuXUHOqK8ceA2VU51yYFzrktKJ2jsDv+aqnPzLIHom
 vvfI6piYE8eIl8yLcO0HspBaXU80sVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781123879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpdZXVO3jlCGnfaH6s77jIoCVRX3D9kae9H03tCDqy4=;
 b=hKPpb0ejLCg4sDnG99M2lpQxK8XDmwW2BxnmL2p9DmD3DqZDp7sxkMRJ5m1qlsGRazogB8
 tOBg8ZELwg+Ja9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4F34779A7;
 Wed, 10 Jun 2026 20:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8VzZKSbLKWqZRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Jun 2026 20:37:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Peter Maydell
 <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Paolo Bonzini <pbonzini@redhat.com>, Kevin
 Wolf <kwolf@redhat.com>, Sana Sharma <sansshar@redhat.com>, =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 qemu-rust@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 05/10] qom: Create object-property-ptr.[ch]
In-Reply-To: <aimvTYDsv_-Xsboy@x1.local>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-6-peterx@redhat.com> <aimNv51iMZ_yEgDG@redhat.com>
 <aimvTYDsv_-Xsboy@x1.local>
Date: Wed, 10 Jun 2026 17:37:56 -0300
Message-ID: <87pl1y3zdn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jun 10, 2026 at 05:15:59PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Jun 09, 2026 at 01:25:09PM -0400, Peter Xu wrote:
>> > Create object-property-ptr.[ch] files to include all the helpers for
>> > object_property_add*_ptr().
>> >=20
>> > These set of helpers are handy because they look extremely familiar wi=
th
>> > qdev-properties, allowing the caller to provide a pointer and it will
>> > manage all the setters and getters.
>> >=20
>> > The follow up patches may introduce more of such helpers.  Since objec=
t.c
>> > has been already too big, split that part out.
>>=20
>> The "ptr" helpers are all instance level properties which is a concept
>> we discourage from new usage, in favour of class level properties.
>>=20
>> I don't think we should be adding more "ptr" helpers, but rather
>> planning to eliminiate the (surprisingly little) usage of the
>> existing ones.
>
> The other way to do similar thing is qdev's offset way, but IMHO that's
> more awkward to remember an offset of a pointer then do math everytime.
> Essentially, from technical pov we need at least one uintptr_t to store
> either (1) offset, or (2) field pointer when there's a field that is bound
> to a prop.  IMHO (2) can be better otherwise we'll need to do all the mat=
hs
> to calculate offsets then when access we add the offset back and do a for=
ce
> cast.  It seems not necessary.
>

The more limiting aspect of using the offset is that MigrationParameters
needs to be embedded into MigrationState because the Object is
MigrationState and not MigrationParameters. We could try to solve that
issue specifically by making MigrationParameters a standalone object.

The main issue is that we would need to figure out how to set the compat
properties that are not part of MigrationParameters.

The other main issue =3D) is that we'd need to wrap this in another
structure because MigrationParameters is generated by QAPI.

A minor issue is that -object migration and -global migration use the
"migration" word from TYPE_MIGRATION, so the MigrationState would have
to be renamed.

We could actually solve the first two by doing similarly to what I did
in qom.json in my reply to the cover-letter:

struct MigrationOptions {
   MigrationParameters params;
   <compat props>
}

... then access it by offset. This is fine because we can then do
whatever we want with the MigrationOptions pointer without having to
follow the lifetime of MigrationState.

> OTOH, I still see value on non-class instance properties (that sometimes =
we
> don't even want to have some props avail for the class, but conditional to
> some instances when created dynamically).  If that is needed, IMHO it's
> fine we still provide per-instance properties.
>
> Is there any pointer I can read about the discussion previously on this?
>
> Thanks,

