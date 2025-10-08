Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B00CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 09:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6QUj-0006Yl-Ae; Wed, 08 Oct 2025 05:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6QUb-0006XX-2J
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 05:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6QUY-0006aq-Fs
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 05:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759915789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avD59s0MrRejfMmkf6x19QYAcY+XYF1IJL9L4ZCick8=;
 b=USkVAXRVhUwmu4r4oL5uhEhaD2nLvIIQeKQ2PevMn32TfE0CE0Qt0l5l5mTJe/R4Eo+SmR
 JWnCclrmOENSxw4cR9v50xJShLVCW563LCWvMsT44jFKJep9VeHFip8JhpkF8fALAWVMpy
 gAi3X8sRDKy2mdvCk7q1oa9X/DKTGsM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-RhSRZxroPpiu7lFwglr1bg-1; Wed,
 08 Oct 2025 05:29:46 -0400
X-MC-Unique: RhSRZxroPpiu7lFwglr1bg-1
X-Mimecast-MFC-AGG-ID: RhSRZxroPpiu7lFwglr1bg_1759915785
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11DAC195608F; Wed,  8 Oct 2025 09:29:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFCFE1800452; Wed,  8 Oct 2025 09:29:41 +0000 (UTC)
Date: Wed, 8 Oct 2025 10:29:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 2/6] tracetool: apply isort and add check
Message-ID: <aOYvAQC7U1s-cq0x@redhat.com>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008063546.376603-3-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 08, 2025 at 08:35:41AM +0200, Paolo Bonzini wrote:
> Sort imports automatically, to keep the coding style more uniform.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  python/tests/tracetool-isort.sh      | 4 ++++
>  scripts/tracetool.py                 | 5 ++---
>  scripts/tracetool/backend/dtrace.py  | 1 -
>  scripts/tracetool/backend/ftrace.py  | 3 +--
>  scripts/tracetool/backend/log.py     | 3 +--
>  scripts/tracetool/backend/simple.py  | 1 -
>  scripts/tracetool/backend/syslog.py  | 3 +--
>  scripts/tracetool/backend/ust.py     | 1 -
>  scripts/tracetool/format/d.py        | 2 +-
>  scripts/tracetool/format/log_stap.py | 1 -
>  scripts/tracetool/format/stap.py     | 1 -
>  11 files changed, 10 insertions(+), 15 deletions(-)
>  create mode 100755 python/tests/tracetool-isort.sh

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


