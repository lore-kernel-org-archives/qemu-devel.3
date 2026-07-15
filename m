Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7DAC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 11:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjxy8-0006uL-Eb; Wed, 15 Jul 2026 07:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <listy@localities.work>)
 id 1wjxy7-0006tv-22
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 07:40:03 -0400
Received: from 089231102037.vcmts-wawpereca-2.vectranet.pl ([89.231.102.37]
 helo=mail.localities.work)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <listy@localities.work>)
 id 1wjxy5-0004k6-Az
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 07:40:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by dzien.mine.priv (Postfix) with ESMTP id 6ED47809DC92
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 13:32:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=localities.work;
 h=content-transfer-encoding:content-type:content-type:subject
 :subject:from:from:content-language:user-agent:mime-version:date
 :date:message-id:received:received; s=dkim20251117; t=
 1784115143; x=1784979144; bh=bvcUtmpFFEs0TZtTgZSVJmENRVmib5kgpbt
 rtFJYGtE=; b=noNZi+bfmEAJYPCQArktdYmwnY7bk38JLAHSPlfOgbXZfFx6bB4
 5whSkoF2k+mw11hHlxYnFFOByz+vaI2MTKRHSJ8KiuN2PgzuUzYZ9st/0VfYR0Pr
 viQuMvHn0TcVC+Til+5/K/gqlaUjnhlNt9lJk0+bGKsMtPqYOdq4RiAg=
X-Virus-Scanned: amavis at mine.priv
Received: from dzien.mine.priv ([127.0.0.1])
 by localhost (dzien.mine.priv [127.0.0.1]) (amavis, port 10022) with LMTP
 id ozrAw0-p0ZoX for <qemu-devel@nongnu.org>;
 Wed, 15 Jul 2026 13:32:23 +0200 (CEST)
Received: from [10.3.0.10] (unknown [10.3.0.10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by dzien.mine.priv (Postfix) with ESMTPSA id 0B20C809DC90
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 13:32:23 +0200 (CEST)
Message-ID: <ff0999dc-df05-4bb0-ac4f-95e481ac6422@localities.work>
Date: Wed, 15 Jul 2026 13:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW, pl, pl-PL
To: qemu-devel@nongnu.org
From: listy <listy@localities.work>
Subject: Could not initialize refcount handling:
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=89.231.102.37; envelope-from=listy@localities.work;
 helo=mail.localities.work
X-Spam_score_int: 24
X-Spam_score: 2.4
X-Spam_bar: ++
X-Spam_report: (2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=2, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi guys.

Perhaps not the first place this mailing list might be, 
however _users_ one seems pretty quiet, thus I'm trying here.

My qemu cannot start a domain:

-> $ virsh create /etc/libvirt/qemu/pacemaker.d/ubusrv2.xml
error: Failed to create domain from 
/etc/libvirt/qemu/pacemaker.d/ubusrv2.xml
error: internal error: QEMU unexpectedly closed the monitor 
(vm='ubusrv2'): 2026-07-15T11:25:13.789834Z qemu-kvm: 
-blockdev 
{"node-name":"libvirt-2-format","read-only":false,"discard":"unmap","cache":{"direct":true,"no-flush":false},"driver":"qcow2","encrypt":{"format":"luks","key-secret":"libvirt-2-format-encryption-secret0"},"file":"libvirt-2-storage","backing":null}: 
Could not initialize refcount handling: Input/output error

I qemu check the image:
...
No errors were found on the image.
584043/901120 = 64.81% allocated, 20.63% fragmented, 0.00% 
compressed clusters
Image end offset: 38286524416

-> $ __myQcowInfo --info /X0-STORAGEs/0/X-VMs-BKPs/ubusrv2.qcow2
image: json:{"encrypt.key-secret": "my-sec0", "driver": 
"qcow2", "file": {"driver": "file", "filename": 
"/X0-STORAGEs/0/X-VMs-BKPs/ubusrv2.qcow2"}}
file format: qcow2
virtual size: 55 GiB (59055800320 bytes)
disk size: 35.7 GiB
encrypted: yes
cluster_size: 65536
Format specific information:
     compat: 1.1
     compression type: zlib
     lazy refcounts: false
     refcount bits: 16
     encrypt:
         ivgen alg: plain64
         detached header: false
         hash alg: sha256
         cipher alg: aes-256
         uuid: 1809fc93-5ae7-4f9e-bf2c-2c3d25364859
         format: luks
         cipher mode: xts
         slots:

I think this might have happened after:
$ -> virsh backup-begin ...
but I'm not 100% sure.

qemu-img version 10.1.0 (qemu-kvm-10.1.0-24.el10)

Any thoughts on how to solve/fix this I'll appreciate a lot.
many thanks, L.

