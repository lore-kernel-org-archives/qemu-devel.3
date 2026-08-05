Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEBFC55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrWwe-0002Oq-Jh; Wed, 05 Aug 2026 04:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1wrWwc-0002Oc-Pb; Wed, 05 Aug 2026 04:25:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1wrWwa-0001Mt-Hx; Wed, 05 Aug 2026 04:25:46 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6755lter2973520; Wed, 5 Aug 2026 08:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1M7z04
 806wH6mVUABkmEvfu0aW/v6VBgZqiOFwwLWoc=; b=gHpB/qsFLe7BKuiKARPTN5
 af2tx9amhYRJnK3RIQAAaVQvLV+Wq3J6XbfxWS6NN+u/eR7pmQpqESekAQZhcugm
 IsNj12cN2P1Y6Nt466bwMuh3k6R7XLCbU47gj+lZ77CKzaBvI64Jg3z+NX+tMIIY
 aNzc0c9jSVKRXiF2lxlcnMS3k1YWlq6ISYJ1she2vH2/Y4eNpvJaKR14ugqwGom5
 SJOPIIzi6vSpsO0aLAG3jwQj+0mjzTG1aevC8S4T9mbXyCDx8H7EgsVFE8SG6vwa
 QT9z3Ad6eRk6bqmDKNmqfNsGA/v5+kUDykf6sPwtjDl8SU1NIMolm9NdR3VPRg3Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a4238c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 08:25:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6758BJ0x022225;
 Wed, 5 Aug 2026 08:25:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgdgxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 08:25:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6758Pc4V5506032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 08:25:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B61958059;
 Wed,  5 Aug 2026 08:25:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97B2558043;
 Wed,  5 Aug 2026 08:25:34 +0000 (GMT)
Received: from [9.123.12.181] (unknown [9.123.12.181])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Aug 2026 08:25:34 +0000 (GMT)
Message-ID: <e73be5fc-5d2c-4932-ac20-6b21f7214dd1@linux.ibm.com>
Date: Wed, 5 Aug 2026 13:55:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] ppc/kvm: Handle CPU compatibility mode correctly
 for nested guests
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gautam Menghani <gautam@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260804182914.83091-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260804182914.83091-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a72f385 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8QdKcQrl16mx-5u6g1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EJ3mtGG4HTY1wqj-Akgk3Bdfpw9H8abL
X-Proofpoint-GUID: tO51gLC2Vi_xGWz9trnEe8A7v4Oi8kEs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2NCBTYWx0ZWRfX6EuhrtCEgIK4
 fpn1cxK87rJ1eYdfazbkDTnmVtgdp2/DeDUGg6+1Z/ovSmLFpTqxHyi+gxNuOlm8h+a/8WRMq27
 0vLKJUoHV7RJr3ynhUyc5rKV0EhZhik=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2NCBTYWx0ZWRfX/qRtuIfIYd6v
 z0+OwhxV/wP/WKDBHvjWbsZLJzFRA+dvHJ/Bc6LckxyTFVh8mXA+txO+q/xXsQoEE3soc+hq4dk
 IlIYh/C7CtRL1xTezNwm/dZZ4MWvpUBPLySRp00lxDaOKvvPfjdTMIAmpQVHbf4K47ThjEjkwyE
 TQqzTlld4niACF5wWGVBcKFGtiWtpZSpW3P27pkER+zRYgQUtjdrRclMvLMWM3AXSd0Gl8UEGjp
 uUihx3r26WsFOgroP9Dk1DuEPceidu2s3gbJbBrtyUCNii+r1iRFXSAtkxEHLuQ9EvEfddc68Sn
 6/IQjdEXIONRrnWrs6Ispzg1dx44Pq+UjmQffVmD08pU6UczaT5a9e75KKv5Uw4035x8Ke4jGDO
 Q3+w28ceSfmLK2BnbMK/WvQ5fbqhSD19aqFAfJBum4tfanXUw0L3k19PhRUFwrkca157G+dXdt4
 B/BVVL3oy5wU11bb/+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



On 04/08/26 11:59 PM, Amit Machhiwal wrote:
> On POWER systems, newer processor generations can operate in compatibility
> modes corresponding to earlier generations (e.g., a Power11 system running
> in Power10 compatibility mode). In such cases, the effective CPU level
> exposed to guests differs from the physical processor generation.
>
> This creates issues for nested virtualization. When booting a nested KVM
> guest, QEMU may derive the CPU model from the raw hardware PVR and attempt
> to configure the guest accordingly. However, the host is constrained by the
> compatibility level negotiated with the hypervisor, and requests exceeding
> that level are rejected by KVM, leading to guest boot failures such as:
>
>    KVM-NESTEDv2: couldn't set guest wide elements
>
> This series addresses the issue by preventing fallback to raw mode when the
> host itself is booted in a compatibility mode, and by querying the effective
> CPU compatibility modes supported by the host via KVM. The kernel interface
> uses copy_struct_from/to_user() for forward and backward ABI compatibility.
> With these changes, QEMU ensures that nested guests are configured with CPU
> models consistent with the host compatibility mode, allowing them to boot
> correctly.
>
> Patch summary:
>    [1/3] [DO_NOT_MERGE] linux-headers: Add uapi header changes
>    [2/3] target/ppc/kvm: Add support for querying host compatibility mode
>    [3/3] target/ppc/kvm: Use host compatibility mode for nested guests
>
> Changes in v5:
>    - Patch 1: Updated KVM_PPC_GET_COMPAT_CAPS ioctl number from 0xe4 to
>      0xb8 to match the corresponding Linux kernel v6 series change; the
>      0xe0-0xe3 range is reserved for KVM_CREATE_DEVICE fd ioctls
>
> Testing (with kernel v6 patches):
>
> KVM APIv1 Testing
> =================
>    On P10 PowerNV machine (L0)
>    ---------------------------
>      - P10 L1 KVM guest -> works
>        - P10 nested L2 KVM guest -> works
>        - P9 compat nested L2 KVM guest -> works
>      - P9 compat L1 KVM guest -> works
>        - P9 nested L2 KVM guest -> works
>
>    On Powernv11 TCG Guest (L0)
>    ---------------------------
>      - P11 PowerNV TCG L0 guest -> works
>      - P11 L1 KVM guest -> works
>        - P11 L2 KVM guest -> works
>      - P10 compat L1 KVM guest -> works
>        - P10 L2 KVM guest -> works
>      - P9  compat L1 KVM guest -> works
>        - P9 L2 KVM guest -> works
>
> KVM APIv2 Testing
> =================
>    On P11 PowerVM LPAR (L1)
>    ------------------------
>      - P11 L2 KVM guest -> works
>      - P10 compat L2 KVM guest -> works
>      - P9 compat L2 KVM guest fails to boot as expected
>      - Without QEMU patches but Linux patches
>        - P11 L2 KVM guest -> works
>        - P10 compat L2 KVM guest -> works
>        - P9 compat L2 KVM guest fails to boot as expected
>      - Without Linux patches but QEMU patches
>        - P11 L2 KVM guest -> works
>        - P10 compat L2 KVM guest -> works
>
>    On P11 LPAR in P10 compat (L1)
>    ------------------------------
>      - P10 (host compat) L2 KVM guest -> works
>      - Without QEMU patch but Linux patches
>        - P10 guest fails to boot as expected (error: kvm run failed Invalid argument)
>      - Without Linux patch but QEMU patches
>        - P10 guest fails to boot as expected (KVM: unknown exit, hardware reason ffffffffffffffea)
>
>    On P10 PowerVM LPAR (L1)
>    ------------------------
>      - P10 L2 KVM guest -> works
>      - P9 compat L2 KVM guest fails to boot as expected
>
> TCG pSeries Guest
> =================
>      - P11 (default) pSeries guest boots fine
>
> ABI Extensibility Testing (struct size 32, extra member)
> =========================================================
>      - Newer struct on QEMU, older kernel -> works (kernel returns -E2BIG,
>        QEMU retries with correct size)
>      - New struct on Linux kernel, older QEMU -> works (kernel zero-pads
>        trailing fields, QEMU gets correct data)
>
> Note: Patch 1 is marked DO_NOT_MERGE as it contains linux-headers updates
> that will be synced separately once the corresponding kernel patches are
> merged.
>
> The corresponding Linux kernel patches (v6) are being posted concurrently.
>
> v4: https://lore.kernel.org/all/20260701052341.62289-1-amachhiw@linux.ibm.com/
> v3: https://lore.kernel.org/all/20260616113915.25589-1-amachhiw@linux.ibm.com/
> v2: https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
> v1: https://lore.kernel.org/all/20260430061333.37905-1-amachhiw@linux.ibm.com/
>
> Previous kernel patch versions:
> v6: https://lore.kernel.org/all/20260804180705.59160-1-amachhiw@linux.ibm.com/
> v5: https://lore.kernel.org/all/20260701051409.51820-1-amachhiw@linux.ibm.com/
> v4: https://lore.kernel.org/all/20260616123314.82721-1-amachhiw@linux.ibm.com/
> v3: https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> v2: https://lore.kernel.org/all/20260513100755.83195-1-amachhiw@linux.ibm.com/
> v1: https://lore.kernel.org/all/20260430054906.94401-1-amachhiw@linux.ibm.com/
>
> Amit Machhiwal (3):
>    [DO_NOT_MERGE] linux-headers: Add uapi header changes
>    target/ppc/kvm: Add support for querying host compatibility mode
>    target/ppc/kvm: Use host compatibility mode for nested guests
>
>   hw/ppc/spapr_hcall.c            | 14 ++++++
>   linux-headers/asm-powerpc/kvm.h | 19 +++++++
>   linux-headers/linux/kvm.h       |  3 ++
>   target/ppc/kvm.c                | 87 +++++++++++++++++++++++++++++++++
>   target/ppc/kvm_ppc.h            |  7 +++
>   5 files changed, 130 insertions(+)
>
>
> base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
Hi Amit,
I have tested this patch and it works as expected. Here is my analysis :

I booted a host with Power10 compat mode and tried following scenarios -


lscpu on host :

Architecture:                ppc64le
   Byte Order:                Little Endian
CPU(s):                      8
   On-line CPU(s) list:       0-7
Model name:                  POWER10 (architected), altivec supported


Before applying the patch :

When I am trying to bringup the guest on a compat mode host it was 
bringing up a Power11 guest and was failing as

[ 1411.578944] [   T2928] KVM-NESTEDv2: couldn't set guest wide elements
[ 1411.578963] [   T2928] vcpu 000000000b9c4155 (0):
[ 1411.578968] [   T2928] pc  = 000000007daf9790  msr = 
8000000000103000  trap = ffffffea
[ 1411.578973] [   T2928] r 0 = 8000000000003000  r16 = 0000000000000000
[ 1411.578978] [   T2928] r 1 = 000000007e581e20  r17 = 0000000000000000
[ 1411.578982] [   T2928] r 2 = 000000007db26c00  r18 = 0000000000000000
[ 1411.578985] [   T2928] r 3 = 0000000000000000  r19 = 0000000000000000
[ 1411.578989] [   T2928] r 4 = 0000000002e30c80  r20 = 0000000000000000
[ 1411.578993] [   T2928] r 5 = 000000007df80000  r21 = 0000000000000000
[ 1411.578996] [   T2928] r 6 = 0000000000200000  r22 = 00000000018c5fd6
[ 1411.579000] [   T2928] r 7 = 000000007df80000  r23 = 000000007db21cc0
[ 1411.579003] [   T2928] r 8 = 000000007db6e5d8  r24 = 000000007db66000
[ 1411.579006] [   T2928] r 9 = 000000007e6655d8  r25 = 000000007e665508
[ 1411.579010] [   T2928] r10 = 000000007db6e5d0  r26 = 00000000018c5fd6
[ 1411.579013] [   T2928] r11 = 0000000000003000  r27 = 0000000000000003
[ 1411.579017] [   T2928] r12 = 8000000000000001  r28 = 000000007db6e5e0
[ 1411.579020] [   T2928] r13 = 0000000000000000  r29 = 000000007db224b0
[ 1411.579024] [   T2928] r14 = 0000000000000000  r30 = 000000007daf274c
[ 1411.579028] [   T2928] r15 = 0000000000000000  r31 = 000000007db76000
[ 1411.579033] [   T2928] ctr = 000000007daf1b44  lr  = 000000007daf1b7c
[ 1411.579037] [   T2928] srr0 = 000000007daf9790 srr1 = 8000000000102000
[ 1411.579041] [   T2928] sprg0 = 0000000000000000 sprg1 = 000000000000ff10
[ 1411.579045] [   T2928] sprg2 = 0000000000000000 sprg3 = 0000000000000000
[ 1411.579049] [   T2928] cr = 20000402  xer = 0000000020040000 dsisr = 
00000000
[ 1411.579054] [   T2928] dar = 0000000000000000
[ 1411.579057] [   T2928] fault dar = 0000000000000000 dsisr = 00000000
[ 1411.579061] [   T2928] SLB (0 entries):
[ 1411.579064] [   T2928] lpcr = 0040000000020400 sdr1 = 
0000000000000000 last_inst = ffffffffffffffff
[ 1411.579069] [   T2928] trap=0xffffffea | pc=0x7daf9790 | 
msr=0x8000000000103000





After applying this patch along with the kernel built with it's 
dependent patch 
(https://lore.kernel.org/all/20260804180705.59160-1-amachhiw@linux.ibm.com/):

I am able to bringup a guest and it got boot up with Power10 by default:


lscpu on guest -

ltcbonn53-vm2:~ # lscpu
Architecture:                ppc64le
   Byte Order:                Little Endian
CPU(s):                      8
   On-line CPU(s) list:       0-7
Model name:                  POWER10 (architected), altivec supported
   Model:                     2.0 (pvr 0082 0200)
   Thread(s) per core:        2
   Core(s) per socket:        4
   Socket(s):                 1



Please feel free to add my tested-by:

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>


Thank you,
Anushree Mathur



