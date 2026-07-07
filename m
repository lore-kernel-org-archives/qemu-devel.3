Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DEEC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh09z-0004PX-9M; Tue, 07 Jul 2026 03:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wh09x-0004Ol-5Y; Tue, 07 Jul 2026 03:24:01 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wh09u-0005pT-Uf; Tue, 07 Jul 2026 03:24:00 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gvXlT4MlYz8Xrrj;
 Tue, 07 Jul 2026 15:23:49 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 6677Na62059025;
 Tue, 7 Jul 2026 15:23:36 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp05[null]) by mapi (Zmail) with MAPI id mid12;
 Tue, 7 Jul 2026 15:23:38 +0800 (CST)
X-Zmail-TransId: 2b076a4ca97a3b1-64497
X-Mailer: Zmail v1.0
Message-ID: <20260707152338744yN4ZfcV8q5Sd9iaKiztV3@zte.com.cn>
In-Reply-To: <CAKmqyKOp_SQkQF4i7BYxdGSPELCTBGymJrHGz4S2pWpvt3JUOw@mail.gmail.com>
References: CAKmqyKMhqavLeDj7fy-JpY8WGKO0m_o+94UMPX2sBK5Ldsid4w@mail.gmail.com,
 202607061406240161qB8UHkhWxKejNM4p23xn@zte.com.cn,
 CAKmqyKOp_SQkQF4i7BYxdGSPELCTBGymJrHGz4S2pWpvt3JUOw@mail.gmail.com
Date: Tue, 7 Jul 2026 15:23:38 +0800 (CST)
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <alistair23@gmail.com>
Cc: <alistair.francis@wdc.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu.zevorn@gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gdGFyZ2V0L3Jpc2N2L2t2bTogYWRkIGV4dGVuc2lvbnMgYWZ0ZXIgdjcuMS1yYzQgdXBkYXRl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6677Na62059025
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 07 Jul 2026 15:23:49 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4CA985.000/4gvXlT4MlYz8Xrrj
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

> >
> > > On Mon, Jun 22, 2026 at 4:59 PM Wang Yechao <wang.yechao255@zte..com..cn> wrote:
> > > >
> > > > Expose zilsd, zclsd and zalasr.
> > > >
> > > > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > > > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Thanks!
> > >
> > > Applied to riscv-to-apply.next
> > >
> > > Alistair
> > >
> >
> > Hi Alistair, could you please confirm if this patch was applied to the
> > riscv-to-apply.next branch? I can't seem to find it.
>
> Oh sorry, it didn't get applied. It doesn't seem to apply to master or
> my branch though, are you able to rebase it
> 
> Alistair

Ok, I'll rebase on the newest branch riscv-to-apply.next and resend this patch.

Regards,
Yechao

