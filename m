Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8566DE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJaiW-0005CB-Hx; Fri, 06 Dec 2024 10:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tJaiU-0005Bk-Ig
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:58:06 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tJaiR-0005vA-W7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=yvv1PK3bh/vccs2Dg3KochfdXI2iN9gTUIWGYlhQ09s=; b=V9Ra4J76D1WzNOy
 TJYGvWefyIBZ93Upk/OldLl8lGibWgBKA7sWaMvss/33HUnsCuWb69SXNbpsxmtoAIg2Edk8+otvJ
 MOfYN7XWTQ2XU4d8BiB3EIogtFluj//fvY7ZFMlCT/qOgjENX5uylpyxL/cmUuWk+Da+UdPJVH9fJ
 mU=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	ltaylorsimpson@gmail.com,
	brian.cain@oss.qualcomm.com
Subject: [PATCH 0/2] Misc Hexagon QOL
Date: Fri,  6 Dec 2024 17:01:01 +0100
Message-ID: <20241206160103.24988-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Separate submission of patches 35 and 37 from the helper-to-tcg
patchset:

  https://lore.kernel.org/qemu-devel/20241121014947.18666-1-anjo@rev.ng/

Anton Johansson (2):
  target/hexagon: Use argparse in all python scripts
  target/hexagon: Make HVX vector args. restrict *

 target/hexagon/gen_analyze_funcs.py     |  6 +++--
 target/hexagon/gen_decodetree.py        | 19 ++++++++++---
 target/hexagon/gen_helper_funcs.py      |  7 ++---
 target/hexagon/gen_helper_protos.py     |  7 ++---
 target/hexagon/gen_idef_parser_funcs.py | 11 ++++++--
 target/hexagon/gen_op_attribs.py        | 11 ++++++--
 target/hexagon/gen_opcodes_def.py       | 11 ++++++--
 target/hexagon/gen_printinsn.py         | 11 ++++++--
 target/hexagon/gen_tcg_func_table.py    | 11 ++++++--
 target/hexagon/gen_tcg_funcs.py         |  9 ++++---
 target/hexagon/gen_trans_funcs.py       | 18 ++++++++++---
 target/hexagon/hex_common.py            | 33 +++++++++++------------
 target/hexagon/meson.build              |  2 +-
 target/hexagon/mmvec/macros.h           | 36 ++++++++++++-------------
 14 files changed, 127 insertions(+), 65 deletions(-)

-- 
2.45.2


