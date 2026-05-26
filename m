Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53B7CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRppe-0005OA-04; Tue, 26 May 2026 07:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wRppc-0005Nb-M2; Tue, 26 May 2026 07:20:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wRppa-0001xn-HW; Tue, 26 May 2026 07:20:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q9puji1370210; Tue, 26 May 2026 11:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TjdUJU
 TOMLOBGC73ZV6MulVtIcD6dhnUkPZ7wOleAkQ=; b=DwDYaC9C2HnjuzqFEZah5L
 2YZvYzZPiMCZwzSQdvKKM8UxHr8iSVPYteedW4Pn/U3CwRONWWT8wVJpJEYNr1+A
 IcVYnPiHH9iAqiQtcku3sera9u78ajNnir0u93+9hyRCIq8n8TJsQfzsV6KGKRpf
 IgM/FYybSq2DsZuO2dLWSt2imJJlg1inOWp+3FzlTd2Zg+iJx5C3h0DcSQk/iOSZ
 tA9yarIQK2GMng72Vlq5n5MCY1KE+aw9nV4AZOMFQjX8SNB4ejeJAH30SdzW2HNd
 QLa5Kbm+1qRp13dcFIwHaxlQfd7zv74taj5AdVWz3uuZmRpAxe76kIYlKU8MdzCg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2bqy3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 11:20:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QAd8fp019723;
 Tue, 26 May 2026 11:20:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebqjjs295-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 11:20:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64QBK66351511564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 May 2026 11:20:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84A4120040;
 Tue, 26 May 2026 11:20:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC78620043;
 Tue, 26 May 2026 11:20:05 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 May 2026 11:20:05 +0000 (GMT)
Message-ID: <f4f5a3a3-f042-4d97-92ec-ca37e9991b43@linux.ibm.com>
Date: Tue, 26 May 2026 13:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/s390x: restore fpu_status rounding mode from
 FPC on sigreturn
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-stable@nongnu.org
References: <20260525152210.4119543-1-mattst88@gmail.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260525152210.4119543-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: VRQwAR0MpdvBrPPjZM1fe-8LE23DkBa2
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a1581eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8
 a=3C5sMMQzxbaJqVHWmA4A:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5NyBTYWx0ZWRfX61UarmHw9/Cb
 xPNlSuhfgJlPAhleKRog+YEws55/vSIamgKx9GvVQ4Iqwz52OsA3C5/y++iL+dtEPas54fEtRkv
 P/xpXItwwe0ampUtJo5Mij+kv2N2IBZE89jxjKkDa8zh652VJ7ArEDO8fBRwsgTQrGsZpsD2bBr
 aNsbU8dmyxxd5AhXJn8rBrDP2LfCUCiweBvONs+2r7sWGlSQ6pbL7Go6o20Ys7fmOeK3iCwz6gl
 SWgQS8k32e7/NlKb8TcBME1iRGy1nGLffpmsHP3TiO+HVPFg4Fv8pMiEXa6L52nbzIjLC4tb1Iu
 EAWUC6yv1CHpRH0UW5joTfEg3OHbXXmZYXGdGLT4Mpq3RqL9kTl9qdJyC5gk8dOFzmJeQkUhCC+
 IzAsJlGepx5pbJOlbpA6OY0atG4knioU0JjDEaUk7UKYUr9Dn99CQxLBkH6S8XcRp3+FZoz3cUW
 RYb1854LY3suf0e4PEw==
X-Proofpoint-ORIG-GUID: -RCBZWpQjV6qXlHg63NuUP8r-np5WbnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260097
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 5/25/26 17:22, Matt Turner wrote:
> QEMU keeps the s390x floating-point control register (FPC) in env->fpc.
> The rounding mode bits [2:0] of FPC are reflected into the derived
> env->fpu_status via set_float_rounding_mode(); every architectural
> write to FPC goes through HELPER(sfpc) which keeps the two in sync.
> 
> restore_sigregs() restored FPC with a direct assignment:
> 
>      __get_user(env->fpc, &sc->fpregs.fpc);
> 
> This wrote env->fpc correctly but never updated env->fpu_status, so on
> sigreturn the interrupted code resumed with whatever rounding mode the
> signal handler last installed in fpu_status.
> 
> Factor the two-step "write fpc + sync fpu_status" logic out of
> HELPER(sfpc) into cpu_s390x_load_fpc(), declare it in cpu.h, and call
> it from restore_sigregs() in place of the direct assignment.
> cpu_s390x_load_fpc() omits the specification-exception check that
> HELPER(sfpc) performs; raw signal frame restoration does not validate
> the saved state.
> 
> Fixes: 2941e0fa05 ("linux-user/s390x: Save/restore fpc when handling a signal")
> Cc: qemu-stable@nongnu.org
> ---
>   linux-user/s390x/signal.c     | 6 +++++-
>   target/s390x/cpu.h            | 1 +
>   target/s390x/tcg/fpu_helper.c | 6 ++++++
>   3 files changed, 12 insertions(+), 1 deletion(-)

Just curious, how did you stumble upon this?
It looks like a source of nasty intermittent bugs.

> diff --git ./linux-user/s390x/signal.c ./linux-user/s390x/signal.c
> index 96d1c8d11c..28ad80bde4 100644
> --- ./linux-user/s390x/signal.c
> +++ ./linux-user/s390x/signal.c
> @@ -332,7 +332,11 @@ static void restore_sigregs(CPUS390XState *env, target_sigregs *sc)
>       for (i = 0; i < 16; i++) {
>           __get_user(env->aregs[i], &sc->regs.acrs[i]);
>       }
> -    __get_user(env->fpc, &sc->fpregs.fpc);
> +    {
> +        uint32_t fpc;
> +        __get_user(fpc, &sc->fpregs.fpc);
> +        cpu_s390x_load_fpc(env, fpc);
> +    }
>       for (i = 0; i < 16; i++) {
>           __get_user(*get_freg(env, i), &sc->fpregs.fprs[i]);
>       }
> diff --git ./target/s390x/cpu.h ./target/s390x/cpu.h
> index 3acbe83f0f..f55b79ef8a 100644
> --- ./target/s390x/cpu.h
> +++ ./target/s390x/cpu.h
> @@ -895,6 +895,7 @@ void s390_init_sigp(void);
>   /* helper.c */
>   void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
>   uint64_t s390_cpu_get_psw_mask(CPUS390XState *env);
> +void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc);
>   
>   /* outside of target/s390x/ */
>   S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
> diff --git ./target/s390x/tcg/fpu_helper.c ./target/s390x/tcg/fpu_helper.c
> index 6ca0b7162b..b1c61d73d7 100644
> --- ./target/s390x/tcg/fpu_helper.c
> +++ ./target/s390x/tcg/fpu_helper.c
> @@ -1087,6 +1087,12 @@ static const int fpc_to_rnd[8] = {
>       float_round_to_odd,
>   };
>   
> +void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc)
> +{
> +    env->fpc = fpc;
> +    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
> +}
> +
>   /* set fpc */
>   void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
>   {

Could you reuse cpu_s390x_load_fpc() in HELPER(sfpc)?
The new sequence looks semantically identical to the one in the helper.

Also, I think we do need to partially reuse the sanity check.
Looking at kernel's fpu_lfpc_safe(), whenever the user writes a corrupt
value into the signal frame and the kernel tries to restore it, an
exception happens and 0 ends up being used instead.

