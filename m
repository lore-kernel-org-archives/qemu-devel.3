Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC6DC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 11:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkLZM-00058Y-Bd; Tue, 18 Feb 2025 06:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkLZL-00058F-18
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:15:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkLZI-00051q-N2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739877309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=onk8IssJ16EKEadeiJZEggVTYgKxpd7GpNBQXMSmpsg=;
 b=Bcx2Yw0IsiuyofB+lYCNUX52GttbTZk5/4NRnNXSMKdCiCqo4fi7m069JmhbiPjphm2Kxi
 yrjwLikqOGV2AemkoXzr6rB03XsFruvU64pVAb3UsieTyDxZYNlAWOFszFtu9OyCjSrE22
 i+1eVWGCrMFK482yevPVKMmjECFIC/c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-OtGip0N5OcORDf37TYzkMA-1; Tue,
 18 Feb 2025 06:15:08 -0500
X-MC-Unique: OtGip0N5OcORDf37TYzkMA-1
X-Mimecast-MFC-AGG-ID: OtGip0N5OcORDf37TYzkMA_1739877307
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D9141800877; Tue, 18 Feb 2025 11:15:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.141])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCFE319560A3; Tue, 18 Feb 2025 11:15:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E0BF918000AC; Tue, 18 Feb 2025 12:15:02 +0100 (CET)
Date: Tue, 18 Feb 2025 12:15:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: ROM files and non-x86
Message-ID: <ezfslatmgi6ixk6hoofubw2qtf6qis3mbgcpvy6cp25cwwl2k7@o4t4qfwzhcj6>
References: <a430de0f-1c27-4c52-97d4-b881efa47131@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a430de0f-1c27-4c52-97d4-b881efa47131@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 18, 2025 at 01:38:42PM +0300, Michael Tokarev wrote:
> Hi!
> 
> Qemu system-mode emulation, when used with a NIC, loads a ROM file
> for network booting (and fails to start if such file is not provided).
> ROMs shipped in the source tarball are x86-only, so such loading does
> nothing on non-x86, where we just wasting guest memory, - since the
> ROM code can not be executed on the target architecture anyway.
> 
> These days, ipxe provides (UEFI) ROM files for architectures other than
> x86.  And these ROMs actually works, making it possible to network-boot
> qemu guests in UEFI mode.

edk2 ships a virtio-net driver, so network boot support does not depend
on ipxe.

Using nics other than virtio-net on aarch64/riscv64/loongarch64 looks
pointless to me.  All these architectures are younger than virtio-net,
so there are no compatibility concerns.

> Would it be possible to make ROMs target-arch-specific, and drop the
> ROM dependency/loading on non-x86 if there's no arch-specific ROM found?

I think this can be done with compat properties today.  IIRC this is
already done for one of the VGA devices to load a macos driver instead
of vgabios into the rom bar.

Given that the roms are mostly needed on x86 I think the simplest
approach would be to turn them off by default and enable for x86
machine types using compat properties.

> This probably requires machine version dependency, to make the machine
> migratable.

Yes.

take care,
  Gerd


