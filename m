Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82D606A331
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rfc1149.net header.i=@rfc1149.net header.a=rsa-sha256 header.s=smtp header.b=IXhofd5r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSBBQ-0007Ho-NA; Sat, 14 Nov 2026 05:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1xSBBM-00074f-PF; Sat, 14 Nov 2026 05:40:29 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1xSBBK-0004ld-V4; Sat, 14 Nov 2026 05:40:28 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 9A83980022;
 Sat, 14 Nov 2026 11:40:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1794652823; bh=eBY7k8tQ+IaaOa4EcSB+YJll1j9daG0bLmqF4lD06II=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=IXhofd5rUDMXtzcr1g2TWSKhqvGdLJ7nskwD1mVZbT8yMmip6OQ/q90cy4jdMeGgO
 kSumy2pjUD6gFaVNGlEKeG6EcadngxGhXzwRP8mnjuOPGnWLbJl0nSe4I5PkqY/FN/
 4FrO9nhRYPKTeYgCQA9xXX1jtnJjmekFNFU4hQbU+WJmr5N8bCVa5PVUnqDwawbBbL
 g2Hp2LzhozYcwJzoOIj0ITv63jkZ3TreSi2Ut7VFzzur2xv7Gy28CTiYD9BUpatQxw
 eIjkmAE8Fp38Ca+v6opHH6LvwnAhwl1AVXDkkAsmtkfJ/4uPv5oaJrwyaHMVds3Hxj
 Rd9RfxbQ2f6vg==
From: Samuel Tardieu <sam@rfc1149.net>
To: ~mohammadodeh <Mohammad.Odeh@exalt.ps>
Cc: qemu-devel@nongnu.org,   Alexandre Iooss <erdnaxe@crans.org>,   Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,   Peter Maydell
 <peter.maydell@linaro.org>,   Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,   Kevin Wolf
 <kwolf@redhat.com>,   Hanna Reitz <hreitz@redhat.com>,   Fabiano Rosas
 <farosas@suse.de>,   Laurent Vivier <lvivier@redhat.com>,   Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,   Markus
 Armbruster
 <armbru@redhat.com>,   =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Bernhard
 Beschow <shentey@gmail.com>,   Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Jan Kiszka <jan.kiszka@web.de>,   Bin Meng
 <bin.meng@processmission.com>,   Shameer Kolothum
 <skolothumtho@nvidia.com>,   Jamin Lin <jamin_lin@aspeedtech.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH qemu 3/3] hw/arm: Add STM32L496G-DISCO machine
In-Reply-To: <179449578952.8382.2790865629085512841-3@git.sr.ht>
References: <179449578952.8382.2790865629085512841-3@git.sr.ht>
User-Agent: mu4e 1.14.4; emacs 31.1
Date: Sat, 14 Nov 2026 11:40:23 +0100
Message-ID: <87eccnzofc.fsf@rfc1149.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

~mohammadodeh <mohammadodeh@git.sr.ht> writes:

> Introduce the STM32L496xG SoC variant with its flash and SRAM sizes.

It is a bit strange to include it inside `stm32l4x5_soc.c` when it doesn't match the description. Maybe the name of the file should be changed to reflect that it also cover the 4x6 SOCs?

Also, the STM32L496xx SOC has an alias for the SRAM2 at address 0x2004_0000 (in order to get a contiguously addressable SRAM1+SRAM2 memory area). This alias seems to be absent from the code, as it was not needed for the STM32L4x5 SOCs which have no such feature.

Best.

  Sam
-- 
Samuel Tardieu

