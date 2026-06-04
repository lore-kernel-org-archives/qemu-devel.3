Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0E9CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5N8-0007ku-2w; Thu, 04 Jun 2026 06:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5N4-0007hI-3E
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:32:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5N1-0001qP-G5
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:32:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6549GwJ12260724
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 10:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kcoYFesn4CUliLj5oo105SmiNe62ojOiMqdnqrtBJZA=; b=aVLWm9EASXmg3V8V
 DD4hJ2CkhOgH0P1m3EoZKR/19KwNXd8NlTppwzo2ShcKMvWOOIlcibAiYazNQ3pU
 NaDsscj9D/3N6F5hOx7rztTD4xK7ygiACHLfuiiDJHyO3T4CLvUZNNmbyQ0mEa9X
 PdvgI2Trdr2q3v+6PheCnZLzoK9iNVJx/qmV3bBk1pjcdXGJeyyoaWM0rLr7xip/
 IZdVMX39bS8qccpQI9cYxjUsC9ogx6R7YOFnotlRn04la4iOaK/F9qyRmAlkS+DI
 0400NKVirzNYxWWmVFEEQNobGj29MDkzZ+NdekA5Ql6G63aJbF+FX0UJf6inKXK6
 XVjp2A==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejr2mkmnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 10:32:13 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-660f247c238so917060d50.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780569133; x=1781173933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kcoYFesn4CUliLj5oo105SmiNe62ojOiMqdnqrtBJZA=;
 b=LsgdALmvJvIag8WywMviqgQbq1ujtEDGOCK9N/vbVjrutzINqAhDBn/WSYpL4iTe1p
 nlzWBX3vqkQZyQ1soUYa8a/sa066Xq6fXcj6/S6DtfzEhs1uDR/0jrrMXzvQn4/1/GyM
 GXZSbqSl7WzJGMZx4F4ZVYrJYqg5iczmerLImuCP3kJJ9WiPqirpaPQkxI9Sw7mHUi9/
 hcNb21H6wbcOvFl+3Vm2S3MMLckTnar0TocysQdFK6T5BwguqBz4NsTs+lU/NjlYW3FW
 NqP/xD3FviEeY5+BHovUBpd4CIO88LLF6hbNtNRp8j739Wv2bJ9/fh6ua21s/iTcQVHC
 2Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780569133; x=1781173933;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kcoYFesn4CUliLj5oo105SmiNe62ojOiMqdnqrtBJZA=;
 b=mvyj+p/Hbf9tDhOQLfhUVYG7YwolQoetdbGYQTksbfFqlw114DQpqs2s7iqFDnVhP5
 +S/ciHT2dZOcAYqOvFaNOeduhcOFlQIx4Vo/fwwdoTCVEoEFPVNsE7XwU9GglRxnZB/D
 DMCA3Do+U5J3tCK2EIDk+ONHFHSaE5U3gpXFa+u4d5YBTPh8Grs/xum9kNuX6qd8IaQQ
 bXsa8SyZhLAcnh/8Q6akG0TpNxO27aXI9WvCJdORBw6PJ/1o6mFBVALyb+DxidTKv5G8
 7YxtWZrmuFXMuoj4b8aSfLL44AlfcmLTh3xBb6+9a/TjTccobP6fucbsJwW5r+/PpYHh
 7EDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZJrlS9/YBU5cRUfUmEY0LMWA8dn/Nk+5luvyieQqaAtfEzr0fjHqLOUc6mzbo/4MwTuPfeL+JFHSi@nongnu.org
X-Gm-Message-State: AOJu0Yx5W5bhdQpSa0sDRVbSfZ0QzgXA4hQskblD4WuP4H3B2fmA0hRI
 SeNgP/4JuhePwwAahN03128/6k3T4HK/GZ8hlrULdG2Gi8PYrLM/G9bSiGoLwn2jGklOAXUOARk
 i2DXo+wEzFgQ5gAgEgTAYl8XOSzmbmA/4sbzwfGwPSMzAS56fDq2SKcecJQ==
X-Gm-Gg: Acq92OELKZHmBw9Yom9IU1By9WNO6xYLuFvOVgL0Rbbu9W8wAr9wxeU3UHjQHFhn8OI
 8vB8yITZdYNDA2hMNXWeJXFIZY4KsLzRa5QDZcLDsA9wTtAmJmD0pEbxh6V/Nd3RjByiAxVuqim
 RonST47kTBb7kAvtIfPoaljlwDAQOR4MCCktLjIDN/y/zDDDpSSF0+3dRkcstaWyN9qHQ25iLnS
 7XSGAv+sSUFi7201nvmQTpgN082sCowQEiu8AKj9Q7F73xkY8NgDeF+eIjr9LclbNkvlj56HKly
 5VVNwVuHbV3rTQj5RsMDQoaocoognj0pNj9TbDPTXm5MTQA9GkGEUPGr/bwPixRLnNERJZqr6Ki
 TCKa+L2+5QZnIy4+U/NNWGEhb9CM5iY4V/HJGXHhLlKEYWvb/je5E8hgEJ85VGRZaGDeR
X-Received: by 2002:a05:690e:169e:b0:660:7460:f913 with SMTP id
 956f58d0204a3-660dc0515cemr5905159d50.26.1780569132717; 
 Thu, 04 Jun 2026 03:32:12 -0700 (PDT)
X-Received: by 2002:a05:690e:169e:b0:660:7460:f913 with SMTP id
 956f58d0204a3-660dc0515cemr5905127d50.26.1780569132131; 
 Thu, 04 Jun 2026 03:32:12 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d62046efsm3561371d50.11.2026.06.04.03.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 03:32:11 -0700 (PDT)
Message-ID: <3db409c9-65ff-4556-be69-7026ef3dc637@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 07:32:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/25] target/riscv/debug: Maintain itrigger_enabled
 in helper_itrigger_match()
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-11-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-11-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o-Oz2mNc9tXvpHi5vnNyzQdCRe-ciBgQ
X-Proofpoint-ORIG-GUID: o-Oz2mNc9tXvpHi5vnNyzQdCRe-ciBgQ
X-Authority-Analysis: v=2.4 cv=A91c+aWG c=1 sm=1 tr=0 ts=6a21542d cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ftf0STVcFXjSZnxUVb0A:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEwMSBTYWx0ZWRfX7GnZn1i5kVoO
 56sX2VJiASAcFWDkCxZv9IwMocYQ1m7OufhNuVzrEftjXKQzPbkE1gibzk1PR1pBMO3lv5LO40I
 Pr8ANghLmxY/W1fbsBus/KUAAwEqpA/FTBPT6cmaHH12wCKFGZLqRdwODcPRQUqFvTiZ80LFvLy
 qP40pRlmJm+gapF/VCuS87Vdqacgsec9QZcP8FRCzm3s04ytjXxvtzcgMeyyEYmaN/RyAq1rqYZ
 oF8utw7aBD09Bv98I7VZvllbCAB7HEtcn9yv5eoJg/unERUF8TXupRpFSF6dsd3+IiO0x5CqUp1
 WzpJw4jjHcnHwnhN1ytlqPXsLSRI3ydRFC/QxLem9zsL7/OMEvIexxestcoXbHPmFZms7gjw/xD
 Z31TnkZqitFXUgmM7AkcV3C/54Lp5ewseQLPw3iKfnXJpd7Ho6ap+GSKRONStrCkpgNy6jnrkpV
 M/DknmdADkWw0mrAIRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040101
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> helper_itrigger_match() iterates over all triggers so it can maintain
> itrigger_enabled rather than calling riscv_itrigger_enabled() which
> becomes O(N^2) where N is the number of icount triggers.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/debug.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index d835c0e79a..7ae02fe2d2 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -693,9 +693,18 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
>       return false;
>   }
>   
> +/*
> + * This is called by TCG when an instruction completes.
> + * TCG runs in single-step mode when itrigger_enabled = true, so
> + * it can call after each insn.
> + */
>   void helper_itrigger_match(CPURISCVState *env)
>   {
>       int count;
> +    bool enabled = false;
> +
> +    g_assert(env->itrigger_enabled);
> +
>       for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
>           if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
>               continue;
> @@ -709,10 +718,12 @@ void helper_itrigger_match(CPURISCVState *env)
>           }
>           itrigger_set_count(env, i, count--);
>           if (!count) {
> -            env->itrigger_enabled = riscv_itrigger_enabled(env);
>               do_trigger_action(env, i);
> +        } else {
> +            enabled = true;
>           }
>       }
> +    env->itrigger_enabled = enabled;
>   }
>   
>   static void riscv_itrigger_update_count(CPURISCVState *env)


