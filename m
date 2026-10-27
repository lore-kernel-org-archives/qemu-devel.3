Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E5606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FRaFjZt/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLfER-0003Gu-F5; Tue, 27 Oct 2026 07:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xLfEO-0003FR-HQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:20:40 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xLfEA-0003va-9m
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:20:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so2110683f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793100024; x=1793704824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8ftzrYXbW8WtLL1EcTLG7m4YPotN05J9oeEWpD38Plg=;
 b=FRaFjZt/2diYvZM+JRhu51n4eVsYhonE3yU2C3NDaTSfa3XgaNPBjOx48k1rHwPixT
 l8A8HMPuw32JfbHvltF2RfAMBoNJTUOoMB6zlTKV+uHwcOrBwaWdz0KH8aqbritk/OlK
 akGCs5e4L0Lzmf6JZM4btS3n+blyWEG0k6tk45UalKBu9wdMrL0vdBJKZ8MM3/HMqiSv
 FNq7fFvSkVqolPriSVXigEdwvkH+iP7x5TBu+uwPjMN6uZweZ4DBc6d6hVVKQ9Lm8DLX
 CyFKXks5bsSq3o0Lq08vF+5i7c2Mn84o7exbgrUHJNDyYRaOP1j0l2eTxDbG0ZPSauIm
 eZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793100024; x=1793704824;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ftzrYXbW8WtLL1EcTLG7m4YPotN05J9oeEWpD38Plg=;
 b=asem2+MufXj06Ti5W1QhcRlcK/6Xw2j80I21Dn57FzajZOx9G0RlrzlQcWbWsCo+Nz
 ZJHINpw3d8iojUKmmDUUtDKah/G8QSzJoe2PXOh35sL+4wCsyAACuPWJJkucRCc42DJS
 UsMcz/X/cd8zv/yPOqrR2Nz+qowNytaj2KNspHapOK/lyOSfTs5Qo95EQIHsEkcjhZ23
 inSTTlcY1JYq3vb8sc19dnZ8DV3ce77K0ROoOGShZHCP0o/tqLPvOZvtV8OfKSVgZbej
 pYBDaB69jCF2nC39YiCE8SU57jNy5brXvNdK/MGRERqCoZOPrpxWL7rUtWyE2rM8tVHo
 cPSA==
X-Gm-Message-State: AFq9FYJvuIfFrAsjU8+F/WFesMP3weTPUR9lrN6oT6QwLsVqvQNhP8te
 e5oyQEFdtnul7xcueOzcxUQwgpxA6i9TumvXZUkYDDiExz4cRmj/mdtN5VMR4Q==
X-Gm-Gg: AYBFou3DZxmk5+/WJZphieCIuJTfQdIROetVJhl0tOkbQfSH80p/Q+sElkfspK0tXh5
 19O7RXBHhUm0wNmAR5PNQSyoKtusJBNIIMU2Y9ZojxR2VGsmCj5BDlgjIRGjTvuHWGfFrEnMWBP
 I5SgVtPNxkgMzc9hOL/jge+LrK4HNhaUG3P7RwkVWLXtq6cKHH42qIgEQegr4Hg750MjZSwkGAb
 90aj5v2z+MWgEy9EoJCFj2VcpUU6CibRLvEgFfcRdQjXFOXcHRWEQHqSAyOoJHOMqGVy+VKSP3J
 2Z0+qRugLgSkLgbVre0kO6QJU4qNnCkRHj/ODDbCz5A7wgXalZgfLAqV+SRDXE4AEUbMGeiP/g/
 6vZlTQdAuQH7d+Pcnj1sAKL1p7FahZEbqJf4rEsYaofncUvrOIXte3j3yW869CybQqqwtDuKFHh
 4Vmn9Hs/NxIMQLErfSrFIoR+txKXtJzqhLLe1R8+A2RNOn5Aq+wGESpUUhjVfzDlAF9EpRHY9V0
 gE0yYvdJOB5ta1niAq8w4PijK8U8RZ7zr9pWVZNfyYEjf0rdgGypohoZqLBAalAhjIbOZCQ6OpI
 LWqkf8c=
X-Received: by 2002:a05:6000:2dc8:b0:48a:f073:336b with SMTP id
 ffacd0b85a97d-48e3eb88c9fmr17460457f8f.23.1793100024209; 
 Tue, 27 Oct 2026 04:20:24 -0700 (PDT)
Received: from ehlo.thunderbird.net ([213.138.33.179])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48e0sm22889031f8f.38.2026.10.27.04.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 04:20:23 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:20:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Zhao Liu <zhao1.liu@intel.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v5 0/8] hw/sd: Improve performance of read/write/erase
In-Reply-To: <C4ABBCFA-97E9-4C0D-A132-25B2A816E4B7@gmail.com>
References: <20261006094447.43491-1-shentey@gmail.com>
 <C4ABBCFA-97E9-4C0D-A132-25B2A816E4B7@gmail.com>
Message-ID: <E6179174-F75A-4563-9B34-7EB54F483FA1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 16=2E Oktober 2026 14:28:18 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 6=2E Oktober 2026 09:44:39 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>>This patch series improves the performance of read/write/erase operation=
s
>>
>>on sdcards=2E
>>
>>
>>
>>This is done by increasing the maximum buffer size that is worked on=2E
>>
>>From 1 byte (master) to 512 bytes (commit 1-3) to larger than 512
>>
>>(adma commit)=2E
>>
>>
>>
>>Testing on my system with fio I see the following rough performance
>>
>>values in MiB/s=2E
>>
>>
>>
>>              read write readwrite
>>
>>       master:   6     6     3/  3
>>
>> first commit:  51    43    23/ 23
>>
>>second commit: 392   180   144/143
>>
>>
>>
>>Tested on a 2GiB raw image with:
>>
>>  fio --filename=3D/dev/mmcblk0 --direct=3D1 --runtime=3D60 --time_based=
 --bs=3D128k --rw=3D{mode}
>>
>>
>>
>>The adma values are somewhat unstable but always >100MiB/s, I'm not sure
>>
>>why but I guess it has something to do with the host side caching=2E
>>
>>
>>
>>The fifth commit fixes the DATA_STAT_AFTER_ERASE bit in SCR and
>>
>>introduces an option to allow to erase blocks to 0x00=2E
>>
>>
>>
>>The sixth commit optimizes block erase when erase-blocks-as-zero=3Dtrue
>>
>>is used, by passing the zeroing request down the to the block device=2E
>>
>>Erasing 2GiB now takes 0=2E1s instead of 26s=2E
>>
>>
>>
>>Signed-off-by: Christian Speich <c=2Espeich@avm=2Ede>
>>
>>
>>
>>I'm picking up this series with the changes indicated in v5 below=2E Ple=
ase let
>>
>>me know how I could improve attribution to Christian in case I missed so=
mething=2E
>>
>>
>>
>>The last two patches are new and are small cleanups=2E
>>
>>
>>
>>---
>>
>>Changes in v5:
>>
>>- Rebase onto master
>>
>>- Split patch "hw/sd/sd: Use multi-byte/block writes for block path" int=
o three
>>
>>  (first three patches)
>>
>>- Use sd_blk_{read,write} with additional parameter directly rather than=
 having
>>
>>  sd_blk_{read,write}_bounce_buffer
>>
>>- Drive limits and write protect groups are preserved to be checked on b=
lock
>>
>>  boundaries only since these checks are redundant in case the SD host
>>
>>  transfers one byte at a time=2E
>>
>>- WP_VIOLATION is only raised once the first protected block shall be wr=
itten,
>>
>>  rather than immediately at the beginning of a multiple block write whi=
ch
>>
>>  starts with allowed blocks=2E
>>
>>- An off-by-one error has been fixed in the same case where one bye too =
less
>>
>>  had been written if a write protected block had been detected=2E
>>
>>- There are only two rather than three code paths each handling the mult=
iple
>>
>>  block optimization=2E
>>
>
>Ping

Ping^2

>
>>
>>
>>Changes in v4:
>>
>>- Rebase onto master, no changes needed=2E
>>
>>- Renames:
>>
>>  - sd_blk_{read,write} -> sd_blk_{read,write}_bounce_buffer
>>
>>  - sd_blk_{read,write}_direct -> sd_blk_{read,write}
>>
>>  - to_erase -> erase_len
>>
>>- Extract erase logic into sd_blk_erase helper
>>
>>- Enable erase-blocks-as-zero by default=2E Add compat for 11=2E0 and be=
low
>>
>>  to keep it disabled=2E
>>
>>- Add cleanup commit to update trace events=2E
>>
>>- Link to v3: https://lore=2Ekernel=2Eorg/qemu-devel/20260204-sdcard-per=
formance-b4-v3-0-dc1cf172ee57@avm=2Ede
>>
>>
>>
>>Changes in v3:
>>
>>- Rebase onto master, updating read/write path for newly added RBMP
>>
>>- Split up commit 1 into multiple commits
>>
>>  - change interface to allow "short" read/writes that are continued
>>
>>    by the core later by calling again
>>
>>- Link to v2: https://lore=2Ekernel=2Eorg/qemu-devel/20251202-sdcard-per=
formance-b4-v2-0-d42490b11322@avm=2Ede
>>
>>
>>
>>Changes in v2:
>>
>>- Properly set DATA_STAT_AFTER_ERASE in SCR
>>
>>- Add erase-blocks-as-zero option to allow the user to switch between
>>
>>  0x00 and 0xFF for erased blocks=2E
>>
>>- Link to v1: https://lore=2Ekernel=2Eorg/qemu-devel/20250919-sdcard-per=
formance-b4-v1-0-e1037e481a19@avm=2Ede
>>
>>
>>
>>Bernhard Beschow (5):
>>
>>  hw/sd/sd: Transfer up to one block in case of multi-block commands
>>
>>  hw/sd/sd: Add buffer argument to sd_blk_{read,write}
>>
>>  hw/sd/sd: Use multi-byte/block writes for block path
>>
>>  hw/sd/sd: Retype state attribute to SDCardStates
>>
>>  hw/sd/sd: Remove unneeded forward declaration
>>
>>
>>
>>Christian Speich (3):
>>
>>  hw/sd/sdhci: Don't use bounce buffer for ADMA
>>
>>  hw/sd/sd: Add erase-blocks-as-zero option=2E
>>
>>  hw/sd/sd: Optimize erase blocks as zero=2E
>>
>>
>>
>> hw/core/machine=2Ec |   1 +
>>
>> hw/sd/sd=2Ec        | 230 ++++++++++++++++++++++++++++++++++-----------=
-
>>
>> hw/sd/sdhci=2Ec     | 102 ++++++++++----------
>>
>> 3 files changed, 225 insertions(+), 108 deletions(-)
>>
>>
>>
>>-- >
>>2=2E56=2E0
>>
>>
>>

