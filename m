Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FAB606D801
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UM31G+/H;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E/w42ZE/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQPM-0007g1-QO; Fri, 06 Nov 2026 15:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPQPG-0007dr-1v
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:19:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPQPB-0006MN-41
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:19:24 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6JLU4S1700609
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 20:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xwISUpyAi2ZGvqd3CDOAyqcLYtMvgMyAjxQEWHiek/M=; b=UM31G+/HXFMkGc1G
 sVt9Xn/jZjXfpP5sVodQ/5K4VjlPKFefjgGsijr9/YI/34tp8G+0lK/zf2iXBoQG
 cD/LKiwrohvtAWwPTSeqVVKVlmDlZka8O09QNL8uWzA2iOW7OM+HWZwFRXx48Bfr
 nJ9D6oQW8e4MEWnnD8nLYE9+g0BHtPjroHxYTyeyaG2uHKHkWlzXkDSqYg3y9hp5
 btGfI0Q0V9uermVQU/dbmXZ+MFWw1vQkD6OMf2Q+/4ppBCirgNMBx3IYTH43bE92
 DxTLUWCWUSe7SKMm2bp/248hlbpgGpxol7zWVg8MLyiUbeRXlr9tH11gpU61ENFN
 179D3A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmypg78t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 20:19:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-370230d93efso940213eec.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793996358; x=1794601158; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xwISUpyAi2ZGvqd3CDOAyqcLYtMvgMyAjxQEWHiek/M=;
 b=E/w42ZE/hIsKYggmZ83XBLCCYZ+LwYYLTn/P/QLubCCNJsWiwxMlw7PfxqOXFYBy3K
 5/uQPKTzU1oXrvPErQUxjch1ne3sBL0fMzYRqLSUUTYf9qzET47B1nnsGKitL7VCKJkp
 gnJlOggoyt+35fkMt5+IAbaGowkLNv/ihdebLOoBgFk83GXWU9n00RbSWgLZ8MPTSJN0
 aQrN0ydhQDTbUYixNJSHTVjzgQeRhM/RRr6/NrMQby2/UH8mCWMyOKbE1up7C4Inr9vc
 uVWIGC9lCa5rOtxsdMzJQZdMYVNnbtaFrV/zJCa+H0n7onRwkEHATLE78MrX3BGB1mwk
 q3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793996358; x=1794601158;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xwISUpyAi2ZGvqd3CDOAyqcLYtMvgMyAjxQEWHiek/M=;
 b=x5ahgn0nUbvhS0kV3lzVkSMSyo9A3EOTnVmzha4EREFStWgDw3kSuYwPqTIq7yVT7u
 RJxfw0M81dRSDy27RrNpT2xDSh4FFyIu4sexZf9D/5cGo3cPoQ8dGlqDnP5rXuCWxiEp
 6qj+bFObtaZywVaKshRGfUpWqGzfnYzLM47XPDsnFHDs+I78w6GI3KhfQT3sWTPjoXH1
 XeBxYMCQwiGgK71UkgOqDRk19/QSpsh+Ot2Zxf1vxq+xA9j6B0Y5l3+zjmgLapz3j7bd
 Gc19X8vJpbyHJ7F6IhR0Xj0Xz2ZO0KhfL4XNZIQAeKrmmEP19umMFlM0seBiUfE+RZNQ
 1JEA==
X-Gm-Message-State: APuU4Z8YMaVRT27DLA681o+83/m+S6PF5J8V0X8wesuE8pRv16FNP0+V
 5h2yQAdTGp6qQ84sJHXptGL4Fbj5axxaeCNfMMPWBio1TgMd3UgVeq6nypw5uw2+hTJ7HV8ZUM1
 u2Jp+x9QSZ4MfBbQ0CZS7wuwJ9BsGD+f0Ho/RsdHvhFh4aumTtw2MA3RDeA==
X-Gm-Gg: AYBFou28YWBZuvBW1/TuETXMlWNH6urp9sTfyadeC62Oani9EPTu7fvzYspZo+7wDG4
 sXbAVCRXEeQQPWvz78N6dtB92zqtqLmroO6ACUeLDsfn/uubwDMq2OLLYjGqEYGnMB3N1Dfx9MD
 UDR8fwtIBpYVNTuovyf8RCVRr9dTvMsz924zfLWBFurjlVGGWLmO7bmta/JDAklA/KQuTVabmm/
 IYgUX5fFrYOhpu5Eui12V6G+kFaWeVhY0qIzDOz8ij+ONuE1G//qX2V1d5dCgGLwWfe2PJPiXSh
 gQM0HA80bqExb/RaMD3uugENOEzVYgljzm97pPS8MEG5F05pRjz8uN4Ipn5Y/2ZmW+ByvPzbexb
 ZBNeX78zJkaZNnu8AB/M8xhLkkIz+iRdAV6fIEKqS0VsQbLSCrE1M3jjBPdBcGdSsrrKBx6Sqma
 eL7yRzYpHaikhF5mbx95PGEEUfTRxJTAerA2x+lWPbeg==
X-Received: by 2002:a05:693c:8847:b0:369:21a:dcca with SMTP id
 5a478bee46e88-36f75440b8fmr5643048eec.10.1793996356673; 
 Fri, 06 Nov 2026 12:19:16 -0800 (PST)
X-Received: by 2002:a05:693c:8847:b0:369:21a:dcca with SMTP id
 5a478bee46e88-36f75440b8fmr5642972eec.10.1793996355478; 
 Fri, 06 Nov 2026 12:19:15 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa9fc92fasm11538595eec.19.2026.11.06.12.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 12:19:14 -0800 (PST)
Message-ID: <13f5730a-1a3a-42db-9b04-7e00249e7260@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 12:19:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target-info: add target_mask_selected()
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
References: <20261105190346.1539-1-luoyonggang@gmail.com>
 <20261105190346.1539-3-luoyonggang@gmail.com>
 <f84768d9-1aa4-463d-a0f5-4844a4babe22@oss.qualcomm.com>
 <CAE2XoE_u9AhjKZxtocf-e=8SjgiJ5gURxJVmwoXHTu6uKWK9+g@mail.gmail.com>
 <93d749b2-aa50-4cdf-9343-7d7a11bc6a8c@oss.qualcomm.com>
 <CAE2XoE_rbBgArumXgWbG+GynNFF31248F_sB-nG+T4BEZjBPpQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_rbBgArumXgWbG+GynNFF31248F_sB-nG+T4BEZjBPpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX7NogyDp698rV
 Dsr1AK3CoHQM1L0Cs9tgo5/NYS4KkWfCRpKYnKIMcx0Onsj0qlHrtME6JQ5DhiMPDVSAoMHrVjP
 y4LxXcdLlm4TnYapnaproeN735nYC9Q/PaCYMOi5xevmpJ1Ze+lDtc8UQpbP97sA+lSjIZz2e5K
 ziwhEvQhC+VaNBIxjUR20kgVYFxO60PkXRhD46ZpgQS0dlRsYyX3Sjej4voOWfWRYynN1fV/GeF
 7fjw9mY6V7Q+k/+FftJjQF/LorQyuHOZAREQ4Gfxmbi2aVnnIFG5pFlwTqgLW13JbpYT5oeFNnO
 wCginwhAd9XWjGuIQjW7zu88pXlbsyrhQ2Qk7V5aPU3RDY5sgilWuToyS4E6WrgHTvlpzz3LQGa
 nLk9u1mBKoeE3BbzORlgmO5Uou722LfpyIuGTX6MB4lCptM9NoDI7dbIN12/j+corm/RGvyDQRf
 qVAhG58cL4n96nB5vuw==
X-Proofpoint-GUID: nxqYWNag9OzmlgplyrmMXdbcCz5PSkPO
X-Proofpoint-ORIG-GUID: nxqYWNag9OzmlgplyrmMXdbcCz5PSkPO
X-Authority-Analysis: v=2.4 cv=TZ4DJhQh c=1 sm=1 tr=0 ts=6aee3646 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VlI1i-Ewzn7X5AAbD80A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX8nC5hMmD+0Mf
 FuOvQ9X54MizlvyqKoOFY4LZt52msu9Sd/YSPR5IpGVybvcTMg7gfJbt+BwB8kYyM2uoq7tdCX6
 qBlHt4i/h17M5hQIprDtWMFUsOpZWt4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060080
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

On 11/6/2026 11:52 AM, Yonggang Luo wrote:
> On Sat, Nov 7, 2026 at 1:47 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 11/6/2026 9:46 AM, Yonggang Luo wrote:
>>> On Sat, Nov 7, 2026 at 1:44 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 11/5/2026 11:03 AM, Yonggang Luo wrote:
>>>>> Return the QEMU_ARCH_* mask of the selected target. System mode
>>>>> returns QEMU_ARCH_ALL until a target is selected. User mode returns
>>>>> that target's bit. Tools return 0.
>>>>>
>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>> ---
>>>>>  include/qemu/target-info-init.h | 15 ++++++++++-----
>>>>>  include/qemu/target-info.h      |  9 +++++++++
>>>>>  stubs/meson.build               |  1 +
>>>>>  stubs/target-mask-selected.c    | 13 +++++++++++++
>>>>>  target-info-def.c               |  3 +++
>>>>>  target-info-qom.c               | 10 ++++++++++
>>>>>  6 files changed, 46 insertions(+), 5 deletions(-)
>>>>>  create mode 100644 stubs/target-mask-selected.c
>>>>>
>>>>> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
>>>>> index b7024c9fae..8492986832 100644
>>>>> --- a/include/qemu/target-info-init.h
>>>>> +++ b/include/qemu/target-info-init.h
>>>>> @@ -24,12 +24,17 @@ module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
>>>>>
>>>>>  /*
>>>>>   * User mode does not support multiple targets in the same binary, so just
>>>>> - * define target_info().
>>>>> + * define target_info() and target_mask_selected(). The target is always
>>>>> + * selected.
>>>>>   */
>>>>> -#define target_info_init(ti_var)        \
>>>>> -const TargetInfo *target_info(void)     \
>>>>> -{                                       \
>>>>> -    return &ti_var;                     \
>>>>> +#define target_info_init(ti_var)                           \
>>>>> +const TargetInfo *target_info(void)                        \
>>>>> +{                                                          \
>>>>> +    return &ti_var;                                        \
>>>>> +}                                                          \
>>>>> +uint64_t target_mask_selected(void)                        \
>>>>> +{                                                          \
>>>>> +    return QEMU_ARCH_BIT((ti_var).target_arch);            \
>>>>>  }
>>>>>
>>>>>  #else /* CONFIG_USER_ONLY */
>>>>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>>>>> index 2cd4cc5671..5673d10eba 100644
>>>>> --- a/include/qemu/target-info.h
>>>>> +++ b/include/qemu/target-info.h
>>>>> @@ -134,4 +134,13 @@ bool target_base_riscv(void);
>>>>>   */
>>>>>  bool target_riscv64(void);
>>>>>
>>>>> +/**
>>>>> + * target_mask_selected:
>>>>> + *
>>>>> + * Returns the QEMU_ARCH_* mask of the selected target. System mode
>>>>> + * returns QEMU_ARCH_ALL until a target is selected. User mode returns
>>>>> + * that target's bit. Tools return 0.
>>>>> + */
>>>>> +uint64_t target_mask_selected(void);
>>>>> +
>>>>>  #endif
>>>>> diff --git a/stubs/meson.build b/stubs/meson.build
>>>>> index 744fb759a2..49cede8582 100644
>>>>> --- a/stubs/meson.build
>>>>> +++ b/stubs/meson.build
>>>>> @@ -12,6 +12,7 @@ stub_ss.add(files('monitor-hmp.c'))
>>>>>  stub_ss.add(files('qapi-event-emit.c'))
>>>>>  stub_ss.add(files('replay-mode.c'))
>>>>>  stub_ss.add(files('trace-control.c'))
>>>>> +stub_ss.add(files('target-mask-selected.c'))
>>>>>
>>>>
>>>> For which configs is the stub required?
>>>> target-info-def will always be present.
>>>
>>> For tools
>>>
>>
>> Can you post the exact link error that exposes the absence of this symbol?
> 
> There is very much, I extract part of them:
> 
> 
> [61/389] Linking target tests/fp/fp-test
> FAILED: [code=1] tests/fp/fp-test
> gcc -m64  -o tests/fp/fp-test
> libevent-loop-base.a.p/event-loop-base.c.o
> libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o
> libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o
> libqom.a.p/qom_compat-properties.c.o tests/fp/fp-test.p/fp-test.c.o
> tests/fp/fp-test.p/.._.._fpu_softfloat.c.o -Wl,--as-needed
> -Wl,--no-undefined -pie -fstack-protector-strong -Wl,-z,relro
> -Wl,-z,now -Wl,--start-group libqemuutil.a
> subprojects/libvhost-user/libvhost-user-glib.a
> subprojects/libvhost-user/libvhost-user.a
> subprojects/berkeley-softfloat-3/libsoftfloat.a
> subprojects/berkeley-testfloat-3/libtestfloat.a
> subprojects/berkeley-testfloat-3/libslowfloat.a -lnuma
> /usr/lib/x86_64-linux-gnu/liburing.so
> /usr/lib/x86_64-linux-gnu/libgio-2.0.so
> /usr/lib/x86_64-linux-gnu/libgobject-2.0.so
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so -Wl,--export-dynamic
> /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread -lm
> /usr/lib/x86_64-linux-gnu/libpixman-1.so
> /usr/lib/x86_64-linux-gnu/libepoxy.so -Wl,--end-group
> /usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
> function `type_register_internal':
> /build/release-amd64/../../qom/object.c:243:(.text+0x1c2): undefined
> reference to `target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
> function `target_mask_filter':
> /build/release-amd64/../../qom/object.c:120:(.text+0x1df): undefined
> reference to `target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd:
> /build/release-amd64/../../qom/object.c:120:(.text+0x37a): undefined
> reference to`target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd:
> /build/release-amd64/../../qom/object.c:120:(.text+0x1ebf): undefined
> reference to `target_mask_selected'
> collect2: error: ld returned 1 exit status
> [62/389] Linking target tests/bench/benchmark-crypto-akcipher
> FAILED: [code=1] tests/bench/benchmark-crypto-akcipher
> gcc -m64  -o tests/bench/benchmark-crypto-akcipher
> libevent-loop-base.a.p/event-loop-base.c.o
> libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o
> libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o
> libqom.a.p/qom_compat-properties.c.o libcrypto.a.p/crypto_afsplit.c.o
> libcrypto.a.p/crypto_akcipher.c.o libcrypto.a.p/crypto_block-luks.c.o
> libcrypto.a.p/crypto_block-qcow.c.o libcrypto.a.p/crypto_block.c.o
> libcrypto.a.p/crypto_cipher.c.o libcrypto.a.p/crypto_der.c.o
> libcrypto.a.p/crypto_hash.c.o libcrypto.a.p/crypto_hmac.c.o
> libcrypto.a.p/crypto_ivgen-essiv.c.o
> libcrypto.a.p/crypto_ivgen-plain.c.o
> libcrypto.a.p/crypto_ivgen-plain64.c.o libcrypto.a.p/crypto_ivgen.c.o
> libcrypto.a.p/crypto_pbkdf.c.o libcrypto.a.p/crypto_secret_common.c.o
> libcrypto.a.p/crypto_secret.c.o libcrypto.a.p/crypto_tlscreds.c.o
> libcrypto.a.p/crypto_tlscredsanon.c.o
> libcrypto.a.p/crypto_tlscredspsk.c.o
> libcrypto.a.p/crypto_tlscredsx509.c.o
> libcrypto.a.p/crypto_tlssession.c.o libcrypto.a.p/crypto_rsakey.c.o
> libcrypto.a.p/crypto_x509-utils.c.o
> libcrypto.a.p/crypto_hash-nettle.c.o
> libcrypto.a.p/crypto_hmac-nettle.c.o
> libcrypto.a.p/crypto_pbkdf-nettle.c.o
> libcrypto.a.p/crypto_secret_keyring.c.o libauthz.a.p/authz_base.c.o
> libauthz.a.p/authz_list.c.o libauthz.a.p/authz_listfile.c.o
> libauthz.a.p/authz_simple.c.o
> tests/bench/benchmark-crypto-akcipher.p/benchmark-crypto-akcipher.c.o
> -Wl,--as-needed -Wl,--no-undefined -pie -fstack-protector-strong
> -Wl,-z,relro -Wl,-z,now -Wl,--start-group libqemuutil.a
> subprojects/libvhost-user/libvhost-user-glib.a
> subprojects/libvhost-user/libvhost-user.a
> /usr/lib/x86_64-linux-gnu/libnettle.so
> /usr/lib/x86_64-linux-gnu/libgmp.so
> /usr/lib/x86_64-linux-gnu/libhogweed.so -lnuma
> /usr/lib/x86_64-linux-gnu/liburing.so
> /usr/lib/x86_64-linux-gnu/libgio-2.0.so
> /usr/lib/x86_64-linux-gnu/libgobject-2.0.so
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so -Wl,--export-dynamic
> /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread -lm
> /usr/lib/x86_64-linux-gnu/libpixman-1.so
> /usr/lib/x86_64-linux-gnu/libepoxy.so -Wl,--end-group
> /usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
> function `type_register_internal':
> /build/release-amd64/../../qom/object.c:243:(.text+0x1c2): undefined
> reference to `target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
> function `target_mask_filter':
> /build/release-amd64/../../qom/object.c:120:(.text+0x1df): undefined
> reference to `target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd:
> /build/release-amd64/../../qom/object.c:120:(.text+0x37a): undefined
> reference to`target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd:
> /build/release-amd64/../../qom/object.c:120:(.text+0x1ebf): undefined
> reference to `target_mask_selected'
> collect2: error: ld returned 1 exit status
> [63/389] Linking target tests/bench/benchmark-crypto-hash
> FAILED: [code=1] tests/bench/benchmark-crypto-hash
> gcc -m64  -o tests/bench/benchmark-crypto-hash
> libevent-loop-base.a.p/event-loop-base.c.o
> libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o
> libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o
> libqom.a.p/qom_compat-properties.c.o libcrypto.a.p/crypto_afsplit.c.o
> libcrypto.a.p/crypto_akcipher.c.o libcrypto.a.p/crypto_block-luks.c.o
> libcrypto.a.p/crypto_block-qcow.c.o libcrypto.a.p/crypto_block.c.o
> libcrypto.a.p/crypto_cipher.c.o libcrypto.a.p/crypto_der.c.o
> libcrypto.a.p/crypto_hash.c.o libcrypto.a.p/crypto_hmac.c.o
> libcrypto.a.p/crypto_ivgen-essiv.c.o
> libcrypto.a.p/crypto_ivgen-plain.c.o
> libcrypto.a.p/crypto_ivgen-plain64.c.o libcrypto.a.p/crypto_ivgen.c.o
> libcrypto.a.p/crypto_pbkdf.c.o libcrypto.a.p/crypto_secret_common.c.o
> libcrypto.a.p/crypto_secret.c.o libcrypto.a.p/crypto_tlscreds.c.o
> libcrypto.a.p/crypto_tlscredsanon.c.o
> libcrypto.a.p/crypto_tlscredspsk.c.o
> libcrypto.a.p/crypto_tlscredsx509.c.o
> libcrypto.a.p/crypto_tlssession.c.o libcrypto.a.p/crypto_rsakey.c.o
> libcrypto.a.p/crypto_x509-utils.c.o
> libcrypto.a.p/crypto_hash-nettle.c.o
> libcrypto.a.p/crypto_hmac-nettle.c.o
> libcrypto.a.p/crypto_pbkdf-nettle.c.o
> libcrypto.a.p/crypto_secret_keyring.c.o libauthz.a.p/authz_base.c.o
> libauthz.a.p/authz_list.c.o libauthz.a.p/authz_listfile.c.o
> libauthz.a.p/authz_simple.c.o
> tests/bench/benchmark-crypto-hash.p/benchmark-crypto-hash.c.o
> -Wl,--as-needed -Wl,--no-undefined -pie -fstack-protector-strong
> -Wl,-z,relro -Wl,-z,now -Wl,--start-group libqemuutil.a
> subprojects/libvhost-user/libvhost-user-glib.a
> subprojects/libvhost-user/libvhost-user.a
> /usr/lib/x86_64-linux-gnu/libnettle.so
> /usr/lib/x86_64-linux-gnu/libgmp.so
> /usr/lib/x86_64-linux-gnu/libhogweed.so -lnuma
> /usr/lib/x86_64-linux-gnu/liburing.so
> /usr/lib/x86_64-linux-gnu/libgio-2.0.so
> /usr/lib/x86_64-linux-gnu/libgobject-2.0.so
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so -Wl,--export-dynamic
> /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread -lm
> /usr/lib/x86_64-linux-gnu/libpixman-1.so
> /usr/lib/x86_64-linux-gnu/libepoxy.so -Wl,--end-group
> /usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
> function `type_register_internal':
> /build/release-amd64/../../qom/object.c:243:(.text+0x1c2): undefined
> reference to `target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
> function `target_mask_filter':
> /build/release-amd64/../../qom/object.c:120:(.text+0x1df): undefined
> reference to `target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd:
> /build/release-amd64/../../qom/object.c:120:(.text+0x37a): undefined
> reference to`target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd:
> /build/release-amd64/../../qom/object.c:120:(.text+0x1ebf): undefined
> reference to `target_mask_selected'
> collect2: error: ld returned 1 exit status
> [64/389] Linking target tools/qemu-vnc/qemu-vnc
> FAILED: [code=1] tools/qemu-vnc/qemu-vnc
> gcc -m64  -o tools/qemu-vnc/qemu-vnc
> tools/qemu-vnc/qemu-vnc.p/meson-generated_.._.._.._ui_dbus-display1.c.o
> tools/qemu-vnc/qemu-vnc.p/meson-generated_.._qemu-vnc1.c.o
> libio.a.p/io_channel-buffer.c.o libio.a.p/io_channel-command.c.o
> libio.a.p/io_channel-file.c.o libio.a.p/io_channel-null.c.o
> libio.a.p/io_channel-socket.c.o libio.a.p/io_channel-tls.c.o
> libio.a.p/io_channel-util.c.o libio.a.p/io_channel-watch.c.o
> libio.a.p/io_channel-websock.c.o libio.a.p/io_channel.c.o
> libio.a.p/io_dns-resolver.c.o libio.a.p/io_net-listener.c.o
> libio.a.p/io_task.c.o libcrypto.a.p/crypto_afsplit.c.o
> libcrypto.a.p/crypto_akcipher.c.o libcrypto.a.p/crypto_block-luks.c.o
> libcrypto.a.p/crypto_block-qcow.c.o libcrypto.a.p/crypto_block.c.o
> libcrypto.a.p/crypto_cipher.c.o libcrypto.a.p/crypto_der.c.o
> libcrypto.a.p/crypto_hash.c.o libcrypto.a.p/crypto_hmac.c.o
> libcrypto.a.p/crypto_ivgen-essiv.c.o
> libcrypto.a.p/crypto_ivgen-plain.c.o
> libcrypto.a.p/crypto_ivgen-plain64.c.o libcrypto.a.p/crypto_ivgen.c.o
> libcrypto.a.p/crypto_pbkdf.c.o libcrypto.a.p/crypto_secret_common.c.o
> libcrypto.a.p/crypto_secret.c.o libcrypto.a.p/crypto_tlscreds.c.o
> libcrypto.a.p/crypto_tlscredsanon.c.o
> libcrypto.a.p/crypto_tlscredspsk.c.o
> libcrypto.a.p/crypto_tlscredsx509.c.o
> libcrypto.a.p/crypto_tlssession.c.o libcrypto.a.p/crypto_rsakey.c.o
> libcrypto.a.p/crypto_x509-utils.c.o
> libcrypto.a.p/crypto_hash-nettle.c.o
> libcrypto.a.p/crypto_hmac-nettle.c.o
> libcrypto.a.p/crypto_pbkdf-nettle.c.o
> libcrypto.a.p/crypto_secret_keyring.c.o libauthz.a.p/authz_base.c.o
> libauthz.a.p/authz_list.c.o libauthz.a.p/authz_listfile.c.o
> libauthz.a.p/authz_simple.c.o libqom.a.p/qom_container.c.o
> libqom.a.p/qom_object.c.o libqom.a.p/qom_object_interfaces.c.o
> libqom.a.p/qom_qom-qobject.c.o libqom.a.p/qom_compat-properties.c.o
> libevent-loop-base.a.p/event-loop-base.c.o
> ui/libqemuui.a.p/clipboard.c.o ui/libqemuui.a.p/console.c.o
> ui/libqemuui.a.p/cursor.c.o ui/libqemuui.a.p/dmabuf.c.o
> ui/libqemuui.a.p/display-surface.c.o ui/libqemuui.a.p/input-keymap.c.o
> ui/libqemuui.a.p/kbd-state.c.o ui/libqemuui.a.p/keymaps.c.o
> ui/libqemuui.a.p/qemu-pixman.c.o ui/libqemuui.a.p/spice-module.c.o
> ui/libqemuui.a.p/vgafont.c.o ui/libqemuui.a.p/cp437.c.o
> ui/libqemuui.a.p/vt100.c.o tools/qemu-vnc/qemu-vnc.p/qemu-vnc.c.o
> tools/qemu-vnc/qemu-vnc.p/display.c.o
> tools/qemu-vnc/qemu-vnc.p/input.c.o
> tools/qemu-vnc/qemu-vnc.p/audio.c.o
> tools/qemu-vnc/qemu-vnc.p/chardev.c.o
> tools/qemu-vnc/qemu-vnc.p/clipboard.c.o
> tools/qemu-vnc/qemu-vnc.p/console.c.o
> tools/qemu-vnc/qemu-vnc.p/dbus.c.o tools/qemu-vnc/qemu-vnc.p/stubs.c.o
> tools/qemu-vnc/qemu-vnc.p/utils.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-enc-zlib.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-enc-hextile.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-enc-tight.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-palette.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-enc-zrle.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-auth-vencrypt.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-ws.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-jobs.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-clipboard.c.o
> tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-auth-sasl.c.o -Wl,--as-needed
> -Wl,--no-undefined -pie -fstack-protector-strong -Wl,-z,relro
> -Wl,-z,now -Wl,--start-group libqemuutil.a
> subprojects/libvhost-user/libvhost-user-glib.a
> subprojects/libvhost-user/libvhost-user.a
> /usr/lib/x86_64-linux-gnu/libz.so /usr/lib/x86_64-linux-gnu/libjpeg.so
> /usr/lib/x86_64-linux-gnu/libpng16.so -lsasl2
> /usr/lib/x86_64-linux-gnu/libnettle.so
> /usr/lib/x86_64-linux-gnu/libgmp.so
> /usr/lib/x86_64-linux-gnu/libhogweed.so
> /usr/lib/x86_64-linux-gnu/libgio-2.0.so/usr/lib/x86_64-linux-gnu/libgobject-2.0.so
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so
> /usr/lib/x86_64-linux-gnu/libpixman-1.so -lnuma
> /usr/lib/x86_64-linux-gnu/liburing.so -Wl,--export-dynamic
> /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread -lm
> /usr/lib/x86_64-linux-gnu/libepoxy.so -Wl,--end-group
> /usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
> function `type_register_internal':
> /build/release-amd64/../../qom/object.c:243:(.text+0x1c2): undefined
> reference to `target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
> function `target_mask_filter':
> /build/release-amd64/../../qom/object.c:120:(.text+0x1df): undefined
> reference to `target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd:
> /build/release-amd64/../../qom/object.c:120:(.text+0x37a): undefined
> reference to`target_mask_selected'
> /usr/bin/x86_64-linux-gnu-ld.bfd:
> /build/release-amd64/../../qom/object.c:120:(.text+0x1ebf): undefined
> reference to `target_mask_selected'
> collect2: error: ld returned 1 exit status
> [65/389] Generating block.syms with a custom command (wrapped by meson
> to capture output)
> [66/389] Generating qemu.syms with a custom command (wrapped by meson
> to capture output)
>

Thanks, that's indeed coming with patch 4. In case we don't pursuit with
buckets approach, stub can be removed from this patch.

> 
>>
>>>>
>>>>>  if have_block
>>>>>    stub_ss.add(files('bdrv-next-monitor-owned.c'))
>>>>> diff --git a/stubs/target-mask-selected.c b/stubs/target-mask-selected.c
>>>>> new file mode 100644
>>>>> index 0000000000..510a515851
>>>>> --- /dev/null
>>>>> +++ b/stubs/target-mask-selected.c
>>>>> @@ -0,0 +1,13 @@
>>>>> +/*
>>>>> + * Tools have no selected target.
>>>>> + *
>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>> + */
>>>>> +
>>>>> +#include "qemu/osdep.h"
>>>>> +#include "qemu/target-info.h"
>>>>> +
>>>>> +uint64_t target_mask_selected(void)
>>>>> +{
>>>>> +    return 0;
>>>>> +}
>>>>> diff --git a/target-info-def.c b/target-info-def.c
>>>>> index bcf9cfe1e4..a992019626 100644
>>>>> --- a/target-info-def.c
>>>>> +++ b/target-info-def.c
>>>>> @@ -9,6 +9,9 @@
>>>>>  #include "qemu/osdep.h"
>>>>>  #include "qemu/target-info.h"
>>>>>  #include "qemu/target-info-def.h"
>>>>> +#ifdef CONFIG_USER_ONLY
>>>>> +#include "qemu/base-arch-defs.h"
>>>>> +#endif
>>>>>  #include "qemu/target-info-init.h"
>>>>>  #include "hw/core/boards.h"
>>>>>  #include "cpu.h"
>>>>> diff --git a/target-info-qom.c b/target-info-qom.c
>>>>> index aeeedb7e81..fb4c9835e5 100644
>>>>> --- a/target-info-qom.c
>>>>> +++ b/target-info-qom.c
>>>>> @@ -9,6 +9,8 @@
>>>>>  #include "qemu/osdep.h"
>>>>>  #include "qapi/error.h"
>>>>>  #include "qom/object.h"
>>>>> +#include "qemu/base-arch-defs.h"
>>>>> +#include "qemu/target-info.h"
>>>>>  #include "qemu/target-info-def.h"
>>>>>  #include "qemu/target-info-init.h"
>>>>>  #include "qemu/target-info-qom.h"
>>>>> @@ -40,6 +42,14 @@ const TargetInfo *target_info(void)
>>>>>      return target_info_ptr;
>>>>>  }
>>>>>
>>>>> +uint64_t target_mask_selected(void)
>>>>> +{
>>>>> +    if (!target_info_ptr) {
>>>>> +        return QEMU_ARCH_ALL;
>>>>> +    }
>>>>> +    return QEMU_ARCH_BIT(target_info_ptr->target_arch);
>>>>> +}
>>>>> +
>>>>>  void target_info_qom_set_target(void)
>>>>>  {
>>>>>      g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
>>>>
>>>
>>>
>>
> 
> 


