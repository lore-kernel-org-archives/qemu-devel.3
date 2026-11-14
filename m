Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F1606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rfc1149.net header.i=@rfc1149.net header.a=rsa-sha256 header.s=smtp header.b=DzZrL0HW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSAsW-0003gZ-TW; Sat, 14 Nov 2026 05:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1xSAsU-0003YB-Of; Sat, 14 Nov 2026 05:20:58 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1xSAsS-0000h2-US; Sat, 14 Nov 2026 05:20:58 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 29AF680022;
 Sat, 14 Nov 2026 11:20:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1794651653; bh=kASd6KyE8qx+PRFlSyohtAoNJbvzfBOc9ZPxOOr6SpM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=DzZrL0HWXuR4wbtaJlU9lM1mdHVwqvyv20TSPBnG8D8Z0R4tfHM0WfRL3zQIX/ljW
 vWovgf+mJ1w4TNmLrgpjgAwCY2oITkKm6WCbv7xgDQReHQbUHkxtX981+nJo8Di4U8
 C94w3TbXIW1c8VfFJMXIbmn9BQ9z6oGBAKREDDTeLS8vEvvTW5GSopmY4C/VGJiLYy
 ns5Zdzb0pwEI14/ypuAbxdHXl3P7Y5HR3n/ig7PSr3T08hZH/0Om6z5ZL/7iSgz1MC
 t049xNjVGGQ5Fcs7GQWrZfHtTt5hDSMPkpP6UBfpwOWgBh/Dos0SKC7s4rI3gSV10y
 VQLmLP6op407w==
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
Subject: Re: [PATCH qemu 1/3] hw/block: Add Macronix MX25R6435F flash
In-Reply-To: <179449578952.8382.2790865629085512841-1@git.sr.ht>
References: <179449578952.8382.2790865629085512841-1@git.sr.ht>
User-Agent: mu4e 1.14.4; emacs 31.1
Date: Sat, 14 Nov 2026 11:20:52 +0100
Message-ID: <87pkw7zpbv.fsf@rfc1149.net>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

~mohammadodeh <mohammadodeh@git.sr.ht> writes:

>      { INFO("mx25l25655e", 0xc22619,      0,  64 << 10, 512, 0) },
> +    { INFO("mx25r6435",   0xc22817,      0,  64 << 10, 128, ER_4K | ER_32K),
> +      .sfdp_read = m25p80_sfdp_mx25r6435 },
>      { INFO("mx66l51235f", 0xc2201a,      0,  64 << 10, 1024, ER_4K | ER_32K) },

By looking at the surrounding lines, it looks like the part suffix ("f" here) is usually included. Shouldn't it be "mx25r6435f" instead of "mx25r6435"?

>      PP = 0x02,
>      PP4 = 0x12,
>      PP4_4 = 0x3e,
> +    QPP_1_4_4 = 0x38,
>      DPP = 0xa2,
>      QPP = 0x32,
>      QPP_4 = 0x34,

I would have put the `QPP_1_4_4` definition after the `QPP_4` to group the `QPP` instances.

> @@ -759,6 +762,7 @@ static void complete_collecting_data(Flash *s)
>  
>      switch (s->cmd_in_progress) {
>      case DPP:
> +    case QPP_1_4_4:
>      case QPP:
>      case QPP_4:
>      case PP:

Same here.

Also, you haven't added a case to the switch in `get_addr_length()`. Is that because it matches the default case, or is that an oversight?

Best.

  Sam
-- 
Samuel Tardieu

