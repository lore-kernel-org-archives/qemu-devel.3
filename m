Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A4BC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJVxI-0000Fo-RR; Mon, 26 May 2025 07:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uJVxG-0000CR-D2
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uJVxE-00025u-9Q
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748258712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/FEjXOLzj5L5/lUQ9Ws/gOrxr180bGZQkH2W69Ud6M=;
 b=XkwzCNFQWJzW1ygVwA6luy2wNlxq/N0riT7xBUhlQto+O7MWnlQbfFobeIgLfoDfzkyUjY
 FI4TXYcEPx/BhTgmY4CqNJ4I7/yx2AedA57F6YjCHFZ6bkLyX7vv4wYDzVrulKmk1yDXc0
 1v4yeLaHNHUMGAy4UbKpDTXaf4BKE+Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-uxHrrXzlNmSbFhsqlppcYQ-1; Mon,
 26 May 2025 07:25:06 -0400
X-MC-Unique: uxHrrXzlNmSbFhsqlppcYQ-1
X-Mimecast-MFC-AGG-ID: uxHrrXzlNmSbFhsqlppcYQ_1748258705
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9389B19560A7; Mon, 26 May 2025 11:25:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.225.234])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3963A195608D; Mon, 26 May 2025 11:25:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D871B18000A4; Mon, 26 May 2025 13:25:02 +0200 (CEST)
Date: Mon, 26 May 2025 13:25:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/2] Firmware/seabios 20231128 patches
Message-ID: <capr5eoes6uql63je42dfgvozk6hshx55kcrjzkh5oszktk3zl@77hv2bi6wzc7>
References: <20231128081743.2214005-1-kraxel@redhat.com>
 <8ec05a12-b900-4f32-ba2f-e2ab7c60350d@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec05a12-b900-4f32-ba2f-e2ab7c60350d@ilande.co.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Hi Gerd,
> 
> Are there any plans to update the SeaBIOS firmware in QEMU soon? In
> particular someone has asked me off-list about one of my previous ESP series
> which depends upon having an updated SeaBIOS firmware.

Plan is to update to 0.17.0 as soon as it is released.  Which is delayed
a bit right now due to a regression in the ahci driver being sorted out.

take care,
  Gerd


