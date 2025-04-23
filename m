Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24991C369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 17:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7dUA-00012Z-KN; Wed, 23 Apr 2025 13:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u7dU9-00012H-2m
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:02:09 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u7dU6-0007BD-Rj
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:02:08 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C9A47211CA;
 Wed, 23 Apr 2025 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745427721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNyttTgSKhULwqzPyehDXSd8hnaHK9r85xIu+uEOG2I=;
 b=fpl/yP8v0GVzZl9IFP6HSpQHBwqBs5Pn4uqbU8xaTYX/uPqLWeKkoSq1FdO3JTNTOu64j1
 ZNURxBB7ISr5bsQI6I7lFwOPKs0ZwsV8DhpawX/O1atcQrVgSQ4+m8NpA2HcJi4pTW7laK
 34lXDLZq58tqq/cyNrW/uE9uLN10iNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745427721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNyttTgSKhULwqzPyehDXSd8hnaHK9r85xIu+uEOG2I=;
 b=2TRY0dF2IUbQUTrdMgiSD1rTgR9/BHVVAT6AaAHDBAn0qpI0YVS0IIoNRRNmqNfcD5W6NW
 e2iyeiTti7WKjDAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745427721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNyttTgSKhULwqzPyehDXSd8hnaHK9r85xIu+uEOG2I=;
 b=fpl/yP8v0GVzZl9IFP6HSpQHBwqBs5Pn4uqbU8xaTYX/uPqLWeKkoSq1FdO3JTNTOu64j1
 ZNURxBB7ISr5bsQI6I7lFwOPKs0ZwsV8DhpawX/O1atcQrVgSQ4+m8NpA2HcJi4pTW7laK
 34lXDLZq58tqq/cyNrW/uE9uLN10iNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745427721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNyttTgSKhULwqzPyehDXSd8hnaHK9r85xIu+uEOG2I=;
 b=2TRY0dF2IUbQUTrdMgiSD1rTgR9/BHVVAT6AaAHDBAn0qpI0YVS0IIoNRRNmqNfcD5W6NW
 e2iyeiTti7WKjDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 466CB13A3D;
 Wed, 23 Apr 2025 17:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g/1WAgkdCWhHGwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 23 Apr 2025 17:02:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: Migration compatibility test broken on major version releases
In-Reply-To: <20250422154131.GA308586@fedora>
References: <20250422154131.GA308586@fedora>
Date: Wed, 23 Apr 2025 14:01:58 -0300
Message-ID: <87bjsmerqx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Hi Fabiano,
> The build-previous-qemu job does not work when a new major version is
> released:
> https://gitlab.com/qemu-project/qemu/-/jobs/9788294494
>

You might be using a slightly different workflow from Peter and Richard,
I don't think this ever happened before. But that's totally fine, I'll
change the job to behave better in that case.

> The previous version computation produces "v10.0.0" when testing:
>
>   $ export QEMU_PREV_VERSION=3D"$(sed 's/\([0-9.]*\)\.[0-9]*/v=E2=90=81.0=
/' VERSION)"
>   $ git remote add upstream https://gitlab.com/qemu-project/qemu
>   $ git fetch upstream refs/tags/$QEMU_PREV_VERSION:refs/tags/$QEMU_PREV_=
VERSION
>   warning: redirecting to https://gitlab.com/qemu-project/qemu.git/
>   fatal: couldn't find remote ref refs/tags/v10.0.0
>
> The CI job runs before the v10.0.0 tag is pushed to the repo. (The tag
> is only pushed once tests have passed.)
>
> Even if the tag was there and git fetch succeeded, the test would test
> migration between v10.0.0 and v10.0.0, which doesn't seem to be the
> purpose of the test.
>

Yes, but since that one commit does not have any code anyway, we've
decided to just let it run on the same version. The very next commit
will be aligned again. Still, the time-of-tag issue was indeed an
oversight.

> Please adjust the test to handle this situation. For now I will re-run
> the job after pushing the final tag (since it already passed for the
> release candidate tag).

Will do, thanks!

>
> Thanks!
>
> Stefan

