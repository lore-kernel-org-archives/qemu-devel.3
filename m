Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4467EC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uAK-0006FP-Hw; Mon, 31 Aug 2026 01:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uAJ-0006Ek-0X
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:02:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uAH-0006V0-CL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:02:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52aip2764501
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ogfm7fGlpD/fK4msnFiAGptrTF4T28h4vPO79+sGQk0=; b=N9Pimvy2nc2uu6UV
 6y51+TgLvcJLqUQYD0hQdoE7ipo3IRl2YLwLhaJSLN1KzBjBvGjgs3nyFIU5SgVb
 Y5OIAaEbzpYiDAaXD3Duu6DOFBVAdy8S1AFXsFidHwN0WP7aUN58xU4P23M1q+FH
 6BV1Xychwav4EEafk9HOhLfYKgWP7GYlAp1MBWe55o295tHueO7+Gw1k8uY/s6V8
 7RgeBnYCqD6DwulRgo2fMlyfDVhQeyVhznXsSVKQU0WDtZyVvQ+/KVDWLvnws+MT
 B5yabvh8oyttnDFmj7sHFcjZ6jjTnn1o4XSZK4CQx0VIB2OfNYUj2Rs7i+FKgtWO
 yCv6Rw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqgymn5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:02:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52fb2a46cb5so82795971cf.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788152550; x=1788757350; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ogfm7fGlpD/fK4msnFiAGptrTF4T28h4vPO79+sGQk0=;
 b=HghKUb9tSU/rie4Dex0bM8WPKmIPrwo9CDZzAZFu+h3BXI/LK1OBLBTyK+CN1gkao7
 8UfQVHVLH74yKT9R9zJBJRj42N5eD4AU0bKlePaBqltqvaC5k6QFomQ0PJKSZtBZVxpz
 I+BhNZtzykA1jnaJHKC0p5Vw1F4G8UV88UPwuFybmbOf9txew4BF3JoIUDAN9O8/V4kv
 f1cJkULmZB0GctUz0UjXvFSLFsgwjoll6bwR2Lh8mrpSpyExuNMGyd8aTYAEb+szASRd
 1LGiin5/5DE7x8C8HfqHFfMoNOZ8W6OPDLKKT7KHUSTE4H6Y3eWF9ZzRlAIfw3A6w7nD
 +ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788152550; x=1788757350;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ogfm7fGlpD/fK4msnFiAGptrTF4T28h4vPO79+sGQk0=;
 b=WREV9WVy6ppOkVXfRaOcWSkZ5b4nUWxKW8NzoQ2zB10kOtAPZrWwGWfJ97OaCXesDS
 F+VnOGfajXHCmJujFmVBFhYM+yV1qbIETeZOmLFw9Lw8e7MfO/oniVTBLQKCiguYC81K
 NTy5z8MS4EPAvo1i9GP+Eh36gZsPApUoiCySYNH1+VSEram8dmeA6ceAmQrbjgLLmCfd
 QjdmdnNG08XqPl2FmmUBvrFd+2vmKnRRNcnk5O9xG+S87o1nb8uZ6cTd7eaOGjWY61Zx
 wnQJndx3hptW7XtdgQUlNEgXO/e26lZ/oYYpyASaYq0qi8qWZ8B9R0093t5iwX+YkcSm
 Xy5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoV2bbk8Rsj3UYMSE8jM6hbqbUL4aScqsy9VCrYZLEHzvf6/2Rsdq1t6LuXAAoZTCEKHBX5vheIEIAq@nongnu.org
X-Gm-Message-State: AFuF++k3XA5dny+a1/X1RYRJXyC8CRlBfUHriFI+ZMxfO3ArtR90uo4/
 lJ1IMBGPLiivQyFDBUOzHpEY/4Rh2bUUtpWgXaLOgVeM6gRHeiAoO4EDCTmKGFnb8Q65w+PhQgz
 +CZF/1kn+Yu6xJx+O5W0EQD9GrzNCinatNDF3rk/gS2GO8mKGJS7+qe5aYQ==
X-Gm-Gg: AR+sD12rs0H9l2vw7W6Nvqe6pRvTUXSzs0JxkLFzfD1X3L/t4fgvwZJoPMCsqUaSoDa
 1UOmimqGvXDgEhYZRJ3+L1DrvpQjfWxZczJzpa95UdwTtkbJnF2fBgE+RidhmhjURDZZhPkYEgW
 uK202uaBOqcjKLSPFGrZGnGtxgokUL9T1orTePf5WJaZCYDZmmgJUHflURwNNTWEdqD0nIduIOW
 iszVzf7Fd9CFTeGHDGFjXoFp/XuNc6nhZDTu0aN5OsS3TXr7+YfRSu9Zw6/23eMVBOgxJmlbir/
 WnJw6wQzHPiC5iWjNXvctWTGERkO8yb8FKznzX2wQDqPNstEW/o8fWouZAroTdxpnTx7PWda+LX
 sgnWHM7eQJ7KN79NavxpjAFG+bRi0q102Aw==
X-Received: by 2002:a05:622a:313:b0:52d:953b:2c25 with SMTP id
 d75a77b69052e-5301b43b7a9mr4636851cf.38.1788152550144; 
 Sun, 30 Aug 2026 22:02:30 -0700 (PDT)
X-Received: by 2002:a05:622a:313:b0:52d:953b:2c25 with SMTP id
 d75a77b69052e-5301b43b7a9mr4636471cf.38.1788152549763; 
 Sun, 30 Aug 2026 22:02:29 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9269f1b6sm192197715e9.4.2026.08.30.22.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 22:02:28 -0700 (PDT)
Message-ID: <92c34e5d-7d36-4b33-9dc1-04705dbe353b@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 07:02:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] hw/intc/sifive_plic: Take a MemoryRegion for the
 created device
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
 <20260831021500.82565-6-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831021500.82565-6-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX+kO3LvgPMsao
 pJNHHxdYixDF8W5afapi4su8hh5JRcCN/YaiYH+5oYJNYl/XTo/MPi1UYZaawkM1raVuVb2GY97
 /QXhnrPY9XMD+pH4Pq9EhTT9oarHxdw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX022bmtsRI2FA
 +J5Rgnw7A39alVEbWqA2f7Dr9EkV562PrcS1TxPJpKZLzvkE/qwVKHTAZsu0OtPyNSbKAUYLeqI
 tr1cp6FbzBr9EdURqUON+IRgoF8Ioo1WKISleioBe6/0VLwY671QXzg2O+773sMjkknUouzi3YO
 5EAb8AjwgV3WwoQHh4L8uepnWSomf8dPci9x6qYCbSgcsAZB7vRbLhPgaKZwrzLNIPF16XdfoHK
 5Rok9aUTeIer/nyCdGfjACzVr8Wffql0CUWmdevKvADCDYX5L5fmYZAVQIccMFuhvfbtcT6+Rpb
 e/P4jFPDIqi6ySB1wD2dTxUeo7ziaIr4iClIlwQ54erCbgcGZs3uJDaQHN+fJTQBSJ3Qh7CSrHj
 0lSXxAXXPu4QrvVtfJigJ5dMnvQNLCWYH++VEfkY76IJ6jk9+tVFDyMb05oxhnBVTHKUNHqGvSa
 LFggNzTY7iPh5lzFVzA==
X-Proofpoint-ORIG-GUID: GPRq6IkaWFS8UCB14UsV_67bZtZYkqr4
X-Authority-Analysis: v=2.4 cv=R5Ez39RX c=1 sm=1 tr=0 ts=6a950aec cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=c8oAG7Qat8bFSpU1qJEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: GPRq6IkaWFS8UCB14UsV_67bZtZYkqr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310041
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> sifive_plic_create() maps the device it creates into system_memory,
> which prevents its use by SoCs that map devices into their own memory
> container.
> 
> Add a MemoryRegion parameter and map the device into it instead of
> calling sysbus_mmio_map(). All callers pass system_memory, so there is
> no change in behaviour.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/intc/sifive_plic.h | 3 ++-
>   hw/intc/sifive_plic.c         | 6 ++++--
>   hw/riscv/k230.c               | 3 ++-
>   hw/riscv/microchip_pfsoc.c    | 3 ++-
>   hw/riscv/shakti_c.c           | 3 ++-
>   hw/riscv/sifive_e.c           | 2 +-
>   hw/riscv/sifive_u.c           | 3 ++-
>   hw/riscv/virt.c               | 1 +
>   8 files changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

