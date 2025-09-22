Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4C7CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0cyi-0001If-ID; Mon, 22 Sep 2025 05:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v0cyb-0001E9-QF
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:36:54 -0400
Received: from m239-4.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v0cyT-0000XB-3z
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:36:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1758533800; x=1758541000; 
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From:
 Sender: Sender; 
 bh=T3zMaekyFS1Z5ONmwjBD2G4qk6+31wnjFNxLyfCUjuE=;
 b=IM/sydKemCoE9KVZxW+CpiXCOVpoiZPg1Jq3AZ3JHVDw94fGcrlUMoHWUrorCc3mDm2p1kd0z5s3giWf/G+mlUcyJN8OgQyHL3+ywcvg/K4lYaxdJVT4LjhWZUJxgDeaEiVZeJM5OfssobBFJXJ28T1fGKp8sGCNG5og5si0OpbfKJPLKblRN3PhbF0yMXcJonwZng6/b0J6LX4j8UTuFPcwLq42KDe59wGZlMYHGfepRJFaSTIpMYa9po21WEmMExLST2juAzgvYdnsOmloY1yaVwIVFP0c+oWK0QZJPfauaBV7DdXpvkbylHtdKkSv600oYa73zNnUwO4Fe9wKKQ==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 828b261a786e1b88f6f0348b70940623e6e0bda0119f79194ebef0939f7d6478 with SMTP id
 68d118a8d42d18cfde6d4cd4; Mon, 22 Sep 2025 09:36:40 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, mst@redhat.com,
 david@redhat.com, mjt@tls.msk.ru
Subject: [PATCH v2] virtio: Add function name to error messages 
Date: Mon, 22 Sep 2025 11:33:15 +0200
Message-ID: <20250922093632.381955-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915162643.44716-2-alessandro@0x65c.net>
References: <20250915162643.44716-2-alessandro@0x65c.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m239-4.eu.mailgun.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


> > For completeness you could also fixup:
> >
> >   virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
> >
> > for virtio-ballon. Otherwise:
> >
> > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Thank you for your review.
> I've missed that. For completeness, I've sent out a v2 that removes the
> manual __func__ usage in virtio-balloon to avoid duplicate function names,
> as you suggested.

Resending v2 with additional CCs to virtio maintainers and Michael
Tokarev (trivial-patches), as no feedback was received after initial
posting.

Thank you for your time and consideration.

Best regards,
Alessandro Ratti

