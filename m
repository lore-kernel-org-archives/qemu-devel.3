Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B22DC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wIp-0006TP-SU; Tue, 22 Sep 2026 04:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8wIo-0006Sw-8x
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 04:56:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8wIl-0001p4-TK
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 04:56:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M3h5te1842299
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 08:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NFuqf/ob5IjLPNyOpIWNKpsEvcLdHKwSEG+TvA6t8fQ=; b=JAmc2XzekXqxxjnu
 NM4c6ti6jODylRB3Rf00NVwiM6p+AeM4wk6E3gcQnkMNRDY9zyTfCrPyXISW2h3a
 q2tS1l8b14J2k8CTnRUVOMK30pNZ5M5m+yiBJ2EXhkZEMJVy6QjSwfqx9OKPp5BQ
 2qkMVWwglPhDsIio4fZ4oLfsgZn/CmdaCDKjbGmBsKfbewh6vPpsGScLGx/zYDWy
 QAB9fkHTiUnTjpmEoPncalXNQxCiPJ6hAtVvoVWcjrY/dAgKIMVecA8C4jLO+zqp
 vF5N++T/sGcP8ndPw4QveinUoNPFKAdmIZ0uUEz7sM+JfXGVm1nlTjwzqR6bCw2G
 JKfVPw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guj1113fs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 08:56:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a01d1d1b6so586803785a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790067392; x=1790672192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NFuqf/ob5IjLPNyOpIWNKpsEvcLdHKwSEG+TvA6t8fQ=;
 b=foyMGheaOIRyOINB1v4dLK1rbKNZ/Cv6vHiOQwxnAuckDiuGyFTVj/PudB5eUI+Wc7
 XYqR93B+bI8qw6yJBAzxXxUhtD18cWAXfDnBHfqqc9qd5U8U6eaZinFa+0lAn/ZUqeJv
 mv/YFeHN4aJlVQQ4Y2hqK4ODRgeUopyUX2BvwDtoN06SLYvwpaOquozj8PCx1wF3QyjT
 SLoToMsEkqLqIXl3sT2lzJezGl45PF56ojFTq08aBBgqtMKXYyS7ZmMHvhrXGhs25sE3
 50qMqUF4J0Xc77978Tu4wSfgZ+J4mCkCHBI+7CrYOIorglj54r470NKXoaNJ+uL5R4R0
 MepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790067392; x=1790672192;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NFuqf/ob5IjLPNyOpIWNKpsEvcLdHKwSEG+TvA6t8fQ=;
 b=qOCvCUtAKX3F2p/xrKEYb3n6Or+JZpnyVnNGtljdGsmP/zU1hOWjiLTJr/bopLc9X6
 u3fPqU9yZPt4zyKmYM9n+bmchPak3NVPnjiUcNiu39Wf3fYIR18vAMm1qgBSbEgngwR6
 jwOTmqbzRFc7g1vgE4vmxrf1KbWfQHiko64ZAnRwEg2tR/4VAI8lkb8MRZgQvMFxh9zu
 f+OTY+R/yU4op36mE9yPMUFMH6SoMw+ng+l5qsIjqyyCXRjOgEiTe+WqvkjMSRRb5DF4
 vgxjgr1j72s5XC1uCwXR8PYHWdDsvsskMSoX9YVGnV6ouDpCb6+DovFW4R3WFuZp1O+N
 zq7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiNE2InnV09O3udGfMc1uF13jbwsM36h4hiszS9dKlCAldtB1FLnrVFFBGgOhSjUeNJz+JXnUTXb8J@nongnu.org
X-Gm-Message-State: AFuF++lVWdTlwVEv7/J1mh/vsNPSvBCk9mh2r7q6lh+ryXt1uYu2QohZ
 wGo3foOiKGDAA1JuYcoLgxaOOK0K5IL6vkX1h4JyAym1RDTuOTiyvRPXKN7bDhsO2vElNFxeVyy
 a2KMY3/FvElx/re+11FT/gmv9zQe4hnnzgzKTIKI9yFpAhwYj6zuFhfmAag==
X-Gm-Gg: AYBFou2WcoeVWSdU4JsvW6e96U0qbQSdkCrJSXuRF5bGJAXDZqLb6vT5t6EzYPQw020
 DiokiOhT+bUBUelPnykqotllwSnbRT0lT/jeCmhkUk23x/zq/tkHBfvr+yLkHaMW0bWLVgyz+Hs
 oN5Azybq9W8C6/aG3K/q7ApOjbMWkmhDV/f03m5cvBOkaquaiuEfTTPEBDbzfKvP58NUcTVaVhj
 SvOVoJ5RpU69DLBG8WOP3XZpU9GgGpMcuvq9eBbow+oA+RBCXCe++bmjDTiPoL6oMPGiH/j+CaB
 GNgBP3wXlAmehyIkba2sl2tWqTuvU3cZM7Qd4a9jXKmSJnOjhZujdtaGdYbDM5FX411YutG/ENV
 jVkGpTaWP3lkenTowZvbB
X-Received: by 2002:a05:620a:4888:b0:939:ede4:a499 with SMTP id
 af79cd13be357-93c197a8f04mr258740185a.5.1790067392472; 
 Tue, 22 Sep 2026 01:56:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4888:b0:939:ede4:a499 with SMTP id
 af79cd13be357-93c197a8f04mr258737485a.5.1790067392060; 
 Tue, 22 Sep 2026 01:56:32 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8ccc053sm67013835e9.7.2026.09.22.01.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 01:56:31 -0700 (PDT)
Message-ID: <3a8d34b6-a0cb-46a4-8ef8-6d8b029bf253@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/16] s390x: protvirt: Set guest IPL PSW
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20200319131921.2367-1-frankja@linux.ibm.com>
 <20200319131921.2367-11-frankja@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20200319131921.2367-11-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Wksrl9yppkjT53XjmAEeWS48IH99gNeR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyOCBTYWx0ZWRfXypWa58cMG393
 ylA4GcKQ7ageAsB/ekNRGSGulOu4eqvB2s/KjYrGtKrbIEWLb9siTUwuS42VU3RNEHq1oSSJuCp
 X0DudykFWBUQZZxO/oR/wySXnQWR5yM=
X-Proofpoint-ORIG-GUID: Wksrl9yppkjT53XjmAEeWS48IH99gNeR
X-Authority-Analysis: v=2.4 cv=atQnmiZV c=1 sm=1 tr=0 ts=6ab242c1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=QTt6BuOzr45adi7bDCnRgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=GkNqxiYgfmm5P44wggEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyOCBTYWx0ZWRfX+zvmqA05UaBy
 jEN6bZTC1ePm1bWTnyqqWPAe6dMMKki4MF+4Vr0gn6XkOSVTwxQAsJcJolUJQCjPVAKVnvd2Kqr
 yBijCJ4xKlfhfv7URu+XODFp/KSCIGyid6hoHkZ0a3MTKTMGH52pE7lBhPvgKGFA8OOyRnq2gR4
 6kwDCyTVCfDxCGoDRpsTC0oDtTC5SVHPQQAwDBEpgUDthVO7DeZqkd2ylBDGJHEDas8MrRzTXA+
 8EmtB2itccfvIDk5gdejMZ4tjP/kJMSRCQsWbizwvP7WMZa2eoybTWm7YAO6Tb8Cl44PC4EAxyj
 veCAlY0Hkqe7x7YdLDtkAbq2fMcA7PrIQ63DY3l9Ynsof/32BOwl3gS5rSHvVaGPtxD6/9FqV4q
 y7AFr7SXpdeVpUs98qiLZfWZi9yu+W8AFkaDtUjm+GLY2/UI/QlLIp8QJE+89MANNHhWbat0xGq
 4F7p+TL1E29MzXcV7bQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220128
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

(old patch committed as 59181010a2ff82c3a97e9b5768ee87c38e4815f1)

On 2020-03-19 14:19, Janosch Frank wrote:
> Handling of CPU reset and setting of the IPL psw from guest storage at
> offset 0 is done by a Ultravisor call. Let's only fetch it if
> necessary.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/s390x/cpu.c | 26 +++++++++++++++++---------
>   1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 961e3ebdc530cfab..71a0c9b3e55d0cbf 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -77,16 +77,24 @@ static bool s390_cpu_has_work(CPUState *cs)
>   static void s390_cpu_load_normal(CPUState *s)
>   {
>       S390CPU *cpu = S390_CPU(s);
> -    uint64_t spsw = ldq_phys(s->as, 0);
> -
> -    cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
> -    /*
> -     * Invert short psw indication, so SIE will report a specification
> -     * exception if it was not set.
> -     */
> -    cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
> -    cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
> +    uint64_t spsw;
>   
> +    if (!s390_is_pv()) {
> +        spsw = ldq_phys(s->as, 0);
> +        cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
> +        /*
> +         * Invert short psw indication, so SIE will report a specification
> +         * exception if it was not set.
> +         */
> +        cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
> +        cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
> +    } else {
> +        /*
> +         * Firmware requires us to set the load state before we set
> +         * the cpu to operating on protected guests.
> +         */
> +        s390_cpu_set_state(S390_CPU_STATE_LOAD, cpu);

S390_CPU_STATE_LOAD is overwritten the line above, is that deliberate?

> +    }
>       s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>   }
>   #endif


