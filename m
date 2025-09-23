Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BEDCAC5AE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 15:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v14gE-0000Ho-9p; Tue, 23 Sep 2025 11:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v14gC-0000H7-9s
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 11:11:44 -0400
Received: from m204-227.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v14g9-0000Qg-Qa
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 11:11:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1758640298; x=1758647498; 
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From:
 Sender: Sender; 
 bh=/05LDhf6jMiTAX+rkc+1tIJmP4IBZJb/c5wwz91+X8c=;
 b=E3GEo/Y/uYK8drwJsi/4GCD4z0XRo04QgwuZ9jPGwd5pPmHYODmNxCfOr+g8VOHq0bFUnsyn/RGT8QJrkirghGhrFIeyYS3XzhQRVg0HKhvPEaGPES59XjXYgLK/LyE2gpjiFL8ugZyjf+9LutGcBLwwuq35qUeLnAIg4ZQYssZYE2g/H0sNabaog8XlLoWBT4rskxiyoe7rdRwXBlqqySgHRnZmA/CdbciBZHw8d6djF+1rg6oodZPmJhY4aPCSyDLqUsgW5VnlQb0LGEgB6lKRKVn8Tzmj9XjeH9kyQ9JYuaSsnV1qjwtZee4LnlEfVM2LkseWZf7O3h/5Up00Qw==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 3410bf604baf3b1186e1b7c3ddb9946731989e4e31ae93aebc8156634f8d87f1 with SMTP id
 68d2b8aa18d8f1fae9c332c8; Tue, 23 Sep 2025 15:11:38 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: alessandro.ratti@gmail.com, alex.bennee@linaro.org, armbru@redhat.com,
 berrange@redhat.com, mst@redhat.com
Subject: [PATCH v2] virtio: improve virtqueue mapping error messages
Date: Tue, 23 Sep 2025 17:09:24 +0200
Message-ID: <20250923151127.504186-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923130034.486370-2-alessandro@0x65c.net>
References: <20250923130034.486370-2-alessandro@0x65c.net>
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


Hi,

Following up on the previous discussion [1], Markus Armbruster raised an
important point:

> Note that qdev_get_dev_path() may return null.  You need another fallback.

This v2 addresses that by falling back to the string "<unknown device>" in
the virtio_get_pretty_dev_name() helper if both the device ID and QOM path
are unavailable.

Markus also noted:

> For what it's worth, "qdev ID or QOM path" is how users specify devices in QMP.

With this change, the logic for device identification now mirrors the behavior
expected in QMP tooling — prioritizing user-provided IDs, falling back to
system-generated QOM paths, and ensuring that a meaningful identifier is always
present in error messages.

Thanks for your time and consideration.

Best regards,
Alessandro Ratti

[1]: https://lore.kernel.org/qemu-devel/87y0q58f97.fsf@pond.sub.org/


