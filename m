Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CE0C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 13:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA770-0007cd-6H; Wed, 30 Apr 2025 09:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steffen_hirschmann@web.de>)
 id 1uA5AP-0005Y9-EL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:59:54 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steffen_hirschmann@web.de>)
 id 1uA5AM-00065L-IG
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1746010778; x=1746615578;
 i=steffen_hirschmann@web.de;
 bh=fFNNTcYnsIOHQKytBfD9qaSrFHlEEA4BlvaoH9oniEU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GDMMko7m05xUidpqQeiQGIzh7X68Xj59i7ly3kRfyRhfvi8gedU7gQry80G7ACvH
 5nD23c1btP+4DtFd8iyAWkO0F6cvXlI5LW09kAsXyRFT+S2uQ2otmdzH9e9tEct21
 ujfWa419AJyHsfDE0EYz9fH483071p4uw7vyenWvCGOKGKHsNlVyDwgt66gOHKXDd
 Um9/refYO367ekppkNygb814oRCeT3ktswozLQ+gVDB125JoGLxHLcbEMiSUYqtUr
 iH7tibM/fMdM7vdRe8x+jRnpBCt45WYiO8uUTCH73z1EnwFTju8nwdNzkyKPB0AVv
 xy4I042vWDFH12Xevg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([87.123.246.30]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkEhH-1uujel2JtR-00nXhl; Wed, 30
 Apr 2025 12:59:38 +0200
From: steffen_hirschmann@web.de
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Steffen Hirschmann <steffen_hirschmann@web.de>
Subject: [PATCH RFC 0/1] TCG plugin libinso.so: Virtual address range count
Date: Wed, 30 Apr 2025 12:59:36 +0200
Message-Id: <20250430105937.191814-1-steffen_hirschmann@web.de>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1u/YlfFMiJXqKhTy5UtoaBMDo4LcObrB32/EVIx81Z4FP5Uw4WC
 sUOxHEyq8JW3JtMdbEtpyqTtTajwtPLS2zm3P0stZSmkRYckruJUHfHi7B9Y0u6dghW2eBY
 ukZl1fLomMeTyq6M2Wb/5qtQkz0PKQ9oJ69y6jx8CaohVe1k+xFPA+RFHEjDNJPIVdtJJVD
 +mX2RHRYakz4AX5ZzNuhg==
UI-OutboundReport: notjunk:1;M01:P0:zQW4V/iwU5M=;ykLoPYJ9/Higx6qNyCmkXxxjjFX
 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
Received-SPF: pass client-ip=212.227.17.11;
 envelope-from=steffen_hirschmann@web.de; helo=mout.web.de
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Apr 2025 09:04:26 -0400
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

From: Steffen Hirschmann <steffen_hirschmann@web.de>

I found it useful for the TCG plugin insn.c to be able to count only
instructions in a certain virtual address range (e.g. single leaf function=
). It
could be of interest to a broader audience, thus I am RFCing it here.


Steffen Hirschmann (1):
  TCG insn.c: Implement counting specific addresses

 docs/about/emulation.rst |  2 +
 tests/tcg/plugins/insn.c | 89 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

=2D-=20
2.39.5


