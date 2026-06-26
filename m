Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD576C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd8eo-00071X-WA; Fri, 26 Jun 2026 11:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wd8el-00070C-W3
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:39:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wd8ej-0004Bd-V9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:39:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QF47nX1733513
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E46FYzbXXRuPTXAtorRKrLCA02lw11U+vsEZuUCTJZ8=; b=b+elB4YK0sLxrLJz
 2NwSb+i21lT5hXuqzDTrELAn/Znjyza54S4mCR0SBEr+LXA6RuKr74yLGAly84cw
 hgCE0vnBD8YH1XQTirlgQ9DNCxes0QTCbRerBM9WU8xCbJ17xOaSQzS+Df9VJ7vV
 DE1JqOcuf+yQC3UZxEeg2T6xrdexWKvB+6LPlmN8lZyAzjdTsNoCCYvrQiXhW6dX
 oYurYsfgX9q4dzlW33Apzl+6hHw772SmmXpaNo6kUS/HoJMMAyNADjDw9UH5payP
 4Kjf9dE6BQohmuVPBECH/vjvPLUUKAg/WXXbYncBqtYa+TDkJ2ayWesviI1w3Xnk
 Xk+IHw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eewbc7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:39:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so1232742eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782488386; x=1783093186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E46FYzbXXRuPTXAtorRKrLCA02lw11U+vsEZuUCTJZ8=;
 b=ALsPRzrHQYibMawGm8BUkk+6+bZIbmtoBSatagSPth5c755TLCgs4x5DUML/EskR5P
 wIC5omfmiJPour0pHBNr/pioVPkZ2zMZxTxpMsVYSA/r55eQSeh1fM2fMusG73QHtm7q
 tTuMn8JwklBcYe5pGUlucyse/p2Z2lliHGmgAqXVnYyDgGT+A4f61IkWvH6PAU94xwp4
 xR8Z2FMe52VmMcK3xe+h++xO4DaFMsNYmuJxJWVKxJEbzYdfxbjBXfS8Zq9krbseSG3A
 WCCZYT27PPn8oSLVLMmXAWFYaENPggOARlGlUn6HcfBdALIfuruUu0GI0etEhZOpyTvF
 Kc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782488386; x=1783093186;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E46FYzbXXRuPTXAtorRKrLCA02lw11U+vsEZuUCTJZ8=;
 b=j0qPun0gIsRc5v2mvKuBTzxClQYX/esYgzjZXMgL6sIu3ppJ8f94utshRx3+3A4FHF
 29QvlSRfok8YgE9P2I0Rufq5KuLCJlenv0dGo9yNODtau7sTNN5HiQDh414RPckUbQTC
 Vxwog1KDNUt2/g1R93i9n6jaHsnNoH+1yNxTLW9okAKfgtFb59Ktc3/suYq1rCiiYv5c
 TjjTAFafprEmN0ILzde/kzhDJgH+g70tMKLuvVjn3ur2RtIx/Fu570x5Fkdug2JlG48W
 KIUExfpXRole/PqZ2lveXg7X5FJ9cDdQQIaUlf04iZL3tiTmQ5LDTjkC96y5mvay2D04
 0a0g==
X-Gm-Message-State: AOJu0YxGuHHu5Dvlk8TIbKwjsbB4uUSKw8G+ynmlz53Zb1ktpv/NynEq
 aV5Pho8rMKsLH7daw8++I/LyFowj2un5nz4Jf+thV2vepC5BN+wQqkY1hI1lmzsx2MBZUR6LkK4
 1qVfDSnCNEdiNeIWy9kk5UKHAfVnxOyCCuyEO2F/kzxS7dYllTAA2DhoXIA==
X-Gm-Gg: AfdE7clP4w8tikAC8tdEMgy7xWTGg/T+ZJPb55krwiMa57+1pR334wq1VQFhGCVKXmH
 t4NwGoijRVtzRIApb2AA9ZVcnL9rCJYBKVpl6FN8wXknXoLEzRD/WBlBxpQmb34Q+MXATT1Ydhx
 h8Fu6OOUoHxJbn4LGjSrDXLLPEBJ7MRwjlOGvDVu1w4iMx2UbAlXIEIKQNunaJvvOw+IftPdfMZ
 /5gduB6hKnNfdNTRTOPTTVbQ3B/JJc3fF19pKiD2cXGaVCno1WmvwjTlC8NOX2cAjouwMnllCFS
 vwibuG5oRR2dVoq3H6i4H7/i7oRg/tofHuRNGER4HyC76mT+rVckLKpwi6YUbiAlWvl2H7rhNLa
 XUKRKD1pabvvp7uJBL5j7N22mB2ECZwei3HViE6hPa3rjT1mgxBgcA3hSRr0hVvFXrdVHLUAP64
 xW0so=
X-Received: by 2002:a05:7300:7b8a:b0:2ea:4228:ab11 with SMTP id
 5a478bee46e88-30c84b1df71mr6074106eec.3.1782488386255; 
 Fri, 26 Jun 2026 08:39:46 -0700 (PDT)
X-Received: by 2002:a05:7300:7b8a:b0:2ea:4228:ab11 with SMTP id
 5a478bee46e88-30c84b1df71mr6074070eec.3.1782488385279; 
 Fri, 26 Jun 2026 08:39:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c944d004esm10258642eec.22.2026.06.26.08.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 08:39:44 -0700 (PDT)
Message-ID: <9d695c7f-bb02-44bd-8e1c-f8bdbf3bbbf7@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 08:39:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/system: add general note about architecture and
 machine differences
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Linisha <linisha232@gmail.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com
References: <20260623205839.1294-1-linisha232@gmail.com>
 <20260625192121.1887-1-linisha232@gmail.com> <aj5P0n03aKv93uci@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aj5P0n03aKv93uci@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyOSBTYWx0ZWRfXxxDjwXYkdarf
 XGCBaeDycfoiVzuRuPVC45MTljTjTizVBcCnR1ELR+9Ct+C+iT5kXqOXbD8ybG48QoHnS6wOeJw
 qDLsk2mkcUcclusB3ZWfb8iUrIC26HE=
X-Proofpoint-GUID: TodwX0aAcY1dBvbdHJ5blIrq7hcxJPcZ
X-Proofpoint-ORIG-GUID: TodwX0aAcY1dBvbdHJ5blIrq7hcxJPcZ
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3e9d43 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=2IXTaRTgaJI3x-eaTxUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyOSBTYWx0ZWRfX3nhYzlBiSdY/
 hsOe7qytlkYOGrWPDIh6WBMytf00J07m31lA9YuqfMQ8gemfo8dBM6QhL9M2VJve1amgMWgOXUB
 4qSo1C3SdI9OqneBMkX8nUV5okgQpOf6o2Rjl24bFr6yCA6Y7HWBHi7KPu61OhPtnRERtmHyeAz
 +uYiKIRIbRDKJnlTt0iD3FMrYPHxycLDzAIqaPdEoW9AX7IqTdIWoLgZdatE1Bv5/ytHigR3viJ
 S2UJDu4pRNZ5IGxSi1PM/SNy5Cv7a3nUyMwwc6klOI/bOt7GGMMhlOIK8EK8rxnzmmccbKs7Qjt
 NdRtTFdo/BLkL3MMkG30H71Bpu3bU7L27eXZlUvxyEGH54ZMJZ1Kro6WQbtXBxgL8wu4F1O+4br
 8tmC2IMlNsOT3eqP60k1KHmEuWS/+AkXcI1kwX6MQvieJqjunfhdQD3Ok3uC0bvTGW4OCg4nUl0
 WvyXrtWQRsihmnjGpDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/26/2026 3:09 AM, Daniel P. Berrangé wrote:
> CC Pierrick as docs maintainer.
>

Thanks Daniel.

I wonder how I was not in original recipients for this patch.
@Linisha: did you explicitly set list of recipients, or remove some people?

> On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
>> Add a note near the start of the introduction explaining that QEMU options, properties, and command lines may differ between target architectures and machine types. This helps prevent confusion when examples shown for one architecture do not work for another, such as the pflash0/pflash1 options visible in -machine help on some machines but not others.
> 
> Please ensure commit messages are line wrapped.
> 
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
>> Signed-off-by: Linisha <linisha232@gmail.com>
>> ---
>>
>> v2: Take a different approach based on review feedback from Daniel
>>     Berrangé and Peter Maydell. Instead of incorrectly claiming
>>     pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
>>     machines too), add a general note near the start of the introduction
>>     about how options, properties, and command lines may differ between
>>     target architectures and machine types.
>>
>>
>>  docs/system/introduction.rst | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
>> index bec7291e47..8d9ef61d26 100644
>> --- a/docs/system/introduction.rst
>> +++ b/docs/system/introduction.rst
>> @@ -1,6 +1,15 @@
>>  Introduction
>>  ============
>>  
>> +.. note::
>> +   QEMU supports many different target CPU architectures and many
>> +   different machine types for each architecture. Options, properties,
>> +   and command lines that work for one architecture or machine type
>> +   will not necessarily work on another. The examples shown in this
>> +   manual are specific to the architecture and machine type being
>> +   demonstrated. When in doubt, consult the documentation for your
>> +   specific target architecture and machine type.
>> +
> 
> Not convinced many people will read this, but I gues it doesn't
> hurt.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
>>  .. _Accelerators:
>>  
>>  Virtualisation Accelerators
>> -- 
>> 2.47.0.windows.1
>>
> 
> With regards,
> Daniel


