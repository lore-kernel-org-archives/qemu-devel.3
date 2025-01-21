Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A68C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 03:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta4hD-0006qh-JW; Mon, 20 Jan 2025 22:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ta4hC-0006qJ-8k
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 22:12:54 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ta4hA-00008p-Jp
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 22:12:54 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E72C74E6036;
 Tue, 21 Jan 2025 04:12:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XHEedFgYFJsH; Tue, 21 Jan 2025 04:12:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E5A814E6001; Tue, 21 Jan 2025 04:12:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E334074577C;
 Tue, 21 Jan 2025 04:12:48 +0100 (CET)
Date: Tue, 21 Jan 2025 04:12:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Tao Su <tao1.su@linux.intel.com>
cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com, 
 xiaoyao.li@intel.com, zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 4/4] docs: Add GNR, SRF and CWF CPU models
In-Reply-To: <20250121020650.1899618-5-tao1.su@linux.intel.com>
Message-ID: <a945e893-8d27-b1a3-3f3e-d9b04080c70d@eik.bme.hu>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-5-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 21 Jan 2025, Tao Su wrote:
> Update GraniteRapids, SierraForest and ClearwaterForest CPU models in
> section "Preferred CPU models for Intel x86 hosts".
>
> Also introduce bhi-no, gds-no and rfds-no in doc.
>
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
> docs/system/cpu-models-x86.rst.inc | 42 ++++++++++++++++++++++++++++++
> 1 file changed, 42 insertions(+)
>
> diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
> index ba27b5683f..f0b5189d91 100644
> --- a/docs/system/cpu-models-x86.rst.inc
> +++ b/docs/system/cpu-models-x86.rst.inc
> @@ -71,6 +71,16 @@ mixture of host CPU models between machines, if live migration
> compatibility is required, use the newest CPU model that is compatible
> across all desired hosts.
>
> +``ClearwaterForest``
> +    Intel Xeon Processor (ClearwaterForest, 2025)
> +
> +``SierraForest``, ``SierraForest-v2``
> +    Intel Xeon Processor (SierraForest, 2024), SierraForest-v2 matigates

Typo, do you mean "mitigates"?

Regards,
BALATON Zoltan

> +    the GDS and RFDS vulnerabilities with stepping 3.
> +
> +``GraniteRapids``, ``GraniteRapids-v2``
> +    Intel Xeon Processor (GraniteRapids, 2024)
> +
> ``Cascadelake-Server``, ``Cascadelake-Server-noTSX``
>     Intel Xeon Processor (Cascade Lake, 2019), with "stepping" levels 6
>     or 7 only.  (The Cascade Lake Xeon processor with *stepping 5 is
> @@ -223,6 +233,38 @@ features are included if using "Host passthrough" or "Host model".
>   ``/sys/devices/system/cpu/vulnerabilities/tsx_async_abort`` file in
>   the guest should report ``Mitigation: TSX disabled``.
>
> +``bhi-no``
> +  Recommended to inform that the guest that the host is ``not``
> +  vulnerable to CVE-2022-0001, Branch History Injection (BHI).
> +
> +  This too is an MSR feature, so it does not show up in the Linux
> +  ``/proc/cpuinfo`` in the host or guest.
> +
> +  It should only be enabled for VMs if the host reports
> +  ``BHI: Not affected`` in the
> +  ``/sys/devices/system/cpu/vulnerabilities/spectre_v2`` file.
> +
> +``gds-no``
> +  Recommended to inform that the guest that the host is ``not``
> +  vulnerable to CVE-2022-40982, Gather Data Sampling (GDS).
> +
> +  This too is an MSR feature, so it does not show up in the Linux
> +  ``/proc/cpuinfo`` in the host or guest.
> +
> +  It should only be enabled for VMs if the host reports ``Not affected``
> +  in the ``/sys/devices/system/cpu/vulnerabilities/gather_data_sampling``
> +  file.
> +
> +``rfds-no``
> +  Recommended to inform that the guest that the host is ``not``
> +  vulnerable to CVE-2023-28746, Register File Data Sampling (RFDS).
> +
> +  This too is an MSR feature, so it does not show up in the Linux
> +  ``/proc/cpuinfo`` in the host or guest.
> +
> +  It should only be enabled for VMs if the host reports ``Not affected``
> +  in the ``/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling``
> +  file.
>
> Preferred CPU models for AMD x86 hosts
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>

