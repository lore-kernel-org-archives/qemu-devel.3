Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA7FEDF154
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 11:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqriu-0005KF-Ud; Fri, 13 Feb 2026 06:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqris-0005K5-8J
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 06:52:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqriq-00076s-Ad
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 06:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770983549;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLjEqRVbYdXVUtgUm36rHuqBkcnOqdFgItsa9L11swk=;
 b=Ql8VnySS7iSGGpGsy6VupbOuXQnVu6T/LEu0fnFEBrV0DxOcFXxC/7DZJ5d1hLMhGkqJGV
 dRmta/KHp7BFRklVaqtkPDU1bI3BLSKYYwnY/nxjBp252aSE1txo1+ZUAcEdAtxobcvWyg
 GEop6u3ZWYIWgVdy1YbHyPR8iP2eS80=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-8QIn8BBxOVeZ96q2BnZTDQ-1; Fri,
 13 Feb 2026 06:52:26 -0500
X-MC-Unique: 8QIn8BBxOVeZ96q2BnZTDQ-1
X-Mimecast-MFC-AGG-ID: 8QIn8BBxOVeZ96q2BnZTDQ_1770983546
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD1961955D8F; Fri, 13 Feb 2026 11:52:25 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF19B1800464; Fri, 13 Feb 2026 11:52:23 +0000 (UTC)
Date: Fri, 13 Feb 2026 11:52:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Aidan Khoury <aidan@aktech.ai>
Subject: Re: [PULL v2 29/41] i386/cpu: Fix incorrect initializer in Diamond
 Rapids definition
Message-ID: <aY8QdCBQFQAwMD04@redhat.com>
References: <20260213102109.107491-1-pbonzini@redhat.com>
 <20260213102109.107491-2-pbonzini@redhat.com>
 <aY8GLhvyOLZgv7MF@redhat.com>
 <CAFEAcA_SWSO3cufc3MDv600Qc4nf7pipEhCyt8JLSG2rqQa3fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_SWSO3cufc3MDv600Qc4nf7pipEhCyt8JLSG2rqQa3fA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Fri, Feb 13, 2026 at 11:48:29AM +0000, Peter Maydell wrote:
> On Fri, 13 Feb 2026 at 11:09, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Fri, Feb 13, 2026 at 11:21:09AM +0100, Paolo Bonzini wrote:
> > > From: Aidan Khoury <aidan@aktech.ai>
> > >
> > > The new Diamond Rapids x86 cpu model definition that was added in 7a6dd8bde1
> > > has an unexpected comma in the `.features[FEAT_VMX_EXIT_CTLS]` subobject
> > > initializer, causing the prior initialization to be overridden.  For this
> > > reason `VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE`
> > > is not included.
> > >
> > > Fix this by replacing the comma with the missing bitwise OR to properly
> > > combine all the flags into a single bitmask value.
> > >
> > > Fixes: 7a6dd8bde159 ("i386/cpu: Add CPU model for Diamond Rapids")
> > > Signed-off-by: Aidan Khoury <aidan@aktech.ai>
> >
> > That's missing your S-o-B
> 
> 
> I have this pullreq tested and ready to apply -- do you think this
> is important enough to respin?

I'm not that fussed if it is just 1 out of the 41 patches, but I've
not received the other patches in this pull so haven't checked.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


