Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B816606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e/2M73gW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWPKa-0002he-Dn; Wed, 25 Nov 2026 21:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xWPKX-0002cR-Sh
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 21:35:26 -0500
Received: from mail-pj2-x03.google.com ([2607:f8b0:4864:39::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xWPKT-0001EU-MC
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 21:35:25 -0500
Received: by mail-pj2-x03.google.com with SMTP id
 d9443c01a7336-2f08b80a840so32685655ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 18:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795660519; x=1796265319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FXR5fY9w0UwdiNAuY3odcVNzbKqwkmwUYZjUrNrGUFE=;
 b=e/2M73gWjYHMjr7SZkNPD3ya89MzTUveshS71cM4avbx2rzy/LjlD066TLn23nPHya
 xJApn0ZUGtDb265BfLaFJ1Rfz3bSbMhqIODLndtzavDnj4nC4bygo6hlifMauBwyo21Z
 0IH8bgNPJKEapmcRqxKIzxkhASdLUV0COqW6UXgjggXm+xWJBz0fE9uECp/Wmp/7WeI0
 9O/aNvh0F3i+PqRORVjEoaE7DMaZG2VHGnHlcwt+XPNXsSiJjLuY/7rVMbq3rksiTrfl
 BhPDwAcEzPu6G/MY0NpX20SkF8MBV7LGQCLFZAut6g/Vu+8ehKQb9/qYPHaeuj9tgDG8
 KDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795660519; x=1796265319;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FXR5fY9w0UwdiNAuY3odcVNzbKqwkmwUYZjUrNrGUFE=;
 b=ujuECx0S0VqPjzz5DefbVeeE1JB95BCCM1dYOCtLgrf1yJFCUZK/lNIhRRMFCeMxsi
 X1UjoafB9jy1ttBVJFapKpZcRt2p8tDdjr9EPUA9DYxYjuqe26yrDzM/EhlCKTPcGJmQ
 6uR5SQLW3XSKBYoaW72dOJWUNNdhwC/ksmDIaG6fAR1lSsY9OyvMR9tWBxPDWni25jAd
 0oWmLuJ8CV3y/ukkTGHsFwKsu6PKak9wQ6jCItn9ubdaXH9IMmSNd9UORXZmtnZKwpYj
 MjkIVOPcameX5bM2wnm0X/k3NUTgWBqH0RroBtnCSV1kHKTkvWzIOUCMAVsNAe0sBk/x
 FSzg==
X-Forwarded-Encrypted: i=1;
 AL+hErH7cQeAAcpHoB199NVEu6zQaOck7dRpk7m/J5VBhKIvKgCJqQsNxbxycFbAFOn/8uZfL1fJoXjqfAx0@nongnu.org
X-Gm-Message-State: APuU4Z9YWvNsYhI3Dbyk7iEXxfpDVATdYON/LObpmLJUp53m2MNdKoMH
 nx0sLHy0Nfl/ZDi1GNyRJ3bgDC9HOAokoY9O9UKlMu/a//9M+LMNaGsN
X-Gm-Gg: AZFdTZeYhnAd1AXa91q5eCcgbgUBzjS/xPFoBzW7zDfIN09Qt3T5N1s2P6hq9UGHK0r
 bAHOAoi/dPQwEW3cc2PBethUlCUpbaBr3Z+NlwgJ6WjdGNL3iyE1d7YhCCRsCW33LAiPVKNhZCO
 aPocrYzP7W2kvBhJnEhIkJFI8p0GkzKRDhumZOyeD+C3exV+lzqD1mUsZKcwdWf6okC0pPZIJWi
 15yBPOTzWmebV6T+hD94obFO7ExRezGZctKZbqJXkPldYaXmlcVaXMzZycTUjnMOgzYn3Dcbfpl
 9a9HKqh1JOdAT0SBUllRs7JkZIzsVhKc8PfCidWP9HYk8wt+pRdv5L2DGaqstS6O8DJct21nhsS
 GKWwF2tyVs+s80QtbRT9YeXCOqFAqnpdw5h3U98cnaPoeCuqptOA/rhu3TdxBb4Ldya7x93FrTu
 8By7abbyjpR0qRw59C8Bkek/E1C6IgF6XStZmhyzh/jPxkSYpgZazPG4Uv65OBH8lYYCdnsX+B9
 tDI5z1qjHeubr0b/zBzSzsTqJjiCcz2eGfIKy2fp7AzIlRFxzgs69O2WjYEVt71Mz/2W8FffDDE
 t12cpPCtonGuI49s86s8jK6Dpq911Nqkd2zX708Aw7uQ9w==
X-Received: by 2002:a17:90b:2d8a:b0:3ac:450b:164c with SMTP id
 98e67ed59e1d1-3b41c96cde4mr20358979a91.47.1795660518643; 
 Wed, 25 Nov 2026 18:35:18 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:61d:93ac:f2c5:2564])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0a34asm29705417a91.3.2026.11.25.18.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 18:35:18 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: asrinivasan@tenstorrent.com
Cc: Zixin Wang <w1355457260@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 0/8] Add Spacemit K3 Machine
Date: Thu, 26 Nov 2026 02:35:01 +0000
Message-ID: <20261126023501.460848-1-w1355457260@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAEev2e9YBm-rA1+-mmw-qF-5dLw7uO0o=knHh30KAyDVepBsfQ@mail.gmail.com>
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
 <CAEev2e9YBm-rA1+-mmw-qF-5dLw7uO0o=knHh30KAyDVepBsfQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::3;
 envelope-from=w1355457260@gmail.com; helo=mail-pj2-x03.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anirudh,

Thanks, that makes sense. I will hold my own model and focus on reviewing
this series first; missing features and tests can be added after it is
upstream.

For the tests: I do not use tuxboot. The K3 SDK and image download entry
point is SpacemiT's resource download center:

  https://www.spacemit.com/community/resources-download

K3 resources are available under the SDK and image sections there. My
local test uses the K3 SDK Linux image and OpenSBI firmware from that
SDK, together with a small initramfs and a QEMU-specific DTB. I pin the
exact files with SHA-256 and boot them with:

  -bios fw_dynamic.bin -kernel Image -initrd ... -dtb ...

This avoids the tuxboot kernel/OpenSBI limitation entirely. The qtests do
not need firmware; they run with:

  -M k3-pico-itx -bios none

The DTB I use is prepared for the Linux-first QEMU machine. If your memory
map differs, we can adapt the DTB and boot command to your machine model.

For your NOR-flash test, the same K3 Image and DTB should be usable; you
mainly need to prepare the NOR image/layout. I can share the
qtest/functional test harness and help adapt it. I can also boot-test your
series with the K3 SDK images and provide a Tested-by tag if it passes.

Thanks,
Zixin

