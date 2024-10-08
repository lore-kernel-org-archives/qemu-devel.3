Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922E6CEF173
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 13:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syAKi-0002Jz-1v; Tue, 08 Oct 2024 09:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1syAKf-0002JP-3S; Tue, 08 Oct 2024 09:32:58 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1syAKd-0000AV-2e; Tue, 08 Oct 2024 09:32:56 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 47D874E6010;
 Tue, 08 Oct 2024 15:32:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id MgYWqqkHMNpa; Tue,  8 Oct 2024 15:32:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 593F84E600E; Tue, 08 Oct 2024 15:32:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5754C746F60;
 Tue, 08 Oct 2024 15:32:47 +0200 (CEST)
Date: Tue, 8 Oct 2024 15:32:47 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 0/2] Consolidate embedded PPC initial mappung functions
In-Reply-To: <cover.1721131193.git.balaton@eik.bme.hu>
Message-ID: <0bbe70cf-d798-d6b8-1070-827683e923bc@eik.bme.hu>
References: <cover.1721131193.git.balaton@eik.bme.hu>
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

On Tue, 16 Jul 2024, BALATON Zoltan wrote:
> Embedded PPC has always enabled MMU so it needs initial mappings to
> start. This code is duplicated within machines which this small series
> aims to consolidate into helper functions to reduce duplicated code
> and make the board code simpler.

Ping?

> Regards,
> BALATON Zoltan
>
> BALATON Zoltan (2):
>  hw/ppc: Consolidate e500 initial mapping creation functions
>  hw/ppc: Consolidate ppc440 initial mapping creation functions
>
> hw/ppc/e500.c          | 41 ++++++++++++++++++--------------------
> hw/ppc/e500.h          |  2 --
> hw/ppc/ppc440_bamboo.c | 28 +++-----------------------
> hw/ppc/ppc_booke.c     | 10 ++++++++++
> hw/ppc/ppce500_spin.c  | 30 +++++++++-------------------
> hw/ppc/sam460ex.c      | 45 ++++++++++--------------------------------
> hw/ppc/virtex_ml507.c  | 28 +++-----------------------
> include/hw/ppc/ppc.h   |  7 +++++++
> 8 files changed, 61 insertions(+), 130 deletions(-)
>
>

