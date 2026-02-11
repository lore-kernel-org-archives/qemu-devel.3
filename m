Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21E5E9E2EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 11:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq8mP-0004Dp-7a; Wed, 11 Feb 2026 06:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vq8mN-0004Dd-GR
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:53:11 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vq8mM-0000ej-4M
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:53:11 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0D150596A13;
 Wed, 11 Feb 2026 12:53:09 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id veO14UplHljq; Wed, 11 Feb 2026 12:53:07 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 04414596A0D; Wed, 11 Feb 2026 12:53:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 02F3C5969FA;
 Wed, 11 Feb 2026 12:53:06 +0100 (CET)
Date: Wed, 11 Feb 2026 12:53:06 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Elisey Konstantinov <elisey.konstantinov@gmail.com>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/usb/hcd-ohci: Implement frame number overflow event
In-Reply-To: <794EF3D1-9CF5-4640-B889-B317329017AE@gmail.com>
Message-ID: <ef4c429a-50fe-0aac-9de9-f3f33e0477fd@eik.bme.hu>
References: <794EF3D1-9CF5-4640-B889-B317329017AE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 11 Feb 2026, Elisey Konstantinov wrote:
> Tested-by: Elisey Konstantinov <elisey.konstantinov@gmail.com>

Please sent that to the list too (cc'd now). Does this also resolves our 
ticket?

Regards,
BALATON Zoltan

