Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EC6C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxB5C-0005vK-VM; Thu, 20 Aug 2026 18:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxB5B-0005uk-Sc
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:17:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxB5A-0008Ew-7Y
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:17:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7dKp3242372
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O1DgHDdmWX02SUH2NBQJEeEj/Rl0+K/0+lthwEwT4gw=; b=Fx84ec0BU83KTlTW
 bV8gGE1UmlbDwIr1E8ZfFqh4MbbfW7yCLAcaMyjI+7MFJII8T5a5AWKNA6kNEj5L
 H98n3dcwVWPBxbrQa3U8TRhKeYDyRVhYDbPre+HrUtNjfHOORWWxo6vfO82weWSO
 J0hes8c7gw/9Vi4NyJ/dbgE2sVMg7IuA3Hj8S1OzOEv3E7VuIJNd6vmvtVTMBINH
 e8b+UBjntFEQ63EoKF41ExSeUrYPy95jpLn3eBqfnquHD5Q0LH/YOBtYMuaobwZg
 ddomRc0bz1FPg3yeeUy/V+Lx4acIN5aK6RA5oCM38YMHhOauh6xSXqmUEoeFjGFd
 tbTohA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x05uja3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:17:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f5ac7354dso399244a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787264274; x=1787869074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O1DgHDdmWX02SUH2NBQJEeEj/Rl0+K/0+lthwEwT4gw=;
 b=BfmcLNJyNW5FA4PvkqF5eLeTrzfkjWk9TaRxPK2A9WXmWuRGgm5ThYffCrNyzPbfFY
 +hdMjfQ4ZV4VPdH3ewfUb/HTwkA07ntMYs2VIrLlcYPia8KF0TDGnFgNAJl4PR+YFH79
 oPPj3TX92MigaidFq+KSZS088vMyHyMkSnlydl4Le9nJDC0rBFb6VyWQPfiO8xIIawMc
 cbAwuBT2CngyVIoedo0dpHLfH07K795EOViioeBFOrnLzKyLr+F9+uwCtEJbW4nTq7J0
 GiXFk8xCQ50XfLtH7Re5qBUbsDwmC2fnx/uETuJ6CNjg0/hgZimuW8jAzxZ+A0dl0xZd
 NYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787264274; x=1787869074;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O1DgHDdmWX02SUH2NBQJEeEj/Rl0+K/0+lthwEwT4gw=;
 b=mzFzepsNhzQI/QisvJs1TBN1UG/nV2s8wVuo2SapW7rmUcJKhxkZ7TkFXYqmNIyOGB
 hYyBYTVGkRSHL1sxg4fGkNeYTnG+hNa+qeCAlMPLmrpmdXhqQDwaVr02tkB2f2pUYfDC
 p2u3SbGbpJ1U/DoNNa+1Q5b95yUKPfoC9x7lyfasl2UnOV7X05bk1Dm8k87t54cOR4Wh
 OXg7NQfMIbjvimuDavTZ8PQIWaM39W2KqoDzbEIdXLWeAjXYYWblqAEjjZXdM1Hz9ky9
 SpOp9kzBTqsaAu17ReZmF9FkPQ4zrn93bfUNkkWECa+PpvZzfCPjUXSulkRRiXWP8jqo
 d79w==
X-Gm-Message-State: AFuF++nk5zIpi9e83CpozXyPCo5KtkBLSV8nq/DsbuDr+iSmNtUhPHMV
 xzfoPDJc/8Ack1I4y4Z3B0Zz1I4JuDB8FwEquj440PHrKsS8tA9jf/Mc3rJ9MHDa99HoLJYuCyv
 hywpstjvXNj1NzNdMwvw9T0Kv2D7I6JX8szwCEeRP6/JSJugfzhnOqIux1g==
X-Gm-Gg: AR+sD13E/PZWhtJ76+vjjMSvqnsUrPPTTVeNIHeALBdFz8sF6yuSfdFHNche51uTz22
 Ckq68ESdztm+9yqnpR8PIY/4zV3raYB6KFwefTWLwq1rzDWy2LPKBhTDXk5cgeHL7kJS7HqvV4X
 V1h8mgPRpCsiSXVvC1Syh3MpfUCsQ++mEk6amgv496D3wGgC/RYbqkDOuNTBSLwZac4YtJ+9Kf1
 Rad5okNcE6ynTTGGFkUUy+EDTgy0JZ6EMB285DiTqpFyzz6/OU2E/azFssXjLU30evBlG2Y2FM1
 lBFLX9D4zgs+xLEN9kz3+d52Dme0oIgb88BcGthXN7LuPwHgUH43wwUwg7G65ldLYTb8XwtnT5B
 f/NGxZShueo27HYxLObffYCGySPoqc/9w5q4crLxt/R/tx1hJNUPS2kSo/XxZtQza1erD
X-Received: by 2002:a17:90b:4a81:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-395c33ec558mr2504089a91.7.1787264273889; 
 Thu, 20 Aug 2026 15:17:53 -0700 (PDT)
X-Received: by 2002:a17:90b:4a81:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-395c33ec558mr2503969a91.7.1787264273348; 
 Thu, 20 Aug 2026 15:17:53 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae5f1ffsm31415047c88.13.2026.08.20.15.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 15:17:52 -0700 (PDT)
Message-ID: <94e049b6-f144-4494-a089-2bef2251ca07@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:17:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 05/28] hw/arm/smmu-common: Add security-aware address
 space selector
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162410.2805113-5-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813162410.2805113-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KXFNu5QbHz1gL4XcZh0sCsAlrHFJCvFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX5bWNv1L2+/p2
 dLzn7T++vtl927cUTJw9cDlbo1M7KqITEgUJBfwbkss4yiwaoky+C639ZLeaXsWUcn4MES4vFCm
 F+5BQ6CGzxQu/mC9JHYmb6Qxg2DOf4CxxtkvN4q5nE/d73IioLohTO0SsU+Aikq0Di8pDpan2IT
 wgAaUcd4EAi6tpzy+jvRvESiI9ILzTeZ4IDWht75ew0KmNSOWDtsz6aly6uORRhEVui+DmjIi9C
 hsZLRzE16QB+ZaFreWCG7cU+LR3/Wjbv59W0ZpJ0F7aYaIoFdfkiq7mC5sGyKDrviKM5m26E4rS
 fTZXv3SHDur2TDaIfYdDyd2wHtpE5c23yPv+hYjqY3DAu0jgwGVMDwGew/9SYH/F/dgkVI6jfBf
 avfp2U2v9rWwV6ofOU+6mfqUN0S2gA1Pxj+Obatpgn6fb3PvfGZ+w54WlU/HKEOI6LCl9Jpz94w
 b/UmLpFhsVsj1jGHLqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX7GoQupcFomCg
 TnlUp87yReq0pl3YP9yKaIqeiWDeRr03uLBVCzUzW7zoiW8PGITALN+OCn4g688W1tH6Ay9MW0y
 bGZzrFus32D7ppgYootOVDReSRbCfkk=
X-Authority-Analysis: v=2.4 cv=VfPH+lp9 c=1 sm=1 tr=0 ts=6a877d12 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=fgrLqfBXAAAA:8 a=EUspDBNiAAAA:8 a=a6Ko7388s_gqmAnDnXwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-GUID: KXFNu5QbHz1gL4XcZh0sCsAlrHFJCvFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200166
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/13/2026 9:24 AM, Tao Tang wrote:
> Introduce SMMU_SEC_SID_S to represent SEC_SID == 1, meaning Secure. And
> then provide smmu_get_address_space, a SMMU instance-based address space
> selector. The helper returns the per-device memory or secure-memory
> AddressSpace selected by SEC_SID.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 15 +++++++++++++++
>  include/hw/arm/smmu-common.h |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 8e40ba603d3..54a6a9f4d62 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -30,6 +30,21 @@
>  #include "hw/arm/smmu-common.h"
>  #include "smmu-internal.h"
>  
> +AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid)
> +{
> +    switch (sec_sid) {
> +    case SMMU_SEC_SID_NS:
> +        return &s->memory_as;
> +    case SMMU_SEC_SID_S:
> +        g_assert(s->secure_memory);
> +        g_assert(s->secure_memory_as.root);

This second assert is not needed as we know it was initialized in realize.

> +        return &s->secure_memory_as;
> +    case SMMU_SEC_SID_NUM:
> +        g_assert_not_reached();
> +    }
> +    g_assert_not_reached();
> +}
> +
>  /* IOTLB Management */
>  
>  static guint smmu_iotlb_key_hash(gconstpointer v)
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 6ea40f6b074..9d6e2d3038f 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -43,6 +43,7 @@
>  /* StreamID Security state */
>  typedef enum SMMUSecSID {
>      SMMU_SEC_SID_NS = 0,
> +    SMMU_SEC_SID_S,
>      SMMU_SEC_SID_NUM,
>  } SMMUSecSID;
>  
> @@ -188,6 +189,8 @@ struct SMMUBaseClass {
>  #define TYPE_ARM_SMMU "arm-smmu"
>  OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
>  
> +AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid);
> +
>  /* Return the SMMUPciBus handle associated to a PCI bus number */
>  SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
>  

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


