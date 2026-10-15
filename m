Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90511CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPOM-00047T-2q; Thu, 15 Oct 2026 13:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPOL-00047D-68
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:37:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPOJ-0006uI-Db
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:37:20 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFYQqd4077483
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 amXLv3V4JVn3CBvgx55Mw5FLl/jev4POeyxG7G/QcmU=; b=NOv14a2iCHr9EaUS
 ftqVzh2+aheCrfy3kyd5xluZO5toRmTo1AjAlNMgDajcPRm5nwiNz7NMCmBP6ARD
 ARyuZBE03M79U7t/XBF6YQQErrt4FgzOSEC1P0lBcguMWvQxxK43HUeiQRbPyuFL
 5QfB6j8IeCj1N9crVPFSFu6l8DMEkKd6W+uoA7uN8YjyJViUAtQTWXvltBDA1Py0
 16h9vnQHUjq4V3QaZLgCQoN/U7unyeht0Ps67QLQpbLrC3rkkhchMHk2BjkSFPHH
 7ZcJBhm8+rr4gf3pfZ9H8Q/KRf/dgVw5sl02I2DLJ/3jKPxRzX97Z5N14diuvlRX
 3bKaZA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc20bs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:37:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936aa34873bso360382985a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792085835; x=1792690635; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=amXLv3V4JVn3CBvgx55Mw5FLl/jev4POeyxG7G/QcmU=;
 b=jiE9e7vOqg9zPM+Wi4y2QYLIw6SU7VFd0REb7T4Np7kJNVkiNuVeEz91QUBBqmh649
 RuDNA1e8g2K1TgNrqPgHbe+6CbC52CgPzk2SKGg7sj0PVKYjJu4jRc1LLRlCzIQ1ljtX
 kewNdvvAXpnwuRGasM56frIIjeYMMl/3vyBiSL6zP2psgJ5TXegcrNgwYznlZDNWmRR8
 VYOAvf5V/3awSj1U17IuxR17+5wlxI+s1qAUAw6TSareF4CNlJDqrMtejxm9K/0XU11U
 iYbXz8z8jIXSlt/7c6jPzB/RxQf/Re6KeVJZCXOpBok23343GMQjZbRnsqiqW/J0rSPe
 ameQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792085835; x=1792690635;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=amXLv3V4JVn3CBvgx55Mw5FLl/jev4POeyxG7G/QcmU=;
 b=VNvOOSL6PRHXsFWi+wekCDnk8JllsPaPtDZ2pvO/awkIkBtcjczpwHmQCz1I0BxbMm
 mVijMUArZo2Jrl/bSkqS/DR/vsNIs5nORjtUKwrTLlFLldFTSXFvie7n/Wbpkvzch5Lc
 TC+LTSVNsp3YlWU08PAHIZhEhDUnyO2AUZN3XfGzdrlFJ478TDWQNIlAFdfVUnwfHZLJ
 p4u/3DHDwhd1V5S0sCVMP6h0cIIrI4y0I/Tl4FoKt5uD0j7JkaU/CqHnuXENmnPWTl34
 nrYDB5KRmBDf6HlAYEDHdASge9zop22PURMX3nAvv0oH3XAw75bm+wTbtQVitZhKt3yg
 xbDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmdNsOsUYIGOelSPSpouvG3ezHi91pdcohz2GIBe7K6SgqUh/XRwt2m278zwnCRDthGXmy1MZpYsH+@nongnu.org
X-Gm-Message-State: AFq9FYLZmy98pGwSa1gsp5ObtgO2iRNaL2H9h9VhSKbdHisivXPQNYdf
 x0a/+xaoO8GfTsW9a0WggkxXpVw3UOhoQfweYshe7z5Zr7tGCraA9hHYEHJXd87BlMk8hRsPoMG
 GBtMs9YOb1IHBv0c7ny2EbtujcJh8IHjHRwMliqFAItwTxj7MzWFO+JteUQ==
X-Gm-Gg: AYBFou1JVvUVzEWeItGnNbWTDw92umjnjJoB7lQwCOXhQ8+LxUv/8PbnW2+bxxK9z00
 pN93m1u6K/LwPFwgDayVTw15mslLBytRiK0+c3s64QcEI+olu7jVWJpODhNw1aw2s7ud70Wk0yh
 n3kA0CvnSGTuGpgr0cvLiEh9DHJ+N2qVmWRHnBcCzavqM5IDHKg3DdgbUF4GXRKwKsabn8rO6pf
 VoE8CrMyeeD8M+LgfzGSoOUWNlbiyMZVfLBKGWNWe40neQTq39S2c06MVKo3udOxa1/swOY7qk2
 T0HRaXHkjE8qykvgzCDj973U5ONQ7E4NILIxj9wBF1M3SXvmw7Z8xLeo9ozE1fVYHZ5fZyL2kSi
 /Vd+EhvPNaRc8tUj0I0groFgs1hgBwblEnw==
X-Received: by 2002:a05:620a:6489:b0:939:3885:3131 with SMTP id
 af79cd13be357-93ebd0c2fc7mr3005068685a.3.1792085835380; 
 Thu, 15 Oct 2026 10:37:15 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:939:3885:3131 with SMTP id
 af79cd13be357-93ebd0c2fc7mr3005063685a.3.1792085834851; 
 Thu, 15 Oct 2026 10:37:14 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaa34sm19882332f8f.20.2026.10.15.10.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 10:37:14 -0700 (PDT)
Message-ID: <b99355a2-a424-41b2-978b-8938de06cbda@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 19:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] target/riscv/cpu: constify cpu parameter for
 riscv_cpu_mxl
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad10f4c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cZkIkwtWA_EkRJw8LEEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX890z6oQFbiBN
 M7awmsk41VVO9Tt5Tt+064RQrqJ5PFMc4VDW/G2DKkdOJt+9AGINW7KRNx93o5qkiNl2ODLYTMI
 qgjXCqrw/7UEgQII7EDi3SIuKl9mO8o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfXwPnteVT3JLBu
 ESoejKm2vDESqVkASsPb4osBChnW9pSm6Y1V5dIRuK/70+DccKfS0/YafcdOd9YY4BV8+cuDefE
 6IyxOBuzb4gO6nNl5YMQwVSP311Uw5oZAjW4AfZzIiCjtvuBBOrBUlwQz2ZAIPBP7nQYlBRFN4N
 GElJtec5Tp5kp4JKO7bklFUKpo2BeE8TqqIW/HwVNZXxTHGrmgBxakXBoDqNHUTcCb1fQ8ZZB/N
 TWjnyJUOB6YcnrPj9mXkx1ryluXOMqWfRhJ5dGd65xwSwX+WlprUEqymL+Ic24gdmfeVTaGgb1s
 y0IrMOjUCrt4HwGOLldl1+VCCEV/ziGp+t5n/5NV8IeA5nCC+dXXyOKb/XgiL9lK+sSWib1Rh6h
 D8KeBT2fOJOqDdcvM4uoQWAOZ6XSV6iaJXPgVILVWEMvoaOoHzkDIJ5ayMr/h2oquSAfSbOCbGw
 MbEgVkNNvx8NJew0Xqg==
X-Proofpoint-ORIG-GUID: 5xz1vTmX8dnZ1OKMq-96kqT5cIxqBwEq
X-Proofpoint-GUID: 5xz1vTmX8dnZ1OKMq-96kqT5cIxqBwEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150070
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

On 14/10/26 23:05, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/riscv/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8c8ffe94cd8..00650a66dcb 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -755,7 +755,7 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
>   #ifdef TARGET_RISCV32
>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>   #else
> -static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
> +static inline RISCVMXL riscv_cpu_mxl(const CPURISCVState *env)
>   {
>       return env->misa_mxl;
>   }

Reviewed 6 weeks ago and in Alistair riscv-next queue IIRC:
https://lore.kernel.org/qemu-devel/20260901095229.72018-17-philmd@oss.qualcomm.com/

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


