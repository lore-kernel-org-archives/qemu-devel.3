Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB33CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGkT-0006It-2j; Thu, 01 Oct 2026 09:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCGkP-0006ID-NU
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:22:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCGkN-0004ph-3M
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:22:53 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691CTdQf962507
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 13:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AKPhGAM7FUvCE54sUkTTafP4Pcx1epAjLTVFhQAC3as=; b=G3cuyLmCqt9zWJtz
 61AmXqjsYQvug0hi7bwG/uai7QX203lZ1sAtYXIBlYqaGdIPu/tyzaAo5eGQUjlB
 1+eyyVPRnmxBe0j8rGlaZif6PQQYLCNWbFNJhlw0YR1cD0N2rbiVGoeZE78YUXp2
 CXDSb0Iuo9M1tpQQjZKAEHUCJr6vj6s0bpQeMkspiHHFrQ0ycHzopNdkkOrO8hQG
 pjN67NUq/crh3rQr5Mb7m3Aj5/JZOFJpvh/hnw7glLlXbWxSTOWlgPw0MeLJzllh
 EcQJCQQ/pUjevIzCUXGYBHuNc0f5HMGVs1Tc2ovZLHzbyEOm893by5K2wGreiuHQ
 vuKOgA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcvd2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 13:22:49 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-917a109c937so17565226d6.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790860969; x=1791465769; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AKPhGAM7FUvCE54sUkTTafP4Pcx1epAjLTVFhQAC3as=;
 b=OOBNE+dZFF9HcrHWaQO6tnGtAHLIos7cCo5AQRrUSkDwI+kEpCHfsiMNsRlQcUv+fJ
 rBwBMjnq3zFNJdz0LW0wfxyk6x4NSWU2A/lM/562s0tvwQ72tKa7GryIPJMxVB/fqmUk
 YRRvQQMRD6Rwx07Or6umwOORqzc9p8sQL8INVArDyZoyNbM9xosSxjNGrW+djvQhKUZD
 OUTiZmG2hoi3ufgRw5r9H3dR3MTC54vzsk3FtTKufmvf1IO/N6RFDQGugusMLmt24GF6
 XERTN7EEFQzA2LOgY0fI1kyXrCEWLHpnkJ36hWoxY8h66ZUsHCeE+6bP1UTCeEFHcJEw
 0mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790860969; x=1791465769;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AKPhGAM7FUvCE54sUkTTafP4Pcx1epAjLTVFhQAC3as=;
 b=VCasDOg+Vq1h5rK+Ng5ZPmS62ws7grwT9WCX3QJlHhJuY/utqZ5UCWPJtXGe17gyv2
 a4hvfUovcHKDhNwE57fvJJ9ikGdj2xLwWA4FfbygvZaG2Hv7gHDMJI6ZkFBzBNGSDYSS
 OPJFfneJ4znRugsPDH9voQ4UlBGnXD/Wj5MdSPsUnVATztNfEjgzJIqhxmjYZobYieyK
 DQZ8/1P/SrYFFw8A+MOBeSp15k5FL68hxTOzGWy2+BzibAywgEnTQ/vUlKwVuvjsK7H6
 HGHBjpJjgh4dQTQopkd6XGrMxT1b7Vp6LxBkv169tgWUYC+b1GYeBzcPRDnmOMH6ncMw
 QdGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+v9b6xQ1S7prLFgRX8CeNcucXj+mf7vwembDOBVwTpRlGG69WuxJdxi39HD/7qqETwth1gCnVsjUK@nongnu.org
X-Gm-Message-State: AFq9FYJE4xoiPK0Ja0VqBG0lA1fUZAmEQQW0zWoe+dmq99XiUwFiBAMU
 0zPduM8JXWVHOFTfKANIyxIFhY+zbRT5tUClhg5mnu5GDlnIdQbIl8xykZUmhjuUcm+3n4c9Caz
 qx1Vg1OXbHvkuOWwujszKyV3qJ7rZld2z7nATAEdFr6fZGhXEaHoQyaiYrg==
X-Gm-Gg: AYBFou1di20r4RlT0+bYEf8Jo3IMZf5uLS9hJ3irHITw9yU3WS2KVnzHn7iTE8wnuwg
 WjuHLm20SZnLKoya0CJ0b9MUtJwJI2ruImvDqP/fpgFZ6aw6hJ4wpXHpjWEC+9q32osmadz5aYl
 a8DwgidHf/C2MZXNf7Lq7CY2qsYhiykU6mMok/awJqyIRZg+LiZ6D3a43dqZ6GxxsAWM8S0d2fv
 DCxlM2Ej2LGQ9vppGz1BzIqZCMN8os6oj6k7eZcYfdCXGpqy4zLJp2Cby7FPArCmzRqJB5IXnK9
 3BIT0JVwpjbjfi20jvYLJeENz43xBq4UGDoOXCAp2mKCYzuPCIxLk5PaN2J8UZZd9WL6p2+qHMO
 /N2eSwnLnSvoS5e1MuvixO5A4vndYCoua/g==
X-Received: by 2002:a05:6214:2262:b0:912:588d:55e8 with SMTP id
 6a1803df08f44-917a0b2acd3mr83623086d6.9.1790860968610; 
 Thu, 01 Oct 2026 06:22:48 -0700 (PDT)
X-Received: by 2002:a05:6214:2262:b0:912:588d:55e8 with SMTP id
 6a1803df08f44-917a0b2acd3mr83620956d6.9.1790860965697; 
 Thu, 01 Oct 2026 06:22:45 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a881d2f2sm26380266d6.7.2026.10.01.06.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 06:22:44 -0700 (PDT)
Message-ID: <9f56dd91-448b-4e71-9f60-e7cb00655aca@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 10:22:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] docs/atlantis: Update Atlantis UART documentation
To: 'Portia Stephens <portias@oss.tenstorrent.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>
References: <20261001031720.2334056-1-portias@oss.tenstorrent.com>
 <20261001031720.2334056-5-portias@oss.tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001031720.2334056-5-portias@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX60csahen+8J8
 2DVdo2v+jz6FSFQZhI+eIch39tYdnDzhNGci/i95BdNGk2XbSCmDVfG6VEn3FHEB9reqcjrGMLe
 FTr+2NbBfSZRpN28p1Tkg9M4C5UybZJkRkIermdkJBqFkjWU2/e/sKcHNnKHmI3hg6IJF8TvGY7
 k9iCY4rdyGW0CMFEC0pSnAWFXtOjK6Lkmx1g7NkB/j68LH2xoEt6mKiW281FpKmisw6bs4PdDqO
 icZpvP/I18dTZfmUpDrSjEe66Sn9rzMr+t0H0Qe4VhVSGUoIlA9nlBC0s+dXSVWNZgpxi/KPEz+
 MKZSbVAKAySxBM1AbLrA6dafqW/IirlqHF+l/wBzdTtq1QjuLaNbNKvrl/Yk5142FDhCyiyCFrF
 URPdpDpQQmaz497xy4sSLQPiChHt2/hY+cTaHw/8vKCMoLSbuY/Qp3uFVLdubGb+Fgd3Vwv+0BT
 hD98ZeAbAUO2XO7BzNQ==
X-Proofpoint-GUID: q66Lcyy7KepRC104IyEN_lZa9qghyIXB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX+9BqYjpaxLUw
 ECuEKtFgI05PKeBE4Tn0x0gPq9o2pYbe7yuCJjDnibPzdFSBOBXqMTejl9uVwJV8aZZ/gzIWsHD
 AMhgQLDMDy1kEm16dq9aUV7VjkYPRVQ=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abe5ea9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=jbqyKmyYbxlRs/MVMa3Ccg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=t9496tuAAAAA:8 a=EUspDBNiAAAA:8 a=kGxUkT7GHAhlYg2gINoA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-ORIG-GUID: q66Lcyy7KepRC104IyEN_lZa9qghyIXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 10/1/2026 12:17 AM, 'Portia Stephens wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> Add documentation describing how to use the console machine property to
> control the console.
> 
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---
>   docs/system/riscv/tt_atlantis.rst | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
> index 1f2880d617..e8176d96e8 100644
> --- a/docs/system/riscv/tt_atlantis.rst
> +++ b/docs/system/riscv/tt_atlantis.rst
> @@ -13,7 +13,21 @@ tt-atlantis QEMU model features
>   
>   * 8-core Ascalon-X CPU Cluster
>   * RISC-V compliant Advanced Interrupt Architecture
> -* 16550A compatible UART
> +* DW8250 compatible UART x5
> +
> +Boot options
> +----------------
> +
> + * ``console`` to change the UART which is on the first serial interface.
> +   Most users will be intersted in the Ascalon boot console ``UART1`` but

intersted  ->  interested


With the typo fixed:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> +   Ascalon has 5 UARTs and this may not always be the case. The RCPU console
> +   is on ``UART0``.
> +
> +To change the serial console and use device ``UART3``
> +
> +.. code-block:: bash
> +
> +  -M tt-atlantis,console=3
>   
>   Known limitations
>   -----------------
> @@ -24,9 +38,6 @@ real platform. Notably:
>   * There is no PCI host bridge, so virtio-pci devices cannot be
>     attached. Boots that need block storage must use ``-initrd`` with
>     an initramfs.
> -* The DesignWare UART is modelled with QEMU's ns16550-compatible
> -  ``serial_mm`` device; DesignWare-specific registers beyond that
> -  set return 0.
>   
>   Supported software
>   ------------------


