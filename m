Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEACDC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 23:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAdIE-0007fQ-80; Thu, 01 May 2025 19:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAdIC-0007eQ-L5
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:26:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAdIA-0000mc-3w
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:26:12 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3BC4355D25C;
 Fri, 02 May 2025 01:26:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yRfkKqBFzUt0; Fri,  2 May 2025 01:26:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0332355D25A; Fri, 02 May 2025 01:26:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0128F745682;
 Fri, 02 May 2025 01:26:05 +0200 (CEST)
Date: Fri, 2 May 2025 01:26:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Jon Wilson <jonwilson030981@googlemail.com>
cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, 
 WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>
Subject: Re: [PATCH] Support madvise(MADV_DONTDUMP) when creating core dumps
 for qemu-user
In-Reply-To: <CAJHT5-+-3aJ4PqUj2G4C_aWA+WwevskMEEr0xcFotOfgqmNy3g@mail.gmail.com>
Message-ID: <cae935d3-e4b3-0969-2df7-75cc8c2ed9ff@eik.bme.hu>
References: <20250501181758.1057834-1-62701594+WorksButNotTested@users.noreply.github.com>
 <6d4308bf-5c8d-42df-a5f9-221dc1222ae2@linaro.org>
 <CAJHT5-+-3aJ4PqUj2G4C_aWA+WwevskMEEr0xcFotOfgqmNy3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 1 May 2025, Jon Wilson wrote:
> Awesome. Thanks. How do I do that? Sorry I'm new to this workflow. Can you
> point me at a reference?

qemu.org -> Contribute -> Patch submission guidelines:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html

Regards,
BALATON Zoltan

