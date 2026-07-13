Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAA6C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFak-0003jt-5a; Mon, 13 Jul 2026 08:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjFaj-0003jS-96
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjFag-00085H-UX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783945014;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WowKFqloqtS7tNNVEJRyD+VnJHdZAYwSMQvFEdfcv60=;
 b=DaQvXP9hQfn0Z9X/6Gzbd/GYTW/68aqv2/bd5Qr4Ll8YpB2Rsi4YwrpKeQHDYO0JZ/5mbG
 +P1+nU94VxFbZrOctqxRJIwiT2YyV8cuIe4vklQKbQM4uvj5V49I40O7KrnYfL3PWgBWNi
 /xJlAKKxBOZobfZ51GFCzl2DcC3WRu8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-a-ax5XnrPWmLdPOimESrNA-1; Mon,
 13 Jul 2026 08:16:51 -0400
X-MC-Unique: a-ax5XnrPWmLdPOimESrNA-1
X-Mimecast-MFC-AGG-ID: a-ax5XnrPWmLdPOimESrNA_1783945010
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C0BB1955E7D; Mon, 13 Jul 2026 12:16:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DA8D1800593; Mon, 13 Jul 2026 12:16:48 +0000 (UTC)
Date: Mon, 13 Jul 2026 13:16:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-trivial@nongnu.org
Subject: Re: [PATCH] json-parser: fix formatting of comment
Message-ID: <alTXLYe2dZHptHj1@redhat.com>
References: <20260713114622.1950506-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713114622.1950506-1-pbonzini@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 13, 2026 at 01:46:22PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qobject/json-parser.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 5935730c0c7..6b1b4762bda 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -29,9 +29,10 @@
>   * object, an error, or NULL (if the object is incomplete and no error
>   * happened) after every token.  Therefore it has an explicit
>   * representation of its parser stack; each stack entry consists of a
> - * parser state and a QObject: - a QList, for an array that is being
> - * added to - a QDict, for a dictionary that is being added to - a
> - * QString, for the key of the next pair that will be added to a QDict
> + * parser state and a QObject:
> + * - a QList, for an array that is being added to
> + * - a QDict, for a dictionary that is being added to
> + * - a QString, for the key of the next pair that will be added to a QDict

bike shedding a little....

  representation of its parser stack; each stack entry consists of a
  parser state and a QObject:
   - QList: an array that is being added to
   - QDict: a dictionary that is being added to
   - QString: the key of the next pair that will be added to a QDict


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


