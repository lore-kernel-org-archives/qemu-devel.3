Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C3DC021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 12:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkMPq-0002Rj-19; Tue, 18 Feb 2025 07:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkMPl-0002RR-0H
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 07:09:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkMPg-00046n-7A
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 07:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739880558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XDkTUj0mpVFaIQDbae/lmO7G+0fgtZ7kULDZiE1sfA=;
 b=fRbde0gN1bkZkIyJEhYwcXYVgTP5cbPhKbH2RDG1kAcNvsZ71kCZMN+UJ2lLl4nKUPprQ6
 8ELon83VwvYODRBGRA/3HBTxW7qabC1NzwKGfPx74vMa7LLXVNjWjCvMopY9dPjNcE52y4
 SrxUTjDG4dggdYT5fubAyrvP14btPSo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-UpAz2koRPAerdrlAreuC2g-1; Tue,
 18 Feb 2025 07:09:16 -0500
X-MC-Unique: UpAz2koRPAerdrlAreuC2g-1
X-Mimecast-MFC-AGG-ID: UpAz2koRPAerdrlAreuC2g_1739880555
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63C24180087C; Tue, 18 Feb 2025 12:09:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.141])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B24301800361; Tue, 18 Feb 2025 12:09:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 349A918000AC; Tue, 18 Feb 2025 13:09:11 +0100 (CET)
Date: Tue, 18 Feb 2025 13:09:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: ROM files and non-x86
Message-ID: <b7xkiw3cz2wh4mp47gj4f6ogbk2wvfl6tbardpaemoptkbzwsg@oojekkoz22kq>
References: <a430de0f-1c27-4c52-97d4-b881efa47131@tls.msk.ru>
 <Z7RpEvbg7ecBN1vf@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7RpEvbg7ecBN1vf@kitsune.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi,

> > A similar question exists about seabios and vgabios - for example,
> > virtio-vga device always tries to load vgabios.rom on all architectures,
> > while on non-x86 it is useless.
> 
> In this case it is more dodgy. I vaguely recall some code for
> interpreting these BIOSes somewhere. That is the x86 BIOS can run in
> some emulation to provide the BIOS functionality on non-x86. Not sure
> how much it's actually used in practice for the kinds of cards that qemu
> emulates.

Only relevant in software museums.  X11 has a vesa driver doing exactly
this.  It's only used in case your linux kernel is so old that it does
not ship drm drivers for qemu vga devices.

take care,
  Gerd


