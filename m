Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94330C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 10:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ23K-0000fn-Ox; Fri, 13 Jun 2025 06:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ23I-0000fa-D6
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 06:54:28 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ23G-0004CH-20
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 06:54:27 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.84])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id 916811800EC;
 Fri, 13 Jun 2025 11:54:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1749812056;
 bh=K80DA7Fvltgvri8sKTPJ/YNND0GS1uCJMPH1v67Nvrs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=M5HfBb9mkqKSSZGH/s5L+CfNLskQogUdbVdmQd0P2hpibG/GEtIZDIyFA0wLAisgy
 oXUsoqlKHm9MJHvlNhEU18uboKwM/JIUbIB34Xer/CMJhGO1TeeXrOz/+qJYBX19wb
 OOaQ08i5UFOfJAzMCu2W+r///3JeFwa+X1joiVRg=
Received: from [172.22.54.5] (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id C41ECA0238;
 Fri, 13 Jun 2025 11:54:11 +0100 (BST)
Message-ID: <d0638b3c214b333c6866627f0b0b45ed1ac6f74f.camel@randomman.co.uk>
Subject: Re: [PATCH v7 03/16] backends/igvm: Add IGVM loader and configuration
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P .
 Berrange" <berrange@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, Joerg
 Roedel <jroedel@suse.com>
Date: Fri, 13 Jun 2025 11:54:11 +0100
In-Reply-To: <npky2kaolzdvj2qmn3tk3vsdnf4bontjwzyjyftoh3mgmgiars@kqverspb5htg>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
 <928b7178f2960441871dbb8145f639b10ac84ccb.1740663410.git.roy.hopkins@randomman.co.uk>
 <npky2kaolzdvj2qmn3tk3vsdnf4bontjwzyjyftoh3mgmgiars@kqverspb5htg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 2025-02-28 at 14:13 +0100, Gerd Hoffmann wrote:
> On Thu, Feb 27, 2025 at 01:44:07PM +0000, Roy Hopkins wrote:
> > The IGVM loader can be used to configure both confidential and
> > non-confidential guests.
>=20
> For non-confidential guests the initial register state is not loaded.
> https://github.com/coconut-svsm/qemu/pull/17=C2=A0has a somewhat hackish =
fix.
>=20

Thanks for this. I've taken a look at how this can be implemented based
on the current patch series but it would require some non-trivial
changes seeing as the IGVM implementation is handled as part of the
confidential-guest-support code.

I think it best to leave this series as-is and I'll author patches to
add support for setting non-confidential CPU state after this series has
merged.

Regards,
Roy

> take care,
> =C2=A0 Gerd
>=20


