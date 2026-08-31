Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC43C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16RM-0004jB-Lr; Mon, 31 Aug 2026 14:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16RL-0004j3-NL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:09:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16RI-0003ng-A6
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:09:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFqv4A3524323
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bpLFZGhYdjzrPxC2cz6o9CL2xmG6mRulV6jgcYRL99A=; b=Sci30IOYY0TqKWO4
 ZXIA+Xo8uxo66FUlPP2uwaY8e9T172sSNhzWX2fmf0vnNMa4kcfs54hhcxiFyK8Q
 SZ786NuTKEculivdPvxrigycWj1fwL/ZkaB/qFWSIUhQbjqISV6rqKTk1pNXFIbK
 EJuoVtc4ZHxEVNJvzMagIUBK7Ll1Fwzt2g8LysHv21R4J2m8rm3SGxTSzJEhCBlU
 TGYPQKpVscNxDeD32o8IbNH+zOiNvzGfwlpZidl2izwwpx2WccMq5CJkUO/N2cDZ
 BbmU4HrkjZW+V5No91jLimfh89+jSMR8pm2Xo3zMqRMTlkUF/l/Qo6pw3uKg5sDb
 y79HCA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd556tv48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:08:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso40596a12.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788199737; x=1788804537; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bpLFZGhYdjzrPxC2cz6o9CL2xmG6mRulV6jgcYRL99A=;
 b=MaMQU7PQks+c89YF92iAQTPJoVR6M2gpRasNNjdWQZ405kL9RipKUjH7VaykZPV5f7
 2SoGw3wBz1bRj5K6AHt5IWDnFOkN8YOxTcrJ+D3GGteqmOxEDeAbji8unfra8E88Eg2F
 5L9m8FJSPxHT1Rqgu/6u4BBubbKQQCaVA4UfGASlhlNM69uxfZ3qSD+FcELsXryTH1Bb
 J0Ym8PIke/SzXQLe1PDqg/A6p+WoP0GvQzoH6V9Z7FfLaeqT4L1jb3AOI9UUM+LNWmf2
 DvakI7PNr9tJYUU0on2c8aGLU+IQkifVCqa/I14FxSGrVtAS25zsjx1GCgtis11n/5E8
 stRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199737; x=1788804537;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bpLFZGhYdjzrPxC2cz6o9CL2xmG6mRulV6jgcYRL99A=;
 b=WftoFvlqSBcgDmRzZc9/i6tqZkRUnsS685XU4RTq+MCR4U5USAZQsubzPVoqo3jAxU
 mmeDMo/qr2mQFLHEkV65ZioY+X9sl7/BUcS676CtDInFCtHQ3p/ZoCIvnOGwDJMhzII3
 ZS8H9ZNzuH75NwBv6dW3yPXJD6SUt27zY5vOmauxKd4U1uif8VZNMmRaR95CVGfzjjYS
 35byUiLvZxbWYVh6PPxYxw15xbRP2yTszYZ3C05wE1TIWmY9tIXB4bTzCzYXG2NBH++B
 g2WVV6B/zb4LgluoB9S7wL0jWSgw/qvOIDs8jV5qjuATCRKkz9DD9x/Z5x4R9kVjP09v
 1t3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoedLTCK6Ur8F2CpugjfvvkQO6BBTBSn2KfzLiaO9g7br5DW2qQo0R3hv0JnlvWtyw1rDSJ+BiNEhqr@nongnu.org
X-Gm-Message-State: AFuF++mCckCaKGrF5EUThme3zsQVaV4p4khjtrWqac/1OpUnFwCjLYSh
 1m4B0w+5gEUxoCMi+0/jO4gZDKcGrWseiHynpj72c9YvYhfjOVH8YrI/6AOHr9p1db0vkFafZks
 eENEyg5/4cdVJ4ugxJp0J7mFtbDJZrIBtj8UF8Av3mRU4/0RMs8M086ImMA==
X-Gm-Gg: AR+sD11YVRIrMsDXmvb/Mk5ryng2EBNOAide69haeDgaE5o7Cn5ppcj5jyXhZr8hbHm
 l/Yi+b+sF5lpunEOUwrUva8T7m+nt1l5tXqlw6ewyxrZlURkaSPPe06kGCmPkYBNWzfBBy1tF+j
 S8GzHOYrfFxIeZthvFLTprwZ4yNhZXVpKfNo2QY5RSbykV2VRWR3/4uEefjTv0crIu2avrS5u2Y
 g5LtkPMFVGJUzPQuWdump9V8rcJNQ15AomvvB4b4xiOZ4alwLMgyLkvs8ew+mLaSaIz6yrkRECt
 ekHK6D1UFvXTzrsusHXMPBRJcg6+Lv6gP6WwgdDHGp5r7DwgBsvYxXP/MrojDBSKbGd/DYaCQvh
 d4P8vZ5yBpzd7cdrny4V9WfJZQCp5ax+Z/7NR/BAqO/E1RtdnyC2EsXhSEmva+Wx1A2YU
X-Received: by 2002:a05:6a20:9c87:b0:3d1:60d3:9a10 with SMTP id
 adf61e73a8af0-3d26784f276mr45454829637.5.1788199737214; 
 Mon, 31 Aug 2026 11:08:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:9c87:b0:3d1:60d3:9a10 with SMTP id
 adf61e73a8af0-3d26784f276mr45454764637.5.1788199736708; 
 Mon, 31 Aug 2026 11:08:56 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm23457089eec.4.2026.08.31.11.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:08:56 -0700 (PDT)
Message-ID: <dea08f38-c420-41b1-8919-0b334e8b1ef5@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:08:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/47] target-info: add target_config_dpcd
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-29-pierrick.bouvier@oss.qualcomm.com>
 <38a48f49-d045-4287-9164-5692f4f9598e@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <38a48f49-d045-4287-9164-5692f4f9598e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfXyCPJHyfHk3ru
 Vn4L06GT+R0kpF92D7glTjQn4nYIlDyxAC+DE3IYAr8bXZUmkj1J+MkQst3elEpko4PN3RUqJd0
 oOUh3wGj6Crn3VMkBb6WWJl1S9Sfw2s=
X-Authority-Analysis: v=2.4 cv=O7sJeh9W c=1 sm=1 tr=0 ts=6a95c339 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0tskN80FW_EZqs2YpuAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: wv4AAt0tJtFDr6_R1tUgrZov-vTV3cc1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX5feeri6Rf8r9
 9V7nVyzc5rK3CZ+bU52hB/YYqHqPMYcgj21V5U+psHMVtHh+3hcxaCaxdfHHkvvBfeFMcneA43A
 C/hJ/jGD+Wh3kvEObZE6nP0UaQSRNC2+8+XcBtt1FqLV+N3LW11Gu9meeygdNIRD8hC5z4PJmph
 3rFYY0HKMtNek6esET7GOQhIjgNCsHqlLjSRIHfBev5ATontfxdeSi3xF3HpopRaHaY9HfvDI0/
 ORKC72aKwTzgrZ6OMF9XrHYkmGpQ3xpBIp7OJW4ovA5Cl4a4DFhCbwleqDsaYqXv1Fbe/DP3Hqs
 k/W0mgCS4ABtBtwHip+pKGeeRfWWUzaRy7o28v772c8B+WNBgZ4JzMODx2/e2y8yeicbiqbE034
 mIvgFruO/ejPETAzst9ZF14rv/PR17R6SlyiZKRKCPZoPy6geWMKsabSzQ9aPz9shuj74bOCux6
 /tCBYrvgAm35tXUdbVg==
X-Proofpoint-GUID: wv4AAt0tJtFDr6_R1tUgrZov-vTV3cc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310156
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

On 8/31/2026 12:04 AM, Philippe Mathieu-Daudé wrote:
> On 29/8/26 00:58, Pierrick Bouvier wrote:
> 
> No commit description explaining why we need this change.
> 
> Guessing, XLNX_ZYNQMP_ARM is AARCH64 specific and is the single
> Kconfig selecting DPCD:
> 
>   $ qemu-system-aarch64 -device help|fgrep -i dpcd
>   name "dpcd", bus aux-bus
> 
> We want to keep '-device help' output unchanged, thus we add a
> TargetInfo dpcd field. This however doesn't sound right to handle
> a target device config in a distinct way.
> 
> IIUC the DPCD device is plugged on a AUX bus, but the wiring is
> done explicitly calling aux_map_slave(), meaning so far devices
> can not be plugged from the command line interface (maybe they
> could, but the code required to do that is not in the repository).
> IOW we shouldn't allow TYPE_AUX_BUS children to be user creatable:
> 
> -- >8 --
> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
> index 877f3456062..240447598ad 100644
> --- a/hw/misc/auxbus.c
> +++ b/hw/misc/auxbus.c
> @@ -317,6 +317,7 @@ static void aux_slave_class_init(ObjectClass *klass,
> const void *data)
> 
>      set_bit(DEVICE_CATEGORY_MISC, k->categories);
>      k->bus_type = TYPE_AUX_BUS;
> +    k->user_creatable = false; /* Must be wired calling aux_map_slave() */
>  }
>

I'm fine with this change, but if the approach is "let's find
workarounds for all CONFIG_* to not add them in target-info", I think we
are going to have a hard time dealing with all existing types.

There are simply types that depend on Kconfig whether we like it or not.
For instance, all virtio devices. And a user is free to deactivate them
with a custom Kconfig, so we can't escape the need to represent that per
target.

> ---
> 
> My suggestion is to simply add a previous hunk as a patch before your
> "single-binary: command line reference" patch in this series (can send
> if you want), and not add the TargetInfo::config_dpcd field at all.
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/target-info-impl.h | 2 ++
>>   include/qemu/target-info.h      | 7 +++++++
>>   target-info-def.c               | 3 +++
>>   target-info.c                   | 5 +++++
>>   4 files changed, 17 insertions(+)
>>
>> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-
>> info-impl.h
>> index 4f6c898c707..045799a771a 100644
>> --- a/include/qemu/target-info-impl.h
>> +++ b/include/qemu/target-info-impl.h
>> @@ -31,6 +31,8 @@ typedef struct TargetInfo {
>>       /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
>>       bool page_bits_vary;
>>   +    /* CONFIG_DPCD */
>> +    bool config_dpcd;
>>       /* CONFIG_MULTIPROCESS */
>>       bool config_multiprocess;
>>       /* CONFIG_NITRO */
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index d775c94d1e3..a60751a4ef6 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -42,6 +42,13 @@ const char *target_cpu_type(void);
>>    */
>>   bool target_big_endian(void);
>>   +/**
>> + * target_config_dpcd:
>> + *
>> + * Returns true if target defines CONFIG_DPCD.
>> + */
>> +bool target_config_dpcd(void);
> 


