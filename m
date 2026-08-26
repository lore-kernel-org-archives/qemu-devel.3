Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8203FC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHzz-0008Pg-GT; Wed, 26 Aug 2026 14:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHzx-0008Oa-Ks
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:05:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHzr-0003DH-5X
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:05:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QHLxTb1044140
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0aKBEAAFRVYLid2OaLjFOGC+DQV42SuupgQ5UtPS3LE=; b=K3we8OUyrZCA7TcY
 +SK6ViiKGqeinNxE2N97725xBZhSbTqdcUcfkMSHtpS6ORdKHe8KGfFWZEgOtsRU
 KauUWbwA3kmblKbFfs1xlM0Rl4J0o0O3A/CYodoU6DJbmpDgsaIh695Bx/ycGFxt
 9/Y6mR7x9fIN3vxirBIb1YvhcCP6tFe8IQ2lt+JQ5qmaomiqkqCKpGqZvJ3LAe3X
 VfGXO9R/0Y74rwA3dL/BO0PJ+tqowcwMb6c2ZD05w3fzuMks7me2YnxijNCDAIN4
 ht1dH2hFVmrqmiVGYyq3XC1YnTeg1TSl8K0t8Nb0ur9WhWwbF+wxdnr9U7mH3s76
 LUGa6g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwg5um-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:05:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so22719051cf.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787767509; x=1788372309; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0aKBEAAFRVYLid2OaLjFOGC+DQV42SuupgQ5UtPS3LE=;
 b=A8oRUJNBAJKConSpH3vCDEmRj8FHmmVz8r1aJD+iGvYfJSARXKz6K0ZIfAlK2Bx+pQ
 mTfWJ+kEITA0Gj/rUuKuMPSP+HimQ9sra4UlPOlx6DbH/N4igUlYWzK8wHkn/AprfkEC
 8PK3dBMTNSMG2AgusbHxJ4wDSPBYWC7iRJ1Br1bCLfL8APKWFq1LQ3W7pPmzR1J83tpo
 oB/9Aj3Bu7qhtniQToxiEGP65SS4c/n1T+cYOuVsyapa9Q3TEeekCxLiJUXYsqtoISkm
 G/UzfmktfcXPugzU4zGAQpSeXcWaeH0JzrgydCfs4mNSKgUcKhbIgW8Z5BURcITx6msh
 5VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787767509; x=1788372309;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0aKBEAAFRVYLid2OaLjFOGC+DQV42SuupgQ5UtPS3LE=;
 b=DWoQjgEmXXGPVcjfgdNWUqnDprnm2qG5r163CQXfdrHPQcPTCbj+ApusrPdOErrALw
 fbhecFP2pdfeIT2cvNerr5sNBzD/UDrvfnQ3bf9AZFP8MXtCw/BzGDJ242zkbWGfHC7k
 qKE+2W7V/+vgBhHYecBDTDWZtAwJ5UGG+NmFsPtslJmdm6yWUgZsHVEIIMbACyidfKGk
 K+YyU3yyuY5/NzEyVKsknBY08XRb70IYPdmyfqK0sIKFFV/NIGX4NDrCbrCFLtrnE/9B
 a1HfhG8Bbqnq95w4VELm1IqZcfJRqm4qxlh+DXcFiHgcnJqQmBZ4kQxPr8q7sOLltNgS
 UQ+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqISMsPZC3X4PsxDsYINHYIb5XRTpOFc9IOx5Z0UsAGZ7FtI8pj9TEFBlxiBhGrlKS7NEi7sQ4+4L8A@nongnu.org
X-Gm-Message-State: AFuF++newtwmmhDTkXrHD1DE1XSeSSqSPsJ5vA+IEJdjQfeWceqod1rl
 ry/2Rd6P576Y7VKcvOQ3JnLjCW/xq6xdXSg3AXjjsNaBjr7YVnnSk/R4zSOWTrQxCh4cHGArtCR
 nHN/xwdreIGrLxf7aeGQWMDfIsNcYNn81E9bmcimCaqfBp/5ZN+dQYdE6nw==
X-Gm-Gg: AR+sD10rq65faOAHbRFR2VzTZuBL/izCU8gpbCQfoIhWt+cGkL1sxgFXongg/8AJS6I
 Xvz1hCG6IK5hFlaxYMLdHB8CDkWhe0bnmCGqX90s2jnBmNPhE57YKZUJwHcW81P5NEn8oLSrzKa
 uPLlDqAMRXOmaSmEEGz4wNc4+Zrd0Q0pd+3ySCz6P7vMkRW/4p0Av5oeKqVQHwwS3vo/LoZbTc3
 SH+sPobhLPyzqVt7C8cOSCNvem43k2asPvvBw3LAYprWaIzFYrJBve//kJTNxYE8ZL5DWXkgA4A
 9+Akzo/qEBv7Sojy1w353FR4RFlbucs3SYSz0vR410rowqgx5FJz6KRD8W4sdQW4PN8BtE7YTo6
 gZVHwpwFb3QCQ2fC+7RmyII+5aVU4yLXcu3Ic6OINCYV5kNon3g==
X-Received: by 2002:a05:622a:30f:b0:51c:1568:3a53 with SMTP id
 d75a77b69052e-52e422ebbc3mr89594831cf.16.1787767508687; 
 Wed, 26 Aug 2026 11:05:08 -0700 (PDT)
X-Received: by 2002:a05:622a:30f:b0:51c:1568:3a53 with SMTP id
 d75a77b69052e-52e422ebbc3mr89593571cf.16.1787767508021; 
 Wed, 26 Aug 2026 11:05:08 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a722400sm557869766b.23.2026.08.26.11.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 11:05:06 -0700 (PDT)
Message-ID: <c36279c6-6595-48e9-8cad-2896064e9e33@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 20:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] meson: link ARM and RISC-V into qemu-system
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-13-luoyonggang@gmail.com>
 <b9f0853b-adda-457d-94e1-add9bb2a2548@oss.qualcomm.com>
 <ao7jWx-zfmB9AUEb@redhat.com>
 <d7d5e491-430b-4781-8746-eebcc1e4177e@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <d7d5e491-430b-4781-8746-eebcc1e4177e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6TLyq1QuUS2GgQgJfYS49MIXjCW6YOeV
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a8f2ad5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=WGUbI1f7ho_wN7Lv0PAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 6TLyq1QuUS2GgQgJfYS49MIXjCW6YOeV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MSBTYWx0ZWRfX9v4gTwgbHxEB
 Xn/zgijxUetOw29U1Wonou3R90Q0FtAIDQ1pTEuAYNlL76zDUoeECQCB3i0BAEpgFCZphEq7YAG
 8oZX546CgPgqEzHgmT4lP3xBKM1X62+le9EZze5qW7kvvSl3gUstztrqSJnFArFg5jNH8xwZ6FF
 1b2AvIOIVmuJYEzjwu0J0sjnrQjSVXrshBO3v+C1ih5/aVhyd109cmI1n+MRKGd/WVFj5PZDPgy
 9+vNjyjBASSAfTsYSaqu1BTWEzg4r+dZNoxZtQxrru1Ws5lPxFO04qs1JQ5rrg6/7Feham/usbU
 gQcLiRkCpH/cjDOrsYhGDKikYJB1tnG24Ksc6MAzzVKT5GqDK8IM2TxwR+mwkXTFAB6/FTVr08v
 eUgHypApL66d+gyaqKkHI14C339/o6wfFv6bf1Vqpp7qXgha5bvZfdpO4iFxZO44bkBt+VYLwpx
 g18mjUTS4v879wXIQCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MSBTYWx0ZWRfX4YRZW+g7VoFF
 d0e/kb2SI72ZWwxR4l6RUEgEihRaV2HN5Z2HDR8cOnGvddhBx8SgDzZ5B6kkX/nTFQ/Nq1s/IOi
 WFRD5Tv6bDCrgHoM7HMcB9coh0UiVLA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260151
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/8/26 19:40, Pierrick Bouvier wrote:
> On 8/26/2026 6:00 AM, Daniel P. Berrangé wrote:
>> On Mon, Aug 24, 2026 at 09:20:38AM -0700, Pierrick Bouvier wrote:
>>> On 8/23/2026 8:07 AM, Yonggang Luo wrote:
>>>> - Build qemu-system (and qemu-systemw on Windows) from aarch64
>>>>    common/system objects plus RISC-V arch objects taken from the
>>>>    existing riscv64 lib.
>>>> - Pull 32-bit TargetInfo and 32-only boards from the arm/riscv32
>>>>    libs so hw/arm and target/riscv are not compiled twice.
>>>> - Skip linking qemu-system-{arm,aarch64,riscv32,riscv64} and the
>>>>    Windows *w variants; symlink those names to qemu-system so
>>>>    argv[0] still selects TargetInfo.
>>>>
>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>> ---
>>>>   meson.build | 156 +++++++++++++++++++++++++++++++++++++++++++++++++---
>>>>   1 file changed, 147 insertions(+), 9 deletions(-)
>>
>> I think this approach of taking common/system from aarch64
>> and adding in riscv specific objects only works by luck.
>>
>> That's not obvious from your patch, but Pierrick's counterproposal
>> below will expose it with a little  tweak....
>>
>>
>>>  From 6261b0c255e1a8f0df2b41928b8dfb365d0fa488 Mon Sep 17 00:00:00 2001
>>> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> Date: Tue, 14 Apr 2026 10:56:15 -0700
>>> Subject: [PATCH] meson: build single binary
>>>
>>> This is not built by default.
>>> Build with: ninja -C build qemu-system
>>>
>>> All available *-softmmu targets are aggregated, ./configure
>>> --target-list can be used to restrict which targets are included.
>>>
>>> In case user has targets that are not supported, we emit an error
>>> message when build qemu-system target. This way, it's not necessary to
>>> have a custom configure flag, and qemu-system can live next to existing
>>> binaries without complexifying the workflow more than it is already.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>   meson.build | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 48 insertions(+)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 553df3e7f053..4a31a520d9eb 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -4264,6 +4264,9 @@ if host_os == 'darwin'
>>>   endif
>>>   
>>>   traceable = []
>>> +single_binary_libs = []
>>> +single_binary_deps = []
>>> +single_binary_crates = []
>>>   emulators = {}
>>>   foreach target : target_dirs
>>>     config_target = config_target_mak[target]
>>> @@ -4419,6 +4422,10 @@ foreach target : target_dirs
>>>                    build_by_default: false)
>>>   
>>>     if target.endswith('-softmmu')
>>> +    single_binary_libs += lib
>>> +    single_binary_deps += arch_deps
>>> +    single_binary_deps += target_stubs
>>> +    single_binary_crates += main_rs
>>>       execs = [{
>>>         'name': 'qemu-system-' + target_name,
>>>         'win_subsystem': 'console',
>>> @@ -4500,6 +4507,47 @@ foreach target : target_dirs
>>>     endforeach
>>>   endforeach
>>>   
>>> +single_binary_objects = []
>>> +foreach lib: single_binary_libs
>>> +  single_binary_objects += lib.extract_all_objects(recursive: true)
>>> +endforeach
>>> +
>>> +single_binary_link_args = emulator_link_args
>>> +single_binary_link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
>>> +
>>> +supported_targets = [
>>> +  'aarch64-softmmu',
>>> +  'arm-softmmu',
>>> +]
>>
>> Adding in riscv64-softmmu to this list and building with
>> configure --target-list=aarch64-softmmu,riscv64-softmmu
>> will fail with this meson approach.
>>
> 
> Maybe it's now more obvious why our original goal, presented at KVM
> Forum 2025, was to have only arm/aarch64/microblaze, and not riscv.
> It just requires more work to have it, and iteration is key. But we need
> a minimum viable product to start somewhere.
> 
> It is still our goal to this date.
> 
>> Specifically we'll hit duplicate symbols to to taking
>> different KConfig branches, resulting in building in
>> both the real impl and the stubs:
>>
>>    /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge_stubs.c.o: in function `pxb_cxl_hook_up_registers':
>> /home/berrange/src/virt/qemu/build-alt/../hw/pci-bridge/pci_expander_bridge_stubs.c:14: multiple definition of `pxb_cxl_hook_up_registers'; libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o:/home/berrange/src/virt/qemu/build-alt/../hw/pci-bridge/pci_expander_bridge.c:214: first defined here
>>
> 
> There is nothing new here, and we discovered all that more than a year
> ago. That's why we started using stub_ss more, as it provides the weak
> symbol semantic we need. It's not the end of the story though, as we'll
> have to adapt some functions to this new "multi target" world.
> But to be able to test and debug that, we need to have a single-binary
> first.

I will try to find time to finish that 'HOWTO convert to single-binary'
document I proposed to Daniel Barboza and Anton Johansson which is
structured as "why / how / commit references", that could help Yonggang
and others to understand why this effort is taking so long.

