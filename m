Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472A606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VRipQ7VH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uts6nYAf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNRv2-0001Mn-FM; Sun, 01 Nov 2026 04:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRuy-0001KV-Tl
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:32:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRuv-0005fE-95
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:32:00 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18KcQw1321344
 for <qemu-devel@nongnu.org>; Sun, 1 Nov 2026 09:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oOZtN8Fil/MjYVttleWqP99VP18KjK7FwDMixfhgVFg=; b=VRipQ7VHvPIjPH2C
 O+bcbpF/1Lqc02byAzbpl+mEoqNxyvqDYWe2pdg87Wuhic3H+PUhnAvIqmofeIEN
 2mOO8CA9gxHhalglySGE3vWdQx9W4Io1500IU5LfFInV0zhqSs+HNrjo4Cgydb40
 mUlvqldaBLomRxtfUDgIx0zUA5BdGqZqwrwuy3PdyXAiefY6optGKGHhiecftLjH
 YNV+QL8jPXxxW5d4G9A4+rfBUv1hItnEXDXoC/ko+MWB1dpo5eLea4LUCXZQ1qiF
 4qxUFQFjX4acTX0UyP2oSzpSgwI1A7ilikyy9vRDtZh4CRxbbtQbGYwNNhLGC1fh
 AvRw8w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn61fucf1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 09:31:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844e383so339336185a.1
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 01:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793525515; x=1794130315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oOZtN8Fil/MjYVttleWqP99VP18KjK7FwDMixfhgVFg=;
 b=Uts6nYAfcuXN171P8R2VpKGa+WgfryaMNyOhzJ/dM4IOqpqE8eh4a9bcBtKfHQCp0Y
 J4uL4ATa8v6uMJIIhIaf5dN6/DluQRqK0oOWHC2oLMbvw+ZQGm04E1/Dix7LVobq6T4x
 YQ8CWlHAMvd13aN9/fVi7XFHHm2kQghQ0OsUkoTJ4nMxONF4QlEx+MH4ka8S2RBnGPRf
 sTjRJPNTCMojP7b6UkwYCTYwxRDXBzhGbUHullCmnUSGP5GYsu0WFCeDIG3VgIFFv+ii
 uAq85Jjp7r9Ys3HZwlwWT+BkQNXUd3Xq7uuSbUSbiWvnmeZxZmK0/vuIbT7VJjn3bVod
 8oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793525515; x=1794130315;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oOZtN8Fil/MjYVttleWqP99VP18KjK7FwDMixfhgVFg=;
 b=WHHiYwQhKqK4Zas6Yy0IDowDz9OBT7yLJHkSjJzgMxY5nGdwT/iiyJdEcFeZsQKYyt
 D/gAMl5sUMkjpxzHE9/ORsC4bD455ng1GhgHs/46B4Yie2TW1LUgg8y6sK1Ee2t6ljgi
 9sI5QIYNN0ezJGpnc01eUP11OkJyzU/51yJKx/QJ24WDMlPuZJF5Ju5pwAZS1SZsoDgr
 xWK332OOPxd8+j/PSghT/iYuwTqhT6OsC5XVw7S/pCjuAhyz3NUDB7i/TWxGmJk0ZO4l
 3fpChf1hR3/qXqJOsMVjd/z39FJaIhWvH4i7ZK1FOvo0Hs7ZznhzU9yDy0LLFy7bCTKH
 PQAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzksZOk7OquERb7LJDcKLTzZBdWPvXlfeN8/6A3DCROoNq2ofyn1YbYT9pGFH5VNoXm7IwgVOm+xSGL@nongnu.org
X-Gm-Message-State: AFq9FYLBtWTfyGhoZIGOCHh4dh9bBEK9Y8F+orCU+nkB8o1GmuFk9oZP
 xz7HiIzdt/mIol/gaTQSwZmGI2RCYK6ZB+O9e8bh0YWPYRjvwAq+RlR9O4uEzg6nEeKsxU6Lemi
 bQv5K6mg+kC72s37/P+I5jbB0yioiOTzClcnt6jQf8dE+y6a+/CQCnFZyyg==
X-Gm-Gg: AYBFou3y3NVg6pd+96nFfSNkdFv5Xuaq4cNyovCZEFt1haQmaxmJafaBfCTDkWWbC1+
 zQCa0ds8vWXv57PFNxP1LPOJPTL+NNGTODx2jON1aUFRuZmo7EeKXV7tp/goacK/FS1mNPRgOdb
 siX8ZbBYVxwwZkCd2eVGWo002nbf19qfsWYMPCOEtjwpn6wtqps1QBbMqAiXdCvFfFVWhPCjJmf
 v0v2cleIZdOXGfshhjb8tCA86PnBfSrMTxSd0w9TazZ8tlsIEBk38dH5Du8r3baRbjzFbKIV0DF
 2+htHskdVtZ+JHUvuSNovDUB/gh8H6WJsvzFKrS+lObNDzJUnxIinSXr0i7OouJTAg9jgZdw6iX
 NW86+r/rxEadeL3uVt45HbDuX99bOxl6wy0yAB8HdQx4eaptOXP3KEXVWmWRXJWoX7nCR7u0lgp
 SMxaJN12CI
X-Received: by 2002:a05:620a:2696:b0:93f:216f:f404 with SMTP id
 af79cd13be357-944216bdeb4mr1151768285a.40.1793525514689; 
 Sun, 01 Nov 2026 01:31:54 -0800 (PST)
X-Received: by 2002:a05:620a:2696:b0:93f:216f:f404 with SMTP id
 af79cd13be357-944216bdeb4mr1151766485a.40.1793525514237; 
 Sun, 01 Nov 2026 01:31:54 -0800 (PST)
Received: from [192.168.68.102] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca8088581sm62156386d6.44.2026.11.01.01.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 01:31:53 -0800 (PST)
Message-ID: <7a8671e3-add6-4fa7-8e1e-3b94071d4677@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 06:31:50 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/27] hw/riscv: sifive_u: Correct the L2LIM maximum
 mapped size
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org
References: <20261014012323.322790-1-bin.meng@processmission.com>
 <20261014012323.322790-7-bin.meng@processmission.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014012323.322790-7-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfX4b/Irrm/tHn5
 B8GybQp6aqjsC3Z2xvlZmdB1ys6gEqnV9PLer2o3USuTor+AVw1/qbBxqKAKBW4FBNrTywyChee
 xVsRG1qHVtiLv6PuoO/rPKSb+hieB/s=
X-Authority-Analysis: v=2.4 cv=V/LoQuni c=1 sm=1 tr=0 ts=6ae7070b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=FRSEYCzRAAAA:8 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8 a=RANoeU_kD-jqrAgHIL0A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: Ee9MsXy3BrJ6GpIetBGxo1BuvHceB4fQ
X-Proofpoint-ORIG-GUID: Ee9MsXy3BrJ6GpIetBGxo1BuvHceB4fQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfXx67+irfhfnHq
 BHKABvzz/rkDLHhvOuOo2PT/cgXP7WGEs9kmxVgXfd+D/7Wa8LU1ARfmLWBsXDzxeyodEDL5EVi
 0tqobCKGWqzxmLAb+dCJBGCTbsWiqqe4pw9MMRGLLb/j0+Ns6imUg8FlfFed4CuBhcq2ywaAzQr
 nlZO78pf0qa61KYalCn6LVJ2AsD/Wv08z/bp3W1KfCdCceS/4TJj2b2rj4WUsKbHIrD3HcvMt7/
 35j8LTa+DSXX02HGF46hEKB7QRHxCdIfm2KgIwUukOO7EUFsfpjkEKgR+CvarhIZGlvRhjqA7cn
 l23RcU6qZW8fcfYg7Hd7gfqexdPZbJGAhk6Vyg71TrgNdnJmNg9D7Zc4gFEFai6IQ5oEQzizVzl
 sJpCGs6qEa/13Bn3O6NrmuY5KlaaM/oOFshGBzJSSGNII9VaEJBUh1T6L14ccpfiTEBaLr4aiZs
 ydySkdmXNz2QT2aS0tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010037
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/13/2026 10:22 PM, Bin Meng wrote:
> FU540 SoC has a 2MiB L2 cache, so the maximum mapped size of
> L2LIM should be set to 2MiB too.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> 
> (no changes since v3)
> 
> Changes in v3:
> - New
> 
>   hw/riscv/sifive_u.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index b7d5e7b4da..1ac0d1bbd9 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -72,7 +72,7 @@ static const MemMapEntry sifive_u_memmap[] = {
>       [SIFIVE_U_DEV_CLINT] =    {  0x2000000,    0x10000 },
>       [SIFIVE_U_DEV_L2CC] =     {  0x2010000,     0x1000 },
>       [SIFIVE_U_DEV_PDMA] =     {  0x3000000,   0x100000 },
> -    [SIFIVE_U_DEV_L2LIM] =    {  0x8000000,  0x2000000 },
> +    [SIFIVE_U_DEV_L2LIM] =    {  0x8000000,   0x200000 },
>       [SIFIVE_U_DEV_PLIC] =     {  0xc000000,  0x4000000 },
>       [SIFIVE_U_DEV_PRCI] =     { 0x10000000,     0x1000 },
>       [SIFIVE_U_DEV_UART0] =    { 0x10010000,     0x1000 },


