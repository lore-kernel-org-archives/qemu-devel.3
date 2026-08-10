Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E73AC5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtYEf-0005aG-V6; Mon, 10 Aug 2026 18:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtYEf-0005a5-5h
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:12:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtYEd-0004I8-MT
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:12:44 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALX9pu2830383
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YUSr8oiG4lGrNZP2DL6AAze7p26x9vHQwG4eZ+yhvbY=; b=ZP0n8mgl48QCfm+v
 kEDL/nU5bOBtTcDqHE+/8PkHA9dhbn8DKoxCLWtNBXRSj+Me8qtyTl6efJOnVbUy
 EG0Yw/Wn73nGrl1XfoFeWWXmerbtW2TvWOlZi8qSSd1D0lHMWK3Esg+DGGl1LZkU
 v1n4HX60VMJVQB+rmhcKuYtgTPseJ/X5c06JvvalHCSatUKV4dl1Uy0pkfiGaG6X
 svpx1qb/QtctBpH2VZTpQDccNQuWLv3xFYVwe/hbP+vjWsZ+0IKFoC+Ihz+QVlYG
 b46fptV/N6///F+sTcW7iW83hAHs3q17OxavzLKHBcaa94FIG/+4kRc25laiMoF6
 2zyGoA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf14kk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:12:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso3916471cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786399961; x=1787004761; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YUSr8oiG4lGrNZP2DL6AAze7p26x9vHQwG4eZ+yhvbY=;
 b=E89jXcC1l6LAFsrZNGIPgDPAe5QU8tikWSUzMoZaI6CLpzVtFmYrwyqXoLq2nXjCvD
 5KGWubrujJJV45W8x/WM03QrcijviTr/VPl88EJttULJgQGnxksHPajJzuXnufzVRLTN
 R06KE56FV4ARJGpXiD3+u249ozf10D7xVRgif2IPKipPmMbp1vdPgON1EpDPTspSgE1m
 wY++goeFY5rSthktGLxCDj2IiciadiEU5Jtxz5nhS20N/BJTagSHwwyQsxZq429zRda+
 O09HyQhF5NFZXVsQ9jXBRgBht/ronv83EfLUTJ+VYkFtS+wwuvrfFCblRuzlqd44qJli
 +nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399961; x=1787004761;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YUSr8oiG4lGrNZP2DL6AAze7p26x9vHQwG4eZ+yhvbY=;
 b=B+HFfLxApHNaHqMZjKHYZJ7dZhuj2XG82Z29oMCEQIoXoLAkHn89LVmQpCfylQIdDa
 TR/fK+UCMLHFhmFMNUXFxF/Qvb9D+9f4Eh8lSYd0AdFMTxRXsue+fXzWAra7OIB0ZO55
 2P6paX39uR3Qa0JHkxXDrRxyM72C0X2+bEGU6ESZ/icllyIXWw8YaUbloH6bUlZuEBPJ
 p+ag3yBLV0YSg0uUI7neerUEYEJCQgt5fjHKp378THqnUAIZuPZzV9pMM3cCAQ6G5GE/
 N2EdQjlCALIYQODIz5hB04xgz3RrYMwy42gEf9UvavWysc2wm4g5QlVUkgCaWJX5e7uC
 kV9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5uEHrkBs2esc3E6tTYILalPzPW1RSk42LE3vdVdNEXk6Ib3HoWhoO94fuBHcwfZs6U9DuV9f9qFTH@nongnu.org
X-Gm-Message-State: AOJu0YzfvDk31xWRPpkhX1GNorKCX7lsNg3EZUajmpc7oe1SBKfKW4Y4
 QqF6yGq9fiGh2iW4f+iAWBLTHPmWC6uTldRdWBMQoeuz0O9JFlmjWv2Io1u6CO5k35+8WiiZL6n
 +mO9RUyQtkpueKQ4Uup9qE1haBEq49cMY4aKcwuY5Mdtn03N2sIvinXrnsg==
X-Gm-Gg: AR+sD10bO4Fki+HQoPSyqudVWnsNDjOk3I9EEmgIVEIxHa++NX6pMWWYG3O+eqLEnff
 4JCz9DaaIjRjcImCwve6VXSk84pROTVv1GIbqCBd8NEE5RF2+KvojPelhR74fM6Xdf/HhZoX38v
 0CyCfQmQqOGRY5FkCuZ0tnZ/qzO4fISAMg56fEEG8z3TGqLPbxFfKq5Sp7CiFsSYg/M1gEhWfvi
 NA4PVFnd0emw8scUhIqVqLvE79XDVtDoCdqgCTkgMlLDOhmf/LuRSFAVlbzH/046wSlrFMUpkss
 iFE1tuxvIdikkd6IrwZc3cOVFEeNeuJh7WaTqxK7ZV8ACthW+9M1EIzmTK3WR8DtSU2ZZIJi0eM
 BSY+GNUOoQ1efcW28JAR0UhCU+DGd5y07oSnl8g9c
X-Received: by 2002:a05:622a:d1:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52d5139fa35mr20447381cf.2.1786399961485; 
 Mon, 10 Aug 2026 15:12:41 -0700 (PDT)
X-Received: by 2002:a05:622a:d1:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52d5139fa35mr20447101cf.2.1786399961038; 
 Mon, 10 Aug 2026 15:12:41 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506cbsm39972175f8f.14.2026.08.10.15.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 15:12:40 -0700 (PDT)
Message-ID: <b361db3c-f5f3-496e-ab90-ea43bbd0039a@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 00:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] hw/tricore: wire peripherals into tc27x SoC
Content-Language: en-US
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 christoph.seitz@infineon.com
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
 <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-8-1c39053e5e95@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-8-1c39053e5e95@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lahc0DnAZ9e9tIXRNkzfSK99WMyU2efg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4OCBTYWx0ZWRfXwkLcECrR3DCU
 VwHhmLnuS53/S8DSlxRxYiK4T71rS8vw9MYnq5QRUpPcnmNkKiIyxTxJ+fyt+OW5qCcdmFB0JLP
 C6BCssXjTNL3tYC8pXD+BN/Pg7UzNrk=
X-Proofpoint-GUID: lahc0DnAZ9e9tIXRNkzfSK99WMyU2efg
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7a4cda cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=vU9dKmh3AAAA:8 a=diA30jNN42xtM1azklYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4OCBTYWx0ZWRfX4AC/+na4tL4v
 Vh4byi4+ZoMkKpYX/CpmGARHO9F7GeNP2bgnqUXCXRVMmS4j22B/tPiRaNAq0Q/mf18l0R12OVK
 IpIJbEjqEMmciT1mR6BJKKSsXsZTig0KbhokEofxC6WWWY0ga5xZytV9ucWQUHXK5bZE1fF1bDl
 7u6+kmGHI7NNxOizZ1KBKrmfh40fHFG7ZBAW13AB+ScictqH967dJjiRd14iMIunmTcTjlEgIPF
 qYP0W9jUk5mXbYIqlPyg4dhQ3SC0ZrtIXypdAXmk4fTmiIDIX9PjAWcjH6wpPW4hZXwR8SNGhbl
 t+sQ538eX2M/s/drieBCdKRNv0MlOUGS7JHa9h1CrCjkIrj6tX1l/Lf05H2nu0AKuzUq8lQeE98
 hNxKAfjsQHgGY6HJitLc3uhCev9Qj3DrMXStbev1eqFzqjsYBzyZjDK9dBfiI0vo36tuh0bccKL
 Cy5BbH4rKiAJ4mncVWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100188
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

On 31/5/26 11:30, Parthiban Nallathambi wrote:
> Map IR, STM, ASCLIN and SCU into the tc27x SoC at their hardware
> addresses.  ASCLIN0 gets serial_hd(0), peripheral IRQs are routed
> to the IR.
> 
> Interrupt delivery to the CPU is not yet wired -- that needs
> do_interrupt and CPU-side GPIO inputs (follow-up series).
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>   hw/tricore/Kconfig             | 15 ++++++++++
>   hw/tricore/tc27x_soc.c         | 62 ++++++++++++++++++++++++++++++++++++++++++
>   include/hw/tricore/tc27x_soc.h | 13 +++++++++
>   3 files changed, 90 insertions(+)
> 
> diff --git a/hw/tricore/Kconfig b/hw/tricore/Kconfig
> index 6c04f64949..fd589f7b78 100644
> --- a/hw/tricore/Kconfig
> +++ b/hw/tricore/Kconfig


> +config TRICORE_SCU
> +    bool
This change belongs to the previous "[PATCH 07/10] hw/tricore: add 
System Control Unit (SCU) device".

