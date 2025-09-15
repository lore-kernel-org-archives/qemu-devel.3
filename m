Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315AECAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy67c-0007ZA-By; Mon, 15 Sep 2025 06:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1uy67X-0007YP-Ub
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:07:40 -0400
Received: from m239-4.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1uy67G-00066J-Uk
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:07:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1757930835; x=1757938035; 
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date:
 Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=h4jLD4Rr/R88hs8O2K+L/cU/piXpEFdNsRzJyBeUBhs=;
 b=YbS6Z3lIBLTjQNz+fScV8mxEg5DkKi6pu5LgD5vGYrypc9kJQ4uqEYLNBMiBxBuKHLTpbHa12xEIbCV0T0QfNZx15Nc9y/AgbKWHzme6su8H19l4HtIAotF2aky/Z0Njd9GGcDEHLzeGgqoaCS67gDw9bQHYJ17ifUq4dV+9QqyV4uafM7bbkwuCn44TKjbaD3Ki9AGAWHelqYEqvO7kY5npSPiUtA80/d+fJJFjLT1BlcTfW+0vmNdHrFHXCXPDBcjTC7+bG00kyH+gW/oycsE3+XqjKvwuFRMj4k4oRKswrZ7o5ayFgXaXHAsBz+adWb+O4LA4g7WKZeRJThTdNw==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 72144cfb99b61755965ba36ab48da239f3e5d8856025c89e1aebabc970f2747b with SMTP id
 68c7e550e845e547b35073d5; Mon, 15 Sep 2025 10:07:12 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: alessandro.ratti@gmail.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH] virtio: Add function name to error messages
Date: Mon, 15 Sep 2025 12:01:06 +0200
Message-ID: <20250915100701.224156-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m239-4.eu.mailgun.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


Hi,

In a previous attempt [1] to improve virtio error messages I didn’t fully
understand the suggestion made by Alex Bennée in a previous attempt [2].

This patch implements his idea more faithfully: instead of hard-coding a
"virtio" prefix at the call sites, we prepend the function name within
virtio_error() itself. This centralizes the change, avoids duplication,
and makes the log messages more informative.

For example, after forcibly triggering an error inside
virtio_init_region_cache(), the resulting output now shows the function
context clearly:

    ~/qemu/build$ sudo ./qemu-system-x86_64  \
    -enable-kvm   \
    -m 512   \
    -drive \
    if=virtio,file=/tmp/some.img,format=raw
    qemu-system-x86_64: virtio_init_region_cache: Cannot map used
    qemu-system-x86_64: virtio_init_region_cache: Cannot map used
    ...

This should address the original concern in a cleaner and more
maintainable way.

Thank you for your time and consideration.

Best regards,
Alessandro Ratti

[1]: https://lore.kernel.org/qemu-devel/20250830093844.452039-2-alessandro@0x65c.net/T/#t
[2]: https://patchwork.kernel.org/project/qemu-devel/patch/20220414112902.41390-1-codeguy.moteen@gmail.com/

