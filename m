Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A6DCF857A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 10:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJTM-00032g-RF; Thu, 03 Oct 2024 06:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1swJTL-00032E-MV; Thu, 03 Oct 2024 06:54:15 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1swJTJ-0002DW-Ja; Thu, 03 Oct 2024 06:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=q9UNtp49MNYmiKaSkbMeVLbUdltKc+oYNGZAz/h9oYI=; b=DitYZC0N8tuuPHnu
 C36IVAcm0yKXWUofSLjsMZXLJVSBpYB3hX0y7N5pWZW8YBTYkWvbsSQp067KTNOH3vWxVosgL3eN/
 ckhyw0zChlCn6yObbGA2GWwIHwYacTTyX13aS6T4qz31fB/N6TDEAelGLz06rvTkZ6yopZFe4cyYs
 KzZVUegJLXrFiIZaM9p0/EOaHZdKCv+3kN9XvBKYuehIyFOl8HVmmbvzqG/bWUXSyiW1+L/EMBH9t
 SvsQ+eEWmM7uKvVsn+jBWFCku8X6vec2QR/+vhAVDBzEXfF2z+wnoXW2WE9h4QntgmwkJT9qIeuD0
 SwaSnKJo+x6Tf68L7Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1swJT8-008dMB-1p;
 Thu, 03 Oct 2024 10:54:02 +0000
Date: Thu, 3 Oct 2024 10:54:02 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com,
 jasowang@redhat.com, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
Subject: Re: [PATCH] hw/net/net_rx_pkt: Remove deadcode
Message-ID: <Zv53ynWvaOycpgH7@gallifrey>
References: <20240918225128.455043-1-dave@treblig.org>
 <2cd10ae8-8937-474a-b7fc-a98613416330@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2cd10ae8-8937-474a-b7fc-a98613416330@tls.msk.ru>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 10:53:45 up 147 days, 22:07,  1 user,  load average: 0.10, 0.03, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Michael Tokarev (mjt@tls.msk.ru) wrote:
> 19.09.2024 01:51, dave@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> > 
> > net_rx_pkt_get_l3_hdr_offset and net_rx_pkt_get_iovec_len haven't
> > been used since they were added.
> > 
> > Remove them.
> 
> Applied to the trivial-patches tree, removing net_rx_pkt_get_l3_hdr_offset()
> prototype from hw/net/net_rx_pkt.h in the process)

Thanks, and to Akhiko for pointing out that header left over.

Dave

> Thanks,
> 
> /mjt
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

