Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD5606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=M9BVK0mR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U5k9kYoi;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=M9BVK0mR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U5k9kYoi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNqt-0006fc-Fo; Tue, 17 Nov 2026 13:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTNqr-0006dE-Nr
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:24:17 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTNqp-0003hJ-Sb
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:24:17 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F8521F7B7;
 Tue, 17 Nov 2026 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794939852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2Wo3Kl6916Oqx3THywpLBTGvJjL5woPuY7TbgeuSJU=;
 b=M9BVK0mR0bt6yAE4JA0IFqlCzKR6RUZ+j/Bg+JbfrpwYsS2067MsScWN/KqGez+CXyf5UW
 tERPRlbV76NhSFfCI7m9IQvCu/qIxfKFKyEhowN77K8E/3Is/oGsEnjTeqCpPN/lU83ueK
 qM/qMFn0Nt51hq456J6FDqUy1Z6iDIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794939852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2Wo3Kl6916Oqx3THywpLBTGvJjL5woPuY7TbgeuSJU=;
 b=U5k9kYoifHnovB+v2inS97U/OQyUMf6f++cVAsRZ4k0T8DJLaL5Ts26ncEDMn79t/Iovd7
 NqMZoYaQJD1cnjBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M9BVK0mR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U5k9kYoi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794939852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2Wo3Kl6916Oqx3THywpLBTGvJjL5woPuY7TbgeuSJU=;
 b=M9BVK0mR0bt6yAE4JA0IFqlCzKR6RUZ+j/Bg+JbfrpwYsS2067MsScWN/KqGez+CXyf5UW
 tERPRlbV76NhSFfCI7m9IQvCu/qIxfKFKyEhowN77K8E/3Is/oGsEnjTeqCpPN/lU83ueK
 qM/qMFn0Nt51hq456J6FDqUy1Z6iDIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794939852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2Wo3Kl6916Oqx3THywpLBTGvJjL5woPuY7TbgeuSJU=;
 b=U5k9kYoifHnovB+v2inS97U/OQyUMf6f++cVAsRZ4k0T8DJLaL5Ts26ncEDMn79t/Iovd7
 NqMZoYaQJD1cnjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A82BB13302;
 Tue, 17 Nov 2026 18:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LsVPEMub/GqVMwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 18:24:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 07/10] system/cpus: report a BQL held past a deadline
In-Reply-To: <20260915203455.580999-8-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-8-den@openvz.org>
Date: Tue, 17 Nov 2026 15:24:09 -0300
Message-ID: <87bj7ns4dy.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3F8521F7B7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,intel.com:email,openvz.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,qualcomm.com:email,linaro.org:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Denis V. Lunev" <den@openvz.org> writes:

> From: Denis V. Lunev <den@openvz.org>
>
> A vCPU thread reacquires the BQL on every exit that needs userspace, so
> a lock held for tens of seconds stops those vCPUs dead and the guest
> reports its own soft lockup. Nothing in qemu records that this
> happened, which leaves a guest panic as the only evidence and no way to
> tell a stuck holder from a guest that wedged on its own.
>
> Add a BQL watchdog. A thread of its own samples a counter advanced on
> every acquire and every release, so it is odd while the lock is held.
> One odd value seen throughout the window means a single owner held the
> lock for the whole window, because any handover would have advanced the
> counter twice.
>
> Advance it in bql_update_status(), which the mutex hooks already call
> for exactly those two transitions, so a cond-wait that drops and
> retakes the lock is covered without the wrappers knowing, and so is any
> caller that reaches the BQL through the plain mutex API. Record the
> holder's tid beside it, under the same lock, because the thread listing
> alone cannot tell a thread parked on its own condvar from one blocked
> on the BQL. Cache the tid per thread, since gettid is a syscall and
> this is the lock path.
>
> On expiry, name the holder and list every thread's state. The listing
> separates a thread blocked on the BQL, which waits in a futex, from one
> idle inside KVM, which waits in kvm_vcpu_block, and names the syscall a
> wedged holder is stuck in. Report once per episode, or a lock held for
> a minute buries the log in copies of one answer. Put the time on the
> line unless -msg timestamp=3Don already does: a hold is only worth
> reporting if it can be lined up against what the guest saw, and that
> option has to be asked for in advance.
>
> The deadline has to clear the longest legitimate hold, and migration
> setup can hold the BQL for a while, so the watchdog stays off unless
> asked for. The bql-watchdog-ms machine property is the whole interface:
> it sets the deadline, on the command line or over qom-set at any time,
> and 0 turns the watchdog off. Reject a deadline above a minute: a hold
> that long has already shown up as a soft lockup inside the guest.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

