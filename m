Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746E5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgcTj-0003GR-Ba; Mon, 06 Jul 2026 02:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wgcTh-0003Eu-7Q; Mon, 06 Jul 2026 02:06:49 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wgcTc-0006Qd-Bw; Mon, 06 Jul 2026 02:06:48 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gtv4n3b9hz8XrrZ;
 Mon, 06 Jul 2026 14:06:33 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl1.zte.com.cn with SMTP id 66666MAR059389;
 Mon, 6 Jul 2026 14:06:22 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp03[null]) by mapi (Zmail) with MAPI id mid12;
 Mon, 6 Jul 2026 14:06:24 +0800 (CST)
X-Zmail-TransId: 2b056a4b45e0e54-7f916
X-Mailer: Zmail v1.0
Message-ID: <202607061406240161qB8UHkhWxKejNM4p23xn@zte.com.cn>
In-Reply-To: <CAKmqyKMhqavLeDj7fy-JpY8WGKO0m_o+94UMPX2sBK5Ldsid4w@mail.gmail.com>
References: 20260622065717.15386-1-wang.yechao255@zte.com.cn,
 CAKmqyKMhqavLeDj7fy-JpY8WGKO0m_o+94UMPX2sBK5Ldsid4w@mail.gmail.com
Date: Mon, 6 Jul 2026 14:06:24 +0800 (CST)
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
X-MAIL: mse-fl1.zte.com.cn 66666MAR059389
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 06 Jul 2026 14:06:33 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4B45E9.001/4gtv4n3b9hz8XrrZ
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

> On Mon, Jun 22, 2026 at 4:59 PM Wang Yechao <wang.yechao255@zte.com..cn> wrote:
> >
> > Expose zilsd, zclsd and zalasr.
> >
> > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
>
> Thanks!
>
> Applied to riscv-to-apply.next
>
> Alistair
>

Hi Alistair, could you please confirm if this patch was applied to the 
riscv-to-apply.next branch? I can't seem to find it.

Regards,
Yechao
>
> > ---
> > Changes in v2:
> > - Rebase on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> >
> > ---
> >  target/riscv/kvm/kvm-cpu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index f0de5c3071..707b992d55 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -304,10 +304,13 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
> >      KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL),
> >      KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
> >      KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
> > +    KVM_EXT_CFG("zilsd", ext_zilsd, KVM_RISCV_ISA_EXT_ZILSD),
> >      KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
> >      KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
> > +    KVM_EXT_CFG("zclsd", ext_zclsd, KVM_RISCV_ISA_EXT_ZCLSD),
> >      KVM_EXT_CFG("zabha", ext_zabha, KVM_RISCV_ISA_EXT_ZABHA),
> >      KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
> > +    KVM_EXT_CFG("zalasr", ext_zalasr, KVM_RISCV_ISA_EXT_ZALASR),
> >      KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
> >      KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
> >      KVM_EXT_CFG("zfbfmin", ext_zfbfmin, KVM_RISCV_ISA_EXT_ZFBFMIN),
> > --
> > 2.43.5

