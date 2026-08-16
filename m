Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88568C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 08:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvWbf-0000TZ-1k; Sun, 16 Aug 2026 04:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWbd-0000Sz-Sl
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 04:52:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWbc-00063A-3q
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 04:52:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67G72hxe3129574
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T5Ov2WEgzcQAZaQvNAgyhHLjZ6dHTw3sZRy4aWjj9+g=; b=FrPybcfxepLcKNdY
 RzU0JNit5vxxybFkRzM5JY6llOz/xbBu7+M8xb2IyGSE8geAvohoYztcLmMIk6s0
 7u7AcMimjLm4X2ejYPHUAkmzGs35pZbpM4thRO0bC6kDeQYusewpmkeeMsa04pVw
 8qdM8ISe/xe9EM+uMM9Zy66EcNgOBpW9Tt82+k7k/Vxzyx/k4ueRAMqgRJqxZ1tj
 yjvHbNAmunuXR+njsss2EAH14h0qeFuuOESMwTUd5gAT0Me08MILvWotBDPcNQ2G
 iQDIGGbv7IOD85JwBUcrVilr5OS6RcbjG9H6ESkuzWY6RmlGFSlvu11W3yYRnVlN
 qram3g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnu3sx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:52:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934979ee9f1so300258585a.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786870354; x=1787475154; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T5Ov2WEgzcQAZaQvNAgyhHLjZ6dHTw3sZRy4aWjj9+g=;
 b=aosLHRFOndWPlt1RfnmFrwgc1AmNzOkThtc7n7PmQoOxmAeIcxpmOesPrRE37eW/p+
 QqXoA8kVXq1iSYgo9qEvrl/hAqWIdLWDjiOSjoU6/d75U5EriomUxDq9i4tvkgPgdIcj
 3pIjj/WwHMzzoqJkM4vdotxN/gRCXUiPRKvtatiynKrJ5G98uNeoOrcejnpIlUYA+j7n
 myQcg/oGTcaZUUODneZPBBiEMByxvAhrUJv7YhT8yZmDwZKP7pvQDLhcgcaSHocHPxJv
 5vIYek8ml/wQbgi8jej/tLNoGih3JapTw7utmWnwPgfOO2fXM2RWLudZKLMt8aWVY7LL
 qZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786870354; x=1787475154;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T5Ov2WEgzcQAZaQvNAgyhHLjZ6dHTw3sZRy4aWjj9+g=;
 b=Sx988/2aNSNekji4MbBUArFxEOKYP8hEZ+povKw+3dNLXgqSTWRQqOrKTfcEmp1OYu
 K0+zOTG4jc7knCPMC7vCMRDwyezcMQy97ouFClTxNZ+2FAOFuY69pZS0V08MxHDN6ek0
 ntfK4IfZ3c9xcN8uz43EY5nGI394W8EwLJ6nUgm7SG5E//Bpkhg/Vnz0+VH2wybiipzp
 aAmdaiwhHAu26TqEKNWJDRhIwOqIR9cJnVEH6rgRB0pGLYWwSCmFKtMdg8L21XP0+dJv
 yWwEFvBM9fV7sPWCDPD/CLZr0J/zk/mwLQZFUkggqB6RB/p/cM9hisD3rOSV/tsBz/z+
 fE3Q==
X-Gm-Message-State: AOJu0YyEzKL3F3qSukDSzl/JE27FnusHg9D9DpBovakgTVFnlycXnYnx
 /+Px8TQZhdglrvLqWj4xMyHA0bEuN9dKnZXfp0462BYGgnfPWt6bpMQqShEoBUzDX/aZBT9NBoL
 AIV0qU9B0gR8mcyiWxUou6Ralv44ppU80SF0b/xQBjvjz8ZFKHnYYurxjUQ==
X-Gm-Gg: AR+sD13QdSyAvV1F8VRHz6V7dsOXvS3enXa5Wi6LrLTAZNLTvykH2N/LwwwhyMfW7Mh
 HRdpZRwnK40ZEQJUePIMdHJ0ZI4ml1z8uEZXKgLAmgrPEa9N1+DAmIoxyKJjSHvZjyocjYQtXAV
 ZRbse5SvYQFTxPnQbOd1u+wXi6C30eMxISUlfA181LcicKjN+2WiQ13qaHKb/viEzS26fw+6Wlu
 LwAD1KREApNeN5qANc9Fn0zBXVNotlUSCxcxcZQU+0EXwhFRGzrTB4wClNkTB2zaurTFAcqYLRG
 7PdOvr7HTGAGpnre4CK8H/zPRpe3fEa/cAYINVE7ceRR73EGwRA2ubUk8tPYD/LPl8wpmPNF1mS
 bdO7bvRMdx1bEol234+awUpErSBdnRYjMlN0=
X-Received: by 2002:a05:620a:6e19:b0:915:f96b:8f5a with SMTP id
 af79cd13be357-936d2331185mr1543191685a.36.1786870353705; 
 Sun, 16 Aug 2026 01:52:33 -0700 (PDT)
X-Received: by 2002:a05:620a:6e19:b0:915:f96b:8f5a with SMTP id
 af79cd13be357-936d2331185mr1543190685a.36.1786870353194; 
 Sun, 16 Aug 2026 01:52:33 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d20fdsm169309725e9.1.2026.08.16.01.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 01:52:32 -0700 (PDT)
Message-ID: <351e6d2a-20bb-48a6-a1f6-0800cf2a969a@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 10:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/arm_gicv3: Have GIC kconfig select GICv3 for HVF
 and WHPX
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-stable@nongnu.org
References: <20260812220816.94034-1-philmd@oss.qualcomm.com>
 <CAFEAcA-NUOtTPuvxKja+bNU6wy6EQFVMfX9nmQ_LbtAPKHqMXA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA-NUOtTPuvxKja+bNU6wy6EQFVMfX9nmQ_LbtAPKHqMXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2NSBTYWx0ZWRfX4gUHAWngArZK
 vPUSpzs8uysnHqVPpEbwcNABN9lD1AyJAha8MpS+V3WS/PoQYL6L2PM7rWfnedjw4FgLMlZ63cY
 acs6a6oFGo6kiEAwNpXj8erDr2mHR1awX6RlBb9Gk+8vp8kHZOLGvsmSPMy6tNCj9cdmAnkLsC2
 ybQXeI+YMtq3A/+O3LNIcmasq3pKFbeJy1TQRByCXKnQhWWwAiZohxDtHO5/RmLsiIf3AXSKWwG
 jwiFECLlp1engt3344rJWp+vcMSVCjoCd1onfXE6jaRJfKDC5DLsQLBhfDoQ9ak7pnFX4KI8Pk7
 IEeduHc3MTDGeqQi5ZDQAm9LhM5jqqxL9D0roDl0RUSYt2BZicWsI8j8O7woHtDXaoTaiHQP87l
 sSEbdH8Yyly4v68Ls+0Gfln/NVsvv5D25ajuPtDB8mCX9U/ezS+Hov7mUdCMooTQojkHhiTC8fD
 6xUux8FifcD/bWqzxGg==
X-Proofpoint-ORIG-GUID: kk2iFmBLWdcH7tqoC55eG8xFCjYGiE_E
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a817a52 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=sjlnlqp1G4b0nBOF4k8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA2NSBTYWx0ZWRfX7lXQ8ZFhMbUE
 wOaGULdF4CDgHjMLCjg3Fi6HGiJ9I6oEnkknjMMWbSDbGN6TVVi0ZXfMiSoxk9CBmSyukZyq0Q9
 u3GXGfplPKme71b6fpT+e0DGTVsq8qU=
X-Proofpoint-GUID: kk2iFmBLWdcH7tqoC55eG8xFCjYGiE_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 15/8/26 16:53, Peter Maydell wrote:
> On Wed, 12 Aug 2026 at 23:08, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> While trying to fix the GICv3 dependency on KVM and WHPX in
>> commit 39a8c3941eb, we missed the Kconfig ARM_GIC symbol only
>> selects GICv3 for TCG, not HVF and WHPX. Fix that.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 39a8c3941eb ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   hw/intc/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
>> index 097de4efc5d..05e697967d0 100644
>> --- a/hw/intc/Kconfig
>> +++ b/hw/intc/Kconfig
>> @@ -26,7 +26,7 @@ config APIC
>>
>>   config ARM_GIC
>>       bool
>> -    select ARM_GICV3 if TCG
>> +    select ARM_GICV3 if TCG || HVF || WHPX
>>       select ARM_GIC_KVM if KVM
>>       select MSI_NONBROKEN
> 
> Is this instead of RTH's patch "hw/intc: Fix arm kvm gicv3 selection",
> or do we need both?

Richard's patch only touch KVM, so we surely need both.

I haven't tested KVM but rth's reported error is the same error
I'm having on HVF and WHPX. The ARM GIC Kconfig are confuse to
me, so I don't feel confident to review his change. My gut feeling
is what we have is too complex and could be simplified, but I
haven't spent time thinking about it.

