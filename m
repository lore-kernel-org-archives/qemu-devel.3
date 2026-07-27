Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F1FC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEny-0004lF-7I; Mon, 27 Jul 2026 02:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woEnw-0004ky-9I
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:27:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woEnu-0008EN-KQ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:27:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R1fp1a2240162
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tUvZ0eUlMImlDP3VdoMDLwTadd2TsCsWJdNGa+7f8J8=; b=TzMMfE1w5R38ZAcm
 LVWKxMlNXLFzCx4lTHty0HIX5JB1PoFS4D/VqofhgxzReL+FXDI/aDJQEAI117tm
 bSgwKOYYRvYkJ+FaXdMvjYh7y7Yty0Ci3uHcJ4m7vBVjv8NoHb1yxJaJwKoJGaig
 uDgfM9albv1mal/QUz0U8V2s6aQewNC3yCbIwyr2CAx9lYWpptDuREPGUTWWPajz
 mGY+NyggGIjnhIe+sB5MAD4iXC6SEqiWjabAb0LPCBTam+vX0wqdVBAWuQc1Gviv
 J4AM0W4BuRzqHUcNb/JLn3xoDBEXe0YO09JYLQr2xS4yzxCgLdVnwvIkcxXiTXIf
 OSZlVw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fnsxs13ee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:27:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a97644aso30773521cf.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785133628; x=1785738428; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tUvZ0eUlMImlDP3VdoMDLwTadd2TsCsWJdNGa+7f8J8=;
 b=E9Ohvs9gDNDL4sUduyTHgW1J/0p+nj9Z3ZKRNfjGc8ns74o4BeVcJfPWIAVllHBri6
 6pMpgTdnmznupz2aQGLiEhUgiahXucwq//LL1Kc/5814NFU4yek6IyrtRM9PHT+FQVxN
 58hmX3dYQXALm2dslp1/PBBBchGlWk3Qf0XOWoX50XwgMh4ieNs3w4ag1rZSvWX1uuLK
 PZSccmssWBGp02joD4vOJQHr2bcmOrEGGq5ALsRQKrVtNwDe0HcacmZy4xLDPkfxqErB
 6FNZGO17EGDY1+jggbYcnaK7953Z0PGCbOt5o+bu+NM4yNkoCuZRkZ76gsdyy6AD4vGL
 RbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785133628; x=1785738428;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tUvZ0eUlMImlDP3VdoMDLwTadd2TsCsWJdNGa+7f8J8=;
 b=KYZ5oaY9BGgXW2ny7CzwNGN0lTKjYFtvln2P17MagigFOertX4jKHTVsU0NWZIM8LW
 +0Shylk5iegUaBo9aDRHZjZDm5bKnuKeyi4bjP8XWT65nTdad4KAaaKT7dzPsc0O/WHq
 ESYGMAG9TlFdqS6cTr2akF2iGGbe5Up9dft+WUJSduqrYU0E/I7dapgskrNKfPdfgVND
 Go5S0MftYj42WJDuuTtj01KpnFjwgNWadYBi78k/Dww1o5VTG4XnslBbQmuRd4ndcak5
 NjZOcoURflUrtgFzxaS00191vJmIg1aaExIPBApo6RTttFBpjZ4SRH7c0HEvXSwnOH65
 NWQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqxR0KAGr833wb6pqsbWZdsVWUVIfRR8UCjG3MHffzF+BfAgQ2ZFUCg9/vDvqjzJ2BwxC7Jgf7Hr+b@nongnu.org
X-Gm-Message-State: AOJu0Ywoivweany2lg/0nhiDOyQiwiUkkNQYtR4AhM4jbvF5S1iB2Z0W
 50kSqreJClVbnaN8qnR1XZ2L5x8B+e8ZUszSJOq/FG63YKx+4ndXg/4C4+rfn65IjsEoS7HS66a
 Twwn/1WI0hEoDcStgDE4KvbCDCHrRBlROS/pifthtMJwX5xv5bMYlGG0HJw==
X-Gm-Gg: AR+sD123e/EuMDR8IqyzT7F7SVhh5dzMnFq6eEvr81ZYQyKbfA5flW/Z6BgVQK4o90u
 G2FJ5QU3fOi0G3LmUxKpdseOvwfVpuxKL2bbek8aMugzmeylTnBXx9sfG6JQuau116bTzTINdV6
 +K/9a4IJ5tFP7LRcrVSg+z7l9ni2+MDWCIY3zSxZRB98WgPDbLD3sqefCERqx6qX4jojUzSyn8r
 uP/aKrWtJecr3+yvRlU8nl/g7NUtoTdu/CNbhOfxzWb/aGunLposw4qiFwYsjdxQ8KReQIMgXZg
 33uMlDzTtvrdEgW4vZi1V4Xd4iCxuziOmFPf5JNOWg6iumhVsP6j54Y1luDNdAzwJJMSw2UO5RC
 oK2KMMB2gZKoY88Kig2a/r43Xp0jU/bKNRqvThOREWuigaHPyDVQ=
X-Received: by 2002:a05:622a:386:b0:51c:25da:903e with SMTP id
 d75a77b69052e-529a86f41fdmr73277191cf.58.1785133628552; 
 Sun, 26 Jul 2026 23:27:08 -0700 (PDT)
X-Received: by 2002:a05:622a:386:b0:51c:25da:903e with SMTP id
 d75a77b69052e-529a86f41fdmr73277101cf.58.1785133628155; 
 Sun, 26 Jul 2026 23:27:08 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm45980724f8f.27.2026.07.26.23.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 23:27:07 -0700 (PDT)
Message-ID: <c972ac12-20cc-4f01-bb49-fd09491265c4@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 08:27:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hw/intc: resample level IRQ on PLIC completion
Content-Language: en-US
To: lanxiaoyun <dubdublan1987@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com
References: <cover.1784966571.git.dubdublan1987@gmail.com>
 <b946a6859040243e973622b7f038a19c2021db95.1784966571.git.dubdublan1987@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <b946a6859040243e973622b7f038a19c2021db95.1784966571.git.dubdublan1987@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2MiBTYWx0ZWRfX0lmcBQPMd7t/
 WSq6TM6AyqXh6CIDQQ1iTEaCbZOuF2gC/40KSGTi1qri0xtJ/Xsr/fIy0EtU+ZEgXy9atGuXWGF
 9/AEsynCDtuuDMLb533BCOKkOII6HrdaiAfVsTc95L2j52SBc51XqjGn4BQnVcw4LCksAPsn7eu
 m+QZhvhj0b9ZVf2FMP9ILsCkMAWhlEFt9LHumzp4OaYqKdFZanqzSCFbM3WdD4iD4UgoO/KmPjL
 iQ7wizMH1NQ1+dchYm+kLBMC0D+V9BpZZIzgKTuuPlWwznR3+Lm/Oczwm/7AazCmBQvk+dMJZuK
 GMM+ZFBhD7UOA+4HBZA12AwyM0eTPbZkVPhFL0iKz5gfuu5ZITB0d2dPhB69VOeHu7VipokUcAJ
 YTIqFZYZ928COY32+XjJ4mzeZPZ5oXQ6PIgEn7C//1/c7MoqTU7qUqy9T1FVjXsMgiy2XNtRXFS
 2MYVBpjjk1XepxK43hQ==
X-Authority-Analysis: v=2.4 cv=EYr4hvmC c=1 sm=1 tr=0 ts=6a66fa3d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=_q44DS1WNQBOSQMTb2QA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: IYIKgeJrN-zgHmkM-eO2ZNZDe4U0ApCS
X-Proofpoint-GUID: IYIKgeJrN-zgHmkM-eO2ZNZDe4U0ApCS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2MiBTYWx0ZWRfXyv7iACTzwvBI
 kCdLuTs68SWHBBPlvo2o83I+5bdL0MfjmY84MsRpLJOGq0tIjosopc7pq5ixmW3eLJi+mBZPoal
 SCDIJPiEHF0mupamQibz+FrWsJzVdTs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270062
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

Hi,

On 25/7/26 18:51, lanxiaoyun wrote:
> From: lanxiaoyun1 <dubdublan1987@gmail.com>
> 
> When an interrupt completion message is received, if the interrupt is
> level-triggered and still asserted, forward a new interrupt request to
> the PLIC core.
> 
> This updates the SiFive PLIC IRQ handling so completion rechecks the
> current source level and reasserts pending state when the input remains
> high, matching the RISC-V PLIC specification.
> 
> Signed-off-by: lanxiaoyun1 <dubdublan1987@gmail.com>
> ---
>   hw/intc/sifive_plic.c         | 4 +++-
>   include/hw/intc/sifive_plic.h | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index 9c84ff06a9..43f235e329 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -246,6 +246,7 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
>           } else if (contextid == 4) {
>               if (value < plic->num_sources) {
>                   sifive_plic_set_claimed(plic, value, false);
> +                sifive_plic_set_pending(plic, value, !!plic->source[value]);
>                   sifive_plic_update(plic);
>               }
>           } else {
> @@ -276,6 +277,7 @@ static void sifive_plic_reset(DeviceState *dev)
>       int i;
>   
>       memset(s->source_priority, 0, sizeof(uint32_t) * s->num_sources);
> +    memset(s->source, 0, sizeof(uint32_t) * s->num_sources);
>       memset(s->target_priority, 0, sizeof(uint32_t) * s->num_addrs);
>       memset(s->pending, 0, sizeof(uint32_t) * s->bitfield_words);
>       memset(s->claimed, 0, sizeof(uint32_t) * s->bitfield_words);
> @@ -353,7 +355,7 @@ static void parse_hart_config(SiFivePLICState *plic)
>   static void sifive_plic_irq_request(void *opaque, int irq, int level)
>   {
>       SiFivePLICState *s = opaque;
> -
> +    s->source[irq] = !!level;
>       if (level > 0) {
>           sifive_plic_set_pending(s, irq, true);
>           sifive_plic_update(s);
> diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
> index 32973dbf28..627a418ba1 100644
> --- a/include/hw/intc/sifive_plic.h
> +++ b/include/hw/intc/sifive_plic.h
> @@ -54,6 +54,7 @@ struct SiFivePLICState {
>       uint32_t num_enables;
>       PLICAddr *addr_config;
>       uint32_t *source_priority;
> +    uint32_t *source;
>       uint32_t *target_priority;
>       uint32_t *pending;
>       uint32_t *claimed;

Where is this array initialized?

