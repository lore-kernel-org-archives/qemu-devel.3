Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA591606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ldUDjnI0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX4XP-0000Gv-Op; Fri, 27 Nov 2026 17:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xX4XN-0000Fu-S3
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:35:25 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xX4XM-00078S-Aw
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:35:25 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cde827b7b95so2861602a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 14:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795818922; x=1796423722; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s3GcS9t32LnUnA6PazCviKk9ZpyL3XnsWns+PMeSPTI=;
 b=ldUDjnI0Bw0sc6AbyzA+qQIGJX0C/cS4Xa+8O7OQBUvN1OT6JybE4EHvlN1d5odFyR
 0/w4wFkGxDBfrDz8tp+G08ZlZC6Qz37YCPSnwa5w4gVwc86QcMHPdDhZDIaYFZMshpfn
 aYoD3VVV5QleNY8nF4CW8Ln/Er/ecSogyCKVAZeR70UOEGmOcxtmZyuf+GGxG5waU1Ld
 Q/mhMHc1Ir1sYBbniKn9f8ZnDR/nL8KMxvJo8qiq+713o9KeVTQ89PSyOJCKJCt7WoEZ
 nw3y2MZy+VBXmi0vGiph7wdCkKyGxI6xqWXHAUcZbOCcRnXQMhw1rQyt6hfn3NY3HOQC
 DveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795818922; x=1796423722;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s3GcS9t32LnUnA6PazCviKk9ZpyL3XnsWns+PMeSPTI=;
 b=1mS5GhQAsRKhtG59BzJzJV3gKotl+SIZJQplyuMKIEfF2bYDBEAqymgxABWvz07J6/
 wH0+WuS9UlF1o6IiS122aIWg1MiReiCK2BFPTkzAGW5g5tz4ru/ooK6hhiSCr8Ybl1NT
 ViYoWc+xD7hPMpEZH446V+KNR0TZJLdms72uZhU7X2Yp2kpsDjttEtBl6e4DGfYcdnDt
 IzvPgD+u5hUuSZ9GCWMOzeYfJdBONgkVsgMrljWYJIwm6GzLnvQ9B8rH1TTs8sz9xBgu
 3wSvef2ufoqlGLf/qI4RBbyTkVkFCBCMbgpNRjVxZ4l+HXf9M/7UQE/ZeY9RDhyAyA/F
 2MLw==
X-Gm-Message-State: APuU4Z+x7342//WWtb6JFNPgU1WR8rc3fFIY/Z+A7yB7eZaI+Jo199su
 6aromnbKtOB4w6SuqiuH+uXlTZVQFBwN3iwblZIaLhTSglbFv8qPsoj7
X-Gm-Gg: AZFdTZc/epIs0xap4pSQ4Cxi91ijvMAJlTzvuU6zSKAJy74qtvsVD8YeLntm7GaFtdU
 YUEJWqPl/ogmsK0NftBMStuiDwrecHvASH9QwxsdyKXwwd6z7tOA7wy0dqTMTJc+mfUW10Hd5n4
 Pza6TLApEMQ4Unl48dJ7A7UTOUbLKGTtazeVTbwprbOnzr7P9zWEnQ6oicojvy8V6KG45hG8NTA
 3ZXkgeBLx+V2OWtvTH3DONnDefjA5OI5eRKZIhxDI+11rtv4+nBdgyhSBCg7CvAahlXO7nNBBdb
 JteydABUs9exvaSu3IkaHBjXvfzIV4gfqUFKtCQ82CkTOQiIQr1DDUEtNMnrY1hOrvkxzscHAE7
 bLaJCidHMaJodrnpf5borEuZnhCXXFvO3OAXcdak+oAxgDmbjlNslixFnqK5XL+5s4mCkW8k0dU
 xIN295VuBVsnLnYfUGBbclRWIUmhLLs0Qv3Xa2HLsBre6uzjjmgBTHAuXrRAdQ5rcza/r42h5GL
 nBGRiNRvazJbEk3mbuD6aP7v5Bgr0WISAmUoWkQjWD9H5kmCP4nVO+MDzsuQ4ntFJyVskAYSCZ4
 NEpKm4Pg7ouIovknHb/Y1yElfWMEotyl5AQe/i6OE4p+Qg2dGnXi21aHMfxsqAqe8ZmXTW3TAit
 hqNgKRqlYQj3Kpkel+EuhRiOiSjzZgdA=
X-Received: by 2002:a17:90b:2f8f:b0:3b0:ad59:7199 with SMTP id
 98e67ed59e1d1-3b41c942629mr23359630a91.32.1795818922298; 
 Fri, 27 Nov 2026 14:35:22 -0800 (PST)
Received: from cfarm136.osuosl.org (cfarm136.osuosl.org.
 [2605:bc80:3010:104:21e:67ff:fefd:7034])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0b2c4sm39880831a91.4.2026.11.27.14.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 14:35:20 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Subject: [PATCH 0/4] hw/pci-bridge: Convert PCIe bridge devices to
 Resettable interface
Date: Fri, 27 Nov 2026 22:35:14 +0000
Message-Id: <20261127-pci-bridge-resettable-v1-0-cdf15c9252c5@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQrCQAyE4auUPLtg1lLRq4gPm+1UI1JLshWh9
 O6u9fFjmH8hhymczs1Chre6vsYK3jWU72m8IWhfTXEfO+bYhSlrENO+LgZHKUmeCCc5cszp0LI
 MVL+TYdDP1r1c//ZZHsjlF6N1/QL8CdoHeQAAAA==
X-Change-ID: 20261126-pci-bridge-resettable-9b712ca341bf
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=aleszlucero@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series converts the remaining PCI Express downstream and upstream
port devices in hw/pci-bridge/ from the deprecated
device_class_set_legacy_reset() to the three-phase ResettableClass
interface.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
Oscar Alejandro Sánchez Lucero (4):
      hw/pci-bridge: Convert gen_pcie_downstream_port to Resettable interface
      hw/pci-bridge: Convert gen_pcie_upstream_port to Resettable interface
      hw/pci-bridge: Convert xio3130_downstream to Resettable interface
      hw/pci-bridge: Convert xio3130_upstream to Resettable interface

 hw/pci-bridge/gen_pcie_downstream_port.c | 10 ++++++----
 hw/pci-bridge/gen_pcie_upstream_port.c   | 10 ++++++----
 hw/pci-bridge/xio3130_downstream.c       | 10 ++++++----
 hw/pci-bridge/xio3130_upstream.c         | 10 ++++++----
 4 files changed, 24 insertions(+), 16 deletions(-)
---
base-commit: 9751c62358073580cbf330a4df22077a7c6a407c
change-id: 20261126-pci-bridge-resettable-9b712ca341bf

Best regards,
--  
Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>


