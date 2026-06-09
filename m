Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9B5CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtnO-0004D8-9t; Tue, 09 Jun 2026 06:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wWtnJ-0004Ch-D7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wWtnI-0003bQ-2S
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781001291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZK+pvwkqWFiZ5J1nrFy4EafopDF0DRdTpAqjIGRm17o=;
 b=gQ13ofJeOH2HQO/lJsjwTR/ElQuC1BbB2Z9p1pCpUxedoHyx2PUrUvnZfUh+bEiBYJzSeA
 VRwUknhKY9mfYC/HoQZuGfJF/2DGH/NqtgEGKzeABZWmPekLqnNHE4WoViYsvbs861h5hS
 ISq7fv9XgZ+Knx2RObd4ZQlC8ghv2BA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-FEtozQZvMzSkooI6p55dMg-1; Tue,
 09 Jun 2026 06:34:47 -0400
X-MC-Unique: FEtozQZvMzSkooI6p55dMg-1
X-Mimecast-MFC-AGG-ID: FEtozQZvMzSkooI6p55dMg_1781001286
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76E521955BCE; Tue,  9 Jun 2026 10:34:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.153])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37A3E36919; Tue,  9 Jun 2026 10:34:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 157F11800391; Tue, 09 Jun 2026 12:34:45 +0200 (CEST)
Date: Tue, 9 Jun 2026 12:34:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] add a note on -shim to direct kernel boot docs
Message-ID: <aifm6ftvlQSIXCOg@sirius.home.kraxel.org>
References: <20260604134422.359214-1-kraxel@redhat.com>
 <CAFEAcA9RnjQyxmBcBunrMq6EB=L=Oc4_aWQAYY8rVFr6mKWXog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9RnjQyxmBcBunrMq6EB=L=Oc4_aWQAYY8rVFr6mKWXog@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  Hi,

> > +linux kernel is signed by the distro and is verified by shim.efi.  So
> > +without shim.efi in the loop secure boot verification will not work.
> 
> What are the symptoms? Does the firmware refuse to start the kernel,

Yes, the firmware refuses to load the kernel with an "Access Denied"
error.  Newer edk2 versions additionally print a hint that secure boot
is most likely the reason for that, so it should be obvious enough.

> > +Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
> > +distro install media.
> 
> I think the BOOT* names are a RedHat-ism -- my local Ubuntu box
> has "shimx64.efi".

No.  The BOOT* names are the ones in the UEFI spec and should work
everywhere.  Typically there is an additional copy in
EFI/$distro/shim*.efi.

> Do we need to warn the user to make sure they use e.g. a matched
> shim binary for the guest kernel they're trying to boot, or can
> anybody's shim binary boot anybody's guest kernel ?

Both shim + kernel should come from the same distro.  There is no strict
version dependency though, usually the fedora shim binary can boot all
fedora kernels, except in case some signing key gets rotated or must be
revoked.

With additional configuration steps it is also possible to have ubuntu
shim boot fedora kernels and visa versa, but that is clearly way beyond
the scope of this patch.

The tl;dr version is: take shim + kernel + initrd all from the same
install media and things will just work.

take care,
  Gerd


