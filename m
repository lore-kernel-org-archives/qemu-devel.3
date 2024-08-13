Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEF3C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 14:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sds7h-0000r7-HP; Tue, 13 Aug 2024 10:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sds7f-0000pB-I9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sds7d-0000wa-Sj
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723557816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J6j+LUWomIxEI6R4Yn4ks4Gnz4VF37g4JDVVk/F303Q=;
 b=Ipw84hQcHty9p6656RCSbhr4NDqJuPlTyvnFzXRdhr1a7XbRBTOHF8ivF12Vv3r8fA0sK+
 z6UQbCG9HreROMrvJBfzRx9dlymWy6G1d/CmWxavjHQ5xVZAGN1d69f1FOH28poHhoR3vQ
 0r7WiEmr2s8KhbXjmX0qUTAZc+JfoBw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-AuLerkaWPJqlH4DTx_0cig-1; Tue,
 13 Aug 2024 10:03:32 -0400
X-MC-Unique: AuLerkaWPJqlH4DTx_0cig-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FC9E18EA818; Tue, 13 Aug 2024 14:03:27 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25707300019C; Tue, 13 Aug 2024 14:03:24 +0000 (UTC)
Date: Tue, 13 Aug 2024 09:03:22 -0500
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: nbd@other.debian.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] docs: Tweak location of qemu nbd extensions
Message-ID: <y6zzatumbgufg4kqei7xg2oqyn67x56qic4qxtxiolnrewptwa@4uyfygi5rhme>
References: <20240802133811.2001029-1-eblake@redhat.com>
 <Zq4uK9Z6GX7Ga-qY@pc220518.home.grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq4uK9Z6GX7Ga-qY@pc220518.home.grep.be>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Aug 03, 2024 at 03:18:35PM GMT, Wouter Verhelst wrote:
> On Fri, Aug 02, 2024 at 08:36:43AM -0500, Eric Blake wrote:
> > Upstream QEMU is moving the location of its NBD docs, as of its commit
> > XXXX[1].  Instead of pointing to the raw git source file, point to the
> > rendered html version built from rST.
> 
> ACK. Please push as soon as that lands.

The qemu patch has landed and the web page is now live, so I pushed
this as commit 29171ec.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


