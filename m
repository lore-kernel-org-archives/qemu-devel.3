Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD1CCCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiv5-00043A-1r; Fri, 16 Oct 2026 10:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xHiv3-0003zh-D5
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:28:25 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xHiv1-0007LL-CC
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:28:25 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so4161315a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792160901; x=1792765701; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uNQPCq9l8r4XiSGCtjVwZ/7otkxiiZTgxRrkorrj56o=;
 b=fe0p+sMFvdmzKvtXApQeXf3ehle5cihWDyPx5KQmU7PXMbL9rNZ6NaIoy7JdvRWMOP
 wxbTg312QpzZB1XPGjib/N6cpElImcTwtIxfjjAwp5eFLw7mpFCJRO902wiqbLHIIafb
 uQd1DeCPBZ5/2w84cgQ6bKCfm11DQrT+qerAmikMHRmZbIZmcl23ZfF49/RDNiIghlCF
 JsefBmb2RpXeNjAQN+lXFlMBpF7pKwFElndrQsziNPltA2MQViCgjG3VA3yEBQYHduBO
 8SPBaZC+4kQ1boau2q5IiOferYcCjFI6+CgN+NZPA2QX33QlNEbklI+CqaYWbKZY/IuN
 Lgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792160901; x=1792765701;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uNQPCq9l8r4XiSGCtjVwZ/7otkxiiZTgxRrkorrj56o=;
 b=cZkRSvos6UMDGFMC0Jb+MMA5cepV+KAvd4zwhU1pKKAu6NhVRAO3ZtZK3Iw/PrJSUQ
 PPNYp9viOxyITFCaBaKps/QUpaOXXuAER+2EEAXgGyZPWxBGtQEt75FAGw4CDuaM5Ew0
 K1fXXqDJziGAN/1M8FzxYbCP6b2y8lxsmvQdIjXg0SerSZe8n9IehJBkEoTq4T+hGASV
 xpZudL6X301aNe0ay5rk5f7l5MfrOXG88e0plaz8S8fePfGxWKmRlNDxI6fD5HA/PBHy
 ubuY+iaEVp1OQycq4/r40DjxtSJfaKPwk9Cq5xPLFdjgQAlRrj9BprzrRij0hg3LflAF
 XOdA==
X-Gm-Message-State: AFq9FYLMMuSq9Laow3UqTLzeDFx3occerbUrQEDoXZuK/KUuirJeoavV
 KXP3T2+9OL2jXa/JoaTR9Aam9iR2OhKnTUgJy00/1+TQNxjsGOCBuCDFhdVRTg==
X-Gm-Gg: AYBFou0Ob0U4LRiSs3yOm6oV7DKCmuuc5df8DeljaLQ0q7TQ23RCi9tpZ6pJ9ZTDEiZ
 RuqMGidmBhspdKrQhcqjk9GxQSiLYRoS1Od54yHXiBu7SbPVE+CzZZks9ze+Kcj2Lv+dDhwOwKI
 Nb2MgQgqXGldbxpSJdMsxgkM40d708y27xZuvGjSBu9Uw1nr0afMLXqVNispiJXINn/nQ4LqwCy
 EG0i1REGPLGSMi09j+whk9Dsycx6GEQeoPbqIBX0/WSW6LgCAVW6DVVgcZ1ggqJRW36VBg/8FMC
 NlAGkh5mwGlN13qLUQUda2sIgDbE4J2y+uDhVLnxBsZV+L/FApxEMC4Wae9y8nM33jH3ZP6+ZYH
 XSrGxH43MZO5Sgt/krek/LPCuMrr3oQnOZ7LVOzq/422iD48fEB+C8HTs5/1pTYPegbchjnxYko
 Of2pn/jx6KFP/TA29BLX49qgpCjh9L3Ugj7S+Eb3QRSuOfHHsmaY67I/Msgp1FAO39HJvkgt3I/
 yvNcsl4ZsElb2bowXjVXvR0s3YTLfcH98u8c2VJxR/Ng3QPpGUqOaUJhqUEobEJOXn9Idk=
X-Received: by 2002:a05:6402:2748:b0:6b1:b17a:de82 with SMTP id
 4fb4d7f45d1cf-6b1b17aed7emr14225345a12.38.1792160901374; 
 Fri, 16 Oct 2026 07:28:21 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf35e000b58d2e94ae5e9ab7.dip0.t-ipconnect.de.
 [2003:fa:af35:e000:b58d:2e94:ae5e:9ab7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1ea1ddsm887077a12.34.2026.10.16.07.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 07:28:20 -0700 (PDT)
Date: Fri, 16 Oct 2026 14:28:18 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Zhao Liu <zhao1.liu@intel.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v5 0/8] hw/sd: Improve performance of read/write/erase
In-Reply-To: <20261006094447.43491-1-shentey@gmail.com>
References: <20261006094447.43491-1-shentey@gmail.com>
Message-ID: <C4ABBCFA-97E9-4C0D-A132-25B2A816E4B7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 6=2E Oktober 2026 09:44:39 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>This patch series improves the performance of read/write/erase operations=

>
>on sdcards=2E
>
>
>
>This is done by increasing the maximum buffer size that is worked on=2E
>
>From 1 byte (master) to 512 bytes (commit 1-3) to larger than 512
>
>(adma commit)=2E
>
>
>
>Testing on my system with fio I see the following rough performance
>
>values in MiB/s=2E
>
>
>
>              read write readwrite
>
>       master:   6     6     3/  3
>
> first commit:  51    43    23/ 23
>
>second commit: 392   180   144/143
>
>
>
>Tested on a 2GiB raw image with:
>
>  fio --filename=3D/dev/mmcblk0 --direct=3D1 --runtime=3D60 --time_based =
--bs=3D128k --rw=3D{mode}
>
>
>
>The adma values are somewhat unstable but always >100MiB/s, I'm not sure
=
>
>why but I guess it has something to do with the host side caching=2E
>
>
>
>The fifth commit fixes the DATA_STAT_AFTER_ERASE bit in SCR and
>
>introduces an option to allow to erase blocks to 0x00=2E
>
>
>
>The sixth commit optimizes block erase when erase-blocks-as-zero=3Dtrue
>
>is used, by passing the zeroing request down the to the block device=2E
>
>Erasing 2GiB now takes 0=2E1s instead of 26s=2E
>
>
>
>Signed-off-by: Christian Speich <c=2Espeich@avm=2Ede>
>
>
>
>I'm picking up this series with the changes indicated in v5 below=2E Plea=
se let
>
>me know how I could improve attribution to Christian in case I missed som=
ething=2E
>
>
>
>The last two patches are new and are small cleanups=2E
>
>
>
>---
>
>Changes in v5:
>
>- Rebase onto master
>
>- Split patch "hw/sd/sd: Use multi-byte/block writes for block path" into=
 three
>
>  (first three patches)
>
>- Use sd_blk_{read,write} with additional parameter directly rather than =
having
>
>  sd_blk_{read,write}_bounce_buffer
>
>- Drive limits and write protect groups are preserved to be checked on bl=
ock
>
>  boundaries only since these checks are redundant in case the SD host
>
>  transfers one byte at a time=2E
>
>- WP_VIOLATION is only raised once the first protected block shall be wri=
tten,
>
>  rather than immediately at the beginning of a multiple block write whic=
h
>
>  starts with allowed blocks=2E
>
>- An off-by-one error has been fixed in the same case where one bye too l=
ess
>
>  had been written if a write protected block had been detected=2E
>
>- There are only two rather than three code paths each handling the multi=
ple
>
>  block optimization=2E
>

Ping

>
>
>Changes in v4:
>
>- Rebase onto master, no changes needed=2E
>
>- Renames:
>
>  - sd_blk_{read,write} -> sd_blk_{read,write}_bounce_buffer
>
>  - sd_blk_{read,write}_direct -> sd_blk_{read,write}
>
>  - to_erase -> erase_len
>
>- Extract erase logic into sd_blk_erase helper
>
>- Enable erase-blocks-as-zero by default=2E Add compat for 11=2E0 and bel=
ow
>
>  to keep it disabled=2E
>
>- Add cleanup commit to update trace events=2E
>
>- Link to v3: https://lore=2Ekernel=2Eorg/qemu-devel/20260204-sdcard-perf=
ormance-b4-v3-0-dc1cf172ee57@avm=2Ede
>
>
>
>Changes in v3:
>
>- Rebase onto master, updating read/write path for newly added RBMP
>
>- Split up commit 1 into multiple commits
>
>  - change interface to allow "short" read/writes that are continued
>
>    by the core later by calling again
>
>- Link to v2: https://lore=2Ekernel=2Eorg/qemu-devel/20251202-sdcard-perf=
ormance-b4-v2-0-d42490b11322@avm=2Ede
>
>
>
>Changes in v2:
>
>- Properly set DATA_STAT_AFTER_ERASE in SCR
>
>- Add erase-blocks-as-zero option to allow the user to switch between
>
>  0x00 and 0xFF for erased blocks=2E
>
>- Link to v1: https://lore=2Ekernel=2Eorg/qemu-devel/20250919-sdcard-perf=
ormance-b4-v1-0-e1037e481a19@avm=2Ede
>
>
>
>Bernhard Beschow (5):
>
>  hw/sd/sd: Transfer up to one block in case of multi-block commands
>
>  hw/sd/sd: Add buffer argument to sd_blk_{read,write}
>
>  hw/sd/sd: Use multi-byte/block writes for block path
>
>  hw/sd/sd: Retype state attribute to SDCardStates
>
>  hw/sd/sd: Remove unneeded forward declaration
>
>
>
>Christian Speich (3):
>
>  hw/sd/sdhci: Don't use bounce buffer for ADMA
>
>  hw/sd/sd: Add erase-blocks-as-zero option=2E
>
>  hw/sd/sd: Optimize erase blocks as zero=2E
>
>
>
> hw/core/machine=2Ec |   1 +
>
> hw/sd/sd=2Ec        | 230 ++++++++++++++++++++++++++++++++++------------=

>
> hw/sd/sdhci=2Ec     | 102 ++++++++++----------
>
> 3 files changed, 225 insertions(+), 108 deletions(-)
>
>
>
>-- >
>2=2E56=2E0
>
>
>

