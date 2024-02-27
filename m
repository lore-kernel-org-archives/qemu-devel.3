Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BDBC54E51
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1retF1-0001SA-E6; Tue, 27 Feb 2024 03:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1retEy-0001R9-I7; Tue, 27 Feb 2024 03:55:09 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1retEw-0003vs-RR; Tue, 27 Feb 2024 03:55:08 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e4e7e25945so1993443b3a.1; 
 Tue, 27 Feb 2024 00:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709024105; x=1709628905; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnlDAPgGIsFzcqwBwxAATUk+Ze4BZ1EKLksX7SHo4rE=;
 b=P8i7MaoCJews8C0sgOVrQF0DyBq8IMr7DjG/QFmib0gt2kuXq+6omLZA9bhfEbiZJa
 rXUHU+4LQouU19nuW1vvRmWuhOQdk4QbEjZaa7AYHc9V9aae4xgnhKSduGPZtBPOw15x
 c+PeCSz+WN1ve+PHsLPYkeebBfIXdU3UPBJiqHO+39MN/9vfxbf+DL9UDtRdT6zFOmc5
 hQ3Hs1m2kNV8iVDfmxQfgesO43s2YaW7jLZrHrJc6Re8L3wsf3rC3GqpOEDhRr3yqXWw
 diuJi7xqfElN+wBnXLVklCFriTdvtbyE7rnfzeCW5HYOsyvHW6K9lmfOnghc/H0ep6hQ
 ycIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709024105; x=1709628905;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vnlDAPgGIsFzcqwBwxAATUk+Ze4BZ1EKLksX7SHo4rE=;
 b=QQScm1D7WNDv4UOcy6Bh3B+fRvULLFcKhkBFPxPWO9fhbmvYCtwiw/kUr9cmcJLtSp
 Avt0JVNvqS2mVFFbwTdwde+cjm8QeVw8xYBzdTxrzq+L0HHrUcKf4VpSTyIZ8A1ReT5M
 CeMdWulxMXj90sJszubXirj4/3LtRk89EP/NcAarHYxRDj2fmoPhgobmxbkhVxptLeWn
 Hdf5Y9kDbxUGt+iKdFNLwLjXSN9QBXAnCC8rv5dgikpeVoC9xSr6o5rRytBhomNM9uWs
 3qDocbU/lY5EEzL20I6I7nUZNPLrag5ZjIm1fNhBoqngjmd/e4+ZIWTo7Sm+UH0qeLf8
 Ku/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmrDjnDjWquI5/OJS8ziDtlr7ewFRADpt0YFC0W9M/6LPAx6oA4gO10viA+Xq8iJtw5YomYLh+Y9Y+zB/X02mzarb/7u0UnypzuvJ1FY9EGogiHaWba+TW5U4=
X-Gm-Message-State: AOJu0YwVQsL1uD6MjFJkk6k+5Qx8djWHFcsNUBtmdApT6mYblBQ7m3CV
 /cF4nPsaE44tYaaGPHukg4WrbbknfiAuNOhmTnJsMIIJ5UT/FaZQD5oPXCC8
X-Google-Smtp-Source: AGHT+IEjf59/1Q0Iw6uUTtzBst0OuweAyLtlZ2FedL6HBilcdMaJyU1O0wClaW236gO4v/h7z3cgOw==
X-Received: by 2002:a05:6a00:4f82:b0:6e5:32e9:9fc6 with SMTP id
 ld2-20020a056a004f8200b006e532e99fc6mr5149219pfb.34.1709024104951; 
 Tue, 27 Feb 2024 00:55:04 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 x8-20020a056a00270800b006e500e31f9bsm4520954pfv.63.2024.02.27.00.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 00:55:04 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 18:54:57 +1000
Message-Id: <CZFQHBO2FUX6.30O1PDW79JW97@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 04/15] spapr: nested: keep nested-hv related code
 restricted to its API.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-5-harshpb@linux.ibm.com>
In-Reply-To: <20240220083609.748325-5-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Feb 20, 2024 at 6:35 PM AEST, Harsh Prateek Bora wrote:
> spapr_exit_nested and spapr_get_pate_nested_hv contains code which
> is specific to nested-hv API. Isolating code flows based on API
> helps extending it to be used with different API as well.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/hw/ppc/spapr_nested.h |  4 ++++
>  hw/ppc/spapr.c                |  7 ++++++-
>  hw/ppc/spapr_caps.c           |  1 +
>  hw/ppc/spapr_nested.c         | 27 ++++++++++++++++++++++++---
>  4 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index 2488ea98da..3f07c81c3d 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -5,6 +5,8 @@
> =20
>  typedef struct SpaprMachineStateNested {
>      uint64_t ptcr;
> +    uint8_t api;
> +#define NESTED_API_KVM_HV  1
>  } SpaprMachineStateNested;
> =20
>  /*
> @@ -103,4 +105,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp);
>  typedef struct SpaprMachineState SpaprMachineState;
>  bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
>                                target_ulong lpid, ppc_v3_pate_t *entry);
> +void spapr_nested_init(SpaprMachineState *spapr);
> +uint8_t spapr_nested_api(SpaprMachineState *spapr);
>  #endif /* HW_SPAPR_NESTED_H */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 97b69c0e42..51a1be027a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1376,7 +1376,11 @@ static bool spapr_get_pate(PPCVirtualHypervisor *v=
hyp, PowerPCCPU *cpu,
>          entry->dw1 =3D spapr->patb_entry;
>          return true;
>      } else {
> -        return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
> +        assert(spapr_nested_api(spapr));
> +        if (spapr_nested_api(spapr) =3D=3D NESTED_API_KVM_HV) {
> +            return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
> +        }
> +        return false;
>      }
>  }
> =20
> @@ -3443,6 +3447,7 @@ static void spapr_instance_init(Object *obj)
>          spapr_get_host_serial, spapr_set_host_serial);
>      object_property_set_description(obj, "host-serial",
>          "Host serial number to advertise in guest device tree");
> +    spapr_nested_init(spapr);

I would maybe make this init a reset instead, and then it could do
the hypercall unregistering as well? You could rework that part of
it into patch 1 (or reorder the patches).

Thanks,
Nick

