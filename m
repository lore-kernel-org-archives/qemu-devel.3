Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A9ED6ACCA
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGHiZ-0006IH-OL; Wed, 27 Nov 2024 08:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tGHiX-0006I1-AG
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:04:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tGHiV-0003I1-MG
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732712665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pv4xPEcxltNiYiHNPRFAvU0Rsp2SorHyw9zplram7EE=;
 b=dw6nkPtbE+zu5xuaWWcJkq8TfWvhnIn+HkVEYG60+zAsUTPBVXsDD3VNRmLcCAxVmoHC2i
 tuu0EzC3XvN59YfR3i3FEUZbr4CEK39kGKGciLtVRcDZ2E+nB2W3uK+vnTp/3BGxz7PDXw
 269xcwUbOn4YJKL7vN9ASa0WdtfdAnY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-Lcglp2zDNN6YcrfUNUumhg-1; Wed, 27 Nov 2024 08:04:24 -0500
X-MC-Unique: Lcglp2zDNN6YcrfUNUumhg-1
X-Mimecast-MFC-AGG-ID: Lcglp2zDNN6YcrfUNUumhg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa53914509eso217490666b.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712662; x=1733317462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pv4xPEcxltNiYiHNPRFAvU0Rsp2SorHyw9zplram7EE=;
 b=lMnL50M7Qb+gcgzhVSu4VRA8fQbPkodOiWk3BCJnOOPEpL9Js1WEVbe4E4ajN7ZvWs
 1UMe9HHyD1HWZ2O/GeoNP34Ouudy6ygLKlkpVfPN1Sd2elUJliDqXfEfiDwlqafX06vb
 9Rbg1w5ULljfWNaKHD3V/tw2YQWXhiFnUmaosCYlYpgAMscXTr0KRImpVygCbwlExziI
 y9UjaKpP5Nj7H9O3B8Za1GUnWbm7lK8pix/+sdbTSYNkEhwHBXVX8SiYhN+YxXuuenca
 JNXuyATLBqfVA/iJebjyU/U99NAlGd3fQ5v+p2++tZkxmjo4hUn3Nhat8OI+jSLRHds5
 /HTA==
X-Gm-Message-State: AOJu0YwDKM+sjyCqMRQE1CVQzI8GPupP9dPY4RJ0loDzlWsgbwv0Lyvl
 0KMSYC5MA2cBdyyx3W0jcoFsWdmIE0h9lpjMvUfEv70RYj4KEIQwZ8oC24rjamQE5QDLRIqTNQw
 4hhrbJo7LqJGiE90cfWXr0FEHUFy4UNJnMkkGa+T2fEY0MRbL4q/YLof/a0UZqEuU9VL0ez0//H
 zvqliscSeKljpe+Tvb1ehaMPLH59vQtg46b98avSSL
X-Gm-Gg: ASbGncv0eMQTS8zog8ys6c/hTrKGulj8IgcSjMSSxRWscgJd0o0CNqqi+qEWHkyxGBe
 noIO5tTrqRZF6dBijpkkF/bsKEhvnbWXvZw==
X-Received: by 2002:a17:906:3d21:b0:aa5:3fa9:e90c with SMTP id
 a640c23a62f3a-aa580f56c51mr199586366b.32.1732712662210; 
 Wed, 27 Nov 2024 05:04:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFARGVosSIlkqQz4cj9pHfPi99wbLWXmnJddAokdH9+eU+FrE1XwTpQ5hFerU6R5fS8B9Fubc5CWGCb5pi6qJw=
X-Received: by 2002:a17:906:3d21:b0:aa5:3fa9:e90c with SMTP id
 a640c23a62f3a-aa580f56c51mr199583266b.32.1732712661873; Wed, 27 Nov 2024
 05:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20241127114057.255995-1-berrange@redhat.com>
In-Reply-To: <20241127114057.255995-1-berrange@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 27 Nov 2024 18:34:10 +0530
Message-ID: <CAK3XEhO=+6o9v87YfMcJYaUUOtbdRq-WcBKW9wDjfeLPyOnAcQ@mail.gmail.com>
Subject: Re: [PATCH] hw/core/machine: diagnose wrapping of maxmem
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Wed, Nov 27, 2024 at 5:11=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The 'maxmem' parameter parsed on the command line is held in uint64_t
> and then assigned to the MachineState field that is 'ram_addr_t'. This
> assignment will wrap on 32-bit hosts, silently changing the user's
> config request if it were over-sized.

With this patch, for the failing test_mem_addr_space test in 32-bit, we get=
:

Traceback (most recent call last):
  File "/builds/qemu/tests/functional/test_mem_addr_space.py", line
256, in test_phybits_low_tcg_q35_71_amd_41bits
    self.assertRegex(self.vm.get_log(), r'phys-bits too low')
AssertionError: Regex didn't match: 'phys-bits too low' not found in
'qemu-system-x86_64: ram size 1065151889408 exceeds permitted maximum
4294967295\n'

Traceback (most recent call last):
  File "/builds/qemu/tests/functional/test_mem_addr_space.py", line
294, in test_phybits_low_tcg_q35_intel_cxl
    self.assertRegex(self.vm.get_log(), r'phys-bits too low')
AssertionError: Regex didn't match: 'phys-bits too low' not found in
'qemu-system-x86_64: ram size 1059783180288 exceeds permitted maximum
4294967295\n'

etc.

>
> Improve the existing diagnositics for validating 'size', and add the
> same diagnostics for 'maxmem'
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Tested by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  hw/core/machine.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a35c4a8fae..f29fe95964 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -598,11 +598,19 @@ static void machine_set_mem(Object *obj, Visitor *v=
, const char *name,
>          mem->size =3D mc->fixup_ram_size(mem->size);
>      }
>      if ((ram_addr_t)mem->size !=3D mem->size) {
> -        error_setg(errp, "ram size too large");
> +        error_setg(errp, "ram size %llu exceeds permitted maximum %llu",
> +                   (unsigned long long)mem->size,
> +                   (unsigned long long)RAM_ADDR_MAX);
>          goto out_free;
>      }
>
>      if (mem->has_max_size) {
> +        if ((ram_addr_t)mem->max_size !=3D mem->max_size) {
> +            error_setg(errp, "ram size %llu exceeds permitted maximum %l=
lu",
> +                       (unsigned long long)mem->max_size,
> +                       (unsigned long long)RAM_ADDR_MAX);
> +            goto out_free;
> +        }
>          if (mem->max_size < mem->size) {
>              error_setg(errp, "invalid value of maxmem: "
>                         "maximum memory size (0x%" PRIx64 ") must be at l=
east "
> --
> 2.46.0
>


