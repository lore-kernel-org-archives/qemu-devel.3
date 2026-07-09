Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78306C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpru-0007Qz-VJ; Thu, 09 Jul 2026 10:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whprt-0007Qd-Hy
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:36:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whprr-0001Ht-DA
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:36:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669Dx5cD1835833
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 14:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 57uLOYP20ZPPo84vUbIDBb1y/EUle/1NhhYvvUaa2XQ=; b=GGCzFW36HbozoJhT
 K79BgZ7Td3sdXNiiTtWc0XQqVDbDgHm8/CJT0RFO283hW8z/Xpi6xZIXyWcQ8mfL
 5JkD480X6oNlLKp13y9sTVAh/JHs1x3Tk1c26eyeH7Y8OY1RkvtMT+3CyhLwgjn1
 DJ9FPOllrETBiIDlOwpSkMPPXwAJEHPr5EyK9kvbX9CBpbaayI5m4arD9hBkfxal
 kDFiaH/vA7iUKboKZ7BlS1dpKxD7l1ByCe4fCF01xZ2eD1808KPWWUY/qqfXqvuV
 j/PYBi6/jXFS1+9XnXL8KOnic3IlViwpPu1nb7MaM6SY/2uXFKtFapVq2sh8MFia
 jT6ETA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfur1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 14:36:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91931144870so126084585a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783607805; x=1784212605; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=57uLOYP20ZPPo84vUbIDBb1y/EUle/1NhhYvvUaa2XQ=;
 b=jfujET0ETMjEZFJsnzfzZvR8wbuqjQFm5to75yNzu3xqF3Z128jwagg3/rhRaGBDKP
 eTQ8B6au1/voDJZWOlEdwqT+JqRD5dSbMxAf4d06JfHQ7GY5W0apdi3q9S8QdWq7HMU/
 KegF/fFNBdowJ3dgt3ZRgwkV2kHdE89HAx5rBfu+dPFYZ4XGNLgjjml6ThTXBtptRHnb
 l5QW7UV0+93mzMGUkRIO1WKDqwPgWhIvFb0sLhEpyvknu0brUMZh1wtwHkSJce3MdiPp
 2SqS5cgFf5NtzBpMbjwH8LmGJEnsstoijvSZ06gRauTgj4tM4VGUwAwExd+wRvcQjjhl
 wRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783607805; x=1784212605;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=57uLOYP20ZPPo84vUbIDBb1y/EUle/1NhhYvvUaa2XQ=;
 b=qd68bnE8Bp/0IRPPcto8AcY/QekuC6NlpkNUR7rtitk8S3jnD17+4doJHH+P5Gtkud
 DPYMH4dwLEZFjb7AZEDC3JgGoNKg1Mbc+Q+ibr4bOATl8EeB2hmdKgRZyhD2uDmY8JG6
 ALLjXkXLvUG42ShiEhameEMbmRRtMEp4TA0AEPi1/E5NaO1HW7UBxBhORUW4me0FAj0g
 PmqZf8YO0IuTrK1kGlIdlDwHCpeKuxXRUeJLKXgYy8QeVC7bYtErSt6IxCh/50nYlDMC
 Y/UW/+f00UAJE8fnSuZpe8aUJaoU6wB3PqrInU3zHC2LAVJd4zEsO62xMlM7CgixBOXN
 Mh8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPyMGQ6colm6lWHDfTsL2InGdUoCkBUpCELmbpzaRa80HItFbwDp5Ftsa2aKZU0uDGxI0xHiM0mclU@nongnu.org
X-Gm-Message-State: AOJu0YwICxL4I51/S5SXCOyxTfizjbC443NIAwtDlL9b7GMHkPgyEPdr
 koOZj5D8eKAYuVo1ApHN1KC1z/I6uiJFacVeqBbgbM4SvrhfpQPMQxXOrBm0nZDM1SM6ZA9k3q+
 1KtyGfZ4iFcDVB/T8pMfT3mhiO8t7J98dRfBA7LVKArV6LIwHOL88rmh0RA==
X-Gm-Gg: AfdE7cl2H0t07Xnj41TYX7OmO2IPcT4jFGhfPEMn9qA/Zthm5avRKJH7j4C+xtAWUn1
 +Y8epASpeJYKVkQXGKuEGE1NvERQZMtdwVN8o46AgE5sdh+YcfqvVrTlOB8sdMbuDSQN7emwXyG
 ZyDj7F0D7rtf+cYi+t8ipupH57mjVsKd7mIIJnHNpqSeMYWUF77J1rrWI76rN6s+/tVkRUoLfui
 ao1S1UCSqqg2feXVus3bO5AF+Wstr0DzRoToMCBrWf1wR4UDkWa/4fkwvaFYGDq3c0aRjGEwiSl
 ceSFQuIBPVWUVfw936Fva3/6mopJS//zzXwLZik0r0+bqS2V2YzU2u5Ni/g/BMoFvYq56BYA8po
 pdF2+bjlHztNWEyL+7fgnMmTpWRKe4RCf/YnzFAdQC8UowHP2CC7bLM5zF0cJhw==
X-Received: by 2002:a05:622a:1925:b0:51c:1b78:b03b with SMTP id
 d75a77b69052e-51c8b3b3f43mr91624141cf.52.1783607804595; 
 Thu, 09 Jul 2026 07:36:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1925:b0:51c:1b78:b03b with SMTP id
 d75a77b69052e-51c8b3b3f43mr91623651cf.52.1783607804031; 
 Thu, 09 Jul 2026 07:36:44 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ee2bcac0sm60657965e9.0.2026.07.09.07.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 07:36:43 -0700 (PDT)
Message-ID: <ef853a76-c96f-44e1-ba6e-474d87a75518@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 16:36:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/23] accel/hvf: Create hvf_protect_clean_range,
 hvf_unprotect_dirty_range
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Collingbourne <pcc@google.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20251103101034.59039-1-philmd@linaro.org>
 <20251103101034.59039-2-philmd@linaro.org>
 <7ba7afe0-1e89-480e-92f1-6a1682b56baf@oss.qualcomm.com>
 <8d0539a6-65aa-47d1-8885-daa3fa20fbe6@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <8d0539a6-65aa-47d1-8885-daa3fa20fbe6@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MyBTYWx0ZWRfXzOFg7nigzDic
 3DLSPkj+Hcu0LCn2E2jWIp933PWALJNi+9+G035MMKS51qW/J4+xtk85Iomnhh/XFE06yQJZA/v
 CXmDhuYh8UQeu0C8Pxiw0ZQvfCOkhSUZw3cnwtWRad34stVxmiyexLGzzDOCN5wge3ZzZP2QZyC
 KGD2AkKUjJZ8K5sfguOEj+3vfTGANYrglY1wxjAGYX3TH7L+eSVXE0C+YqeY7Smg2WdAxVPo15v
 y7yOFTdr7W9RS78gQvNb6maPpjWt3PxHvVSRrdOc0rsCzeccIAmctcKJ3gFqPKLMvGiMD9OAf7q
 QtzgbbSQ0L1erybhNExQkXRrWhAKvdTSMA4GcbOh6BVIFmd2rdL0i7n/ACket6qTETuPUZx5TI8
 ZYiiBHSn+KGI7eGiKCLfLQ1wwe8H9SmMNugSqv1qOVUAD9BI4NzhiIUfCc32mp3nTXzNeV2vLrG
 ugFHPZuQQ9dCzGF6RZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MyBTYWx0ZWRfX785Jta1KxDIG
 AmxTdMHIXiEE9ylPd6uYQl+6SwEt0prDSxPdc+mhQMdFWWgKnmg6qUSnWsWHTPTHsBNqCsIsTiA
 dZ1wXeRM9IBf8c5EsGs74+UxqE7065c=
X-Proofpoint-ORIG-GUID: H1c6XcIW9o1-ZLxXnJZrB77znNiLgy93
X-Proofpoint-GUID: H1c6XcIW9o1-ZLxXnJZrB77znNiLgy93
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4fb1fd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=pg2ERakl5tBgst9pSu8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 9/7/26 07:07, Akihiko Odaki wrote:
> On 2026/07/09 7:13, Philippe Mathieu-Daudé wrote:
>> On 3/11/25 11:10, Philippe Mathieu-Daudé wrote:
>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/system/hvf_int.h |  3 +++
>>>   accel/hvf/hvf-all.c      | 25 +++++++++++++++++++++++++
>>>   accel/hvf/trace-events   |  1 +
>>>   3 files changed, 29 insertions(+)
>>>
>>> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
>>> index 3d2be4092ef..5a57691885f 100644
>>> --- a/include/system/hvf_int.h
>>> +++ b/include/system/hvf_int.h
>>> @@ -89,6 +89,9 @@ int hvf_arch_get_registers(CPUState *);
>>>   /* Must be called by the owning thread */
>>>   void hvf_arch_update_guest_debug(CPUState *cpu);
>>> +void hvf_protect_clean_range(hwaddr addr, size_t size);
>>> +void hvf_unprotect_dirty_range(hwaddr addr, size_t size);
>>> +
>>>   struct hvf_sw_breakpoint {
>>>       vaddr pc;
>>>       vaddr saved_insn;
>>> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
>>> index 0a4b498e836..e13abddbd9c 100644
>>> --- a/accel/hvf/hvf-all.c
>>> +++ b/accel/hvf/hvf-all.c
>>> @@ -58,6 +58,31 @@ void assert_hvf_ok_impl(hv_return_t ret, const 
>>> char *file, unsigned int line,
>>>       abort();
>>>   }
>>> +static void do_hv_vm_protect(hwaddr start, size_t size,
>>> +                             hv_memory_flags_t flags)
>>> +{
>>> +    hv_return_t ret;
>>> +
>>> +    trace_hvf_vm_protect(start, size, flags,
>>> +                         flags & HV_MEMORY_READ  ? 'R' : '-',
>>> +                         flags & HV_MEMORY_WRITE ? 'W' : '-',
>>> +                         flags & HV_MEMORY_EXEC  ? 'X' : '-');
>>> +
>>> +    ret = hv_vm_protect(start, size, flags);
>>> +    assert_hvf_ok(ret);
>>
>> Maybe this assertion is a bit aggressive toward users, since while
>> we know the host limits, we don't know what the guest wants to do.
>>
>> I got:
>>
>> qemu-system-aarch64: Error: ret = HV_ERROR (0xfae94001, at ../../ 
>> accel/ hvf/hvf-all.c:77)
>>
>> Running with '-trace hvf_vm_map':
>>
>> hvf_vm_map paddr:0x0000000010000000 size:0x00020000 vaddr:0x104514000 
>> flags:0x07/RWX
>> hvf_vm_map paddr:0x0000000000000000 size:0x00020000 vaddr:0x104890000 
>> flags:0x07/RWX
>> hvf_vm_map paddr:0x0000000400000000 size:0x80000000 vaddr:0x380000000 
>> flags:0x07/RWX
>> hvf_vm_map paddr:0x0000000030bc0000 size:0x00040000 vaddr:0x1048b4000 
>> flags:0x07/RWX
>> hvf_vm_map paddr:0x0000000050bc0000 size:0x00040000 vaddr:0x1048f8000 
>> flags:0x07/RWX
>> hvf_vm_protect paddr:0x0000000430000000 size:0x00004000 flags:0x05/R-X
>> hvf_vm_protect paddr:0x0000000030000000 size:0x00004000 flags:0x05/R-X
>> qemu-system-aarch64: Error: ret = HV_ERROR (0xfae94001, at ../../ 
>> accel/ hvf/hvf-all.c:77)
>>
>> Should we propagate the error to upper layer?
>>
>> Are there cases we can safely ignore?
> I don't think this should be propagated to the guest. In this case the 
> failing hv_vm_protect() is for a GPA that was not mapped into HVF in the 
> first place.
> 
> The memory listener currently calls hvf_log_start() for every dirty-log 
> section, but hvf_set_phys_mem() intentionally skips some sections, for 
> example writable non-RAM regions where we want every access to trap. KVM 
> handles the equivalent case by looking up the matching slot and 
> returning if there is none.
> 
> So I think we should only ignore/skip protect for ranges that we know do 
> not have an HVF mapping. We should not ignore arbitrary hv_vm_protect() 
> failures for mapped RAM, because then dirty logging can miss writes or 
> keep faulting forever.
> 
> A fix probably needs factoring the same mappable section test used by 
> hvf_set_phys_mem() and using it in log_start, log_stop and log_clear.

Indeed, I am having a log_clear -> DIRTY_MEMORY_CODE call on a ROMD
device. In commit d1f4ba9d94c ("accel/hvf: Simplify hvf_set_phys_mem")
we removed this check:

      bool writable = !area->readonly && !area->rom_device;
      ...
-    if (area->readonly ||
-        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
-        flags = HV_MEMORY_READ | HV_MEMORY_EXEC;
-    } else {
-        flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
-    }
+    flags = HV_MEMORY_READ | HV_MEMORY_EXEC | (writable ? 
HV_MEMORY_WRITE : 0);

Maybe we should use back one of this helpers instead of accessing
MemoryRegion internal fields?

1473 static inline bool memory_region_is_romd(const MemoryRegion *mr)
1474 {
1475     return mr->rom_device && mr->romd_mode;
1476 }

1716 static inline bool memory_region_is_rom(const MemoryRegion *mr)
1717 {
1718     return mr->ram && mr->readonly;
1719 }

2697 static inline bool memory_access_is_direct(const MemoryRegion *mr,
2698                                            bool is_write, 
MemTxAttrs attrs)
2699 {
2700     if (!memory_region_supports_direct_access(mr)) {
2701         return false;
2702     }
2703     /* Debug access can write to ROM. */
2704     if (is_write && !attrs.debug) {
2705         return !mr->readonly && !mr->rom_device;
2706     }
2707     return true;
2708 }


