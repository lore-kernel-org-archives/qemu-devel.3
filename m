Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F63104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw674-0004Ms-7o; Fri, 27 Feb 2026 17:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw672-0004MR-B4
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:15:08 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw670-00071F-7Y
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:15:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F78D5C9C0;
 Fri, 27 Feb 2026 22:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772230504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EWOk2FnAJNKvUWClC7GtqEtiUCpT0kw2AotvO0pa2yQ=;
 b=Xzz61xgbhN3qHS6CkUA1EhYTXwfEX5PidxvRw2THcANNvSg42WSHpcc+yc7Wg288ASCuER
 cLq/nAzwGik5HqaUHrmCLxiDYwqjQAdOWFJfmSR/YdeKkctrtYmCKkghIi3oxJd8JjG+tc
 +numQZVBn0Sdo2Dn39njuSf9Rsz6dgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772230504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EWOk2FnAJNKvUWClC7GtqEtiUCpT0kw2AotvO0pa2yQ=;
 b=DeQB4YI/ppxNdUkhdStWeroSdQCzysnkpbGfSMbautT31uoJJBOCLRPSJl1/iIxcwj/6lq
 /fFzKlkacYIezNDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oPHC25cL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sliCG9PJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772230503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EWOk2FnAJNKvUWClC7GtqEtiUCpT0kw2AotvO0pa2yQ=;
 b=oPHC25cLwAehP0AfO+ZYfmlMFxAViG8Yv2OI+4DxcqADuZ94I6Wzq9otKE9PebDdhXp+L8
 i/gcPDOgM0anoYoNrBLIHtpd4R63yKPC+R2enRWLn93AVVC9T3JNLj3PTyOGNF3ukhWOrf
 4nWyKqXnbExLSWLrJXzB/GeloPIwYgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772230503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EWOk2FnAJNKvUWClC7GtqEtiUCpT0kw2AotvO0pa2yQ=;
 b=sliCG9PJLLZ4jk+O5EDEXXEHgg9lJteeqlGEtU2bqPSfMyQ660PshZL810xpUwq1SSyaDw
 G4HoYzmB+maQYoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B3DD3EA69;
 Fri, 27 Feb 2026 22:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Tq0KFGYXomndVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Feb 2026 22:15:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: vsementsov@yandex-team.ru, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 01/16] migration: vmstate_save_state_v: fix double
 error_setg
In-Reply-To: <20260220210214.800050-2-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-2-vsementsov@yandex-team.ru>
Date: Fri, 27 Feb 2026 19:14:59 -0300
Message-ID: <87jyvxu93w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,yandex-team.ru:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 0F78D5C9C0
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> We may call error_setg twice on same errp if inner
> vmstate_save_state_v() or vmstate_save_state() call fails. Next we will
> crash on assertion in error_setv().
>
> Fixes: 848a0503422d043 "migration: Update error description outside migration.c"
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/vmstate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 4d28364f7b..fccd030dfd 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -539,6 +539,9 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  } else {
>                      ret = inner_field->info->put(f, curr_elem, size,
>                                                   inner_field, vmdesc_loop);
> +                    if (ret < 0) {
> +                        error_setg(errp, "put failed");
> +                    }
>                  }
>  
>                  written_bytes = qemu_file_transferred(f) - old_offset;
> @@ -551,8 +554,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  }
>  
>                  if (ret) {
> -                    error_setg(errp, "Save of field %s/%s failed",
> -                                vmsd->name, field->name);
> +                    error_prepend(errp, "Save of field %s/%s failed: ",
> +                                  vmsd->name, field->name);
>                      if (vmsd->post_save) {
>                          vmsd->post_save(opaque);
>                      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

