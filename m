Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E52CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 16:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0jbR-00074v-IP; Mon, 22 Sep 2025 12:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0jbD-00073O-BV
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0jb6-0002uf-SR
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758559261;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rV1MBmUO+kFwpzKCwnYt3rkCiVRoBG3ljNTdOHB19w=;
 b=Y2ww7YDRXOYq0Dpma6EnkQcUj0oirB2aJ3iZ1EvntmODFvS4pvfS4Ox2G0DfLXp66SrKlW
 RQbGQJIBogSrHjTeCZCYZlWRgsoEKYZNrrXW/VDbu/xev0Fxt1hm0vq6ORi501Vu8KE/8H
 bUwyTlxV+8OWEF5ayUUCnxAF9syzdSU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-6kMzRk26MAqWSf05Ui_hVg-1; Mon,
 22 Sep 2025 12:40:58 -0400
X-MC-Unique: 6kMzRk26MAqWSf05Ui_hVg-1
X-Mimecast-MFC-AGG-ID: 6kMzRk26MAqWSf05Ui_hVg_1758559257
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2F6C1800366; Mon, 22 Sep 2025 16:40:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71CB719560BB; Mon, 22 Sep 2025 16:40:52 +0000 (UTC)
Date: Mon, 22 Sep 2025 17:40:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH 14/24] tests: move mips to debian-legacy-test-cross
Message-ID: <aNF8EKwH3lTb2R1D@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-15-marcandre.lureau@redhat.com>
 <aM1m13xBnM9WU_E3@redhat.com>
 <CAMxuvayXSdVaz=i56T686oKpKf5gE4y6YaPgedPBKGQEPx0v8w@mail.gmail.com>
 <aNERkB5WhM4ePIHn@redhat.com>
 <c94acf92-5f35-45ea-a11e-c85ff7e4d811@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c94acf92-5f35-45ea-a11e-c85ff7e4d811@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 22, 2025 at 05:10:56PM +0200, Paolo Bonzini wrote:
> On 9/22/25 11:06, Daniel P. Berrangé wrote:
> > On Mon, Sep 22, 2025 at 12:38:09PM +0400, Marc-André Lureau wrote:
> > > debian-legacy-test-cross is for tests/tcg. Debian 11 supports more
> > > architecture than 12 or 13..
> > 
> > If there are architectures in 11 that can't be tested in 12,
> > then from QEMU's POV that is now an untestable feature, since
> > 11 is outside our support target and we don't want to be
> > holding back our support platforms for this.
> 
> That is true for using that architecture as a host; but as a target, the
> architecture remains testable with just a few extra hoops to obtain a
> working cross compiler.

The commit here mixes that boundary though. The legacy container is
currently used to provide cross compilers for the check-tcg tests
with is outside scope of our support matrix. This commit, however,
is removing the testing of mips host build on Debian 12, while
adding mips gcc to this old Debian 11 container.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


