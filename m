Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D86C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHCy-0004sr-5x; Wed, 26 Aug 2026 13:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHCw-0004sK-5W
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:14:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHCu-0007bg-Ne
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:14:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGvBUF343800
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XjcLN8fU7el4Fh98y3Uavwsv8lvtHLsQAEnAQ7C1TBk=; b=mCkwk5/bsj3JZB7i
 lQuPCTuJDw/3LUfVAY+e6wqYMgJwa0ggksP35rGmuH8jGwaoNU4qjW4xIk5uCLuQ
 vuVl1rgRcMlbhEvw9PY43EuFfm+h7Qo+Oc82OFUHqsgXltpKHFVZebfSkObhbFvn
 6MmuSH87HM8p7IXJqXbrcs1ivG6atwSwoLkdg7c4FRUUIqQOkb+6HwsJiPKViShs
 ano/JkIrfKwPryloVcb6nK5zfl0iA6RkfluNPq7CkQw/EWJo+w0cwK+mCwQQ4V3M
 rtYuA8D+DW59nZ5IRKhYikLgyF9DaxF0hsbMctmVt9SXQpAXegwtgdTye8MMtmh2
 ld0TGQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9utht8p5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:14:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d137a68so22565301cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787764475; x=1788369275; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XjcLN8fU7el4Fh98y3Uavwsv8lvtHLsQAEnAQ7C1TBk=;
 b=T4qQYAAV6+tg8XjKkfW/MOcqPJE8zNAj9H0pDMPV089QFiQ+xc6m3mEz51dtWZmYf7
 qUxAlEMJcjFXgKmZfe1l+cT/M09mF/N/6o05fPCMH9kFC8OVAAVjX7bab2okW++KvWhF
 G2VLWhy/EkV5Cho/m3c17QhE763t4T4YmVwC6xfyI1IvfrVySksU6c/BlK18VPVlHIT4
 ECc2peZb8Tc/LMWZ4MLFTlXO11rtLO51ciehWEmt8ftpJNBHzzuZ/te9xv846lax5Znn
 opaQaGWVSfp4GHslK4aGvwm6yCkoWhoIvUrojvXs33NW/FeSd9yScWdErkNo2yIjh624
 yl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764475; x=1788369275;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XjcLN8fU7el4Fh98y3Uavwsv8lvtHLsQAEnAQ7C1TBk=;
 b=ssGjCuHWv9/L9puLqe5LUqp8K+mXgq4dfKfcSLXqIvhOpEI1Hd4XK4srV9zYu56hen
 CIkHWeNnFOoN7L7mNUu9T3dhMmbwSX4NMQ20KMwZnALXhyNx6tOKnoztfTBaSTgmYvuw
 aUAqNpRN79/qGKtsX94ogMgwa0bZKKiAQm6M318FPtUC/9FBd+oLsxpqwSd906SWkAi9
 Q5rSkh8iIC4Jnoidst4UIdiLfsmeUBi3IlJOXnxFN0o1W4umS5jKzctVWnE29mwl4OGe
 El0Z32612C8rEaCby/eGfIsWClQgTFz61KCa2WgNBOE61bADbuYfd9XXgEzbM0j5fIED
 FEUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwflQvRZivpWQ/G1ug68l6exCQwGx7K+EKHkAETaUNoc3TlCqzdPYC1IBtPwhC07UlwDIOK+xcg8tO@nongnu.org
X-Gm-Message-State: AFuF++l/DwX0pA9WLfhgp6fgloY8UHl1ys0C7/fIbChyQCqag4Y2xElE
 S2p9a89XWxDwJMRvIXD/M1Mrk4AhK8clyuLdDEUf0cm5nON3PBcKreXe3WlqHzy4TGbuYZH2yO5
 sM4boGxRHJVFSL2Ko+7Fha6OyaJRoYWK0kk3cyqKqnnBAvfqQ7kezNMRGPw==
X-Gm-Gg: AR+sD13D8rVTKTVQF1bEx02odz3P3xNsPUcLawwj1RG7clvXx4fEnhi8HXh2ovWbU2t
 jiLliFP0QAbeU9zUKS96ddjjIXDOh0XsoR+AA5QDulVSzPf+Op3OsCXz4UKLobY6VMyOU6dXceN
 fcRR1wExOcJmEvcxkO2ZM/h4ccW1oUkB3ouXK5klIFqgkDl0yk1u3UImU2+8yQrouDX5nWuPRIE
 NAnLphtiaehFrdCtWVYiWrAAhU4BNTPZug8eQ9qTvqHZebxSk+4AjCbABzMfjCGph+83Y83XoVx
 xCnvk3VaHgB69ofGFGOeJVIE1FTnJHZb9+FndmjflyyPsPfm7E2gyAPsBID9nDzWD5EH2shSeeb
 SkSjd1c4ye67XdXPQ3zfg1rMoiUpiYBJhICjHKKIVY+Cf
X-Received: by 2002:ac8:5fc3:0:b0:52d:6c92:b5e1 with SMTP id
 d75a77b69052e-52e423e01d9mr86539471cf.27.1787764474535; 
 Wed, 26 Aug 2026 10:14:34 -0700 (PDT)
X-Received: by 2002:ac8:5fc3:0:b0:52d:6c92:b5e1 with SMTP id
 d75a77b69052e-52e423e01d9mr86538421cf.27.1787764473774; 
 Wed, 26 Aug 2026 10:14:33 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deb030bcsm6696954a12.31.2026.08.26.10.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:14:33 -0700 (PDT)
Message-ID: <39a94a2f-c45d-4451-bb8c-b6c68a4177b9@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:14:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] hw/riscv/fdt-common, virt.c: add create_fdt_rtc()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
 <20260826164814.44335-10-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826164814.44335-10-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8f1efb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=WGN6J-DbI_Zv_MiG4ecA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: D4V6AeRknHOpDbtKU-uSqopnfDhYCdnL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX8zw26r6h6T7u
 V60wT/QGTZmoiS8h6KUMG3DqyUWOfQA69PmomIFgoXeJSJrHkUbOe1iGW8ZIh2aQH6oNifI1Ea2
 lowXl+8AXhXOuDYTQc+CLe2awylkUPuiYFUEPSeV9d/bp61s5E/jjPsKhkPR4j5ijpvd339e6bR
 W/gBCj46mL/4oCXz1oloaFjKH4rtZchLEd62qfxPZPc2LzBmQIBNYrBjbVWpyQa6AF348TBg+/U
 UiHj5AhmXHHo73SwmE+h+dSDyoh+RygbAYRilxvMuP0IEiz/o4TjyF0YnAvwODQIuZEJ4K9Oe4i
 h7lLX+bGtIJ9rEmBA6pZiFE3ER+H9jelFsb++0O2JaPvEIjXkgjaBz2ipeXdduxSrEUraghByzR
 DAYu9a5aO9XLBIREKyUIFdjywUeXX378GDQnFJt4mCLGhC9spvE4YdvKgTcJGL8YU27KmmrfKpG
 45KpPcvHmA5EPheGq8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX86i9noh33Gcr
 2oFoyl61TuLelsPzwIs4Y1vzPt/frT33gClwqoC0EJNlAenNwvcws1UQoagHOnHk8VpOgF/lmDY
 B4V3ulKgCcq1urIUoKQfGxCOakhApyA=
X-Proofpoint-GUID: D4V6AeRknHOpDbtKU-uSqopnfDhYCdnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260144
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

On 26/8/26 18:48, Daniel Henrique Barboza wrote:
> The soon to be added 'riscv-server-ref' board will add a rtc FDT subnode
> that is similar to what the 'virt' board users.  Put it into a helper to
> avoid copy/pasting code.
> 
> No FDT changes intended.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/riscv/fdt-common.c         | 23 +++++++++++++++++++++++
>   hw/riscv/virt.c               | 26 ++------------------------
>   include/hw/riscv/fdt-common.h |  3 +++
>   3 files changed, 28 insertions(+), 24 deletions(-)


> +void create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
> +                    int rtc_irq, int aia_type,
> +                    uint32_t irq_mmio_phandle)
> +{
> +    g_autofree char *name = NULL;
> +
> +    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
> +                           rtc_mem->base);
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible",
> +        "google,goldfish-rtc");
Mis-indented ;)

