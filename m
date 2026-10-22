Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D16606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYvYZA1f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqUe-0003s0-AJ; Thu, 22 Oct 2026 06:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUc-0003nA-I3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUa-0001dX-RL
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/boa/0bybGQV/iXPiDfMXlzkaZu6kj8Rk1U0VSoXz4=;
 b=DYvYZA1fYikHKUldiwDizuW0VV1Y8dQCw1EysWYgcnIGWrMWYbt2jop0NX1uIOIz+8Doo8
 ibr7cM0GF/iTVnbVKF51XK2ahscu6SJjwwQqZ7DUucsaH6kqnujwF6lbzXf6hcuj4yWhk+
 EiSY2y7TNY/bn+MX2IxfgbDbGBEFHXA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-x72QyshONIOzPf84JcEyGA-1; Thu,
 22 Oct 2026 06:57:47 -0400
X-MC-Unique: x72QyshONIOzPf84JcEyGA-1
X-Mimecast-MFC-AGG-ID: x72QyshONIOzPf84JcEyGA_1792666664
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 262A91955F4A; Thu, 22 Oct 2026 10:57:44 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17D161800480; Thu, 22 Oct 2026 10:57:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:43 +0400
Subject: [PATCH v3 16/18] MAINTAINERS: cover riscv GDB XML files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-16-7ad902b9a7cf@redhat.com>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
In-Reply-To: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=583;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NUVaSOrO08iwQWHDySrfqb6/dQfv1iAP+uKUvVESKFQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evm0DUE4z6Ujguc0rtSeKkMPIOAnzHb4GKVo
 UgckN68EbOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5gAKCRDa6OEJdZac
 5YhbD/95jB4tThjTO104nf3kOeN0Gxw+mw044y8zXldEe4kbNLkbno5XnwmAShhXm8SNSRzIW2W
 UNZZkSQjKW1fMeTZw9nSiGs8vJgtt07fqcf3GIOT1OlSXRcufphLXH4FCKWj7H9eOU77C0OlqOw
 gQZ0U99OPSGc4U+euWdqctGXTQA4Re74J9pDWT7mAqY/51X1h5u8Yt13XQd/VX55TMTIYhw5v+n
 LIIrsW/gdTBvpHKUq+3SKeBf7REnDAKmqoPKgzS+mqxDegTVGlf3tKzQCi6yNZov988b05jypPG
 Lc2BTvFXzUBbGko9U2tQX8kS13dDgUPTYpVgH9+/A5S/UZUUH6BqU+GetAifu0QVtINM8JN3zz9
 fSph29qcqPiuFM81q2bV70uE6sMQBXR0lPqN0JfCBpo8ag3JCTBJ0iQ9NlNeNRbjFoAT+CQC8Fo
 +1KIbeKi+IxEKisAw0L7mZ5ce302DL8HSSVylZhgYoD6nyeNeKKY+6/loG0uF+iAKcr1Ps7j7yo
 LXxoXJymhBz31CO8DpbhEqpGPLvvdTdGFFYGDOI8CT9vuEKm+/haLvkz2f7Zu+VKTpXoIXoqQRv
 GLSf6El2TwW+AaqkE4842uCCggb7Jj+V8w8tM+D8IJXfJ3WVLSr8V8aBAsaKcqUZ0ipD4Sl7pgc
 8Gw16zA+XQwEQsQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an entry so changes to these files are routed to the RISC-V
maintainers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index de3cb9dcaf25..010539dd3588 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -372,6 +372,7 @@ F: configs/targets/riscv*
 F: docs/system/target-riscv.rst
 F: docs/specs/riscv-iommu.rst
 F: target/riscv/
+F: gdbstub/gdb-xml/riscv*.xml
 F: hw/char/riscv_htif.c
 F: hw/riscv/
 F: hw/intc/riscv*

-- 
2.56.0.116.g6de20f6092dc


