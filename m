Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B97606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fql30wke;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NUhHzU2O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXYk-0005CX-AW; Mon, 09 Nov 2026 17:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXYZ-0005BK-Of
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:09:40 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXYY-0001QK-3E
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:09:39 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LA2CZ2029792
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 22:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0N6txGuoCy050LjwKuyYPj6KbLN4zM7FrAU+ARIjgnk=; b=fql30wkeierMAq2O
 0FsTKZM5VG+/aT+DdZVn31gU5LVQ4FlHTcdJID+85gTByyTt1MaX5wdXLzFttyMo
 jt21hhBRNskDUth/QBPvk221lyCdIucD7JV2AE08a5yztzvnIljOQUIa2Fv7CEza
 P6eGjxnkXMkmGJoyZuT6Kji2OxKJEpizKyfSEnhE2A/Ho5YATXzPBkECJZZHQl1w
 8pVrsszVBPmSCOqr1LnP9zEjIguqucGogTdTcXiuwbSpLEPV00x242ltqKag7ORQ
 tI6pA8eQowfln7w24uEmnkg6YJj/WztQsofkMip9OcbtcrI/FLGb2ezTyP/9FiY/
 Tlf2Rg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx81pvt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 22:09:36 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d2d60a8bf5so257834137.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794262175; x=1794866975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0N6txGuoCy050LjwKuyYPj6KbLN4zM7FrAU+ARIjgnk=;
 b=NUhHzU2OU0ka9dyy26a84m6Vn2mnaRBmvNxrzT6tzcLgrvrWPCRTxmG6BO+y0o2JN5
 L6gl2vmfvgbHOFUkmUjMR2XlnrsMjGvUhizigmZu1L3+a80/t7YPIfUpdhrh4a7ANajj
 adM9EixLB6xj7pdRcBHc4eMG+W6Cn6DjnMGRsReFMDtX8fLb+7+KrWZU8T+MkNTF/leM
 xangyMF309FpmhosmJcu5o7XklCVlwgfxQhYkjE4To+GEL/uwo3zZxO1tiyJMcDrUuTU
 C/I44MFXMIVUgggMTmKhj48i6jkH0VG6Y+0KCJ4+WuJqjBe7MXPiiKAw3jQU34xbLfen
 eI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794262175; x=1794866975;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0N6txGuoCy050LjwKuyYPj6KbLN4zM7FrAU+ARIjgnk=;
 b=zYQJQkbG9QE4vvrDNmHfKKoyhJOs6ETk93GRq6wCPrgQD3LBpY4PQ8qJRafPxrTdIi
 HPCBGzaoSJe5l2YNbCT3U4jE2NaNSI/8c6QR8A5dWgd0jKJ2OxfQUKcjiQgcgqY4Ypec
 f05Xi72wcA+M3SZlEVJyz0XD4Vok9gXZCUWx2SZdQ6zakXg0iCXEYfnr64bAowhllsw4
 SENynheZiu7mJGdE6kK5nHtP9/5XZ/RsmYA3boJ50hXzoC1guro0EuwmAZgeBttql3Pz
 D2AmVBxFO0wH7aL6jKvzXg1MbWUWU/6G0l62FsQfqJ557mAZF/ikQdima9IInf5iXM2f
 bfAQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHh8ZydN21hWNL2p4nTPw2xsu4mLDacf2tETwSOyPpixjv9SQ5hBNdiuIU5zMwxVcJ4sNQjx7TU7MjR@nongnu.org
X-Gm-Message-State: APuU4Z+IzjKKXXp0BLgtz7XvvS5SYTMlyzd7RAPLUsmtGOcqeOcEyD10
 DhVp68cWA8v7aMihDkqHtuC3eg8Sd0gZIb52r/HCSTSIzZxtWvuApB6tHtutOQRcTlgpzpGBByv
 3SjWJTmcaEYzNE4nefWra++ATg675XZP7bAEUVaGJMN68wpw0Qlms1avX3A==
X-Gm-Gg: AYBFou3UEKIrGoHDGgunltQENEVyvi8OIsC986CJUizkbdqS/TSwgVCcZ0k9Fwk8C5b
 O6P5+TfUABCIwr7uAw8F6T7rVSAqlVC1rsWSVBG7DFzMvucBtczuPdSAygO+4NTi7Ns3dxVLVNG
 p+nmA9GS5T9SZ11yYRYZqRwpw5CBkIH8ZMzejyHx6iZYpAwWEmOS8SPvxKOA2dIgbfG+wtEUiFb
 JbQv/5S3IP3AzywWERCyYrHNagiRFFUb71P4AEGaUPqZ2G3JfWpkipfh6tO9CGWFvz1OYcCrv9z
 0dX0WXpVbbUvDibfKsG9LPktM5w4FLGx/7Z7spiP1R4mJNX7/ovoPE1IvRFNVdmNCvY08dyoG8m
 JTvL6g7VlqDp9v0PGRYWqzT5KYOsoS8jnQtdUTIhLGx8WUAtlrj1SjyUYVnb/g7UXVRrXEuzA83
 DPzuvHWg==
X-Received: by 2002:a05:6102:3f8f:b0:7a8:2a34:432e with SMTP id
 ada2fe7eead31-7d301b8d8a1mr245858137.9.1794262174968; 
 Mon, 09 Nov 2026 14:09:34 -0800 (PST)
X-Received: by 2002:a05:6102:3f8f:b0:7a8:2a34:432e with SMTP id
 ada2fe7eead31-7d301b8d8a1mr245849137.9.1794262174497; 
 Mon, 09 Nov 2026 14:09:34 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0233f95dsm9597055e9.1.2026.11.09.14.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 14:09:32 -0800 (PST)
Message-ID: <c43c435f-66b7-4a93-9b01-19ed22920869@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 23:09:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use gen_goto_tb() for vsetivli exits
Content-Language: en-US
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20261104-research-vsetivli-direct-chain-20261103-v1-1-ace12cf5280a@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261104-research-vsetivli-direct-chain-20261103-v1-1-ace12cf5280a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af244a0 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jJNwmlt5YcoxQ9T_qy4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: bDnSIy6SGhwD4OVVAguQws-9eMCTJDgn
X-Proofpoint-ORIG-GUID: bDnSIy6SGhwD4OVVAguQws-9eMCTJDgn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4OCBTYWx0ZWRfX89OT9MuEIguo
 0Ary7pihOlAbVhczEnbgxRnuJSB5zlDLwioaAdaD8uiHo2UVm+DK8QeVIi1QEAyTkVHXkHnmM8D
 iRIZqDUGF/6MRZnRAlaJZY3cKHSZi5I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4OCBTYWx0ZWRfX/5PmUnbRLHvO
 Qgx7qDfVLkWjkiL2Upis5dWZq5Je+dA9tqw1391zSJmXX1YwTtpE5gJ+suqGYTAHgIhuL7Gi7iP
 XiBvwCDHUKxB4beziCGkGn8AA4ZPSb4Ds4eayyNfEzK3+LIrOxtKtRRLYtIDeRMKf8dCWRy+WY2
 eJVs+LQFbdwm5Pn0eim4pAJJ76vDcr7Ui/B/pay8guedYy+9p2HFdgKM+4O2ouT2YHCFQIcxF/g
 iicvojiZnKPTtfZbabYb6NWnfSAsExE9jTAKiOpan1zyMWva3sBKHXFkrTg4myKiZpqyrX4IMgf
 dLDDLd2ylGFfMvK05cQQ8qc8wSyuoLKISzK6DwZaYMU56zJa40txMKs4f2g226lPx1/2HU6DmtA
 kdxAa0VAfVsXO1Hi2qiLmKszcmJpd81rEfg0ZNmtJSdSEn7KQvbqZHEn3X63VAcZwyApWs6PDWX
 E4+R4Gyio3HDtCeb34g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090088
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

On 3/11/26 18:34, WX Chen wrote:
> This change adjusts the translation exit of `vsetivli`. While preserving
> the existing helper, state update flow, and TB boundaries, it uses the
> generic `gen_goto_tb()` path to reduce the overhead of repeated successor-TB
> lookups.
> 
> `vsetivli` is used to set the vector length and type, and both its AVL and
> vtype encodings are provided by immediates. Given the CPU configuration and
> the source TB execution context, after this instruction completes normally,
> the vector state changes relevant to subsequent translation are
> deterministic. Therefore, this exit is eligible for direct TB linking.
> 
> Measured on an AMD Ryzen AI 9 H 365 (x86-64) host, using qemu-riscv64
> with -cpu rv64,v=true,vlen=128,elen=64. A RISC-V GCC 14.2.0 cc1 built for
> rv64gcv compiles the packages with -O2 -g0 -march=rv64gcv -mabi=lp64d.
> Only cc1 runs under emulation; make, the compiler driver, assembler and
> linker run on the host.
> 
> Each variant is warmed up once, followed by three paired clean builds in
> AB/BA/AB order, using -j1 and fixed host CPU affinity (CPU 7). Median build
> wall times are:
> 
>                    Before (s)    After (s)    Wall time reduction
>    LZ4 1.10.0         125.017      123.060                  1.57%
>    zlib 1.3.1          71.062       70.310                  1.06%
> 
> In a separate untimed test, a loop executes two vsetivli instructions per
> iteration for 37 iterations. Host-side GDB entry breakpoints show that
> helper_lookup_tb_ptr() entries at the two successor PCs fall from 74 to 0.
> The guest still executes 74 vsetivli instructions. Initial TB dispatch and
> link establishment still occur through the normal dispatcher.
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

