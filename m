Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C192606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yu1cNA5I;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SwbsKNVD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJNK2-0001GF-CD; Tue, 20 Oct 2026 23:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNK0-0001G7-DB
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:49:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNJy-0006TW-Sx
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:49:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2EtaY299884
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cYHbuJlRFIVhNpMSqeUuxi092uzI00WWtS+pcdpO5gU=; b=Yu1cNA5IBS01P9oS
 5o61YqaIcgRLVhWGkND7dJiMTaMQUJJVVl/NlwfmoLNUlp1xdVmWte0iILYHW9TP
 mIcfZvPdHzbyNCouDcdDM05Fkb0x+fu2D1c4wMPMWTpvmgzF5F5SGuChn9qLX0xP
 qO8F2lFkmdKP4TUBXC90GfRCi3jbaQWsvYKuI1ZW6kzPRTSSpAH5dw8CZ5YGkcK/
 jA7JbgPJbXU6dgDBf3lrTSCp/k5o4y15wnjLQf9Q5BthiLv2CDQX7w3LxKDLrYMq
 elYq5nOpOfrKLRWoTcfLlUjLf/ScPnTgGfnFP1hQFKrRXO8s/F1Az5VT5vZBeycd
 plcx9g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4std4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:48:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so64258885a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792554531; x=1793159331; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cYHbuJlRFIVhNpMSqeUuxi092uzI00WWtS+pcdpO5gU=;
 b=SwbsKNVDfjVd097M1+ZZYtXfjIbfHC4XXGJsR1C62ApciPbCEMwL7LKYqFd6TetS8q
 4JfaOhuDM+HvSBYBW1hIaaIMcF66N+29dD2YdgA/CbKbjZqg8gPK01NZfgp3tqM1w9At
 K/1FmVCvpu83opOzWKtWOd2Ifi1EEige0ZuS8LlQcf04VjFEUVjOTC3qQJVNJzfi66/y
 ZTHYZWlH+GvpjBnaBGzFaMVbUUD1hrQ61bP5OQPMV0m6+xFYAD9QTFBJVGc4RBI3jft4
 lOXbeKPugDCXeL48lubxfGmR3ZpzwWRPv4gd9nrYUxIe81J2UGjlzsxgaBVyxgJ6Thya
 gjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792554531; x=1793159331;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cYHbuJlRFIVhNpMSqeUuxi092uzI00WWtS+pcdpO5gU=;
 b=f0RR0m2GRnnlllCgiedFV8wqVkhmbgebwbiB89O8fC7nmo8E5qIYQcw8rM/9KWPVhG
 5iX5lmTosLVyTxsVSP4MKgIS3tXv65k3crC7oZ9QPtk5Puvr8XCwbTAFZ+7XbdHUwID9
 Fxy3BqqRrzR3TCTcA1BMq7V3sQ9/w2xYC5Xp+HzHEQlFZkjF4OdpxEaJs2TyMkyeI3zm
 xiW/trWAq7M/jS+dNTBHbJsiD+LZSpi+Yq9/XWB4LJ1VvsT01BSqqR/QKVbye0MzXhMc
 KRS/gpbh6cmJ8rZWPlAs2GBVo2mnsLYy6/DCbWMLz1Pq7PwOto172SERUKzKaulk14Zk
 pSsw==
X-Forwarded-Encrypted: i=1;
 AKwUvByEiHbnXKMuhTt3jVDY2CLovbqVGvEIpsKQKM/Lo2Qinc6ZyMkYfhp3d6v0nOWwUH6VoXTScrvdAG8Q@nongnu.org
X-Gm-Message-State: AFq9FYJypYVD9KFAI2HhdY78ZBSSKdFKbGLlWKRP9tcHA9LBtov/aJSy
 4HqyDGnxs5UzQOm0KKIkwbW6X6j/flo253kGvS6ma/DBANXnSlNy+UbeuZESqHmtv/Ztz4yUoUL
 sdkF+3/fHIeuvJtHOa9u8TBsjPCsg9iHJjwHXXSjF+YgyCMWUThgFLXKGMQ==
X-Gm-Gg: AYBFou3YxvgNQyJ1XfNYzvtLXy6SSqPg5XXMFOds/NJs88jDbjXk/B26U8tW2JPNoPt
 DYZ5s4o9EzV+dPMp6J4VLdr53b6XZ6kmUFm5PgzFWKXasxyXh1HklfWuKaD8BRgnQ7Vk0dAwxQ2
 C/pAD1e1eK9+sYJZ8SSmRKki1+bFFrG58bDQKAm9oxwPm7FjJWogpGZ1dnfjsAcYTlal78VIR4E
 OJqhImnSeRHfe8G5hnvimwfDki+GMJ93gyxczw9QH4EVY8Lu++cWPsvz6zLtc/1axyFC41sEi0G
 P5RWg9FRLU9sMEWdyI+c0PR8LwcOgQyizQdJmA9QHuuJrhHYLatqnTyHh/4DVnvHUMjCZ5kXfE+
 pCDky4ons8fpf59Bzb5poAMBMZYNia359hw==
X-Received: by 2002:a05:620a:684a:b0:93b:c537:fdb8 with SMTP id
 af79cd13be357-93f57e40556mr242037585a.6.1792554531143; 
 Tue, 20 Oct 2026 20:48:51 -0700 (PDT)
X-Received: by 2002:a05:620a:684a:b0:93b:c537:fdb8 with SMTP id
 af79cd13be357-93f57e40556mr242035385a.6.1792554530620; 
 Tue, 20 Oct 2026 20:48:50 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2e8daffsm133607455e9.4.2026.10.20.20.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 20:48:49 -0700 (PDT)
Message-ID: <fe2f44b8-9a71-4485-9af6-27c79fe213ef@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 05:48:48 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/tricore: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
 <20261020122752.3651914-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020122752.3651914-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iBM7UiTEWr5Ig1uQzTsoQhzU2nC1ffLh
X-Proofpoint-GUID: iBM7UiTEWr5Ig1uQzTsoQhzU2nC1ffLh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNCBTYWx0ZWRfXxrL0F5Yba+5a
 vctBEf3mUqHwTeNHxYwyYRXnig6u+HLKjxsd5GQeEwowHp+/k9qXYvSeD2zwxcY6VhoCCeVtsd6
 XtG09xkowYHyNfvHL0PwQHnXZP//R+8=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad83624 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=QZ6kjRIZqm1PJJHJeKQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNCBTYWx0ZWRfX2MUiDtbcKFo3
 aJ1PQm5+poPvX8zH3RjPEdSeMFqcIpFvekOoZTu9ha/yPdUwo0G7+6v020Hm9410xLPvW6bvE3E
 LrMymqYCcYnj2MuQroipfOhDHF7sE6K4dUTwSZl3F7UJC96QjCSf+EcB5/ggTbf7fS3isRP+OZY
 K/aX5l2C43l/lSW7K5+ectYaY05O2wCyAiSTdPY2fPDZg3RFsctl2N0GvvfBYfYzNEX8OJKxhOv
 Eg3Yy4IqSoBG/2C3ht7T02VM/sWbarRlb7mSxVB0kg5EsH42XnQLV71J4wJ4/NdrAxShQFbOQll
 ZyCWanlYA3khRd3oCuOwSd5gFxknH1RrUo99hNpC1g0GNWCcTK5xfoAQGLlXZ1CfqJwfrsNwdWW
 /JMKE/3ik9zTfj7W6P38EsHYCTVbaOPGnUTCBGpBWfbY3RaXtqCbfcy1DitLf/NmyeGbJVfpw7j
 mP0PMJrz2VeZm1cN1+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210014
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

On 20/10/26 14:27, Peter Maydell wrote:
> Convert tricore to providing the translate_for_debug method rather
> than the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/tricore/cpu.h    |  3 ++-
>   target/tricore/cpu.c    |  2 +-
>   target/tricore/helper.c | 13 ++++++++++---
>   3 files changed, 13 insertions(+), 5 deletions(-)


> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index 273713a1473..9cc80b14c8c 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -47,7 +47,8 @@ static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
>       return ret;
>   }
>   
> -hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
> +bool tricore_cpu_translate_for_debug(CPUState *cs, vaddr addr,
> +                                     TranslateForDebugResult *result)
>   {
>       TriCoreCPU *cpu = TRICORE_CPU(cs);
>       hwaddr phys_addr;
> @@ -56,9 +57,15 @@ hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>   
>       if (get_physical_address(&cpu->env, &phys_addr, &prot, addr,
>                                MMU_DATA_LOAD, mmu_idx)) {
> -        return -1;
> +        return false;

pre-existing, get_physical_address() always returns TLBRET_MATCH (0)
so this part is dead code, but better keep the same pattern between
targets.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>       }
> -    return phys_addr;
> +
> +    *result = (TranslateForDebugResult) {
> +        .physaddr = phys_addr,
> +        .lg_page_size = TARGET_PAGE_BITS,
> +        .attrs.debug = 1,
> +    };
> +    return true;
>   }
>   
>   /* TODO: Add exception support */


