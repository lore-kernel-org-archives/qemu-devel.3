Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414C8D3F07A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7Nj-0007J7-D9; Wed, 28 Jan 2026 10:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7Nb-0007Ca-OF
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:22:52 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7Na-0003O2-5B
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:22:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF01E33BEC;
 Wed, 28 Jan 2026 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vDt4EuaDfihqXHBeAIGd98bMgccKGmwTwJuAKqHivYI=;
 b=kNDGMVSwGplomkmW6sqQzP0Adhz9lEMwFz43I+2m6z9vRVXhH5ITMqyRaxhnOxnIZSZTML
 YO6w05hpU/R7lV+ojUi6RbZlsc4yStsyfVBBjiZzd9u9KQLcksRK/NqMcbW66FlqdhC7gB
 IH+jZG1k9gJw7f04DUf+OU3sjamDwno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vDt4EuaDfihqXHBeAIGd98bMgccKGmwTwJuAKqHivYI=;
 b=vajFMAhQfiT4ca0J7Ahdq6IIAh2Z2+Z+FLq8HbhMQHXzoLaGVEGOUYlhAJlK4080c/2waj
 3BbBrDlBIaucrdCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nf9OdkBI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JhCFLflf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vDt4EuaDfihqXHBeAIGd98bMgccKGmwTwJuAKqHivYI=;
 b=Nf9OdkBIgv9bq/jPxCRmP1Pm87+U6wYXj5g2DSO4gG5V+/PdKOUTgmcbLM6I/FCy9lg3PE
 TIvO8buzLH2JK0qOdIUHmOyr0l45gqjy+0HlbkLr3yVQ4ulIi2xvRrnuzMkwH7zCV0pC1f
 3TPpmdaOB2/y7Oww6tsNd/ClgMSkXrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vDt4EuaDfihqXHBeAIGd98bMgccKGmwTwJuAKqHivYI=;
 b=JhCFLflfHCRDpm54xA/QYza2niGbxJfMTpTrdG0u0dpDMrEd/tIZ8Yro/Tn/xV3mVtZpnC
 GHHvaKZTRhAB81Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 355A43EA61;
 Wed, 28 Jan 2026 15:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QODPObwpemluNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 15:22:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 15/24] migration: Provide helper for save vm description
In-Reply-To: <20260127185254.3954634-16-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-16-peterx@redhat.com>
Date: Wed, 28 Jan 2026 12:22:34 -0300
Message-ID: <878qdhg3t1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[web.de]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ASN_FAIL(0.00)[7.9.0.0.4.6.0.0.0.5.1.0.0.1.0.0.4.0.1.0.1.8.2.b.0.4.e.d.7.0.a.2.asn6.rspamd.com:query
 timed out]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_CC(0.00)[redhat.com,web.de];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[6];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: BF01E33BEC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Provide two smaller helpers to dump the vm desc.  Preparing to move it out
> and generalize device state dump.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.h |  1 +
>  migration/savevm.c | 35 +++++++++++++++++++++++------------
>  2 files changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/migration/savevm.h b/migration/savevm.h
> index d0596d1d62..f957f851ef 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -50,6 +50,7 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
>  int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
>  bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>  void qemu_savevm_state_end(QEMUFile *f);
> +void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f);
>  void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
>  void qemu_savevm_send_open_return_path(QEMUFile *f);
>  int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a787691352..41560b97a4 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1669,13 +1669,34 @@ ret_fail_abort_threads:
>      return -1;
>  }
>  
> +static void qemu_savevm_state_vm_desc(MigrationState *s, QEMUFile *f)
> +{
> +    JSONWriter *vmdesc = s->vmdesc;
> +    int vmdesc_len;
> +
> +    if (vmdesc) {
> +        json_writer_end_array(vmdesc);
> +        json_writer_end_object(vmdesc);
> +        vmdesc_len = strlen(json_writer_get(vmdesc));
> +
> +        qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
> +        qemu_put_be32(f, vmdesc_len);
> +        qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
> +    }
> +}
> +
> +void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
> +{
> +    qemu_savevm_state_end(f);
> +    qemu_savevm_state_vm_desc(s, f);
> +}
> +
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>                                                      bool in_postcopy)
>  {
>      MigrationState *ms = migrate_get_current();
>      int64_t start_ts_each, end_ts_each;
>      JSONWriter *vmdesc = ms->vmdesc;
> -    int vmdesc_len;
>      SaveStateEntry *se;
>      Error *local_err = NULL;
>      int ret;
> @@ -1705,17 +1726,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>  
>      if (!in_postcopy) {
>          /* Postcopy stream will still be going */
> -        qemu_savevm_state_end(f);
> -
> -        if (vmdesc) {
> -            json_writer_end_array(vmdesc);
> -            json_writer_end_object(vmdesc);
> -            vmdesc_len = strlen(json_writer_get(vmdesc));
> -
> -            qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
> -            qemu_put_be32(f, vmdesc_len);
> -            qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
> -        }
> +        qemu_savevm_state_end_precopy(ms, f);
>      }
>  
>      trace_vmstate_downtime_checkpoint("src-non-iterable-saved");

Reviewed-by: Fabiano Rosas <farosas@suse.de>

