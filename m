Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F39FF588DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEq2S-0001vy-ME; Mon, 20 Apr 2026 10:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wEq2M-0001uB-Fg
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:55:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wEq2I-0006dR-US
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:55:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K9mWuJ3925734
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 14:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3JeLdlwhjC5
 4DxCiFm7fx3vjy7wODhTTKXC3lfwFwiQ=; b=HLaQiydqj6Jlh3DNeHC13H3dK9p
 ex4iQ5FIAg/4Ym/bnEV96tVg7sOfpCzC8iEp3iEgvpgRiNW4m64Hr92UwzoyJv/e
 KtOcnaG1/seQmi46HMHNCIoUsSUWrII1QEYqkkxU6VMBZn+DG0sbKqNgmSVmi5E9
 RGqsoI+honBIR+nRySCMqDUmgiDqjbQ3rcW828/DhiLuVnx7Xwwt61rhMHIvvBBP
 r5l+/8ooPw+uFrkV1An0+X66PX7GgEwh3IO+fWuNWg1yiqcyaF0WYNTZuq2PCDmk
 bHRbRURmeqall6heF4VIAICOm3xEky5wXEyXhIZHGLAJiZBTXHOA7B7dIJA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnhu9s28m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 14:55:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b81ff82e3cso2487682eec.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776696940; x=1777301740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JeLdlwhjC54DxCiFm7fx3vjy7wODhTTKXC3lfwFwiQ=;
 b=hd8vTXzVNMC6ja/dI44yQEG3spvHHXTsUMAB7mWx4QGPIHb74qWaUzCcxFz/BzWu0J
 SuXzP6skrjNnJ60Jy7O4S04m2IrWImDd+uPhDN4CCmL664N5heJ+u9Ohke0JD8QV6lqG
 HFOAjqUV/VPp4hnymx+zsW0PAzTl3s9HzZWFIkGGZ96YVcYRXa0vpdbQCBvkkNFOTsAv
 P1dbNJHArs5HiDoTNUC8vTOAqHNPa2NHSyVSremxxyBV3NLBd8snef9ddGlOqkKxbpQi
 iCn8OHc+J9Jh7LIDGiuCjXLB+dYRC4j7i8TVOi2w3QLwL9gGWvKi1jn3iEB1kUqfiR1x
 S/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776696940; x=1777301740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3JeLdlwhjC54DxCiFm7fx3vjy7wODhTTKXC3lfwFwiQ=;
 b=dL4GGSYyhySYhyvaEFfce6//VvD7fZ3As0xIyW+80SoRmLwqostjP6msQ6PCJp4ujw
 qYLf3kyzJT6dJ8+bdEcXxrERYKeYI1vfjROP4vMIZ4SrB1Rt/bCC2StT0klQO4I8kpoD
 H36z8zawv+m9fAF1W2DHda0WAKUKse3yOcHY3yI0GqSSNvZKdXXpx6dW0qEzPYuzGjrS
 WWDkbq8x5n+XP8+Q9Tb32UjEkQzfSZoryP512T5vjBD7lKseX6TfL1xkUeEkmCjDAITZ
 mAU7fFOFpbL/yFg2QvipMtp/wYJAnZtDoua7CkNoaiVMp1NL3JNwxo/UxxEGOUGZ0gft
 F/kg==
X-Gm-Message-State: AOJu0YyGGnSWtQCjkSVmb2icISi37Ix1X92SZZtv949iZ9ojVh5Hd8pz
 93X0VZ9BFFEmI7lv9akkB8N2R07uvSLBD0Xh41FndaLADMkBmjpuxK4HENFn75uC9GSZ3+d7XWq
 3u30aRRb9aNq9pHj9XylwpMmeNf4d63bcE0q/NKpM8S8MeIeGHRfIFmkPww==
X-Gm-Gg: AeBDieuadbDTmfDtkdhaug6MM//wrbq33Exg+FlleUCaviVjH2O/PjU74qWR/l6I4Yu
 68X3UuQULXpEhxEDHqvmnOpKDtck8EJ2Xh0xCzqfveFO7GP6whXUbvy2ldwsBJOo+zpZAIMMH9D
 t0Iqk/ztsJr3zzY1gyVd8yQFTplizexNl9cIJtr0ksoemoRGp5HD6b7lBBFRGXTOIeFojKEa54Y
 woUsJgNlQUsEV67d5wZ+WZHBV4NphO2AoDR9DRR5ddvgwXpNQn5zIA459BTqWHAchLTmaGZ9R1w
 OkruXMwhJ7mK5lhWiSEsIDwHGSPmLrc/rjgF20HKzyiLIqjuMX83RxYEHZhZ0qPc7qPW8S5Miix
 UXh1c/3WUdVREChWEzt7M4216sA+fywaL+hJ3ufS9jcIjfhxfTNLWVFfefA3gsuxZC3Km2xeQyJ
 +dwWnG2Vd6jTo04kw/P9o=
X-Received: by 2002:a05:7022:48f:b0:11b:2a5:3b9b with SMTP id
 a92af1059eb24-12c73afd10bmr6121963c88.8.1776696939597; 
 Mon, 20 Apr 2026 07:55:39 -0700 (PDT)
X-Received: by 2002:a05:7022:48f:b0:11b:2a5:3b9b with SMTP id
 a92af1059eb24-12c73afd10bmr6121934c88.8.1776696939021; 
 Mon, 20 Apr 2026 07:55:39 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c837f7feasm12104230c88.0.2026.04.20.07.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 07:55:38 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, pierrick.bouvier@oss.qualcomm.com, bcain@quicinc.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH v5 8/9] hw/hexagon: Define hexagon "virt" machine
Date: Mon, 20 Apr 2026 07:55:36 -0700
Message-Id: <20260420145536.1198387-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260416210305.2255579-9-brian.cain@oss.qualcomm.com>
References: <20260416210305.2255579-9-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE0NCBTYWx0ZWRfX6fbJ79+UusPQ
 YlhwqxbY7Fazjvb4B/5hsZkJ21Taz5Gnuv88doP6lxVaMsoZSps8d8Dizc2dw9/qd6Ip32zwBkf
 37Xc86er9E2uoz7SBrWJG3rxPmd7xQvEmjV1G9wp5t4wGhonKbnJlv4RNTN/XItfYSmAkGqPQ0w
 wBqdxD67hZ89R9T1pMI05G8mJA/d8zLE0uDKH9ToVSZhUkeOLkR0vySK/UlLJodqV0/iHTvwyI6
 is8lANZ/o9B5LQfYUK45Nvjqwvi7s3t071p+M5eO6izfppPQZbENqM8b5bTtuRzJwyQfndzxP8R
 3KvckltO7KwLwuaFMWrHvW09MFnFutnwUkbN/0y3mMt+SAAHcqWVdygyrSGO7rNJH6M2nluQsBG
 5oWWqe7M5hdjBFoDSkLhYQ9DsXdew2K8LJrLS/kyxpS/FNgi6E/2Y+k7q4n5ruksfmRaaZXeBNE
 K45k7BJ32WC4fYdkb6w==
X-Authority-Analysis: v=2.4 cv=IIoyzAvG c=1 sm=1 tr=0 ts=69e63e6c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=4QKhv830yg8YpbWl3Z8A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: TKyOlQRXbD1q7AmQNKHs4tX0f8JQlGRC
X-Proofpoint-ORIG-GUID: TKyOlQRXbD1q7AmQNKHs4tX0f8JQlGRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Thu, 16 Apr 2026 14:03:04 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> new file mode 100644
> index 00000000000..ff93b5221ba
> --- /dev/null
> +++ b/hw/hexagon/virt.c
> @@ -0,0 +1,456 @@
> +/*
> + * Hexagon virt emulation
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/hexagon/virt.h"
> +#include "elf.h"
> +#include "hw/char/pl011.h"
> +#include "hw/core/clock.h"
> +#include "hw/core/sysbus-fdt.h"
> +#include "hw/hexagon/hexagon.h"
> +#include "hw/hexagon/hexagon_globalreg.h"
> +#include "hw/hexagon/hexagon_tlb.h"
> +#include "hw/core/loader.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev-clock.h"
> +#include "hw/core/register.h"
> +#include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
> +#include "qemu/units.h"
> +#include "elf.h"

nit: elf.h was already included above

> +#include "machine_cfg_v68n_1024.h.inc"
> +#include "system/address-spaces.h"
> +#include "system/device_tree.h"
> +#include "system/reset.h"
> +#include "system/system.h"
> +#include <libfdt.h>
> +
[...]
> +static void fdt_add_hvx(HexagonVirtMachineState *vms,
> +                        const struct hexagon_machine_config *m_cfg,
> +                        Error **errp)
> +{
> +    const MachineState *ms = MACHINE(vms);
> +    uint32_t vtcm_size_bytes = m_cfg->cfgtable.vtcm_size_kb * 1024;
> +    if (vtcm_size_bytes > 0) {
> +        memory_region_init_ram(&vms->vtcm, NULL, "vtcm.ram", vtcm_size_bytes,
> +                               errp);

I was going to ask whether we should handle errp here and abort earlier, but
fdt_add_hvx is always called with error_fatal, so that's fine. (I wonder, though,
should we remove "Error **errp" from the function signature and use error_abort
here directly, for clarity and future-proof?)

> +        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.vtcm_base << 16,
> +                                    &vms->vtcm);
> +
> +        qemu_fdt_add_subnode(ms->fdt, "/soc/vtcm");
> +        qemu_fdt_setprop_string(ms->fdt, "/soc/vtcm", "compatible",
> +                                "qcom,hexagon_vtcm");
> +
> +        assert(sizeof(m_cfg->cfgtable.vtcm_base) == sizeof(uint32_t));
> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/vtcm", "reg", 0,
> +                               m_cfg->cfgtable.vtcm_base << 16,
> +                               vtcm_size_bytes);
> +    }
> +
> +    if (m_cfg->cfgtable.ext_contexts > 0) {
> +        qemu_fdt_add_subnode(ms->fdt, "/soc/hvx");
> +        qemu_fdt_setprop_string(ms->fdt, "/soc/hvx", "compatible",
> +                                "qcom,hexagon-hvx");
> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-max-ctxts",
> +                               m_cfg->cfgtable.ext_contexts);
> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-vlength",
> +                               m_cfg->cfgtable.hvx_vec_log_length);
> +    }
> +}

