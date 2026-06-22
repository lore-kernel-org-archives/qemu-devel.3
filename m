Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF220CD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbVPS-0002kU-GG; Sun, 21 Jun 2026 23:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wbVPO-0002jy-Bn; Sun, 21 Jun 2026 23:33:14 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wbVPM-0000wk-GU; Sun, 21 Jun 2026 23:33:14 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4gkDL42VBrz52SGX;
 Mon, 22 Jun 2026 11:33:00 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl2.zte.com.cn with SMTP id 65M3Wm3M045254;
 Mon, 22 Jun 2026 11:32:48 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp05[null]) by mapi (Zmail) with MAPI id mid12;
 Mon, 22 Jun 2026 11:32:49 +0800 (CST)
X-Zmail-TransId: 2b076a38ace1fbb-3a47d
X-Mailer: Zmail v1.0
Message-ID: <20260622113249376pqkC7XTwda1gb273ExLCp@zte.com.cn>
In-Reply-To: <CAKmqyKP50HjozugAefA20h_m6Dya40ZiVe5rtiJDV+Z2Tvqsew@mail.gmail.com>
References: 20260617063630.111472-1-wang.yechao255@zte.com.cn,
 CAKmqyKP50HjozugAefA20h_m6Dya40ZiVe5rtiJDV+Z2Tvqsew@mail.gmail.com
Date: Mon, 22 Jun 2026 11:32:49 +0800 (CST)
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <alistair23@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu.zevorn@gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdGFyZ2V0L3Jpc2N2L2t2bTogYWRkIGV4dGVuc2lvbnMgYWZ0ZXIgdjcuMS1yYzQgdXBkYXRl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 65M3Wm3M045254
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 22 Jun 2026 11:33:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A38ACEC.001/4gkDL42VBrz52SGX
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

> On Wed, Jun 17, 2026 at 4:39 PM Wang Yechao <wang.yechao255@zte.com..cn> wrote:
> >
> > Expose zilsd, zclsd and zalasr.
> >
> > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

> Can you please rebase this on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> Alistair

Sure, will do. I'll send a new version rebased on that branch.

Regards,
Yechao

