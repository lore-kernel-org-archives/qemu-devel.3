Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20C5C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPmb-0004NG-Jj; Tue, 18 Aug 2026 15:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwPma-0004MS-5o
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:47:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwPmY-00049R-Hg
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:47:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJZNZP2168561
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b6285oL++lp/M49zRlpGsl8d40mbfzmR1u3C9cKLjr8=; b=JSHNbv7cxj0rfTVv
 a4xVpYrmk0JGcmnCTntrGkc2hW4G2C9tSrkoblHMsehMDS6iTgPXONR2TVMLacnG
 joLPS1f7W0UUjvo1xPTuimPTwjomo6By995x/483uv61JvX+1my+1fnEZ6BoQ3S8
 HvnrPCvj1+9Te1ZkS4G50bdTO3/RFq1St2N5wAVk6tm8+qh5OMbrizc6ODz0Aw4D
 zCUGI+ksjIV2kJLU2zzw3XCIPoGBocnjBC7M69uM08alM40+lh2qrdQp4hv5A5N+
 MfRrkGcE874iOQ2zNiPRKWBa62ZuDXFaL+OvVPXas4GjYRzrCZViBvVve4ArqQAP
 8CeyOQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb1ajvt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:47:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so39867085a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787082451; x=1787687251; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b6285oL++lp/M49zRlpGsl8d40mbfzmR1u3C9cKLjr8=;
 b=euKc3bvucVEbF1tmBsN9GdZpFV6LsqJlJagrGqEPofyVyQJs2yfI6DOPTliFcx1ZB/
 pePYNxfACMMBEO1H9CwNxJOnkpHSvdvFR8kHUjwSuFKnl9UkUrOpZmq3o+xSLh0Uu+ur
 AIhOXiYIwHbeWYU+9DCmM5v27s42UkBWzAde8jQa5hcV0G2hDJbygNWlGdcA9+ysL5G5
 JUm+KHOGuWtUEItMvUsAZS/dFtpmDS4XGRh1oG76oCJofUAOyaRpbS38Sal9Odqbni4Z
 g3i1UhyhIAgN7DO8Pdmprc4LhIWXHCUcPMNV3o1J5c6R3IbApT0B7pTVMhqSDH4NPdfX
 OSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787082451; x=1787687251;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b6285oL++lp/M49zRlpGsl8d40mbfzmR1u3C9cKLjr8=;
 b=miAjKPo8zdiEl53cA0o0NukTSWpHJ9CtubP5vDB2gUjH6xsdHAjKjOuyPkFfPhMT/C
 xI3GWX/AYgZdAgv55z8x5hId058y4MhhrUJn1Ooh8s1WPjU+kcNs39TOwfmV6ujJo5Kj
 AHu7LcmPF8A4PTBCha06oTQpk2+I21lt1amazZMb0Ijo+/BER+pdmtakaA7sQdXWolzR
 KJ6SER4oC6z6FgAela6QtJQGoVhNfXe6E2QXDbjQKazMQwa+Nmdv6EyjREH5VcnHn+Ws
 n+va0J7pmmpI9Mc9T9h/ms0MrFRyRnDtWBMBEhhQJNoRkQLEjbnszPK7WjU1Ai69wd3M
 xeMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVq18yKxgbaPpS5VV1KfdZvdfaDDFBCKhvEo/zcYpIfgnj0zA7hCBOZr39Ls3Zw5KzI25U5q+1mCdN@nongnu.org
X-Gm-Message-State: AOJu0YyKQP31ZizRweFujnGwWBuKbaFhMp7eV4vRsPAAIy4yraq90hwv
 s3UU8UCOjtIAJ2hF8gvuadkeYohYrjTwFxGB4FSP3QX/Ng1zAvMtbiWD+ffIGQotFpyvJjgMoRJ
 uY7iCSVloGjgG6mTMncP4wmBxygTQ9VYBnTBeIMUNZmGyVe5VgtNYGfn+Vw==
X-Gm-Gg: AR+sD13xDD/tZoNj+0own5/xeIfKMb3AUigRl5EKnrBNmm8nFV0dmGKN5Te9hQ7mVoh
 5yapknXzccWu038MkD+NI2TqehYk9km+VFI1DkcGx9oGiB7vtzU/mGS3sG0up/3/IlpxldzkdWT
 mCTP22EDZc1lQ/NLE/wUpaDVCkNZXWMCqblMW7j4zc4XXaYosLRNrlbN1DUXSX9ys9NeuvkYNdT
 qVSLbYeBrRC/E0g7mHH+QpTyQ+qVw4Dq4hZuOOZBGqkZUxhUk8Tk/Jk5lDDjttOmD8EubfLhxuE
 lXTO69JpO9z10WVtWl/Wy65P4me+Wa99nGd4eiBtuRjOVnCH87Cpult0eqYRUIIksyaJ3uo1VVR
 rHC6eBldV1Kf9T4+AM878daDz8TEsccfENgidwE2vOhVkJURrva1z7e78IU3i2ocy
X-Received: by 2002:a05:622a:134f:b0:51c:2135:b00a with SMTP id
 d75a77b69052e-52dd326b9b9mr4808541cf.40.1787082451360; 
 Tue, 18 Aug 2026 12:47:31 -0700 (PDT)
X-Received: by 2002:a05:622a:134f:b0:51c:2135:b00a with SMTP id
 d75a77b69052e-52dd326b9b9mr4808121cf.40.1787082450882; 
 Tue, 18 Aug 2026 12:47:30 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db621764bsm47062691cf.15.2026.08.18.12.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 12:47:30 -0700 (PDT)
Message-ID: <210afbdc-ff9a-4743-95ce-1aeb1bf4b200@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:47:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/28] target/hexagon: Implement wait helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Sid Manning <sid.manning@oss.qualcomm.com>
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, philmd@linaro.org, Brian Cain <bcain@quicinc.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
 <20260529215806.608770-6-brian.cain@oss.qualcomm.com>
 <f9ac74f3-46d9-4958-8635-8c61bff60921@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <f9ac74f3-46d9-4958-8635-8c61bff60921@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0NSBTYWx0ZWRfX1r3N4rQKi8yw
 4NfI2F5VPFPOubp6807JZpcK6Y27Eis5BMUmNauOhX6UIWssYco7WVXj4ub+0W1mAQjYveeGlqp
 BLbAubXbshzunFdr3Uxr/xfesBS3VPdFdznssJywIr2YTtI+9y/17K45dG2zMYAy4qPhj78xvG8
 /18IsBy/pv62utEKbhjcBklmuJmX6fROX0uwd1e5LFO7ZxC7BItxell59lybYkSuXkk49jX8vAY
 T2CSmyowhPZhTSLsfRmpC0B6hFEo282mQrAOpW52V6K4+3aVwN/1KtCYMtW+V4CMMV1WplwmU21
 rMefao0qDkhD3TPAfrs5WLEVZrKoo7awejh+l+iF9pwHyfxAWEVC8R0/oRu9aliT7KYtBBLjow7
 meTAlvt7fBoC2NC9BmCkLXLXzkmP9JFFCTRYLg+ECxfuVt9hM6NRvvTETyxyOtmPAcXcIHe8zc9
 GrpDCFLKQbALkEGT+hQ==
X-Proofpoint-GUID: Zu1Ko49MhAJjejHCQyBvEXLMBOcwW5PA
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a84b6d4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-7hq2_fSU2ADFg7VcVYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Zu1Ko49MhAJjejHCQyBvEXLMBOcwW5PA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0NSBTYWx0ZWRfX7QFLQW9PO27o
 9jJK2IarLehDQqZycF7EH5zv5GUTeGZ4mzZ8RazZTlMa7wbDuQCAsQDK8amFxDQ6c1NpuDofYBB
 PCRcSZj8yKnrLY4YHKGlub6rbg/T3uA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180145
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 8/14/2026 12:29 PM, Philippe Mathieu-Daudé wrote:
> Hi Brian, Taylor,
>
> (now committed as acd2b7a2f19ac04bd313e816e5f9e7f87adc9858)
>
> On 29/5/26 23:57, Brian Cain wrote:
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/gen_tcg_sys.h |  2 +-
>>   target/hexagon/op_helper.c   | 60 ++++++++++++++++++++++++++++++++++--
>>   2 files changed, 59 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
>> index 000fc415c74..98cf6216780 100644
>> --- a/target/hexagon/gen_tcg_sys.h
>> +++ b/target/hexagon/gen_tcg_sys.h
>> @@ -80,7 +80,7 @@
>>   #define fGEN_TCG_Y2_wait(SHORTCODE) \
>>       do { \
>>           RsV = RsV; \
>> -        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt->pc)); \
>> +        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
>>       } while (0)
>>     #define fGEN_TCG_Y2_resume(SHORTCODE) \
>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>> index 235c70f7370..d40061de06e 100644
>> --- a/target/hexagon/op_helper.c
>> +++ b/target/hexagon/op_helper.c
>> @@ -1486,9 +1486,65 @@ void HELPER(stop)(CPUHexagonState *env)
>>       hexagon_stop_thread(env);
>>   }
>>   -void HELPER(wait)(CPUHexagonState *env, target_ulong PC)
>> +static void set_wait_mode(CPUHexagonState *env)
>>   {
>> -    g_assert_not_reached();
>> +    HexagonCPU *cpu;
>> +    uint32_t modectl;
>> +    uint32_t thread_wait_mask;
>> +
>> +    g_assert(bql_locked());
>> +
>> +    cpu = env_archcpu(env);
>> +    if (!cpu->globalregs) {
>> +        return;
>> +    }
>> +    modectl =
>> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_MODECTL,
>> +                               env->threadId);
>> +    thread_wait_mask = GET_FIELD(MODECTL_W, modectl);
>> +    thread_wait_mask |= 0x1 << env->threadId;
>> +    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, 
>> thread_wait_mask);
>> +}
>> +
>> +static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
>> +{
>> +    CPUState *cs;
>> +
>> +    g_assert(bql_locked());
>> +
>> +    if (qemu_loglevel_mask(LOG_GUEST_ERROR) &&
>> +        (env->k0_lock_state != HEX_LOCK_UNLOCKED ||
>> +         env->tlb_lock_state != HEX_LOCK_UNLOCKED)) {
>> +        qemu_log("WARNING: executing wait() with acquired lock"
>> +                 "may lead to deadlock\n");
>> +    }
>> +    g_assert(get_exe_mode(env) != HEX_EXE_MODE_WAIT);
>> +
>> +    cs = env_cpu(env);
>> +    /*
>> +     * The addtion of cpu_has_work is borrowed from arm's wfi helper
>> +     * and is critical for our stability
>
> Could you explain this comment?

It's a note that was added to our downstream fork when fixing a bug 
attributed to hexagon_wait_thread() that was a bit challenging to 
uncover because none of our existing regression suite detected it.  It 
was only uncovered in a "virtual platform" environment modeling the 
various cores among the SoC.

We can follow up with a reword/clarification or deletion if you prefer.

>
>> +     */
>> +    if ((cs->exception_index != HEX_EVENT_NONE) ||
>> +        (cpu_has_work(cs))) {
>> +        qemu_log_mask(CPU_LOG_INT,
>> +            "%s: thread %" PRIu32 " skipping WAIT mode, have some 
>> work\n",
>> +            __func__, env->threadId);
>> +        return;
>> +    }
>> +    set_wait_mode(env);
>> +    env->wait_next_pc = PC + 4;
>> +
>> +    cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>> +}
>> +
>> +void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
>> +{
>> +    BQL_LOCK_GUARD();
>> +
>> +    if (!fIN_DEBUG_MODE(env->threadId)) {
>> +        hexagon_wait_thread(env, PC);
>> +    }
>>   }
>>     void HELPER(resume)(CPUHexagonState *env, uint32_t mask)
>

