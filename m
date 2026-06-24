Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB2ECDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 21:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcV3y-0001yf-0k; Wed, 24 Jun 2026 17:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcV3w-0001yG-97
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 17:23:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcV3u-0006OJ-M6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 17:23:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OJj1QH3754182
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 21:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZXwK9O66w60JCuAFOojGCj+5+pZoODHDMXTyfNck9/8=; b=NSxITkL0VTZCxeJ0
 w612n3FyyG+OXWS2lc/kQecxL1s8l1ZqbzLMUenF3epb8c6pKccjq4xu8S3mvjwz
 4hkkuEytXNGvYkn3ulLwJoxTd05RE81padFuiF+pj2dp4bUG6TkqrIsbxqO7Gl8p
 RtCXhroIDZfMRXBm9YVy9QwPBaEZne8FpxcOIdc/jPwX9I/+CISxHdKy/JFZLoWO
 2DhZy5QG6OLwaW+qr8gK5WngU5Kc/0n/1blljGnIvahzyg7BIRMsA8OBXN6qmanH
 n5SztzZFVdCO0FG2Ws6cje5DLvPxjmhdglyb1QJPbznxKxeJX2I2o1NaVR1Kpx62
 5jxcRw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05bfcb3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 21:23:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91931144870so277395985a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782336187; x=1782940987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZXwK9O66w60JCuAFOojGCj+5+pZoODHDMXTyfNck9/8=;
 b=co5fS5XkmZY14h08m8shsLoZ2pXqTZA3tTwqYh9G4q2Zf0qEe/0ScNAtu+iNmRTIp5
 44yQp+ecZZrOXpySl76/xm3baAUi6l6Zi2VSkmrTNWrC1bK44nDrF05NpXm4qb/vTdMF
 hNcmLz2f4cuYUwPugRn+5yOA9kNhjrkA1MkC2TJqYQfaUd3or/SRu59Jx5QQtOqt67vp
 2wvyvhv9pawdfdPBaNSsmWG9gpSJzH+I3F/y3xhVoZn2LgWa75NXTAaQ2uG9RnZpbqpo
 cKnCXj0DWuGk2SvEF24EbsJDq1E/FwIynfdxmp3JqXfQ4xBKT3/U+izlSmu9Lqbuhm3m
 1Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782336187; x=1782940987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXwK9O66w60JCuAFOojGCj+5+pZoODHDMXTyfNck9/8=;
 b=fSkriB05LypNY8gLn5tQEa7wzZuUH2ZIqeM/90EGdRzB/DTDlXN195j24fBMxfSOLv
 dxKBwGJWXq8ipBDLVdmlndv1c/0SInGCdSKkUuTBahgteg1SZGXuL7po+YEzcF4+Ka/i
 9X1QugN8lpPwJFe/xQHLfF8XuA7K7hC5xJBB6Ih6Y0PU3kxBSiLWxUDPCq78sHMkc3DM
 mdS5VhcaMsYNVwlwoJR5glXib5pZ9wC1DfwNLQzgvm76OZnkxkvE1MuA4/nPIMFbXqeA
 d48CHg+8TiW//2XakdcPf81kUNFmtcEp0v27gtSOeryMcKBDfUhgjWbTMx2qvTNBJzxB
 7gyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ++WtD9m5VpKvtjm5MdQ93cK5auvuEvDbFdQ7v9NrTAJsopkcByczW9AivMzMFek2wVEto8BPeGdl3Q@nongnu.org
X-Gm-Message-State: AOJu0YwbVCkOBYO9RCvwThUhXvFMKQzSRAviHqbykC3zT1zpE4L1wVwW
 1/jerqhbcik8ksF35Jc+4SE/I8zKRmNe37aeRsVZnV8vHWFvY/RFHBEay9BV9spOMENuksOUDCc
 xfxmPu6hkfIk6KFAi+RpQhclIQLxzwCBl4pyZlJmYFGRMPXXuvOD8UKrQQQ==
X-Gm-Gg: AfdE7cm3evzJBwyh3MHlWyiQZNvVjgWm5iZsgcS+kA7oJVvuMV7W7z7UaLzkwrliVZD
 rx8aF2G/kk40kWcSoIltXBP4/RZ+GHcbPnRq/TPwb7Ok4SGuSjkLFZAGQre3UqsLW9+rtmYQA3G
 oBNofw5zT3OyPzFmkY9g9lqGmh3WjHx72XWlRx6fgll0Qh9ORsMC6fiTLNLmlNfPOb9eub8VAIa
 e6b4LENQFmIZCgqbtruaM9MiFmgvATWWGm7w184qNwdM1qL+VxlJ+e7afNPUBI5YmZiEOuEQLiO
 Q0oVM99rOhb2TxIP6Z3r6rgLxl2N8UH7i6pxUocjqk8QaP+s+PaJF2iyPkcDBCxp7wMIrmofcI5
 Ikh2cVAFXUUzgkdH48S1bKTBS0mVGyGpYgULYpNWYLWPS72tFDFjw93rvvHMTkA==
X-Received: by 2002:a05:620a:1a28:b0:915:c4de:7ac2 with SMTP id
 af79cd13be357-92646678987mr1467850485a.30.1782336186652; 
 Wed, 24 Jun 2026 14:23:06 -0700 (PDT)
X-Received: by 2002:a05:620a:1a28:b0:915:c4de:7ac2 with SMTP id
 af79cd13be357-92646678987mr1467843485a.30.1782336185989; 
 Wed, 24 Jun 2026 14:23:05 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01d51sm8350817f8f.15.2026.06.24.14.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 14:23:05 -0700 (PDT)
Message-ID: <e095935c-ab2f-404e-889b-c2b96aaf6e4c@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 23:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] amd_iommu: Decode XT interrupt control register
 without bitfields
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, sarunkod@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org
References: <20260624195925.1254462-1-alejandro.j.jimenez@oracle.com>
 <20260624195925.1254462-3-alejandro.j.jimenez@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260624195925.1254462-3-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X8Bi7mTe c=1 sm=1 tr=0 ts=6a3c4abb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Xz7ZqOEmHuaKqGuKPTU-VqAatjLuvXvY
X-Proofpoint-ORIG-GUID: Xz7ZqOEmHuaKqGuKPTU-VqAatjLuvXvY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE3OSBTYWx0ZWRfXxgw1skWeKABU
 YMMRuIOuPBzwtJFnsf80a9ZK9OBCCfSzd1OKSHot+R8+sbFmk6ZuY9mgyiKpo/INibOiEXSQqZ4
 9r+jYvLIQvBgAPmPKFW8fcLyUVYeWT0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE3OSBTYWx0ZWRfXyVcLk0NplTvX
 7BDDiPhODbs946j4dzlkEJQ0K3YXa4K2O+J2LKNqH/TNopu9nVU0CUBZynYxzKSmw5sQDBouGl+
 /ImRJeHYLe5WtwfgvV83kLUvx9YBTqH3pemmyIlzW8s417bBrMA154PeZgqGIgWGgyQnaiojIlA
 dsoRqgSmcnRadyJ120ixJwhusymckhqZ+YmCp163v2bLkvS1F0jL/N3MAXC6IH/1fTP557qEI1H
 UtYSzdt7zzcAMi5croNLqLzQLdZzoMTfzACu7mqSZDq7TBYHbj8HaJzy5xX2VGPZ4SenfpyNSyV
 7N4usVU/C+3XP6wsazD7jtkYQo6K71Z0rvtTlMvBCwVeMQpmc5iquKQCev6WP0pLO9nAUoJtzr0
 Qu375SxRq5ZWfAQXLjk3oRmGe9tMVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240179
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 24/6/26 21:59, Alejandro Jimenez wrote:
> The XT IOMMU General Interrupt Control Register is a guest-visible MMIO
> register. Decoding it with bitfields depends on host bitfield layout and is
> not portable to big-endian hosts.
> 
> Fix this by removing union mmio_xt_intr and explicitly extracting fields
> with FIELD_EX64() from the full register value returned by amdvi_readq(),
> which has already been converted to host endianness.
> 
> Using a designated initializer for X86IOMMUIrq also ensures fields not
> provided by the XT register (e.g. msi_addr_last_bits) are initialized before
> x86_iommu_irq_to_msi_message() uses them.
> 
> CID: 1660056
> Fixes: cf0210df65aa ("amd_iommu: Generate XT interrupts when xt support is enabled")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 28 ++++++++++++++++++----------
>   hw/i386/amd_iommu.h | 14 --------------
>   2 files changed, 18 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

