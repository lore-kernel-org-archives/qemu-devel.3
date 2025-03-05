Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FB0C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 20:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpv6s-0001gV-TO; Wed, 05 Mar 2025 15:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpv6q-0001gB-Q0
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 15:12:52 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpv6o-0004vc-IX
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 15:12:52 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525ArRhu007314
 for <qemu-devel@nongnu.org>; Wed, 5 Mar 2025 20:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IpUxJHAJr2roQuTrd60+KXVzrMyTapOyM1x2zaDunmo=; b=J9fU0LVcO7LIvty1
 uCnN7hH+iR1ba3FVym4pg6fTDng21Zbeg+xpLtnhw6yhlgWlpvTgEbYcShaUuvB3
 gSd2NaUTu17dCG6b19YljGla1TsAmVwJs7uPZdzwe9gM55+cH5y3ZpBse/9M8/vI
 R4e5yG0b4/zZJazWFkZ27I8Q6hV8QK+BGRrXwVZmzoXNMdsYctftXuHptCWpEGrT
 tZ7J/eiV4/xHJgRybiHVFU/qu1mBErGHaHtCbCUxTDBQmSDY/BFzJBrX1QRKswe8
 kGzjVT6xNliyPSfnEi3Lpxl7g/PlATh4w0YHzLHiPJitgVwz3MYbSaeQ6+anFyMT
 hsPr5Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6upkps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 20:12:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e8ccd73acaso123257986d6.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 12:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741205566; x=1741810366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IpUxJHAJr2roQuTrd60+KXVzrMyTapOyM1x2zaDunmo=;
 b=nJIiUAHoFj4zphwIRGAiu/08DdrNCR8eaDXUnb4IvOHm6VfeDpeG+0XVjqhT4levgy
 RMmxbh47aGeroLlVbWL17Fp0Itqtd/KBYLlrEtb1Oq0dQRwJHkvF3jinp92IrzOs07As
 tJ42L7nZNrvZITcFRZwTsokmUgDbRJ8Nc4MVNY7xELk/TeT6pb7Tt4env4jY3LkYY32k
 ZOHnginSYrhhEImzZdeNxqFAjWh+EFHNPrqAvRmrxSrBVjbMF42+8JlbrThvjxZVVVry
 LSh9cPfPwIcj1j1jDgQrCNsrTXJ8G/o8VreOBxRGMKkQup4p+1MKg3DzmjiRqvU5dKdA
 IKoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfCuLQoe7f3baBUMTZiW0fMBhw4DJI+2BgYxUCnc9/d8UM7O12HfohlhVJyEGw6SiJ2rJKeelnfef9@nongnu.org
X-Gm-Message-State: AOJu0YzpC0RTgKZ6bTjBIixBLW4+Jel3Y81eMsBLpYohs1NWnWT7MlLT
 k+OpF1LpFxRHVLmRv49z4L2R4c35LbJ2D+CltPgMit1zl7fNnc3/rH3f2EMen+YcplLc/PVUfHO
 K7C+2vxscc4vLALweDRNlyevu9Cjgg/+bCQNbpQyI5zgiPm8ClEpcgg==
X-Gm-Gg: ASbGncvRmqw4B/fZ0TT235KmhOBdT1X/KT/9sKEodisXfHSskN8sodrI26o4jG2HCKg
 vLkaKYGYcoaE9nHSs2aq5ZJ+lKG506ZvPYzdYPxJu1qcLBpqMIAYL6tdarX879yZYMpEuxEKrjc
 lpyFRRAuL2gaMOqurN5pjWwUDn5TC2awNJlQUMRFFXPeyTV3iIJzfIqSlq28KQvuu7DbHYDQlwa
 gK3BExqDs0lRror4MuntqJLfoF+7bpZW0kT96O+pIR10y40Cx6VKKvyBjJKChYZDbAaJw8UlNFy
 E4jtDB/TEoJn/W9BRyz9QNw+kKAej9r9NWRb0nSMmFgUYL0iAxAhtAV0s5YTlRgTdX970kE9Gg=
 =
X-Received: by 2002:a05:6214:f26:b0:6e6:9c39:ae4b with SMTP id
 6a1803df08f44-6e8e6d33c1cmr67555386d6.42.1741205566526; 
 Wed, 05 Mar 2025 12:12:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjUmklVS2PKo6rflL9x/fvwWmNBodqty6YKVa52MLBdTqqz4VRrGBifjAQDdRwZdMVwqGEfw==
X-Received: by 2002:a05:6214:f26:b0:6e6:9c39:ae4b with SMTP id
 6a1803df08f44-6e8e6d33c1cmr67554996d6.42.1741205566146; 
 Wed, 05 Mar 2025 12:12:46 -0800 (PST)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e897634c48sm83291836d6.6.2025.03.05.12.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 12:12:45 -0800 (PST)
Message-ID: <bf301657-eea6-4f3d-b64f-6a36c5375ec7@oss.qualcomm.com>
Date: Wed, 5 Mar 2025 14:12:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/38] docs/system: Add hexagon CPU emulation
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-3-brian.cain@oss.qualcomm.com>
 <01aa01db8e05$d5abd330$81037990$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <01aa01db8e05$d5abd330$81037990$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SvIErEALC6AIbCBTL6C-8INaZz0F3jxp
X-Authority-Analysis: v=2.4 cv=H40hw/Yi c=1 sm=1 tr=0 ts=67c8b03f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=ID6ng7r3AAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=P4ePCzKHb6K1PAnQc3sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=AkheI1RvQwOzcTXhi5f4:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SvIErEALC6AIbCBTL6C-8INaZz0F3jxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050154
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/5/2025 1:36 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 02/38] docs/system: Add hexagon CPU emulation
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   docs/system/hexagon/emulation.rst | 16 ++++++++++++++++
>>   docs/system/target-hexagon.rst    |  1 +
>>   2 files changed, 17 insertions(+)
>>   create mode 100644 docs/system/hexagon/emulation.rst
> Add to MAINTAINERS?


I will fix this.


>> diff --git a/docs/system/hexagon/emulation.rst
>> b/docs/system/hexagon/emulation.rst
>> new file mode 100644
>> index 0000000000..03a6092a12
>> --- /dev/null
>> +++ b/docs/system/hexagon/emulation.rst
>> @@ -0,0 +1,16 @@
>> +.. _Hexagon Emulation:
>> +
>> +Hexagon CPU architecture support
>> +================================
>> +
>> +QEMU's TCG emulation includes support for v65, v66, v67, v68, v69, v71,
>> v73.
>> +It also has support for the following architecture extensions:
>> +
>> +- HVX (Hexagon Vector eXtensions)
>> +
>> +For information on the specifics of the HVX extension, please refer to
>> +the `Qualcomm Hexagon V69 HVX Programmer's Reference Manual
>> +<https://docs.qualcomm.com/bundle/publicresource/80-N2040-
>> 49_REV_AA_Qualcomm_Hexagon_V69_HVX_ProgrammerS_Reference_Ma
>> nual.pdf>`_.
> The target/hexagon/README file gives a link to the v73 version of the HVX PRM.  These should be consistent.


The V79 PRM is newer -- I can update this to point to V79 and delete the 
one from the README, would that be acceptable?


> It would also be good to mention the README file in one of the files in docs as well as mentioning these files in the README.  Or is there a standard way the community handles this sort of thing?


docs/system/hexagon/ is intended for public consumption by users (for 
example, at https://www.qemu.org/docs/master/ IIUC).  IMO the README 
reference (whose audience is QEMU developers) is not suitable there.  
However, I could make a reference from docs/devel/hexagon-sys.rst to the 
target/hexagon/README - sound good?


>
> Otherwise
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>

