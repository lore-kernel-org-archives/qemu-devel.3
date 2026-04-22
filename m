Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCF2F9B5F0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFTVW-0007Nh-4P; Wed, 22 Apr 2026 05:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFTVU-0007NG-QP; Wed, 22 Apr 2026 05:04:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFTVT-000137-42; Wed, 22 Apr 2026 05:04:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LImlPL972859; Wed, 22 Apr 2026 09:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Foug6M
 KO/DnOQDiV+Gc1d5FV5lntRd6byKGaNl7t1wg=; b=r6XuAb6I0S0/53blvPeLGi
 V8Z4wGkb35Ad1QUQiVoSZT8CTlK1F7z9AG/esg8XXGB3RXx5hxwfOAlasstj3eRs
 GNcWucaBV6DA+P6Hec9A5HTstF4OucIEgwXiqmp+cStFdpJcHuOgOSTomiuU4EDC
 ktPec9bFQSPWQ6vxYuduHp/rPfvRBhn83dFHp0g9G6eaGJLIVMb71aR82I2PBGNW
 +8o/Fx1u3sUXN0zdo8rcDZzi4aIXMBljhJjo7qEWqHfiUxpCMo1vLmFU9UmDtKxb
 gCOqnJlZfB8DdLr11RzfTr1uNtLZW4VF3xvoYbIiUFs6+Ltdzr5JRlcQpYKq8NSw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3jd59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 09:03:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63M8oOqW015821;
 Wed, 22 Apr 2026 09:03:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky1hjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 09:03:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63M93nOB56689124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2026 09:03:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 876012004D;
 Wed, 22 Apr 2026 09:03:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11C3F20040;
 Wed, 22 Apr 2026 09:03:48 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.34.105])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Apr 2026 09:03:47 +0000 (GMT)
Message-ID: <5ba47c77-3e2a-49c6-96b5-37fa97ef60c4@linux.ibm.com>
Date: Wed, 22 Apr 2026 11:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] accel/tcg: Pass access_type as an argument of
 tlb_set_page*()
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20260421162912.3295598-1-jim.shu@sifive.com>
 <20260421162912.3295598-2-jim.shu@sifive.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260421162912.3295598-2-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: L84vMpyYfJGFsPkM2y0gWZ-8uQtZJWnc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4MyBTYWx0ZWRfXxWz6EOQesTwT
 GX1UIDLtJ5kL+nQZy7OOu/T6bBfX1SjnB8BkWTgZn04n++4aboxXH9fnx2MmJT3dPbiIx/gbPeZ
 1Q3k8ubrSOm+PeodqiMUVaWxrWN4iQ8QFeXQWzjtUxj9hGRLIwxx+jsLHrVC0g56l7x3bIKaeuR
 2UchdqGkgIWvtBdSuc91XkH8ZzGRAd/QZfwATCvgDb1/OW3tuh4WG8AlXOwAJBTtgpnUbDFfobr
 AdEDFu4PIH9GRPTqyXSu7Uv/AiAVkhiySUHdAcbk05M0Vq+w6gGx+M56rEyOAEjz2O/kCBlnuV/
 7UwxJSTYIDfjjT01LLEnrpw1KLz9WKt3ZE36aEtVQMvxabI36rJ8Cw1pZQNv2vNf4oXyFaoczYW
 YUCGts/AtVMnxbaMZz43YL4TmXHKsgydLG21NtgJWq6FxlTGrly0jCgUf/cvyrrVaoSu5vsk3Uo
 wSdFctl6UpQ3JRV9JQA==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e88efa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pFyQfRViAAAA:8
 a=UKC7VR2YJJbtN_zRHfsA:9 a=QEXdDO2ut3YA:10 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: I9WLuzlg34-WgK8LZqfSfXsmjRKmd4-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220083
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 4/21/26 17:29, Jim Shu wrote:
> Pass the access_type so that we could know CPU will do the read or
> write access. Then, CPU can fill the CPUTLBEntry[Full] of the specific
> permission (@prot).
>
> It is fine for address_space_translate*() to return different section of
> read and write access. tlb_set_page*() only sets 'CPUTLBEntry.addr_*'
> for specific @prot, so access from another @prot will only get TLB miss
> and start to overwrite 'CPUTLBEntry[Full]' with new @prot.
>
> It is the preliminary patch of next commit to pass the iommu_flags
> to IOMMUMemoryRegion from access_type.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
>
> ---
>   accel/tcg/cputlb.c                   | 14 ++++++++------
>   include/exec/cputlb.h                | 11 +++++++----
>   target/alpha/helper.c                |  2 +-
>   target/avr/helper.c                  |  3 ++-
>   target/hppa/mem_helper.c             |  1 -
>   target/i386/tcg/system/excp_helper.c |  3 ++-
>   target/loongarch/tcg/tlb_helper.c    |  2 +-
>   target/m68k/helper.c                 | 10 +++++++---
>   target/microblaze/helper.c           |  8 ++++----
>   target/mips/tcg/system/tlb_helper.c  |  4 ++--
>   target/or1k/mmu.c                    |  2 +-
>   target/ppc/mmu_helper.c              |  2 +-
>   target/riscv/cpu_helper.c            |  2 +-
>   target/rx/cpu.c                      |  3 ++-
>   target/s390x/tcg/excp_helper.c       |  2 +-
>   target/sh4/helper.c                  |  3 ++-
>   target/sparc/mmu_helper.c            |  6 +++---
>   target/tricore/helper.c              |  2 +-
>   target/xtensa/helper.c               |  3 ++-
>   19 files changed, 48 insertions(+), 35 deletions(-)

[...]

> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index ffbad8acfd2..63606c19d07 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -482,7 +482,6 @@ bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
>       out->prot = prot;
>       out->attrs = MEMTXATTRS_UNSPECIFIED;
>       out->lg_page_size = TARGET_PAGE_BITS;
> -
>       return true;
>   }

This whitespace change looks unnecessary.

> @@ -1461,6 +1462,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
>       int prot;
>       int ret;
>       target_ulong page_size;
> +    MMUAccessType qemu_access_type;

Do we need to assign MMU_DATA_LOAD as a default here?

>       access_type = ACCESS_PTEST;
>       if (env->dfc & 4) {
> @@ -1468,9 +1470,11 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
>       }
>       if ((env->dfc & 3) == 2) {
>           access_type |= ACCESS_CODE;
> +        qemu_access_type = MMU_INST_FETCH;
>       }
>       if (!is_read) {
>           access_type |= ACCESS_STORE;
> +        qemu_access_type = MMU_DATA_STORE;
>       }
>   
>       env->mmu.mmusr = 0;
> @@ -1480,7 +1484,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
>       if (ret == 0) {
>           tlb_set_page(env_cpu(env), addr & TARGET_PAGE_MASK,
>                        physical & TARGET_PAGE_MASK,
> -                     prot, access_type & ACCESS_SUPER ?
> +                     prot, qemu_access_type, access_type & ACCESS_SUPER ?
>                        MMU_KERNEL_IDX : MMU_USER_IDX, page_size);
>       }
>   }
Otherwise it may be used uninitialized here.

