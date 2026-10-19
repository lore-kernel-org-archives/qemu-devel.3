Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219A7CCF2E4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xImKq-00051B-Gt; Mon, 19 Oct 2026 08:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xImKo-00050P-5w; Mon, 19 Oct 2026 08:19:22 -0400
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xImKl-0006GL-2d; Mon, 19 Oct 2026 08:19:21 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=o4mq77tfUM8DmBaf7dqnSzZzp7EymyisRSQJv9tuePc=;
 b=zwjRCxeSUalUtLaEsgfhxm4h2mMA7QiO91Q5TwSZZt8sOCmfG7nqkfEx9P1gMyZW5bWw2FnEr
 0VWmQWIQlK+RAbABt1GjRlONb5KqTAi/BefItjFwjpPDDZANK19zMiaeFz80rmi48XIguXk58RH
 mS4wPwXqJ04BRICdTRoZ0+4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4j7ZN7456rzcZyr;
 Mon, 19 Oct 2026 20:19:03 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id 12811203AB;
 Mon, 19 Oct 2026 20:19:10 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 20:19:09 +0800
Message-ID: <501bf5cc-cee1-4593-943d-505003541d41@huawei.com>
Date: Mon, 19 Oct 2026 20:19:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
To: Peter Maydell <peter.maydell@linaro.org>, Jinjie Ruan <2118537295@qq.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <eblake@redhat.com>,
 <imammedo@redhat.com>, <michael.roth@amd.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
 <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
 <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
 <CAFEAcA_4xb3CBL9TTAdKMOG_ijWpt9wsveCp0R602VoFaWUH1Q@mail.gmail.com>
 <tencent_82895B2529E419B263EC95C8349389114407@qq.com>
 <CAFEAcA-amrQOM8+qnaxgWLyGNM=vp-vKV=OqqU7Qp17PRiH_KA@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAFEAcA-amrQOM8+qnaxgWLyGNM=vp-vKV=OqqU7Qp17PRiH_KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.68]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.217;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout02.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



在 2026/10/19 20:01, Peter Maydell 写道:
> On Mon, 19 Oct 2026 at 12:46, Jinjie Ruan <2118537295@qq.com> wrote:
>> One honest caveat
> 
> Please don't send LLM output to qemu-devel.

Sorry. Here is my understanding:

As mpam_csu_value() and mpam_mbwu_value() below done, the monitor code
scales the base value based on the software-configured PBM
(Partition-Based Monitoring) or MB MAX values, rather than just
returning zeroes.

And most of the code are to expose the many MPAM registers, constructing
the ACPI tables, and building the hardware topology of the memory
controllers and caches to correctly expose the MSC (Memory System
Controller) components.

static uint32_t mpam_csu_value(MPAMMSCState *s, Mpamf *mf, MpamCsuMon *m)
{
    if (FIELD_EX32(m->ctl, MSMON_CFG_CSU_CTL, EN) &&
        FIELD_EX32(m->ctl, MSMON_CFG_CSU_CTL, MATCH_PARTID)) {
        uint32_t partid = FIELD_EX32(m->flt, MSMON_CFG_CSU_FLT, PARTID);
        uint32_t nrw = mpam_nrw_id_for(s, mf, partid);
        uint32_t cpbm = mf->per_nrw_id[nrw].cfg_cpbm[0];

        return muldiv64(s->csu_capacity, ctpop32(cpbm),
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
MPAM_CACHE_PART);
^^^^^^^^^^^^^^^^^^
    }
    return 0;
}

static uint64_t mpam_mbwu_value(...)
{
......
           if (cfg->cfg_mbw_pbm[0]) {
                frac_num = __builtin_popcount(cfg->cfg_mbw_pbm[0] &
                                     ((1u << MPAM_MBW_PART) - 1));
                frac_den = MPAM_MBW_PART;
            } else {
                /* MBW_MAX is a 16-bit fraction; 0xffff = full bandwidth. */
                frac_num = cfg->cfg_mbw_max & 0xffff;
                frac_den = 0xffff;
            }
            rate_mbs = muldiv64(rate_mbs, frac_num, frac_den);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
......
}

> 
> thanks
> -- PMM

-- 
Best regards,
Jinjie


