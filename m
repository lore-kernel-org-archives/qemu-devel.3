Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771D606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ilyxFHLU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqUR-0003cS-KA; Thu, 22 Oct 2026 06:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUO-0003Xy-6D
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUM-0001b4-Jz
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5kGCfHgCc/S1Rz9fYcpiHxYbGcs/KHHbdcereSG2Es=;
 b=ilyxFHLUWF2DI2LY3P+9sIWIonr0KXvk19Rf/IzwCt/wnTwayNQKcRlwypMV3oOQ1yr8wP
 hE6a/rZDSOVkAjb6KDbMzRdt0d13jP5WmsAzVsykJgy3L70UI+ATP2FplI1PKEftpavMlK
 HRQ/CgFQ2z9fyaOxTdb8iWvJ5Qjs+Wc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-H1njEnGOOvq6-vtbq_ELPg-1; Thu,
 22 Oct 2026 06:57:32 -0400
X-MC-Unique: H1njEnGOOvq6-vtbq_ELPg-1
X-Mimecast-MFC-AGG-ID: H1njEnGOOvq6-vtbq_ELPg_1792666649
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66CB21956059; Thu, 22 Oct 2026 10:57:29 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8178B195608C; Thu, 22 Oct 2026 10:57:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:39 +0400
Subject: [PATCH v3 12/18] MAINTAINERS: cover m68k GDB XML files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-12-7ad902b9a7cf@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=591;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0bstKJJsgi1FPZ/zGf2Unp0q0dU4pENa2SLvxQB9r3U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evmRtRuCyn0MHU6YsmrHO4Is30Yzuhg4tKib
 D4ylSfs6uSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5gAKCRDa6OEJdZac
 5fLmEACnVBklFtmi51tAvAdFqTvyjmtWV3IbHcJ9QJKJtksQ7Xd1/xBAE88d2MdNOWGAHiGX7dL
 v5FBziRa30KymELgMeakaLYHPjzcmaK8X2yr8igWtGhZhjAl3Ki/g7GnheqljMhninEwbn4+qUk
 qkFjN+xmD2Rn4XJStNOJBqd1/wJRlb0LQ14CgqyDvazCqalY+abKtfUIZG8u0ibmZvJ0ZsfIjUe
 ONsJJZFNKeYX6Ycv+INY/D+csyZVlufXGct7GDXcZJZ5B13dk69xdpkSxD2ERpfkRI5IPrF2ye3
 sIthercEyZS7tl7nuAwk5V3NehedpcfKqQ9kKkyEL582SC8NXjnzp2z7omnkarvS498/zsyEJFf
 WkDpVtoe8WHvoDT2IYftwgMuucJJLwGEdYJH8t6Ec9pYbUnz5nnai/Mh5AaP9ImXhcmC1uXFN5N
 K7upVxNULAPhTJlhSuBujP3MGD88GS20bBc7h5Q5QjmqzRid+NbI9vrJ9R3HZIJuMCmDiiPBWo6
 SpHH99Zkm2wAa446QkMxI5fF1Quo7BbLCM5URZRgxzzOFJ7AUs8BwMFbxLV8DdKEnbf0lkglSL1
 mJDrPaIKM5Q+er/wtlr2fBawqQgcv3w6x/dNHpKaw7/LnDScAKkfZkOGNMFS5BLBaSwJeLz5E4M
 5YY5tuwxB0vtIdQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add entries so changes to these files are routed to the m68k
maintainers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f22333fbf177..de3cb9dcaf25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -303,6 +303,8 @@ M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: target/m68k/
 F: disas/m68k.c
+F: gdbstub/gdb-xml/cf*.xml
+F: gdbstub/gdb-xml/m68k*.xml
 F: tests/functional/m68k/meson.build
 F: tests/tcg/m68k/
 

-- 
2.56.0.116.g6de20f6092dc


