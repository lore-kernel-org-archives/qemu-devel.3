Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3E8CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjE3-00032D-D9; Thu, 28 May 2026 18:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjE1-0002zz-Ir; Thu, 28 May 2026 18:29:13 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDz-0006yW-T8; Thu, 28 May 2026 18:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007334; x=1780612134; i=deller@gmx.de;
 bh=2kWHhFJsKil/MBmltZHcnFnWPWZcJOCCukMWNZUBUg4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GDNZ3A5+/YmMn4+C/DHYQOq3TAlFXp96Z+1EqJL5IWmFHgIw6JtGiNP8OWikvLU1
 dl8X+2LMqV0CRq3n7EZkZZ0mWz+fhwP/9N4yKJPuoHkCBvd1gGu0becFOabynCtf7
 QbveqpPU0THAucckiD2pZwxvbAXNJDs9MUr4jzIWQHUpV1mhcincAiSGqIsy7m1w7
 GZm/KK/BCVDR/Z+GdSLQ8SVWkHKRBkfQmrMbdCmWimoMzAiFgOkJekkmWSmx7Qc58
 H6Ee/em3ajC1fO9GTWar6imDb9WFpVsO+5jU+dTVjgPzXoSow2CxrnyYrI4GSC1dH
 9wpvq7qYvYG2GHXFKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1wPAij1jgx-002vwD; Fri, 29
 May 2026 00:28:54 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 08/10] linux-user: Fix typo in function documentation for
 pgb_addr_set()
Date: Fri, 29 May 2026 02:25:45 +0200
Message-ID: <20260529002548.19293-9-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529002548.19293-1-deller@gmx.de>
References: <20260529002548.19293-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m417ZrPkADHA+t1aUGaTs4oyhCAr0D14mfhJot7A51wMqfX33gM
 FbYOV25wu/IssLU/E6fY7mMzRs8R06CVm1V/dl0vLXtBxpiIB+JuVNjsmUB4r3z9Mp25nAO
 OhaXMQvTNwU5OqOtDjbWIvy+dvNqa7yKax8BibWdPZZLhkpfigOoCDBbiKFg0eNXGSCbMGA
 cmbVOf2dAKQUFNqfp3XUw==
UI-OutboundReport: notjunk:1;M01:P0:/p0Dig6R6Co=;uqs1WYlmvk1wnsqvWtPR3vja/ER
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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


