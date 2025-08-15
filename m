Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A32CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 19:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un0Yk-0005k4-Js; Fri, 15 Aug 2025 15:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1un0Yc-0005ef-Jg
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:57:47 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1un0YY-0004zJ-Nx
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:57:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4984D21257;
 Fri, 15 Aug 2025 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755287861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ryCEBLZZ9Ne4YYi+KCfWtFcsi3eSPvdCXmY6vn21Qc=;
 b=0OygGqAEg7rIeRy8U21s44NRbBfVd+YhAzYJ0KPIkCaZ92OrTNUU2uoyr7iO68gopB9hYD
 lqEcqQJzy+bvwExFKAmCwY8Vqb7fMWsJy2TOBbB+H9VbcVZwFwTsXVHamB9iwPjKK1rkn2
 5/TZZbS83BjLu7ObbT5FiTAoIG7Wq+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755287861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ryCEBLZZ9Ne4YYi+KCfWtFcsi3eSPvdCXmY6vn21Qc=;
 b=lHF0dETYc5BLvH2tKxpbVvNEJLj+nWHFmne3nFGKVK8e7WsNTGZdZ5c1IOAjlRcOgEzeHq
 YtiTwXN7tnfiCeDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755287861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ryCEBLZZ9Ne4YYi+KCfWtFcsi3eSPvdCXmY6vn21Qc=;
 b=0OygGqAEg7rIeRy8U21s44NRbBfVd+YhAzYJ0KPIkCaZ92OrTNUU2uoyr7iO68gopB9hYD
 lqEcqQJzy+bvwExFKAmCwY8Vqb7fMWsJy2TOBbB+H9VbcVZwFwTsXVHamB9iwPjKK1rkn2
 5/TZZbS83BjLu7ObbT5FiTAoIG7Wq+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755287861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ryCEBLZZ9Ne4YYi+KCfWtFcsi3eSPvdCXmY6vn21Qc=;
 b=lHF0dETYc5BLvH2tKxpbVvNEJLj+nWHFmne3nFGKVK8e7WsNTGZdZ5c1IOAjlRcOgEzeHq
 YtiTwXN7tnfiCeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76B6413876;
 Fri, 15 Aug 2025 19:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u2emHDSRn2gpXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 19:57:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Steve
 Sistare <steven.sistare@oracle.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Arun Menon <armenon@redhat.com>
Subject: Re: [PATCH v11 23/27] migration: Capture error in
 postcopy_ram_listen_thread()
In-Reply-To: <20250813-propagate_tpm_error-v11-23-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-23-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 16:57:38 -0300
Message-ID: <875xeoxsr1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[32];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL96jwb13nk98k7j3ws9zhxhn8)];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,nongnu.org,xfusion.com,linux.vnet.ibm.com];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Arun Menon <armenon@redhat.com> writes:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
> to load the vm, and in case of a failure, it should set the error
> in the migration object.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index de2bce276faa863a0f25deedafb0b784f10559d7..b85620a03654c214f4e771fa3=
b2bcfdf48661214 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      QEMUFile *f =3D mis->from_src_file;
>      int load_res;
>      MigrationState *migr =3D migrate_get_current();
> +    Error *local_err =3D NULL;
>=20=20
>      object_ref(OBJECT(migr));
>=20=20
> @@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      qemu_file_set_blocking(f, true);
>=20=20
>      /* TODO: sanity check that only postcopiable data will be loaded her=
e */
> -    load_res =3D qemu_loadvm_state_main(f, mis, &error_fatal);
> +    load_res =3D qemu_loadvm_state_main(f, mis, &local_err);
>=20=20
>      /*
>       * This is tricky, but, mis->from_src_file can change after it
> @@ -2137,9 +2138,12 @@ static void *postcopy_ram_listen_thread(void *opaq=
ue)
>                           __func__, load_res);
>              load_res =3D 0; /* prevent further exit() */
>          } else {
> -            error_report("%s: loadvm failed: %d", __func__, load_res);
> +            error_prepend(&local_err,
> +                          "loadvm failed during postcopy: %d: ", load_re=
s);
> +            migrate_set_error(migr, local_err);
> +            error_report_err(local_err);
>              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACT=
IVE,
> -                                           MIGRATION_STATUS_FAILED);
> +                              MIGRATION_STATUS_FAILED);

This should be left alone. Having this patch (git) conflict with
something else just because of this line would be really annoying.

>          }
>      }
>      if (load_res >=3D 0) {

