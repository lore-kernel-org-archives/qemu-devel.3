Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D91C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2QsF-0000hm-Pf; Fri, 04 Sep 2026 06:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2QsE-0000hN-Hj
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:10:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2QsC-0008KM-Jm
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:10:17 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6847mmJZ2838724
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 10:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B5hezHvA3eSG9S4U9gaP1yT1D3oR0ZwE7D4B+PrZh7o=; b=pkfin7e4HcIii8hD
 GynQ7HYdx0IXWiIEtt2H/SQYfuVq7j01W35b05qccshjGfSzluU7XZMgGGJmSynV
 VkX7y8V23NqXwRThu+rfSHIk2dG0306UAdQ2M1pzmU1sxLC4rJWcUozmvD4Nf78P
 D2ouwlc8ut++zoVingLQfS8iJcC6+Ze+xrzo3+iTsYhynapdbCixhbvKSIRGHAiY
 WsSvtqpE3M+VtucT+XDzo+/0K2Da8igTEAH9CXC1VFGj55az5vSQq+fSNpfUSO3c
 oJpQANY4tZtvl+11cgYfGzBRq4mRbg1z24A7TDI9VbABj1E0hhGhZyDVdbkZdVSK
 T8Forg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtrwgc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 10:10:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939665a1ae6so209883385a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788516614; x=1789121414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B5hezHvA3eSG9S4U9gaP1yT1D3oR0ZwE7D4B+PrZh7o=;
 b=XL6iaXBKXbC+oVTG9sV2MNvHKmRnRsyMh79LXaZ3TtULZ9WrEDpxqE4v+aAEG9Q3rE
 g6f4dfsH3T2CZTu9+5KYwJ+spM2w/P8p7VvRZiyDzxRo5jdz7ddbAMRxz691pXRSnVHL
 JKv0HnhmsnrG/17SnTxKU1KPu+PCKXDtfflZUmVVqT1Rx4HWy0dfiHKl6cOebgrIi5eB
 +6atKS+YtzMcuqpQnIvmEVpM91D34LAEUoEYyNs8I+cb2sSoNNQHXQnfrzwPznMNCQcf
 YYquc6bBdjFQ7pZWWH/q/w/zIQ5PG1jHpNw0tgR/8cI4zlFXj1XzcVt01Rj13c+Dx7Tg
 IyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788516614; x=1789121414;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B5hezHvA3eSG9S4U9gaP1yT1D3oR0ZwE7D4B+PrZh7o=;
 b=T8YGnNdRngD5JuSjcmTz+nbO5hoKnfkqza9N36Ut8SG6SavWfomb4o/Km0KH8ND8It
 nP4Z8I0odvN0RrKTXvsIkCmtqqipgorOdfzVK9dKP+DhTsFTLhS8chKoyJ8AVvtkDORc
 EBdmgs5IZtSIp77ExNGTdxUCmHR1K75dx0z111k4G3cILfXnqseEJHqyGQuD/sQWtWTt
 CE644llgu8BUAltJUHbBeyuHZuxUUUqm8PDDh7ytxX/5FUOlCRFjjklanRtSF0RodPRZ
 PqsTCcOWX2cCG+/dI5fkEMy2SQApwcCPypwwzQT4daXc2meaBPEk2bAzCNNV26bUShFO
 66Ow==
X-Forwarded-Encrypted: i=1;
 AKwUvByVRv/IUQhcmQkGCxWmRcKbTpS74m3Q4hAlwKNCSzO+7Bu7jGS228m3zw1msVYGFbpoGv8+Sv1x8iCV@nongnu.org
X-Gm-Message-State: AFuF++kOUWl7smdriq3GjhnxDrB3t86g6duvvPIyN3EjiP7Km862KgWY
 ItNiLStlRVDooZ6etCv6UcuDATxx2FWvH/UT4QDbIJVINv2eNWmv2QWg/bJL1FnX0Df2XK4XvdC
 e2d2o5gcrWq/1338VrqgZaCCWhEh3FDY8Ubfygob5chfhJznfS1XWHxtdRA==
X-Gm-Gg: AYBFou05zkfHyv0ar9awTTRHbCovaqTfWz5UV5m8SzI0D8BE6rnBwE9iDvyteTQs0NZ
 InLnegOB6dYZ0GkB9ZpFDK88oBLlbGXk3zR4/+l6kJLSofFaGbRgyzvmJRXxYs9veH+N4Rou/f4
 IwI7HUJIDFUmV18lk76eHoBV/EudMuMp8sX3/hA5Lb7Y+F3xzs2/fHcte9lFBwy9tcxtL0Eirf6
 gNUs5PZaWdAmTKuIdH1Wlabltw1UQpCaiui3+uQqjSSUueASH7oBW1jL6/QXZHrmCEwYDeJG4ka
 gAfa0VaxxHDlP2x5NJCUWIJSdLx6qykLnp67YW4AA1bYh2F89rc7OqDMNnjiHuZPwqhtHlOQqXJ
 XhMDL/LlZ6AKRWt45+BpoTqN3VsF3BXOYRA==
X-Received: by 2002:a05:620a:8083:b0:932:df7e:b31d with SMTP id
 af79cd13be357-9398034162amr490891385a.12.1788516613657; 
 Fri, 04 Sep 2026 03:10:13 -0700 (PDT)
X-Received: by 2002:a05:620a:8083:b0:932:df7e:b31d with SMTP id
 af79cd13be357-9398034162amr490886885a.12.1788516613195; 
 Fri, 04 Sep 2026 03:10:13 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c81c3sm5021959f8f.26.2026.09.04.03.10.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 03:10:12 -0700 (PDT)
Message-ID: <5f89dc8e-daf5-47c4-a6eb-5e7ea5c1f921@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 12:10:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] accel/tcg: Make halt-to-exec transition explicit
 and remove cpu_exec_halt
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <11dc8cc9-cab2-47c2-ad5e-a63e293e0a43@oss.qualcomm.com>
 <c574454e-f379-4182-bb0b-58868c39c5d0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c574454e-f379-4182-bb0b-58868c39c5d0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9a9906 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BE-vnXYMyMfpYUc7XY0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: KrV4EmZ6HkC70dT2Pl9AIydOjO3pd8hM
X-Proofpoint-GUID: KrV4EmZ6HkC70dT2Pl9AIydOjO3pd8hM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5MSBTYWx0ZWRfX7lw95dix4B4C
 hnEcuXeRZoUkURqEXDz1ZFlAulsMnengyEJ5YecFv5CGx1JGB/TWJbuan0QBxLZ2o44Ea5JTqx5
 QiFN2F/SdK5/p6XzeqpTwoQ+IGBXmWg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5MSBTYWx0ZWRfX1fTnNeQL0uGg
 TPgFgqeB2AlWzPROUn7Stjb9TFb2J42XlAZECdLUd1t/jj/C7CB1Ut1D8P9juPUi0cZbotX0/Vc
 CVNaZtNlN6GUtruVYa1p5un5f6rcm/UQnuDjr+GmHIIGckWi01ob/XI7IT85Y50IpSAX0FqCmF6
 pxzK7/YTDH7sJd4oa84Ws/n9oGJYOKNxOEg9ujm8ELFubc8yqD5fgoaI/hIAyQhbxErvh5bqcFu
 SRJFx31AfLN3bV+elm4W9KvJZCZGWTu0503hrEBuBKok/GPhcv9mCT110pCJzU1NaAwQQMhYVtO
 X59WbQ9JzOnerIOf9bT9P3srp6FMtI/0xFZZwIMk7OfcowSNYi/sDxiKRaHipcB4djIWg3c44ci
 oaAQmozvDZ/yXBNiKCF1WnvpCczbhgLUPGhxuBWx1sErRPACJd8L6l4PP9JWpyabVndDrykYauX
 uMRqynPljugv0eQ+Lpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040091
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/9/26 11:53, Paolo Bonzini wrote:
> On 9/3/26 11:56, Philippe Mathieu-Daudé wrote:
>> On 19/8/26 16:56, Philippe Mathieu-DaudÃ© wrote:
>>
>>> Philippe Mathieu-Daudé (11):
>>>    accel/tcg: Rename for exception codes named @ret as @excp
>>>    accel/tcg: Restrict EXCP_HALTED handling to system emulation
>>>    accel/tcg: Check %halted field in cpu_handle_halt() caller
>> Queueing uncontroversial first 3 patches (reviewed).
> No objections other than bikeshedding names:
> 
> - process_async_events -> poll_during_halt
> 
> - transition_halt_to_exec -> leaving_halt

Thanks, if Mark is satisfied with these, I'll respin.

However the main issue is the one raised by Peter here:
https://lore.kernel.org/qemu-devel/7766d96b-4065-4917-9d7d-094bd6d1f29c@oss.qualcomm.com/
Could you have a look?

