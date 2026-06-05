Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79AFCD6E6E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIZh-0007kL-9w; Thu, 04 Jun 2026 20:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wVIZe-0007jp-Lg
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 20:38:10 -0400
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wVIZc-0004sN-WA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 20:38:10 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9090A40249E;
 Fri, 05 Jun 2026 00:38:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com
 (trex-green-8.trex.outbound.svc.cluster.local [100.105.229.196])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2AD12401EFB;
 Fri, 05 Jun 2026 00:38:05 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Hysterical: 643e7eb12dfe8cd0_1780619885390_170340365
X-MC-Loop-Signature: 1780619885390:1579572453
X-MC-Ingress-Time: 1780619885390
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.105.229.196 (trex/7.1.5); Fri, 05 Jun 2026 00:38:05 +0000
Received: from offworld (186-79-219-2.fo.baf.movistar.cl [186.79.219.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4gWjG35DZFz1040;
 Thu,  4 Jun 2026 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1780619885;
 bh=noRiTl5Y3cKt8NUWxuKitnMk3DTj+jaCi+jIYKy6NBY=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=fgpJJebOCTBotFZI49jQUfAP2BMFdYIew3XAgPB5zqA74SfhD3Qbe2X5pTR3y1LSC
 hK7aJv55wLVZ2QVU5vVFsj5rZIgFemU8MFClmPtCDeg610FwRZr/iLzU3p+lRBlbzW
 NVnhptChjgW32+ZIna4rsE5Sb3YrJsLmoUAEtaDIl6msNDQdFGmL+vCeNpKJoqWmYu
 0v5ttl44h/6qzv/1xHYNMb1F+Idnbv1avqZhL5b93qOlsmdEelHTnEL8w2JOcx+1oW
 OE9re4LcS7nt+hDx6Rh4k6waJ1dMFriUEz6uslyQXc0T0yVyJGBODIOuiF6pEqFmTX
 QS7I76nlH1EKQ==
Date: Thu, 4 Jun 2026 17:37:57 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] hw/cxl: Add per-capability CXL Fixed Memory Window
 restriction flags
Message-ID: <20260605003757.mmplm66efpxgiujw@offworld>
References: <20260602231806.2469011-1-dave@stgolabs.net>
 <20260602231806.2469011-5-dave@stgolabs.net>
 <20260604113426.206c4d39@jic23-huawei>
 <20260604154259.tq7vnnzuc74jif2m@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260604154259.tq7vnnzuc74jif2m@offworld>
User-Agent: NeoMutt/20220429
Received-SPF: softfail client-ip=23.83.218.253; envelope-from=dave@stgolabs.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 04 Jun 2026, Davidlohr Bueso wrote:

>This is also why I drop the bit0 in the default restrictions. I am fine removing
>this check here for now, but also have a kernel equivalent which fails the cfmw
>parsing if any of the above is seen (maybe the failure could be downgraded to
>a warning).

Just fyi on the kernel v4 I just sent out, I removed the failing when bit0+bit1
and just left the error on bit1+bit5 (BI).

Thanks,
Davidlohr

