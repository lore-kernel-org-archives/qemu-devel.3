Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFB7CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 16:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQSPW-0000zb-MK; Fri, 22 May 2026 12:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQSPU-0000z8-Nq
 for qemu-devel@nongnu.org; Fri, 22 May 2026 12:07:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQSPR-0007lR-5e
 for qemu-devel@nongnu.org; Fri, 22 May 2026 12:07:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M9vQ6r312987
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MiJmzAXAUfy4HBltJR+iQJtydgxzRUZxuvYy6Ya9gLQ=; b=V+2I/vfqxusUxM0w
 lBW4eeqXW9PUS5wgv1yRTo4NEa4b+Qw6Sk7e5s5KvYOuh/tS9H8hDuHPB9/xpXI4
 HQCGcNl4ySt/Q3tW3cl81xrtp4YXz6fs7Zbk+XvRZm5DogU7R++8nuNd7c+Q9Xe0
 K6GkdF2nbnhHwLyIv75qaJVE3s0ezm+zf/HYF4tfIcWhy2M+9IxIEE7TK76Wna6o
 IEwH27fiqKYYkd9Yc3x1W6fb5FrtBvAkZKm8q1gMvgY7pAar+sCl/eBJzpmKqHU3
 t85EHD8xpe4tALsOcFxXKqIO/OFFc/puHJ8Imh3neIIJjiZzcQQId0Ad4+fmnDgI
 SSTDWg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea8834nkq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:07:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3041ab826ddso5376010eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779466054; x=1780070854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MiJmzAXAUfy4HBltJR+iQJtydgxzRUZxuvYy6Ya9gLQ=;
 b=aXlTg8xx/399fK3OAdfBQZw/HaoHAByKShnVwRmn1I03hptCaYgf2zbL7ZaEe6va2O
 mjs+h8nkxtBgmgkGWG254t+nDl08NzbOG0jFRwjoFNthremrNqQFqKVAEb0jENla7XbB
 N2VjclbyiGzHmu8TsM24fjGnSR4sJUo9llfi0tClbC8miyDD8/g6R22PnQs7p7VPheBF
 74+nwV2nhJScH0QEJBxjr1pVBo56jBZwuOT5cNkZUXuJTlj7LqaUxRdz8lKb7bvk04M1
 aO2EiZzndhFy35kaIFUhckAKFUrQydLKe2kiAlBMOwkNTLlJmSpikAxtimgQY6x3r8wh
 qSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779466054; x=1780070854;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MiJmzAXAUfy4HBltJR+iQJtydgxzRUZxuvYy6Ya9gLQ=;
 b=maEJksdZxQpW1AGzJyxky2XE8hVw8tn/3hMlHXS7AikpnKm22X8p7pLcnJOmxZOqhC
 QaLR/RNMOCc3CoCgE3hjm+XvFREOHSCKafmwGN4wjXaP5LbBdpVx6UT96uLIkAdpk4ge
 VsPWv7zZmL6wm5pvRibOLrq9xpeOndKARBvMz6F1/chR8RxgOxVyx5a3i1thWYy89xpN
 G+rftMN07sW65woviTATZ5h6s0+KYfzrwMXyy+vOn/LdcmkCe3wQDdsMepz1qxrwMqHv
 rIAvkeoOQqLFAQuiagkGrvz3dChBAgPSCLQLv2gL4Aif4ZgWThm60UPEtKSKYYjO0jwf
 s8zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Bt+QUyoqVfuThISAtl/DDLrzfYJKFu755LLk9UcAfcKuW3LjcapvXFtjLQNcbWLi8NDuE+SZAjQGs@nongnu.org
X-Gm-Message-State: AOJu0YwIyitES6s6dL8DRfC6uXUJmWyDnlIm0VupVm37xzoQslIUuVrX
 tqGbDtELNB9NMPFMHPc8i+wU3vVdXbTg6xOhcYDELbNpOV2Ajuh0NK7bmwUHkvq3scMYIkXQMVU
 7O4pwlXElmIIJje3sPpSKOQdjRRNZvO+zjcLgpwb9oWFkLzNHdH5OeycIIQ==
X-Gm-Gg: Acq92OFi6LCvWpLd7QZfFG/oy6EE5Speo8G7yFYRAn0ZVDsSljWRgiuKa89Q3dGLyuf
 3J3ItrTZoZtEKZ8Zw9m2GoeGBGd1nn0INPyDIT1o4o0brrskiV1BNPKOhsHGLGkp/F8RSndIHUA
 TbAL+9DR5lLWzNkstaj3loNdC5dslcO1epb+oW5CQvHqTf1+d7LQB86rvvv08jSz4QwakN6QCNq
 7FOx9BmuCPsPcFfrYhsnh/BmKaXKSbnFSDQmAbkhmTKU3xI46a6PUJjYgMFwmpxSOZ3+DOZ3yFw
 wRJC6V9cqfVwlAtmdXJ/+dT4xM4C/R10fCew9Kju6NM4yfj8f1G9riuac0TrDQgjjZN2VaIubD7
 iXcZABAOEVSgQITejp4Sf/L785Xm5Moy371M/C/4cjMqtH7VAjK0vP1ZEnYBYIUXwkYDIiMBKK7
 HvhL6oDw3/uy+zOA==
X-Received: by 2002:a05:7301:11af:b0:304:5a9c:6479 with SMTP id
 5a478bee46e88-3045a9c6ba4mr563701eec.9.1779466053967; 
 Fri, 22 May 2026 09:07:33 -0700 (PDT)
X-Received: by 2002:a05:7301:11af:b0:304:5a9c:6479 with SMTP id
 5a478bee46e88-3045a9c6ba4mr563688eec.9.1779466053312; 
 Fri, 22 May 2026 09:07:33 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f3feadsm1691642eec.13.2026.05.22.09.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 09:07:31 -0700 (PDT)
Message-ID: <e08dbd19-f72a-4d40-8720-0306582d9399@oss.qualcomm.com>
Date: Fri, 22 May 2026 09:07:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] ppc/spapr: Split VFIO code and refactor EEH
 interface
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com, philmd@linaro.org
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
 <20260520095446.64206-6-nnmlinux@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260520095446.64206-6-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE2MSBTYWx0ZWRfX7EQPJlocFvCo
 CsubS8H2VMoFPXt1qH1QsaHJK6gRH8R0qiJ5ikM0kDdqVmgRDBCL23lBgrfTR2SCFGBbs7F/CD9
 p1fv3inxuII/H6BgoCYtUX4kjRLZhnJNkGThwIcnH0zKf9f99K4wXZRlFPwI4/183JbW8sUjvgA
 1vVqOMaW/ff599Yk6aWzrSEnMc9o7XSduGhTzL8ryzRQImEvQDekSjyJd57+EXdz1L8Ee4lXRUs
 IhADOM3EMO4fipzrvc/NabJl1rO+i/2QazjuC1fTCfm/+bkibIj5S9THxO8HebuwPc2yLqBLEOT
 8t0FgAwxltZZRqLiZ4RAcqsyEr/dJh+YzGx+RgFOcxkM6jn68ei2AdEiVAMn8/sCnLWgNJnKBch
 EKXZlGZHIeHrgdUlTiYUz6DZcq/txldAtf8F2jU5LdACcTCn/quIQ3+j8qEIHtdF6N139YjDwDK
 9DLfMlkFYJCvoHPpvCw==
X-Proofpoint-GUID: R3vrzSKx88xmQ1LlzFRMSDUaLd4TonWb
X-Proofpoint-ORIG-GUID: R3vrzSKx88xmQ1LlzFRMSDUaLd4TonWb
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a107f47 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=1OQNpWm9ZLux6AqFIWUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220161
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/20/2026 2:54 AM, Narayana Murty N wrote:
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
>  hw/ppc/spapr_pci.c           |   1 +
>  hw/ppc/spapr_pci_vfio.c      | 367 +----------------------------------
>  hw/ppc/spapr_pci_vfio_eeh.c  | 346 +++++++++++++++++++++++++++++++++
>  include/hw/pci-host/spapr.h  |  44 +----
>  include/hw/ppc/spapr_vfio.h  |  28 +++
>  stubs/meson.build            |   1 +
>  stubs/spapr_phb_vfio-stubs.c |  52 +++++
>  9 files changed, 432 insertions(+), 410 deletions(-)
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
> index f08f21f03c..576b92229b 100644
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
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index ed0b22a84a..2207654d83 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -22,119 +22,11 @@
>  #include <linux/vfio.h>
>  #include "hw/ppc/spapr.h"
>  #include "hw/pci-host/spapr.h"
> +#include "hw/ppc/spapr_vfio.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pci_device.h"
>  #include "hw/vfio/vfio-container-legacy.h"
>  #include "qemu/error-report.h"
> -#include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
> -
> -/*
> - * Interfaces for IBM EEH (Enhanced Error Handling)
> - */
> -#ifdef CONFIG_VFIO_PCI
> -static bool vfio_eeh_container_ok(VFIOLegacyContainer *container)
> -{
> -    /*
> -     * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
> -     * implementation is broken if there are multiple groups in a
> -     * container.  The hardware works in units of Partitionable
> -     * Endpoints (== IOMMU groups) and the EEH operations naively
> -     * iterate across all groups in the container, without any logic
> -     * to make sure the groups have their state synchronized.  For
> -     * certain operations (ENABLE) that might be ok, until an error
> -     * occurs, but for others (GET_STATE) it's clearly broken.
> -     */
> -
> -    /*
> -     * XXX Once fixed kernels exist, test for them here
> -     */
> -
> -    if (QLIST_EMPTY(&container->group_list)) {
> -        return false;
> -    }
> -
> -    if (QLIST_NEXT(QLIST_FIRST(&container->group_list), container_next)) {
> -        return false;
> -    }
> -
> -    return true;
> -}
> -
> -static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
> -{
> -    struct vfio_eeh_pe_op pe_op = {
> -        .argsz = sizeof(pe_op),
> -        .op = op,
> -    };
> -    int ret;
> -
> -    if (!vfio_eeh_container_ok(container)) {
> -        error_report("vfio/eeh: EEH_PE_OP 0x%x: "
> -                     "kernel requires a container with exactly one group", op);
> -        return -EPERM;
> -    }
> -
> -    ret = ioctl(container->fd, VFIO_EEH_PE_OP, &pe_op);
> -    if (ret < 0) {
> -        error_report("vfio/eeh: EEH_PE_OP 0x%x failed: %m", op);
> -        return -errno;
> -    }
> -
> -    return ret;
> -}
> -
> -static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
> -{
> -    VFIOAddressSpace *space = vfio_address_space_get(as);
> -    VFIOContainer *bcontainer = NULL;
> -
> -    if (QLIST_EMPTY(&space->containers)) {
> -        /* No containers to act on */
> -        goto out;
> -    }
> -
> -    bcontainer = QLIST_FIRST(&space->containers);
> -
> -    if (QLIST_NEXT(bcontainer, next)) {
> -        /*
> -         * We don't yet have logic to synchronize EEH state across
> -         * multiple containers
> -         */
> -        bcontainer = NULL;
> -        goto out;
> -    }
> -
> -out:
> -    vfio_address_space_put(space);
> -    return VFIO_IOMMU_LEGACY(bcontainer);
> -}
> -
> -static bool vfio_eeh_as_ok(AddressSpace *as)
> -{
> -    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
> -
> -    return (container != NULL) && vfio_eeh_container_ok(container);
> -}
> -
> -static int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
> -{
> -    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
> -
> -    if (!container) {
> -        return -ENODEV;
> -    }
> -    return vfio_eeh_container_op(container, op);
> -}
> -
> -bool spapr_phb_eeh_available(SpaprPhbState *sphb)
> -{
> -    return vfio_eeh_as_ok(&sphb->iommu_as);
> -}
> -
> -static void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
> -{
> -    vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_ENABLE);
> -}
>  
>  void spapr_phb_vfio_reset(DeviceState *qdev)
>  {
> @@ -146,260 +38,3 @@ void spapr_phb_vfio_reset(DeviceState *qdev)
>       */
>      spapr_phb_vfio_eeh_reenable(SPAPR_PCI_HOST_BRIDGE(qdev));
>  }
> -
> -static void spapr_eeh_pci_find_device(PCIBus *bus, PCIDevice *pdev,
> -                                      void *opaque)
> -{
> -    bool *found = opaque;
> -
> -    if (object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
> -        *found = true;
> -    }
> -}
> -
> -int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
> -                                  unsigned int addr, int option)
> -{
> -    uint32_t op;
> -    int ret;
> -
> -    switch (option) {
> -    case RTAS_EEH_DISABLE:
> -        op = VFIO_EEH_PE_DISABLE;
> -        break;
> -    case RTAS_EEH_ENABLE: {
> -        PCIHostState *phb;
> -        bool found = false;
> -
> -        /*
> -         * The EEH functionality is enabled per sphb level instead of
> -         * per PCI device. We have already identified this specific sphb
> -         * based on buid passed as argument to ibm,set-eeh-option rtas
> -         * call. Now we just need to check the validity of the PCI
> -         * pass-through devices (vfio-pci) under this sphb bus.
> -         * We have already validated that all the devices under this sphb
> -         * are from same iommu group (within same PE) before coming here.
> -         *
> -         * Prior to linux commit 98ba956f6a389 ("powerpc/pseries/eeh:
> -         * Rework device EEH PE determination") kernel would call
> -         * eeh-set-option for each device in the PE using the device's
> -         * config_address as the argument rather than the PE address.
> -         * Hence if we check validity of supplied config_addr whether
> -         * it matches to this PHB will cause issues with older kernel
> -         * versions v5.9 and older. If we return an error from
> -         * eeh-set-option when the argument isn't a valid PE address
> -         * then older kernels (v5.9 and older) will interpret that as
> -         * EEH not being supported.
> -         */
> -        phb = PCI_HOST_BRIDGE(sphb);
> -        pci_for_each_device(phb->bus, (addr >> 16) & 0xFF,
> -                            spapr_eeh_pci_find_device, &found);
> -
> -        if (!found) {
> -            return RTAS_OUT_PARAM_ERROR;
> -        }
> -
> -        op = VFIO_EEH_PE_ENABLE;
> -        break;
> -    }
> -    case RTAS_EEH_THAW_IO:
> -        op = VFIO_EEH_PE_UNFREEZE_IO;
> -        break;
> -    case RTAS_EEH_THAW_DMA:
> -        op = VFIO_EEH_PE_UNFREEZE_DMA;
> -        break;
> -    default:
> -        return RTAS_OUT_PARAM_ERROR;
> -    }
> -
> -    ret = vfio_eeh_as_op(&sphb->iommu_as, op);
> -    if (ret < 0) {
> -        return RTAS_OUT_HW_ERROR;
> -    }
> -
> -    return RTAS_OUT_SUCCESS;
> -}
> -
> -int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
> -{
> -    int ret;
> -
> -    ret = vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_GET_STATE);
> -    if (ret < 0) {
> -        return RTAS_OUT_PARAM_ERROR;
> -    }
> -
> -    *state = ret;
> -    return RTAS_OUT_SUCCESS;
> -}
> -
> -static void spapr_phb_vfio_eeh_clear_dev_msix(PCIBus *bus,
> -                                              PCIDevice *pdev,
> -                                              void *opaque)
> -{
> -    /* Check if the device is VFIO PCI device */
> -    if (!object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
> -        return;
> -    }
> -
> -    /*
> -     * The MSIx table will be cleaned out by reset. We need
> -     * disable it so that it can be reenabled properly. Also,
> -     * the cached MSIx table should be cleared as it's not
> -     * reflecting the contents in hardware.
> -     */
> -    if (msix_enabled(pdev)) {
> -        uint16_t flags;
> -
> -        flags = pci_host_config_read_common(pdev,
> -                                            pdev->msix_cap + PCI_MSIX_FLAGS,
> -                                            pci_config_size(pdev), 2);
> -        flags &= ~PCI_MSIX_FLAGS_ENABLE;
> -        pci_host_config_write_common(pdev,
> -                                     pdev->msix_cap + PCI_MSIX_FLAGS,
> -                                     pci_config_size(pdev), flags, 2);
> -    }
> -
> -    msix_reset(pdev);
> -}
> -
> -static void spapr_phb_vfio_eeh_clear_bus_msix(PCIBus *bus, void *opaque)
> -{
> -       pci_for_each_device_under_bus(bus, spapr_phb_vfio_eeh_clear_dev_msix,
> -                                     NULL);
> -}
> -
> -static void spapr_phb_vfio_eeh_pre_reset(SpaprPhbState *sphb)
> -{
> -       PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
> -
> -       pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_clear_bus_msix, NULL);
> -}
> -
> -int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
> -{
> -    uint32_t op;
> -    int ret;
> -
> -    switch (option) {
> -    case RTAS_SLOT_RESET_DEACTIVATE:
> -        op = VFIO_EEH_PE_RESET_DEACTIVATE;
> -        break;
> -    case RTAS_SLOT_RESET_HOT:
> -        spapr_phb_vfio_eeh_pre_reset(sphb);
> -        op = VFIO_EEH_PE_RESET_HOT;
> -        break;
> -    case RTAS_SLOT_RESET_FUNDAMENTAL:
> -        spapr_phb_vfio_eeh_pre_reset(sphb);
> -        op = VFIO_EEH_PE_RESET_FUNDAMENTAL;
> -        break;
> -    default:
> -        return RTAS_OUT_PARAM_ERROR;
> -    }
> -
> -    ret = vfio_eeh_as_op(&sphb->iommu_as, op);
> -    if (ret < 0) {
> -        return RTAS_OUT_HW_ERROR;
> -    }
> -
> -    return RTAS_OUT_SUCCESS;
> -}
> -
> -int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
> -{
> -    int ret;
> -
> -    ret = vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_CONFIGURE);
> -    if (ret < 0) {
> -        return RTAS_OUT_PARAM_ERROR;
> -    }
> -
> -    return RTAS_OUT_SUCCESS;
> -}
> -
> -int spapr_phb_vfio_errinjct(SpaprPhbState *sphb,
> -                            uint32_t func, uint64_t addr,
> -                            uint64_t mask, uint32_t type)
> -{
> -    VFIOLegacyContainer *container = vfio_eeh_as_container(&sphb->iommu_as);
> -    struct vfio_eeh_pe_op op = {
> -        .op = VFIO_EEH_PE_INJECT_ERR,
> -        .argsz = sizeof(op),
> -    };
> -
> -    /* Set error type, address, and mask */
> -    op.err.type = type;
> -    op.err.addr = addr;
> -    op.err.mask = mask;
> -
> -    /* Validate and set function code */
> -    switch (func) {
> -    case EEH_ERR_FUNC_LD_MEM_ADDR:
> -    case EEH_ERR_FUNC_LD_MEM_DATA:
> -    case EEH_ERR_FUNC_LD_IO_ADDR:
> -    case EEH_ERR_FUNC_LD_IO_DATA:
> -    case EEH_ERR_FUNC_LD_CFG_ADDR:
> -    case EEH_ERR_FUNC_LD_CFG_DATA:
> -    case EEH_ERR_FUNC_ST_MEM_ADDR:
> -    case EEH_ERR_FUNC_ST_MEM_DATA:
> -    case EEH_ERR_FUNC_ST_IO_ADDR:
> -    case EEH_ERR_FUNC_ST_IO_DATA:
> -    case EEH_ERR_FUNC_ST_CFG_ADDR:
> -    case EEH_ERR_FUNC_ST_CFG_DATA:
> -    case EEH_ERR_FUNC_DMA_RD_ADDR:
> -    case EEH_ERR_FUNC_DMA_RD_DATA:
> -    case EEH_ERR_FUNC_DMA_RD_MASTER:
> -    case EEH_ERR_FUNC_DMA_RD_TARGET:
> -    case EEH_ERR_FUNC_DMA_WR_ADDR:
> -    case EEH_ERR_FUNC_DMA_WR_DATA:
> -    case EEH_ERR_FUNC_DMA_WR_MASTER:
> -        op.err.func = func;
> -        break;
> -    default:
> -        return RTAS_OUT_PARAM_ERROR;
> -    }
> -
> -    /* Perform the ioctl to inject the error */
> -    if (ioctl(container->fd, VFIO_EEH_PE_OP, &op) < 0) {
> -        return RTAS_OUT_HW_ERROR;
> -    }
> -
> -    return RTAS_OUT_SUCCESS;
> -}
> -#else
> -
> -bool spapr_phb_eeh_available(SpaprPhbState *sphb)
> -{
> -    return false;
> -}
> -
> -void spapr_phb_vfio_reset(DeviceState *qdev)
> -{
> -}
> -
> -int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
> -                                  unsigned int addr, int option)
> -{
> -    return RTAS_OUT_NOT_SUPPORTED;
> -}
> -
> -int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
> -{
> -    return RTAS_OUT_NOT_SUPPORTED;
> -}
> -
> -int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
> -{
> -    return RTAS_OUT_NOT_SUPPORTED;
> -}
> -
> -int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
> -{
> -    return RTAS_OUT_NOT_SUPPORTED;
> -}
> -
> -int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, int option)
> -{
> -    return RTAS_OUT_NOT_SUPPORTED;
> -}
> -#endif /* CONFIG_VFIO_PCI */
> diff --git a/hw/ppc/spapr_pci_vfio_eeh.c b/hw/ppc/spapr_pci_vfio_eeh.c
> new file mode 100644
> index 0000000000..6d07ae50c5
> --- /dev/null
> +++ b/hw/ppc/spapr_pci_vfio_eeh.c
> @@ -0,0 +1,346 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/*
> + * QEMU sPAPR PCI VFIO EEH support
> + */
> +
> +#include "qemu/osdep.h"
> +#include <sys/ioctl.h>
> +#include <linux/vfio.h>
> +#include "hw/ppc/spapr.h"
> +#include "hw/pci-host/spapr.h"
> +#include "hw/ppc/spapr_vfio.h"
> +#include "hw/pci/msix.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/vfio/vfio-container-legacy.h"
> +#include "qemu/error-report.h"
> +#include CONFIG_DEVICES /* CONFIG_VFIO_PCI */

This include can now be removed, since associated ifdefs were already
removed.

With that,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Also, build was correctly fixed and series passes all tests also.👍
https://github.com/p-b-o/qemu-ci/actions/runs/26162641798

Regards,
Pierrick

