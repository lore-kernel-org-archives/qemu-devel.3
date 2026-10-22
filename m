Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD3606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=quante.one header.i=@quante.one header.a=rsa-sha256 header.s=cloudpit header.b=0CHiQ+SH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJlTS-00040i-16; Thu, 22 Oct 2026 01:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xJlTL-0003zH-8v
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 01:36:15 -0400
Received: from nx230.node02.secure-mailgate.com ([192.162.87.230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xJlTI-0005ma-HJ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 01:36:14 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xJlTC-00DCe0-77; Thu, 22 Oct 2026 07:36:07 +0200
Received: from Zeuss.fritz.box (p57b2f06c.dip0.t-ipconnect.de [87.178.240.108])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id EC3B9281065;
 Thu, 22 Oct 2026 07:36:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792647365;
 bh=JJPNxpCKIumSkEloS+zHttRgStXkWDm23StdAIf8V0Y=;
 h=From:To:Cc:Subject:Date:From;
 b=0CHiQ+SHYhmcQvwlYgncoCcVtXAkpAK/+XoQkcqSi6PrpDumB4rKO17INdEBdqC5N
 o7rPaKwmZ+DSPAs0p/0+WEtjy2PnCXgJ1bFvyy5jqPTg/2zeclcvwDNYEgbtgJGs5/
 fq/gnIOWe7c4attoAaJ3amafE9GCWGVgU+owhMHs=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/2] ui/dbus: send a Scanout before the first Update of a new
 surface
Date: Thu, 22 Oct 2026 07:35:31 +0200
Message-ID: <20261022053535.38791-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179264736561.2629088.4714787979025200756@web279.dogado.net>
X-PPP-Vhost: quante.one
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuWpNubh3cIiLEZrh2gEDfVZwA0HHB6wBGn4
 1eBw+I+qBSu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4bfb3Wpfl0YrDETFFUhZByyS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEGvDsoH6Px
 tvFZEJq1ao2KNxVlNYfTDes2/iU+jP6aHfyJo3p7gy1e9++JJPEBLznPyriFfn5NvO42Ap/RDo1K
 7YPxd5oCuPJF4h3COKJnHNz37T4lGe0b3b353enzYMd3uDwFdNb0zYKaG9LRDyHukvvmofBbiY/F
 T4Me+6tl0xTuJA6gXgp/J8AYo4QlDSRs5R65i8wVt7S6RkdWWv/6OD+3oVtoqf1sQ5+Hc5anPk4a
 l0h743VOpKNY+4Mjijih9cFkA1rXqjlzL8TMCQ/eSuoFtAzQY6KmRTFFBaBZrqOQ16G1PbMKvBhj
 phlugR2L8WF2VeyCHG6Wgx/xolPx8v4U33sAF7CQcKjyNBy5EZhMCXGziQTrOqTQXJsob4ddSzLc
 /sOfcvtALEqg2NN0r0UJWexGgsaaMnPgs8s3EUGWGfzp+G0K0sAtcowVe/dZ+B/zlBbfPMY10/91
 3Q1FpMrKY6l06uyQAjsn4BDA+fXpCTSsxx3gTqU12UMqIHwMiwQzKw+6v3CaIMG6s7LqJEOkmmMd
 ZrnGq6Vnupd3DKRxiKu9zx6DKbyP+C7xLDoUtfHGLcDl0ufvgDlI/XQJMfkLj3oRzQd1kj7M87C0
 PsgHNcfneYQ3wBeSOhOOfRxcO4iKjEv0mfhutvThG1exQK1JS1wPrYDD/ctpiLRIW52JOW16W/8n
 kd0N7tqGJSaCkTqu1tfUeZfgE1XFly2m9udgILM3Fez+btvr1T++7iN+mBa4cVcOYt9AmTHtPiSq
 FgWLTPkUzixfiZut0B5XdbGJDA/yVfT0p3NLgpZnN+JEEqC8fUv8WSQj2T7wOwDa
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.230; envelope-from=christian@quante.one;
 helo=nx230.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Tests, each with QEMU master (8967b2fe1b) and with the patches:

 - The text mode setup of Windows NT 4.0 Workstation (German CD) with
   cirrus-vga and TCG, and a D-Bus display client of my own (not
   public).  This client follows the Width and Height properties of the
   Console, and its new buffer starts black when they change.  Every 3
   seconds, I saved its picture and a screendump, and compared them.
   After about 21 seconds, the setup changes from 720x400 to 720x396.
   In the pictures from 3 seconds after the change to the end of the
   run:

     master    177660 and 83700 of the 285120 pixels (two runs) are
               black in the client, where the screendump shows the
               blue background.  The client got no Scanout of 720x396.
     patches   The picture of the client is the same as the screendump
               (one run).  The client got a Scanout of 720x396.

 - dbus-display-test: with the series, all six test cases pass.  With
   patch 2 alone on master, the new test case text-resize fails
   ("Update" == "Scanout").  With patch 1 alone, the five other test
   cases pass.

checkpatch.pl is clean.

Christian Quante (2):
  ui/dbus: send a Scanout before the first Update of a new surface
  tests/qtest/dbus-display-test: check the Scanout after a text resize

 tests/qtest/dbus-display-test.c | 162 +++++++++++++++++++++++++++++---
 ui/dbus-listener.c              |   8 +-
 2 files changed, 155 insertions(+), 15 deletions(-)

-- 
2.53.0


