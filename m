Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE3CCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut0EG-0002ja-TF; Mon, 01 Sep 2025 04:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ut0EC-0002ge-6g
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ut0E9-0000wb-Jh
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756716563;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9wSE9i7vT8xHbJiCQ2OdMTkv0klDQu89+BoJ6Zih1w=;
 b=Gyw4iMaNeM2Q+Prh2j3QL+h2NpfKns9oR49NJfinfqdLuneCUjnW2MCG5SpTFm1vDZcu9/
 qc/YFClSN4h4vHghrgSbNF4gtoOy/62nYGPJPdwQs11vfYbtsRmd/sGdydvqKrJIkJmGjg
 rokXX9HAoeyZWAt5KimRyR3mW5zLV/U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-ZYFFn6R7OteWiCTQAv6TSQ-1; Mon,
 01 Sep 2025 04:49:20 -0400
X-MC-Unique: ZYFFn6R7OteWiCTQAv6TSQ-1
X-Mimecast-MFC-AGG-ID: ZYFFn6R7OteWiCTQAv6TSQ_1756716560
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4B2719560B4; Mon,  1 Sep 2025 08:49:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 879E9180029B; Mon,  1 Sep 2025 08:49:18 +0000 (UTC)
Date: Mon, 1 Sep 2025 09:49:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 07/14] util: add API to fetch the current thread name
Message-ID: <aLVeCs5QHtAJJLiY@redhat.com>
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-8-berrange@redhat.com>
 <2fbc5525-cf8c-4d3a-ac2e-97d2764fc5f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fbc5525-cf8c-4d3a-ac2e-97d2764fc5f4@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Aug 31, 2025 at 08:14:21AM +1000, Richard Henderson wrote:
> On 8/30/25 04:03, Daniel P. Berrangé wrote:
> > +#ifndef PTHREAD_MAX_NAMELEN_NP
> > +#define PTHREAD_MAX_NAMELEN_NP 16
> > +#endif
> > +
> > +static __thread char namebuf[PTHREAD_MAX_NAMELEN_NP];
> 
> If you're going to have this...
> 
> > +static __thread char namebuf[64];
> 
> ... or this, why not just remember the name from when we set it?
> 
> You could even store a pointer instead of a larger number of characters.
> I'll note that all of the names we actually pass to qemu_thread_create are
> string literals, and that we don't actually need to do any memory allocation
> at all with them.

I was thinking about the possibility there will be threads running that
were not created using qemu_thread_start, given that libraries use threads
behind the scenes and I can't rule out possibility that such threads call
back into QEMU code.

> 
> 
> > +    name = g_utf16_to_utf8(namew, -1, NULL, NULL, NULL);
> > +    LocalFree(namew);
> > +    if (!name) {
> > +        goto error;
> > +    }
> 
> That would certainly avoid this kind of hassle.
> 
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


