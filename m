Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0777ACA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIYP-0002aU-Ep; Tue, 02 Sep 2025 00:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIYN-0002Zy-Sa
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:23:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIYL-000142-Vh
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:23:31 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822XKRU031715
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NP0+cALrvqVMaaxb2z8zeAAv1JvZY+EQNI0HWQgzw54=; b=iQrOw8xN1TNKQ4fC
 3MCkKH+EzJKvN0bLHbkuERm0MHlgqsIxxCZvNYN42y6LjWm6GVELsIX1W000+q+a
 +/NNKD7fR2RKuUqmoz5yNGcQOleyxBXZEMzeVPfF5GOJSmOQBu5FmXlvtcwUFm2D
 w3EvTH9u40UptZroO0m0/EVWF0lo30nW7CCXbaufLwtUxK7oQu9J2pRh7KsOcAbE
 jBjN5OwOQgdsDQBZq6VDtdnTmNWCAe2IGPCy1RBnpUSzqn6JAfebxSeyfEq4tC/k
 NNgsrurNFDWvDMB2wc1CYPefEZFSJQkd4uAjAWED6w7Ex2+HB/fC+ItpVeVhqB7b
 JTLqOA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvw879f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:23:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b3118ab93aso64176101cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787007; x=1757391807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NP0+cALrvqVMaaxb2z8zeAAv1JvZY+EQNI0HWQgzw54=;
 b=t3KNv4IC4REUEn1Vkd2OFdxifRk5SmLH3ovtp3bdhERF5QKLaYlTm6CR1X8fFjrfgy
 //m8dOWu8raih7rOnpmi7JCNoT1pGrvrV+QWHuYlpYtCDS1PRevWDPWR3lId8ETR1fdA
 LgAOijjtk6REgS9YUUOR5bmfoeGqyS19jOUHmBdDrWc+CHJgZ6IaZfbzTj8tHFvwX9YG
 BfpMZ8l7EFZPMe1TE6YscX1/B3cMzgOhPEO3+wwpa8zOGanKXnTj14XcjkAWkpg87a2I
 J6YKvGaqjdafmxwt0s7rsmaUPn7q1rkFFHjXy4dgxOL7p4iK2breZNnKqYrP9KOOtCdx
 DnOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULX0i8aza0ZBjS0ff91ppXYa1s98nwT0dN4k994cntnlfkvmSJwlV6UH1Z434j1L8K3Lq2w7JBxz9t@nongnu.org
X-Gm-Message-State: AOJu0YzCGlQCOlc86tuu28C1UPL654r2cT0EC76J2WTDEuXlurBp4OrX
 z2C1RkSvlzNZeE9qmQdHmKaW/Hr0sAe/TRv5fUd7iBFGRdh3iKbCo0QjrPDQRXaZXOoDjEpgmIS
 67KPx3a/kXKgg4PhG9NvX30+VFYsGaQTMci85Zg1rzPpS/6NxZZmRC0V0AA==
X-Gm-Gg: ASbGncvLKK5H8B7EiCzaO+VlVm/0ZbxvhfZ1qAai/bntKbRtvx4dDk2BUXpW5M44K/s
 Sh9FQb+MKAuMgEPR+RIw0zUW71regM8+Pp57p2FxmjhNySBL9KiXFoi23PiDYvI7APESDFLHt5S
 hX6S+v6Lan+kifPx7BvknQj5/R+J38WB9SqwVUgIp2GSh6Gwx37qQY5FG1bxL4pMyoLNOeTU/JB
 d8GgLMg1f6wZZ6RSc7svyqNnd0qTMPaHHTD4w1jmQuLb/Ed2AAsf2nM8VwB2C7mm5PGc1U3tbOF
 60s+lKE7Mwq//TUuZMSLDgT1kJGAuMZ6r/7lCFZ/MmkxYkPuz8Uw6KjDynzV5Q==
X-Received: by 2002:ac8:5f10:0:b0:4b3:d3:e7a0 with SMTP id
 d75a77b69052e-4b31d844931mr132016091cf.8.1756787006397; 
 Mon, 01 Sep 2025 21:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/wC+XyYfI6wsp2mbAmQ4SIQ6JroKeUUMZpcJl3XZ/jRq2m+caCLOQMglCyTxOarrV+mk/vg==
X-Received: by 2002:ac8:5f10:0:b0:4b3:d3:e7a0 with SMTP id
 d75a77b69052e-4b31d844931mr132015831cf.8.1756787005861; 
 Mon, 01 Sep 2025 21:23:25 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm17958390f8f.27.2025.09.01.21.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:23:25 -0700 (PDT)
Message-ID: <f616089d-8b64-4ab1-8d87-b6e6361a24f7@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:46:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/39] target/hexagon: Implement wait helper
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-8-brian.cain@oss.qualcomm.com>
 <017401db976b$96f4c4c0$c4de4e40$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <017401db976b$96f4c4c0$c4de4e40$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfX4OKYROXYogov
 nFKBoppS9OE2Q1a3uweD/NxkK49zIeH4IKxBhDHQil0Ie3q63z6y/iIVgPxbf+JUog82elpUFx+
 pYWzvV6BzqxI4TzM0CLGVrCTlNqf2fRTSh6D39BEHgQ4YQnZ9aRbBq1/D4x6Y0/mqOFZ1KTK6fJ
 Bb0cxU/q2nt2zz/yNDimZVtOR1VZnnFzhI1Yo0pOtINOPIyPcNScrSpjmSzpJMIh7nDhQ+Z7fWV
 VpwT3b8BCxLbaorlsxB7r1ld1c7KEdNju9g4HL46rmpOARBw+jgIVDWADXdMdVJ6z6Vn/clF5ti
 vf/HCK/TYfZbDo6vEhkjANaaBe0E/txd68j7O/QBrpUsE/Cpyl0PtmzD8K8r69xA90LTWypuOyv
 EbWV8521
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b67140 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=tNnlAxD6BZQisbNMuHEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3RozRVz72cnN-cOQG5zYVoToPpUrfXwU
X-Proofpoint-ORIG-GUID: 3RozRVz72cnN-cOQG5zYVoToPpUrfXwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 3/17/2025 1:37 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:28 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 07/39] target/hexagon: Implement wait helper
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu_helper.h |  1 +
>>   target/hexagon/cpu_helper.c | 40
>> +++++++++++++++++++++++++++++++++++++
>>   target/hexagon/op_helper.c  |  6 +++++-
>>   3 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
>> index 95a0cc0788..e8d89d8526 100644
>> --- a/target/hexagon/cpu_helper.h
>> +++ b/target/hexagon/cpu_helper.h
>> @@ -20,6 +20,7 @@ void clear_wait_mode(CPUHexagonState *env);  void
>> hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause);  void
>> hexagon_start_threads(CPUHexagonState *env, uint32_t mask);  void
>> hexagon_stop_thread(CPUHexagonState *env);
>> +void hexagon_wait_thread(CPUHexagonState *env, target_ulong PC);
>>
>>   static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
>>                                          uint32_t val) diff --git a/target/hexagon/cpu_helper.c
>> b/target/hexagon/cpu_helper.c index 3e2364a7b0..e64568b9fc 100644
>> --- a/target/hexagon/cpu_helper.c
>> +++ b/target/hexagon/cpu_helper.c
>> @@ -71,6 +71,46 @@ void
>> hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
>>       g_assert_not_reached();
>>   }
>>
>> +static void set_wait_mode(CPUHexagonState *env) {
>> +    g_assert(bql_locked());
>> +
>> +    const uint32_t modectl = arch_get_system_reg(env,
>> HEX_SREG_MODECTL);
>> +    uint32_t thread_wait_mask = GET_FIELD(MODECTL_W, modectl);
>> +    thread_wait_mask |= 0x1 << env->threadId;
>> +    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W,
>> +thread_wait_mask); }
>> +
>> +void hexagon_wait_thread(CPUHexagonState *env, target_ulong PC) {
>> +    g_assert(bql_locked());
>> +
>> +    if (qemu_loglevel_mask(LOG_GUEST_ERROR) &&
>> +        (env->k0_lock_state != HEX_LOCK_UNLOCKED ||
>> +         env->tlb_lock_state != HEX_LOCK_UNLOCKED)) {
>> +        qemu_log("WARNING: executing wait() with acquired lock"
>> +                 "may lead to deadlock\n");
>> +    }
>> +    g_assert(get_exe_mode(env) != HEX_EXE_MODE_WAIT);
>> +
>> +    CPUState *cs = env_cpu(env);
>> +    /*
>> +     * The addtion of cpu_has_work is borrowed from arm's wfi helper
>> +     * and is critical for our stability
>> +     */
>> +    if ((cs->exception_index != HEX_EVENT_NONE) ||
>> +        (cpu_has_work(cs))) {
>> +        qemu_log_mask(CPU_LOG_INT,
>> +            "%s: thread %d skipping WAIT mode, have some work\n",
>> +            __func__, env->threadId);
>> +        return;
>> +    }
>> +    set_wait_mode(env);
>> +    env->wait_next_pc = PC + 4;
>> +
>> +    cpu_interrupt(cs, CPU_INTERRUPT_HALT); }
>> +
> Why not put this in op_helper.c?

I'm not quite certain what the rationale was but if it shouldn't be in 
cpu_helper.c we can move it.  Is it just hexagon_wait_thread() or should 
all of these functions be there instead?


>
> Otherwise
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>

