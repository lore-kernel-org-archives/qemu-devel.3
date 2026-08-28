Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBB8C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05fb-0002gF-RV; Fri, 28 Aug 2026 19:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05fZ-0002ff-GI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:07:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05fX-0006Wx-QF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:07:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTVnn1173232
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KDiwj6MATfrkvVZLIhMCNFCaKfXZ4wx0Yru/QohbEtc=; b=RUDgzb4skPM+1Utn
 5l/O1k2S9egDW+pTb2JN6wfSmERmFn87hp5HHRhJhBlyunrbx+cTJ2qufuZdhldk
 CvgctmNx7LT60p0UofjBuSYYwEnrXIgBHIvpUTqspOKLn/1NAFQlxHFM3uSPuVLE
 TG1j8XTJR+Cb3hykGwp5Hfr5hjYbXbrsvTcnN9232kjN1Jt6WI28l87XlK6GQE/J
 akWK9Vew4ELMa4yosp51dAoca6rZgg0y/POf3V1kvi5bonCcKhQawbDKH6fIQA64
 x/4r/SRcfKMOIAz3jKDpQ5H12+ygQlIyTvTI5q06DYwwW0ooNtrb7t/5729aRhE8
 NFyKIA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afjm3m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:07:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf7dd9fd91so17999745ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958449; x=1788563249; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KDiwj6MATfrkvVZLIhMCNFCaKfXZ4wx0Yru/QohbEtc=;
 b=Gb2oTp1+nhQjEIQ44QnKc5yiaFrRb5MuFXt8jVZ2rncqRfJBPvBf8dcoXUS4oBmL8M
 UjhG+1MIE8RsXGhYb1jbrYWwQVTwN4RR5Fv8L6a4uIFp2Rb0O5sfR1Mt7xzNxPxmZzJN
 nboJMi2nkCUPAjUOQJaK0hq/oPAKshHMu/86VRj/MYBFIzCgHDBHJfnO5d6XA7BOQVje
 pCAGipehDjRpfB8s+hnoK/sw+bRvp4eWIGS5hYVxKsjLVwhNPyZB+5bRIzE9DRqmKsO9
 f1HWOiuBi9+34wqf8d5AnceDfaJTGirtsKtFvyTo3y2ZPgIlSuCKopUP/wgvTNSPlKo4
 C06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958449; x=1788563249;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KDiwj6MATfrkvVZLIhMCNFCaKfXZ4wx0Yru/QohbEtc=;
 b=rCzg4JUPLeoE0tUNarmCpqITyB4Bgh2WQii0xr82KdGGfyiO3xPsBsYWrO0nLZ1PEu
 Hz4PdsOLddHf6MlWWgc5I5tHBiquiKXXfG3ZU9y1lbO8+DBRIMAXmZHFKj2JiaEcUVg9
 vGlmCyPjtRfm8JWCvU05nG3QJ5B6waWU6ckgfhJhKzNi9xjeuxMuA15nr84cTV4IqtjG
 IgCXRR6tct8vR0b9mFal3BETKq8hthTvQCogrVqIpnnQWkGkE0Qa1mqzBK58MF1jJxQL
 CZ/RnOd1g19iI/PPYnVzLldcz3VP4GH3lEak45kzE491GpKwxtFE/ZxBHVWqjCpRlerq
 VE1w==
X-Forwarded-Encrypted: i=1;
 AKwUvByqdhHNQJ/YAMRL+SAML4oxJSbQR9J6nsE8hLibF4yeTKwBA6T32X6vMJAJW06A6Ta+l0hv737W+bGx@nongnu.org
X-Gm-Message-State: AFuF++lt6+78gpee5TCG73J51cvwhssQQ47Hzvif0NtN9b+yDw+p5uKS
 8VJUOt2XuqudhWq7NhCq3IemidVkjXw6uU4Oswtzix3OlDgivdzGRTsvmlXrkQc6emMGJxiNl7S
 kuddB//D7UTQYkNKEjt2O8hYVckbijncakcAsjbsrzgLe6Uhx0awq0R+ugg==
X-Gm-Gg: AYBFou2CsyBJoozl0hXhYozQrSXZOU+zW2g3YLCzvJiqASO94RhfDFHE2+bRIQy5rMJ
 IOG7oVINPcxQS7uqL0lJWYydTwmpmWe0N5g9T9XSD8jNz3vlZf5FWW/0tGqYRnkTn7R/2cLOnT+
 4dXexFXAZHjJKTrfA+gR7AFfkYa8vMtMKFRxeU+ytyiDGB5wy+amGj3+Cmu/G0qM2qCa5dlov+a
 KHjgaxNmLrQ0IcwHhyIp+vaN368lOxaDVgBmnst4kXo0pkg+aKXA+K35jPa5Nk4qbasxAUyC0X2
 ZDNM2RC+wQ6xpTrOpHnntGbPQYjYnViNJEeVt7nzH1vnsO1ZHS5GqARlYict7A1quGTK6RVvhhT
 JH8PEXdSZzt/9YIitmSHvPEsYyyvcCePvBFlXCM3sp06K1N0Fjoh8ObzCnWsacOc4epZx
X-Received: by 2002:a17:90a:1196:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-3989beabb17mr2910550a91.23.1787958449039; 
 Fri, 28 Aug 2026 16:07:29 -0700 (PDT)
X-Received: by 2002:a17:90a:1196:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-3989beabb17mr2910325a91.23.1787958446802; 
 Fri, 28 Aug 2026 16:07:26 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0d4b336sm9591742c88.8.2026.08.28.16.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 16:07:26 -0700 (PDT)
Message-ID: <ecbea75f-a642-496c-8d81-729186b205cf@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:07:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
 <anTPOqFKWFKAX_3C@redhat.com>
 <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
 <anxQdlwxAtqfl-N-@redhat.com>
 <cc88ff07-474f-48d6-a2a4-1a2c3f64f3fd@oss.qualcomm.com>
 <anxvMQpZlBUu5SaB@redhat.com>
 <9db3cc07-61e6-4740-823d-112ec80f216b@oss.qualcomm.com>
 <anyCswBYBZWeMt3I@redhat.com>
 <e40e5a75-cb20-4608-b628-f363068a36ba@oss.qualcomm.com>
 <b0930315-f3b6-4fcd-82ca-11028856c343@oss.qualcomm.com>
 <9292ce2a-6493-41f9-85a0-b6d90f1fdab0@linaro.org>
 <7c0f6c44-6f60-4d3b-8d04-cc3e9aadb5f4@oss.qualcomm.com>
 <77f29009-66e3-48a1-8663-bc567ff1c1a8@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <77f29009-66e3-48a1-8663-bc567ff1c1a8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OJaVGVTMeIQ7vSvsT2Kcw9D87UUf07-m
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMSBTYWx0ZWRfX0I9P8bwlvYBh
 OHALtv/rYndN1WeBcuZTzB9fKxRZ9pHYC/oTr1CRufmfigF7swv9vrxOtXgQ4qWptChfPpP+wCw
 +HH1lc6taoTrTzxNify9hzGAyYiIkqY=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a9214b2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AZDx_CGMkRi1S4RTUewA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMSBTYWx0ZWRfX225ciF9fdZNO
 NFfQplhcx0Zl5ipC9Sg0QhCLxg6oU5UtKI5/CKJdePXo/smyAJLb2jxG/HIrxqaVxsa3qO6/iCM
 SkUUxa8Ne5lYo6otqXh3JSqa0uW/qxfq/6RVEl1ZjV3P7pBce1lWeiByiWDCxdJDGBD536y00Bt
 KxwHHeWf+ZhWOM4Y9zv4hkEfLRXsfthYA5UBO9r5E0tDX2iRGX9ou0c+G5yd4zd5sdA1Oazl2zv
 gqAJM+LI9hDSudvBtVF9k1U70aviINjzZIUrrbTAH6AASTLMOg1K/8g+TH2/SUJ/cP033hXCstQ
 W6kvBb/+utcxihwCLjgju/OA9Bd1gSVAqB1kSwgAiXZ5+mwgIW8bWxQfSxvU1W3lfiOT64emnTW
 NrYA9/KaHxVNzWV13pXqrO0gbTGToVczMCXbVeTj3u2njlWmfeqnFgnGUMgcJOkxMcihpe9Yisp
 0lnVFCVLbY0ulUC2xNw==
X-Proofpoint-ORIG-GUID: OJaVGVTMeIQ7vSvsT2Kcw9D87UUf07-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280201
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/26/2026 4:31 PM, Richard Henderson wrote:
> On 8/26/26 16:29, Pierrick Bouvier wrote:
>>> Can we please just have a plain callback?
>> Something like:
>>
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -494,6 +494,7 @@ struct TypeInfo
>>       void (*class_init)(ObjectClass *klass, const void *data);
>>       void (*class_base_init)(ObjectClass *klass, const void *data);
>>       const void *class_data;
>> +    bool (*is_available)(void);
>>       const InterfaceInfo *interfaces;
>>
>> And used as:
>>
>> ...
>> is_available = target_aarch64.
>> ...
>>
>> We would keep the exact same set of types registered than today.
>>
>> Would that work for you Richard?
> 
> Yes, please.
> 
> r~
> 

Please see an implementation of it here:
https://lore.kernel.org/qemu-devel/20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

