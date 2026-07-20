Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE438C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlxdP-0007MN-9G; Mon, 20 Jul 2026 19:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wlxdL-0007LZ-H7
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:42:51 -0400
Received: from cyan.elm.relay.mailchannels.net ([23.83.212.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wlxdI-0005xE-22
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:42:49 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id BFE8F4C0952;
 Mon, 20 Jul 2026 23:42:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com
 (100-104-253-237.trex-nlb.outbound.svc.cluster.local [100.104.253.237])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 58F3D4C1079;
 Mon, 20 Jul 2026 23:42:44 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Relation: 367eb78547b43b37_1784590964425_131921293
X-MC-Loop-Signature: 1784590964425:732101614
X-MC-Ingress-Time: 1784590964425
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.104.253.237 (trex/8.0.2); Mon, 20 Jul 2026 23:42:44 +0000
Received: from offworld (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xrz65vzz2x; 
 Mon, 20 Jul 2026 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1784590964;
 bh=/c0sNGSQaDr0zLvwwyVC+RwnDdHSwqcH9LdcLgviDpA=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=ZrMKD36pKn0r3b1OmHb9tjYbPi8MmqsFCwll9Pg6Vg22tqR6LAg/6jpd4lbABwxPZ
 NKAH1bgUU6OUoykeavCRhS3FzC5TC5JYTxNcNFqUfgbof1YRFTPpttUU+1Zc5bgoYi
 4NnWa27rkkVHv5riFoOuuVD8MlkCZs96ZdjXDBmvJ2g/bsshGRtQqpWYgI29BphSFE
 16I/mCsFtyJjt52FIlpA3Rnhw0nZihni+X08LWg8/ItPA3+fnCFJXTRZ0+CEacoLmm
 aoyOoLMZsqEp6Jn6CZXndsEhvfio9eqdSLv3bknDbUH0b7PxHC1qlD4zDY1PCOOEDh
 T7zOTZBmhLVmw==
Date: Mon, 20 Jul 2026 16:42:41 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org, mst@redhat.com
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/5] hw/cxl: hw/cxl: Host-only default CFMW
 restrictions and per-window options
Message-ID: <20260720234241.zugypuohzgdve7md@offworld>
References: <20260720233242.901544-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720233242.901544-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429
Received-SPF: softfail client-ip=23.83.212.47; envelope-from=dave@stgolabs.net;
 helo=cyan.elm.relay.mailchannels.net
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

bleh sorry, the cover letter subject should say -qemu.

