Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49A3C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegpk-0006hA-9d; Tue, 30 Jun 2026 18:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegpi-0006gs-I9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:21:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegpg-0004AV-VB
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:21:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDrQj2838645
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yYM8sVunaks5J22fH16IPWBd0e3lt8Yf6kqzD0dnXmo=; b=IZmv1oY4I4rByyg/
 naB6hqPMC/6/sjuJtuFrzq9WosnwiJMVBQ3pHiHcO1V7Z7Plm5h+TyQHgXzUwDkm
 0ZZniFROGJX0rMMOOJbGxFtBCXkxa3fo2iDL1xXo62cyBMfViJT7QtbsC2XnUIKp
 HZ/3bulZKkpNieXkrJyP3Qt7yWpWvOwjhD9mroCK5/DaMNsFdyfo1OlLOtTp2oZ9
 Mj7ORhdGSANKxYiZRQTZoFCM9dvWjH058+QIO9gY9pNT5qh0WtsYL8ZpxGYo0/Nv
 FNS76xs+O0c77otGFky5TlNzLD+S+B4nJX3rr6VULiDXbr51wBwayVzdP9VLjjyy
 LHWQOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hbd1h95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:21:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92da6f3cc81so370785a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782858091; x=1783462891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yYM8sVunaks5J22fH16IPWBd0e3lt8Yf6kqzD0dnXmo=;
 b=i9Lr31gmLmXoyZmj8z3dZAidVaccwQDr7sym6se1u1LaBOq6yQxTD/3NqI8je3GWul
 J7P58j48e1veblzisj4TsBCag1GDIWoPQDqkUB5lRC0PIZkBAsoSZI0cfgHikhpAg5Wc
 P8n2pPJpNEtCj8CRvFW0Xc82yGrItCPHnq74s47A7BCP4vns2xaGb5GRE0jM20u1vFaQ
 E21GvLDzcfLN5vme+h8bVsov3RpX4usWo2PSrXHXYD7YOctmF2My0sHuRI4H4q4FJH4Z
 Nq4Vlo950ohEIfbs0nFfDZ2HvFq67MAC+Jb7asLsIwyT/mQi6ZffXiuH09RvdpHMShuQ
 2CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782858091; x=1783462891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yYM8sVunaks5J22fH16IPWBd0e3lt8Yf6kqzD0dnXmo=;
 b=ogEDqsfSDElorj/Cn+VhwAucyx0i9frznwDQs9Ps5dNkTAF15h4wGu52+HSkvEDE58
 GcaUQDM8V8inPODyWvrmU22dUUgyUjJW7nNvPfbZtzZ6XdDN/yuHRfH4ghdUNB5et2SA
 /uAlW+Ig4TRO+w4wo2ul8C3XOLFow3CkB5/qZXdTESzSoXao0yIrnrMHacyEKyX7bKjK
 c4vzy4zRLSsH+/wy85qEZNWXHeAYwzAzNOaahX7VkL+wHOgziiVE57ekBkn2IiBNGuhY
 PKZoWRGqozhFD8H/TCAKneDpMvLi4LbM+7QKBQbV23e2bxrqtj3skk6IrjlQjKo0Y2NQ
 piKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9I+E8f5qE5QxtMwbLOzLA67pCAuAlxdNM3TLTGZ7yoNPig7Cgsp31Ay/B4RbVEiMsFGmGuD6Yfw5iu@nongnu.org
X-Gm-Message-State: AOJu0YzoRw+cNfA7klyw58Q5R5z1kldf9pofSkCjsjOEPbvNsFrIJa/x
 GAueitxOCYo3AlDY4b4tO3O5f+NktnW2eeSQM7u8wxNr28qk4YGNDbBpWWFgchxPKJbLK+WXZH5
 fO4YyL5BnoFdOXYQU7LzAjgGjKVNl+kQQkyHNmA7Txpj0xE/zqtw9sTZvWQ==
X-Gm-Gg: AfdE7cl7OjLUTGp17vMtKKSyrgCUDhsmPa6/utKMNN2KqhKRaraFBJbKq5jD754X5F/
 XUgkHV2BZmgNp0O623z9wSY7YeimEQ/KZwp1zntd8LHkxPWi2IDHaM1OZ4mE9pbRFexV00IhQIq
 CmnklIFrH7N/X10sqXftbr6n762qZF7D4X4x1orL1dXrJSutE7k32S/SIiPGBXHKaU0EPbmGV0H
 LlMcKELh/RoS307eH0pbHGcKBhGa3Bt+SnM0S+4IFCuyqVQvu1qBXLu4ZKgSr3jqBo7j5rjLVya
 feI1MJNFh7N9PAW9cgbJrPShPVggBr5L4qr1t6a+UuEJ6j72xJlGFp8ydBufMSOuioadfqewE22
 2jnAmfdNWyXmoUf5jMQJ4BvKWx9eNMxkx0RscGXy3ROonH39O/CYab+1Wrm52tQ==
X-Received: by 2002:a05:620a:370b:b0:929:b3a4:9bf4 with SMTP id
 af79cd13be357-92e624e5a3bmr881411585a.21.1782858090552; 
 Tue, 30 Jun 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:620a:370b:b0:929:b3a4:9bf4 with SMTP id
 af79cd13be357-92e624e5a3bmr881408785a.21.1782858090182; 
 Tue, 30 Jun 2026 15:21:30 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef11338sm15467195e9.1.2026.06.30.15.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 15:21:29 -0700 (PDT)
Message-ID: <8fc62470-8988-462c-a065-ad4e2fa3b9a6@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] amd_iommu: Fix endianness handling for command buffer
 entries
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, imammedo@redhat.com,
 peter.maydell@linaro.org
References: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
 <20260630220806.1758748-6-alejandro.j.jimenez@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630220806.1758748-6-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNyBTYWx0ZWRfX6Mf8ZOg9CjHi
 1FUioE9KzSNiZbzeBR/+EQBtihhdzTDm/i76NVtMZ/mh4gB/RHuW/UipPlq7xnfmyZPIx8u1uD5
 ZA9Z1ekfuYfkRUHd1SeSRo0LIz22cLk=
X-Authority-Analysis: v=2.4 cv=MpJiLWae c=1 sm=1 tr=0 ts=6a44416b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8OIx0Vj1NTrbCKkW4tMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Z1PIJsl9o8KnjtX1QO2kcJ3wMiKxOeHn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNyBTYWx0ZWRfX0Zttfb5+qrfX
 OnXszEaY9G35e/KnLnHAjNKCdokjJmM1sCSKhRRLW6piHY1bVgi7bdyaMmFNwLR3chv7UN3jIFe
 26LBXR0CCwW5Ne50PQLqEiixsMCCKXdjWNTNE+1iwF5vuZ2NhfckIbUa+A9UUyqX2oEZ/xFdvX0
 xkIHklTX7Yd5O+OimgOpgu3V/ofJ6XNhg8e+KmSutDP5omtWMbFUODA1LqFnxx859QTwcF3ddDx
 lQFLmaoOP0DIvFi1ZmChuTEekDGR4dXr+K9gGl7Uu+mSXDX+Vvw43dWBRmrbnBuUPz5dEZIGU7k
 vh5wCrdlYuEVW5SIObexP+uavle7R5YwcX3aXjaIHh6uoCDLQqt5tUNnrzgspyB1DWtHAjl49ic
 EYA8VqwhzvRaobkNKJg2iErSAE8FnEM6Lzal1acO4hqy6HLEkSi8x0VBaYMShn4ogqZsRbSZ1M/
 Ez++NTKmSiTD/TpMXaw==
X-Proofpoint-GUID: Z1PIJsl9o8KnjtX1QO2kcJ3wMiKxOeHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300217
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

On 1/7/26 00:08, Alejandro Jimenez wrote:
> AMD IOMMU command buffer entries are stored in guest memory in little-endian
> format. Convert command buffer with le64_to_cpu() after dma_memory_read(),
> so that command handlers can all operate using host native endianness.
> 
> Remove the cpu_to_le*() conversions from command handlers, since the values
> are used internally by device emulation and do not need translation.
> Conversion is only necessary when reading or writing to guest memory e.g.
> writing completion-wait data and event log entries.
> 
> The flow for command buffer handling is:
> 
> - Retrieve command buffer (cmd[]) from guest memory (via dma_memory_read())
> - Convert command buffer to host endianness (via le64_to_cpu())
> - All handlers decode fields from cmd[] in host-endian format
> - All emulation code uses decoded values in host-endian format
> - Use cpu_to_le*() when writing back data to guest memory
> 
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/amd_iommu.c | 39 +++++++++++++++++++++++++++++----------
>   1 file changed, 29 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

