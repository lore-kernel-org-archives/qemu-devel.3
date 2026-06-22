Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A994CCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblxQ-00030c-IT; Mon, 22 Jun 2026 17:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblxP-0002zm-As
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:13:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblxN-0003zv-RN
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:13:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbN7w2122921
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k8/XBQ6YPEYj57lJe49ypWv+orav3G+3B8zjEHIvY2c=; b=h3LezXFfIfvvAMMh
 nbOLA6a4eQRaKi2yQZ7M8eSqyMJhTsMm3Zua3UNEMDqi0TbsFyPyf95saqipMQjP
 FeO4m17Wew3m0IodtLSTitHaaJWK8y/1m6PTH58Xe7ODhC+3OI9ntj0ilELmefaB
 UgzoMI/mW9aZFzCBBo8PKXSNAjWom9tjBDpLubNhH/eN6GEM+Yj6hQ04ce5dVMEb
 CSKUOSM2LstH7hfBdzPEf7F+7SIV+v2f40e7dW6RnWSS/YItb3zdY0IwEabvOfUp
 TaJ5JM621QuB/FVrbr+VVGtaFaCJw3BB58YW5Y9a9X4Eb2VyT+05C8slD7yrrPlY
 AfOjAg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n41qs6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:13:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91ed0e140c5so1341930185a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782162804; x=1782767604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k8/XBQ6YPEYj57lJe49ypWv+orav3G+3B8zjEHIvY2c=;
 b=PmIWfjPGbs2BxX7trVAHxeKCAK4RBUIeV30We16YtGQKHliplVS0hdBkMX92YMSv4G
 iyJnEnTtWGjxNQr2fyZkyKCtd39kXibwGQz7HpKP07KsLlyILEyfgAZVRG9/JMG1nxfK
 UCXurHmP+omQmNoqzEx/1zsnwq81WcfAeQFDU+f8i6a2cZiz3zVT/nIer5+kK2aIwKdN
 NEX6HRU0vqvpknry2//bSC0b1fX4QIhhodyj1U8ob6EK4NrJkob3XFTTj1GVC8fwTHkJ
 Piezbqmb5j0pMnYAn/5Wc5YqptZ19jU5MT0S0bl7m6s6yUZJOgdanJIpfxzD+DyV3S7v
 JskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782162804; x=1782767604;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k8/XBQ6YPEYj57lJe49ypWv+orav3G+3B8zjEHIvY2c=;
 b=oI0h4y2Md/ZaX6tipxTIPiBqXs0upvuFmE7v3tRXqsBqKCCS8iCzGyZk53z39v6N6D
 HVpJeZRMK/QE+Sdf3f58oDabFVyE9OuGSCmSY8RBh652C21UF3DRsWVmlKZ4IICpNpdx
 0GQuHn0BX4CbQl5omcvdyTdjORi2ESwqqiOKy8c8T7bP+OdgqMNqBlgHPHDkqyzuGTkq
 C5jnkSAHsRdGoovPhRfqwpE8Hgwan4GsLCOyIeaaeEejv4X87APv+5NWIACbDlxoRAgG
 8l4RUjhpkD2HgfSLAHCI5bV7afgOQbt9EBcdV6cZhe4zTimVuZS6WlMWZ+xGHYIJbxNj
 e/xQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ri/uv21xieyBy5ulU0ziQKbAmuIQZE5dqgds6504/w/bESn+zwJl/KfMf34A2P1QHcqvpFJCpzHB2@nongnu.org
X-Gm-Message-State: AOJu0Yw3pzY7W1RElWJ87aX/Y/DtsP60XrbBqMWx+dK4vrbDynPiXzyp
 icF//hsNy6yU+ofuAipcP5epEHluau4OEGF0UlQl29pwTEcRELkwIGw5A5o8zzuIM0Pu9RV50TI
 VySpXCHpFVKXs4qIFVpkXWYwiaRBlpyCgrpXzHdaZNUbUpeFkDfgQA5bIaA==
X-Gm-Gg: AfdE7cnBfAE5urMi2Rfa+0KDtC3AdS5yg0nzbqwuUO/akQeKZ4SWn85fX/05jSmfcIQ
 HPRKL3P/SJiOJrDOtEBgmHW/9k0o8/Dd1/WAWHihEHvd5lAiSLGplz1e01uE+B0Bhf8dOoz3JTA
 kwFnvjs70t1grTvoN21U0WlqHdNcYsQzHSfKrOih9D//ykPYuGPdU9hE/Ov1AXG3NSkknhAydQp
 u2sA4npK24WZS6/vB2IDmdKms+uEaGl77X92hBjbVZE5yhb7UWvVwh9V6DfwjEIVe0EQWIgcjnN
 isknnsZ42Lms2cHpJNY9JWiT767yHrF/IWvS0tyBOPLlLi0JFlDCXzWbvmDfxQ6vSDXZkJAooBD
 4D4hr08HvYHJ/cXkIvO3rLnvrERaxGxT6EgAu++tVAXTe/W3Ov+AM3g44OEP7Xg==
X-Received: by 2002:a05:620a:294c:b0:915:c7ad:8bc5 with SMTP id
 af79cd13be357-920913996d2mr2665724285a.31.1782162803812; 
 Mon, 22 Jun 2026 14:13:23 -0700 (PDT)
X-Received: by 2002:a05:620a:294c:b0:915:c7ad:8bc5 with SMTP id
 af79cd13be357-920913996d2mr2665717885a.31.1782162803353; 
 Mon, 22 Jun 2026 14:13:23 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd1fa34sm365048635e9.5.2026.06.22.14.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:13:22 -0700 (PDT)
Message-ID: <dfcdd6dd-ed02-4225-8238-f9a78636057d@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 23:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] target/riscv/cpu.c: filter TCG only bits in
 riscv_cpu_reset_hold()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-18-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-18-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNCBTYWx0ZWRfX4clT8YipeUMp
 WMyI6mFXSq3SrRUQr4bt7pf+1citjHGNBkAe4+1CfvaLS7pwSljjJFAJUXCcpFkH8BccR357ul4
 V2Z1BVD7X21uf0ETLXOiPn5DYrW0fVs=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39a574 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: S7cxOs0FkD8CrOCWQBRvIHSykJubtWrT
X-Proofpoint-GUID: S7cxOs0FkD8CrOCWQBRvIHSykJubtWrT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNCBTYWx0ZWRfX+5b3F1yNS0+j
 +k+gsAOJ8AW3eS6qk6iFpZTeYZ0NOARdC70C2BhGmXZy9ZnbKdj6pt9aKH8Ll5rNRD6gwLfEdbz
 6+KIBn6dOrH5gyfuIuYVMoSVQs+uE08eoLK1I6n/qKvTIH+b5oHj32/yYmMbcsG48h3LAvRVp1q
 eXw9TgSB/FGVtEZmaUmduVBTtoaRsdytTNFBVjODPwj4qQrMlDXS1qIsVbaHLAeZ0xhqu/cHPK/
 QAIXqITuZ3xNb4f9zVuGFRkZJka7vsWu0ddjwqGB2W5UFiH/hrNtsuXYZ6ld2Iw2Ob/aRGh/WyV
 NCgN2KLg3YaLCj/8HmoS1wgCtImvIJSf96Vx5mlvp1rx2VwirN5qwq9YQ/Vdz4736WO8Zi7PXtR
 zATn740qpl5eY8xtX+UCpHX6CuXiXlLtSul57IOwawxJm5jBWP/ZeQpfYR+C1hFmGxJMaGSS1ir
 9bGe5CrG/QycEop1nfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220204
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

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> We have a lot of TCG only initialization in the common cpu_reset_hold
> callback that prevents --disable-tcg to work.
> 
> Put a CONFIG_TCG ifdef around those bits to make the build work.
> Eventually we'll create a TCG specific reset function in tcg-cpu.c but
> for now this suffices.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)


> @@ -1013,6 +1009,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>                       MENVCFG_ADUE : 0);
>       env->henvcfg = 0;
>   
> +#ifdef CONFIG_TCG
> +    uint8_t iprio;
> +    int i, irq, rdzero;
> +
>       /* Initialized default priorities of local interrupts. */
>       for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
>           iprio = riscv_cpu_default_priority(i);
> @@ -1050,11 +1050,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       }
>   
>       pmp_unlock_entries(env);
> +#endif /* ifdef CONFIG_TCG */
>   #else
>       env->priv = PRV_U;
>       env->senvcfg = 0;
>       env->menvcfg = 0;
> -#endif
> +#endif /* ifndef CONFIG_USER_ONLY */

   /* !CONFIG_USER_ONLY */

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


