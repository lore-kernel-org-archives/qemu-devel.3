Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D28C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 16:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4zh-0003x9-9h; Mon, 19 Aug 2024 12:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sg4zg-0003rq-0M
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 12:12:32 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sg4za-0007aw-SH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 12:12:31 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5daa4f8f1c4so1798727eaf.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724083945; x=1724688745; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmZQV+gQhNfX7Q3pNIqrG5VdJ+3DXbcpTYllJY08p/k=;
 b=ETyMwDjVXgwmQP31tDceZ4cObeyg1XzZbKSvBcH/MJbK6gGaXCGb4IwXmULQjrBx21
 OXIc2s5EGSPUXq0E9Ucb2H7U8PwoiMct/8uI7yPN3P7bvC66Ry+gAROnQczjyDJ+tzWl
 L3+SVv1jcyiENt9fJDIYtH0nfu8ZIL6CKBNSPT3RvLSIxLte+Au12kyCILPN4uYJbS54
 j5o1sCMjDndQTY2GJ8j0lYxpT9qD0pC+j/Wf+arIK9dz5NpJ5vT8RZU1WWpERmc4CSoZ
 yG5uCsDIwhqrXce6K9Aoa/MTz/revyaioxNrDgAauo06nIqEt8o3Pw9YFr4MJx/toCCg
 kDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724083945; x=1724688745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmZQV+gQhNfX7Q3pNIqrG5VdJ+3DXbcpTYllJY08p/k=;
 b=ld8f5ZjR9W867Y/Ez6yyJfMW/ovu8xjMFMTpAeOw52UOy4GK3O5gjgejIXwiV9tIDA
 r4lEHwbh1U99L5AEKMQ5e0jDIBkAuWBp8y57wxRyNf4ANGgoUKytvg+J4kd/v+PbsCWR
 SRJUpmd/UdfCofSH19LcJivLYcZ+xTOmlNf2yEf224KtzYM59QKrmWWRSb50HyM/56UE
 8KLYS2I+XW+V0LK0xCw7bmSLNmDyMJ/wgSNAaooSDxEUZv2QUTqCQZx/7CsYhsmbbsNJ
 XrJxw+uA4lRfT7A8dPmQ4IbjoqyevWwtP5ESXHj5j8/Qe7xr02ktofv0Vf0BZpDUqs6U
 kzFg==
X-Gm-Message-State: AOJu0YxNZ/BHiGyEn06NdmQROQf04lYbjfjYbQruC3KOMbGA+ww+Hnsf
 SRI4E4grOzfVRKIee4Cm15w3lkwPgO/Xafwjx1dkSWLuOPxcJimNRAnpmoQijdxhdzZNlCAeyua
 j02+RVEb4U8phXxvz5u0VMZhr8/Q=
X-Google-Smtp-Source: AGHT+IFWt902jNOTDHHOluMU2YEcA/BC8X18zUMuUscYEypwRLbPFDUAm2EHaow6sVeZZ8nEWrLE9L/nh+hFkws6NFo=
X-Received: by 2002:a05:6359:5a92:b0:1aa:a01a:23dc with SMTP id
 e5c5f4694b2df-1b3931b8c6amr1645933655d.15.1724083945351; Mon, 19 Aug 2024
 09:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-5-dorjoychy111@gmail.com>
 <bffedf65-6046-4264-a2fe-011ff8c58860@amazon.com>
 <CAFfO_h6eSmizJuSwRSQ1+gzeVBfmsmrLiN0mCXYuQFXGaJ4_Vw@mail.gmail.com>
 <5a7cd886-0694-45ed-a0fc-6bf69c5ed97f@amazon.com>
In-Reply-To: <5a7cd886-0694-45ed-a0fc-6bf69c5ed97f@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 19 Aug 2024 22:12:18 +0600
Message-ID: <CAFfO_h6fvuhCg4tOKS=nmAN5i+Pxa_1=LLdSbXTu67sU-g4iFg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 19, 2024 at 9:58=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
>
>
> On 19.08.24 17:28, Dorjoy Chowdhury wrote:
> > Hey Alex,
> >
> > On Mon, Aug 19, 2024 at 4:13=E2=80=AFPM Alexander Graf <graf@amazon.com=
> wrote:
> >> Hey Dorjoy,
> >>
> >> On 18.08.24 13:42, Dorjoy Chowdhury wrote:
> >>> AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device whi=
ch
> >>> is used for stripped down TPM functionality like attestation. This co=
mmit
> >>> adds the built-in NSM device in the nitro-enclave machine type.
> >>>
> >>> In Nitro Enclaves, all the PCRs start in a known zero state and the f=
irst
> >>> 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and P=
CR8
> >>> contain the SHA384 hashes related to the EIF file used to boot the
> >>> VM for validation.
> >>>
> >>> Some optional nitro-enclave machine options have been added:
> >>>       - 'id': Enclave identifier, reflected in the module-id of the N=
SM
> >>> device. If not provided, a default id will be set.
> >>>       - 'parent-role': Parent instance IAM role ARN, reflected in PCR=
3
> >>> of the NSM device.
> >>>       - 'parent-id': Parent instance identifier, reflected in PCR4 of=
 the
> >>> NSM device.
> >>>
> >>> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> >>> ---
> >>>    crypto/meson.build              |   2 +-
> >>>    crypto/x509-utils.c             |  73 +++++++++++
> >>
> >> Can you please put this new API into its own patch file?
> >>
> >>
> >>>    hw/core/eif.c                   | 225 ++++++++++++++++++++++++++++=
+---
> >>>    hw/core/eif.h                   |   5 +-
> >>
> >> These changes to eif.c should ideally already be part of the patch tha=
t
> >> introduces eif.c (patch 1), no? In fact, do you think you can make the
> >> whole eif logic its own patch file?
> >>
> > Good point. I guess it should be possible if I have the virtio-nsm
> > device commit first and then add the machine/nitro-enclave commit with
> > full support with the devices. That will of course make the
> > machine/nitro-enclave commit larger. What do you think?
>
>
> As long as nothing compiles the code, it can rely on not yet implemented
> functions. So it's perfectly legit to add all your code in individual
> commits and then at the end add the meson.build change that implements
> the config option. How about the order below?
>
> * Crypto patch for SHA384
> * Crypto patch for x509 fingerprint
> * NSM device emulation (including libcbor check, introduces
> CONFIG_VIRTIO_NSM)
> * EIF format parsing (not compiled yet)
> * Nitro Enclaves machine (introduces CONFIG_NITRO_ENCLAVE)
> * Nitro Enclaves docs
>

Sounds good to me. Thanks Alex!

Regards,
Dorjoy

