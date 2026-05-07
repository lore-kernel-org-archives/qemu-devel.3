Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EA0CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 14:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKzRN-0006dT-95; Thu, 07 May 2026 10:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKzRL-0006dB-Df
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:10:59 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKzRJ-0001We-GV
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:10:59 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A06365BF4E;
 Thu,  7 May 2026 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778163055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P+ha290GD0MHCxelmB//RNk9agOi8mWzZMDIkGtpt+Q=;
 b=Mx58kj9IMtRxtJoOQTqrCUnDf9aeVf3jO+5F5vjntCFMEpEzs0hIFSbzO40c+hyKIx0Fw/
 Jo3bZgPtwOQJubU5w7VjRHLMBRgi4SUlUA7eWa447Zq038XtYYcPD9T4JPo058YvgzIcbB
 JGl0umlRK0KSbvo5DS7j49L/r5iQIyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778163055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P+ha290GD0MHCxelmB//RNk9agOi8mWzZMDIkGtpt+Q=;
 b=NYpSGYNaIR6bYvzaPOMmqWlBka3NnIOX1R5TIIByQMEoQh8ZYyTm0d0VFoeJ/bp7+RtYch
 XEPVH0iU4gcZPYDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Mx58kj9I;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NYpSGYNa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778163055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P+ha290GD0MHCxelmB//RNk9agOi8mWzZMDIkGtpt+Q=;
 b=Mx58kj9IMtRxtJoOQTqrCUnDf9aeVf3jO+5F5vjntCFMEpEzs0hIFSbzO40c+hyKIx0Fw/
 Jo3bZgPtwOQJubU5w7VjRHLMBRgi4SUlUA7eWa447Zq038XtYYcPD9T4JPo058YvgzIcbB
 JGl0umlRK0KSbvo5DS7j49L/r5iQIyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778163055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P+ha290GD0MHCxelmB//RNk9agOi8mWzZMDIkGtpt+Q=;
 b=NYpSGYNaIR6bYvzaPOMmqWlBka3NnIOX1R5TIIByQMEoQh8ZYyTm0d0VFoeJ/bp7+RtYch
 XEPVH0iU4gcZPYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38A54593A7;
 Thu,  7 May 2026 14:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4hsQA2+d/GkYIwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 07 May 2026 14:10:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: Re: [PATCH 07/14] migration: Make switchover-ack re-usable
In-Reply-To: <20260505081423.28326-8-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-8-avihaih@nvidia.com>
Date: Thu, 07 May 2026 11:10:53 -0300
Message-ID: <87h5ojxqc2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, nvidia.com:email, suse.de:email, suse.de:dkim,
 suse.de:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A06365BF4E
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Avihai Horon <avihaih@nvidia.com> writes:

> Switchover-ack is a mechanism to synchronize between source and
> destination QEMU during migration to prevent the source from switching
> over prematurely.
>
> VFIO uses switchover-ack to ensure switchover happens only after
> destination side has loaded the precopy initial bytes. This is important
> for VFIO, as otherwise downtime could be impacted and be higher.
>
> In its current state, switchover-ack is a one-time mechanism, meaning
> that switchover is acked only once and past that another ACK cannot be
> requested again. This was sufficient until now, as VFIO precopy initial
> bytes was defined to be monotonically decreasing. Thus, when precopy
> initial bytes reached zero for all VFIO devices, a single ACK would be
> sent and its validity would hold.
>
> However, now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy
> initial bytes to be re-initialized during precopy. Specifically, it
> means that initial bytes can grow after reaching zero, which would
> invalidate a previously sent switchover ACK.
>
> To solve this, make switchover-ack reusable and allow devices to request
> another switchover ACK when needed.
>
> To avoid scattering them all over, switchover ACKs are requested through
> a new request_switchover_ack handler which is called in specific places.
>
> Since now switchover ACK can be requested for a specific device and in
> different times, make switchover ACK per-device (instead of a single ACK
> for all devices) and let source side do the pending ACKs accounting.
>
> Keep the legacy switchover-ack mechanism for backward compatibility and
> turn it on by a compatibility property for older machines. Enable the
> property until VFIO implements the new switchover-ack.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

