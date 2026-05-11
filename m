Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A98CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNVP-0004ZL-8B; Mon, 11 May 2026 06:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMNVM-0004YI-At; Mon, 11 May 2026 06:04:52 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMNVJ-00088C-Aq; Mon, 11 May 2026 06:04:52 -0400
Received: from localhost (unknown [183.156.89.125])
 by APP-01 (Coremail) with SMTP id qwCowAC3Ym6ZhQFqJ27hDw--.2090S2;
 Mon, 11 May 2026 15:30:33 +0800 (CST)
Date: Mon, 11 May 2026 15:30:33 +0800
From: Zishun Yi <vulab@iscas.ac.cn>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] target/riscv: Allow mseccfg access based on ext_zicfilp
Message-ID: <uirnjykqsqn2nkcbzkycmtidjaz6b6dox7ujjlm5bb6lgiyr2b@5lulu55tek2f>
References: <20260511031719.2826247-1-vulab@iscas.ac.cn>
 <agF8MNb9aKbqsniz@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agF8MNb9aKbqsniz@ZEVORN-PC.localdomain>
X-CM-TRANSID: qwCowAC3Ym6ZhQFqJ27hDw--.2090S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWkAw43trWUZw17Jr13Arb_yoWkJrg_Wr
 y0kFsY9w4qvr4DWan8trW5CrWUKF4FgFW5JrZ0qr45ZasxZF45ua1kAr1SyFn2krWUtFna
 gr15Xw15K3y7tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb28YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnjjgUUUUU=
X-Originating-IP: [183.156.89.125]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4EA2oBeZQvPgABsW
Received-SPF: pass client-ip=159.226.251.21; envelope-from=vulab@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 11, 2026 at 02:52:31PM +0800, Chao Liu wrote:
> On Mon, May 11, 2026 at 11:17:19AM +0800, Zishun Yi wrote:
> > The Zicfilp extension adds the MLPE field to the mseccfg CSR. According
> > to the RISC-V Privileged Specification, mseccfg exists if any extension
> > that adds a field to it is implemented.
> > 
> > Currently, the `have_mseccfg()` predicate function checks for Smepmp,
> > Zkr, and Smmpm, but misses Zicfilp. As a result, if a CPU is configured
> > with `zicfilp=true` but without the other extensions, accessing the
> > mseccfg CSR will incorrectly raise an illegal instruction exception.
> > 
> > This patch adds the missing check for `ext_zicfilp` to ensure the CSR
> > is properly accessible when the Zicfilp extension is enabled.
> > 
> > This issue was discovered and reported by SpecHunter, an AI-driven
> > architecture specification analysis tool.
> > 
> > Link:https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2561/qemu.txt
> The `Link:` tag is missing a space after the colon.
> 

Sorry for that, already sent the v3 patch.


