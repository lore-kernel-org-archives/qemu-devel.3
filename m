Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A671AF433CE
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 22:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD8IQ-0007vc-Qn; Wed, 15 Apr 2026 18:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD8IL-0007up-5r
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 18:01:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD8IH-0004po-Mc
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 18:01:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FFFo7h1792541
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bh3eSiFjGrGUzXTANPTKFs94mGxC5Gtrw/UPDWVy1YE=; b=eYz82mUC7HYsxL+p
 EEuOETNMccpBMAlybz9j1wgfDRumUxzBmI57qVPrkENx0AUzLnKURE1zSO3wB2u1
 TxTse8oFEVnDRkXWXKV4m5g59URiecZ45kkMvBL72ZkxzxBhnL6MPIcUrE3rV2MU
 zsjlNWrZUqXp0DydKjNnweByCg549ncE+8MbbPYGdiv5juwRf1+G4E+R23zbdKgU
 N/cLU8N5SpqTcn0JpaDkX5gMCgDO+Jf/Q1JGb6ZDBWGYmoySdFfyZ6wmVy9I9E3+
 7QdwngV2m2DRnoHVnTIz8eXdLefdDbxSP24wWSLx/mgK8Rb/+5Uk/x4bM85JBeXo
 S2QZ/g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djd5ps84u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:01:07 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1273dfdaf5dso52540c88.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776290467; x=1776895267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bh3eSiFjGrGUzXTANPTKFs94mGxC5Gtrw/UPDWVy1YE=;
 b=HvF6oqLy/3Ubv/PNrJaaZRK8V7xH8uScvhqhvIefp9HaDKN771E8a09vprdjFnQYXX
 6+s4llGPdND+KklkZdSv8oHqGTnOKv7Hf55Sn0b5EBKcdOGYp/tjFGttwDhVvFTVhZ76
 evzOMRAmyDM6OUBw4CZ32fdfwQFoQboEaK3dD0z4MLZtPBRFLCfonSxn/Ywhhw+mM4Dd
 EvN2/yplnu2U+fvIL60KT5GqEyGECaOs9lI7DCB1QGDhosbNMLVHV5wotbJffppL80SW
 OhCfAuoROhoVERMY/tg3etvEYd16lDv7m2dPtIB4B2EsVul1q8OtY42PDFp5MB7VTemU
 IPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776290467; x=1776895267;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bh3eSiFjGrGUzXTANPTKFs94mGxC5Gtrw/UPDWVy1YE=;
 b=XCx2rieEIj2On8B+HvLAaZqlKhrWrVHfZR/nijN87cdOuFToafTlzj1vpQbqedXsmh
 gEpJ5yubL8lXB0HmnTof2fIgpny+aV1AEYAbnMw/ZjjPT55gEHYlc/+g9nIgscwc+nGd
 fTWIsET82kWFtdIDewLZdrQw0s/UsxK5o9Yl8X357GUePvLoS5W9/EjiLfI4S3e4swRi
 X10Z5vm9FMv4ycD0V4KdownECQBZCG9SXj4qtbf0n8zPFPjtnkFR4MpumShhN3GgjywA
 Zq1BJfi4VqtBPoB49o8IcDxujjVjQNVQnF2lDgkH1FeALjUPoDKDfCNyqniP2hI4M5O1
 0idA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ybdJuO0dEfySE542rfT3krWyfQPZqklLL1ayiPN3W7pxBgjayF74y+6lYxug1dhCMvgoFuyCTnAAm@nongnu.org
X-Gm-Message-State: AOJu0YyJsBSnsCmL/faRJeQQlM2LW+3BUqRg5zJcaM/zLQt4jB3CznuG
 kjFuVernWJbVWpHrNAn3XdUimVsqMww3kdlswT0hvwvXc7OcH1jODjbfN697heVgOcSZTa1uI/f
 xkN2LZSDyuuCdzdszyqYQA2HpAurn71Q+ruYGD0zv77jJSx5rosL3JLeVcw==
X-Gm-Gg: AeBDiesAPX9nNIfR7RtE4BqNAE/l38J6icq23FeUuYnPzeSjVCJk3Hw/7RyTDPk1vRc
 FPEOaDrX5DnsyaOq1rtF/InYrPDd5mtuS95gm2DaC4KUmwKIms/816/YjRTcjm5aumZc326FjL3
 +m+uBQHDbnvMbv3v+eRZTSRrUcJhjjZ1lq5rpUt/InF4iIWCrV7X1eFEfbmMUyoQCNkyC4usp0B
 ML0yiWYkRlhZc+Zw8vKkLIvJrKoDA/V12T/nntVJbnUjm7OpdZMjTdJ1HPDniIWVEOmNjFfowBn
 RZYCMgj4MbYeg4FVJDBKwUvtlMDgsuLa6ZtAKhd+N4Xvd0y8N5K4gi3vMOYC9ffkG2ku0vDjjRl
 wxxAtr7CCuMbPpeECV1uQdve5q08Gp9c9mrJxruoKYZWm534md5uddXsWCj+wYzYVA4WRB4mcgR
 2nshg0VxqSPw==
X-Received: by 2002:a05:7022:128b:b0:11a:fb0a:ceca with SMTP id
 a92af1059eb24-12c631217a9mr687537c88.16.1776290466166; 
 Wed, 15 Apr 2026 15:01:06 -0700 (PDT)
X-Received: by 2002:a05:7022:128b:b0:11a:fb0a:ceca with SMTP id
 a92af1059eb24-12c631217a9mr687509c88.16.1776290465444; 
 Wed, 15 Apr 2026 15:01:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f569f4bsm4413086eec.21.2026.04.15.15.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 15:01:05 -0700 (PDT)
Message-ID: <94bf8494-1ad5-44de-9669-865223c08875@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 15:01:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] cocci: Do not initialize variable used by *FOREACH*()
 macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org
References: <20260415215539.92629-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260415215539.92629-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b0OYnlV6iy6QYdY5TggOUyryAXdAQphV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDIwNiBTYWx0ZWRfX4p7FnnWbiwAP
 ZV0asj7WxD9JDrTcvt94f+V0YfZMF189UHc2rb7OE8BaavjVww0xa5ceIWqipdU384SEnYHPsid
 VydY3MRimzTxbl2LuYMEhZO42qZyNUQjyOVjLX/ERTLgbT9XIHb8CU90SFZp4+YDnOuX6ZrGOYS
 ZYuEd3vr/9QIe8ZzqdBGcwybR+kX3y/FwtyGkA2JmcVGTKYJAITKf4c+agtyBOTJW6n8UDKmcOb
 QN68Djo0Cn1nmLzYH9fyYQW6q+Bk6tGU9Hq3DRfJdzpseWlrGh5DXmwWDLZK31UHaP7RoXv2KMH
 u5rTeiv4cQVsWzpkDSu6cN95xJEPbPEzVHRyftVHqMR7DMKydxqv7yuDmqONNlcy0zwCm2wVAOE
 ospGnpuf/LleO+GcUpXDRRCY/4ovzAWXnxxXqN8CYxIWig4JAMbTj7be0+pJVQd2t8WkC2PI2ZJ
 +3MAbE/gsdBpZ+r+vqA==
X-Authority-Analysis: v=2.4 cv=AcmB2XXG c=1 sm=1 tr=0 ts=69e00aa3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1CZdNKJIaicOdOL1u6UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: b0OYnlV6iy6QYdY5TggOUyryAXdAQphV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150206
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 4/15/2026 2:55 PM, Philippe Mathieu-Daudé wrote:
> Most of our *FOREACH*() macros take a pointer argument,
> then assign it upon entry before iterating. Thus there
> is no need to initialize the variable used as argument.
> But sometimes we do, which is confusing (for example
> &first_cpu). This series uses a Coccinelle script to
> clean these unnecessary usages. (and 2 bonus cleanup
> patches at the end).
> 
> Philippe Mathieu-Daudé (8):
>    cocci: Do not initialize variable used by QLIST_FOREACH macro
>    cocci: Do not initialize variable used by QSLIST_FOREACH macro
>    cocci: Do not initialize variable used by QSIMPLEQ_FOREACH macro
>    cocci: Do not initialize variable used by QTAILQ_FOREACH macro
>    cocci: Do not initialize variable used by RAMBLOCK_FOREACH* macro
>    cocci: Do not initialize variable used by CPU_FOREACH macro
>    target/mips: Reduce CPUState scope when used with CPU_FOREACH()
>    target/riscv: Iterate vCPUs using CPU_FOREACH() macro
> 
>   target/mips/internal.h              | 11 ++++++-----
>   block/blkdebug.c                    |  2 +-
>   block/blkio.c                       |  2 +-
>   block/gluster.c                     |  4 ++--
>   ebpf/ebpf.c                         |  2 +-
>   hw/arm/virt-acpi-build.c            |  2 +-
>   hw/i386/xen/xen-hvm.c               |  4 ++--
>   hw/misc/mips_cpc.c                  |  4 ++--
>   hw/ppc/spapr.c                      |  2 +-
>   hw/ppc/spapr_events.c               |  4 ++--
>   hw/riscv/boot.c                     |  9 +++++----
>   hw/riscv/riscv-iommu.c              |  2 +-
>   hw/vfio/cpr-legacy.c                |  2 +-
>   hw/vfio/listener.c                  |  4 ++--
>   hw/xen/xen_pt_config_init.c         |  4 ++--
>   migration/block-dirty-bitmap.c      |  2 +-
>   migration/dirtyrate.c               |  4 ++--
>   net/colo-compare.c                  |  4 ++--
>   net/net.c                           |  2 +-
>   target/mips/tcg/system/cp0_helper.c | 28 ++++++++++++++++------------
>   target/mips/tcg/system/tlb_helper.c |  7 +++----
>   target/s390x/kvm/stsi-topology.c    |  2 +-
>   22 files changed, 56 insertions(+), 51 deletions(-)
> 

For the series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


