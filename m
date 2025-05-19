Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F95DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0oL-00056v-6F; Mon, 19 May 2025 09:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH0oD-00056N-2e
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH0oA-000087-SJ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747662332;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QM0UZsyEGrtPvcJvo8S6NiJMpfvCmuRHPeSmgZmC0V0=;
 b=NkIggLGpPWnbHl4+UL4BW9M8XKUiMxRMusvgaB+brbF2p8mXekKtHaHv7ulVZ52fRIbYg2
 ECboZmgZGIt3A4JSe69/UHitpbZsVD7pp4CKr5JmbKdt98URPn/4dqH1Q7EJjtMWTretLH
 aaapdyQ4W46gd8FLlWzr0cIkE0rNMJE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-ZiEi97MdN96mJazonM2vJg-1; Mon,
 19 May 2025 09:45:29 -0400
X-MC-Unique: ZiEi97MdN96mJazonM2vJg-1
X-Mimecast-MFC-AGG-ID: ZiEi97MdN96mJazonM2vJg_1747662328
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39315180087B; Mon, 19 May 2025 13:45:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA78119560AA; Mon, 19 May 2025 13:45:26 +0000 (UTC)
Date: Mon, 19 May 2025 14:45:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cole Robinson <crobinso@redhat.com>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH] roms: re-remove execute bit from hppa-firmware*
Message-ID: <aCs183hjzXVafV6B@redhat.com>
References: <52d0edfbb9b2f63a866f0065a721f3a95da6f8ba.1747590860.git.crobinso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52d0edfbb9b2f63a866f0065a721f3a95da6f8ba.1747590860.git.crobinso@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, May 18, 2025 at 01:54:20PM -0400, Cole Robinson wrote:
> This was fixed in c9d77526bddba0803a1fa982fb59ec98057150f9 for
> 9.2.0 but regressed in db34be329162cf6b06192703065e6c1010dbe3c5 in
> 10.0.0
> 
> When the bit is present, rpmbuild complains about missing ELF build-id
> 
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
>  pc-bios/hppa-firmware.img   | Bin
>  pc-bios/hppa-firmware64.img | Bin
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 => 100644 pc-bios/hppa-firmware.img
>  mode change 100755 => 100644 pc-bios/hppa-firmware64.img

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Though given the back & forth, I wonder if we wouldn't be better off
changing meson.build rules instead to mode 0644 for all blobs ?

  install_data(blobs,
               install_dir: qemu_datadir,
	       install_mode: 0644)

...assuming none actually need execute bits set.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


