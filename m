Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022BFFC9EC4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 03:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyhvI-0002Wx-Tw; Fri, 06 Mar 2026 22:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyhvF-0002WC-1v
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 22:01:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyhvB-00086Q-6Q
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 22:01:44 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 627312tD030029
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 7 Mar 2026 12:01:09 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zn0Cec2zDB6oRM9Hro4lYiRCYwyCT5AwOsuSDvaovOw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772852469; v=1;
 b=mpggkCz2EwLLR6Idsx4qd18R2/DsSbSXkiYGDUmT00+jUIU9zXL+U6ROc3hdHzvZ
 Z6SjwpU2nttTiBMhbpcUe4cAVWMm4w2Z8jTPL4VxoRyP62L+Cwg0ZAVU3iRN1VuV
 PDQFXl3pz1OnfgwUCzOo2vOS0AltrgUjPvJTNxAxUXyI1iXDi4n0Xp8aj2AlWwq8
 UQe624NoSIvQvTtvWfIF2ZUzmh+wobHZeJ8DHlB7lZzA4j6EVtjSzyhyn+Vs0mEG
 DHDBX2reidicHDzsT5x46eyFo0T2nHPflX9jraH3LMpkrWbfZcZ8ddTuLvrnJa2B
 8st1xVHyKUwNwNGEEqtJ8Q==
Message-ID: <efea9a67-cd54-481b-b766-c40af78417a4@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 7 Mar 2026 12:01:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/8] memory: Remove most _nomigrate variants
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <cover.1772802886.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <cover.1772802886.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/06 22:19, BALATON Zoltan wrote:
> v9:
> - call qemu_ram_alloc after memory_region_init (Akihiko)

It now looks good to me now.

For the entire patch series:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

> - add R-b tag to xtfpga patch
> 
> v8:
> - reorganise patches to move simpler ones earlier
> - drop error_propagate as suggested by Akihiko Odaki to follow current
>    recommendations and so we don't need local err and don't have to
>    pass errp to helper function
> 
> v7:
> - convert xtfpga from global vmstate; this leaves just the vga usage
>    of memory_region_init_ram_nomigrate so the >1 use is not anymore an
>    argument therefore remove memory_region_init_ram_nomigrate too
> - drop memory_region_error_propagate() until we can agree on what to
>    do with it
> 
> v6:
> - keep the last two uses of memory_region_init_ram_nomigrate in vga and xtfpga for now
> - added R-b tags
> 
> v5:
> - convert Sun machines and their display devices from global vmstate
> 
> v4:
> - separate patch converting Sun machines from memory_region_init_ram_nomigrate
> - split helper to init ram into two functions: setup and error_propagate
> - also use memory_region_init_io in memory_region_init_ram_device_ptr
> 
> v3:
> - rebased on master after some patches were merged
> - drop some more line from memory-region-housekeeping.cocci
> - added comment to explain what factored out helper does
> - some more clean ups included
> 
> BALATON Zoltan (8):
>    hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate()
>    memory: Remove memory_region_init_rom_nomigrate()
>    sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
>    hw/xtensa/xtfpga:  Do not use memory_region_init_ram_nomigrate()
>    memory: Remove memory_region_init_ram_nomigrate()
>    memory: Shorten memory_region_init_ram_device_ptr and
>      memory_region_init_rom_device
>    memory: Add internal memory_region_register_ram function
>    memory: Factor out common ram region initialization
> 
>   docs/devel/memory.rst                         |   9 +-
>   hw/display/cg3.c                              |   5 +-
>   hw/display/tcx.c                              |   8 +-
>   hw/display/vga.c                              |   4 +-
>   hw/sparc/sun4m.c                              |  19 +-
>   hw/sparc64/sun4u.c                            |  10 +-
>   hw/xtensa/xtfpga.c                            |   3 +-
>   include/system/memory.h                       |  49 ----
>   .../memory-region-housekeeping.cocci          |  47 ---
>   system/memory.c                               | 275 ++++++------------
>   10 files changed, 105 insertions(+), 324 deletions(-)
> 


