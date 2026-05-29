Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AECCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57u-0006Iu-AJ; Fri, 29 May 2026 17:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57s-0006IN-Hv; Fri, 29 May 2026 17:52:20 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57q-0007e1-EV; Fri, 29 May 2026 17:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091510; x=1780696310; i=deller@gmx.de;
 bh=2kWHhFJsKil/MBmltZHcnFnWPWZcJOCCukMWNZUBUg4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=kWaFQT1vEaIBVkcnmcVZ/85FrYAroBKJ3sE/6TUVjfxaY6AvPxp9JJ8We39YUEEg
 h2Gzjl6HKP2MZzcmUZZRUqe/FRTY4cSe3Lcr6/wtA5EsIjMTOFTqvfoR0Edxz7arS
 Knh+MbqkjDtwdjr21CHUqc5DWrIhVBdnIM0dYjmwgY6MS3fB0WbQ6HRNiUZFzcfrx
 9TdpB6BoYyFp6PfJj950MicoE/jitTpTsvc4UYPA6nPdSlVvZIWK6zyI5NktEmlQR
 JedUgsGYOhDoITuwgigLwjaksTtMcoRt5Ws9b1v5wUmkVjY0vTOcsLN0qdaJsrYs7
 rosXrUNyE2l61vnXkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhjF-1xFyho3esr-00t6xO; Fri, 29
 May 2026 23:51:50 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v3 08/10] linux-user: Fix typo in function documentation for
 pgb_addr_set()
Date: Fri, 29 May 2026 23:51:17 +0200
Message-ID: <20260529215119.73244-9-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a+4ONGIwqZzT22gYR9lvgNj40MnVWgMr/NobWboDX28Xs5o0fl/
 mDFRmECOxi+8v0oPXrSKCN9V+YUsxKkSLFLS2tUL2ZCOECBGOMG45W6CY9/U9Krgujig6XD
 l3Mbuc/IZxm/HcvVCoOJsgH3oU/gDVZq8HLuqcQvgR8+8Uc+Y/3kQdH9qv2cjMZncNqBYiz
 HMYWpJg3aQ76vFPejSlVw==
UI-OutboundReport: notjunk:1;M01:P0:bLSWrpFPqXs=;KF+cRH2l2qkDthbrGi+vH9N9S/x
 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
 XuEr8RYU0gW+E+Iy7s=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The third parameter is called guest_hiaddr.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0e757787d2..f7625c0952 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -848,7 +848,7 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga, uintp=
tr_t base, uintptr_t brk)
  * pgb_addr_set:
  * @ga: output set of guest addrs
  * @guest_loaddr: guest image low address
- * @guest_loaddr: guest image high address
+ * @guest_hiaddr: guest image high address
  * @identity: create for identity mapping
  *
  * Fill in @ga with the image, COMMPAGE and NULL page.
=2D-=20
2.54.0


