Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7753AC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 14:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdWx7-0000lo-TR; Fri, 23 Feb 2024 09:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rdWpb-0007Oq-UU
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:47:20 -0500
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rdWpZ-0004Z2-LI
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:47:19 -0500
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1McY0L-1r3Lzl3b8X-00cutf; Fri, 23 Feb 2024 15:47:09 +0100
Message-ID: <99a3a89c-7a1b-4b14-b495-b96d59278d55@vivier.eu>
Date: Fri, 23 Feb 2024 15:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] nubus: add nubus-virtio-mmio device
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 elliotnunn@fastmail.com
References: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MoGaAsjrZ5HJDTCwkXBSYutmrrmpUbwKfyS+S8MzvkfntMgQmjx
 M49zyKreVmFrBwMeD+3gX2hydLzzy/aJulj1ea/AaFIkSg/UlHan/xkZDgSyGfvNW2FlUX+
 uRSTSpzdBQr8YI+brSHeMQKZPv7WKZ8+DOiJKYK0hiIZeNvItxI7mjULexIEDcIgTQrGdNo
 nlPIVxHHB60sJJ/G8x3Dw==
UI-OutboundReport: notjunk:1;M01:P0:b0ysIjxcXV0=;6eKn16lmp0glVjNartGQMqcJeM7
 Y/O2wQO5mMWCnPg9lHcQLpc5j01Opjhcu+GkobYzju7GXn+DKI4Ow3omRoe6XCMzotxMoKf/I
 fUlhDzc4AI1P6CbgOrqnQfHEcTg3dbiO50Rf2tChJQd5m1VLojF+Fg3zVcCPUre4IuMixVEJf
 WLfr5nC2qD+4ZB7bR5iKn/wS7Yk9r3PlUMYk8lx940G5HzJ6pFrpX2DpQMcinQNloiVFNM2Ie
 At1I68yIe7KQhlJ+qGwFT3wQ41VM7ekjxi9o06QdsgRDkfH6SaUgupeQgBJb7ABckbZzwyckP
 CiDcnKkdw2jLRD9RwZq/UaXMOP4bGhy7HBSXvCwormp4xtgPeU36oD9YtaGzDLaoR3aZmCWkP
 IIWWRAVTd6kZ2jjGhIzm1iOvmZ/ar73a+KSZ4XlxnoyLFGnGsZwbUreIvCNZ0+bKUdmhBJCyH
 7eWUjf6OoTVDfK25zdJosrEq/OW9ynvglBY1nEba/OIyjnhr3DLx8OVDFvM85VGORjxxdQg3b
 ZuErcrjC1oMS27MM5EU+tBibsIzx7XzHE7yux0aSYRPQC1pm32xsoKO47HwaAn0fpEt+aXUJT
 jOzeWP3av39v0sYKsN/+0BKzRnWUBKYNVBBLhGDpW4jT0/BCJUEmD4Z/MgopjPAnLZBmkgw43
 2JGiDZ8XdIS723yqjmWbYcg4aWk8QDmMCn2pDdlaTi+HwTFKgboWCE3Qjx4bZ/4xHM4WCI4c6
 lP7aYasDnpQe/iblGQlePA/1Rj4skoDtspcu0VZK6AfqPfMTTTsWyg=
Received-SPF: pass client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 11/01/2024 à 11:29, Mark Cave-Ayland a écrit :
> This series introduces a new nubus-virtio-mmio device which can be plugged into
> the q800 machine to enable a 68k Classic MacOS guest to access virtio devices
> such as virtio-9p-device (host filesharing), virtio-gpu (extended framebuffer
> support) and virtio-tablet-device (absolute positioning).
> 
> Once the nubus-virtio-mmio device has been plugged into the q800 machine, virtio
> devices can be accessed by a Classic MacOS guest using the drivers from the
> classicvirtio project at https://github.com/elliotnunn/classicvirtio.
> 
> The nubus-virtio-mmio device is purposefully designed to be similar to the
> virtio-mmio interface used by the existing 68k virt machine, making use of a
> similar memory layout and the goldfish PIC for simple interrupt management. The
> main difference is that only a single goldfish PIC is used, however that still
> allows up to 32 virtio devices to be connected using a single nubus card.
> 
> Patch 1 fixes an alignment bug in the existing nubus-device Declaration ROM code
> whereby some ROM images could trigger an assert() in QEMU, patch 2 increases the
> maximum Declaration ROM size (to aid development), whilst patch 3 adds the
> nubus-virtio-mmio device itself.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> [Patches still needing review: 2, 3]
> 
> v3:
> - Rebase onto master
> - Update patch 1 alignment calculation to use intermediatery uint8_t rom_ptr
>    variable, add Phil's R-B tag
> - Add patch 2 to increase maximum Declaration ROM size to 1MB
> 
> v2:
> - Rebase onto master
> - Adjust comment in patch 1 as suggested by Phil
> 
> 
> Mark Cave-Ayland (3):
>    nubus-device: round Declaration ROM memory region address to
>      qemu_target_page_size()
>    nubus.h: increase maximum Declaration ROM size from 128k to 1Mb
>    nubus: add nubus-virtio-mmio device
> 
>   hw/nubus/meson.build                 |   1 +
>   hw/nubus/nubus-device.c              |  18 +++--
>   hw/nubus/nubus-virtio-mmio.c         | 102 +++++++++++++++++++++++++++
>   include/hw/nubus/nubus-virtio-mmio.h |  36 ++++++++++
>   include/hw/nubus/nubus.h             |   2 +-
>   5 files changed, 154 insertions(+), 5 deletions(-)
>   create mode 100644 hw/nubus/nubus-virtio-mmio.c
>   create mode 100644 include/hw/nubus/nubus-virtio-mmio.h
> 

Series Reviewed-by: Laurent Vivier <laurent@vivier.eu>

