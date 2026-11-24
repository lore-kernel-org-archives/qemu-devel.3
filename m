Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66305606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KF7fgQJI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qLKpwxKz;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KF7fgQJI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qLKpwxKz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVr52-0008OQ-EM; Tue, 24 Nov 2026 09:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xVr4w-0008Ge-KU
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 09:01:04 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xVr4u-00045M-9U
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 09:01:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6ADFC1F79B;
 Tue, 24 Nov 2026 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795528858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LIjuf94ncr2KSF7AEj1UwV08v4a9bZYeloNuamoTsJI=;
 b=KF7fgQJIaNHZ6o+4y3Vl0Yo9AYnLMCxpr8+eYnppg8u9WW11YBIVgRII1fcUfQUsf9kQkl
 so+ay+lecac0VRiSCtjhTM4xPtZBYtYQquglFIv+U65mFAGwFkyej1STtCOk9MSEooXCGK
 xYqomFrW+7NagfVyHddl+hJAIc6ZpjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795528858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LIjuf94ncr2KSF7AEj1UwV08v4a9bZYeloNuamoTsJI=;
 b=qLKpwxKzSOGrd1n3uTjRBy/KyKBVH5xsUsFbr1U37iseVMOYzGDrwOIK9dZ+Enp4U+7ywC
 SY/slX/i664kW6Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KF7fgQJI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qLKpwxKz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795528858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LIjuf94ncr2KSF7AEj1UwV08v4a9bZYeloNuamoTsJI=;
 b=KF7fgQJIaNHZ6o+4y3Vl0Yo9AYnLMCxpr8+eYnppg8u9WW11YBIVgRII1fcUfQUsf9kQkl
 so+ay+lecac0VRiSCtjhTM4xPtZBYtYQquglFIv+U65mFAGwFkyej1STtCOk9MSEooXCGK
 xYqomFrW+7NagfVyHddl+hJAIc6ZpjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795528858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LIjuf94ncr2KSF7AEj1UwV08v4a9bZYeloNuamoTsJI=;
 b=qLKpwxKzSOGrd1n3uTjRBy/KyKBVH5xsUsFbr1U37iseVMOYzGDrwOIK9dZ+Enp4U+7ywC
 SY/slX/i664kW6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD23F1339F;
 Tue, 24 Nov 2026 14:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QzZsHZmYBWvQFAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Nov 2026 14:00:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2] docs: migration: Clarify the security posture
In-Reply-To: <awWUmfW-p-dbJT3P@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261124130622.2296899-1-farosas@suse.de>
 <CAFEAcA-g2KmgAH52gCTTa7O+xjUWoRuNxfgdKoXTbsmNM7gv6g@mail.gmail.com>
 <awWUmfW-p-dbJT3P@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Tue, 24 Nov 2026 11:00:51 -0300
Message-ID: <87cxrus50s.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:email, suse.de:dkim, linaro.org:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Rspamd-Queue-Id: 6ADFC1F79B
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Nov 24, 2026 at 01:18:45PM +0000, Peter Maydell wrote:
>> On Tue, 24 Nov 2026 at 13:06, Fabiano Rosas <farosas@suse.de> wrote:
>> >
>> > We have documented[0] the scenarios in which a migration bug is
>                       ^^^
>
>> > considered for a security vulnerability but some ambiguity still
>> > remains, mostly because of the mention of live migration in the
>> > untrusted entities list. Remove that mention and expand the "Security
>> > boundary scope" and "Sensitive configurations" sections with migration
>> > content.
>> >
>> > 0 - commit 8b6405a493a ("docs: Add security considerations for migration")
>> 
>> What's this line ?
>
> My bet is the reference [0] used above.
>

Yeah, I think the commit reference in the middle of the paragraph makes
it harder to read.

>> 
>> >
>> > Co-authored-by: Peter Maydell <peter.maydell@linaro.org>
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> > v2:
>> > Picked PeterM's version for the "Security boundary scope" part.
>> 
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

