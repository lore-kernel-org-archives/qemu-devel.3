Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55184606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cLiwkXxi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JDhMAFjb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOkM8-0004JV-2H; Wed, 04 Nov 2026 18:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOkM5-0004It-Ph
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 18:25:21 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOkM4-00069I-3S
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 18:25:21 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4M4kiI2251645
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 23:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5vsW6x6U76JBXeledkL7zyihGvN5SE3GiljuCj1ULSQ=; b=cLiwkXxiorOG0J9S
 G1GtVaj/7JgW7ITaM4h4wqJeJIiS426rPpZJpnYccqID29Q2wjFVYWMYOoe1yw+l
 V0ydvypYVmDe/b1m7IsA1jVV+f2BYmQPzLmFq7htWqjKBw4nxqye0/ePRSDXfKc9
 MzczAptwAgTKeJli1MKU8TVAIPz61V7ePQdcWFUb60lPmDwoOPdklVEAavVDKczs
 qreaA9jZN793sPePE/WWRnAsmgSDGQSDI3NVo9DOzM7BVaNQttDp2JL7xB7hFJNw
 xSzQmjM7/27Swmx8ywaAnudITKl5wZNQ6/6KKHjmFC5JFiT1sGUBL53Y0C0n7Hk7
 NA1/Gw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn2qpt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 23:25:18 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso3058755c88.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 15:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793834717; x=1794439517; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5vsW6x6U76JBXeledkL7zyihGvN5SE3GiljuCj1ULSQ=;
 b=JDhMAFjbVcALZGPeK9luup2LBbQHoNMsz+MGj6aSPUC7bxIIfzhD3aamqrfejp6wQ2
 Ll1hdYs+4w2K0pFP0fcvjh5yeTy4IAqjiMvhNUMjVb8hskoo2ScryhJRxu42sU6yVLEM
 dJ4rcteiYWni2OEbJEz29KldQ+yTiEvxxLNNkjM60VPTjvFlwpfMfvzmcMW5MfaCDu2t
 PlMj+6dDq3bu0zqEED3pTrabR8DelchAdyI3n7qiJzYoAEuXIhdrwtR+X2GNmVbbszbZ
 F7f66AQSxy8yV3/Re4xqU4pLlO/0Yr2WKRYYCrj1/iLUD1sLRJOHj9M1VeaXY4Pf+h+1
 z/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793834717; x=1794439517;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5vsW6x6U76JBXeledkL7zyihGvN5SE3GiljuCj1ULSQ=;
 b=Ue/PVp8GGsq95IieLEpsJ5IUSL4X+XsChrHKGh44uZ06fCfdwMBNxQDLXxjJavWTfL
 O8Qbi0Bw+LlPInofIUpsJr5ldrvcdyCozHibn9gtHJG+We6j2jrIfj07GskS8yBWps0E
 1W6bUsNXkhTL9ZWXQbUsDyLuB+qwVHB88ntE0yp43/jU5RHB53XfXHi9U/Cnut3KPSp+
 y/zI94jW2U55YjQ+foS03gRRFTSqO57UT76nzuNpWsZIjDiMivqnQ87yfRIPbHE1yE89
 fH2Rm+CHGdFPRc4YUckTafOyGSgxGB6Ht+Brj55y+DPbTe2RXzF1XaR9FQVHKGmBZGal
 PWWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbcjNKoJmM/QL6F+sCwgbDKjd7prry4D2qa+svN6VFNo5y7CNKfTpSZQ+Fv/S4snYBgTCGkA6mn7Y8@nongnu.org
X-Gm-Message-State: APuU4Z93QIR7JP39YY9k1Ycmjtf8t9sRvla9YBKA1KLr7NKoAwZnoTv2
 acMZQLIuLD313hNbw7wrZJd0OnyVqwFuiqmwUdLiKy5jYaJWgKZDcyxfSUIOIT5ZKtNJVeVFaLZ
 HIKodGHzcSHW4+uEGZu/fibpwVox1zKBkkUWT6YLtN02KdCOuKIDN6lhSZA==
X-Gm-Gg: AYBFou2sW1CBz481G07Zhin7m9nzfIR13+kpPgqrhWOFCcwJfEOWQdnfEHXoXMbVCW5
 G1xHKKW3d2kdEviETW6E1ljCIvkCoz8xF75ovqn2Nn+nNv1LFeq7PNarPJ+YGY9UJo8ZbZcn/8U
 +VTFdU6cbhflHsNYolNeJxSRbphpUmzgczNAx2TkJsLxUpkeVUDZ41o6Qo+PQ4+fN9kO5dDWGGr
 qsVEeVqjQ2JRSxpJyBw8qabzTod74ZUIh4va5uoq8UZBePXlExzG5hongmFbAi4K812TD71OAtK
 uLoFvIeMQGXS3aL3MRddr2ABQKsAoVigMY2AL9qGgJQT5RuhzOxCMv85yGGdpQ9UCZZBA7EI+0r
 nIq4cDThregFc8sYvWloePHjQrNa0Sfk0X2IBWdSYzHFIf6i9n3oqmhaxLjBUR0V3BYS07qbmtn
 U6bS2yGg==
X-Received: by 2002:a05:7022:eb50:10b0:14d:baf5:c415 with SMTP id
 a92af1059eb24-1ac5a0b4324mr27696431c88.7.1793834717030; 
 Wed, 04 Nov 2026 15:25:17 -0800 (PST)
X-Received: by 2002:a05:7022:eb50:10b0:14d:baf5:c415 with SMTP id
 a92af1059eb24-1ac5a0b4324mr27696379c88.7.1793834716220; 
 Wed, 04 Nov 2026 15:25:16 -0800 (PST)
Received: from [10.20.27.94] ([12.40.131.195])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c1c283sm11557849c88.4.2026.11.04.15.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 15:25:15 -0800 (PST)
Message-ID: <f171b51a-1efe-48f6-b701-81507c04e774@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 15:25:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/pci: IDE, TEE support functions
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-1-60d361bc0417@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104-ich-driver-spdm-v1-1-60d361bc0417@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA5MiBTYWx0ZWRfXzfO9K6ErQGHd
 RujHzQxc/uZA0vPOJJaSTMBIt8jiZrvnqoMzKEMnXQ5cu0vWxd3Bx3rwJVhSmKboTl+KSQO8btx
 gvWz17SbSTLc6rdFkX9G2ybX7gaEh7H8TMsbgZ5hSsQvcb0ro74PJfL8TP0TJ85Tq2KIQ3mqtr+
 eGiVLV04Y8Zde2ZWxiQZKf++4nsxIItN4xXDUvzCAzf+APWLVEUEcHVuP6H16GUFinKhIcrWdud
 buf5BeUjvcJgX62eeN455kj7sTv85FDcvZIkLIOJlt//VA588MssJRqq9h+0FDKBRMpPuGG2MPt
 F8IvvRxfhkzvrM6JupBDkgKugWhVBQBsLnyXV575KDmqXBNk6u4Mwwc8HSnc9M4JywADS0vFlR+
 WTH9wyNncOB0qkkHr6BK//KgjYON2NYOKsfn8IDmmDd7WNV52ahwSl143dN26heLQludTwwF0aX
 NWIWgn6VNYG6ILUlxYg==
X-Proofpoint-GUID: Nl4PkGxFSueC5MIsgSCVd1b-qoCAhK-B
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aebbede cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=GTbveq6Qlqa3SwyYiUIGjQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=TH8AjMsAlN3xsgtcZ7AA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA5MiBTYWx0ZWRfXyiLIJpmEn2yQ
 o4SV5kqX/cxpSh94dXUW9AYh7bJSmwMAdT7HhXQZ0iGHxSS7Z+s5wlmbRWoa8jSeDfUItDnRJNB
 QOvZpXFZtxTw8R28EWyMGdbEUe8xJBk=
X-Proofpoint-ORIG-GUID: Nl4PkGxFSueC5MIsgSCVd1b-qoCAhK-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/2026 8:34 AM, Jim MacArthur wrote:
> These were introduced in the PCIe Root registers patch series, but need to be
> duplicated for the ICH9 driver patch.
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/pci/pcie.c              | 15 +++++++++++++++
>  include/hw/pci/pcie.h      |  2 ++
>  include/hw/pci/pcie_regs.h |  4 ++++
>  3 files changed, 21 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

