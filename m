Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B036CCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNF9-0005f7-Kl; Sat, 30 Aug 2025 11:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urxh4-0008Q4-Md
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urxh2-0002y0-AH
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756468493;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlZSLx5pDOCRxKLaNUjVvsynijDi4vUAs7rDWUUz71o=;
 b=LX7y18gkOyz/xV7v+TGVTH+z9z1JVjPfmW6ymwLSZ//A4eMS2S8LEVpU6ahnicFTOpi5Pk
 iv9gETybXwnqWTGwrfupc+skGIL6dRA59c4q4YMHZ/XRrXT4R1p5Fwh6+ZLbtOW1eBPsV1
 tmtS79cIWso3Guf0D9bcKv0C3pc4K0U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-u2gX84jIN7mz3UmAN0O0nQ-1; Fri,
 29 Aug 2025 07:54:50 -0400
X-MC-Unique: u2gX84jIN7mz3UmAN0O0nQ-1
X-Mimecast-MFC-AGG-ID: u2gX84jIN7mz3UmAN0O0nQ_1756468488
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D0DC180035D; Fri, 29 Aug 2025 11:54:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 514C130001B5; Fri, 29 Aug 2025 11:54:44 +0000 (UTC)
Date: Fri, 29 Aug 2025 12:54:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 10/22] rust: split "migration" crate
Message-ID: <aLGVAbBqkMMn8CkN@redhat.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-11-marcandre.lureau@redhat.com>
 <aLFr3u+r8P5GGZRJ@intel.com>
 <CAMxuvaz6n1bhsknnyfgvgw9sha13sEicAfZ6hsNX-vX7v7eDsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaz6n1bhsknnyfgvgw9sha13sEicAfZ6hsNX-vX7v7eDsw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 29, 2025 at 03:50:02PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Aug 29, 2025 at 12:37 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Hi Marc-Andre,
> >
> > On Wed, Aug 27, 2025 at 02:41:32PM +0400, marcandre.lureau@redhat.com
> > wrote:
> > > Date: Wed, 27 Aug 2025 14:41:32 +0400
> > > From: marcandre.lureau@redhat.com
> > > Subject: [PATCH 10/22] rust: split "migration" crate
> > >
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> >
> > ...
> >
> > > @@ -0,0 +1,51 @@
> > > +/*
> > > + * QEMU System Emulator
> > > + *
> > > + * Copyright (c) 2024 Linaro Ltd.
> > > + *
> > > + * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > obtaining a copy
> > > + * of this software and associated documentation files (the
> > "Software"), to deal
> > > + * in the Software without restriction, including without limitation
> > the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> > sell
> > > + * copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be
> > included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> > SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> > OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > DEALINGS IN
> > > + * THE SOFTWARE.
> > > + */
> >
> > Could we use /* SPDX-License-Identifier: GPL-2.0-or-later */ directly ?
> >
> > [snip]
> >
> 
> I guess we could. Probably for a future cleanup though.

checkpatch will complain about this - all newly introduced files
should be using SPDX-License-Identifier from the start, with no
boilerplate text present.

Also it will warn about any license use which is not GPL-2.0-or-later,
requesting that it be explained in the commit message.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


