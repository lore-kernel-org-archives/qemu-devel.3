Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF550C5B572
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 10:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxjD7-0006ij-OR; Sat, 22 Aug 2026 06:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wxjD5-0006hK-5x; Sat, 22 Aug 2026 06:44:23 -0400
Received: from nx75.node02.secure-mailgate.com ([192.162.87.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wxjD3-0006NY-9Q; Sat, 22 Aug 2026 06:44:22 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wxjCw-002srp-UD; Sat, 22 Aug 2026 12:44:16 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787395454;
 bh=4iKUzZ8DtMto5vrogY09INCc7LP7uZqA44rc3y3vTG0=;
 h=From:To:Cc:Subject:Date:From;
 b=yaQfAWROetSl16ZGtt+uSe7Yr4mjSWo9fcdDU143Cw5k0zRCl9k5H4C8mW3bVi9w9
 cxhDlxVmrTM8/wxsfeRfUCCT5qg5auUEbNKBQQYnsAJTp894o0QCt+3qODUbt77rO2
 fgnivTMKciLMOiIn58OxiR2rc8YOZR6Bf0xPXj78=
Received: from Zeuss.fritz.box (p549f1e64.dip0.t-ipconnect.de [84.159.30.100])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id D3BB3280E03;
 Sat, 22 Aug 2026 12:44:13 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, kwolf@redhat.com,
 Christian Quante <christian@quante.one>
Subject: [PATCH 0/3] tests/qtest/fdc-test: give each test case its own instance
Date: Sat, 22 Aug 2026 12:43:26 +0200
Message-ID: <20260822104329.42121-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178739545444.2525719.1636959312943224215@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVcyI2KyI0TEtSSLm4cv5J2wB+WGecQKkpM
 lk/JtUBLdCu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4bhCrPFhnnLFbL488WVabfBS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99ROIQSXp0prcVkrsJtqLDcOMdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEG9vh2CZ3C
 vkagHub+zVCHrxrAiQ9LrFKjKskiGXdOYifNjAo/oI1KsSlinhiZwSTM7upkSXAQr6kxkmkxKd7E
 gmVz1j4MRe+OdlYkVJrlZi4DrT70dovxC24/X+dx3iVqmCy1HzZEftAXffblb7BEVSsx11W4Bku8
 Nj/Jz1tydce5Z/R2EzvIB0T7JlyqARh7gD7AfsXew/h928fQEfP3Kfs3HYoxZ2A8CL74A8BpRjYl
 hQTOv2jJ/maiR5x2CLV1yrn7Tl2/eGlT3vtT5Q2OCSL3g9ZGqqDl/bOPQLPC3/Z0OGzipjuCk6M8
 f274+Da2Hd4FX9oFmG2ssImpaOB9XT7WPa4F3kdskAP3L0dYRrkBIkUL/j1Y48GvmeURQjjEvx/4
 sa8yVmJ5dSGjbwA/dTyOzZbKfVh1v52vI8Y0fFUtUuZWpYkUidUuXv6uGhCQeBz88ZlqhzmH6uft
 7+t7T3Ji2DeftKOAvi5/VpKfmaaulMf2xZVX1PF0jIKhEOFrbAyeTqRmo8yvsuqp7tk0ZhXEXqw0
 RKuCqvK44RrggSj3Y80OmAux3oN13+ztUzneoLdgui30GBX/jlb5Bz/vlhgZBdfUYxN1da9xu08A
 VGSyoIaYgqW7eDL7DyiyrmKmj55U4O2YZgguZKOy495PAHSFE+BGkBaqg7rMm0ncWoEA78u/BXBt
 xWlNUZZl2CeM9R/2gMGq0KWAzmMf+ibVDjtW4oFmrPO6qPB0S9LHBAFRJpw+dgtb/qY19tnlsdBT
 RUqLoSOUfHTfiAsjKPjs7BqXSHvjdU6ko1j7gyOKOKHJ58WhluI91Ik/GOwz9gprGRUHDfs4TpM6
 tty9Xg7woShbkJHRneTq/3E3yiGCIw8=
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.75; envelope-from=christian@quante.one;
 helo=nx75.node02.secure-mailgate.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The test cases in fdc-test share one QEMU instance and, with it, the
state of the floppy controller.  Several of them only pass in the order
they happen to be registered in: read_no_dma_1, _18 and _19 fail when
run on their own, and fuzz-registers leaves an unacknowledged interrupt
behind, so it works only where it sits today.

This takes up Kevin Wolf's invitation from the review of d00567f7fb and
431f59a34d: "If you feel like addressing the wider ordering problem in
the tests, too, you're welcome to do so."

Patch 1 registers the test cases from a table and runs each one in a
QEMU instance of its own.  No test function changes what it tests; the
three read_no_dma cases insert their own medium instead of inheriting
one, and test_read_id stops ejecting at the end.

Patch 2 skips the test cases when the pc machine is not part of the
build, after 4e37f749dd, 6500a6abe6 and bb98963d6d did the same for
drive_del-test, device-plug-test and pxe-test.  Patch 1 routes every
test case through a single function, so one check covers all of them.

Patch 3 adds a test case that keeps d00567f7fb ("hw/block/fdc: select
the drive named by the READ ID command") from being lost again -- with
one drive, answering for the wrong one cannot be told from answering
for the right one.  It needs a machine with two drives, which is what
the table's args field is for.

Measured on this series:

  * every test case passes on its own; on master three of them fail
  * the suite passes with the registration order reversed; on master it
    aborts in send_seek()
  * removing SET_CUR_DRV() from fdctrl_handle_readid() again turns
    exactly one test case red -- the new one -- and leaves the other
    sixteen green
  * each of the three commits builds and passes on its own

The price is wall-clock time: the fifteen test cases in the table now
start an instance each instead of sharing one, which takes the suite
from 0.78s to 2.8s.  The qtest timeout is 60s.

The pattern is not new here.  Of the 195 files in tests/qtest, 57
register their test cases with qtest_add_data_func() and none uses glib
fixtures; boot-serial-test.c is the closest model, with a table of test
definitions and a shared runner that starts one instance per entry.  72
files still include libqtest-single.h, which is why the test functions
keep reaching their instance through global_qtest instead of carrying a
QTestState around -- that would have touched every one of them.

Christian Quante (3):
  tests/qtest/fdc-test: give each test case its own QEMU instance
  tests/qtest/fdc-test: skip test cases when the 'pc' machine is missing
  tests/qtest/fdc-test: check that READ ID answers for the drive it
    names

 tests/qtest/fdc-test.c | 127 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 107 insertions(+), 20 deletions(-)


base-commit: eea8fe61b8be8f3016e522e6af24924a0266ca95
-- 
2.53.0


