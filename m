Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE48E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfFW-0002pz-CV; Thu, 12 Dec 2024 04:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLfFS-0002pj-GR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:12:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLfFP-0008L4-79
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733994758;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgxOqa0OhTqE86GKLvNKCWDgf55jVcO4JduR7uvUJHg=;
 b=Uj8sVsfHruKAr0XqrodzGVqKcynr0DIt/hafE2fN63O7HtQvDlSm6uDNguQ0AbWjRZk/EU
 hKCA4aCdGSaHzxZv3UVBH1ZxKOPvCDfa3DBanA1zw5ResfmbKZ6lBo7vtqPZl5GEdVYXCX
 w8FC8zjP7veRJPRi6ZimCZ3MPY5RXXU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-hLh7yG_QPl6fzSH9QxtHwg-1; Thu,
 12 Dec 2024 04:12:35 -0500
X-MC-Unique: hLh7yG_QPl6fzSH9QxtHwg-1
X-Mimecast-MFC-AGG-ID: hLh7yG_QPl6fzSH9QxtHwg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1B4E1955F41; Thu, 12 Dec 2024 09:12:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E52B195605A; Thu, 12 Dec 2024 09:12:30 +0000 (UTC)
Date: Thu, 12 Dec 2024 09:12:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: Re: [PATCH v2 01/31] tests/functional: remove many unused imports
Message-ID: <Z1qo_AoSsxbk0QPF@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-2-berrange@redhat.com>
 <58575b88-15ae-4bea-a191-8ec6dc579162@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58575b88-15ae-4bea-a191-8ec6dc579162@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 11, 2024 at 08:31:35PM +0100, Thomas Huth wrote:
> On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> > Identified using 'pylint --disable=all --enable=W0611'
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/asset.py              | 1 -
> >   tests/functional/qemu_test/tesseract.py          | 1 -
> >   tests/functional/qemu_test/tuxruntest.py         | 3 +--
> >   tests/functional/test_aarch64_aspeed.py          | 1 -
> >   tests/functional/test_aarch64_sbsaref_alpine.py  | 1 -
> >   tests/functional/test_aarch64_sbsaref_freebsd.py | 1 -
> >   tests/functional/test_acpi_bits.py               | 2 --
> >   tests/functional/test_arm_aspeed.py              | 1 -
> >   tests/functional/test_arm_bpim2u.py              | 2 +-
> >   tests/functional/test_arm_collie.py              | 2 +-
> >   tests/functional/test_arm_cubieboard.py          | 1 -
> >   tests/functional/test_arm_orangepi.py            | 2 +-
> >   tests/functional/test_arm_smdkc210.py            | 3 +--
> >   tests/functional/test_arm_sx1.py                 | 2 +-
> >   tests/functional/test_microblaze_s3adsp1800.py   | 1 -
> >   tests/functional/test_ppc_amiga.py               | 2 +-
> >   tests/functional/test_virtio_gpu.py              | 1 -
> >   tests/lcitool/libvirt-ci                         | 2 +-
> >   18 files changed, 8 insertions(+), 21 deletions(-)
> ...
> > diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> > index 9ad3f70bde..0f11966131 160000
> > --- a/tests/lcitool/libvirt-ci
> > +++ b/tests/lcitool/libvirt-ci
> > @@ -1 +1 @@
> > -Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
> > +Subproject commit 0f119661317333038e91b6fb9d0381a6934dcd0c
> 
> That one seems unintentional?

Correct :-(


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


