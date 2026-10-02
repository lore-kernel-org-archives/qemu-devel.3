Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206C8CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 04:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCV9J-000162-Bj; Fri, 02 Oct 2026 00:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCV9G-00013m-5W
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 00:45:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCV9E-0004Ai-3a
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 00:45:29 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922Jphw2988256
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 04:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /zgbKF5C+mXNuYQwNXPeJOm4zHrNW/q30NKyeTUPprg=; b=Gdu0nzxmDWLPtmOP
 a74C7mTd2GAhkjn9EN9N1EliPl8cSMsq0vDrnSSlVyoY8vuwEV7wUrYX1bWYwdQX
 JWPNMEAG7dM4EQ9GBrRkZCTSDukDM0NALxK2ruf4pcgBCL4/h4MUZcYh4D7sfvfC
 LTR8EhXoHUxkzCGJTwS8n4J8XjuhMYDYYEI+MhWAS48dHYB1dz57eT60PE31Dmvt
 IuxTBJ/OYerf+HJkuV0CiPTSUQVAwk5C5lrJzjX168bDqFdiDnC/KUfYerC5BcHP
 HtVp6aJSM4VRos7teXFQa469/NILwxh2/cmi6gi9MO2IUv8dRHg9nvSjYBszM+3h
 lxdLrg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1vxe9q7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 04:45:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf7856ffso469198285a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 21:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790916324; x=1791521124; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/zgbKF5C+mXNuYQwNXPeJOm4zHrNW/q30NKyeTUPprg=;
 b=HKlYQBDssmXy+69MsTqgAismyYHAJlsR/O0Xa2Ps1dWnDufhJeBICx+K3blR9XykzS
 ULiGTXIRwfjq72cdxhfcpHxueTayUk06bWPf8sFKBekRIcniNe/raQJYjLplamN3MmBF
 TOKy+UIQWTi3WnHCXBmG6YlnuIJQ7UdZylOUyUqUiHiN37wkIzPJv1qcBZTQUcLUsfrL
 aMPbRTev3/3Z2OwCHqUsdukcwtmQ0i1ni0nKa5JOgScywtSVzQNDrcRv0ysNks0H/TW2
 svzxXBHlh1vqopn1vk4q5snbd4xfrxYHCEfng5pQ+80tUAWm7mFyUQ33uLLs5Qg6pYXd
 YaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790916324; x=1791521124;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/zgbKF5C+mXNuYQwNXPeJOm4zHrNW/q30NKyeTUPprg=;
 b=1m+dAI5gxr1XwaCFT75IFC9+UYOEZUWhcv3ygeGqjb7IRfIsXXrrTPPFyhHnmaYxCf
 3ob13uawCTcVynNEJyk3QGbk5VVCuGKJSYDsfM1nvwsn22j4OIaatwogqiHiB9vKPIYf
 5gFuf+2f+/bZZ17ba4194+KAuE3QiUvzZf+bbtD1gdVZdjmIKRgfwGhvOKqi5QzvJAz+
 UnucSE2jNdfuC+/ggS3h+mB5gZwS9xOcXbh0TSFLywUPpPTL345u8ReEYQ8s3Fd78nkk
 oVTmtROdAABFRbLRgmTpjZOJvQBUFYR2xDTzFMS2Weflpw5MvXYM2yHv1m++kgnaT21J
 t17A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3EIrzPiYBXFjl3AuDFrEOW0F80M+G+CmO6qTnKMi7u0lnYHVOIJxbcDBcQeJJoori/nMXIIFh6n45@nongnu.org
X-Gm-Message-State: AFuF++ll8cFBjmg003gxFvrMO4v+c8vBRRQmAVKiczEiIlx7XzJXcCuU
 f8l/Qh1NiDBtmci1acN1UENojqc8VlavFudZG2g2UduXwoZyutpY1cXXlbkK31yC3MMvq0yLLu3
 XC4tTJHmSlfKAYm2KknyqpJuDiWwiHhTEqhf/rFifXkurgfQ8Y6OkZ0/WqA==
X-Gm-Gg: AYBFou1qkXGGUr55mCAjmqzOBw8ad0IL2Xil8p+OC47urq7AWrEawXWknrA7j27Kkac
 HPMBYEGCMd63/myhZmkpCXQsZ7nDjfgkhCzzFx++fnsU7VQmPjWJCecCtyqjh4j+pCn1xI6XOsp
 /rt4m8xb4TGVKq+R+//HEAQQ1P39s+ucy9YAyi5WxpPemuGbr8RsYOhw4RLO57h3ba/6Bn4dB8w
 8TM7MQq6VwXL453gXbxKnGY8/MDjac8EPqpW+x5OnFsxNsGPl1P+YTs1LmD4a5uE8ZAWX4VKnw9
 rfdoZf6omL/Mu1IBGj4U1O8VYuZCgkeEK5XB6RejWjRsG07ev63eeQA82PeXs6v92KfOhNeh1BC
 UioZKBJPBk7oblWjvHNbMp0QMH8e9FtxDXg==
X-Received: by 2002:a05:620a:26a6:b0:93c:29b3:3525 with SMTP id
 af79cd13be357-93cf17348cbmr247629885a.36.1790916323761; 
 Thu, 01 Oct 2026 21:45:23 -0700 (PDT)
X-Received: by 2002:a05:620a:26a6:b0:93c:29b3:3525 with SMTP id
 af79cd13be357-93cf17348cbmr247628285a.36.1790916323253; 
 Thu, 01 Oct 2026 21:45:23 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280c84a9sm39513315e9.10.2026.10.01.21.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 21:45:22 -0700 (PDT)
Message-ID: <623a0707-e074-42e2-a40a-bbbb01c618a2@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 06:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: gdbstub - Add sys reg support
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260930175108.3592113-1-brian.cain@oss.qualcomm.com>
 <20260930175108.3592113-3-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930175108.3592113-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fdc4WEQF c=1 sm=1 tr=0 ts=6abf36e4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Jj4k0oqG4fcg50nmhSEA:9 a=hzG74vw4_rJED6HQ:21
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: wcekoY6dpvoX85BI2-_IVHkPtFC_JUHo
X-Proofpoint-ORIG-GUID: wcekoY6dpvoX85BI2-_IVHkPtFC_JUHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAxOCBTYWx0ZWRfXxdj3bZS3nISa
 Lk5a2ay9P6ny++ZUh9oF084G6UW3b4Ni3rKf28r5uhC9dZyWIQHVJhZ91CoY2/xpeno/B7gZD/V
 RbpDi+RDLwQl+3sNPyyZyaTlGX8RQlDWia0mX8PBG2Oqu9Ph48zVnc7xAM9WvbZ21DUzRDdqeyr
 mBcFoyvju4bnI3ushAJ4X4p82mQwlCnaI6J6pVl84xk6dcBu97J/FYlZTENOQ7P82YOZRbep9ie
 RCT/sGIIWyFZaXHbsXPMbGVOTBTyIeP5qUMg4AkXoIiarc7/y4mlm8cgYC81AHvmbft2Ia98J5I
 WnwyRzaMZ8PGjwiRF5JonOQu20KIiYBq7NuD1J+5wU6Nt4p8XXYt2EpB/wOPk+cgOeZtTrSXukV
 Yl9qRhzRMrwLMdZXJZc0xFP7+6KWI8XgFpM9O7H70lmujS7HB+eBIsBjbPutpJvCBeHwjhrqCbp
 K8OpxsdhH5cHWynE1Rw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAxOCBTYWx0ZWRfX2ZNyceuHoUj9
 Sr8QRkbw1ockkhpZf4Rl3zVwVlCgsadEjVJEoj9Uw2EgZ+Jrs6yiie0/IHqb9NesZKIAzedyEAu
 E6V9T1g6DtJeZMwLamWRUWo69JVkOLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020018
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 30/9/26 19:51, Brian Cain wrote:
> Add support for the system and guest registers to the gdbstub.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h      |  1 +
>   target/hexagon/internal.h |  4 +++
>   target/hexagon/cpu.c      | 14 ++++++++
>   target/hexagon/gdbstub.c  | 68 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 87 insertions(+)


> +void hexagon_greg_write(CPUHexagonState *env, uint32_t reg, uint32_t val)
> +{
> +    if (reg <= HEX_GREG_G3) {
> +        env->greg[reg] = val;
> +        return;
> +    }
> +    qemu_log_mask(LOG_UNIMP, "writing greg %" PRIu32
> +            " not yet supported.\n", reg);

Not sure void/LOG_UNIMP is safe, LOG_UNIMP is only enabled with
'-d unimp' and goes on stderr, ...

(nit misaligned style)

> +}


> +int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +    HexagonCPU *cpu = env_archcpu(env);
> +    BQL_LOCK_GUARD();
> +
> +    if (n < NUM_SREGS) {
> +        uint32_t val = ldl_le_p(mem_buf);
> +        if (n == HEX_SREG_SSR) {
> +            uint32_t old = env->t_sreg[HEX_SREG_SSR];
> +            env->t_sreg[HEX_SREG_SSR] = val;
> +            hexagon_modify_ssr(env, val, old);
> +        } else if (n < HEX_SREG_GLB_START) {
> +            env->t_sreg[n] = val;
> +        } else if (cpu->globalregs) {
> +            hexagon_globalreg_write(cpu->globalregs, n, val, env->threadId);
> +        }
> +        return sizeof(uint32_t);
> +    }
> +    n -= NUM_SREGS;
> +
> +    if (n < NUM_GREGS) {
> +        hexagon_greg_write(env, n, ldl_le_p(mem_buf));
> +        return sizeof(uint32_t);

... and here we tell the user the register was correctly written.

> +    }
> +    n -= NUM_GREGS;
> +
> +    g_assert_not_reached();
> +}

