Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB66606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X/8PA/XR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O1ESLEfS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEdw-00057u-JL; Fri, 23 Oct 2026 08:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKEdM-0004x2-EK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:44:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKEdI-00069o-1c
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:44:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAxDr1444078
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BAZkJaKVGuU2W/5MfT1LoIg2UB8BPReZuk0sn3PxPf4=; b=X/8PA/XRq7VxquEK
 I1e5o8rofaOgY/Xm9oRqqnfxtepsIO6ENa7vpPPwg6JOY6l3h2I9Sclfsbb0x4vA
 i1sJMIykD61LCjOg/hcsOdZ8WItBzcb7fvPQTZ7Ggn5nju89bDazj9xBIgiHes+p
 9NvlGDfm4oJWMOblvCmKje4OQ30fexnRrj4MJbWd9+DGdeVqzldqxx8kjZORdi54
 bDQH/sPcz2KJXVkl2cZeXrOrOJoYF/kqeGgAaamQuQPTw4QrPYAztGGzFXn460jD
 ItEN0cjKK+TbBjR7sH9J9ZyWJTDtNtXnpMoUJGvTndEiEOBHy+5dfiU1zb+tsw+8
 gb2cMA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbkr1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:44:22 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91becce058aso24362066d6.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792759462; x=1793364262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BAZkJaKVGuU2W/5MfT1LoIg2UB8BPReZuk0sn3PxPf4=;
 b=O1ESLEfSgD85tb4wp5mSQsJJL6Sbm1qDKA0n7hJ7BM5UN1qL05PMK59bqneeuT/5yR
 Fgpuej+jIhgdTqMrTzb1EDu/vt04rOx18KC+lK9TsekfBtgXfmxAWkQ6Z5XwpNhe5sX9
 ayh8jcEIBwGIaGBY1kUVwV4TBFXog+5lfc40fr90wsOu0zhoJFrwKgSmfg95P/x/ShJj
 x3Gr9yrWPjwDtam32UGEUkiCBnzGvuJhPd7hMXMO3VaUcg6cmj2jJkvpioRQvOliNjk2
 pCuoh9SW7hgbw8JkfFowMg6q9Y02/oo2cdNTEmYg+1LMlbU2viLSUSm2ZYTpmyGMtRRP
 Nntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792759462; x=1793364262;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BAZkJaKVGuU2W/5MfT1LoIg2UB8BPReZuk0sn3PxPf4=;
 b=vcM8BqxiSpPOdx7Cu8wxhElwEQZu8UiIMFKzS1kvwLz7NDBYsiqX4Cqh37SBUCpzkB
 vVhm5q9mB/h0UMEmeIq8b1RyrZk1EQfS0ZohxPDRE5Mnnb4fAwhPcCUvhiGwQPxSPboD
 QjNCHfVrcO8CrW/rXMpRsURuWIP9CgUa6VTmU/m38J3rV/K/lLok0xIEJQOLkHcVQ7nk
 c3NgXxhLqcyZe0FOGTukahm0Pb7kZDMMJ4NQvuo7Ul3964s23I8nbORhtuHi1oyklmrD
 WmYCTmIWVoJqMf6CD2s9jtY8ZQsi0tJIVvYWcSoNdu7efAhPvhSOtSdiKITamTgyps5F
 Zevg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbM9Ujb46NVKWIO+EoG4gNvYmlI2tb9YAdKXhckZPyAMrvidUQDbuZ4SPaohciDflzPwFylUiVewGZ@nongnu.org
X-Gm-Message-State: AFq9FYJiL2lduQzq4KSojPXURbBJYvifgmfPn3JWiamUzqDOKLUhMd9B
 ldtMREod/7UJRTR/e8ZaYi8EnV0Tqf2iKmYgHGbVrp6DXIjS1kafE/YCdzygHZ5F/dYgw+eT3ht
 LoNRLZXoNtC+ajT64WeWnme6DOExb5ji2dXKq673l6i4fXqIz68jPsmFfCg==
X-Gm-Gg: AYBFou23KOZ2l7IlV6oKFxMUWE18n5W7BmNsuK0WLU5rDsKF5nHq2s5bY3PCN/2oooV
 Su6F4lPAmUtT2Yh3o5g8FsXWI3v+xbKSYMi8ByyjE7cc8VriaYLnogSenXAvb9SkedroTCUYWow
 6m4q+vXKIdTBsa1ZuX3Vn7rkWRuMkyYSxQNjbFEZf2O9mP/3flpMOBfeYgwi9ZqXI4oaTrlkOuc
 hXJSQebImhsKwikIIxKGBMiY94qegc0FCT79C8t/ciIlKlOHB+fkjWNJxCGnYk7xApEqkZfIZ2N
 DTNlv9n0iYh5gTtaJG7XqgR8ibdYRvc5AaDn2RC62WYEOJlXuhE6+XcUiMmAVuI7wi44YpLS4R+
 BAog1tpo4K7iuIff2FASEOvQqeD+XNVr6uA==
X-Received: by 2002:a05:620a:4483:b0:93e:fa30:f1dd with SMTP id
 af79cd13be357-93f6f8ba2cfmr368777685a.70.1792759461945; 
 Fri, 23 Oct 2026 05:44:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4483:b0:93e:fa30:f1dd with SMTP id
 af79cd13be357-93f6f8ba2cfmr368772885a.70.1792759461293; 
 Fri, 23 Oct 2026 05:44:21 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edce4fsm5226631f8f.6.2026.10.23.05.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 05:44:20 -0700 (PDT)
Message-ID: <1d64cc2e-26fa-4f87-ad98-eb485897bf0b@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:44:18 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/hexagon: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
 <20261022125858.310252-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261022125858.310252-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0OSBTYWx0ZWRfX2sfFVArn0YJZ
 BcBdzfc85kdWfws6ypw5II2rGVGHFsxzwIqQyh1I7+sMOLYai9jjgT+EOlZ0GS1qDHXzYC58kMe
 eETQsgTdip/keDFODc/ObXvuzv4qdtY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0OSBTYWx0ZWRfXxOs8gkjTWAtC
 +txW+sZ2fm1FdLAz4TFwTnzQH4G7J47TeI4CgpiP7vIm8Llv+WyHn/dQkYGByJf52aVMkQ+1scn
 MRYe/iwX4Hb9Msn8Ut5LKhJ+gJVETFjCR07Ef64vIIo/K0hqYMA3C4rowchy4bIc43V3K9hkV8z
 oQadxB7ZJA3F7Zv0vUaaAZ0ONsK0y+IWE8FV4GEqHyeGTHUsrFW2cQ6RI63ZqEBZfeOzwuURNav
 7By77K7AMhvmvbpqDQzB0TLoobS8fYh297m/itl7qZT3xATazsJUVewlIE6vMCseZPr1F+sz4oG
 c32BlIhblM+3PM1SRaGl2cgRTPJrnPMZj/wR+bSD7S6l+L1Os+BqdRsVEmlwdyNLycVaZK9Wws4
 km/G3V38aI2Z+9YauqpH2iWxZsW98n6YejdJ9Rv3orXwrF1+qRLaRBIcz4a0S9gO9CxX3piPJDK
 iAWZqLquPKMXmiAs7EQ==
X-Proofpoint-ORIG-GUID: QdVD6muwor34PHpkbZcfaWv-by43uWvn
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb56a6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LevUeAFVLao-9IJWzuIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: QdVD6muwor34PHpkbZcfaWv-by43uWvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230049
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

On 22/10/26 14:58, Peter Maydell wrote:
> Convert hexagon to providing the translate_for_debug method rather
> than the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/hexagon/cpu.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index f20d6de6f63..5e99e84b075 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -612,7 +612,8 @@ static void find_qemu_subpage(vaddr *addr, hwaddr *phys, uint64_t page_size)
>       *phys += offset;
>   }
>   
> -static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
> +static bool hexagon_cpu_translate_for_debug(CPUState *cs, vaddr addr,
> +                                            TranslateForDebugResult *result)
>   {
>       CPUHexagonState *env = cpu_env(cs);
>       hwaddr phys_addr;
> @@ -626,10 +627,16 @@ static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>           vaddr page_offset = addr & (TARGET_PAGE_SIZE - 1);
>           find_qemu_subpage(&addr, &phys_addr, page_size);
>           phys_addr += hexagon_cpu_mmu_enabled(env) ? page_offset : 0;

Faithful conversion, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Hexagon MMU supports large TLB pages, and IIUC we clamp at
TARGET_PAGE_SIZE via find_qemu_subpage(). We already have
the page_size (as power of 2) so using it is cheap (and
simplifies the code):

       if (hexagon_cpu_mmu_enabled(env)) {
            phys_addr += addr & (page_size - 1);
      }

and return with .lg_page_size = ctz64(page_size).

I doubt this improve much the debug path, except being a more
correct implementation.

> -        return phys_addr;
> +
> +        *result = (TranslateForDebugResult) {
> +            .physaddr = phys_addr,
> +            .lg_page_size = TARGET_PAGE_BITS,
> +            .attrs.debug = 1,
> +        };
> +        return true;
>       }
>   
> -    return -1;
> +    return false;
>   }

Actually the same can be used in hexagon_tlb_fill(), the other
user of find_qemu_subpage() -- which could then be removed:

-- >8 --
@@ -774,8 +765,11 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr 
address, int size,
                                 access_type, mmu_idx);
      if (ret) {
          if (!excp) {
-            find_qemu_subpage(&address, &phys, page_size);
-            tlb_set_page(cs, address, phys, prot, mmu_idx, 
TARGET_PAGE_SIZE);
+            if (hexagon_cpu_mmu_enabled(env)) {
+                phys += address & (page_size - 1);
+            }
+            tlb_set_page(cs, address, phys, prot, mmu_idx, page_size);
              return ret;
          }
---

Brian, WDYT?

