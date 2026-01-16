Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A97ED4A613
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfSF-0003dD-R2; Fri, 16 Jan 2026 03:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgfSE-0003ZL-Ly
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgfSC-0006E5-R4
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768553111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=feJ4iqoolBevQVHLQZWcSpM6kOGliGrjPiRWu5eLyk0=;
 b=M3pPHbzyOppxwjHOGLSokKu/PgOs3HBBojokEmLwqRQq5GVCT7QfARkHxvCv9Uhz5wxSJC
 qsdaMKy9IRX25zdBZ5evvRC7Ryltuxq+y8RJ6PxjfSMJmOL+aLE6WshdoTApUANs8mqWQ5
 zyaw4PZKuQPYAOJNGHFhGiyLfBtLqvg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-PicsCuUDNBu34fOKtpj0-Q-1; Fri,
 16 Jan 2026 03:45:09 -0500
X-MC-Unique: PicsCuUDNBu34fOKtpj0-Q-1
X-Mimecast-MFC-AGG-ID: PicsCuUDNBu34fOKtpj0-Q_1768553108
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C377919560B2; Fri, 16 Jan 2026 08:45:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5468A18001D5; Fri, 16 Jan 2026 08:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF50621E692D; Fri, 16 Jan 2026 09:45:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: berrange@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] hmp*hx: Move info docs
In-Reply-To: <aWk1FvYlhq6a1Sbm@gallifrey> (David Alan Gilbert's message of
 "Thu, 15 Jan 2026 18:42:30 +0000")
References: <20260115020423.722069-1-dave@treblig.org>
 <20260115020423.722069-3-dave@treblig.org>
 <875x93xf4q.fsf@pond.sub.org> <aWk1FvYlhq6a1Sbm@gallifrey>
Date: Fri, 16 Jan 2026 09:45:05 +0100
Message-ID: <87o6murlny.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> dave@treblig.org writes:
>> 
>> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
>> >
>> > Move the docs for the info subcommand from the separate hx
>> > into the top level file next to the 'info' command itself.
>> > That makes every command in the top level file have a RST section.
>> >
>> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
>> 
>> Generated HTML changes slightly, diff appended.  Shows as vertical space
>> differences in Firefox.  Do we care?
>
> It looked OK to me in Firefox, is there a bit that looks wrong/bad to you?

The vertical spacing around "info subcommand" changes.

Old: extra space between "xen-event-list" and "info subcommand" compared
to between other commands.

New: extra space between "info subcommand"'s doc text and "info
version".

Hypothesis: the extra space is at the boundary between hmp-commands.hx
and hmp-commands-info.hx.

I dislike the old extra space a bit less, but no big deal either way.

[...]


