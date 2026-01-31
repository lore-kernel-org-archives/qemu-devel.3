Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9878FE6BF3C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0Ta-0007Aw-Ik; Fri, 30 Jan 2026 21:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vm0T5-0006hF-OV
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:12:11 -0500
Received: from mail-106117.protonmail.ch ([79.135.106.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vm0T1-00026G-9t
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail2; t=1769825522; x=1770084722;
 bh=5U0l3wVgWK9kNowZyYZcgvlLBninOUWPPo60jfcc9Hc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=bt+jIQ3y+ucXqSAkjrzEampZeid38uSY8JTk86lqwGVCMn3r/VNgObEaj8XjJ0dGv
 K0+cDKImzV9wo79GLhDPLdkWxg3Wtz0mbnIZaZA1hY8DwRafoM+nndNNQquMskpj0W
 m4kbUjizgXA88k4t/bYbT9X/EHI3H4LdYEuVTrZkRoJfjIOIsZFvRGktJHO5fd9H4x
 x+Bly1j1A3BWsbrkWT/A3FZhYR59JUoB/VySrOWM0gbYAXXqukMufyjMW0KyjRv85U
 2c/oNYwnnPRdGvy+nj2IHCrBGzIlWcYFtq3u68sMDsyrXgxbXjnbDwvyUplDrSktBA
 m5v33GHQ2AU3Q==
Date: Sat, 31 Jan 2026 02:11:58 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 pbonzini@redhat.com, stefanb@linux.ibm.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v4 2/5 qemu] Add GNU/Hurd host_os=gnu
Message-ID: <20260131021116.1717230-3-damien@zamaudio.com>
In-Reply-To: <20260131021116.1717230-1-damien@zamaudio.com>
References: <20260131021116.1717230-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: b7dbf1bd7058a82e960822b2a2df847c0df01e0b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.117; envelope-from=damien@zamaudio.com;
 helo=mail-106117.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



