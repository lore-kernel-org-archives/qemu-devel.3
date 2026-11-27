Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42694606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vivier.eu header.i=laurent@vivier.eu header.a=rsa-sha256 header.s=s1-ionos header.b=GM4U0E4Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtIi-0006lx-C4; Fri, 27 Nov 2026 05:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1xWtIg-0006l7-HX
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:35:30 -0500
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1xWtIe-0008CU-D2
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:35:29 -0500
DKIM2-Signature: i=1; m=1; t=1795775724; mf=PGxhdXJlbnRAdml2aWVyLmV1Pg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=vivier.eu;
 s=s1-ionos:rsa-sha256:nUZxvG1tQm+k5v7Iv8SXsNt32xgU
 vb/dk+5Gi3F6NhXBePzyh0RrKD4pfCPUz6hIz9ltDxBkmHDSPNdendOHxNznYUqfD96YMry6J4L
 LPBmCsGAxWlWrc4nyj7q7+Oe0KzdOVwyZF+5+1cWoO4EoUq31d4FYCsfsW4Z7c9F2oz3BLcYsXq
 SjSn925EWwfSl6oaorW0gC4w2FCtBlyEIJgEOMlm0aNAMHv15a34NMlE7v06D9SSCKI/jTCCIov
 kyq3+x8N8HQCzOBQcrs37ZX+LjehboO+jVV4w8fJcNJUqRdYdX1lU6Lbo5O7TmO/lN/E4jN/Zfm
 DbUqBY3DmbJUTg==;
Message-Instance: m=1; h=sha256: T3ET2D6SutA4VoSN0KcOq0UaMVGVNGL9Vy3lZU5faJ4=:
 pWkq94duaxEfWNnmAHZ9roEhdh9L6JwYwLRBW7gX4Mw=, sha512:
 XmzHYXOpuul0xcbEwrUBXKh0JSFCUDuCXrIHopioAZ3atuMQNfzvUPvUG4Iy1cmYVak9+ezh7k6uDTrNyBy7NQ==:
 5Eg/6OR914OkwbBL43P5C/W+qrUnacVzy6T8cUfmncc3lonsERC4dUu8xUw9vMioW4Y2KLBKExJ7tsxj0rJVoQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1795775724; x=1796380524; i=laurent@vivier.eu;
 bh=49rE2D02adOfkbMhzZD2MPeOGn95ua5ePwFgus+iO+0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GM4U0E4ZWVIraXfIUpqfrwZNOpB4RaKUuisQ7u5vfjO1ot9I807ekmbFJ+COpQ43
 137M7EoHUBBL1TOAzRtRI8WTN5ZBVhcbWZHhSKOA5ICPcJJ033moWffSMCg5QPiV0
 maUbbIxdhuXnrkM521kxPS6nOpUleARBg1z7koNt6tE94nLUyjXVsGIh1gzChPqo9
 C/oZAgfklEws7VyKOm/aZCgBXe9MvhHiSFCaX09latAL/6oFpyInlrLwQScWyHIzY
 HFdYBcnz4/vKv1FGiqpy6ZMdgGGW9aR5nuR/wTnKDcIoL4sYAHZZhds23sU+3qT15
 jgSefggIrhE/f8kOEQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MgeXk-1y9Um02uBY-00ordR; Fri, 27
 Nov 2026 11:35:24 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 1/1] hw/char/goldfish_tty: Fix signed data length
Date: Fri, 27 Nov 2026 11:35:07 +0100
Message-ID: <20261127103507.382826-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127103507.382826-1-laurent@vivier.eu>
References: <20261127103507.382826-1-laurent@vivier.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8IJ74n/Ta6W0Wyl7JdHzHDCsbzExG9EW6u8TqqWKYIQyaS1VJ3y
 Uazfc9A+1FCG4r4ly8ZeAJHlUXfSYOZ19ydDCzRcxPC06/lAgpz8v+MwFhQWuiT9GK4q6kp
 4Qe/VUiwZNsnEd2Uz6ACi/E9tVJQ0JwG6bHSFeUfMlTdriDaommPfcxWJPaTfLl/ZZDnG2m
 FeafOOVwRVJMMdlFgqeGQ==
UI-OutboundReport: notjunk:1;M01:P0:PLMMBbhN3wo=;cs94dl0IOXsCFNp43ZHygZGBk7K
 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
Received-SPF: pass client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The guest-controlled data_len register is uint32_t, but was copied into
a signed int. A value of 0xffffffff consequently became -1, allowing the
DMA transfer size to exceed the 128-byte stack buffer.

Use an unsigned length variable so that each transfer remains bounded by
GOLFISH_TTY_BUFFER_SIZE.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4245
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20260827174403.610834-1-laurent@vivier.eu>
=2D--
 hw/char/goldfish_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index 8e1e9228c78b..f64527f50a02 100644
=2D-- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -71,7 +71,7 @@ static void goldfish_tty_cmd(GoldfishTTYState *s, uint32=
_t cmd)
 {
     uint32_t to_copy;
     uint8_t data_out[GOLFISH_TTY_BUFFER_SIZE];
-    int len;
+    unsigned int len;
     uint64_t ptr;
=20
     switch (cmd) {
=2D-=20
2.56.0


