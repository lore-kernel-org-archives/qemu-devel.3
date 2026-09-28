Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0BBC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8D1-00054d-W8; Mon, 28 Sep 2026 06:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8D0-00054K-LM
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:03:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8Cy-0000jt-BZ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:03:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9Mm7m3879667
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1xSDbn3cZFdnXvdFkKOC/kwamch70uFmA2Vgi07Oy0Q=; b=e81E70sh/lim001w
 tLykIACfUSchFrYn0895EwbHVa+U9NYPGOocVuErKXnZ0fnidiL9yeVwIQPcBef4
 I/cAB4j8/15KP5dn/NJjR0K3KA+sD0QddjKE+VsD4z0JbLMKJ/cRzQ3jhFLfxqXT
 UhCaCETIJ8IusN9wJMfrYV6BbxcGlodZvkDFwWK6Uur1lbZa1uKZ0hQNujJb5qCS
 Cqkz1tp4XbZwxb7l4E8vQy43ALt4JdN3Yh2hchYaPqsWmzxwvf0We0EBlsxMmO84
 Jb+cCZuhvEC5aTPijDpaSULwOCihOspDDtJyN12pGgmBwSoj0nOT2tNQSsQZGYjC
 IVHN8g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jwgcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:03:38 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ce04f57aaeso107394e0c.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589817; x=1791194617; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1xSDbn3cZFdnXvdFkKOC/kwamch70uFmA2Vgi07Oy0Q=;
 b=hXonBXN4yC2NKobsGOUmXlUerpKpNCXxP4TpktG1hsXiqO0gNCAMVf3KzusSFlqDvi
 zpdWJb0kGRV2c/u7oYhnEASyffCxzW8/YpmSScgSW0SrKAiXxillyesxV1FltvgQUTBx
 1DcQiOe8WHhN/C+CRHAek8qTLYosGrjZSlZuOn2ef2+eCrVUTRbaIjnCUl9jWf7O2O7/
 wZdJ8XH1ZcA+oiqbOaeMDJeSg9apDVsCFkG7D4Uecfa9RqdTVUknxlegFzffXFRCVWf9
 lBmQeRn9CHVXW9Nfp8Cz0uqNyz+w7DWscmU7P4lbdGmPn8xH7Wp9YS+CjY6DQT5j3XFV
 6GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589817; x=1791194617;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1xSDbn3cZFdnXvdFkKOC/kwamch70uFmA2Vgi07Oy0Q=;
 b=xcZM8wIK1zd6h/pzY+Gx3hCFXrucNHtoMACHaHtqx9w0hZjW0ZYTrxlQuHi7CBXUAP
 LbESttI5FHjPy1oR+nHaNeWGuxnX8Ak5VDa/j7zUnQQ9x1yGPGFT1fGGM6FIYCUY14gw
 46bnAq3Y9IKHtmIZn4Ilt1f33UvyNS0B2L6pTRSZ76NV3A6ERkG9bUGj3cG6b2V7lAlj
 HRAsmQQVrRtWqY0fv/S1ODm3iWCbXDtzuQHccXiugfOcULn7rWvGzz+Cn+Av4+O0/cVh
 BSW1rS+NBEMbWPGv0XM1VLSDmhYuWpyc0luJjLu0U/CWnHq9e8B3M77iemsNnaZ+RxlM
 bqsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxD5hyWxxk4NdPDFFDaFrr+d84aa3xae/ubRWj2gIFnpCjOOMQfujV+LHLFmRELeYlKfKatA15DYdU5@nongnu.org
X-Gm-Message-State: AFq9FYJruIgdvbdWS6ak+6br9uQTJaWu1AxoXkFRMqnPzNQiPE9N5+hr
 aXGNBht8XKKnbBBNrLvnzBP10+qHMMe2on8kaTd2su0gwrU+th857O4qRRv2hui37iA/6AmKvrc
 y3NICy7jpS3nAvo7E5gDIwbyqi2pufR8i5CLJRCiVcF6/YqJ/4HmxOWtHMQ==
X-Gm-Gg: AYBFou0euBuJU9ifPXuNywPSQiwQ78llGcN4FZPeia/CCO1Lz/jlUb+khsrU5jJVkVV
 Rgpm3VuC2zP/xn8Ivbt/xMIP2+AVoA9NheXT6C5kvlreHL+gXptNvckYJ6oYmpGcIs2YAl1rxoq
 H2w7QdG6MUZ1aLTvtYmUAlwnjTo6AEsmPDKnHofK5HW8YRsqizmxZk7VMeIrL/0+ax8XtnZO0++
 Td9TBu4GjKs6Ozp1vpR5dI0EuyEJqaUHsb6P83J3hC4NnjtWljWx9NqWlnatWRh0JtxS7JoS1aV
 yLnoCFhkGfZcKaZq5IGcvLuobBGi48Kc4WIgoEZK74f0HTmG2urj132oaIKI2B+htRukedQaCer
 uSNqHOgNVCB5uMrhLAGfFPKiNxqlui3nzqA==
X-Received: by 2002:a05:6102:148c:b0:7b7:4b29:ffc with SMTP id
 ada2fe7eead31-7b74b298d0amr515806137.14.1790589817292; 
 Mon, 28 Sep 2026 03:03:37 -0700 (PDT)
X-Received: by 2002:a05:6102:148c:b0:7b7:4b29:ffc with SMTP id
 ada2fe7eead31-7b74b298d0amr515794137.14.1790589816773; 
 Mon, 28 Sep 2026 03:03:36 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff21d6209sm132228685e9.4.2026.09.28.03.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 03:03:36 -0700 (PDT)
Message-ID: <a28df37c-b0cf-45f8-9aca-d4cf9877b6ae@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:03:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/pci-bridge: split CXL PXB into separate file
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anisa Su <anisa.su@samsung.com>, Jonathan Cameron <jic23@kernel.org>
References: <20260928095646.3555447-1-berrange@redhat.com>
 <20260928095646.3555447-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260928095646.3555447-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX9HjmhyZKTE6/
 2NFIQs9rgASWNM6AJy7H/KSZNpn2NcESzAwO7htt8wOMIV1nUzuGTQB/R2TjLzEmF38ohp7MTOw
 BeEZrXAWWpaVkFPuojP+dYN3/tqpg10=
X-Proofpoint-GUID: 8Km6nos7RfGhKcx6NcddMnZ2lgKegXdJ
X-Proofpoint-ORIG-GUID: 8Km6nos7RfGhKcx6NcddMnZ2lgKegXdJ
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6aba3b7a cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=g-K3LgQ6wbbBXodtW58A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX7JRCNcHAwFz4
 Ekmpy8YdWGrIWjCOcjUPYRA2tSGZOgLEpLU4pjMPvTeEA2Q02nhuqzJSn65BYcC01UGlRI990kq
 9M8ac9+6B8sZDiZUe87eBDGSPoRqT+IAd/2GzeLXoKgnO0Ineg0f4anwkvTQ/9dFrIFIjqnvB2M
 wHYhRd6WxZ+WcmHK0GiSQVul9UyfEejYs4GUGdM1KV0WF/vXIZGJMwiN1z5U5B3JvQoDplQtMm4
 hpxtBIMBOfOG4egjFN38ixo4cianNZTxDJqEINkTLnSJ3oN+WMXlN8u9ELjMYeBTOD/vpALiSBn
 XCIzjPXqcl2AHbvTLhN6SVKDH2Ejo3jIC0CP/iA5Zc35tY7BC8aqAM4rCW1+uRnv4LphzcH52Yv
 eV44nrW4NwbFZ1MnQSr+85qjL0uQQZoRCEC5rrZWiD5xG9Abi6w73MwHdPa8DEU+CfQkIlHPYUf
 5xQ8NqQoFV2wp2Q/xdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 28/9/26 11:56, Daniel P. BerrangÃ© wrote:
> If CONFIG_CXL=n is added to the Kconfig, the build fails to link
> the PXB device:
> 
> /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_realize':
> /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:202:(.text+0x330): undefined reference to `cxl_component_register_block_init'
> /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_dev_reset':
> /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:309:(.text+0x768): undefined reference to `cxl_component_register_init_common'
> 
> We cannot use CONFIG_CXL in pci_expander_bridge.c because the
> identifier is poisoned. Instead the CXL pieces must be split
> off into a separate source file which can be conditionally
> built.
> 
> With this change, the stubs file is no longer required, since
> the code referencing the stub was already protected by CONFIG_CXL.
> 
> Fixes: 6e4e3ae936 (hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142))
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/cxl/cxl-host.c                             |   2 +-
>   hw/pci-bridge/meson.build                     |   4 +-
>   hw/pci-bridge/pci_expander_bridge.c           | 194 +----------------
>   hw/pci-bridge/pci_expander_bridge_common.h    |  29 +++
>   hw/pci-bridge/pci_expander_bridge_cxl.c       | 201 ++++++++++++++++++
>   hw/pci-bridge/pci_expander_bridge_stubs.c     |  14 --
>   ...der_bridge.h => pci_expander_bridge_cxl.h} |   0
>   7 files changed, 242 insertions(+), 202 deletions(-)
>   create mode 100644 hw/pci-bridge/pci_expander_bridge_common.h
>   create mode 100644 hw/pci-bridge/pci_expander_bridge_cxl.c
>   delete mode 100644 hw/pci-bridge/pci_expander_bridge_stubs.c
>   rename include/hw/pci-bridge/{pci_expander_bridge.h => pci_expander_bridge_cxl.h} (100%)


> diff --git a/hw/pci-bridge/pci_expander_bridge_common.h b/hw/pci-bridge/pci_expander_bridge_common.h
> new file mode 100644
> index 00000000000..fc5d1ac8691
> --- /dev/null
> +++ b/hw/pci-bridge/pci_expander_bridge_common.h
> @@ -0,0 +1,29 @@
> +/*
> + * PCI Expander Bridge Device Emulation Common Code
> + *
> + * Copyright (C) 2015 Red Hat Inc
> + *
> + * Authors:
> + *   Marcel Apfelbaum <marcel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +enum BusType { PCI, PCIE, CXL };
> +
> +typedef struct PXBBus PXBBus;
> +
> +struct PXBBus {
> +    /*< private >*/
> +    PCIBus parent_obj;
> +    /*< public >*/

We updated our coding style to not use these private/public comments
anymore. I can remove them if MST is OK to merge via hw-misc tree.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +
> +    char bus_path[8];
> +};


