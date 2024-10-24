Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91748D1036C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 20:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t44nd-0007Bs-8v; Thu, 24 Oct 2024 16:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t44nb-0007BW-V9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:51:15 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t44na-0000n4-8Q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:51:15 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DD4621D97;
 Thu, 24 Oct 2024 20:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729803071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Leu3552YOrpvL0bxm5sT3VCm5Y+NryoZHf3aznN+jy4=;
 b=1hCpJs4iM6lba2yJ1uHM91YAEX1t6XIg4DKJS9uUiqTjLkIUMNt8fPzUJdjom6skUADsSg
 D42fYnocfbTzQVSDWnEP8IsuV0S87EaScyd559Tff9G4i6b+TyOBJ1jRSR7zGaJtrT6gjE
 VZ+RjO0yn6WZEz47FvtxMlSfxmWHKpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729803071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Leu3552YOrpvL0bxm5sT3VCm5Y+NryoZHf3aznN+jy4=;
 b=ASDLMb/Xrtr/0dkmvPOaLM3CMWDEbUnVRNM7572wNdnkDcJYoyYQLE2hclzqxlgUkDNQpS
 AIGvyOpBQwr5NJBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1hCpJs4i;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ASDLMb/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729803071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Leu3552YOrpvL0bxm5sT3VCm5Y+NryoZHf3aznN+jy4=;
 b=1hCpJs4iM6lba2yJ1uHM91YAEX1t6XIg4DKJS9uUiqTjLkIUMNt8fPzUJdjom6skUADsSg
 D42fYnocfbTzQVSDWnEP8IsuV0S87EaScyd559Tff9G4i6b+TyOBJ1jRSR7zGaJtrT6gjE
 VZ+RjO0yn6WZEz47FvtxMlSfxmWHKpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729803071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Leu3552YOrpvL0bxm5sT3VCm5Y+NryoZHf3aznN+jy4=;
 b=ASDLMb/Xrtr/0dkmvPOaLM3CMWDEbUnVRNM7572wNdnkDcJYoyYQLE2hclzqxlgUkDNQpS
 AIGvyOpBQwr5NJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A5FC136F5;
 Thu, 24 Oct 2024 20:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Cbw/ED6zGmd2IQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 24 Oct 2024 20:51:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David
 Alan Gilbert" <dave@treblig.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/4] migration: Reset current_migration properly
In-Reply-To: <Zxqqzh-5b4Sz6bFF@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-5-peterx@redhat.com> <875xphfg6j.fsf@suse.de>
 <Zxqqzh-5b4Sz6bFF@x1n>
Date: Thu, 24 Oct 2024 17:51:07 -0300
Message-ID: <8734klfcn8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0DD4621D97
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Oct 24, 2024 at 04:34:44PM -0300, Fabiano Rosas wrote:
>> > +     * here it means migration object is gone.  Clear the global reference
>> > +     * to reflect that.
>> 
>> Not really gone at this point. The free only happens when this function
>> returns.
>
> How about "is going away"?

Yep

