Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC4010F2848
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69NB-00037T-VI; Fri, 27 Mar 2026 11:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w69N5-000371-Lh; Fri, 27 Mar 2026 11:45:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w69N3-0002MW-Ny; Fri, 27 Mar 2026 11:45:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R8WiBl1838211; Fri, 27 Mar 2026 15:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JMHeu3
 LIOp2h1TOdXxVhhunUQ4ZNXGED9jPAo0nAr/c=; b=nLG5MnYQj2dNBJjWiE1hnv
 noxCl10+e5YhZ2WPzcgfIpckCSa+bWXmI6Cte/v2SjiQLLHGIcIimdGT61IvQWWw
 +YVP9F6e7l9bgZNQKNoo6Lwdq8mwwnhzz2OZLSS3AqaLzgoI7wBT1oP5VTtYPOCQ
 hZpfiUXrq6w9NGuPitv9OKsaJuSQldofhfLOGR9marhX5M8ckDl2MpSiP1JoX5sp
 wrVb7LGgWWmbeAKCt0XgqgSrD0TX29sKh6A55C5rrKIVfeSZcdn+74vhxz+3MERz
 9qqMQpLyhScKVbcnJW+FWNUu9TKFEFWnT8A9CVYXfyn3qlsqrh2dprQauw+6qn4A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kun1spe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 15:45:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RBm4id004380;
 Fri, 27 Mar 2026 15:45:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2ftxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 15:45:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RFj9G719726950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 15:45:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6750358059;
 Fri, 27 Mar 2026 15:45:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C124458043;
 Fri, 27 Mar 2026 15:45:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 15:45:08 +0000 (GMT)
Message-ID: <d7f6f5e3-678a-4a63-8031-1af2cfd2c7a2@linux.ibm.com>
Date: Fri, 27 Mar 2026 11:45:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/tpm: add PPI support to tpm-tis-device on ARM64
 virt
To: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, pierrick.bouvier@linaro.org,
 "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, mohamed@unpredictable.fr
References: <20260327-tpm-tis-sysbus-ppi-v2-0-d8ec84d25dbc@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260327-tpm-tis-sysbus-ppi-v2-0-d8ec84d25dbc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: HLsyd3Ki921vcgbWuouM2jLuh2HZ8WR7
X-Proofpoint-ORIG-GUID: Uxrw_TXDaLtWThQfdRJwcFb8ilGEsUPP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfXx53LsWG6Klwt
 15H3rRs7KaWSKg4glzqu73nQFupUhciupjQrpIv6YXRys6+PTJikkVKF2I8Zs4H36y4bI+KK2yq
 7D4u0gaVxND6hz+o0Q1tK9GlWyUZ37FElk7wzuQA2yMEoEuA7qPei80n4iGX1Lz9sCiqNa7eNIU
 u64G1XWEGWuCQizEkSMNoq1T2A+EANqv/dxzAEvkosSxAGX7hQQ1qtre6B3FpN6ql2LvsZALj9g
 kFb6zwsQ2TOJw+tkizVt6VKs7VwlXPtpk9q21+YHFKXvw9mhJ58kHG3xLzOUG01w5YMvh5yx/Vr
 Sgj0tX/48k8jIaUeJGPTY/cCiUrTN72LZQdINEN9O0bubxfMHg/iQdCZqGXZLc+TUJEtmBooN6O
 tqPr+Qm3PBgPuxbZKfQ24ujpCRKDBw1LgW9ChSNZfqgSOTaleqIZoIXAkUG8z2t0cFgav6T4OwZ
 TBwPUSyWWUlsdgHRQZA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c6a607 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=YbwBeHEdGhttwI7CrDAA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/27/26 7:48 AM, Mohammadfaiz Bawa wrote:
> The ARM virt machine's tpm-tis-device lacks Physical Presence Interface
> (PPI) support - no _DSM, _STA, or PPI operation regions in the ACPI
> namespace. This causes Windows 11 ARM64 guests to log Event ID 15
> (tpm.sys) errors per boot.
> 
> This series documents the change, refactors tpm_build_ppi_acpi() to
> accept a dynamic PPI base address, then wires up PPI MMIO and ACPI
> on tpm-tis-sysbus via the platform bus.
> 
> Tested: aarch64 KVM, upstream QEMU, Win11 ARM64 25H2, swtpm.
> Event ID 15 eliminated.
> 
> Changes in v2:
> - Moved tpm.rst documentation hunk from patch 3 into patch 1 (Stefan)
> - Added Reviewed-by tags
> 
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
> Mohammadfaiz Bawa (3):
>        docs/specs/tpm: document PPI support on ARM64 virt
>        hw/acpi/tpm: parameterize PPI base address in tpm_build_ppi_acpi
>        hw/tpm: add PPI support to tpm-tis-device for ARM64 virt
> 
>   docs/specs/tpm.rst       | 24 ++++++++++++++++++++++++
>   hw/acpi/tpm.c            |  8 ++++----
>   hw/arm/virt-acpi-build.c |  9 ++++++++-
>   hw/tpm/tpm_tis_isa.c     |  2 +-
>   hw/tpm/tpm_tis_sysbus.c  | 11 +++++++++++
>   include/hw/acpi/tpm.h    |  3 ++-
>   6 files changed, 50 insertions(+), 7 deletions(-)
> ---
> base-commit: 8e711856d7639cbffa51405f2cc2366e3d9e3a23
> change-id: 20260324-tpm-tis-sysbus-ppi-ef31a7d71753

Does this branch contain this series here:

https://lore.kernel.org/qemu-devel/20260317120241.16320-1-philmd@linaro.org/

A patch in this series changed TPMState to not have ppi_enabled anymore:

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 184632ff66..1531620bf9 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -75,7 +75,6 @@ typedef struct TPMState {

      size_t be_buffer_size;

-    bool ppi_enabled;
      TPMPPI ppi;
  } TPMState;



> 
> Best regards,


