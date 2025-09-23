Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53032CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v12eg-0003Wi-NA; Tue, 23 Sep 2025 09:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v12dd-0002u8-Er
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 09:00:57 -0400
Received: from m239-4.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v12dS-0004FY-Jl
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 09:00:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1758632440; x=1758639640; 
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date:
 Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=p57Q6RLqFncpJ+HczZx7OVIo+ASATHP9ZDv/1NZaEu0=;
 b=ZoaRd+/BnbNObGYmqmSxEyvrS6Xh2RYz7i0RnCSHG+3Tqu+pSpnbDC9F8FImp1ORjwyh2pKMGcosQCVB+Js69kPglowczMwmey2pRzMfqcw4uWjpn00NQEs8r58avdb9WUReFFrVNBfgPY+An1JFcK+V1rjYR6swDmYslRnyf4V9S/dEELX4Rkw/l6IN5PZsZv28arTnPJKVlrKVZnDUTJB8yOjDtd06WpzCjHfz5DdQdf55V0Y4ZBFqUIh68caKmOMlI+uUUB4X1yT3qSsqg4k5k9BPCBMDL1VyesdwnwNmV+0GJBjuimInacpbZ0xm1srnU/AQkldAkzYe4gh9mA==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 55fdd80091757d6f49ccd5a4be9c092de5292e63009b174a6410b8c2f163bec3 with SMTP id
 68d299f818d8f1fae90879b1; Tue, 23 Sep 2025 13:00:40 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: alessandro.ratti@gmail.com, armbru@redhat.com, berrange@redhat.com,
 alex.bennee@linaro.org, mst@redhat.com
Subject: [PATCH] virtio: improve virtqueue mapping error messages
Date: Tue, 23 Sep 2025 14:46:51 +0200
Message-ID: <20250923130034.486370-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m239-4.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


Hi all,

Following up on the previous discussion in this thread [1], I'm submitting a
cleaned-up version of the patch to improve error messages in
virtio_init_region_cache() when virtqueue ring mapping fails.

This version introduces a helper (virtio_get_pretty_dev_name()) that returns
either:

 - the device ID, if explicitly set by the user (e.g. -device ...,id=foo)
 - or the QOM path from qdev_get_dev_path(dev) otherwise

This improves the clarity of error messages, especially when debugging
misconfigured guests or setups with multiple virtio devices.

## Example 1: PCI device (fallback to QOM path returns PCI ID)

~/qemu/build$ ./qemu-system-x86_64 \ 
    -enable-kvm \ 
    -m 512 \ 
    -drive if=virtio,file=/tmp/some.img,format=raw
qemu-system-x86_64: Failed to map descriptor ring for device 0000:00:04.0: invalid guest physical address or corrupted queue setup

## Example 2: Non-PCI virtio-mmio device (QOM path fallback)

~/qemu/build$ ./qemu-system-aarch64 -M virt -cpu cortex-a57 -m 512 -nographic \
    -append "console=ttyAMA0" \
    -drive if=none,file=/tmp/some.img,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 \
    -kernel /tmp/vmlinuz-5.15.0-qcomlt-arm64

qemu-system-aarch64: Failed to map descriptor ring for device virtio-mmio@000000000a003e00: invalid guest physical address or corrupted queue setup\ 

## Example 3: Explicit device ID (dev->id path)

~/qemu/build$ ./qemu-system-aarch64 -M virt -cpu cortex-a57 -m 512 -nographic \
    -append "console=ttyAMA0" \
    -drive if=none,file=/tmp/some.img,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0,id=foo \
    -kernel /tmp/vmlinuz-5.15.0-qcomlt-arm64

qemu-system-aarch64: Failed to map available ring for device foo: possible queue misconfiguration or overlapping memory region

As discussed, I considered using qdev_get_human_name() but it often returns
opaque paths like 

   /machine/peripheral-anon/device[0]/virtio-backend 

Which are less informative in user-facing logs compared to PCI IDs or
user-specified names.

The messages have been adjusted to be more descriptive and scoped to improving
this specific area of diagnostics. I hope this aligns with the direction
discussed — but of course, I’m open to further suggestions if something still
feels off.

Thank you for your time and consideration.

Best regards,
Alessandro Ratti

[1]: https://lore.kernel.org/qemu-devel/20250915100701.224156-1-alessandro@0x65c.net/

