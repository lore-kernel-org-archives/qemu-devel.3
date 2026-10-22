Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1860A4AE0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=quante.one header.i=@quante.one header.a=rsa-sha256 header.s=cloudpit header.b=ESerhM4f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt5Y-0005UE-Vu; Thu, 22 Oct 2026 09:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xJt5U-0005Rx-W7
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:44:09 -0400
Received: from nx76.node02.secure-mailgate.com ([192.162.87.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xJt5R-0004YQ-Bz
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:44:08 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xJt5M-0022iv-5I; Thu, 22 Oct 2026 15:44:01 +0200
Received: from Zeuss.fritz.box (p57b2f06c.dip0.t-ipconnect.de [87.178.240.108])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 20A2A280D9A;
 Thu, 22 Oct 2026 15:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792676639;
 bh=HPMWBytaARWCVzRF7zi+Nx4sM5parwX7zroR+n+QK0M=;
 h=From:To:Cc:Subject:Date:From;
 b=ESerhM4farpSaGdcWJrUScazEYtJ2uKJfZhRNziaph742BPsC5T0ATGasq/fQOCdH
 AoCTZhZVINSzPNG/w4r0WZXFJYNgT4dv3tpZzqfr6+pyhdP52ptIeDlpDRuvQfBHrk
 s6DmLROWFWr+t9vFuecxd/r7oL9rTFROJODKwN34=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 0/2] ui/dbus: send a Scanout before the first Update of a
 new surface
Date: Thu, 22 Oct 2026 15:43:31 +0200
Message-ID: <20261022134335.12241-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179267663980.1250482.2886837813759933113@web279.dogado.net>
X-PPP-Vhost: quante.one
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuW23HfVLO1RDCNYA+3GysBnWo8i8aHah/tj
 qZWpzHyYwSu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4a7jrPrXpTH3kI6IFTGnS9bS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEGvDsoH6Px
 tvFZEJq1ao2KNxVlNYfTDes2/iU+jP6aHfyJo3p7gy1e9++JJPEBLznPyriFfn5NvO42Ap/RDo1K
 7YPxd5oCuPJF4h3COKJnHNz37T4lGe0b3b353enzYMd3uDwFdNb0zYKaG9LRDyHukvvmofBbiY/F
 T4Me+6tl0xTuJA6gXgp/J8AYo4QlDSRs5R65i8wVt7S6RkdWWv/6OD+3oVtoqf1sQ5+Hc5anPk4a
 l0h743VOpKNY+4Mjijih9cFkA1rXqjlzL8TMCQ/eSuoFtAzQY6KmRTFFBaBZrqOQ16G1PbMKvBhj
 phlugR2L8WF2VeyCHG6Wgx/xolPx8v4U33sAF7CQcKjyNBy5EZhMCXGziQTrOqTQXJsob4ddJHFu
 y1HXOootZFA11PrJOUUJWexGgsaaMnPgs8s3EUGWGfzp+G0K0sAtcowVe/dZ+B/zlBbfPMY10/91
 3Q1FpMrKY6l06uyQAjsn4BDA+fXpCTSsxx3gTqU12UMqIHwMiwQzKw+6v3CaIMG6s7LqJEOkmmMd
 ZrnGq6Vnupd3DKRxiKu9zx6DKbyP+C7xLDoUQ6xxLWO25M4AXb5PVu+SoeKCnDSS/wStIOeHyAVA
 nOAHNcfneYQ3wBeSOhOOfRxcO4iKjEv0mfhutvThG1exQK1JS1wPrYDD/ctpiLRIW52JOW16W/8n
 kd0N7tqGJSaCkTqu1tfUeZfgE1XFly2m9udgILM3Fez+btvr1T++7iN+mBa4cVcOYt9AmTHtPiSq
 FgWLTPkUzixfiZut0B5XdbGJDA/yVfT0p3NLgpZnN+JEEqC8fUv8WSQj2T7wOwDa
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.76; envelope-from=christian@quante.one;
 helo=nx76.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Without OpenGL and without shared memory, QEMU does not send a Scanout
to a D-Bus display client when VGA text mode changes its size.  The
client gets only Updates for the rows of the new size, although
ui/dbus-display1.xml says that Update is only called after a Scanout
call.

Patch 1 sends a Scanout of the whole surface at the first update after
a surface switch.  With shared memory, dbus_scanout_map() already does
the same with ScanoutMap.  Patch 2 adds a test case for this to
dbus-display-test.

v1: https://lore.kernel.org/qemu-devel/20261022053535.38791-1-christian@quante.one/

Changes since v1:
- patch 1: clear the flag also when ScanoutMap is sent, and name
  ScanoutMap in the comment on the field (Marc-André Lureau)
- Marc-André Lureau's Reviewed-by carried over to both patches: patch 1
  changes only as he suggested, patch 2 is unchanged
- rebased on current master

Tests with v2, on master 4f4225874d:

 - dbus-display-test: with the series, all six test cases pass.  One of
   them, console/map, waits for a ScanoutMap, so it runs the new line in
   dbus_scanout_map().  With patch 2 alone, the new test case
   text-resize fails ("Update" == "Scanout").  With patch 1 alone, the
   five other test cases pass.

 - I did not run the Windows NT 4.0 test from v1 again.  v2 changes
   only the path with shared memory, and my D-Bus client does not
   implement org.qemu.Display1.Listener.Unix.Map, so for this client
   the code runs as in v1.

 - The Win32 variant of dbus_scanout_map() gets the same line.  I have
   no Windows build here, so it is not compiled.

checkpatch.pl is clean.

Christian Quante (2):
  ui/dbus: send a Scanout before the first Update of a new surface
  tests/qtest/dbus-display-test: check the Scanout after a text resize

 tests/qtest/dbus-display-test.c | 162 +++++++++++++++++++++++++++++---
 ui/dbus-listener.c              |  10 +-
 2 files changed, 157 insertions(+), 15 deletions(-)


base-commit: 4f4225874d4d3747ec1142e935dbd314218992fa
-- 
2.53.0


