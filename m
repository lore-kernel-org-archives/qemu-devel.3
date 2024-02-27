Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01809C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuJ2-0004oC-Lh; Tue, 27 Feb 2024 05:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reuIy-0004jU-Bu; Tue, 27 Feb 2024 05:03:21 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reuIk-00076q-U9; Tue, 27 Feb 2024 05:03:20 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e49833ccdfso988019a34.2; 
 Tue, 27 Feb 2024 02:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709028184; x=1709632984; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytoSqAFhOWmoUeVQUUlSrAQnwMfL5ELYf+G8HVtTKKU=;
 b=MbEHux+FWQXK/bfBMUZNA5cqIw2MVuL7S9nJP+vZJ1AO3kpwdAPe4bAYdnRsODpvGh
 wPkn81o+maJ6/8LOz3n6mvgNd7CcYWMpZSm9gPOBn8VfWf+9J66NSX4IJJzilfVp0Mad
 Xf1+7EgIxPILhDnBa64EhcXok1ag6ZqonU6VbMOpCN4Jy0sKhcjqjdqjg8wBlZakqq5g
 wtpAF91LH8wSHaTm6sTEnRRD07WgfkNpPKhetjodvzXZle4ZoKW7ebR5GD/wJL1rQ1xe
 XcXXS2M+ix9w6HFhHTLuCqsvvQQpoOcPz6qZBKW372uGL3ICrkxsDI7vzd9WgUOUK23B
 AKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709028184; x=1709632984;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ytoSqAFhOWmoUeVQUUlSrAQnwMfL5ELYf+G8HVtTKKU=;
 b=At4RNu64bg1CgkeAa+UINVI7+DloV9VSm1CxwNcId/tL+i2LBYmcAv2HjGlGRApXr/
 IT89JwJ29rcrW2QWQrgRDpOT6EPunOuED3HI/TujaEpgSp1Fdhu1s63vTZ4oWwUfJ/AJ
 AMyDR70Xb6xeFrY4ZuZURUbZ5NtfjiLZoctvD5sJBwri2keemiUlQ8tDHnIUdTaKFZcF
 +cyocj9ky6PJ/obv68Ifv/upYYKk26O5SGDreJKC1iLJTTiroSaps8NJg4v+PrDXnRb0
 6cbea9hEpqORIeTB67fA0xyoQczh2ik+VW+VlivBRvjjwZrKId524LOjgGp8itGPns8x
 rpuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdu96IZSxLPlSu7MWVGcZTzjYpjWxI+t2rLUaavdVu8x8YmZawAiT2IHJKctqatm5t3MtUv6B11dSF875bxWFrplX3y7wkh52RXOSAB/knlb6d+Lh9NwHROrE=
X-Gm-Message-State: AOJu0YyNuMCaVfNSJe/X5Ild8P+RncngULggtqI07m0lFm6b1WOqXPoM
 3FWMa/e0RnU4jVIV95EvSRO9+CYDlMP7khdTa3OoByrrOSiP+shd
X-Google-Smtp-Source: AGHT+IFoWwF+R57lDVRU6cSdTtOXmXpIHlbhmMrLh8Xf7OSkYI64UGglDqcRoDA7uL8cBiBR+4xAWA==
X-Received: by 2002:a05:6830:1495:b0:6e4:64e6:c1a6 with SMTP id
 s21-20020a056830149500b006e464e6c1a6mr9909989otq.22.1709028184337; 
 Tue, 27 Feb 2024 02:03:04 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 r3-20020aa78443000000b006e4f1e6f145sm5546500pfn.33.2024.02.27.02.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 02:03:04 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 20:02:57 +1000
Message-Id: <CZFRXDZ1CYSH.34D4OR8HLW63U@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 10/15] spapr: nested: Initialize the GSB elements
 lookup table.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-11-harshpb@linux.ibm.com>
In-Reply-To: <20240220083609.748325-11-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue Feb 20, 2024 at 6:36 PM AEST, Harsh Prateek Bora wrote:
> Nested PAPR API provides a standard Guest State Buffer (GSB) format
> with unique IDs for each guest state element for which get/set state is
> supported by the API. Some of the elements are read-only and/or guest-wid=
e.
> Introducing helper routines for state exchange of each of the nested gues=
t
> state elements for which get/set state should be supported by the API.
>

This is doing more than just adding helper routines for the GSB access.

[snip]

> +
>  typedef struct SpaprMachineStateNested {
>      uint64_t ptcr;
>      uint8_t api;
> @@ -16,6 +201,8 @@ typedef struct SpaprMachineStateNested {
>  typedef struct SpaprMachineStateNestedGuest {
>      uint32_t pvr_logical;
>      unsigned long vcpus;
> +    uint64_t parttbl[2];
> +    uint64_t tb_offset;
>      struct SpaprMachineStateNestedGuestVcpu *vcpu;
>  } SpaprMachineStateNestedGuest;
> =20
[snip]

> =20
>  /*
>   * Register state for entering a nested guest with H_ENTER_NESTED.
> @@ -172,17 +452,40 @@ struct nested_ppc_state {
>      uint64_t sier;
>      uint32_t vscr;
>      uint64_t fpscr;
> +    int64_t dec_expiry_tb;
> +};
> +
> +struct SpaprMachineStateNestedGuestVcpuRunBuf {
> +    uint64_t addr;
> +    uint64_t size;
>  };
> =20
>  typedef struct SpaprMachineStateNestedGuestVcpu {
>      bool enabled;
>      struct nested_ppc_state state;
> +    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufin;
> +    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufout;
> +    int64_t tb_offset;
> +    uint64_t hdecr_expiry_tb;
>  } SpaprMachineStateNestedGuestVcpu;

It's adding new fields in existing nested guest state
structures. This should be explained a bit more, split into
another patch, or moved to patches where they get used.

Thanks,
Nick

