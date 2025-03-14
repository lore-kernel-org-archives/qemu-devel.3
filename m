Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30ABC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 07:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tszCO-0002D5-A7; Fri, 14 Mar 2025 03:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Lufh=WB=kaod.org=clg@ozlabs.org>)
 id 1tszCF-0002Bn-JS; Fri, 14 Mar 2025 03:11:09 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Lufh=WB=kaod.org=clg@ozlabs.org>)
 id 1tszC1-0003ei-V7; Fri, 14 Mar 2025 03:10:57 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZDb9t6j2lz4wyh;
 Fri, 14 Mar 2025 18:10:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZDb9q4cnXz4wxh;
 Fri, 14 Mar 2025 18:10:39 +1100 (AEDT)
Message-ID: <bc5b5ab1-c923-43a4-8d3a-de63eb0341b6@kaod.org>
Date: Fri, 14 Mar 2025 08:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: New Defects reported by Coverity Scan for QEMU/PPC
References: <67d327ab474d6_3d7eed2ba0acd079b020018@prd-scan-dashboard-0.mail>
Content-Language: en-US, fr
To: "list@suse.de:PowerPC" <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Nick Piggin <npiggin@au1.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mike Kowal <kowal@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <67d327ab474d6_3d7eed2ba0acd079b020018@prd-scan-dashboard-0.mail>
X-Forwarded-Message-Id: <67d327ab474d6_3d7eed2ba0acd079b020018@prd-scan-dashboard-0.mail>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Lufh=WB=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

Just a heads up about the issues Coverity found in the latest QEMU.
It would be nice to fix them before QEMU 10.0 is released.

Thanks,

C.




-------- Forwarded Message --------
Subject: New Defects reported by Coverity Scan for QEMU
Date: Thu, 13 Mar 2025 18:44:59 +0000
From: scan-admin@coverity.com
To: clg@kaod.org

Hi,

Please find the latest report on new defect(s) introduced to QEMU found with Coverity Scan.

5 new defect(s) introduced to QEMU found with Coverity Scan.
2 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 5 of 5 defect(s)


** CID 1593725:  Error handling issues  (CHECKED_RETURN)
/builds/qemu-project/qemu/hw/ppc/amigaone.c: 112 in nvram_write()


________________________________________________________________________________________________________
*** CID 1593725:  Error handling issues  (CHECKED_RETURN)
/builds/qemu-project/qemu/hw/ppc/amigaone.c: 112 in nvram_write()
106     {
107         A1NVRAMState *s = opaque;
108         uint8_t *p = memory_region_get_ram_ptr(&s->mr);
109
110         p[addr] = val;
111         if (s->blk) {
>>>     CID 1593725:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "blk_pwrite" without checking return value (as is done elsewhere 30 out of 36 times).
112             blk_pwrite(s->blk, addr, 1, &val, 0);
113         }
114     }
115
116     static const MemoryRegionOps nvram_ops = {
117         .read = nvram_read,

** CID 1593724:  Integer handling issues  (BAD_SHIFT)
/builds/qemu-project/qemu/hw/intc/xive.c: 1665 in xive_get_vpgroup_size()


________________________________________________________________________________________________________
*** CID 1593724:  Integer handling issues  (BAD_SHIFT)
/builds/qemu-project/qemu/hw/intc/xive.c: 1665 in xive_get_vpgroup_size()
1659     {
1660         /*
1661          * Group size is a power of 2. The position of the first 0
1662          * (starting with the least significant bits) in the NVP index
1663          * gives the size of the group.
1664          */
>>>     CID 1593724:  Integer handling issues  (BAD_SHIFT)
>>>     In expression "1 << ctz32(~nvp_index) + 1", left shifting by more than 31 bits has undefined behavior.  The shift amount, "ctz32(~nvp_index) + 1", is 33.
1665         return 1 << (ctz32(~nvp_index) + 1);
1666     }
1667
1668     static uint8_t xive_get_group_level(bool crowd, bool ignore,
1669                                         uint32_t nvp_blk, uint32_t nvp_index)
1670     {

** CID 1593723:    (DEADCODE)
/builds/qemu-project/qemu/hw/ppc/pnv_bmc.c: 266 in pnv_bmc_set_pnor()
/builds/qemu-project/qemu/hw/ppc/pnv_bmc.c: 271 in pnv_bmc_set_pnor()


________________________________________________________________________________________________________
*** CID 1593723:    (DEADCODE)
/builds/qemu-project/qemu/hw/ppc/pnv_bmc.c: 266 in pnv_bmc_set_pnor()
260
261         /*
262          * The HIOMAP protocol uses block units and 16-bit addressing.
263          * Prevent overflow or misalign.
264          */
265         if (pnor_addr >= 1U << (BLOCK_SHIFT + 16)) {
>>>     CID 1593723:    (DEADCODE)
>>>     Execution cannot reach this statement: "warn_report("PNOR address i...".
266             warn_report("PNOR address is larger than 2^%d, disabling PNOR",
267                         BLOCK_SHIFT + 16);
268             return;
269         }
270         if (pnor_addr & ((1U << BLOCK_SHIFT) - 1)) {
271             warn_report("PNOR address is not aligned to 2^%d, disabling PNOR",
/builds/qemu-project/qemu/hw/ppc/pnv_bmc.c: 271 in pnv_bmc_set_pnor()
265         if (pnor_addr >= 1U << (BLOCK_SHIFT + 16)) {
266             warn_report("PNOR address is larger than 2^%d, disabling PNOR",
267                         BLOCK_SHIFT + 16);
268             return;
269         }
270         if (pnor_addr & ((1U << BLOCK_SHIFT) - 1)) {
>>>     CID 1593723:    (DEADCODE)
>>>     Execution cannot reach this statement: "warn_report("PNOR address i...".
271             warn_report("PNOR address is not aligned to 2^%d, disabling PNOR",
272                         BLOCK_SHIFT);
273             return;
274         }
275         if (pnor_size > 1U << (BLOCK_SHIFT + 16)) {
276             warn_report("PNOR size is larger than 2^%d, disabling PNOR",

** CID 1593722:  Memory - corruptions  (OVERRUN)
/builds/qemu-project/qemu/hw/ppc/spapr.c: 299 in spapr_dt_pa_features()


________________________________________________________________________________________________________
*** CID 1593722:  Memory - corruptions  (OVERRUN)
/builds/qemu-project/qemu/hw/ppc/spapr.c: 299 in spapr_dt_pa_features()
293             /* Workaround for broken kernels that attempt (guest) radix
294              * mode when they can't handle it, if they see the radix bit set
295              * in pa-features. So hide it from them. */
296             pa_features[40 + 2] &= ~0x80; /* Radix MMU */
297         }
298         if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
>>>     CID 1593722:  Memory - corruptions  (OVERRUN)
>>>     Overrunning array of 26 bytes at byte offset 66 by dereferencing pointer "pa_features + 66".
299             pa_features[66] |= 0x80;
300         }
301
302         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
303     }
304

** CID 1593721:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/builds/qemu-project/qemu/hw/intc/xive2.c: 1338 in xive2_router_end_notify()


________________________________________________________________________________________________________
*** CID 1593721:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/builds/qemu-project/qemu/hw/intc/xive2.c: 1338 in xive2_router_end_notify()
1332         if (!xive2_end_is_valid(&end)) {
1333             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: END %x/%x is invalid\n",
1334                           end_blk, end_idx);
1335             return;
1336         }
1337
>>>     CID 1593721:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
>>>     "be32_to_cpu(end.w6) & (536870912U /* 0x80000000U >> 2 */) & !(be32_to_cpu(end.w6) & (1073741824U /* 0x80000000U >> 1 */))" is always 0 regardless of the values of its operands. This occurs as the logical operand of "if".
1338         if (xive2_end_is_crowd(&end) & !xive2_end_is_ignore(&end)) {
1339             qemu_log_mask(LOG_GUEST_ERROR,
1340                           "XIVE: invalid END, 'crowd' bit requires 'ignore' bit\n");
1341             return;
1342         }
1343


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/qemu?tab=overview

   To manage Coverity Scan email notifications for "clg@kaod.org", click https://scan.coverity.com/subscriptions/edit?email=clg%40kaod.org&token=4549557735e1ea1422dff9fceab58944


