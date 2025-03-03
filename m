Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0262C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 20:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpCef-0003kJ-0y; Mon, 03 Mar 2025 15:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1tpCeX-0003in-1E
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 15:44:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1tpCeU-0003Gz-JA
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 15:44:40 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AFMvQ025122
 for <qemu-devel@nongnu.org>; Mon, 3 Mar 2025 20:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Eb+8IeIfgwFwqfNpEBukyROO
 FzwPNkiWo0719T+6Xmw=; b=apsaAYvs1LyKR+r3+4lXq0jPoVqB221iNEfDi+qq
 SxJFLFdfSqCpVV87wHvFoDqX6lMTb1NA2KNNJHTS6pKjMQBQAWlotIJDhDjUePEL
 PH2M+slnxJNmRR5VPGlAPVZtz/KS6odtxTYBnJGp3xJa/nqRtrJup02l0psWz/Tu
 ePRd7Xc1D9TvrRq7RDtNO4jxbXAeKConF9nkJTd6wLqFos5UXM7YhQZspt4vhGA9
 exRJwgjClS3jS2Yf2UJPSttq5F2x7M3ynU4JTyXGyScnGi5XN08bLs+b7GzheX7Q
 ldBRVDYb3sfcFNf6W8bJOzNd0e4CDl6VqnpFb8oOy7Eebw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tase46n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 20:44:34 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6f2bdb560ecso68701237b3.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 12:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741034674; x=1741639474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eb+8IeIfgwFwqfNpEBukyROOFzwPNkiWo0719T+6Xmw=;
 b=oNcCoa5DCp8wQlkWq1k5KrxqTBLMzP4OZcDOV/BHy5C3Os+QKS7PnDoISREreRqUBH
 cVRXtWXAqkctd16zUaLoUneBVmfHW2Swfs5vXp9wfJ9PXZO9Pv8Fw7/vGuijS/h60dfp
 4EG+PsskRXcbRBhmdm9wsKl60dnF/+IVEzESv+skOsJ+uvfaSJkvtpXyZGSAoDy9OIf9
 XkyhjIIXmS00AUqVttrWSo9Qwg/F+ZZtaKtrox+eHv1/1a6plyMByoSjTk38do8cu/nW
 jFx6sD2eZU1ggbBVn7pVDQhf13ulMuajQVfiODcfxOreNU+rM42wH9EEOqGagL3l3Cl+
 JtmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWFxUDIVbeF1u3pKmLOnPVi6zN9lubciS0DueN0LI5NyZ4zisk+xt+l84cwdsh+dISstlEjM1FLqDe@nongnu.org
X-Gm-Message-State: AOJu0Yy1qeZw+LffqqTLyABogBt++XiinJL/uY2sa5SG8KauFCzSe2eL
 awLtZCy2w6mWYAdbhmY1+jUDs/ibg5JcgWy2WEQxaZh/3ShZseMgTBrsLj0BYNMRxko/A7d2YY/
 M/nQta9oX1m2t3pqD9wuf+ZG+a/Bj+SpQEZzozcFmsA5TPG+m44NqP484D05MnD2GxJLLLd69kP
 MLkJZcA5Fh6ClnPq8viUNPj69LlMaB
X-Gm-Gg: ASbGncstJ0RhsVr6IW8a+++jB13mHh4+mVjzDjyWTK4s/l2QwyD+a05xYPoxA7KSG0M
 p5iJdD02lBh0a3fgqD2vQW9QHmD7vMK/Lz0R9RNsq5BjexekQpdHhP+hYwGRGQDgQQkYea0U4zz
 23qeiOyWldBX/uRHvYm3rZOZoVKRMGSw==
X-Received: by 2002:a05:690c:74c9:b0:6fd:369c:635e with SMTP id
 00721157ae682-6fd4a0fba64mr221123817b3.16.1741034673738; 
 Mon, 03 Mar 2025 12:44:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpenhb6bjNCr5KKNHJuPuPek1JIJ6CNDQiTnccoi8xin5L1JEDmPvdjhbDYHOtW1sRpnaLHfe3SomLlY6UEws=
X-Received: by 2002:a05:690c:74c9:b0:6fd:369c:635e with SMTP id
 00721157ae682-6fd4a0fba64mr221123567b3.16.1741034673406; Mon, 03 Mar 2025
 12:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20250225074133.6827-1-kuqin12@gmail.com>
 <20250225074133.6827-2-kuqin12@gmail.com>
 <CAD=n3R2kuvUzyE7nKPmpyELozdo_+eAKVr_CxA5HQ_jLL25stw@mail.gmail.com>
In-Reply-To: <CAD=n3R2kuvUzyE7nKPmpyELozdo_+eAKVr_CxA5HQ_jLL25stw@mail.gmail.com>
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 20:44:21 +0000
X-Gm-Features: AQ5f1JprlG5Sgu7UcZuHcTwErsEB0-U0S3xSc2buB1mmfQIoDfpU4ZFqvaFi8rU
Message-ID: <CAD=n3R0ntWYNN9LxJWVXApY3s_LRddx4YVQPYRzRojXcL-BDug@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: Adding TPM support for ARM SBSA-Ref
 machine
To: Kun Qin <kuqin12@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Graeme Gregory <graeme@xora.org.uk>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: jmZCq9Ut_wbF1Mvzyx_zbgMLa8tl4mcZ
X-Proofpoint-ORIG-GUID: jmZCq9Ut_wbF1Mvzyx_zbgMLa8tl4mcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_10,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030159
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=leif.lindholm@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Doh! Add the lists back in. (No idea how I dropped them off.)

On Mon, 3 Mar 2025 at 17:02, Leif Lindholm
<leif.lindholm@oss.qualcomm.com> wrote:
>
> Hi Kun,
>
> Apologies for delay in responding - I was out last week.
> I agree with this addition, since a TPM is a requirement for servers.
>
> However, to help simplify review, could you add some detail in the
> commit message
> as to which SystemReady requirements this resolves and whether this
> implementation
> fulfills all requirements across BSA/SBSA/BBSA?
>
> I agree with Peter that since this is a non-discoverable component, it
> would make sense
> to step the machine minor version number. A major version bump would
> not be required
> since simply adding this component will not break any existing
> firmware (which will have
> no way of knowing it even exists).
>
> Regards,
>
> Leif
>
> On Tue, 25 Feb 2025 at 07:41, Kun Qin <kuqin12@gmail.com> wrote:
> >
> > From: Kun Qin <kuqin@microsoft.com>
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2625
> >
> > This change aims to add a TPM device for SBSA ref machine.
> >
> > The implementation adds a TPM create routine during machine
> > initialization.
> >
> > The backend can be the same as the rest of TPM support, by using swtpm.
> >
> > Signed-off-by: Kun Qin <kuqin12@gmail.com>
> > ---
> >  hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index e720de306419..93eb3d1e363b 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -28,6 +28,8 @@
> >  #include "system/numa.h"
> >  #include "system/runstate.h"
> >  #include "system/system.h"
> > +#include "system/tpm.h"
> > +#include "system/tpm_backend.h"
> >  #include "exec/hwaddr.h"
> >  #include "kvm_arm.h"
> >  #include "hw/arm/boot.h"
> > @@ -94,6 +96,7 @@ enum {
> >      SBSA_SECURE_MEM,
> >      SBSA_AHCI,
> >      SBSA_XHCI,
> > +    SBSA_TPM,
> >  };
> >
> >  struct SBSAMachineState {
> > @@ -132,6 +135,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
> >      /* Space here reserved for more SMMUs */
> >      [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
> >      [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
> > +    [SBSA_TPM] =                { 0x60120000, 0x00010000 },
> >      /* Space here reserved for other devices */
> >      [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
> >      /* 32-bit address PCIE MMIO space */
> > @@ -629,6 +633,24 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
> >      }
> >  }
> >
> > +static void create_tpm(SBSAMachineState *sbsa, PCIBus *bus)
> > +{
> > +    Error *errp = NULL;
> > +    DeviceState *dev;
> > +
> > +    TPMBackend *be = qemu_find_tpm_be("tpm0");
> > +    if (be == NULL) {
> > +        error_report("Couldn't find tmp0 backend");
> > +        return;
> > +    }
> > +
> > +    dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
> > +    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &errp);
> > +    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, sbsa_ref_memmap[SBSA_TPM].base);
> > +}
> > +
> >  static void create_pcie(SBSAMachineState *sms)
> >  {
> >      hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
> > @@ -686,6 +708,8 @@ static void create_pcie(SBSAMachineState *sms)
> >      pci_create_simple(pci->bus, -1, "bochs-display");
> >
> >      create_smmu(sms, pci->bus);
> > +
> > +    create_tpm(sms, pci->bus);
> >  }
> >
> >  static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
> > --
> > 2.43.0
> >

