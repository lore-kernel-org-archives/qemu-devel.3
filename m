Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D77C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgebw-0003eF-39; Mon, 06 Jul 2026 04:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgeba-0003ca-1c
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:23:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgebU-0006vN-Tl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:23:04 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641V7F3623887
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tAmhagGhKoTxPySDkEE5AIlnpQUTREFpjgT8X/9lJ7g=; b=jpz3e21KN35eKf+4
 E/THJMLK/FgYq3VS3T0Ee3d43A6tWRnTCg3MMD+SIofAE5TARr0Pntf1w5drGaCv
 C5o/SkvFRN4E794Mwn4m5bxnYhyepoeO3I/zL9NGm9wiN4liANG8xK5g+pTbQ2v1
 wvcyLToj/KRFt52JVGy8phUrei3//c25q+Np6YyFyp+LF9xQrYgSbWCOf37yETeu
 QOf8x6mqP/LItUmh1K2Dz4nCYo6qdk6nvSH7DCjnnhb8lQVEYejm9SkIiX5if2v/
 c+W5I5KMn3hjIoJD/Rj8/5HjqxEGng0D/JVi4uyEItjRfbeUzIvUpUhCTjP0RkpR
 PVpJhg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4swd1e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:22:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e62e3459fso221828985a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783326171; x=1783930971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tAmhagGhKoTxPySDkEE5AIlnpQUTREFpjgT8X/9lJ7g=;
 b=TA7jcd3zi8Ly3S1zpJkBsIH9dZtpVAPEmWNgj+oM3xdJ6+OT1YWMqpFJenww7fT479
 yJHb4AZcH2asCKruziIG0VNZ4UZJwctIZv1VAP7eupad5dLAjqOx3V+nqmUFtIbe5eJp
 ZLKU8+PauAfzap1IvAGE9th8UWpn+TWxuwihsMlAt8hBMQVXl/luCIVHT/t5h5LM1iQ1
 tH5wg8e5uXKFQ2y5ygCOrWCktiMUYQ30e19e9iqP+441BYEUY47h7IwNvyuxGBf+Fe73
 HS7wTWFB8Q4OhYYp9XIAk9dHWPIz6XzMn+U2QxytUTzzJgpQafimpl2zlBOxhOiNrR5L
 Fp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783326171; x=1783930971;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tAmhagGhKoTxPySDkEE5AIlnpQUTREFpjgT8X/9lJ7g=;
 b=lv7LkWogDBziXGMqeEDwzGwy41ng7m49EBFgQ0QGnj2t5bYLq4VUtg+Bt521q/6sKL
 Bqlv725z7w2ZA4EZgjucBYXwuWAQv8svG+IIOiRE82A8ev7ZwZl7iZMireXTj6e3ndFC
 +v2JaMbChS+cCXOnOgW7oZUUFGAXjJ5drfq4LwZuDvExx4Z/A9ucfxGhGdP4JuQpqlCa
 XVDsA6W6U9z0vCHFmJFehrqis3iNt6pkh9Smj5kTBnGiuzWHxOrk54tkfp0/R53lA0JS
 dkj8Ib+ko9R+77140f8GzoVl9fYcK0008ZYf+EMcVUHnL6CdA21YMQLC8oTGbJCYfeFP
 ANVg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1CvbjwgpCz21MZ7O3/MIJgLQhuzTV38rrwoZpTy6cMloFuskvvE5qr2BsHQ14VLWTMMZ5/2oylIEH@nongnu.org
X-Gm-Message-State: AOJu0YxzAywpISZ4QIelldzjduJeMLD7QVIzxA4MMXdRa5jXeRRG1LFT
 iZLaCVawr7akpZ+z/wdeyThEBsfxjtf51JWk6T0tMp52n+qZe1GOacGYobk748OBByS+KceteRf
 pJdazpITW9o0+jFfkv2TDKMeQ34QsNCU08To19zZ6cl9ASVnK1mLYWzQVjg==
X-Gm-Gg: AfdE7ck9QOYPUSS3nPC35/HIMmtd9LqqyN0wFBBimsM7bzh4RjPSSwYwbTdIBC897+E
 tRbua33Uwt6FzR2RTw3qdgXGohRnPriE1CHU+SckWE7aaAwxF1XMbEkbBwL3Jtcert/QJUxsh/I
 xz4VJoC6832qeMJUhxP2FABlfuRWcJOQjSF7pZgg/d/IskzCysCxlETIS8NZOQSwwo8VhL4LeW8
 HxqqyOYSytxGOqMdp75Z34q3LKBmdnw5OkO4ARcMEFksxgzWa4OjSpCPY+wcKmoHUMYLk9eqV/f
 eTylIC6GEsNX2cw4kFiQMw8RK5HR+vTleKp3uzao5PS+c4me28+8yAwbn4wulmOFn7hs4U8W6Yf
 hl0ZSkvaAlX9v71Gp+hFsrMGiAg/COkKXxdpb3KvY9KWj8XdMpPqtb9JpCmxI5Q==
X-Received: by 2002:a05:620a:6489:b0:92b:6805:eae4 with SMTP id
 af79cd13be357-92e9a50fa0bmr1286164285a.65.1783326170756; 
 Mon, 06 Jul 2026 01:22:50 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:92b:6805:eae4 with SMTP id
 af79cd13be357-92e9a50fa0bmr1286162185a.65.1783326170227; 
 Mon, 06 Jul 2026 01:22:50 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19cd888csm3539212a12.4.2026.07.06.01.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:22:49 -0700 (PDT)
Message-ID: <2241dd72-e7b7-40da-b557-8ec5988523e0@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci/pcie_doe: Check mailbox length for overflows
Content-Language: en-US
To: alistair23@gmail.com, alistair.francis@wdc.com, tangtao1634@phytium.com.cn,
 mst@redhat.com, qemu-devel@nongnu.org
References: <20260706003647.75945-1-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706003647.75945-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX+Nr9Af64CZxj
 44HaxNVNMqnQgMe1NfWgmosRnJe3VH7qRo7SnLq0DbEFL98MgQ806d9IzFhuOzZmG4YztSB4HhE
 qEMg/5CzvxRjNVdDWBRuZ6ZPI1KoC78=
X-Proofpoint-ORIG-GUID: Wt2oxFroT7zOQJB51DON6X4-nCqdjDHM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX7glYsVQoeOos
 YwanAn40HAINoRo+htHzMOY1uNgf54OaTfBSN0RQPzJx2b430G2t23XZVj4u83mbNc6F1CGy5I0
 eyo3PN0eatl3DGZIwIt2A2n5n2abee1RAaPNPqtowVbX1NxR7GAoyQW8dTmZrPtbnK7wZEspPhp
 gNfcHp7VKXcY6u7bt/lcPqSFIgwMVGqGjgTgupLUIbzNOZCi7UKOOsh+1iMH5mSOGxzAb/L8FVq
 RP6bBE4RJ/To5E3Yosb4rMvg7mi8mm41zuDrrBFCS9HkTQ1J9vy+Z8tbl9dMxhF9yFmmeDQg22N
 50qjhWt44JBvEXYGUFa5MrwFFC6Mf/BiDeYtwwyn1haH+GH2so6T3aDTqUJSMPLt7d8cQIVIvz+
 rxDdqkhg6YdkS4buPpntIgecCjQWHkUy6tqCPj9D9Ree3cMzKG0/jmDPLjgQSWocDHNUMRZUN0/
 JpiGzH1Oj3wp7YmNA5Q==
X-Proofpoint-GUID: Wt2oxFroT7zOQJB51DON6X4-nCqdjDHM
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4b65dc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=RaFb40yWfpTsbqF2WDUA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060082
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

Hi Alistair,

On 6/7/26 02:36, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> It was possible that a guest could overflow the `doe_cap->write_mbox`
> buffer by writing more then PCI_DOE_DW_SIZE_MAX dwords.
> `doe_cap->write_mbox_len` would continue to increment and there were no
> bounds checks on the length when offsetting into doe_cap->write_mbox.
> 
> This patch adds a check and reports a guest error if we would overflow.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3679
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/pci/pcie_doe.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
> index 2210f86968..765ebea42c 100644
> --- a/hw/pci/pcie_doe.c
> +++ b/hw/pci/pcie_doe.c
> @@ -356,8 +356,14 @@ void pcie_doe_write_config(DOECap *doe_cap,
>           if (size != DWORD_BYTE) {
>               return;
>           }
> -        doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
> -        doe_cap->write_mbox_len++;
> +        if (doe_cap->write_mbox_len < PCI_DOE_DW_SIZE_MAX) {
> +            doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
> +            doe_cap->write_mbox_len++;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Mailbox write length (%d) is overflowing\n",
> +                          doe_cap->write_mbox_len);


Do you know how real hardware behaves? I'd expect it to wrap, not
discard.

> +        }
>           break;
>       case PCI_EXP_DOE_CAP:
>           /* fallthrough */


