Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B765DC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 13:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujI0r-0004AU-3t; Tue, 05 Aug 2025 09:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ujHyG-0001aN-2i
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:44:59 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ujHyB-0003p3-Kg
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:44:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C1761F38A;
 Tue,  5 Aug 2025 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754401484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aW9Iuv5VtQ655HzAUHrz8aKWSDweVA8PO0HuouMK3yE=;
 b=K4J2RcWBp5hUl7A2ota9XCOFMadSvTI9EpU0V/0t1lU4K0Q3FGlnFMN7o9mH7ARe3eAsfh
 DY6uFX68NCdTNbZ2InQt0GpsIIbn86VkSHVvY9IfjON0Iol4UZnnnlZuC7/OEHFEl1abZX
 PUsyLhXRGId0xG3pqXSfP0V2os4WRYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754401484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aW9Iuv5VtQ655HzAUHrz8aKWSDweVA8PO0HuouMK3yE=;
 b=P/07b+5QDAClKwtlaGWvpR9rrlnHFhLbStMQOk7oF8G2BLAH4RPlYaT4BAFUA/xP+PAYJx
 QqyevV9Oyd9fk6AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754401484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aW9Iuv5VtQ655HzAUHrz8aKWSDweVA8PO0HuouMK3yE=;
 b=K4J2RcWBp5hUl7A2ota9XCOFMadSvTI9EpU0V/0t1lU4K0Q3FGlnFMN7o9mH7ARe3eAsfh
 DY6uFX68NCdTNbZ2InQt0GpsIIbn86VkSHVvY9IfjON0Iol4UZnnnlZuC7/OEHFEl1abZX
 PUsyLhXRGId0xG3pqXSfP0V2os4WRYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754401484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aW9Iuv5VtQ655HzAUHrz8aKWSDweVA8PO0HuouMK3yE=;
 b=P/07b+5QDAClKwtlaGWvpR9rrlnHFhLbStMQOk7oF8G2BLAH4RPlYaT4BAFUA/xP+PAYJx
 QqyevV9Oyd9fk6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0FE613A55;
 Tue,  5 Aug 2025 13:44:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aHuqHMsKkmi6IQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Aug 2025 13:44:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH for-10.1 0/2] migration: actually make gnutls workaround
 functional
In-Reply-To: <aJHYSwGXTOF4o00n@redhat.com>
References: <20250801170212.54409-1-berrange@redhat.com>
 <d5xctfzcrtbanvkndamonxgqo3tc5nejhyrvh54m3y5bhg4cms@ue7siue2yw7o>
 <87jz3i3n0u.fsf@suse.de> <aJHYSwGXTOF4o00n@redhat.com>
Date: Tue, 05 Aug 2025 10:44:41 -0300
Message-ID: <87h5yl3mt2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Aug 04, 2025 at 04:27:45PM -0300, Fabiano Rosas wrote:
>> Juraj Marcin <jmarcin@redhat.com> writes:
>>=20
>> > Hi Daniel,
>> >
>> > On 2025-08-01 18:02, Daniel P. Berrang=C3=A9 wrote:
>> >> This is a followup to previously merged patches that claimed to
>> >> workaround the gnutls bug impacting migration, but in fact were
>> >> essentially non-functional. Juraj Marcin pointed this out, and
>> >> this new patch tweaks the workaround to make it actually do
>> >> something useful.
>> >>=20
>> >> Daniel P. Berrang=C3=A9 (2):
>> >>   migration: simplify error reporting after channel read
>> >>   migration: fix workaround for gnutls thread safety
>> >>=20
>> >>  crypto/tlssession.c   | 16 ----------------
>> >>  migration/qemu-file.c | 22 +++++++++++++++++-----
>> >>  2 files changed, 17 insertions(+), 21 deletions(-)
>> >>=20
>> >
>> > thanks for finding a fix for the workaround. I have tested it and it
>> > resolves the issue.
>> >
>> > However, it significantly slows down migration, even with the workarou=
nd
>> > disabled (and thus no locking). When benchmarking, I used the fixed
>> > version of GNUTLS, VM with 20GB of RAM which were fully written to
>> > before starting a normal migration with no workload during the
>> > migration.
>> >
>> > Test cases:
>> > [1]: before this patchset
>> > [2]: with this patchset applied and GNUTLS workaround enabled
>> > [2]: with this patchset applied and GNUTLS workaround disabled
>> >
>> >   | Total time | Throughput | Transfered bytes |
>> > --+------------+------------+------------------+
>> > 1 |  31 192 ms |  5450 mpbs |   21 230 973 763 |
>> > 2 |  74 147 ms |  2291 mbps |   21 232 849 066 |
>> > 3 |  72 426 ms |  2343 mbps |   21 215 009 392 |
>>=20
>> Thanks testing this. I had just managed to convince myself that there
>> wouldn't be any performance issues.
>>=20
>> The yield at every buffer fill on the incoming side is probably way more
>> impactful than the poll on the RP.
>
> Yeah, that's an unacceptable penalty on the incoming side for sure.
>
> How about we simply change the outbound migration channel to be in
> non-blocking mode ?   I originally put it in blocking mode way back
> in 9e4d2b98ee98f4cee50d671e500eceeefa751ee0, but if I look at the
> QEMUFile impl of qemu_fill_buffer and qemu_fflush, but should be
> coping with a non-blocking socket. qemu_fill_buffer has explicit
> code to wait, and qemu_fflush uses the _all() variant whcih has
> built-in support for waiting. So I'm not seeing an obvious need
> to run the channel in blocking mode.
>

It's definitely simpler and I think it works. It's uncomfortably late
though to add a bunch of glib event loop code to the migration
thread. Is the suggestion of moving the yield to tlssession.c even
feasible?

Juraj, are you able to get some numbers with this?

> Using non-blocking will prevent the return path thuread setting
> in a read() call, so we won't have mutual exclusion between read
> and write which this patch was trying to avoid
>
> ie, this delta on top of this patch:
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..1eaabc1f19 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -4002,7 +4002,7 @@ void migration_connect(MigrationState *s, Error *er=
ror_in)
>      }
>=20=20
>      migration_rate_set(rate_limit);
> -    qemu_file_set_blocking(s->to_dst_file, true);
> +    qemu_file_set_blocking(s->to_dst_file, false);
>=20=20
>      /*
>       * Open the return path. For postcopy, it is used exclusively. For
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index cf6115e699..8ee44c5ac9 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -338,22 +338,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(Q=
EMUFile *f)
>          return 0;
>      }
>=20=20
> -    /*
> -     * This feature triggers acquisition of mutexes around every
> -     * read and write. Thus we must not sit in a blocking read
> -     * if this is set, but must instead poll proactively. This
> -     * does not work with some channel types, however, so must
> -     * only pre-poll when the featre is set.
> -     */
> -    if (qio_channel_has_feature(f->ioc,
> -                                QIO_CHANNEL_FEATURE_CONCURRENT_IO)) {
> -        if (qemu_in_coroutine()) {
> -            qio_channel_yield(f->ioc, G_IO_IN);
> -        } else {
> -            qio_channel_wait(f->ioc, G_IO_IN);
> -        }
> -    }
> -
>      do {
>          struct iovec iov =3D { f->buf + pending, IO_BUF_SIZE - pending };
>          len =3D qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
>
>
> With regards,
> Daniel

