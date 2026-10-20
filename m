Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4C606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FxA2XaNw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aANdUNkp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJF5Y-0007Xt-WB; Tue, 20 Oct 2026 15:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJF5W-0007Xh-07
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:01:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJF5T-0005ce-MH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:01:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7K2v3460849
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3l8SzXSf3yWm0QzsZUWUVawYW9CEAm0GdfJOtcKchMs=; b=FxA2XaNwiM5jw5Bp
 s0P5Zq7LtGnX1ChYnytM7blDfNfUM2tMqa5eHf6a9lo1iDtTniYSrFkk5rBf14AV
 AicVnVGPQOjdog8rkLOCO1JLNezRM2Uc88MpSTKBbNpbNo8enDL1N+nM0TBpY8CY
 cMaVhjs7nt2JW1UycFgUL7BeVysTX3CPMJCIQJ3Fh/+GfQau6txhrbS00j5I3PMe
 +0gOeL08XjnB1NVe1lpmbN3RD/aak7VZ6h5++slAM3yT79Y5Ztb57Dmw6YIskQhC
 iXYI8yWYsHzAoz8ttD5YhsnAJPMX8kbl/+55zWPL70NEO4J9hcTb+S1ntfq2iHz2
 xc6A/A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4r6b2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:01:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so8746199eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792522884; x=1793127684; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3l8SzXSf3yWm0QzsZUWUVawYW9CEAm0GdfJOtcKchMs=;
 b=aANdUNkpI+PQxoPtuVA65/fpzVc9y6mkKRRVWWxmWjKHpldOdKvwl9a+P3dGKEWoWj
 SEOlQ/sr7g45M9odzQWIFIpoVKgDt9A+tb5FrFSQhB6jKnZm74JsknQIZjMhtP3DJs0h
 JR6e9WXEYw8Mr8thGmlW4XOesVZZlua46yEMQHOOm+XNGmEiM5AWapFIN7dhULzQF2lt
 uRMNO825dZJ5R87yxOYSF2mDcME45AbbjTZQ2Yhxkba9Xa7DyRDJ9tFyhMY4u1orakPF
 rvz5wdXAlxQrVCDWfQ1r+H6+wRJHu6nnSfUlbAQd4ck+dItstPL/WhnJNciEf3TDjGlh
 mGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792522884; x=1793127684;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3l8SzXSf3yWm0QzsZUWUVawYW9CEAm0GdfJOtcKchMs=;
 b=OeyIHGWQSIRk0E02qbyovQQcA8OlYUelAY+jqRlo/ZPsdOh+b+L2XKMOfzcul98uVT
 rq/Yb4Dv5ifYiPqeWybOfud2muoGEV5attWrn4ZNlayBxQgdI/c1PHL1oYKnweo3iDv1
 EVQbJP0XkgEQgzVj3bLAYVmTkXv+0DAB3+zdVegx7xbYxBDQdQqLYfiToTMm7hGuqJhU
 PVAd8thUO98r3oBZW779VpU/ECUkQ2QWStJzOb5abj0pTu8vbdnqoVtn7lck0NIT0X+n
 Vw6LiGg/BhU6xpQvhMal5AH2AjvYWI03MQo5gil4ZV9QtxnM6smYgVd/Q1X6/NGQRbRI
 YeZw==
X-Gm-Message-State: AFq9FYK2RDVq2x92UGf/dZ8+CWrQ75kWT4iUR7V6mL5xsFGk4EwJ7N50
 3+i4f0dOzApSQj2Cs8oMbR8bO2Gt7qqz6FAnMQwjASgxITRYa5/eFTq/vAggKdYJJiVzgkbfafD
 oSxjSR5EISiGQkXeBuDGOumeblnm89wGmiGG4sI7DMzItkbk+a4b80NX8Ew==
X-Gm-Gg: AYBFou1aw5lIVuBpXnIfiQDQI6Lufm3levOXUMMB0zHOzw1oc/SKVf88c/t1Jb3ISNG
 e2Y7QjEE8gvLdsxTJNzVZcXkg8Ac+fB8MqmsGa/QV54kHnwm8bfx3TB5fC9q2E8FKv4DlplJQAW
 V+lmFkdstAdKTa8QzdMOmlRQC0NnJ5tFxXt+VgOBX22vsUIlOUdd/p5k3nZ5cDB/warHUTsGvHc
 QRbJWj4Cj1fGL26g9BW6w1uL9d46V5OrP73XUpGFfFpVUaZBnHn2HT7EsVT6SPtpSQzDl/CpHDN
 6D4V1U/4TWmD8aJrRgATngck8Us2nDAqVzTSpJtO3NKq/U7cZ9IQYBXkhIMkPdNGWxEezcOPBRH
 ImZ+roOuX/OOw1/leFdyT6IBTcvitG044KlxRLCt9ga0cisCP6f8GjsY++xLIIBs4piDCrg==
X-Received: by 2002:a05:693c:20d1:10b0:361:aca0:522b with SMTP id
 5a478bee46e88-3674c43c26fmr231421eec.11.1792522882776; 
 Tue, 20 Oct 2026 12:01:22 -0700 (PDT)
X-Received: by 2002:a05:693c:20d1:10b0:361:aca0:522b with SMTP id
 5a478bee46e88-3674c43c26fmr231361eec.11.1792522881939; 
 Tue, 20 Oct 2026 12:01:21 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3674206d1f1sm501496eec.28.2026.10.20.12.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:01:21 -0700 (PDT)
Message-ID: <88a0135a-2be5-476d-9186-f11788ca4bee@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:01:20 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] cpus: Add helper to log raised exceptions with '-d
 int'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-2-philmd@oss.qualcomm.com>
 <7437c9ee-d1f5-452a-a456-d1dd7e1d268d@oss.qualcomm.com>
 <asYmU2H_J225oU2s@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <asYmU2H_J225oU2s@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ik8S2FPWAbfdZkDbHRZd46FlkanbxVNE
X-Proofpoint-GUID: ik8S2FPWAbfdZkDbHRZd46FlkanbxVNE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NSBTYWx0ZWRfX9ftmbwJdUAPU
 9TjvPtbaeIeROdlZab0yFqoNR2zhF2O6oAUbsb/MSsweAoHmXezKqzgaIQ7524GCpcRNeC4VU2U
 uXgrC30nVg0dIH6kwq+qQlvmJ9gH6W4=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad7ba85 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=dIlN4hCAs7lpxDMZrOkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NSBTYWx0ZWRfXx9RhrxdNEYN7
 Cb6EtGh32O/TKi7Ei7t8NX4MxCJqVZvUSPmeIBip4JRM+1EHakZMTh2yAW/uthvZ2UyVr8edvhk
 HFEJxlVMkQL66TrWyE0W0IF8vAwU9mRkbTXQPfA8fDhYMMJBpOVL/wBCGPW6/KW7NZCfUBMQxnG
 ptXPRQoNripWYdURhGGveI1eOSWOUZF715aax8myF5aApKrZVhFbRIMBRqRY0Qn2ujS8QmdQ86S
 X1maBpzMiAavUZs5Mx6Wq2l6sGSpwAzvzdhR9QLalCrqYgPYXRN2wLcGCRhyVfwfCFFVx74Z9c0
 HBwWB4CzJB76dDhWmoR8GXgSByR9lma8B2XesFIs8SKyKdMiKq4x2GUQSQ48wTlp2aI48TOXPHj
 XlCTE8T2GntEIsZHAKxQdpK1MhyBj3n9/ChBFoZ00bvHqKuJ0hDxZBO0Z7Yq6TGecIn5mukHhpQ
 XyA+4XndW/UIsqVz+/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/7/2026 4:00 AM, Daniel P. Berrangé wrote:
> On Wed, Oct 07, 2026 at 12:47:24PM +0200, Philippe Mathieu-Daudé wrote:
>> On 7/10/26 11:44, Philippe Mathieu-DaudÃ© wrote:
>>> Add log_raise_exception(), a common helper cpu_loop_*() can
>>> call to log a raised exception when '-d int' is used, and
>>> qemu_excp_name() to resolve QEMU-internal exceptions to names.
>>>
>>> Use it in cpu_loop_exit_atomic() to log the EXCP_ATOMIC reason.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>   accel/tcg/cpu-exec-common.c | 32 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
>>> index 68077c8fd9d..2ac8380d0bb 100644
>>> --- a/accel/tcg/cpu-exec-common.c
>>> +++ b/accel/tcg/cpu-exec-common.c
>>> @@ -89,6 +89,37 @@ void tcg_update_all_cflags(void)
>>>       }
>>>   }
>>> +#define EXCP_QEMU_INTERNAL 0x10000
>>> +
>>> +static const char *qemu_excp_name(int excp)
>>> +{
>>> +    static const char *excp_name[] = {
>>> +        [EXCP_INTERRUPT - EXCP_QEMU_INTERNAL] = "async interruption",
>>> +        [EXCP_HLT       - EXCP_QEMU_INTERNAL] = "hlt instruction",
>>> +        [EXCP_DEBUG     - EXCP_QEMU_INTERNAL] = "debug",
>>> +        [EXCP_HALTED    - EXCP_QEMU_INTERNAL] = "halted",
>>> +        [EXCP_YIELD     - EXCP_QEMU_INTERNAL] = "yield",
>>> +        [EXCP_ATOMIC    - EXCP_QEMU_INTERNAL] = "emulate atomic",
>>> +    };
>>> +    assert(excp >= EXCP_QEMU_INTERNAL);
>>> +    excp -= EXCP_QEMU_INTERNAL;
>>> +    if ((excp < ARRAY_SIZE(excp_name)) && excp_name[excp]) {
>>> +        return excp_name[excp];
>>> +    }
>>> +    return "undocumented";
>>> +}
>>> +
>>> +static void log_raise_exception(const CPUState *cpu, int excp)
>>> +{
>>> +    if (!qemu_loglevel_mask(CPU_LOG_INT)) {
>>> +        return;
>>> +    }
>>> +    if (excp >= EXCP_QEMU_INTERNAL) {
>>> +        qemu_log_mask(CPU_LOG_INT, "raise exception: 0x%x (internal: %s)\n",
>>> +                                   excp, qemu_excp_name(excp));
>>
>> Daniel suggested on IRC we can use target_name() here to distinguish
>> between different kinds of vCPUs. Alternatively we can add a
>> CPUClass::log_friendly_format_name() defaulting to current "%p index:%d"
>> but overwritable i.e. as "accel:%s target:%s cluster:%d index:%u", so
>> each time we log something on a vCPU context we have an unified prefix
>> format to parse.
> 
> That would be problematic. Those two different format strings have
> different args. Also since it is not a static string, it can't be
> concatenated with the format strnig being passed to qemu_log_mask().
> So that would imply sprintf'ing the CPU format string prefix first
> with whatever args it needs, before passing the result into the
> qemu_log_mask() call.
> 
>      g_autofree char *prefix = g_strdup_printf(
>          "accel:%s target:%s cluster:%d index:%u",
> 	 accel, targe,t cluster, index);
>      cpu_log_mask(CPU_LOG_INT,
>                   "%s raise exception: 0x%x (internal: %s)\n",
>                   prefix, excp, qemu_excp_name(excp));
> 
> the double layers of printf makes logging quite unpleasant,
> and while it could be hidden in a macro, the runtime overhead
> still exists.
> 
> On IRC, I suggested an approach that would work at the preprocessor
> level to concatenate the arch target name at compile time on to the
> front of all log messages, so there is no runtime impact at all,
> nor any code impact beyond s/qemu_log_mask/qemu_log_mask_target/.
> 
> #define  qemu_log_mask_target(MASK, FMT, ...)           \
>     do {                                                \
>         if (unlikely(qemu_loglevel_mask(MASK))) {       \
>           qemu_log(TARGET_NAME # FMT, ## __VA_ARGS__);\
>          }                                               \
>     } while (0)
> 
> Note, TARGE_NAME is poisoned, so we can't add this to to main
> include/qemu/log.h file. It would need to live in a header file
> that is built per-target, and thus only used from target specific
> code like the TCG impls. 
> 
> As a slight variation, *if* we can assume each target arch's VCPUs
> are in a separate thread, we could avoid using TARGET_NAME directly
> and instead use a thread local
> 
>   __thread const char *target_name;
> 
> ...which would be initialized to TARGET_NAME when the vcpu's thread
> starts.
> 
> Then  we would change the macro to be 
> 
> #define  qemu_log_mask_target(MASK, FMT, ...)           \
>     do {                                                \
>         if (unlikely(qemu_loglevel_mask(MASK))) {       \
>           qemu_log("%s" # FMT, target_name, ## __VA_ARGS__);\
>          }                                               \
>     } while (0)
> 
> That would make it possible to include more dynamic information
> by adding more thread-locals and hiding more fmt args in the
> macro.
> 
> With regards,
> Daniel

Similar to Yonggang's answer, we already have this as target_name()
function. It's statically initialized as part of TargetInfo structure,
and the access is just a function call + structure indirection. I doubt
any tracing benchmark can expose a slowdown that is not in standard
deviation.

Regards,
Pierrick

