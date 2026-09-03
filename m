Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4289DC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x293q-00049f-LS; Thu, 03 Sep 2026 11:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x293l-00045A-UB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:09:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x293f-0005zW-OE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:09:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DAKbZ588264
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 15:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lsjoStyHPuejV7tcNQNa2aR1aFTus6DJYqhh0YJeWNo=; b=JEd18ErtTfu002xM
 N4NgVccgQmLCZPIakjenkm1t6CLkY5GEqM1gvO/PtvoAohtwSD9JCsRuPeHdfxpy
 SwC+r5MXPpOJG+OH7/8UF9IX2tWdWbZkGFrqfY9ghnduXEpRX44eS7FM267ePCSX
 KaYxjPc9GbRhbK3SQaBjgHURvJzq430duQP+HRLQ2Q4l4gRlvhJUymT48Ukp3jte
 i9DKi/WmnE5wFJs9QBOkKbzgYe6kPs5epuOrqKKr6OkCTD2scJYjOL/DAFQYCIzi
 DtnUlvakOEot4IDOl3cIB9u4EtIpMDIGW8v0eiMCAH/uQ0AsKi+eK3yjmDVKgKv2
 tIFx7Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyjj66-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 15:08:54 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-73858d44c8aso586891137.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788448133; x=1789052933; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lsjoStyHPuejV7tcNQNa2aR1aFTus6DJYqhh0YJeWNo=;
 b=JnlDQ22I3clT9CYcIA4zAdITlxMYHo7tennkBCoUVdSuGFFBbszCweZpYRDL4Edo9g
 MvXDCQSNoeS5zIU1SxaBoZw/U7N96oKEaeMKCTZcpWxlyZy4ztcTDGEz3tuCzvFe+Ckm
 pyR/BgBx7gRcWZKeCYirNQqzPhWw8ayLewvBumRxeOScNsOCjcmlJlS8YMqLtZa8IISH
 BjqCf6xu5tnYsz8AKeGMIxAQ+TFSBvgEuhh2eS1Ep6R8C4EfMcL6UMpRr9dHe4kYyBCN
 wZtbMYIweKxph0CvH942Isb4KKLPi5/zib7k6HLCw3Fw65zwASGXn9FGAy2X1maQlR0S
 QwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788448133; x=1789052933;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lsjoStyHPuejV7tcNQNa2aR1aFTus6DJYqhh0YJeWNo=;
 b=sVsLsyR8AlPfWOaqzvCGq3uCA3EVSvweadxhBUH8th7nd4dI5DJ3/GruCDSlvVP6r6
 Dm+UvauOhhfYRwaGPS+xWpDbY9cmLd4kO00wzDTt9yTRbICbqL1En2fY7CBcMCWbo03N
 xUZOR1USYiYFBMSfcXXClSmKZbDeUCVSghF26ELaU/YdpGoPDSgI6jkuO/zSK8qe3WNw
 5cWL9cRz3llMsuPb8wYZQpLwlseXCYMjqpZ4meQ/gVmEH8DjkcGvTSxlw2FTfelKkK1W
 AJOYCobyZ3kelv3PRO+nNPA8ziHjeCoJQsHJXxHLS8J88CoKC6bXB4qa0nXY5/91RmS1
 3t7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByscxFzhtt09Hit6ld4xyvX2YJNxgzgHdBnDBrgjDjhyM94/7PjpnyLVJ5XN+pkZnymfGJOH70Owc4R@nongnu.org
X-Gm-Message-State: AFuF++mgjoc89xmJWRFY4CPTDXl1X1ul7MmgH7Ufk1IuesFe057+JWWo
 94Ub8PVwaTWr0Mk9ZPje/0WwgmG+PLNjnjCHNuR2FMkI6vyd5cKWSMstplxqBfiW1Qd5vbHOn/n
 HoVVNellk5bUCPTMgsnrVtTFb+LiqQqIyaep8j5UK/sbP0sz0S6qyM7/27A==
X-Gm-Gg: AYBFou35NWBvMvS3tcK7L3qfNyZgpW1LMpb9Qrb0DopuC4erRFTEIKu3dpOFp5FeDaF
 +S6wgsFmnFwOdJC2HZ0qbO8mv1y+3lnwdmr7qTgaTESN2qmxYkuysrFv2pCFurDvKBld6X+Cxfk
 gbESRO8iOoZlAQN7AZhH+EsGqqPV9wLlo9q8glIPlcAECJ9tnSKoMkdTdOBscvxwS7wmayjCdEV
 5RiJezNLTBM/kebxJj/0/381zYe/ofIMz2kyLYfOw3sxII0KvnQXHW640GKxOk9YH6lZytJqZiC
 USEQ/Z+LK67Pu6HSJ7aMtJPSwjfneSyZeaZhYr8INcmmlHlvBNkVqWsP662cjnbic/vn4Cb31ds
 dbINFdrmIpU62LFRSHso=
X-Received: by 2002:a05:6102:38c6:b0:785:3211:f5e4 with SMTP id
 ada2fe7eead31-78a1f1c3849mr4721716137.4.1788448132686; 
 Thu, 03 Sep 2026 08:08:52 -0700 (PDT)
X-Received: by 2002:a05:6102:38c6:b0:785:3211:f5e4 with SMTP id
 ada2fe7eead31-78a1f1c3849mr4721336137.4.1788448127353; 
 Thu, 03 Sep 2026 08:08:47 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d9db2sm80855795e9.8.2026.09.03.08.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 08:08:46 -0700 (PDT)
Message-ID: <e87d4602-25d1-4453-a563-30607f50bbef@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 17:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] MAINTAINERS: Add Phytium E2000Q machines
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-34-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260903112532.3276678-34-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEzMiBTYWx0ZWRfX2FGUGulQrqu1
 7VVefYdhsGmvlCJTvr3el9+YQ2993SlJV4z0LjZLIZJr/dUG7Z3o061uAOAyvCask/d2FWBzrbO
 nC5L3SdY4OfgfKndQHxZh4M2V9D1A/e80aGSwbP9RJXUNmZZGXmhkrYus0iEnbKC3FvK1o9P2Gc
 HvdfU3YNgck0xNBIMVnUsrGYMnc4UD3BLxjqcnbFAXlxgH9RU7Xk9kdgngttXjMRN9cYJMPCZPN
 7C4242yw2/lhZtyrvG5pOStuEFWKm1Ct/kpSQBE5Neg5AGmZ2RKhxL5Udp0dAfM/UdExKGOMrKl
 SloA7GGC0OfHiz0yB+HgALoYGjZ6yYQHzYgo6mT3TS/GZHmQQHF++ajjVCMEj9RXbI/xgzcVpjZ
 9x/fQbH72JKo9yQ8kiteHfBI987zefNKKiKWpnc2nGNpQJ+UYm4zCYeYn/6FhmCH+IABGI4MS0Y
 RFQYPJRMB8yqwB4gU2A==
X-Proofpoint-ORIG-GUID: epJnZ4IPbwBzQKPt2wfPY-R0HNkcKN51
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEzMiBTYWx0ZWRfXzUxZppmjelRA
 06adl0W6pB4GsGqiwpi8aN8SxnwjJHhntaThrX3CAK7Ch723hkPP3KSlAVhIEDSuYBTwI+SwA+X
 YL0myiOrlaXB0q+4ZodIFc4OdhNsAUw=
X-Proofpoint-GUID: epJnZ4IPbwBzQKPt2wfPY-R0HNkcKN51
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a998d86 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=YW-np2RzpnBJjfwmyCsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030132
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

On 3/9/26 13:25, Bin Meng wrote:
> The Phytium Pi and E2000Q COMe series adds board and SoC models,
> documentation, and boot tests. Group them under one entry so changes
> reach the machine maintainer and the ARM list.
> 
> Cover the machine, misc, SD wrapper, SSI, documentation, and
> functional test files introduced by the series.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---
> 
>   MAINTAINERS | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

