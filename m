Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344C8C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVS0-0007uV-8s; Tue, 20 Feb 2024 14:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcVRx-0007qw-MW
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcVRs-0002hg-Ig
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708455995;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sO8R3OzUB1H3wBdHR615YvIz8eF8WRxI63ti1vq6aV0=;
 b=iuRAgkH7TcykFGmeP+0S1/aOUBdmUEfnfG0EoZTNVXZKQ3wIzNf6BqPvWpP30/kOR/AAPu
 dFh14gt4g8nJN73KwDXtQzv0l0Mvu50DRHDFjVOII7b54WBTjiUFWGBjbd2BikKoaf38zt
 BGzulaA8+rtiPeo6WncE+RXISqw2r1I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-ss9RuhPhPySJusnJ9Ugz0g-1; Tue,
 20 Feb 2024 14:06:32 -0500
X-MC-Unique: ss9RuhPhPySJusnJ9Ugz0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1305B1C54037;
 Tue, 20 Feb 2024 19:06:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 681BD400D784;
 Tue, 20 Feb 2024 19:06:28 +0000 (UTC)
Date: Tue, 20 Feb 2024 19:06:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 23/23] qemu-img: inline list of supported commands,
 remove qemu-img-cmds.h include
Message-ID: <ZdT4Muc9M5kQ1S9J@redhat.com>
References: <cover.1707513011.git.mjt@tls.msk.ru>
 <a7e67594e748d1b91f755dd971f222afa09f5443.1707513012.git.mjt@tls.msk.ru>
 <ZdT0A3b9-JrMd6aI@redhat.com>
 <00cd5770-29f1-451c-8d13-2b9e987e6c7f@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00cd5770-29f1-451c-8d13-2b9e987e6c7f@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 20, 2024 at 10:02:32PM +0300, Michael Tokarev wrote:
> 20.02.2024 21:48, Daniel P. Berrangé:
> ...
> > $ ./build/qemu-img check --help
> > Check basic image integrity.
> > 
> > Usage:
> > 
> >    qemu-img check [-f FMT | --image-opts] [-T CACHE_MODE] [-r] [-u]
> >          [--output human|json] [--object OBJDEF] FILENAME
> > 
> > Arguments:
> 
> $ ./build/qemu-img check --help
> Check basic image integrity.  Usage:
> 
>    qemu-img check [-f FMT | --image-opts] [-T CACHE_MODE] [-r] [-u]
>           [--output human|json] [--object OBJDEF] FILENAME
> 
> Arguments:
> ...
> 
> Or just:
> 
> Check basic image integrity:
> 
>  qemu-img check...
> 
> 
> In all cases I tried to make the whole thing as compact as possible,
> to (almost) fit on a standard terminal.  The extra empty lines between
> different arguments makes it almost impossible.

IMHO fitting on a "standard" terminal is OK in terms of width, but
should be a non-goal in terms of height. Readability is more important
than avoiding vertical scroll.

> > >              "Arguments:\n"
> > >              " -h|--help - print this help and exit\n"
> 
> btw, the common way is to use comma here, not "|", --
>   -h,--help - ...
> 
> Again, I especially omitted space after "|" to make it
> more compact.  Maybe for no good.

Yes, a comma with a space would look nicer. If we have the
description on the following line, then there's no width
limit problems there.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


