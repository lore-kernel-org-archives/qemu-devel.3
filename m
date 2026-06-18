Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321B8CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waA6B-0005Ni-V4; Thu, 18 Jun 2026 06:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA68-0005NN-9A
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:35:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA66-0008Ci-Sd
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:35:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I9xsaZ1478587
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gREzkpkt3poPsqpBznbWbWToqKXL7IvxmhYHsJxOQOI=; b=LtstRKfg6qr/m3nr
 sMDTTOtjn/5yNtLtmC0N+R2lj5V3dpPv212BnuM79JAWVjys1I6y/icF4RzTY0MJ
 BjYvSntP3lFbYRwgnooloFh6DoOrcOnt42ExCOZDWKkw/B/nwXTkQq2oc32MaJUE
 44zW+uKs/1vtXV/t+uFOlNVYjrps7/f0dj1UMTq+TUQVjRwW3n3bh3smr3nGpKxb
 WrJJK1dxCoygy/RLyDB0R34eTlqHjRU3hES/nwxWFI+NO3ZcmwT3lT01sRS35L7z
 PzlQDID3eh3rRivuqmF9QxWcJY+1xwwo9YYqD6TFKO/qu6M3vlH0kt8iHZZRLuKP
 aydMIQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jv4wx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:35:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9159bc52211so155114785a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781778945; x=1782383745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gREzkpkt3poPsqpBznbWbWToqKXL7IvxmhYHsJxOQOI=;
 b=ENxPiKcnJ7vkODe50T7cID7ky8YXJ6WFjwYl+9w7XKx5joEo6fkA5uyNHpzb4XNQHB
 CZ1XwmHPRKcnkzHwTlQSkZaJTjlBJVhRoHHoigzdEQjfDdQljpAS5U4NcP9MNs2+dNv6
 hiV6m/BE2BzlbXzm8o/BIBUB8X/cn0Tz/c2p7oxdg4bYK8NfXBKSrp9krrjr7qsgAqvM
 kWvJw26D/LwaTSRTAMSXY166KQBUcKTArsYGpLSYDnaOpaipKVgauOOHjaJG8Pms3kyN
 ZqSWlkpRYHs5ulAZ6g7KYdSRCU+arTibWCOgx9gJUPS2gAzxXfGJkHjjKlp2AlqvFUIy
 HrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781778945; x=1782383745;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gREzkpkt3poPsqpBznbWbWToqKXL7IvxmhYHsJxOQOI=;
 b=Es9QpjT/z4RfMTldjZEmVMMxj8ttbyBM6ym9fVa1oork+hdalujX41KrKjGd11YXB4
 6P7YHaix0ngpFdciWh10JCtC2V38Q+T6gFG1KWtH59OFNv4/uSrAQMiw3tNUTB6jxSFw
 iqyGgaaHz0mrIhFGwpoACCslQmnXmMqB37/IwPuqyBo3sGcx2icwgfj4MZip9xPhwA3B
 te1YxkyaEqgO3M6buwLHBSkQNB3LIWmWwLfrxDCw2QBhelzSW5qpZsZNRkTJvbasuOY5
 zt84o/YBPJ1doQ/y4FPW/iHVd21gKQ5kleGGXHB4WkCssLqdFlGJXmP5FFpbvru+GWVO
 CcPw==
X-Gm-Message-State: AOJu0YxPNUIPqLpczS6AaTl3Mrufwj7fQrtahuXcxq4c00OkMDngKUJd
 KjROih0wWbvNI+EmHkA7kiJAPiOmr3N8mRGu9gExdPsVlxbIRB+Cy06uevqFPiAiRaZpMfCT4Oz
 2PJeSkne1WreiUtJnjLx0BqCn6DpujjaWAqzF4K1dl7/UTF1p+qAXrlv5bP1l5rPEMg==
X-Gm-Gg: Acq92OFKoFPchjibiQAYZnAFNzO4Q3p2VPJyrPnOn6In0XEc31DMADqQgHHJDrB9Uo0
 2u3GsfdvH2SbNpW1M52UXenRoe7x+N6z0qMEBtmOSfMKisCeli/BMsw1Jf3qjxCgZLK8ZlmmqjN
 QviNJGuqCGRMm4idvJbwQxmOdnl+h6OplcBjFl/kKizdALybHzvL+ywTFuJiGhAH4ntXH8nydPT
 +hMNG5SqSJQuo3ynZ2mhMC4l9SsPGmMe/KFUNsEZRyiw/StnezmyvuXucNFOiIpHxck1O5GnFhK
 hVyQ5hPWDCuxxd3wj0NOQhjlRHr8xbbSOp3+KpkTFx0xFTpgq9ewsScluIMpWUsNqcgM20u3ue6
 6bkU8m5eCfuq1MjRJLfh8oF1P2SdmLt1MkhDPzUhQGWj8owT9CfdQMDizqQwEtg==
X-Received: by 2002:a05:620a:284f:b0:915:cda5:2807 with SMTP id
 af79cd13be357-91f29924a28mr432950785a.57.1781778944661; 
 Thu, 18 Jun 2026 03:35:44 -0700 (PDT)
X-Received: by 2002:a05:620a:284f:b0:915:cda5:2807 with SMTP id
 af79cd13be357-91f29924a28mr432947485a.57.1781778944234; 
 Thu, 18 Jun 2026 03:35:44 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47ce3sm258535865e9.6.2026.06.18.03.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:35:43 -0700 (PDT)
Message-ID: <99712281-756b-4184-9c90-2e40eb12cfb2@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:35:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] accel/tcg: Extract cpu-loop API out of
 'exec/cpu-common.h'
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfX6B9dm9hC5VB3
 coU2JBO5CGK+CPn0r0+IaAe9R5uVjFLv368jU31+1l1GZ62zzEUpXWR7tmJX/57st4akn+pZVhP
 gQt6aiyCubJq29YYgBkuo42y3ynWffwNYj/AMEDcXi5AZJ6ND2HN1hWMYsiz5tW16gt1tETgOQC
 PZbr+jF5Rk1gMkJaht0i5925H5VkvQ4GOIKjz4G5B7bwlb0aEfnSnpxQ+dO70SWm63TveWovBPg
 N5F59R9jNSJ8s+2KX3kTHx4+nyAEXwRxcAyBlKN1uWgL2fbh5Y2i3iSvq3cMJWUGrn1yUQBM68g
 jPi9sF1XYszV6tfXZL7GnvBMNgliMETfO6+sorUaf3+aCEXm7JR5zump4AL52UooDk8WGWCC4kZ
 J89OqykenNIh6961ssEZBdxoBGWBDTCfMjh3c6DeiuIbrzsq2c4tu0dVideDr/gjsEZ8F0b2cCZ
 qyQyohtckR3F8gtYT4A==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33ca01 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6fTr-v7XiHwcxT5BUucA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: GlHG5vjz1PiYPYWxPEHU5iIxj99h5EJs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfX+Xny4Xqr3THh
 Zuihey9HsPB25/XlFaPVuyae2U5+XA5PO++uQ80r7SeG+KjSsIPwi2oQhFNaaQYPPDLh1rCws7o
 R3svfYwwV/duxYVYeAbYhUS+7F+jzYk=
X-Proofpoint-GUID: GlHG5vjz1PiYPYWxPEHU5iIxj99h5EJs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180098
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

On 17/6/26 19:14, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (11):
>    target/arm: Restrict TCG specific headers
>    hw/s390x/ipl: Remove TCG dependency in handle_diag_308()
>    accel/tcg: Remove cpu_loop_exit() stub
>    accel/tcg: Move cpu_exec() out of 'exec/cpu-common.h'
>    accel/tcg: Move cpu_exec_step_atomic() out of 'exec/cpu-common.h'
>    accel/tcg: Move cpu_unwind_state_data() out of 'exec/cpu-common.h'
>    accel/tcg: Move cpu_restore_state() out of 'exec/cpu-common.h'
>    accel/tcg: Have cpu_loop_exit_requested() take const @cpu argument
>    accel/tcg: Move cpu_loop_exit_requested() out of 'exec/cpu-common.h'
>    accel/tcg: Move cpu_loop_exit_*() out of 'exec/cpu-common.h'
>    accel/tcg: Restrict headers being TCG specific

Queued except #9, thanks.

