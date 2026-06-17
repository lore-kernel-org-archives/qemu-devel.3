Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F026CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZpR4-0005Zf-6H; Wed, 17 Jun 2026 08:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZpR2-0005Ym-EG
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:32:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZpR0-0005gP-Nd
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:32:00 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8UQQv1703248
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AFYfMjwsRokFqUxRgWzBBhSsTEbDjcrHtwfj44iF3oU=; b=oHWwuPT30KQu2Ceo
 BMP0pxNARVtl9ENM24kZwV9Yon4DpRVoXW7w97QppQrVYAQDLuS7jpdXW0IvjZ/z
 7HyoHswZP0icPYLy5LCNxHi9geNcbPVG3AO3YoOXbVUusIH2BfYJ85UqZLdnkLfF
 KcV1m1RmlRXx1G+7nlqef6GIh/q95RnrWU8JqzNnkzYD4um7RrD0qSp8/l8i+Qir
 4XcYoHT4tJYZ9D0N1JaKXTwPw7nnVxbc2Za9Hd1uUWurljv5xtM3E3f1rUhBAUFK
 zBKoikfNyUV8Kjmo7cmrxyxygJK+DwPNPItHLkrVmGREmtqnAkSLTMMOv6cnmS5H
 65ldiw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueet30vc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:31:57 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-966de05134bso114534241.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781699516; x=1782304316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AFYfMjwsRokFqUxRgWzBBhSsTEbDjcrHtwfj44iF3oU=;
 b=JacXpNWxJp3YOc3FpnLDzpal981pzQYGWSz4uTvuuCisyHlNEtJqAifocB+x+ligFH
 rvJSCfW9qBciSaNtPCAyeRLh981D7gSh70KRpfbu6O36L0PXvfqq5Ycq0CpoK/ZA+X3f
 Tgw11xywc9qBZyzlpaYOsPrmjAIDc1BkjenjmvfJjiaekmnSBEUKNRX0UD5vzhXtOJtN
 X4UKAgvTbivadHa7u6R9pGnLRy+KfqWd3FU+xzeM/WJOpR4/lwg0ts3BDYV3IdZqkeEX
 ip8Vrsi94jbHk2s0Bg3tyhLxeZJzx2A8UA/GPRd1JmSLQCFfMS1kCBlUk6PcMO+VvNlc
 NlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781699516; x=1782304316;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AFYfMjwsRokFqUxRgWzBBhSsTEbDjcrHtwfj44iF3oU=;
 b=ZEJ0tT8lumaMZpCuFmZ/kvkGC9W4Np/kDv0BxYPvgKiN7nJw7Gm3comH3d0N2h3wzK
 xEEOkM2PgzGSrgRQKUjWSpdcKgBNVkH0R7x5dBTePMqX0CXwsS+bW4ayuX1wvl3n4uiY
 IBdi+z7glCqnZOvSxuk3LFpyEGY5JLgV8BM9Og+c6M4Su2f4ENIYPc871YtwNB6aexGq
 L1If+oW3cSUUIg46rPEsypa7tf9vKA+SkYLG/AUr6LKr6ais8/47HCbW/2eE496pJGtf
 n1o2ffRsKZcIhAjPZ8e5/Y+9aauv1RYj3JdK7qlIk8CGfeqdw6YfN+rILLyaKgJ75NHZ
 JuBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++rjNfD7i14C85Xmuv+xxrbPA6iPAeKa2cPoC0OslYWt/NExBoPuexDMWNL34cYG8STGXoJ6D6zKl1@nongnu.org
X-Gm-Message-State: AOJu0YydjcBV029tQLmDAV74vC/TE9t/m4EzgM4//DGuXRocX9tt6ylQ
 yRi6qQGap7CQ/w+I58cSROs3ZYn3AxJJtLXy6VU8L+eo7c0bmGgKO5DctAL1+QnqRuImvG5n3sf
 2FtiCxysP/JtcYX1ye9SNCJHWc6oFKymf4clH9CZr+OAFDUfzkVZ+RXMp3WGv5+m/OA==
X-Gm-Gg: AfdE7cmydrLzh9MvagT2Ba/ZKBAOzx4JyWdmCSXwU4woEyAyl/ot4/m/Isz+zrk2aqf
 ccmk7TL+sF8/WHM4NUPnvQDnS13KzFCSJlzTeL3TGOOn+e6tO0yDM9/g3ybm38R9Fg8yc1tT/v+
 gvYl/AWVZzWcsXMoUGgaAZVXhYYCwpmyvIHR3QDUxcmZnX/2PzFx96MnYuHDIKVxUahH6gQobo0
 gw9h0GL0Fzh/D3JfhLOIzInCIKNs3iwfPHuW9f4JO2PQzIcAuRPg3htojuX/Xv6NIcz4LS6A1TJ
 B4hJUKdVvhJuSQFruRM3jjB/8OfnfUV1fKhqNqNlKOXTADJ3KfAMwrvCNjsLl6c5Pi1q6dq3hv9
 sHX8lJk6ZORtRdXNq2Zg6FuF3mDa6E/1rxHKilTgLYhJcB9E=
X-Received: by 2002:a05:6122:320b:b0:5a0:9ad4:7016 with SMTP id
 71dfb90a1353d-5bbc0d20fa8mr1076982e0c.10.1781699516001; 
 Wed, 17 Jun 2026 05:31:56 -0700 (PDT)
X-Received: by 2002:a05:6122:320b:b0:5a0:9ad4:7016 with SMTP id
 71dfb90a1353d-5bbc0d20fa8mr1076913e0c.10.1781699515517; 
 Wed, 17 Jun 2026 05:31:55 -0700 (PDT)
Received: from [192.168.68.103] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f14168f0sm68807586d6.6.2026.06.17.05.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 05:31:55 -0700 (PDT)
Message-ID: <e8371068-7fdb-4a00-b56f-35bd671f0e42@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 09:31:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/functional/riscv64: Use newer kernel for tuxrun
 boot
To: Joel Stanley <joel@jms.id.au>, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260617054034.1020724-1-joel@jms.id.au>
 <20260617054034.1020724-3-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260617054034.1020724-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TPwMAiywfqcUzawOEZH2-5zPgbG8LBwI
X-Authority-Analysis: v=2.4 cv=JufBas4C c=1 sm=1 tr=0 ts=6a3293bd cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=tZD6s3AVAAAA:8 a=EUspDBNiAAAA:8 a=PDEseUOtsgyrhBDX7TgA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=DklORoM8RNzucgFJxVk_:22
X-Proofpoint-ORIG-GUID: TPwMAiywfqcUzawOEZH2-5zPgbG8LBwI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExOSBTYWx0ZWRfXwyqA8aQxlWZL
 +apo1uHGFke0+23Ttg2uCTKNQ96vC9cGNazn5wzj5Pdc+5ru1gF8UCgkaheK6gmxVGAxJvL8ig6
 0YYJyhp2IruVyNxVX8V4wiJgx+G65qnvmIwhAzX1ntNrIBTgKB7oQatzzf4yUiHwk7+5h4/aLq7
 sB8AL+62+l39xHqIyNA0tEqZznlrEJde7bNRc5XgV1/hjRdQo/0Qf/jHvUe/VS/rgtrP7OK3X/j
 PajYdmNKMcrDas2PzKq7349fIaunoP3BSMvRCKZRal+GUEF556yImd/36KQamcMS9ArC6G44f91
 7XbAST77sb6WQt1XwOrP32Rk5qNyqJgI/DLQwVREbocAn24GnpejonHoA/cWXjGL/BmpovlDBhD
 DgbDsDu1NqZgHPDs0jNPHurGwcP/vSxbxX+G9Gducah9x/TmwM4XKB0VBLt/TN7NpuvEsj6y+2X
 MIRGxAFtx9l7AYkj1bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExOSBTYWx0ZWRfX2lllDqRo3NVt
 3XSQKI0by/FP4TxrZKu2y5O1ArAuH5A7xzCqKpN8+I4NykQcUDA3iUXFweVnpTEKoOwF6/1G6ZB
 q2J+xsDzglhaYFS/SLWJpOMrZ4R42A0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170119
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/17/2026 2:39 AM, Joel Stanley wrote:
> The published tuxrun kernel is 6.4 which predates the introduction of
> AIA support in Linux. Update it to a 6.11 kernel, the newest build
> on the tuxrun site.
> 
> Boot times on a laptop are slightly longer but still reasonable:
> 
>                         | v6.4.16 | v6.11.9
>    ---------------------|---------|--------
>     test_riscv64        | 4.82s   | 5.56s
>    ---------------------|---------|--------
>     test_riscv64_maxcpu | 4.94s   | 5.30s
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


And thanks for that PR on that qemu-machine-boot repo I'm using for the riscv-server-ref
too btw!

>   tests/functional/riscv64/test_tuxrun.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
> index 0d8de36204a3..43d1242be52b 100755
> --- a/tests/functional/riscv64/test_tuxrun.py
> +++ b/tests/functional/riscv64/test_tuxrun.py
> @@ -17,8 +17,8 @@
>   class TuxRunRiscV64Test(TuxRunBaselineTest):
>   
>       ASSET_RISCV64_KERNEL = Asset(
> -        'https://storage.tuxboot.com/buildroot/20241119/riscv64/Image',
> -        '2bd8132a3bf21570290042324fff48c987f42f2a00c08de979f43f0662ebadba')
> +        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
> +        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
>       ASSET_RISCV64_ROOTFS = Asset(
>           'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
>           'aa4736a9872651dfc0d95e709465eedf1134fd19d42b8cb305bfd776f9801004')


