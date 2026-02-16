Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DF5E81A2B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 14:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs04L-0001Re-Hz; Mon, 16 Feb 2026 09:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vs04J-0001Qt-9r
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 09:59:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vs04H-0007CQ-A6
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 09:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771253960;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkCbvDet1WGIGsHaEpegvqENk6jWzwz0bWmqEZhgDEw=;
 b=R31dyChI2ID/ns0c5qgkTnHkZEkM0ldxfDAYaoLwnWdgXJbf+Z7EqfjK+lYLKf1nY76+Rg
 xRUMgPYl7s/FENUbNKB4BNjb4kPex0VX3WahDd2QCWxvhUtn2mzTbzYpkPNsd/JnRe2Sex
 Zm85T8gKVyqU0xHtYF2haT1jDXNeP5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-aukwpUE1OLaKVMwHZH7nlw-1; Mon,
 16 Feb 2026 09:59:16 -0500
X-MC-Unique: aukwpUE1OLaKVMwHZH7nlw-1
X-Mimecast-MFC-AGG-ID: aukwpUE1OLaKVMwHZH7nlw_1771253956
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6AAB195FDDB; Mon, 16 Feb 2026 14:59:15 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.52])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C3801800464; Mon, 16 Feb 2026 14:59:12 +0000 (UTC)
Date: Mon, 16 Feb 2026 14:59:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Kane Chen <kane_chen@aspeedtech.com>
Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
Message-ID: <aZMwvfw4O5xeH-Gm@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
 <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
 <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 16, 2026 at 11:17:38AM +0000, Peter Maydell wrote:
> On Mon, 16 Feb 2026 at 11:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Thu, 12 Feb 2026 at 21:42, Cédric Le Goater <clg@redhat.com> wrote:
> > >
> > > Add functional tests for AST2500 and AST2600 machines using the
> > > OpenBMC SDK v11.00 with Linux kernel 5.15. These tests complement the
> > > existing SDK tests and verify that QEMU correctly boots older kernel
> > > versions on these platforms.
> >
> >
> > > +    ASSET_SDK_V1100_AST2600_515 = Asset(
> > > +        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2600-default-515-obmc.tar.gz',
> > > +        'ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6')
> >
> > This asset file is over a gigabyte in size, it takes forever to
> > download, and our functional test asset download framework has
> > no mechanism for giving any kind of progress indication for
> > downloads (or even for telling you the URL it is downloading
> > until after the download is complete).
> >
> > Can we have a size limit for test assets please, at least until
> > the framework can support large assets a bit better ?
> 
> Followup: we have six test assets that are over 500MB in size,
> and they are all aspeed tests. Please can you have a look at
> slimming these down?

I see 2 big assets from aspeed only

  64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93
  ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6


what are the names of the other files in $HOME/.cache/qemu/download
you have that are over 500 MB ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


