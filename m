Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C94606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vv49lqzA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fn+meB9H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU6Bb-0003xx-J4; Thu, 19 Nov 2026 12:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU6BZ-0003xp-LQ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:44:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU6BX-0005eY-7D
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:44:36 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJGrelW1385554
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 17:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dus03X3mtQVokSq5Ud/uqd0xJFDXXu0aosfomDI7Q4M=; b=Vv49lqzA8VHnLxGe
 XDVZBl+uvOXE9XPMzQ4+ox/6mDlM5S4Bmbo+HJIMWRx5dfIUr6QtJ7JK5SuCbAPO
 ciPrcxiF/vx2iyIkMAjBezNy1h9ufREFNqSUomQJmEpGO0snA79L1zH/Bwi6Duog
 2HUeT0w5dZo73ktmvpu1gTTt7cEbY2Vliu7t3aK92//6LnWDLd2n71vRC+i7MCCV
 qGHpwMt4VkGIvYHWThH/7ek1YUluZwZhwGTXjoRZINq3nur3buCa5aORG/wAWCTI
 AjAVnoSSU+I1E4jnwWmxrt9ooYeJqkm3mu/2bC3MSl6jEer6dcPP26lxXk8DVwDx
 SCKqtg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1x70ab9e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 17:44:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso8170785a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 09:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795110270; x=1795715070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dus03X3mtQVokSq5Ud/uqd0xJFDXXu0aosfomDI7Q4M=;
 b=fn+meB9Hq3DZzhDcjSyNJCjmTT5h6Feg4QFUubnTEKbux2RWlZUVuwap3DdedWuFlz
 oGD9F1ZHITxEIS/tUXzxqaKeJC4FItXmLKUwvRHKx1pB/Ag+h7ORqf78kZzUW79wIvh7
 m9Ba3QW0+VcSTluHLJ51YPFrq7Tc/HdVaNA+7eyjxJC+vrGcw6z3zK7VUlHyhjcKegGM
 3n3X8XJ8y9QA4+tMgrFG7zP6Jqad+IXnOalNUUoMALehVYkLpRgi+e4X/iZe6lBSp/QK
 uNxOh4u+dV3x3q54z6zGgGCoWwAIQL4lQm+9hXxZWMHeD49p/a5fOW1vhH27GFsiOmek
 4jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795110270; x=1795715070;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dus03X3mtQVokSq5Ud/uqd0xJFDXXu0aosfomDI7Q4M=;
 b=LhpA5QDWS42mJIjiSxxlV8/k7Knr4QkiNoNcrY0Rogc9mFhO9CuYSh9mN7WCckGN3I
 o+JeVkc3a6p37EoHoMqJPkCnpbN95eWeMYf4490+8oJYlBuNsroRA+go+RODbWgBUbVB
 O8bEgelKFtPnScow+IearGS/QV+m95vDkONaYihwTyrdMynktWrdJUrP9s5q3zkTFGS5
 WSfkdKqyndCeIDH2Y2WB6Y0EvcF3/idGSQblD48oAaVTvuhsKU4veLUby0I21MHDAGcJ
 IXQYNpd950IFAZSuSX9QLTjXZbNqQFW8RBqBOvFsuIwv9cxCAQXuGh0Txe7PVqoBx81c
 pn3g==
X-Forwarded-Encrypted: i=1;
 AL+hErFAORMwb3CTw4RXbs2UATcyTaYH4Tq2wCRvai28Yb9QPTcV3GMTElQs8Zqb8h1RQp9Ech8vrK8BF9eN@nongnu.org
X-Gm-Message-State: APuU4Z870RnPH/ycQ3IuWmjMagCgF7VUd0mbQV6PhKX8McetXkmGo4/L
 hHVW2I04mV/BmVs8ROYS7OKGLN0+01PgQwqbt7qz0q72U9n7C9z1NfELNz48JtYuwqQKRf5BTQn
 hImkclAoMEN0LJu3No+j+26WV+OhfxiKYFyGvlWAALcw/Flg3IaQFRRWmgw==
X-Gm-Gg: AYBFou0HgcUJWlFOJd5Srbtvm8QaCj1oOJOLEpNMPBRR5MQLSF93I/xDRKk0okU0xNM
 MO8IDRf7wTLQbA/438FERyJj6Tydct1L951f0SLPtQVlmO+6oNffT8d+Cd1Ldp+sUWqoCK38QhF
 KKvYotdqkYwQEKBQPcNSxXscuWONvKlN62wSE6Fh0HX2OtvaWglVYuntlZULR4E1Lc3pZ9w5uPW
 5SKmy8GCy3//Yq6bOQtAxkz4tMzxG9PMUWnX8ervjkDQbREZMAeWeSlMrsLe1il0bCcQj3AW9Cj
 OAvWJ6jHP6k6F7LM9uifIk9phRKMEf56VRE/gtKx4iqbukovf2fc48mk7S+iVRm5Q+aFzgPajDv
 NARVhv2XdEWDExVDe/TwKAKE+yLr/cQAJEwfUd4FQG3W8K1OP+DF4PoNMqomu1CO4quxxY+qIEm
 vmfPx+taU=
X-Received: by 2002:a05:620a:8005:b0:949:3066:5569 with SMTP id
 af79cd13be357-949bab2f113mr47096785a.46.1795110270480; 
 Thu, 19 Nov 2026 09:44:30 -0800 (PST)
X-Received: by 2002:a05:620a:8005:b0:949:3066:5569 with SMTP id
 af79cd13be357-949bab2f113mr47092485a.46.1795110269953; 
 Thu, 19 Nov 2026 09:44:29 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84dfe7b1sm50087555e9.1.2026.11.19.09.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 09:44:29 -0800 (PST)
Message-ID: <13edf317-7a3e-4639-92ce-e9dfba3af4fa@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 18:44:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mc146818rtc: Make PF independent of PIE
To: Jason Thorpe <thorpej@me.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org
References: <20210619193849.27889-1-thorpej@me.com>
 <b9e20dbc-fa5f-1e37-ad8a-5d433d77c4b0@redhat.com>
 <00FB4F43-698C-4888-91E7-45FE80CCFC67@me.com>
 <bf3645bf-6a47-75f8-862a-7ea8c467f007@redhat.com>
 <b9960b3a-590b-442f-a95f-e21a24ee00ed@oss.qualcomm.com>
 <7F53EB2A-7E6D-433F-AF66-DE5CE950D0EB@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7F53EB2A-7E6D-433F-AF66-DE5CE950D0EB@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _O9qQQxfxmJBo2OyCpNVOagDTBW1RMae
X-Authority-Analysis: v=2.4 cv=RdgFmFtv c=1 sm=1 tr=0 ts=6aff357f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=MoF8ylqL1P7sxgw2TVcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA3MCBTYWx0ZWRfX4EhfpC4SRgKa
 tBXP1CW8fbSEpUaXmV3umThD/JSXMsPdy2WCyij7fCooQrV/eMd6ioidtlLKSa1b++qBh4pK8VL
 wFJSmsqCgeoOM7Dhf3cr0uptFWH5LDI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA3MCBTYWx0ZWRfX2n+XPa1FdoBS
 aQs63RJlU1GPBw5z7XxFfqsYj5OPmFXw2Hiv7DbOtqnUYQ8fZ7d7p3wC2XMbqIBGTsMXyiIjOgJ
 1SSIrVJB9KCSEAQ7Nip1U+om7ym3iXwk0mmKb8pQY5Agp5Z5DvKZmHsNHECUiPaiYsz01Ftno9r
 RXiB+0+DZqLbwNeIZq1xwevbeO+xCTgjW84tTF6qMMejLBXU/mAoQE7w3GBcANaIcKhLwwpcFzz
 cPHOk1caaFqve9d/XXogT+PRIW3qkdS78Tw3e7ulRuv95VyiRYN7Ne5lzGGEMFNfdgw7Z3tShKV
 eGe3Wy/RRWyPC1rJJa93XIyrU5YT42kFXeB6j0nTqAfvSJ4vAM9sW7OABM0CQPj+BXqhwDDT1ST
 tMSqQukAUEXQgqTaZv0l8e/TkXhpQRFJ5LbicwXGYvORCdCoGlgnzsfVbkzlmeMbLQfbhzf7iCj
 vraTdhYOZ/FCcG8Xmdg==
X-Proofpoint-GUID: _O9qQQxfxmJBo2OyCpNVOagDTBW1RMae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190070
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 5/11/26 15:14, Jason Thorpe wrote:
> 
>> On Nov 5, 2026, at 5:44 AM, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
>>
>> Jason, do you happen to still have your setup to test it?
> 
> 
> I can do so later this week, sure.
ping? :)

