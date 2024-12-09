Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC3CE77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 11:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKbqf-0003cM-4m; Mon, 09 Dec 2024 06:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tKbqb-0003cD-Q3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:22:41 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tKbqQ-00059I-MV
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:22:35 -0500
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id EFA7C2CAFE;
 Mon,  9 Dec 2024 12:22:24 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id i6HhmsEKKh5z; Mon,  9 Dec 2024 12:22:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1733743342;
 bh=EqOzLiRSQxV6Wf7sQXZTn85bILKk00r9o6eDTP1jQzY=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=trgmWbDhSEwKmF/Oo9HNfu4xVxVk0wxwdJTZcnQSei2FqqnhPX0cRnvnqiMhE/2mZ
 XY4imA+7v+l/x+zTK4YkRJPPtjMVy7oKd6eDTagmgKrQX1DyRAg54+3bd5r0iRKf0f
 KWRwKIOymIxGqknYF7iQZVTlZ9TRQu5SbbEw9XqlFFY0giJxTLfuPik13QYd4Ztle+
 FC3S0GGLuEwMD7oyzJl3KEN0erdaVtZGZYZkIL8fwLQau6pEvRzXK4P9VzGUiu9NIx
 uaD38CMA71VMEazB4JVpQPIZSBORuLD0RyFcDZ3feeFIxCzy+S8PqcBW4sOMmztwgq
 YS3H7h4qOCkiw==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 5D2542CA43;
 Mon,  9 Dec 2024 12:22:22 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] hw/net/can: clean-up unnecessary includes
Date: Mon, 9 Dec 2024 12:23:02 +0100
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org, Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241209100635.93243-1-alex.bennee@linaro.org>
In-Reply-To: <20241209100635.93243-1-alex.bennee@linaro.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202412091223.02308.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-3.416,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Alex,

On Monday 09 of December 2024 11:06:35 Alex Benn=C3=A9e wrote:
> The event_notifier, thread and socket includes look like copy and
> paste of standard headers. None of the canbus devices use chardev
> although some relied on chardev to bring in bitops and byte swapping
> headers. In this case include them directly.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Tested on Debian/GNU/Linux for SJA1000 and CTU CAN FD=20

QEMU=3D/home/pi/repo/qemu/qemu-build/qemu-system-x86_64

$QEMU -enable-kvm -kernel $KERNEL \
      -m 512M \
      -initrd ramdisk.cpio \
      -virtfs local,path=3Dshareddir,security_model=3Dnone,mount_tag=3Dshar=
eddir \
      -vga cirrus \
      -append "console=3DttyS0 \
      -object can-bus,id=3Dcanbus0-bus \
      -object can-host-socketcan,if=3Dcan0,canbus=3Dcanbus0-bus,id=3Dcanbus=
0-socketcan \
      -device kvaser_pci,canbus=3Dcanbus0-bus \
      -device ctucan_pci,canbus0=3Dcanbus0-bus,canbus1=3Dcanbus0-bus \
      -nographic

By the way, I would like to discuse how to update CTU CAN FD a SJA1000
IRQ handling to allow mapping on FPGA target platform buses from command
line.

I have some working prototype

  https://github.com/ppisa/qemu/commits/net-can-ctucanfd-platform/

but I have some questions how to implement interrupts processing
(or logic function) correct and acceptable way. I wills tart new
thread and hope somebody responses and teaches me what is the
proper solution.

Best wishes,

                Pavel
=2D-=20
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

