Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34C606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=cfB5/HJZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvoO-0007Lh-Hf; Mon, 19 Oct 2026 18:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xIvoN-0007LR-6r
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:26:31 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xIvoJ-0002wU-GE
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=LmKpKoeA81D6SX13sEtfyvFkE8rL2RVJEPiYVPYnV3c=; b=cfB5/HJZnD25gos
 q5pGLz66o0xekF6v5DBhF7WR56bAVdUvMsd3GrnTSXetY1W/8upcKfOxUpkCZbwNPL9lgdMwiCaWX
 Jde+1Qc3/vuyk7M4+NuAvhSGXDJF+8J6QXdlKaWZL9PyabMbyz5ruU9J0S6TVy0ejzDoJqRtX5DU0
 t4=;
Date: Tue, 20 Oct 2026 00:32:01 +0200
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 01/14] Hexagon: add v85 CPU model
Message-ID: <ataaJllUMf-2zbOx@hive.localdomain>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-2-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019055245.1457795-2-brian.cain@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/26, Brian Cain wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/emulation.rst | 2 +-
>  target/hexagon/cpu-qom.h          | 4 ++++
>  linux-user/hexagon/elfload.c      | 4 ++++
>  target/hexagon/cpu.c              | 2 ++
>  4 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/system/hexagon/emulation.rst b/docs/system/hexagon/emulation.rst
> index 12385311aa4..fb57c77ae90 100644
> --- a/docs/system/hexagon/emulation.rst
> +++ b/docs/system/hexagon/emulation.rst
> @@ -6,7 +6,7 @@ Hexagon CPU architecture support
>  ================================
>  
>  QEMU's TCG emulation includes support for v65, v66, v67, v68, v69, v71, v73,
> -v75, v77, v79, v81.
> +v75, v77, v79, v81, v83, v85.
>  It also has support for the following architecture extensions:
>  
>  - HVX (Hexagon Vector eXtensions)
> diff --git a/target/hexagon/cpu-qom.h b/target/hexagon/cpu-qom.h
> index 2bfa4d5d0fc..d4c8413ded3 100644
> --- a/target/hexagon/cpu-qom.h
> +++ b/target/hexagon/cpu-qom.h
> @@ -28,6 +28,8 @@ typedef enum {
>      HEX_VER_V75 = 0x75,
>      HEX_VER_V79 = 0x79,
>      HEX_VER_V81 = 0x81,
> +    HEX_VER_V83 = 0x83,
> +    HEX_VER_V85 = 0x85,
>      HEX_VER_ANY = 0xff,
>  } HexagonVersion;

I think you missed adding HEX_VER_V85 to get_elf_hwcap(), currently it
would take the default case and return 0.

Otherwise,

Reviewed-by: Anton Johansson <anjo@rev.ng>

