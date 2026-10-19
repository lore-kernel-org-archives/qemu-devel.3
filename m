Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD04CCF2E4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIlpK-0004k1-Pl; Mon, 19 Oct 2026 07:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xIlpB-0004jP-Sx
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 07:46:42 -0400
Received: from out203-205-221-149.mail.qq.com ([203.205.221.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xIlp4-0001eA-Jq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 07:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792410382; bh=Wh3oNE7nHL150dfBDTJFwVcWeJKCV7Jp/qTz3pEAXyk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=c0X0oAW0luXD+qL1C9XvbvPs1awlUx0FiLPto697fGKoZq/one+YeG+xXeSNZAqid
 MOfEETtDIOtek/M0iQMwH/J0BikAG7BQRvld5JrNI7LrATfTGZbnTFkepu4HPZFXYh
 Zw/4e4l17xrWuIRncQgXeFAeg9NKWybMRiWgSvNQ=
Received: from [100.125.153.207] ([139.159.170.67])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id B932C402; Mon, 19 Oct 2026 19:46:19 +0800
X-QQ-mid: xmsmtpt1792410379tnrf08j6g
Message-ID: <tencent_82895B2529E419B263EC95C8349389114407@qq.com>
X-QQ-XMAILINFO: Ms8vYu678XiMxFJinJxmdUsqpD05kzSDZWEHNxItZsZ1fqJk35gwRX1goUL/nj
 sBwSJJNBYYGKMIotIYWSKbJ0dY+9joRvMOjWHETM8wDXyI/lyKcEyDSEmi//moT6nWk+t0lMm5FT
 diX6X0htbdZ2Lq0tkndDIsOKOwy0I0JaFiI+ouHhF6Zn3TlogdiWlFENHJxVRf51mf3n24DJx1Fa
 7P62suUEoNZJrBM4I0sevwT4AzgtEHzYHg/MZgM70kya/PvrkO0ysRcIDW2Nxcwp8AgXqG2f9OzN
 B8qkvksWcJ3pgzhb4kX4PLsSsumCaQmWtHU7CLR7lcmmfAv4gigiq6D9Ou+iO6faM4tat07ZNFpx
 4mrwWmvb4sI8gW62IZ450Kwvy6YvcNHHqCNxfYMWSt59iwZZur+XCM+PtEdbRl4AgyZ+EJ05g+Ho
 VDf7hQsMr6jgU+vEPm9Z78Q4pZHueMQAEvj1iNE2h1beLWMJPcT9p4MEnHWL3s8HbPyNDdW1PzRJ
 vJVJWApo51bdyYXqF1dPz3YrZ00BFN+NgWPCO/QFH76TsAXzr4bnoF7UT4R5VNf2jbXYNg0D5/FF
 ABUG2Jj8PBnrVkMmFTc4FoB4ymwI6aojUyqtCiKjIUZUJRgY0PrnuiWcuoQMstQUq7mP0/uVMc/B
 tMGYWUL4i0LtAbXcMYIry/cC33PFpBZhT1HjaR0HDeriWVgSK8i3i43Mo14XLAazOQFfdfO1etN5
 tr3ojwc98OvLoqPyjUkGiJOmM0nc0hLggnknT7slNU8ZKVv6UhxVej6IhT5PNQwtU9rwkJ9MSTET
 grDOQf8yzWHoqW0myKwq6N/GltXNVwQhe//UtYKpuqhEuu2xPq9xZYlp3HnSbsHjm3XKEg5mGINb
 f60pLhQYt/hVxoVwP9nxcLqsM2GxDN23F8wGbJ6ipC6tVDkUgwDqfxbHp8LtlW4vasRnk6icIG19
 uZKk1Wex0gQCeHFlmfkLZK8UaP5A1j2Tl/7xk7p6NrqGaIkg+gmYdB2ywsftq3kKNPvP6sz7sKbr
 x1hw38mwG/ui7ARe0+bT1dJ0YfnNSq6YL2OpcZJypE65pMCgzDy1U+612+bt0=
X-QQ-XMRINFO: Nq+8W0+stu50gAooZK9W0vrdePOQh9fFqg==
X-OQ-MSGID: <1cf9c647-9d18-430c-a7b6-2f53b8280d35@qq.com>
Date: Mon, 19 Oct 2026 19:46:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
To: Peter Maydell <peter.maydell@linaro.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
 <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
 <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
 <CAFEAcA_4xb3CBL9TTAdKMOG_ijWpt9wsveCp0R602VoFaWUH1Q@mail.gmail.com>
Content-Language: en-US
From: Jinjie Ruan <2118537295@qq.com>
In-Reply-To: <CAFEAcA_4xb3CBL9TTAdKMOG_ijWpt9wsveCp0R602VoFaWUH1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.149; envelope-from=2118537295@qq.com;
 helo=out203-205-221-149.mail.qq.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


在 2026/10/19 17:24, Peter Maydell 写道:
> On Mon, 19 Oct 2026 at 02:57, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>> 在 2026/10/16 18:20, Peter Maydell 写道:
>>> I guess my question here is "how much is this actually doing,
>>> and how much is it 'we provide enough software-facing interface
>>> to keep the guest happy'" ? My (rather shallow) understanding of
>>> MPAM is that it's essentially adding tags to memory transactions
>>> and then accounting how much bandwidth each tag is using. That
>>> seems obviously infeasible for emulation, but on the other hand
>> Hi Peter,
>>
>> Yes, I agree with you.
>>
>> Implementing MPAM bandwidth control and partitioning at the
>> performance-effect level in QEMU is neither feasible nor necessary, and
>> it is not in line with QEMU’s original purpose as a fast functional
>> emulator.
>>
>> We only need to implement the functionality-related parts (i.e., the
>> register interfaces and control flow) to ensure that the software stack
>> can correctly recognize and configure MPAM, without simulating the real
>> performance impact produced by those configurations.
>>
>>> this looks like it's rather larger than a minimal "we provide
>>> the register interface but it does nothing", so what are we doing?
>> By implementing MPAM-related register interfaces and control flow, as
>> well as the MSC hardware topology in QEMU, we can understand the resctrl
>> framework and interfaces in Linux, along with the related hardware
>> topology discovery process. This facilitates kernel debugging and
>> pre-silicon testing, and also allows us to debug and test test cases,
>> avoiding the complexity and slowness of testing on FPGA.
> Yes, but what is your implementation actually *doing* ? If
> software reads some MPAM resource monitor, does it read zeroes,
> or something else, or do we implement no monitors at all?
> 2400 lines is a lot of code for "nothing actually happens".

Monitors are implemented and do not return inert zeroes — both CSU and 
MBWU read back values thattrack the partition configuration software has 
programmed.

CSU (MPAMF_MSMON_CSU) — mpam_csu_value(), hw/arm/mpam.c:615,  as the 
"hw/arm/mpam: Emulate CSU cache-usage monitoring" patch done:
- Monitor disabled → returns 0.
- Monitor enabled with MATCH_PARTID → returns csu_capacity × 
popcount(CPBM)/32, i.e. the fraction of cache capacity the filtered 
PARTID is currently allowed to occupy. Granting/revoking cache ways in 
CPBM changes the readback.

static uint32_t mpam_csu_value(MPAMMSCState *s, Mpamf *mf, MpamCsuMon *m)
{
     if (FIELD_EX32(m->ctl, MSMON_CFG_CSU_CTL, EN) &&
         FIELD_EX32(m->ctl, MSMON_CFG_CSU_CTL, MATCH_PARTID)) {
         uint32_t partid = FIELD_EX32(m->flt, MSMON_CFG_CSU_FLT, PARTID);
         uint32_t nrw = mpam_nrw_id_for(s, mf, partid);
         uint32_t cpbm = mf->per_nrw_id[nrw].cfg_cpbm[0];

         return muldiv64(s->csu_capacity, ctpop32(cpbm), MPAM_CACHE_PART);
     }
     return 0;
}

The cfg_cpbm[0] was set by software by partid in patch "hw/arm/mpam: 
Implement CPOR cache portion partitioning"

+    case A_MPAMF_MPAMCFG_CPBM0...
+        (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
+    {
+        uint32_t array_offset;

......
+        array_offset = (offset - A_MPAMF_MPAMCFG_CPBM0) / sizeof(uint32_t);
+        mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset] = value;


MBWU (MSMON_MBWU / MSMON_MBWU_L) — mpam_mbwu_value(), hw/arm/mpam.c:542:
- Lazily accumulated: value = base + rate × (now − t0), rate = 
bw_nominal × MBW_MAX fraction (or MBW_PBM popcount ratio, if set).
- Disabled → rate = 0, readback stays at base (0 at reset).
- Enabled → counts up over time, wraps at 48 bits, latches OFLOW_STATUS, 
raises the overflow IRQ. The rate depends on the MBW_MAX/PBM programmed 
for the filtered PARTID, so raising a PARTID's bandwidth quota is 
visible in that monitor's readback.

             if (cfg->cfg_mbw_pbm[0]) {
                 frac_num = __builtin_popcount(cfg->cfg_mbw_pbm[0] &
                                      ((1u << MPAM_MBW_PART) - 1));
                 frac_den = MPAM_MBWetPART;
             } else {
                 /* MBW_MAX is a 16-bit fraction; 0xffff = full 
bandwidth. */
                 frac_num = cfg->cfg_mbw_max & 0xffff;
                 frac_den = 0xffff;
             }
             rate_mbs = muldiv64(rate_mbs, frac_num, frac_den);

The MBW_MAX was set by software as below in patch "hw/arm/mpam: 
Implement MBW bandwidth partitioning"

  case A_MPAMF_MPAMCFG_MBW_MAX:
      ......
         mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max = value;


So the two monitors are closed-loop with the control plane: write 
CPBM/MBW_MAX → the matching PARTID's CSU/MBWU readback moves. Not no-ops.

The 2400 lines break down as:
- MPAM2/MPAMHCR/MPAMSM_EL1 + PPTT rev3 cache IDs (guest visibility)
- MSC (Memory System Component) register map, mem/cache MSC subtypes, 
partition control (CPOR/MBW/PRI/CCAP) + PARTID narrowing (*extended 
feature*), the CSU/MBWU monitors above, error/overflow IRQ + ECR/ESR, 
reset/power-on state
- MSC creation/sizing, MMIO window, IRQ-to-GIC wiring, ACPI MPAM table
- qapi/mpam.json + query-mpam-cache: introspection

- qemu boot parameters for mpam.

The bulk sits in hw/arm/mpam.c (1620 lines, two-thirds of the total), 
and most of that is IHI 0099 register field definitions plus the MMIO 
read/write dispatch — fixed overhead from the spec's many registers, not 
logic bloat.

One honest caveat: monitors reflect configuration, not measured traffic 
— rate is derived from the programmed MBW_MAX/PBM fraction, not from 
real memory transactions. That is intentional for a 
functional/configuration model.

Thanks,
Jinjie

>
> -- PMM


