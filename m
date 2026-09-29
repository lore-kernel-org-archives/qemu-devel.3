Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6874CCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWta-0005sy-RY; Tue, 29 Sep 2026 08:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWtX-0005n2-R5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:25:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWtW-000483-A3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:25:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCDrhK3850710
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IKtT1DUNm1B1c8TfoWC4u/5ZxfNRLSH1NgmY30smmHk=; b=bTFC693THPjNUSDu
 4G6x3LHUCD4oWHeVDw2mJwcxvZcPBG9BbyVqNE0tQWH2VaA/Dx/wNK5ybou7jqm6
 79kfEWgnv/QBnTSbEx03dL6FsPsOzQ8P5+pMOmqqBg//kpi2lFHKvJhzRqp1i6kE
 fakD9Z93N8sdWgnZj1fObsBXtEaE69SxINsFM6tVemPkmMIHSpECJoHl0+UOBFbv
 Ol7+DikTHzq/3SUK7GWp37pXx38CoI+rIXkIsEXDUcOCFM+HP/jyQjv4tkHUZyPL
 Uiz+jBnptO1nRgSE5dyKlFIZQ/2cmAhXlYVFX6kCmuIlezqrtHWbkmC/k6M7OaYO
 u68Y/w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1ge79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:25:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93bfb2da664so1181843285a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684711; x=1791289511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IKtT1DUNm1B1c8TfoWC4u/5ZxfNRLSH1NgmY30smmHk=;
 b=QmjoI/qrEeRUrkdlLsL+5oe3CNBlaMa2rlmME7bKx7uIyBfZvcRsIEujSNNPay+/Nz
 lAMJ/Z50F3BK22rISy2oawDEyudjqU/nfzyJthqQNFr8uOKG3lMWSjcszxh/jOOsASKE
 zlOC9gCY6BulckSLz8NJhBGok3+ynj9PKnuB6jEfs7njQ9gWQk4cGSuS8uGp95rgjm8O
 pTp1phOcPK8L8iEbO/PUhfwU38nQpMg3nypSeMwAYhlYi6MQ51oF6qYilRcqXLUG9AEr
 CPwBk6gDijTrpGK8VXlzu69qXvzieaymSu6GyNJ2XzpSEzx6f/70bv0l35Zpgv1UG4B8
 TY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684711; x=1791289511;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IKtT1DUNm1B1c8TfoWC4u/5ZxfNRLSH1NgmY30smmHk=;
 b=U3xJ92cNh8SBgUP3U8kFSTTkAkAAvBq1Dm76fOG/mTSg3Sf5CjN7IQMg9jCCa9dfJ7
 efqX9gzVAn+pxx3P4UYSmiziReDItY/vz44NsVPUqJ+a1T+mSdEDro8+5bfFHwggmLok
 9+o7lF1BVdAiX++rjUnK1Do6+Lo2qfQYxiWDelvkk9whGZdxUO/ll3JYwnKFjcRuMBfX
 6gKVCzRCOGVNHAkIZRI55XygfDGshnX7FW4XcfD8Kh5vvDxGXz45xh/+KgQ+gc+fWytr
 uHqZ3APCIH/fGAoJvMYZPL8ak9m+/ey+3/mCTTijI4aBOn9RkwJpy+C6QIxL2HbGrR0C
 kv5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ5NLBoQSXNQ0yXgCms/sMgnGx2AkdvrmHh00kSBAq0k3FWKPt7iHv4AxpU8z9b5GmsEktnOFWT/wM@nongnu.org
X-Gm-Message-State: AFuF++ndgl5TcSUW/8zp/ko8XOckPOTO1eckifrAi1O+qssGKJEXybPn
 yFV/uEvOWAMeZQQMBkya5yBzbPVaQdRLj8rn63+1squMIe/WeYDkXWednkh5U8HV6tENO0wwAxC
 TPmQJ6A7TDLra47l43GrQNF3SK8bfEWLy8Dq87pNxoaVXPRKepEI2hDJcLw==
X-Gm-Gg: AYBFou38zp+j8gB/Vo3nfLevoOD+JT/eRpwYm5IDR7FP8IxZrYISUUN4ccDzcFf3LDn
 BJ6tg6TRoGsj+0J0EESO6cXgq6/nXRRaBG9N8YRGlIt+MPzGyZ8nvBEZZ4TPKB5CbZopoZHTbM0
 j2vp14los/P6KG6KHWBWYmYsfselBwiDy5RbRYRJKB3Is8JG+O6kW4Ry+X+Y9pV/P1aL/RkzA2R
 0toXptdw1VwqB3keWI6dHu1fmnv72HQPV2XdNl73V/3waCH7g7szjBgS7Qzahl2MMkPCRUmXFPq
 8UOjdrYT7aMeymywYMLfXYm3TjjLIYBNpIMr9ml1oz3xZl8mNdG1k5raK4TJ3gEgnNArtVA5ebL
 jja4FXTlrTQI+CldPM1GV7s5UnpIkLINgKQ==
X-Received: by 2002:a05:620a:46a4:b0:93c:6b90:1d18 with SMTP id
 af79cd13be357-93c6b902283mr1542271685a.62.1790684710775; 
 Tue, 29 Sep 2026 05:25:10 -0700 (PDT)
X-Received: by 2002:a05:620a:46a4:b0:93c:6b90:1d18 with SMTP id
 af79cd13be357-93c6b902283mr1542266985a.62.1790684710404; 
 Tue, 29 Sep 2026 05:25:10 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f886b6sm4074674f8f.1.2026.09.29.05.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:25:09 -0700 (PDT)
Message-ID: <bf30f4b6-d175-496b-99a3-0f33f36f00da@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/42] hw/vmapple/Kconfig: Remove unused GPIO_PWR
 dependency
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-34-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-34-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX2bQbmo8djTbz
 F7GHlJvOnrFSrZwYXI69ZuPHpqftwPQeyOor8zJsiW+3pbN/XN7NBxdVsfOe6jLnfHgy02GTJhW
 kD8RGXeH0Mb/HMGhJDAMU5acsc83aAY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfXwyOSvpiMtMeY
 gR9CGAU3Z5LRkBGhehlgo7UhQoX1mXqoC5HTlkV0N67D3aYW3MaXoYMIE78dUM/3a2+kkpLEkd+
 Ds15x2jCnc6rKHCHOjYe5KzhTMNtTG9CPQih87KBLKxD+yGY8a5JYQ5KuVxfYYQzUFSxadMQX9N
 RI+4d/eHl7WqpQKKdb/EJjwE54RvvyaFHb8jJ6Gg1kE5zTB3TgIH7eZjcu5+1+/vuVnpi4vzzBP
 L5hjRsCo/8tITsVvcomKRqGod4VjmOiqH36Ow21XoQMZAr1dr9pNZYinm1nuSBkkdw4M3qPJ8Ay
 iDLf9BcntvOSx/KAhdD9gQW/cA0NkVJ3C72MMWrujDa5NPa9yKLW6LaEl5OSrLhSeiM72EsuAJG
 5vrcpAAjd93QK1UB1CFJN/yBf/OMkJc1rytALNEphpyTrD7rz7vYPEtZcn9hkTN3CU5nacFeM/y
 Bc1xNckzHwDjBUN/kXw==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abbae27 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: oquMeo8fKjxQ06oL0dIhRPW4SrkosqYj
X-Proofpoint-GUID: oquMeo8fKjxQ06oL0dIhRPW4SrkosqYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290049
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

On 21/9/26 23:47, Bernhard Beschow wrote:
> The config option GPIO_PWR provides the "gpio-pwr" type which is
> currently only used by the ARM virt machine. Remove this unused
> dependency from config VMAPPLE.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/vmapple/Kconfig | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

