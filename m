Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA07E83078
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDLP-0005X9-GI; Tue, 03 Feb 2026 05:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vnDLN-0005VX-Q5
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:09:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vnDLM-0007yh-6p
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770113350;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NUphXlWOfcy3FmwO+7YanS268AhVOoSKPtrqxOe9dys=;
 b=b99y1587Khl0N8mjzoGJrxEYsXEQCzxIoQu/CNGtJkBh01x9m9IJmDbycSRB8BmdSZoVUq
 3K3l0P6Ai/Y9cxSBMwxcsMWABOnLl7qID0NDiJgA+aGnD8l9NKwW26z6IyO40EOGq9KHyp
 Sn6ZHa0bZ369WB0lrPHnRumU7ca7nzM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-cafQEms-ORqbHOnNW6-fEQ-1; Tue,
 03 Feb 2026 05:09:09 -0500
X-MC-Unique: cafQEms-ORqbHOnNW6-fEQ-1
X-Mimecast-MFC-AGG-ID: cafQEms-ORqbHOnNW6-fEQ_1770113348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4224E18002C7; Tue,  3 Feb 2026 10:09:08 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.45])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C0451800947; Tue,  3 Feb 2026 10:09:06 +0000 (UTC)
Date: Tue, 3 Feb 2026 10:09:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: openSUSE container failure
Message-ID: <aYHJPoaFEfs2G3kI@redhat.com>
References: <74094b25-73bc-4e76-a7d6-d41e2a22c6b9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74094b25-73bc-4e76-a7d6-d41e2a22c6b9@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 03, 2026 at 10:47:46AM +1000, Richard Henderson wrote:
> E.g. https://gitlab.com/qemu-project/qemu/-/jobs/12960514743
> 
> Annoyingly, the gitlab pipeline drops some critical lines that show the
> error.  Thankfully I can reproduce locally:
> 
> > Resolving package dependencies...
> > 
> > Problem: 1: nothing provides 'rust1.93' needed by the to be installed rust-1.93.0-150500.27.62.1.x86_64
> >  Solution 1: do not install rust-1.93.0-150500.27.62.1.x86_64
> >  Solution 2: break rust-1.93.0-150500.27.62.1.x86_64 by ignoring some of its dependencies
> > 
> > Choose from above solutions by number or cancel [1/2/c/d/?] (c): c
> 
> It does appear that there's no rust package available anymore?
> Should we just drop rust from this image for now?

It appears opensuse repos have pushed broken the Rust packages.  "rust" is
available, but it has a dep on "rust1.93" which is NOT published, the
newest is "rust1.92". 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


