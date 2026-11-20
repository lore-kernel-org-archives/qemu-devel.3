Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3730606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUCxo-0002ZU-Vb; Thu, 19 Nov 2026 19:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUCxn-0002Z3-6m
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 19:58:51 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUCxl-0001Ck-Dx
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 19:58:50 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A54260E017;
 Fri, 20 Nov 2026 01:58:47 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Z9T-kWEbKi_o; Fri, 20 Nov 2026 01:58:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6BB5C60CCE7; Fri, 20 Nov 2026 01:58:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 69B5613C28F;
 Fri, 20 Nov 2026 01:58:45 +0100 (CET)
Date: Fri, 20 Nov 2026 01:58:45 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Helge Deller <deller@kernel.org>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>, 
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>
Subject: Re: [PATCH v3 2/6] hw/scsi: share NCR/LSI definitions in
 lsi_scsi.h
In-Reply-To: <20261119233235.32808-3-deller@kernel.org>
Message-ID: <faf7c973-3c97-9899-7a46-3a518634603e@eik.bme.hu>
References: <20261119233235.32808-1-deller@kernel.org>
 <20261119233235.32808-3-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026, Helge Deller wrote:
> From: Keith Monahan <keith@techtravels.org>
>
> Move common defines and structures of the 53c710 and the lsi53c895a
> drivers to lsi_scsi.h, as suggested by BALATON Zoltan.

We have Suggested-by tag for that instead of putting it in comment 
message. This patch should come before the previous so it avoids the churn 
of renaming what patch 1 added and add that already using these defines 
and names after this patch.

Regards,
BALATON Zoltan

