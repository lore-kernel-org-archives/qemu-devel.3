Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A5FEF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 06:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voxpa-0000P7-NR; Sun, 08 Feb 2026 00:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1voxpV-0000NY-6a
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 00:59:33 -0500
Received: from mail-244119.protonmail.ch ([109.224.244.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1voxpT-0007UH-IB
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 00:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail3; t=1770530367; x=1770789567;
 bh=5U0l3wVgWK9kNowZyYZcgvlLBninOUWPPo60jfcc9Hc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LnbX9+mS7ecERMFcTXRyip7JSRx+9K1RHp9B8vohJdOrCMFewXX4PFlkycalcKjvl
 vkIsems5AqtebLmil33B2hG0PrEdgV51Ctbc/lbq1gaKZLgCxoM9AgXiRvaelX5NkO
 17RhLEaDs+hohPoLhWVuAN/ph/Gcssg4AU2OLqdd2jrRkWjYZEzVbSpwmTY9SiuudV
 TOWsAkqXKoRcIymtXx+eGC3cmjYgTNjwPGEFsSC0YQ/t5ErioDsuM59wSzzKDo2q9Q
 1IcWH8Tph2BIIeg2pqJcZFE5x/y5o+VKV7x199XXLP5jSZPsoVu+L9ZcYCu9OPoGVx
 C/HeAUp/974Gg==
Date: Sun, 08 Feb 2026 05:59:25 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 pbonzini@redhat.com, stefanb@linux.ibm.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v5 2/5 qemu] Add GNU/Hurd host_os=gnu
Message-ID: <20260208055858.2166524-3-damien@zamaudio.com>
In-Reply-To: <20260208055858.2166524-1-damien@zamaudio.com>
References: <20260208055858.2166524-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: c14d17e0ecbdc099b1b659c4c8f9349a095ac505
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=109.224.244.119; envelope-from=damien@zamaudio.com;
 helo=mail-244119.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index 4b61fd3bbf..fae4d06352 100755
--- a/configure
+++ b/configure
@@ -372,6 +372,8 @@ elif check_define __APPLE__; then
 elif check_define EMSCRIPTEN ; then
   host_os=3Demscripten
   cross_compile=3D"yes"
+elif check_define __GNU__; then
+  host_os=3Dgnu
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
--=20
2.51.0



