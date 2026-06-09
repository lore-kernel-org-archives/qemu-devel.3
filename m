Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E86CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWwpZ-0005YP-Cj; Tue, 09 Jun 2026 09:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWwpV-0005Wy-CN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:49:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWwpT-00076X-Ap
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:49:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClKNP652176
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 13:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OyVMWqBWyTRgiSKJaDqqR/zQnl4SfuYqzu7nGN6nFes=; b=p0Vk0JvT8uRxVap5
 sgmNro2qW2tUZ8f2UCUIZLMIk3AoEpqYCzVhib0XJUxXMgfqd836I8gUrgLxe4mj
 qIp5iWRgZoYepqJTEHupXc9WBAblAWpk1ZMKektmdpJcpRYeAFLFW8uUDza9qKeL
 Ozx90IeiOVJBcrL0Tky2EPEimEcqQLK3iq7xnL+Q9uHNtpTIT1Fhq90JU8HFS/EM
 ouyG6OcbWBiG0WFsMUQNzbRZSftbArJXO+jaGx9W4Yy010Es9iQhcsGku23HjkGU
 y6+EpPNC5+IM+fHgfUOQiQR4ECTfjMycujNRwd34IcCZewErRoUvSqB16wa0/etP
 hcQSeA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0ssfrk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 13:49:16 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-963d24c3886so4742825241.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781012955; x=1781617755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OyVMWqBWyTRgiSKJaDqqR/zQnl4SfuYqzu7nGN6nFes=;
 b=Q6sIBJa9ZWneoUsBillP6XlkXwNnIa/HH4S9AWrFoGMUnPIUNf7fW+YBDYghjqH6Cy
 x3+ROTBAra1WGUunmApLe21jhMW0vN3mIEpyPrM4vcv5wwJHM/4/9n2dy4dPuAJ+vrcd
 YyX4/RzeHFJPWTH7yNNFI+A5jtttrpkAwxbWEAqXjyo9JUwftve5wo0VJqvkTUApf5yN
 lA31MdvDXG1P5ilFvE+CNgmXbWLmWq7btgfvPEERpo9uQEezF+54hg3kWwVi/+0aPTPa
 SrEFse/Lvjr8kjeltZYIHslc0c3ai8zEW9BhQ1rzTvIHEqz4TwvBiFEJ486ViNvqv4Hw
 B07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781012955; x=1781617755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OyVMWqBWyTRgiSKJaDqqR/zQnl4SfuYqzu7nGN6nFes=;
 b=KE7+b1pkE1mrY6cjfy+RtbaFqO9UGVLYdHu3eFLLCxxNNFladty4Nn8AHli3ljEXiJ
 O3POX7C/Ge9u9An7H6obKxbHwAgJdrEY2ASB79VOBzIRUZeKpg/s/A253M6NPYj3/8qB
 aW03xNDfVxdVfiPyeREW74feoNJcDq0JsFG/LKRCySjZvbmavJW8uCtlh6K1K8QC5hWw
 Be2xWYz84q7TvFvLg1//V1Dot7Dz4OdSgsg3F42SeMVY3AbpN5MEeuqUeYcT1vc1qLye
 8YfK1ReBriRsGy3bgsc9KFDFQtRT73SXCrNjm0I6RE0EcSn7XnKeDVz7SZPFDc6+WM/o
 uLxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yfBMZi69jhScTSBS7KoO1/gOg2j17roN7vqNfZY1k8jub0pm0qmJv43qhY7oheh3EmSQnWfvkW9Ks@nongnu.org
X-Gm-Message-State: AOJu0YxPMc9Nlh9bWZNBmJExg0NA4Xrddqgs3VOiz+O/UNuv7Ku5OnbK
 k0MnAbGioduw1coJUKNphQX67j5H1293ptZ1fbfciFxfummScy1v2aV7VQVpLMbM8C5zvLwo5rH
 +OkhAxdQdIhU4dSetZBW4cmfLkxGbXrGOQR+4R9K+46lypc930IJbutWoTg==
X-Gm-Gg: Acq92OGVMs+u2yhI/OTljztqk+UFQvcIxMo358t49NpcbsY01ccaeOi6OAPXC+XFWIe
 y7v+rr/fsoD8fwSTNlpQJJC6sAJAZMjWsDfdmSTxhxLeENyF9OBt8PzVPNHYu7jA0UyqfWUT94n
 ffkSfQp8CdXC+3WdrtBFH/iXeVaRRs/bjj9D+Jxdtm+wGpsF1pZNtmN0i45s5IbsClWE+ss6TF3
 DncdLTxOFBSSeC/c6hiA1zuKC8ax5BJE3RzmnoAVl1tpUuZrm8MskypoMTf2bDPIBYYKP+EfBzo
 Lr1JRrkZ4NDWj7E+ArWAw4byMkFY+9zSlVSj3IxUHZrTvgno0oMNmOat1PR9MaHc6HtZ0E7I7FB
 TEoBD/fDdo6u92jADZVRXvTU67KCXVXPNCHQmcElRhTNtu8VA5fw2/9JvUFoZRHJGzKw=
X-Received: by 2002:a05:6102:5490:b0:6d9:a889:13b2 with SMTP id
 ada2fe7eead31-6fefdee84d9mr10599709137.11.1781012955089; 
 Tue, 09 Jun 2026 06:49:15 -0700 (PDT)
X-Received: by 2002:a05:6102:5490:b0:6d9:a889:13b2 with SMTP id
 ada2fe7eead31-6fefdee84d9mr10599657137.11.1781012954672; 
 Tue, 09 Jun 2026 06:49:14 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559eee00sm1061380866b.56.2026.06.09.06.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 06:49:13 -0700 (PDT)
Message-ID: <6df4d29a-6e6c-4b19-ab78-8d9cecce4bda@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 15:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] igvm: replace raw uint32_t with igvm library types
Content-Language: en-US
To: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Oliver Steffen <osteffen@redhat.com>
References: <20260609-igvm_optional-v2-0-b1f1f08dc40e@redhat.com>
 <20260609-igvm_optional-v2-1-b1f1f08dc40e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609-igvm_optional-v2-1-b1f1f08dc40e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzMSBTYWx0ZWRfXxET4OcSIsKUf
 fCCxVymAApmQdOqjZW7Jb4hksVI9sYlmGgR359GX4FrSYk1zrXj9X24brCpZUxa/7HNHaSg18bS
 7/jVTbm2FsEXFaFnDKH5ZlGE01Di74esigjbKif6J5rRMPp263b0aHOmfnxMOO7IEicM1ZIwOp9
 EHIRcr/eJK06T/viqGiD1z8RAt7PhHa3PaPW9afAAx/JeS4UjtwaIAZhSJB4wacsXBxCIadgTZz
 OkLuCfdIUL3RA1VpQ7CnyzqaT//d/LhxTvPtt+90O5LWVaE0OzjSnEhmIJnkBt8mT8OoLUp0wp9
 fAa/UyIrQ1DDWs9//9H73OySzIn55SG6q3qbIrGkY6XDok3z9wBbi+Ki8M78eduusmj7+yVGag5
 ZS/21gIWrqoBGp3IyDXPuPynDzos4cJPT/oqBe6qGrNAGeEoxuP1095/OyTF2Es00weyOj5dV85
 TwHq45fWNtMqRajmXlA==
X-Proofpoint-ORIG-GUID: WFUGB3vlTbTGaQFLmA-cy9IN4gj9NpuH
X-Proofpoint-GUID: WFUGB3vlTbTGaQFLmA-cy9IN4gj9NpuH
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a2819dc cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090131
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 9/6/26 14:29, Luigi Leonardi wrote:
> Use IgvmVariableHeaderType and IgvmHeaderSection in QIGVMHandler and
> qigvm_handler() instead of plain uint32_t, so that each field's purpose
> is clear from its type.
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>   backends/igvm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

