Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C7ACD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZpKv-0003FM-28; Wed, 17 Jun 2026 08:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wZpKu-0003F6-1q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:25:40 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wZpKs-0003mJ-Ep
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:25:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA3767585F;
 Wed, 17 Jun 2026 12:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781699135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMpxMCw4e7nq3Yw2jPjZFBJQxYhaM3q9NIVzXVyvqB0=;
 b=w+SVwYojeXT2Y2XKminUKzYce1+KMuK8o/aPOEzwb3odNzFXR3u2hJi5AuRSFGSE9B+/4p
 j0HUJIG14l7i0rj3Nrk3IfdwoQt5EuRzXaqWHTQo//O9gkmr86PpHuMTuvZsoc6poviFj6
 OCX1jjRX+wlNNsVHpEEBNWUDmxZawoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781699135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMpxMCw4e7nq3Yw2jPjZFBJQxYhaM3q9NIVzXVyvqB0=;
 b=on114mYcX/hbaj57WjeMm9laBNU4XjkqIfuih0uACjmy8CUwHt5BK51E6B9vp6hbD1C5mE
 QEg6q7FvtvcfQlBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781699134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMpxMCw4e7nq3Yw2jPjZFBJQxYhaM3q9NIVzXVyvqB0=;
 b=W8fcoIQVHPqtZTO/FHjzG0U0Cr5QQQT2hZtRgWqVP0zKbwkpCHKHrnLi1/Sl3Nmuso19AA
 bniCq4KrVZvtME0cHxqbcVxP7qtPqdtyx1uZdUgh/BHw3JJ4SqZA7ERGugXI9ESCA0OD3M
 wWgUtYBvHXfVGMHA88mjKVAIFKPDQ2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781699134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMpxMCw4e7nq3Yw2jPjZFBJQxYhaM3q9NIVzXVyvqB0=;
 b=ZDTz75n0aEYpSbeOFZo/Db6TEL7jzoX5gnZvAfmLCgad92Di8Uns2kHqjXoDauecff1+CA
 T8alB3QVaAFY3CBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F9E3779A8;
 Wed, 17 Jun 2026 12:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id enyYBD6SMmraHwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jun 2026 12:25:34 +0000
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
In-Reply-To: <ajG54jNEs4JDBRJP@x1.local>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-6-peterx@redhat.com> <aimNv51iMZ_yEgDG@redhat.com>
 <aimvTYDsv_-Xsboy@x1.local> <aiq9g60bOnvsOQOy@redhat.com>
 <87h5n94001.fsf@suse.de> <airI3UKeVVRUdQHq@redhat.com>
 <ajG54jNEs4JDBRJP@x1.local>
Date: Wed, 17 Jun 2026 09:25:27 -0300
Message-ID: <87wlvx5p6w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
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
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> On Thu, Jun 11, 2026 at 03:40:29PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> There's nothing standard in QOM, but in patch 10 in this series
>> Peter has a DEFINE_TLS_PROP_HELPERS() which macro-ized the
>> repetitive getters/setters for the TLS string properties. The
>> duplicate code still exists in the binary of course, just hidden
>> from the source.
>
> I believe we have the standard, which is qdev-properties.. which is (1)
> class properties, (2) allow variable bindings so no setter/getter needed,
> remembering them with pointer offsets.
>
> It goes back to last version where the question becomes: whether we want =
to
> make qdev-properties to be official QOM API, by removing qdev specific
> changes and move them over to qom/.  Then make qdev only add its special
> things on top.
>
> Said that, considering if we want to make all things qom-set-able to
> migration in the future, another option is directly go with getter/setter
> that will do the property checks one by one. One benefit of that is we can
> then get rid of migrate_params_check() and migrate_caps_check() altogethe=
r.
>
> Maybe I should go with the latter, and forget qdev?

I think it's a good idea. For caps that depend on one another do you
intend to check once in each setter? The _check functions exist is
because we want to validate the total state of params/caps, not just a
single param. Just pointing it out, it's not necessarily an issue.

>
> Thanks,

