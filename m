Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B13D4A609
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfZJ-00067k-Jo; Fri, 16 Jan 2026 03:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgfZH-00066W-Eh
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:52:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgfZG-000795-4J
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768553549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gahUjP6J9EOFfp2dCaR6LCsaHcKgGV6OTPNYuaUkFc=;
 b=IwemMcRvhVP/yduOpZLDIHmrqtcWZGn7y9nS1LSCT53hiWF32Esbu1ismKo8ZYHBF4JlH9
 ywpv9Hu1MJJ9E+1t1FLc2vqzNpr6tG76OUB+PTB7BXsQobN4L73bIdr9/UhobpGqmqOjCN
 04Prvj3XqS5QzEd9KaxHf9tTVZyDpnE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-Yg1kiHHlMWmIthL66L6USA-1; Fri,
 16 Jan 2026 03:52:27 -0500
X-MC-Unique: Yg1kiHHlMWmIthL66L6USA-1
X-Mimecast-MFC-AGG-ID: Yg1kiHHlMWmIthL66L6USA_1768553546
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A394F1954B0C; Fri, 16 Jan 2026 08:52:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AB2C180049F; Fri, 16 Jan 2026 08:52:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D744321E692D; Fri, 16 Jan 2026 09:52:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: dave@treblig.org
Cc: berrange@redhat.com,  marcandre.lureau@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/4] hmp*hx: Move info docs
In-Reply-To: <20260116005050.376616-3-dave@treblig.org> (dave@treblig.org's
 message of "Fri, 16 Jan 2026 00:50:46 +0000")
References: <20260116005050.376616-1-dave@treblig.org>
 <20260116005050.376616-3-dave@treblig.org>
Date: Fri, 16 Jan 2026 09:52:23 +0100
Message-ID: <87ecnqrlbs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

dave@treblig.org writes:

> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> Move the docs for the info subcommand from the separate hx
> into the top level file next to the 'info' command itself.
> That makes every command in the top level file have a RST section.

Could mention:

  Generated HTML changes slightly.  The difference is basically
  invisible.

> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


