Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1023E9A77A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w50kR-0002Nb-Mu; Tue, 24 Mar 2026 08:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w50kP-0002N0-Au
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w50kN-00079t-Tu
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774354833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YSaLNfehMvGy72Zc2qQN5X1k6y0LNjeEtt0z5UQ/tbE=;
 b=BoTLSmhoOmd7NppKbX2nRVHzLCNVuHzQRX3nWAh6mArtgKW/KRgXIgozkce2dLNcpP1HMs
 pYeccy6bXX3nf/uQUu9xAto3imLFgxUYyrxO1OO7vIc5Ws9gq0eRglwRNFQh9r09gycj7f
 9g2O9H39RegtyKy+t5eDH/fEEHzsCq0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-dOZrssPNN1-xZHLtOQDyHw-1; Tue,
 24 Mar 2026 08:20:30 -0400
X-MC-Unique: dOZrssPNN1-xZHLtOQDyHw-1
X-Mimecast-MFC-AGG-ID: dOZrssPNN1-xZHLtOQDyHw_1774354829
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E81EC19560A1; Tue, 24 Mar 2026 12:20:28 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.33.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6906D1955D71; Tue, 24 Mar 2026 12:20:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for 11.0] pc-bios: remove obsolete linuxboot.bin prebuilt blob
Date: Tue, 24 Mar 2026 12:20:25 +0000
Message-ID: <20260324122025.892666-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The corresponding source was removed in

  commit 88641f4df388faa78c49c54ed885e530fd0a75dc
  Author: Philippe Mathieu-Daudé <philmd@linaro.org>
  Date:   Thu Jan 8 11:30:39 2026 +0800

    hw/i386: Remove linuxboot.bin

We must also remove the pre-built blob to avoid a GPL violation
from lack of complete & corresponding source.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 pc-bios/linuxboot.bin | Bin 1024 -> 0 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 pc-bios/linuxboot.bin

diff --git a/pc-bios/linuxboot.bin b/pc-bios/linuxboot.bin
deleted file mode 100644
index 923d1796fbc58f1a836c160be533d1cf697b7511..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1024
zcmdUt&r2IY6vy9gHZe)X-PE5@4-#x3kjv16P>MG_wU8X_xkCL)K~ks<^cr#+2m|)m
zKcW9XhMabq!zPFb>7}h60wPg1(qJ!DlqpeCN|5o~cbIwbo%ea~4d1oT_AcES^R$>R
z<}G_DE=IDEVgBqUsW!#8%d68Jk~38IqCe}YXb-9r|Mzg4;0>tI5eK3njzlQFRvHWZ
zyPPzan335ADxn8{SYUo0%m+IFYk{@FG}zg$xmuk#!UxlG);NQbbA-AVB^qpYwfSo+
zQ(lhQ5qmqCK@iK?TI(g5G%^DDz@%HhGk6lq*?3HSt>3?r)(LB|_TF@&Rf;FtC5J2i
zBhfBRlodH}YZp-6WH?^_LKfWGB~;flH^>GkcL(eY`0|_$evC@b3s(EHglZFR&4=nZ
zh>k~yz*o=VS}*(HJxGg)+_Vqr5s~oCZMc#TNB&BVnHJ}Pj2m?&Q=>q$V*)vK4{&+}
z2sv=EoA#?s;h#Re9-5o9CZbRKxA(_=Dy+O%qvvmmr4I{RZ`WUMy!-p|zmG?M04>~Q
A5C8xG

-- 
2.53.0


