Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E56EC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whaWa-0007Kr-Kq; Wed, 08 Jul 2026 18:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whaWZ-0007Kg-P5
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:13:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whaWX-0003pc-UJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:13:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668KtGAI3802096
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 22:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bYX3KACLVoJS6QH6ugDFeTZ55tWn/+xOhRkcAwPj6Sk=; b=gDJd4DA8332pooo0
 rf4PhX46FFFIdECh02M30mKrBCO+7EG0j9bbpIOyYEERXfDfR2ST2Z6l/JLEKz7W
 YBcopWAcjSee6I2IP88l8Ft429osLVYOXfCzf/eUloPJ9YBTuF/gn+5M+TpYH6BC
 QBuQO8v/SegKdR7jA4kpblZauBRV9cXxn5H7rVA9Aqxz8liznAWFlahF9PHvaLOJ
 PxhFuen9WvjZGxKem5DjA6XZGtOO4RoSpV6rj2TgIgDzQR+gZdTzSqs5ZkPa8alS
 Cs/dvP+7p03rFhONch/32PxNwXVyM3MKXfQa2GQmHpnh6MsYypjRLJ6wYB/MtfBb
 xdcb4A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u0mv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:13:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso3509051cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783548823; x=1784153623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bYX3KACLVoJS6QH6ugDFeTZ55tWn/+xOhRkcAwPj6Sk=;
 b=JsN+2NuyziZCrSGRr8ZNcPf3lbzl9TXA/v+g5vW3KJvX/QoE5Qu9qDd/HbScTf7x07
 tVLOPC+/5MN7a4ZFWuDcCiIRd5i9hu1n+KA1QTnZBzEf7RiMx3vMR6Z/4+VWtFKADQvL
 TQDodxeQ9YUNwetDzzG4Wz8HgrF7DyBKhoR8jIfCmzlgbk2/HEzpSsVcCKK1mJw/OQ6e
 ww7SHvGl1+6iMQtYQtt5oQwy6452afckDdoLC+eIjzmrXx56TLL0Rt4yApm2/NRQHAFd
 4HjWEKjBdWmtS8rfSx7p5+vtTfFeA2ZqSRUxFcPow0ru2K8gBp6yMMBYvI0O0oM2gbIE
 9ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783548823; x=1784153623;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bYX3KACLVoJS6QH6ugDFeTZ55tWn/+xOhRkcAwPj6Sk=;
 b=YixVRzOfVWQDybRRQ/1thGOsmpRgXnG/Tu8SBnPOXUc57low9CGj6uO9ATfWgEqDNT
 AmPBi1ZBe6LR8mKksGXQ8qQ82qYryk324h1m8hUfik4E2+6+ZPaHcZP0j0jSPcC38G87
 IPd51YJChYWZRH45DaXShlkY6MYFmS3z7onzFMO8fu/AhcuhReg4qwPyOM0Jxhdxyizo
 OrgzDWugJCCniH6GgPaTn3dEZpIMtPxwg9FQab8O2MYRSMykJF1ETGN2+S7OVQcyCFRZ
 qVFVVSztuYxBsDk6Ongb9qNfms1WDTNcuKBhsCrAjp+hIaFa2V/knO7fShMnJn0fKXhq
 HK2g==
X-Gm-Message-State: AOJu0Yw9h37n+oC06n3lbDFzA0GfFumzt2w68EOS7Gb7xgBfOnclx7Md
 smEuC+wSGXjuRLTyN9swf2CrIUTWC6EtkVLP0CXKOM1BkXQR5MTry/C5Brr2D3G/5nO+/TOw5Jc
 gjiT7CN4vrzAyFpb2mxJuYa2sKaTCFK1zxN+YcMsXtzBtTjkpyWxCCMzFQvlcgPmTrQ==
X-Gm-Gg: AfdE7ck9VKxD06exv8qHiBTlNDLnD5nIosPof2FLIljI1KllB4Be611u6XxWz85cO9j
 pVGdl9nBRsy4FrC+d6aHVes43ZNLoqrTEb0MLw/8/UxOg+OnUXVSKSaBZq7VOJyjJhfrRgBsuMe
 NS99gCTDC+Fo1JDx9+hHTg9mv73fpCTDQQuYqRhUnKOcIeWrQ74IoDAZHW/MtaFXu/8eDFMaumo
 xTBZ5JM81xN/Cqm2CzNCwLwAkOCd2AO/7VJO1UrSxxzHMQOM7n23+ATF0xu4rgsCXYJDWLd2FLH
 oLKg0ksBYmCYjgiAWGHlfPysFeMxzT2aPUbeAczFyXnZjf4aUrmwtSSHFlB3QooC8fRi2bfd+fH
 tVqMlen+QHX1jiKyw9h1eYWX+uvZFbyug1Py2WcJsOtqbPaDh/tpN4uT7sI2Vuw==
X-Received: by 2002:ac8:7e8f:0:b0:51c:7b12:5fda with SMTP id
 d75a77b69052e-51c8b438e93mr51306531cf.86.1783548822150; 
 Wed, 08 Jul 2026 15:13:42 -0700 (PDT)
X-Received: by 2002:ac8:7e8f:0:b0:51c:7b12:5fda with SMTP id
 d75a77b69052e-51c8b438e93mr51305911cf.86.1783548821419; 
 Wed, 08 Jul 2026 15:13:41 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a6240fsm65234225e9.2.2026.07.08.15.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 15:13:40 -0700 (PDT)
Message-ID: <7ba7afe0-1e89-480e-92f1-6a1682b56baf@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 00:13:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/23] accel/hvf: Create hvf_protect_clean_range,
 hvf_unprotect_dirty_range
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Collingbourne <pcc@google.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20251103101034.59039-1-philmd@linaro.org>
 <20251103101034.59039-2-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20251103101034.59039-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIxOCBTYWx0ZWRfX+hwxgQK5dHEH
 LKcgF7621ufx4JS2pcqINm56kr24S4Fjai0ceGKWS8ZvRL70x4bwep62juFBPsTEPx6yX6fYzI3
 fa1Gcx3qK4NQgf4r+76BoorxjDTUmUg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIxOCBTYWx0ZWRfX0a2Ahaw1kO3R
 5GeSEsAIO+gt0w7WEkErxgzk9hfE1bWXBT5iKwjo85dFg8Bqz7+U9gPi9avNv98QnFyhmfXLncJ
 payM6lJuvtoC54T6yyxsJC4PG+3NdGwhE+cpPUaJdI7z/PI0iFjC7Sxkz8lZjzn/3sNzNT+XYVl
 9TH5BzYFuEhMXWJiU1yvLhYmWUQ6hlI+9DX8jXXFjCKMgt6btcdgxUegfC8OZu3J6WRIAMsMDe6
 qFI0PM+M7QXDEWNkUQsE/xME2GqmzQr0s+/LioOyXSwEa8TN6axZR1JCcmjFnCLdC9nJoKfKmog
 sowpbbWX9YlY9amuf1EOa8HuRXyjVSp2BqzctYvDqSrINXITMF6Q4eek7BD4JgH0QDJzj/b0wCZ
 9YD2Kn5XNe10cD1net8nLIlcHhw7rzTt4l0/guT/5YaYmstvqovZoKhAmurO5YYh9viBk/PlGtB
 FYSwd6PSaCe8c3tdc+Q==
X-Proofpoint-GUID: AxHC3Yg88yaqR0W1jJKteAAPXVptskto
X-Proofpoint-ORIG-GUID: AxHC3Yg88yaqR0W1jJKteAAPXVptskto
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4ecb98 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=TsVdnq78nccsToMOntQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080218
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 3/11/25 11:10, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf_int.h |  3 +++
>   accel/hvf/hvf-all.c      | 25 +++++++++++++++++++++++++
>   accel/hvf/trace-events   |  1 +
>   3 files changed, 29 insertions(+)
> 
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 3d2be4092ef..5a57691885f 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -89,6 +89,9 @@ int hvf_arch_get_registers(CPUState *);
>   /* Must be called by the owning thread */
>   void hvf_arch_update_guest_debug(CPUState *cpu);
>   
> +void hvf_protect_clean_range(hwaddr addr, size_t size);
> +void hvf_unprotect_dirty_range(hwaddr addr, size_t size);
> +
>   struct hvf_sw_breakpoint {
>       vaddr pc;
>       vaddr saved_insn;
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 0a4b498e836..e13abddbd9c 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -58,6 +58,31 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
>       abort();
>   }
>   
> +static void do_hv_vm_protect(hwaddr start, size_t size,
> +                             hv_memory_flags_t flags)
> +{
> +    hv_return_t ret;
> +
> +    trace_hvf_vm_protect(start, size, flags,
> +                         flags & HV_MEMORY_READ  ? 'R' : '-',
> +                         flags & HV_MEMORY_WRITE ? 'W' : '-',
> +                         flags & HV_MEMORY_EXEC  ? 'X' : '-');
> +
> +    ret = hv_vm_protect(start, size, flags);
> +    assert_hvf_ok(ret);

Maybe this assertion is a bit aggressive toward users, since while
we know the host limits, we don't know what the guest wants to do.

I got:

qemu-system-aarch64: Error: ret = HV_ERROR (0xfae94001, at 
../../accel/hvf/hvf-all.c:77)

Running with '-trace hvf_vm_map':

hvf_vm_map paddr:0x0000000010000000 size:0x00020000 vaddr:0x104514000 
flags:0x07/RWX
hvf_vm_map paddr:0x0000000000000000 size:0x00020000 vaddr:0x104890000 
flags:0x07/RWX
hvf_vm_map paddr:0x0000000400000000 size:0x80000000 vaddr:0x380000000 
flags:0x07/RWX
hvf_vm_map paddr:0x0000000030bc0000 size:0x00040000 vaddr:0x1048b4000 
flags:0x07/RWX
hvf_vm_map paddr:0x0000000050bc0000 size:0x00040000 vaddr:0x1048f8000 
flags:0x07/RWX
hvf_vm_protect paddr:0x0000000430000000 size:0x00004000 flags:0x05/R-X
hvf_vm_protect paddr:0x0000000030000000 size:0x00004000 flags:0x05/R-X
qemu-system-aarch64: Error: ret = HV_ERROR (0xfae94001, at 
../../accel/hvf/hvf-all.c:77)

Should we propagate the error to upper layer?

Are there cases we can safely ignore?

> +}
> +
> +void hvf_protect_clean_range(hwaddr addr, size_t size)
> +{
> +    do_hv_vm_protect(addr, size, HV_MEMORY_READ | HV_MEMORY_EXEC);
> +}
> +
> +void hvf_unprotect_dirty_range(hwaddr addr, size_t size)
> +{
> +    do_hv_vm_protect(addr, size,
> +                     HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
> +}
> +
>   static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
>   {
>       struct mac_slot *macslot;
> diff --git a/accel/hvf/trace-events b/accel/hvf/trace-events
> index 2fd3e127c74..f989da59492 100644
> --- a/accel/hvf/trace-events
> +++ b/accel/hvf/trace-events
> @@ -5,3 +5,4 @@
>   # hvf-accel-ops.c
>   hvf_vm_map(uint64_t paddr, uint64_t size, void *vaddr, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08"PRIx64" vaddr:%p flags:0x%02x/%c%c%c"
>   hvf_vm_unmap(uint64_t paddr, uint64_t size) "paddr:0x%016"PRIx64" size:0x%08"PRIx64
> +hvf_vm_protect(uint64_t paddr, size_t size, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08zx flags:0x%02x/%c%c%c"


