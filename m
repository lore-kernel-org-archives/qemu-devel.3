Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4B5FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICL1-0004D9-0Q; Wed, 29 Apr 2026 17:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wICKz-0004Cy-2G
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:20:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wICKx-0006Gg-Ba
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:20:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKcAMA434942
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AynJS2IH1WyMJCeH8HtGYJj4pYV8nGvw1bKO/hjD+kM=; b=n5ET9Ekea9WVlhMN
 Y5ldBqwBpVswCX7Mwq79e6MXTcquB8oKiDByQ+uZewhChZi3vLNgVryrf78sg5SO
 ch736k5N2Q37mECyvlNKNkJfvqlJnHZUTrvOeCz1XA2TAVTOvAMA1xfSGiIidxXF
 nveNiBa9kpW0RtHlmTF4NXa3WvfLmapcvRvUb08+0iiWlP+4f4WhSTVulUhQ4Z3T
 RgRiXZEfH+415z5E90wvb5sucJ1wSXq/oUfPpl308Kp2SpXmLzewWgEb0YJqnEoL
 pDdRUq6wfSGMBuUyvebV0ErtH/BPq/EHqrG/2+cPHCaDMF4VuX9SDopNN/brGKUe
 gI+kLw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxcmf9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:20:49 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12dbf4f678eso1167998c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777497648; x=1778102448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AynJS2IH1WyMJCeH8HtGYJj4pYV8nGvw1bKO/hjD+kM=;
 b=PuPwp7etOAHjPQhPYqmTj7usai4urpqIjLUfGYjckFGdA8n4FclQLClKaj/OXSJ8d2
 qgoemOOTODpOzRk1MgCCi/+7PLvMuL5UKIsAYSsPMXFGjcAWtCGoO80uHLd4ONwWP2DZ
 mm9v9jVw3I54mqqVFa6oBR6cBmjlPur7iATC8z+PBp2IWK5njTGrWyEj0gv1BLIidsgz
 IM/AzsgaZ0eQ/UmLwYiyzejNB/oOt0z0+pIDSyNjLD24hSXuPGsYTuSKMDW5ZvtuM0aD
 MYFjjsHX88R2mGUOTyntcZWXynrGxyJgKHH1vsRGgVyGMd8NHX7QrIHJ4B0p0u39/TKa
 Rhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777497648; x=1778102448;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AynJS2IH1WyMJCeH8HtGYJj4pYV8nGvw1bKO/hjD+kM=;
 b=rk5kb6XwL0kd6e7Hz+GvRtjLnNLY9jzJHgWkVI2PCs0SBPyU7Jm/4BAetohhI/fSEV
 Arwx1W3zAZquz9wsfMmI3szTCtwXRZiSRLUAeOx1MFsDrxTvH8mUazVib5KbszWgFm/b
 jHb1HJ+FYjOwGpINNByZ3EBfcfJZmi8gqsEEi9gpXjBzRrhj9Q6mKnvT+wk/mQZEkTaw
 gEKyQCloGjg066Ga4U34loI1p8taaFJDbqzwQ/7vtuyv/kEoQA4xKycFQCk1XvQwaevh
 Qs1in7Dv1rjRZU4og89IwAASGEs2h9CNvEIzsYAiRan0XwyYPCO4qcl8oZm+lybWIeVv
 nBvA==
X-Gm-Message-State: AOJu0YyO06EEjE5Cjk1N2DGYFBc4l1q2XcQbRVnUk41pCgWoTQys2px7
 KTKnoP/Fxy6rGPSEkptBlqy/MYzI+nHV0buxtP9q2Suti5MgD7D4fRn+HA9Mj1JjOfDK3FN2F2p
 Uei3yqysLq0J/1bP2Zan8lOfYexvwoMBuLDnKj9TsZ8GRbY/3GTl5yxPTDA==
X-Gm-Gg: AeBDiesjVV9TsDnzFBtmMm3lrVgZr2GDk6Fjp5qzUGYnzF3/vMpYyJj8O2kZDIEVpUM
 Kdq2aA5fs16GZAGIGSdP5KtVr9s+BYTpZEoeoGVec0gjNzcVMzAfJ2AYx4mqdkxNK9lBguK+sBX
 eN2H675VpK09dtY+A/2NmO5NbXChylLi+rj7immLvv18sJuTAgm8n+szJ1CMZS6orlHWX3mqpcm
 a+UqbSYv6u99d6D42zjkSuhpVN346zbZLKkIRgiYunvgaca4ftTnYn8nAeaI2FzqWiW37r7zGdY
 fC49prAizQ5YPQwPMCO+B9karH9RsogABV2iDImhi5lCQrdhBVVivRM4Spjs9dpmeuCw+02cxIv
 qs6G5a5oPGxnQ/I41rURRQliRY6Kj0pYtJxfRnK/hXy3BgER3z8E3C/L6frCaXXcA5PjHXbgIiK
 YkHQmDSANx71IMsMpnmb0AYjv1
X-Received: by 2002:a05:7022:22b:b0:123:348d:8576 with SMTP id
 a92af1059eb24-12deafea074mr92281c88.6.1777497648420; 
 Wed, 29 Apr 2026 14:20:48 -0700 (PDT)
X-Received: by 2002:a05:7022:22b:b0:123:348d:8576 with SMTP id
 a92af1059eb24-12deafea074mr92260c88.6.1777497647825; 
 Wed, 29 Apr 2026 14:20:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de320f2a7sm5032596c88.1.2026.04.29.14.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 14:20:47 -0700 (PDT)
Message-ID: <cc173243-9916-41cd-89e4-7aa24748faed@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 14:20:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] qom/object: add object_class_get_list_by_name_prefix
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-5-pierrick.bouvier@oss.qualcomm.com>
 <177745176385.2166241.2869123011864084966.b4-review@b4>
 <afHF1nf_FaBAt6mr@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <afHF1nf_FaBAt6mr@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VAbgl_1vfMDlRDebdNKZ60z-zHH-R4Ot
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f27631 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=WQXpK0Xw84kWOnOWfEsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIxNSBTYWx0ZWRfX/9Rx9vFoGfA5
 KaZVBna+mJhjeKV8kocFYfqRNbDXCQFxHNn/LiOPyPJtNDYcWoqjtCX6x7+S/hOz7k8N54Mhbc6
 r/zIpqiwSCv0g3ZQCBr2HK99+S2UBYINBwt8A5NU+lcqhrD/wfQzj4NwjcRfilJXigLCniTTGJb
 c5RJlfYWPeW4jRNKEBvqFVYb83Bcl7mWBfbgfbxUYRhJZzFWbWqmCMr93oHZ3KCj21UrX8lxtYG
 Nma8oSwGo3mlPtJt7IDh6LF5MYAUohXE1ky8LAZ2b/Tjz3BFvFiZe4kQt7orcqSRl30VrbX7/5L
 yzGZXl+d/XgmC0z4uACrvUTKNA6V4yyKeEs3NSzY2RgP37zH6gSoF8V5UmLpVLDbfjnvT7Evfrh
 mw3NChE51T1xRjumYXHJhTjht6DsRSaxkIBZQvuNK0SFvuE+BXCaTiOc6smYkEilTqU+kiv7JZl
 QEEH3neUrVZUI1/j8nw==
X-Proofpoint-ORIG-GUID: VAbgl_1vfMDlRDebdNKZ60z-zHH-R4Ot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290215
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

On 4/29/2026 1:48 AM, Daniel P. Berrangé wrote:
> On Wed, Apr 29, 2026 at 12:36:03PM +0400, marcandre.lureau@redhat.com wrote:
>> On Tue, 28 Apr 2026 16:45:17 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>>> diff --git a/include/qom/object.h b/include/qom/object.h
>>> index 510885218ba..a6d7b3874a7 100644
>>> --- a/include/qom/object.h
>>> +++ b/include/qom/object.h
>>> @@ -1033,6 +1033,19 @@ GSList *object_class_get_list(const char *implements_type,
>>>  GSList *object_class_get_list_sorted(const char *implements_type,
>>>                                bool include_abstract);
>>>  
>>> +/**
>>> + * object_class_get_list:
>>
>> Should be "object_class_get_list_by_name_prefix:".
>>
>>> + * @name_prefix: Name prefix for type to filter for.
>>> + * @include_abstract: Whether to include abstract classes.
>>> + *
>>> + * To the opposite of object_class_get_list, only matching types are
>>
>> Suggest "Unlike object_class_get_list,"
>>
>>>
>>> diff --git a/qom/object.c b/qom/object.c
>>> index f981e270440..14527108a2e 100644
>>> --- a/qom/object.c
>>> +++ b/qom/object.c
>>> @@ -1062,6 +1062,30 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
>>>      data->fn(k, data->opaque);
>>>  }
>>>  
>>> +static void object_class_foreach_match_name_prefix(gpointer key, gpointer value,
>>> +                                                   gpointer opaque)
>>> +{
>>> +    OCFData *data = opaque;
>>> +    TypeImpl *type = value;
>>> +    ObjectClass *k;
>>> +
>>> +    const char *name_prefix = data->implements_type;
>>
>> Perhaps the "implements_type" field should be renamed.
>>
>>> [ ... skip 11 lines ... ]
>>> +    }
>>> +
>>> +    data->fn(k, data->opaque);
>>> +}
>>> +
>>>  void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
>>
>> I wonder if we introduce MODULE_INIT_TARGET_INFO, is this all needed?
>> since only TargetInfo types would be registered..
> 
> Yeah, i feel like this patch should be redundant if we provide  a
> separate initializer for early types to get registered.
>

You're both right, this patch is not necessary anymore.
Since only target-info QOM types are registered after this step, we can
safely call object_class_get_list.

> Daniel
> 

Regards,
Pierrick

