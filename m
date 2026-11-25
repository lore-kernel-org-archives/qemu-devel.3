Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C388B606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWGew-0004gJ-Vj; Wed, 25 Nov 2026 12:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zakinko@snowrabbit.org>)
 id 1xWGet-0004fr-4u; Wed, 25 Nov 2026 12:19:51 -0500
Received: from bambi.snowrabbit.org ([182.48.54.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zakinko@snowrabbit.org>)
 id 1xWGem-0007Pq-BO; Wed, 25 Nov 2026 12:19:50 -0500
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
 id 2182DC9300; Thu, 26 Nov 2026 02:19:34 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Thu, 26 Nov 2026 02:19:32 +0900
Message-ID: <179562717261.21196.2381142528834233384@snowrabbit.org>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Showta Ishizaki <zakinko@snowrabbit.org>
Subject: Re: [PATCH] hw/ppc/spapr: Match the CAS PVR list terminator as PAPR
 requires
In-Reply-To: <20261028194120.C7B72C9296@bambi.snowrabbit.org>
References: <20261028194120.C7B72C9296@bambi.snowrabbit.org>
Received-SPF: pass client-ip=182.48.54.220;
 envelope-from=zakinko@snowrabbit.org; helo=bambi.snowrabbit.org
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
X-Archived-By: <archiver.kernel.org>

Ping.

https://patchwork.ozlabs.org/project/qemu-devel/patch/20261028194120.C7B72C9296@bambi.snowrabbit.org/

It still applies to current master.  Without it, NetBSD's ofwboot
cannot get past CAS on -cpu power10.

