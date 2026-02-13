Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085AAEEA870
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 00:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgl3-0003Qm-1v; Thu, 12 Feb 2026 19:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1vqgl1-0003QV-57
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:10:03 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1vqgl0-0000tO-QM; Thu, 12 Feb 2026 19:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=WB0gWfLcKZu/8tj9zy7agXpdcY8BJIMMzBf89KI33gs=; b=UOaMB3y9eXMjkgUoGIRA
 XO13RvGgBn5soTKHQNVp2Ngo0dGZ9X4YdWG5cLdPSsowoSusB6HsqqMrPyLkg+4Aoop99QUPYWr5H
 kG+kqmWKVAFwVyha4p7UpnGhVsS3eqA+P4Yyy8z2NhhnLNWdvCkgvH3EO9wL7dVH6AM/HfES1jMFH
 f0pKvt7jLKV/3fkT8oQFIMQ67Pt24vVTxpIcJhT9fWKWDqSnjoAWjxal4LYy4WLi7zx3fZKIq345U
 3eKbz/rpQa8EbpFl9ZBkxh00qUUTWw3QBzypbjE6/b5Lzg+TMpzWpNbk/3rdCIn5CGEWRjq3tss27
 pVfc2GFxfwxioA==;
Date: Fri, 13 Feb 2026 01:09:58 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] baum: Add copy/paste bindings
Message-ID: <aY5r1gI1t-uOnmbU@end>
References: <20260211204445.4124071-1-samuel.thibault@ens-lyon.org>
 <CAJ+F1CKZUz6QDDYj9g2NeyKimOrcXDN-ZYG12CYg2pJn9s4Hjw@mail.gmail.com>
 <CAFEAcA-hvi0=eCr=Bs+sYBJCgAQNsi6kSyo7=xFHq8AG0MNyZw@mail.gmail.com>
 <aY2zQ6X3qxuZR7Jl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aY2zQ6X3qxuZR7Jl@redhat.com>
Organization: I am not organized
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

Daniel P. Berrangé, le jeu. 12 févr. 2026 11:02:27 +0000, a ecrit:
> On Thu, Feb 12, 2026 at 10:33:26AM +0000, Peter Maydell wrote:
> > On Thu, 12 Feb 2026 at 09:44, Marc-André Lureau
> > <marcandre.lureau@gmail.com> wrote:
> > >
> > > Those commands date back from brltty 4.4 (June 7, 2012). I suggest we
> > > add a version check to the brlapi dependency.
> > 
> > Does any distro version in our support policy still ship such
> > an old brltty version that it doesn't have them? If not, we
> > don't need to actively check the version here, I think.
> 
> The brlapi is a bit wierd in that it ships a pkg-config file,

? Does it?

Upstream doesn't.

> We currently detect brltty by looking for the header file manually.

Yes, there has never been anything more than that.

Samuel

