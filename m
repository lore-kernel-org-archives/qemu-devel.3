Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A32EC61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uNm-0001zw-Mf; Mon, 31 Aug 2026 01:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uNl-0001zL-I7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:16:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uNk-0007a1-11
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:16:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52gE82522564
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +tBUK7082SRujEg3Eh+b1JFxPvncwncvCGoOghE7fAo=; b=KXYtBI+/taPfRQg3
 IRR6lD0KYsJfxbw3mFIWWNGQJckbU2bb8scHz0URUPL1bH3lojtnUMFcInjuBmQM
 lAJ11N6o6uHITu+Ix6BgEMV00HQrgW1KFfP1bImc69AEEisWkP8cFgYQVSD5zDXG
 VxNtb3uiJa/pBgiOXcprC0H2Wg9u3D2B5zY/BMQC9XA2ii/irNJjrLagVftuSj48
 khlTDnELNqmyQNt4x8TK2UwC3kJfiL2BGD5Uy+U7t1N2ohlQQn+7ohSxnKOCMKZo
 49WpdzqKMxP3hcsU8wYinJeAZ8WbrDKOlivW6jkc7oW3fveOmTNbi1MsTQCGH1E+
 t30xqg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7w8xj5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:16:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9390ca1a9abso445498585a.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788153390; x=1788758190; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+tBUK7082SRujEg3Eh+b1JFxPvncwncvCGoOghE7fAo=;
 b=jhTqytxu1V46f9zSokFyvJpyiHEIogcPPt2eqGn8alS4LIaWBaHACdDx3g4Q4cX26f
 R08KkXEJY2t8vsvqvPbz/c3F5cywrd0Pgse3YsGjgx36ePGPRl6sPNj80Cuy3GIZFiIU
 HSrDuutKC4kIZn7kBAgvQf1Vg8cENqMWXHqqYWiaV7zpO41hgOLebdRH27uyB4csalJa
 eLK8JkB6FDWlDJdUtXFWhBNfep61n0qDaB9eHAE2FN2+kmJtKp6QMpyAgA/tF3nh1WBO
 peR3yXhYaKjfosEBC0skumg/M7XRch8Yg72oTgeBRt2Xh2lIZyYbg9GKZ9gj3hWvUGx7
 GEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788153390; x=1788758190;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+tBUK7082SRujEg3Eh+b1JFxPvncwncvCGoOghE7fAo=;
 b=nOmlgqy5Mkrqj5gxvxWNe73/jgDabKyxUD7ZgCwkpsCEWKYWllggt48N+I0+vghQBp
 PFwQuaOfVx6qO4GapPyA3o24EUELnouLaIo13RU74ACW0/tD1ctTD2ZRihd5526iwz/c
 74bcs1EmTU2HJnxOHIESrZTY3LUg/mtFGlV23/PELxfcCjaiWrMFkK4iv7xQhf8EOt4v
 UAH7q03hht8bDU9WNXQDFaq16N3zFzwosnCpESHOZb2tELj3QOBo67aAimHNghCisW2L
 azinBnt7ljM/kvvtD7ICD7yFexYG6zvnhyfWnUYuOv/g0NcT2f1eGX8XI5vwjw57nMTH
 Tqng==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLNGSlSO9B0H1t4cRfDQ8DmAru0xf/NDxN8EsFEAH3fFjyTCgxuhSlagLSgBzM2cGYVRQ2WrzUbFP8@nongnu.org
X-Gm-Message-State: AFuF++mzTwKdB9/opmnXL3xh6U+RgSoF8x8xH4dr52zYNulchU1k6Y8f
 OUGHnJWcRGoDGF3UNWtpRFN4zN0KnD/resgte4+egdMIarKbH0tMDKrzvV4Dv+j56hCS2BCIYMd
 e+IY5RCA1RWqlayus327hMwWX9x/+PQpioVCJ2uxe+5EoTmyb4AHhB9erWQ==
X-Gm-Gg: AR+sD11NX1P+KsbkmRj+3Y+WjlC+ENQKflL5aST33UnSeCDbKHGFnLSMa8n8tsci6yQ
 cXKF/MNUOkLv+AxCQ266rh4/vsJos1P3DDA+ZbNDZNgCY+IHLgFRM/kbw88Ec3Xs381Otf8LVlZ
 7DtBQrdXxPqa6Du59zOwLZVd/ak0/Bhjd9mr5Q1ABmaYzqUllNRkcRAfJABroU58PNfj8wsOuXS
 hbPuP+DQoryYM7yG+qOucs5Zv6ZRn2JvKVKxvIAHBo5VtRFbhGK01L786bJ1Xe5S0Ac+OkNE/vg
 5ff2EMUKePICP2W5OZV1yx6MKhIHKnh9GXuHqxeDZki6Mr3nibFIYa3vmewtd+3hhsVyHLKsJ5o
 h6RyHCOLGHR5brJXh8E5xUnacpfvChI/r6w==
X-Received: by 2002:a05:620a:1b92:b0:937:356d:eec with SMTP id
 af79cd13be357-93913816194mr2813056685a.16.1788153390423; 
 Sun, 30 Aug 2026 22:16:30 -0700 (PDT)
X-Received: by 2002:a05:620a:1b92:b0:937:356d:eec with SMTP id
 af79cd13be357-93913816194mr2813053185a.16.1788153389987; 
 Sun, 30 Aug 2026 22:16:29 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dd2517sm261090265e9.7.2026.08.30.22.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 22:16:29 -0700 (PDT)
Message-ID: <ebdf3e7f-0026-4b71-a752-9eb18016fc82@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 07:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] hw/riscv/atlantis: Make TTAtlantisState own
 memory containers
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-14-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831021500.82565-14-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a950e2f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MiBTYWx0ZWRfXyatO94gzwZst
 u5u1PWiRNusCaG1LaYpDodxk6aD9jjp74AQpUX7jFihFgqeq9qCqX7kJdCSFAxTz0/tShOZmKfq
 3UfRlTHRu412mpZ14iDwoIGZAsVdzIg=
X-Proofpoint-ORIG-GUID: nLr0rQ_5fSXZRTSPn98PUTwOJFpwrIPr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MiBTYWx0ZWRfX3wgaou/4Kfqw
 +Spo1YhzJ04YQzPeMoySM/33QQElDYGAtef2wBFLelsvI9Ugt57b5cNEViiZa7HeK9iij1suf6u
 vbpgMctyKwQU4MCOr01BhcEQwJqj8NENZafxuXcut8A6hBbB/lFSbotllCvchuzhRErFosPBI89
 7J3yia7hN1Rk7mbRbHKytz9F0f6Yc2HCXYOhKJq+ZJGqvo6/TveDvsin7MzSwvDxgID2wA/mo7k
 gJLoc700Wk56ZEHhVxAeF0pn/IUGOuhLrN3IljJZh+qzl8Rm+xxAQl4n0iMvZt0P6+Eh63L5uze
 otYQJt1xsjmEZH+06bpU+rMFbDbB03VHcYbgkVoYbr9thSc7ROt+1j5xvQwgazMcyLCoXBG9p6I
 NvV3678B10v/ZwYV6aXsmi9+bW7svAtoKf6rg7ISGUz4u8LAdVmhynnb7E9DNjxuIJhOYzPPtfr
 in6xCXlgjmi1kmoUV7A==
X-Proofpoint-GUID: nLr0rQ_5fSXZRTSPn98PUTwOJFpwrIPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310042
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

On 31/8/26 04:14, Joel Stanley wrote:
> The DRAM hi, DRAM low and bootrom memory containers can be owned by the
> TTAtlantisState.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/riscv/tt_atlantis.h |  4 ++++
>   hw/riscv/tt_atlantis.c         | 15 ++++++---------
>   2 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

