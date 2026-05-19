Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B71CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLjl-0003Vo-Co; Tue, 19 May 2026 10:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLji-0003En-BY
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:47:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLjf-0008Bj-Nt
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:47:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JCZqRV1395972
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NmUdXoM5hJiNmGKxhDGdvhPop8Ik0wI4wsQkTnWVgCM=; b=Tp3JAHJTCaJuSpF9
 b9pi0N2c2/XPZYAJSWp/hqWyLiMENrA05EMkc3Gb2X9Go1U974MfISmKdjMlJnW5
 rFNFlU1yuChhPDRSskX+4SwnsFPmCvYvC8ehaa2wchEAgyyIl4DG67s5JPs4a+hh
 phgMTXrzwMzI6dsUzgorUtEIOemkKOonU+XFjZ+8CaQRYzYeZv3LdPo9RGOz+OaY
 9pibrZfgQRghtKsrxEY0Xrr1CZnbXBIFfOt3G8gV36tOHLtUpEqZiSETiBBeM1Ld
 AHoP7p2+sJF3ORgObMekCtH0W1021Qamna8WBK/T0uT8OWyEZu2bszB6Bx+glSNt
 xnp5jA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8r0q0jr4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:47:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so3792363eec.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779202073; x=1779806873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NmUdXoM5hJiNmGKxhDGdvhPop8Ik0wI4wsQkTnWVgCM=;
 b=BzqgDELrbcVoOHV54RIedQ3HcU0vlxxnNk/QPgEpC04fKOBIcgQktv2RlWY5gevTog
 gwqgVNAtrXwozbo0f8dqC7j/SZH+qJSg36u0t9iXG6lZ3OyYnclbX3Q5Uo8IjY41fh/k
 6AKt6+ipL5x8+t6v+Okb0eIt1HzX+XcVwPnxfTOj6WW/LJDdua+iOcFNlus/PII/IYS/
 j6NGzhZT0KmDUzani8xSSnYme0ouKXSOfWIaDtpKkdxhF6k6p3yZbL0y91hIotJ5X4RJ
 +c5hDy+RZVthkdc+DMWLhbid9yNaqqY67ZE13avX9vyoWvqHuRjAqZwF8uF5IS2bOEnE
 LDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202073; x=1779806873;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmUdXoM5hJiNmGKxhDGdvhPop8Ik0wI4wsQkTnWVgCM=;
 b=oiqcLN2d0pq/oGhMmH7mX07UTcablatFx2CHHEpUGFUZf1ZcsQQnD6WEJ0a+qIHCLh
 Zv44uEVr/EAf0HoRfJpGiIWfk7zcXCT8ym3jQ5yBUHnzPmY2pSxv0wnMsC6OXsIXLoP9
 I62mc7eP/yuj3OgsJxSMvS/jwxPXCTtUvz9khd6C7q0YU6/iIdY/Q1irScdy1yKLRwbP
 P7z3HskKTYpBrU3KzIKXsMwzTmL2ssWCdMQVnV8+h+wJ4wKqRsfbsG7xKMmYI/cea5nQ
 ttNHyKy3H4wzdQDA+VnHhVpd4i5pkAeJSWaJkIr5zhqte/Mljx5l03u+hIQmjfnA2oR0
 biCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8AKURhm6p6wu57wYxr2DNY/LjegrSRxMr2RVt2VshSzqrhRoylkBIltpcy3eRFvGZgKN6Z1BrdBAI+@nongnu.org
X-Gm-Message-State: AOJu0Yw+0WrlGZT/hKogoi4Ptxr5PeCqoRkgZ0beicKO0Z4PfP0/PeIP
 61dSDvo1f72/2baBom7rpgIL6PHKxWI0qm3BRjFSXK4nWzwyyOpOSKpzIEQN+G9lj6sXjGQWR8d
 A3eZLPU9zD1OLICWwGpjE/OXUEviC4KXagZcWy6ZlX5ZkM1qp9aZxlihr9w==
X-Gm-Gg: Acq92OGUfjHLSOWnITSwSIgOEVqXxLYCBmOR7R5MCQOn9wmmsp6FmEiguNiTCP9c1Hf
 NOh1XAvxPQnkUkuIe+nt7WKxvB0uHo+xTWNO91a0lERYaplWqiZv0p9DhIZXvNXIUHR9tpjPPDk
 RgHTjjIutYPSD8yf2Q7MUDeqi2qssQXcocyyRBQ1FgtcX0bEtCjvqLl8B20iMgisJqMduNkgZF4
 E7PmaarZRxupNtTRfMHLTWHI6EUj92evJ8gc1SlI76DIxOrzWhr5vOJ/TEtkdSym5RFE1L6S4Vf
 4spf194B1Hsns+Wn9c+u2Yi3NVPzd+725Q5GWaGN5RYKENeaY3hlgPwMkERVDVnCC7tMueGZIGT
 citWe01eLNf2ztClTxzrQNl9N4oaDtdX+Keq1VuVUwtKX5dpGeOQvakck/SGtpKJTsg==
X-Received: by 2002:a05:7300:a907:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-3039818eec3mr8002448eec.2.1779202073270; 
 Tue, 19 May 2026 07:47:53 -0700 (PDT)
X-Received: by 2002:a05:7300:a907:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-3039818eec3mr8002416eec.2.1779202072629; 
 Tue, 19 May 2026 07:47:52 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978b3cb2sm20972068eec.30.2026.05.19.07.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:47:52 -0700 (PDT)
Message-ID: <60d9c0da-cf4b-4210-8a54-743bb4e767be@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:47:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] ppc/spapr: Split VFIO code and refactor EEH
 interface
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com, philmd@linaro.org
References: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
 <20260519103325.8056-6-nnmlinux@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260519103325.8056-6-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0NyBTYWx0ZWRfXyMGbm+aaONEI
 JtwM/zM1t2DpCmb/UUXBP6rZqYgo9rig7EsmaWQFLjbhM2BmldC7SlcWhLKx4rOEiuM7G8sKjbn
 RuKBSLO65rBE0CtG0DY3m1hPSBZYMGgu9RHyC0BKAVfn568DnuXQWv0rG2dmHpWsU//4BrO+Epk
 jMdWwXUOLsrR4NUymmyVLmmv2cMoWwp4ljFuOvQIG7QqBZP6VoAQ0qbuILnCZRXVP2Zffpb6HyH
 6vuaGydWD//pY6lWWKg2C/k4Pw3sAx7BhHIrp4NpguZMfaIhQCWkdRVz4ft7ivx3Wjek2QjNyN2
 WJ7fCTTkxDrQft0oEsAcmncFWntzExsCpm63tg9Q9SmNLvY3s+I78uge0q1aETw1Qxnko7Tzna1
 FHNKPonpRyQQbCq7RbyKa5+xmzWymYzgwe/DvH7VeIFsIzBEcoe3UZhj7XruyEDQCaIlaFjg6yb
 KpqtlD3TyCrvSAoLYbA==
X-Proofpoint-GUID: Z7hWvwnLQrZRd7tO7vuh54goc5V0x8Xn
X-Authority-Analysis: v=2.4 cv=Q6/iJY2a c=1 sm=1 tr=0 ts=6a0c781a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=Lz787Td67pY25gv-1WgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Z7hWvwnLQrZRd7tO7vuh54goc5V0x8Xn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190147
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/19/2026 5:33 AM, Narayana Murty N wrote:
> Split spapr_pci_vfio.c into two files to separate concerns:
> - spapr_pci_vfio.c: Contains general VFIO routines
> - spapr_pci_vfio_eeh.c: Contains EEH-specific routines
> 
> Additionally, consolidate VFIO EEH function declarations into a new
> header file (spapr_vfio.h) to improve modularity and reduce header
> dependencies.
> 
> Changes:
> - Split VFIO functionality: keep general VFIO routines in
>   spapr_pci_vfio.c and move EEH routines to spapr_pci_vfio_eeh.c
> - Created include/hw/ppc/spapr_vfio.h with forward declarations
>   to avoid pulling in full spapr headers and libfdt dependencies
> - Introduced stubs/spapr_pci_vfio-stubs.c to consolidate all VFIO,
>   VFIO EEH stub functions in one place
> - Updated hw/ppc/spapr_pci.c to include new spapr_vfio.h header
> - Updated stubs/meson.build to reference new stub file
> 
> This improves code organization by separating VFIO and EEH concerns,
> and enhances build system modularity by making it easier to maintain
> VFIO-related code separately from core sPAPR PCI code.
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  hw/ppc/Kconfig               |   2 +-
>  hw/ppc/meson.build           |   1 +
>  hw/ppc/spapr_pci.c           |   3 +-
>  hw/ppc/spapr_pci_vfio.c      | 367 +----------------------------------
>  hw/ppc/spapr_pci_vfio_eeh.c  | 346 +++++++++++++++++++++++++++++++++
>  include/hw/pci-host/spapr.h  |  44 +----
>  include/hw/ppc/spapr_vfio.h  |  28 +++
>  stubs/meson.build            |   1 +
>  stubs/spapr_phb_vfio-stubs.c |  52 +++++
>  9 files changed, 433 insertions(+), 411 deletions(-)
>  create mode 100644 hw/ppc/spapr_pci_vfio_eeh.c
>  create mode 100644 include/hw/ppc/spapr_vfio.h
>  create mode 100644 stubs/spapr_phb_vfio-stubs.c
> 
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 347dcce690..1fb191fe83 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -6,7 +6,7 @@ config PSERIES
>      imply PCI_DEVICES
>      imply TEST_DEVICES
>      imply VIRTIO_VGA
> -    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c
> +    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c and spapr_pci_vfio_eeh.c
>      select NVDIMM
>      select DIMM
>      select PCI
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 37aa535db2..97e4be0dc9 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -36,6 +36,7 @@ ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
>  if host_os == 'linux'
>    ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
>      'spapr_pci_vfio.c',
> +    'spapr_pci_vfio_eeh.c',
>    ))
>  endif
>  
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index b00f71d92a..221d05e5c5 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -33,6 +33,7 @@
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pci_host.h"
>  #include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_vfio.h"
>  #include "hw/pci-host/spapr.h"
>  #include <libfdt.h>
>  #include "trace.h"
> @@ -718,7 +719,7 @@ static int parse_and_verify_recovered_special_event(target_ulong param_buf,
>  static int parse_and_verify_corrupted_page(target_ulong param_buf,
>                                             uint64_t *addr) {
>      *addr = ((uint64_t)rtas_ld(param_buf, 0) << 32) | rtas_ld(param_buf, 1);
> -    qemu_log("RTAS: corrupted-page: addr=0x%lx\n", *addr);
> +    qemu_log("RTAS: corrupted-page: addr=0x%llx\n", *addr);
>      return (*addr) ? RTAS_OUT_SUCCESS : RTAS_OUT_PARAM_ERROR;
>  }

See build failures for this change:
https://github.com/p-b-o/qemu-ci/actions/runs/26094993976
If we want to change something, the proper way is %"PRIx64".

...

Rest of the patch looks ok to me.

Regards,
Pierrick

