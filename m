Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F656606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 01:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJhVA-0001oc-5T; Wed, 21 Oct 2026 21:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xJhUz-0001oC-Sn; Wed, 21 Oct 2026 21:21:42 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xJhUx-0006fB-Du; Wed, 21 Oct 2026 21:21:41 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j97f11TXgz8XrrZ;
 Thu, 22 Oct 2026 09:21:29 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl2.zte.com.cn with SMTP id 69M1LOtf042429;
 Thu, 22 Oct 2026 09:21:24 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Thu, 22 Oct 2026 09:21:25 +0800
X-Zmail-TransId: 3e816ad96515026-153c3
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: daniel.barboza@oss.qualcomm.com
Cc: alistair.francis@wdc.com, chao.liu@processmission.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 wang.yechao255@zte.com.cn, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 3/3] target/riscv: Add SBI STA state to vmstate
Date: Thu, 22 Oct 2026 09:20:09 +0800
Message-ID: <20261022012022.433289-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <91d62753-5841-456b-9869-32b73a0ecbcc@oss.qualcomm.com>
References: <91d62753-5841-456b-9869-32b73a0ecbcc@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69M1LOtf042429
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 22 Oct 2026 09:21:29 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD96519.001/4j97f11TXgz8XrrZ
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> On 10/17/2026 11:51 AM, Wang Yechao wrote:
> > Save and restore the KVM SBI state as a vmstate subsection, so that
> > a guest using SBI STA keeps working after live migration. Only the
> > STA shmem address (shmem_lo and shmem_hi) is saved for now; other
> > SBI state can be appended to kvm_sbi_state as it is added.
> > 
> > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > ---
> >   target/riscv/machine.c | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> > 
> > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > index 0de06e9588..b8cdca79cc 100644
> > --- a/target/riscv/machine.c
> > +++ b/target/riscv/machine.c
> > @@ -318,6 +318,23 @@ static const VMStateDescription vmstate_kvm_mp_state = {
> >           VMSTATE_END_OF_LIST()
> >       }
> >   };
> > +
> > +static bool kvm_sbi_state_needed(void *opaque)
> > +{
> > +    return kvm_enabled();
> > +}
>
> I think kvm_enabled() isn't enough here since there's no guarantee that
> the current running kvm driver supports SBI STA.
>
> If we take the existing mp_state as an example, in kvm-cpu.c we have:
>
> bool kvm_riscv_has_mp_state(void)
> {
>     return cap_has_mp_state;
> }
>
> And then, in machine.c:
>
> static bool kvm_mp_state_needed(void *opaque)
> {
>      return kvm_enabled() && kvm_riscv_has_mp_state();
> }
> 
>
> I think we can do the same here.  In patch 1 you're setting kvm_sbi_sta.supported
> to true if SBI STA is available.  We can add a:
> 
> bool kvm_riscv_has_sbi_sta_state(void)
> {
>     return kvm_sbi_sta.supported;
> }
>
> And then you can use it as another check in kvm_sbi_state_needed() too.
>
>
> Thanks,
> Daniel
>

Thanks for the review and for the detailed explanation.
I'll make this change in v2.

Thanks,
Yechao

>
> > +
> > +static const VMStateDescription vmstate_kvm_sbi_state = {
> > +    .name = "cpu/kvm-sbi-state",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = kvm_sbi_state_needed,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_UINT64(env.kvm_sbi_sta.shmem_lo, RISCVCPU),
> > +        VMSTATE_UINT64(env.kvm_sbi_sta.shmem_hi, RISCVCPU),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> >   #endif
> >   
> >   static bool debug_needed(void *opaque)
> > @@ -645,6 +662,7 @@ const VMStateDescription vmstate_riscv_cpu = {
> >           &vmstate_kvm_timer_frequency,
> >           &vmstate_kvmtimer,
> >           &vmstate_kvm_mp_state,
> > +        &vmstate_kvm_sbi_state,
> >   #endif
> >           &vmstate_envcfg,
> >           &vmstate_debug,

