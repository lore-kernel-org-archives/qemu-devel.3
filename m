Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A253BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 10:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzZVt-00008l-7G; Wed, 24 Apr 2024 06:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzZVr-00007x-Id
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 06:06:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzZVo-0001NL-Mt
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 06:06:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-349545c3eb8so4862451f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713953158; x=1714557958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RJeq6fIxiiTYHpTB+2A2F57sm5CMyZXLKrdNd8XZ0VU=;
 b=NDqyptc+ZNJMakhN1Dt5p642bao1ACFdV4WFl9RJ/MA4npzInJjvC6BaDwZm5VcMiy
 zufFcb/2Mzwcg5e0bzfL7Z8eT62U2ma55GZ6gZgEVvkjDge0/jk7kVdFPaOnsKdWHEPe
 o0D7DE/roT4pyHBevgBjUYmBBgCziz5H7SdRqstTMH9jyg8xTZP+kH1QbD8BzQxiEEHV
 3YIHG+PAGhQv7Rbube16Pg5wf/eBDYi52H5yV3B2w4BYYChiRawMGyzdTVPtVsb9rB3Q
 q9QsKHCfD3eDmja0BOVAqGDFDWdBQJ7BHLEmbYhPss0flpOUO9G01WSloOgU6oS/dLue
 Qrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713953158; x=1714557958;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RJeq6fIxiiTYHpTB+2A2F57sm5CMyZXLKrdNd8XZ0VU=;
 b=WPRt8hX+Bbeqbh0oOfb39thp1xjQkX+Ng3YVh9B+yJ1MOMz+9MWO7kT3t+Bzai5mi0
 5aKFdRxkY+1GgrBz6kTdf7qJSettLQcbqBRuO3PtajXxTjrREVN2WDy+TaXEP+ZgNZci
 krTrr9NFufdU7umeLCNXBXJYdElOA7tDJzOeLs/Ryv16bz4VTQRFq3rWcu3zsL1MN0Db
 x9peAKFloG86VYpZon5OM2AHnxHAZFplBJqMuBYIX/az/b2obo5Z958kZJjkQbVkG+c3
 UhbTZYuMwZP5NASY640Q+JbKdiIXyDhT3v7vBJxOiK1LgZuFV3mayGtL3q3TVC1p3Fac
 c2Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1CKGL0Oba1jKSrsPVZf4ntaXtL04xB6kVQaQADvbM67fuVTYZA85XOkBipEh8d4ra9HQ+9qMx/V0oYfdMoIwWha1eSpQ=
X-Gm-Message-State: AOJu0YyxM64n5F/vjPgJy4zobiui961MiKo1q8eMmuu96fdaJFYGUBma
 MyA0R5+WNZGaVHV0PvRJu+67dKY/tG2yRazwl/qWcud/1abE/jNpbM6aiT9x26Y=
X-Google-Smtp-Source: AGHT+IGRwoNvywezgAtvjGv1mnC+Z4/ri35VrWRJslP2OcATQLz8PEMyGT2jE+F1RXzBdZ9zsCTNAw==
X-Received: by 2002:adf:f809:0:b0:33e:7f51:c2f8 with SMTP id
 s9-20020adff809000000b0033e7f51c2f8mr1482384wrp.36.1713953158508; 
 Wed, 24 Apr 2024 03:05:58 -0700 (PDT)
Received: from [192.168.1.102] (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr.
 [176.184.51.42]) by smtp.gmail.com with ESMTPSA id
 j13-20020a056000124d00b0034b7906c716sm3564205wrx.106.2024.04.24.03.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 03:05:58 -0700 (PDT)
Message-ID: <ac66952e-4281-4250-96f4-dc3d5b518d24@linaro.org>
Date: Wed, 24 Apr 2024 12:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: Provide MemReentrancyGuard * to qemu_new_nic()
To: P J P <pj.pandit@yahoo.co.in>, Mauro Matteo Cascella
 <mcascell@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sven Schnelle <svens@stackframe.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Rob Herring <robh@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
 <20230601031859.7115-2-akihiko.odaki@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230601031859.7115-2-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 1/6/23 05:18, Akihiko Odaki wrote:
> Recently MemReentrancyGuard was added to DeviceState to record that the
> device is engaging in I/O. The network device backend needs to update it
> when delivering a packet to a device.
> 
> In preparation for such a change, add MemReentrancyGuard * as a
> parameter of qemu_new_nic().

An user on IRC asked if this patch is related/fixing CVE-2021-20255,
any clue?

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/net/net.h             | 1 +
>   hw/net/allwinner-sun8i-emac.c | 3 ++-
>   hw/net/allwinner_emac.c       | 3 ++-
>   hw/net/cadence_gem.c          | 3 ++-
>   hw/net/dp8393x.c              | 3 ++-
>   hw/net/e1000.c                | 3 ++-
>   hw/net/e1000e.c               | 2 +-
>   hw/net/eepro100.c             | 4 +++-
>   hw/net/etraxfs_eth.c          | 3 ++-
>   hw/net/fsl_etsec/etsec.c      | 3 ++-
>   hw/net/ftgmac100.c            | 3 ++-
>   hw/net/i82596.c               | 2 +-
>   hw/net/igb.c                  | 2 +-
>   hw/net/imx_fec.c              | 2 +-
>   hw/net/lan9118.c              | 3 ++-
>   hw/net/mcf_fec.c              | 3 ++-
>   hw/net/mipsnet.c              | 3 ++-
>   hw/net/msf2-emac.c            | 3 ++-
>   hw/net/mv88w8618_eth.c        | 3 ++-
>   hw/net/ne2000-isa.c           | 3 ++-
>   hw/net/ne2000-pci.c           | 3 ++-
>   hw/net/npcm7xx_emc.c          | 3 ++-
>   hw/net/opencores_eth.c        | 3 ++-
>   hw/net/pcnet.c                | 3 ++-
>   hw/net/rocker/rocker_fp.c     | 4 ++--
>   hw/net/rtl8139.c              | 3 ++-
>   hw/net/smc91c111.c            | 3 ++-
>   hw/net/spapr_llan.c           | 3 ++-
>   hw/net/stellaris_enet.c       | 3 ++-
>   hw/net/sungem.c               | 2 +-
>   hw/net/sunhme.c               | 3 ++-
>   hw/net/tulip.c                | 3 ++-
>   hw/net/virtio-net.c           | 6 ++++--
>   hw/net/vmxnet3.c              | 2 +-
>   hw/net/xen_nic.c              | 4 ++--
>   hw/net/xgmac.c                | 3 ++-
>   hw/net/xilinx_axienet.c       | 3 ++-
>   hw/net/xilinx_ethlite.c       | 3 ++-
>   hw/usb/dev-network.c          | 3 ++-
>   net/net.c                     | 1 +
>   40 files changed, 75 insertions(+), 41 deletions(-)


