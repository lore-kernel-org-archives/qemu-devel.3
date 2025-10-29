Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E163BCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6eA-0004WJ-Ko; Wed, 29 Oct 2025 09:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vE6e8-0004W7-Mf; Wed, 29 Oct 2025 09:55:28 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vE6e1-0004nN-Hv; Wed, 29 Oct 2025 09:55:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 738BD597304;
 Wed, 29 Oct 2025 14:55:15 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 62RLQB14ghuj; Wed, 29 Oct 2025 14:55:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 631F9597303; Wed, 29 Oct 2025 14:55:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 61B67597300;
 Wed, 29 Oct 2025 14:55:13 +0100 (CET)
Date: Wed, 29 Oct 2025 14:55:13 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: pegasos2 patches for the freeze
Message-ID: <bee2d3b0-1565-2c63-93a0-4e84ced610f0@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, HEXHASH_WORD=1,
 SPF_HELO_NONE=0.001, T_HDRS_LCASE=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

To help tracking patches to be merged here's the list I have on my 
pegasos2 branch that I hope can be merged for the next release:

f5c71e99b5 (HEAD -> pegasos2) hw/pci-host/articia: Add variable for common type cast
159f8cec9c hw/ppc/pegasos: Update documentation for pegasos1
8835cce4ff hw/ppc/pegasos2: Rename to pegasos
356511cf3d hw/pci-host/articia: Map PCI memory windows in realize
7649f4c174 hw/ppc/pegasos2: Add /chosen/stdin node with VOF
b1b9b6668d (master) hw/ppc/sam460ex: Update u-boot-sam460ex
41312cc017 ati-vga: Fix framebuffer mapping by using hardware-correct aperture sizes
2d1444017d ati-vga: Separate default control bit for source

I hope somebody can take care of the ati-vga patches so you don't have to 
care about them, you already have the sam460ex u-boot update then only 
need the "Some more pegasos patches" series and the last articia patch 
I've sent separately based on the series. No review yet on the 7649f4c174 
hw/ppc/pegasos2: Add /chosen/stdin node with VOF patch and not sure if we 
can keep Philippe's R-b on 356511cf3d hw/pci-host/articia: Map PCI memory 
windows in realize based on previous discussion but other's were R-b by 
Philippe already. I hope these can be in your last pull request for the 
freeze.

Congrats for becoming ppc maintainer by default :-) but thank you very 
much for helping out with this.

Regards,
BALATON Zoltan

