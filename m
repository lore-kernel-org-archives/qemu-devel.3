Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6CCD74ED8
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHaS-0003Lv-DN; Fri, 23 Jan 2026 08:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHXy-0000dQ-5W
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:50:00 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHXw-0006x4-HB
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:49:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF647337FE;
 Fri, 23 Jan 2026 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769176195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xLqzjXVBLOTlApeJWyx9n9Bwi1C/BZSgQNlxSdFeoQ=;
 b=TkIBuS3/ZV0TY8CmUSHvCFffwV2kd2R2kBSdV6rM3VJTMPJzBnmaIG10CWCTDBF8ymjsmr
 cSWAl8NjoupQBEb0z1Gia126PAJXSQOZCF3jtyasKlq115FNY59StzxzNRqJoHwxhGEVhY
 2Cp9JIJuafkfC6l3eYzu3bU6Ew5Ja8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769176195;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xLqzjXVBLOTlApeJWyx9n9Bwi1C/BZSgQNlxSdFeoQ=;
 b=jgCfu4lx1I38zjnu/SG0zlseAfJbu/GHn3tqkyvXp3Q+i22NLpjKcuG5sssvljmyaeBWsy
 pQKUJf63B4lonqBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mXPXwuWE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/av2v5Hp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769176194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xLqzjXVBLOTlApeJWyx9n9Bwi1C/BZSgQNlxSdFeoQ=;
 b=mXPXwuWEXGlFvVJkfARhrdBBHPxXhPT20DAo79aTHnmnpDkeCYVXL/qRuZkpVHwf2sBlOv
 XwfwGTBHbQMfZ5aloI1UeHu7GaQQrUjWkSBl+/PZBaIs5FbH3+k8kORNK1XwBGHhVA+KEi
 anUlREQ+OxCHlGqViFwZwFYSs42mdi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769176194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xLqzjXVBLOTlApeJWyx9n9Bwi1C/BZSgQNlxSdFeoQ=;
 b=/av2v5Hp8htNCqTbwskl0li48TJ4YabhYEJRqA5zorxhASRYhXIVGru4nrroHfI2pGUY1T
 tq8ZMWWYIAY9XZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 244AB1395E;
 Fri, 23 Jan 2026 13:49:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y45jNYF8c2mWAQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 13:49:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH 07/10] colo: Forbid VM resume during checkpointing
In-Reply-To: <20260121223336.3381912-8-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-8-peterx@redhat.com>
Date: Fri, 23 Jan 2026 10:49:51 -0300
Message-ID: <877bt8iglc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[web.de];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AF647337FE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> COLO will stop the VM during each checkpoint on either PVM or SVM.
>
> Accidentally resuming the VM during the window might be fatal because it
> may cause the RAM and devices state to misalign, corrupting the checkpoint.
>
> Hence forbid VM resume during the process.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor/qmp-cmds.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 1ca44fbd72..0c409c27dc 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -84,6 +84,9 @@ void qmp_cont(Error **errp)
>      } else if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>          error_setg(errp, "Migration is not finalized yet");
>          return;
> +    } else if (runstate_check(RUN_STATE_COLO)) {
> +        error_setg(errp, "COLO checkpoint in progress");
> +        return;
>      }
>  
>      for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

