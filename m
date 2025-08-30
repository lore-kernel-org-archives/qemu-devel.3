Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00E2CA1003
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOQc-0000k4-2l; Sat, 30 Aug 2025 12:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1usI2y-0007ow-4u
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 05:38:56 -0400
Received: from m204-227.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1usI2w-0002MS-0v
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 05:38:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1756546731; x=1756553931; 
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date:
 Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=/HYEUGSfsPIIVlhCbmnNtY/cUpksb10S6fvArjj8hsI=;
 b=bhHtN7gDuEdHHBn+spD6lPCMbSCKOmQSFjo91PUhna/NqJpM8A+7R0tgGDtZyvWG4pgyLrbkG1cEWMvGLw6McpgPn9CtjqGRQwiAoDudZZOec1aQlSaYxOlHtDIRBeJIwey9XLGmDRtJ1QAEHd374sZCc2NkKMTBGnjWk0Gb37qWPxsDrUnNn+sOzdZvTyGdXewfI3sTSPMfialikyTIl6nWMQmnllBRfwuzQbge1yy00SJtaeM5FTall95x956kDDbgO7uZoPmRTROqgUHAr8jtZMlTHHrlLPtyMk351pqi0XVK5DP0YldUN2MAwyyfyVzVnI/3AAyU0MspV0GeGQ==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 93518a5527e07c5c8c323cd912038c47e23a9b50108f025ab03e83a0b0c23c7b with SMTP id
 68b2c6abdcefa73eceecbfa4; Sat, 30 Aug 2025 09:38:51 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: alessandro.ratti@gmail.com
Subject: [PATCH] virtio: prefix error messages with "virtio:" 
Date: Sat, 30 Aug 2025 11:31:46 +0200
Message-ID: <20250830093844.452039-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=161.38.204.227;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m204-227.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 30 Aug 2025 09:06:12 -0400
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

This patch follows up on a previous attempt [1] to improve error messages in
virtio_init_region_cache(), where the messages:

    Cannot map desc
    Cannot map used
    Cannot map avail

were changed to:

    Virtio cannot map desc
    ...

While this was an improvement in clarity, a reviewer (Alex Bennée)
pointed out that all such messages go through virtio_error(), and suggested
a cleaner and more scalable solution: prefixing all messages in
virtio_error() itself.

This patch implements that suggestion. It modifies virtio_error() to prepend
"virtio: " to all messages, improving clarity across all call sites without
duplicating the prefix manually.

I tested the change by forcibly triggering an error inside
virtio_init_region_cache() and verified the resulting output includes the
new prefix, as expected.

  ~/qemu/build$ sudo ./qemu-system-x86_64  \
      -enable-kvm   \
      -m 512   \
      -drive \
      if=virtio,file=/tmp/some.img,format=raw
  qemu-system-x86_64: virtio: Cannot map used (debug test)
  qemu-system-x86_64: virtio: Cannot map used (debug test)
  qemu-system-x86_64: virtio: Cannot map used (debug test)
  qemu-system-x86_64: virtio: Cannot map used (debug test)
  qemu-system-x86_64: virtio: Cannot map used (debug test)
  qemu-system-x86_64: virtio: Cannot map used (debug test)
  ^Cqemu-system-x86_64: terminating on signal 2

This should address the original concern in a more maintainable way.

Thank you for your time and consideration.

Best regards,
Alessandro Ratti

[1]: https://patchwork.kernel.org/project/qemu-devel/patch/20220414112902.41390-1-codeguy.moteen@gmail.com/

