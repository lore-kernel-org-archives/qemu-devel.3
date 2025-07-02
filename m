Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9852BC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtuv-0006Gc-3r; Wed, 02 Jul 2025 05:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uWtur-0006GL-MX
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:38:09 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uWtuo-0004hj-ON
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:38:09 -0400
X-ASG-Debug-ID: 1751449070-1eb14e1c3b31b20001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id HbOkbt7zIZBcZITp (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 02 Jul 2025 17:37:50 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 2 Jul
 2025 17:37:50 +0800
Received: from ZXSHMBX1.zhaoxin.com ([::1]) by ZXSHMBX1.zhaoxin.com
 ([fe80::2c07:394e:4919:4dc1%7]) with mapi id 15.01.2507.044; Wed, 2 Jul 2025
 17:37:50 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 2 Jul
 2025 17:35:35 +0800
Message-ID: <64708aa4-3404-4454-b398-793697b3922f@zhaoxin.com>
Date: Wed, 2 Jul 2025 17:35:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] i386/cpu: Introduce cache model for YongFeng
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH 4/8] i386/cpu: Introduce cache model for YongFeng
CC: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Jason Zeng <jason.zeng@intel.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>, Yi Lai
 <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, Tejus GK
 <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 <qemu-devel@nongnu.org>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-5-zhao1.liu@intel.com>
 <7f2b589b-589d-4d72-9ecb-26bb5727f724@zhaoxin.com>
 <aGTTGP+92oL+5rbf@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <aGTTGP+92oL+5rbf@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 7/2/2025 5:37:48 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1751449070
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5572
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.62
X-Barracuda-Spam-Status: No,
 SCORE=-1.62 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA085b
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.143699
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.40 BSF_SC0_SA085b         Custom Rule SA085b
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/2/25 2:35 PM, Zhao Liu wrote:
>=20
>=20
>>> +            {
>>> +                .version =3D 3,
>>> +                .note =3D "with the cache info",
>>
>> I realize that my previous use of "cache info" was not precise; "cache
>> model" is more appropriate. Please help me adjust accordingly, thank you=
.
>=20
> Nope, will fix.

Thank you!

>=20
>>> +                .cache_info =3D &yongfeng_cache_info
>>> +            },
>>>                { /* end of list */ }
>>>            }
>>>        },
>>> --
>>> 2.34.1
>>>
>>
>> Hi Zhao,
>>
>> I tested the patchsets you provided on different hosts, and here are the=
 results:
>>
>> 1. On an Intel host with KVM enabled
>> The CPUID leaves 0x2 and 0x4 reported inside the YongFeng-V3 VM match ou=
r
>> expected cache details exactly. However, CPUID leaf 0x80000005 returns a=
ll
>> zeros. This is because when KVM is in use, QEMU uses the host's vendor f=
or
>> the IS_INTEL_CPU(env), IS_ZHAOXIN_CPU(env), and IS_AMD_CPU(env) checks.
>=20
> This is a bug:
>=20
> https://lore.kernel.org/qemu-devel/d429b6f5-b59c-4884-b18f-8db71cb8dc7b@o=
racle.com/
>=20
> And we expect we can change the vendor with KVM.

Oh, I've reviewed your discussion on this bug, and it looks like it will be=
=20
resolved soon.

>=20
>> Given that behavior, a zeroed 0x80000005 leaf in the guest is expected a=
nd,
>> to me, acceptable. What are your thoughts?
>=20
> Well, (with this bug) since VM is "Intel" vendor, so this is correct.
>=20
>> 2. On a YongFeng host (with or without KVM)
>> The CPUID leaves 0x2, 0x4, and 0x80000006 inside the VM all return the
>> values we want, and the L1D/L1I cache info in leaf 0x80000005 is also
>> correct.
>=20
> Nice!
>=20
>> 3. TLB info in leaf 0x80000005
>> On both Intel and YongFeng hosts, the L1 TLB fields in leaf 0x80000005
>> remain constant, as we discussed. As you mentioned before, "we can wait =
and
>> see what maintainers think" about this.
>=20
> Yes. I suppose Zhaoxin also uses 0x2 to present TLB info like Intel does.

Yeah. Same behaviour.

> To support TLB, I feel like there is still some work to be done, and it
> depends on if it's worth it...
>=20

The community will provide the final decision, let's wait and see.

>> In summary, both patchsets look good for Zhaoxin support, I don't see an=
y
>> issues so far.
>=20
> Thanks!
>=20
>> Btw, YongFeng host also support 0x1F, does YongFeng need to turn on
>> "x-force-cpuid-0x1f" default ? I think maybe yes.
>=20
> OK, will add it.

Thanks a lot!

>=20
> BTW...my colleague reports a bug that Intel/Zhaoxin CPUs with cache
> model will meet assertion failure on the v10.0 or old machine.
>=20
> So I think it's necessary to drop all the assert() checks on
> lines_per_tag directly:

I'm not sure in which scenarios this assertion failure occurs, so I can't o=
ffer=20
any ideas on a solution=E2=80=A6

>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 18bb0e9cf9f6..f73943a46945 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -491,7 +491,6 @@ static void encode_topo_cpuid1f(CPUX86State *env, uin=
t32_t count,
>   static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
>   {
>       assert(cache->size % 1024 =3D=3D 0);
> -    assert(cache->lines_per_tag > 0);
>       assert(cache->associativity > 0);
>       assert(cache->line_size > 0);
>       return ((cache->size / 1024) << 24) | (cache->associativity << 16) =
|
> @@ -520,13 +519,10 @@ static uint32_t encode_cache_cpuid80000005(CPUCache=
Info *cache)
>    */
>   static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
>                                          CPUCacheInfo *l3,
> -                                       uint32_t *ecx, uint32_t *edx,
> -                                       bool lines_per_tag_supported)
> +                                       uint32_t *ecx, uint32_t *edx)
>   {
>       assert(l2->size % 1024 =3D=3D 0);
>       assert(l2->associativity > 0);
> -    assert(lines_per_tag_supported ?
> -           l2->lines_per_tag > 0 : l2->lines_per_tag =3D=3D 0);
>       *ecx =3D ((l2->size / 1024) << 16) |
>              (X86_ENC_ASSOC(l2->associativity) << 12) |
>              (l2->lines_per_tag << 8) | (l2->line_size);
> @@ -535,8 +531,6 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *=
l2,
>       if (l3) {
>           assert(l3->size % (512 * 1024) =3D=3D 0);
>           assert(l3->associativity > 0);
> -        assert(lines_per_tag_supported ?
> -               l3->lines_per_tag > 0 : l3->lines_per_tag =3D=3D 0);
>           assert(l3->line_size > 0);
>           *edx =3D ((l3->size / (512 * 1024)) << 18) |
>                  (X86_ENC_ASSOC(l3->associativity) << 12) |
> @@ -8353,7 +8347,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
>               (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
>               *eax =3D *ebx =3D 0;
>               encode_cache_cpuid80000006(caches->l2_cache,
> -                                       NULL, ecx, edx, false);
> +                                       NULL, ecx, edx);
>               break;
>           }
>=20
> @@ -8369,7 +8363,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
>           encode_cache_cpuid80000006(caches->l2_cache,
>                                      cpu->enable_l3_cache ?
>                                      caches->l3_cache : NULL,
> -                                   ecx, edx, true);
> +                                   ecx, edx);
>           break;
>       }
>       case 0x80000007:
>=20
>=20
>=20


