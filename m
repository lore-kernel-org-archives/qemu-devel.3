Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E2AD3B7F8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0ef-0004va-53; Tue, 09 Dec 2025 11:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vT0eU-0004u8-SK
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:33:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vT0eS-0004fO-PU
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765298001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gHPLyyftNYxAv0qCCFjZSv1kC2VinNXBS5MKVKtZ1o=;
 b=ehAjilatlJxXaARyPuhTn5ZPujQQH1j5ROEAx5OgH4rTsXl59rJnaNd6Ix9j6sUbHa13c3
 X10PQ/QTVb++5FODElTEWk/2fe4hNqAX9ExJUcgVy/FXlKNb87eMAQreWsjDhhBRcG44Sg
 i75CbMAoPpU0nkapGIMGaf9MCnvaFaI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-Ck3foxl2OpKZC2Xjromkgw-1; Tue,
 09 Dec 2025 11:33:18 -0500
X-MC-Unique: Ck3foxl2OpKZC2Xjromkgw-1
X-Mimecast-MFC-AGG-ID: Ck3foxl2OpKZC2Xjromkgw_1765297997
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 059B11800378; Tue,  9 Dec 2025 16:33:17 +0000 (UTC)
Received: from localhost (dhcp-192-223.str.redhat.com [10.33.192.223])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3114D30001BE; Tue,  9 Dec 2025 16:33:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, sebott@redhat.com
Cc: maz@kernel.org
Subject: Re: [PATCH 3/3] target/arm/cpu-sysregs.h.inc: Update with automatic
 generation
In-Reply-To: <20251208163751.611186-4-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251208163751.611186-1-eric.auger@redhat.com>
 <20251208163751.611186-4-eric.auger@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Tue, 09 Dec 2025 17:33:13 +0100
Message-ID: <875xafr4xi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 08 2025, Eric Auger <eric.auger@redhat.com> wrote:

> Generated definitions with scripts/update-aarch64-sysreg-code.py
> based on "AARCHMRS containing the JSON files for Arm A-profile
> architecture (2025-09)" Registers.json file.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/cpu-sysregs.h.inc | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 3c892c4f30..9bb27297b5 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -1,17 +1,27 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +
> +/* This file is autogenerated by scripts/update-aarch64-sysreg-code.py */
> +
> +DEF(AIDR_EL1, 3, 1, 0, 0, 7)

AIDR_EL1 (and MIDR_EL1/REVIDR_EL1) are used by the
(hopefully-soon-respun) writable id register series, so it's good that
they do not need to be added by hand anymore :)

>  DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
>  DEF(CTR_EL0, 3, 3, 0, 0, 1)
> +DEF(DCZID_EL0, 3, 3, 0, 0, 7)

Also see
https://lore.kernel.org/qemu-devel/20251127170657.3335112-1-cohuck@redhat.com/T/#u

> +DEF(GMID_EL1, 3, 1, 0, 0, 4)
>  DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
>  DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
>  DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
>  DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
> +DEF(ID_AA64DFR2_EL1, 3, 0, 0, 5, 2)
> +DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
>  DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
>  DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
>  DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
> +DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)
>  DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
>  DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
>  DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
>  DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
> +DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
>  DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
>  DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
>  DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
> @@ -36,6 +46,10 @@ DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
>  DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
>  DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
>  DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
> +DEF(MIDR_EL1, 3, 0, 0, 0, 0)
> +DEF(MPIDR_EL1, 3, 0, 0, 0, 5)

I'm wondering if we need to add some handling for MPIDR_EL1.

>  DEF(MVFR0_EL1, 3, 0, 0, 3, 0)
>  DEF(MVFR1_EL1, 3, 0, 0, 3, 1)
>  DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
> +DEF(REVIDR_EL1, 3, 0, 0, 0, 6)
> +DEF(SMIDR_EL1, 3, 1, 0, 0, 6)

SMIDR_EL1 is const 0 in tcg, and KVM currently does not support SME. So
I guess we should init the idreg to 0 for now?


