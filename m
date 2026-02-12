Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E69EB4901
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 11:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqUT4-0004DJ-8E; Thu, 12 Feb 2026 06:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqUT1-0004D0-OL
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 06:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqUSz-0004cN-Eq
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 06:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770894155;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xARxOAzse0WfjGT9H8LH/Q2n42puzBtm5gCinHf28pw=;
 b=F1Biww32xXDYAXll31GzrZ41uyf+kQ9ke6tyoVfVNgNdiB6/Fhxik4yUGc1UZhmbP1dcZq
 Jj6pbPuyNkyfcFG1AVmn90V7KsxcwkdzwSgmPM6UvzRzYxxM1ITeZAxMaJdaS0J/GAQhNS
 WBECWDKvt+Kr0HT73eGnXCA3Mtypnyg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-9__ZzrmkPHqgKnoALvoAGA-1; Thu,
 12 Feb 2026 06:02:34 -0500
X-MC-Unique: 9__ZzrmkPHqgKnoALvoAGA-1
X-Mimecast-MFC-AGG-ID: 9__ZzrmkPHqgKnoALvoAGA_1770894153
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 131D518005B7; Thu, 12 Feb 2026 11:02:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.206])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 005201800464; Thu, 12 Feb 2026 11:02:30 +0000 (UTC)
Date: Thu, 12 Feb 2026 11:02:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] baum: Add copy/paste bindings
Message-ID: <aY2zQ6X3qxuZR7Jl@redhat.com>
References: <20260211204445.4124071-1-samuel.thibault@ens-lyon.org>
 <CAJ+F1CKZUz6QDDYj9g2NeyKimOrcXDN-ZYG12CYg2pJn9s4Hjw@mail.gmail.com>
 <CAFEAcA-hvi0=eCr=Bs+sYBJCgAQNsi6kSyo7=xFHq8AG0MNyZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-hvi0=eCr=Bs+sYBJCgAQNsi6kSyo7=xFHq8AG0MNyZw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 12, 2026 at 10:33:26AM +0000, Peter Maydell wrote:
> On Thu, 12 Feb 2026 at 09:44, Marc-André Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Those commands date back from brltty 4.4 (June 7, 2012). I suggest we
> > add a version check to the brlapi dependency.
> 
> Does any distro version in our support policy still ship such
> an old brltty version that it doesn't have them? If not, we
> don't need to actively check the version here, I think.

The brlapi is a bit wierd in that it ships a pkg-config file, but does
not specify any cflags/libs in there :-(

We currently detect brltty by looking for the header file manually.

We could at least do a pkg-config check to validate existence, and
the min version, but manually set the library name the linker.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


