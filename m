Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6F1C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 12:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSytp-0003rA-Mu; Thu, 25 Jan 2024 07:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rSytm-0003po-Sz
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 07:32:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rSytk-0003wI-Ub
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 07:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706185919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4V7+rwa2drGU46d1D2pjPPc90q9XGh3msMRigDRP/10=;
 b=Bej6bgnskKMJttEBjnpZIeh+AAQhJQgGCZl264H/tJipFklTFZnRDxaZ/Jh5QAgZkfEOY1
 /X4cKQ7hjZUhmeGFB4rt5Q35VY5YlLHrpKLKhQIdymM9/mQzcdQm/0EZ+Z8f36DzHaQbf9
 GlYYNuo88xEylYN3fPec8Yp1tX17g9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-TSC9VRTOMF2Rybok16NdWg-1; Thu, 25 Jan 2024 07:31:55 -0500
X-MC-Unique: TSC9VRTOMF2Rybok16NdWg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FEE488CC40;
 Thu, 25 Jan 2024 12:31:55 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D28A492BC6;
 Thu, 25 Jan 2024 12:31:54 +0000 (UTC)
Date: Thu, 25 Jan 2024 13:31:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Maydell, Peter" <peter.maydell@linaro.org>,
 "P. Berrange, Daniel" <berrange@redhat.com>
Subject: Re: Do we still need pre-meson compatibility hacks?
Message-ID: <ZbJUuQF_ZpFI8D5e@redhat.com>
References: <CABgObfaCq+++xj7ow5Sm22P5nfMZyh-BKt57m3Po6voKyCnuXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfaCq+++xj7ow5Sm22P5nfMZyh-BKt57m3Po6voKyCnuXQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 25.01.2024 um 08:54 hat Paolo Bonzini geschrieben:
> Right now configure contains a couple hacks to preserve some of the
> semantics of the pre-meson build system:
> 
> 1) emulation of ./configure by creating a build directory and a forwarding
> GNUmakefile (requested by Kevin)

I occasionally still use this. It's a bit more convenient when it does
work, but I have the impression it's not 100% reliable and sometimes
'make' on the top level doesn't do anything while 'make -C build/' finds
something to do. Though I'm not sure if it actually happens on upstream
or if it's a downstream problem.

> 2) creation of symlinks such as x86_64-softmmu/qemu-system-x86_64 and
> arm-linux-user/qemu-arm (requested by Peter)

This is another thing I haven't tested in a while, but for some reason,
some test cases only used to work for me when I gave them a binary like
x86_64-softmmu/qemu-system-x86_64, but not with ./qemu-system-x86_64.

Kevin


