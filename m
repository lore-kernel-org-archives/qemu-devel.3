Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88015CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOlH-00086N-Hp; Wed, 07 Oct 2026 06:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOkX-0007oV-2t
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:19:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOkV-0005g4-73
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:19:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jlWr3686121
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gOMsU4qVMOJXitVPgP5knCEUXcopCFq0+HUUlmQbBdk=; b=UExVD8hHWhsdNPvl
 ucF56qbjCkXlzVSE3NmR/F/baUvkhL4+1FMnvBO1fSEMDedp5NOf5xmSX3z5/1a8
 07SJ9MLOwrNd6ic8wn9HeBll/abyEU7wFzVUPStlZGlPpUmjRrmVJmFcpmRRtAqL
 /ejGfIEbjF9PxHF2wXOTKRXEWSPhCEGwJjf3Unr3sjjsE6L0KxKNwU7HTFauZSBG
 C3pef+ZVWP/wNSBKU05YoY1GwCuapSZ0RFrJMBYp2I7FMrvepscqgKBz1rArgXK5
 wcSaKuZuzpoLeBluYlnd+bTeNL2v8JpeVi1noAbn6p6uB4PDfSpdYYL46iUN4Dsy
 ORUpHA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c609n4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:19:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so871626485a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791368385; x=1791973185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gOMsU4qVMOJXitVPgP5knCEUXcopCFq0+HUUlmQbBdk=;
 b=TSkMOEkG4+QVQXJOBehserWG8juYnb5QOqPAvSURJwn4nZ2/q4YHpgnysCMeMyBKgp
 Gra8+jO5GDoTmBUa9mDwHubOAPCWPEKIAfjqPOCaE9HNeBWvYeLLI7AvilujgYeImywI
 0WjkV5NxNMJ0e8+n9JN7xg0O560FmGlEUtJ9X873mtRt7Kk8qkHnUxJzmo1vQn8TCDw7
 c3l4Mlbe9Vy8PdGl1mCK5RW/Bpicq9lYJPqnXzf+SyApsn9e/lLnrt9mhA3n/VpyMwBM
 QdlPxdqCpAP1nPfZk8sHP5OiWIK7clRxGK3LK4xkugJqULfk1vko3b0rzSKxScJvix+G
 l/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368385; x=1791973185;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gOMsU4qVMOJXitVPgP5knCEUXcopCFq0+HUUlmQbBdk=;
 b=D3LizkQ7Y4PeUZGCXjBBZDF3eXaiFV/4Z9zEB7NhcEDedA0Dpk5tgkcRQOA+r8psqB
 /4AcJzPbWPobZV1wQpDX6UGFmvtg9zXMNpbROUP8IGC1Wg7qVq0qD6tD1Tcp8+C1NnNL
 DIhja7tbVQR3YW3Zl8KF6xSyK+z6jmzneNxZd+2JZlpwLH/LMefrtFgxuwHphdQfMcej
 erSQaYbf6+aaeHrxG03feBiiHl7PggXxwNlsB62c/AKjU21MBVXTCgIJFr76HqpoeYn3
 4RYry9+IpeToMo8JQ+PUZBiqXe2ky+RVIoVtYAW+ZcmVwTb8nbNohtgoNUvFePa3OYUs
 OQ2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwp6GeHiKKuUfHZh6UdDs5v3TLu5FoVelhFeEZCsPl1PyoeOc6Pkwqm3fVnE1/o7YauxkLyuufNXXY/@nongnu.org
X-Gm-Message-State: AFuF++kgdP54R0L0AhVsQXMpN+hZnaia1ke6rrYoaCboIxxCwMNT8AYt
 HL9+Gpl5qJ0NEOqMUQ/fA/dh0NaYWSpNfABcPYl6agduvKzE3RXaIoY7K8+c6PQ0Oy4z/tGyuWG
 X8YgkceGahEhwaEl2p3rnCTHVvQS5UW2N53n1U7u8+bbaCa2p1s+1xrct9Q==
X-Gm-Gg: AYBFou24LfJT1Qa3ElGwn3c/Ea8oID12D0KSKA48sEQ8fxTmC1x0+ie3s6Enn2QNGt8
 JvlqT9qoOaEbS7auh54RrT1MGGjovqeoOGxUg5pS2e+l/aV2zVy2G8yL4lNrwpP/VyQ5oGecLhM
 ukl3/bJCQdhutfB6h9B/Me19bC3C3RvxK8/+rF4QpdgA8hTsqUqDYWClmR/tgGf7CSQxC5YfBCL
 NIA3WmxubEUiLCoEmESi8KMSrfEzCPV0D7SDuAw390btUDZvq2BDvnZwP+5LA+bjR2vMvOQo1A3
 CR80YmFH7+3q1iFxvcxPjZY3UeIzGKytbSVCn9hXPJ4r1XVfmbvnrxAsCrqOuxmi1OqoMufrQ3B
 QlSB7J+xow9GE2OJhmjOiwqqyplQNq+C7RQ==
X-Received: by 2002:a05:620a:4113:b0:93c:7955:afd9 with SMTP id
 af79cd13be357-93e9b7f5871mr295023585a.52.1791368384879; 
 Wed, 07 Oct 2026 03:19:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4113:b0:93c:7955:afd9 with SMTP id
 af79cd13be357-93e9b7f5871mr295020085a.52.1791368384343; 
 Wed, 07 Oct 2026 03:19:44 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1787e7792sm133524535e9.0.2026.10.07.03.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:19:43 -0700 (PDT)
Message-ID: <596c47de-255a-4436-8e88-bc44b6dca0c5@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/18] target/riscv: Runtime register MAX and BARE CPUs
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-7-8a2f0f296a7f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-rv-dedup-v2-7-8a2f0f296a7f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WNKR9Yiu1IfXWpvUUv0imtaiJNg9OWql
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX1h1dwMPMulcv
 sKK5upgJdeTQJCl1mL35/w38Kh70sPj/d1kbHrSwbzLjjVZ0+xUqIgrXT/SaEjqgzo5WPrLCZJ/
 DsH9qhGjESzPfQ7kUV5QzdX2iOng0KA=
X-Authority-Analysis: v=2.4 cv=PM+aavqC c=1 sm=1 tr=0 ts=6ac61cc1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: WNKR9Yiu1IfXWpvUUv0imtaiJNg9OWql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX/DhfyqhTju8u
 l8k3PtPXvbCGSHAff42TqD92QBSwwycskEH1kg/pJnSiOJFqsW7atZ9XeTrwFZtX507XEMGfWmh
 uXRN78odK7mJ7oWNlfocVKrUrkM2huyzyAswkPnQ5677hEuAGwNczcXPzZgHoRO9hjVHAHmgu+0
 o5YamiyNKDM2kz/OUis23qn8yssti6iayY5xuKGSfqD+2Yj499UA80iicYQfHd7hK0r65lJ25dN
 5AVgWiljTzH8fHxFnob2dgpqbMIg69O9ENYdRjcw1tU++ej58wkDGdWQFG5SytLFpAwz+kE8Z2t
 MVPolGFpeNJEFz83JP8uyGEj9BRZ/GGiR3doI3ZnnwH3t/kNq+aJYL0FVxk1uJIZAneF3/3oQnD
 mPHaobmypKxphiS0qdjAaQIBHkGWHpsxBO3FriKZb+YJPeAyjcsAscJxIvCE0YbTHr9Rt9yW60M
 rYhKvNMtgySHvfu5NQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070041
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

On 7/10/26 10:43, Anton Johansson wrote:
> Moves MAX and BARE cpus to separate typeinfo tables indexed by
> target_riscv64() during registration, similar to how ARM handles MAX cpu
> types.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.c | 86 ++++++++++++++++++++++++++++++++----------------------
>   1 file changed, 51 insertions(+), 35 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

