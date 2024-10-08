Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B211ECEF15A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 11:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy8mZ-0003wb-Dz; Tue, 08 Oct 2024 07:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sy8mV-0003w7-FZ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 07:53:36 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sy8mT-0002Fj-P7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 07:53:35 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2facf481587so46451251fa.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 04:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728388411; x=1728993211; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LtlSqfPrHMDVflzhJjREaxeo7iWi5684iejiLQUms4U=;
 b=UYYz2BrCAODlfsfrOK3Bzd+XuzHkB9d5N0sRTVkgp+aaxiA4y6OQWJQiHMBVZWXISQ
 T4liHurJxFVQaZlJ4L6QWdKGkYYY778Omv2yA03FP1WGa8fW0jgZRufTgxxDHsYxpmr6
 ddHypP3B2h17sVUCuyz2OcnZaSSbuobwYGCwKM8cmuA/DYY8vsW5nYdoQyIBiGZqezv0
 /ljkQHm1bXIrI71laL/QY6ycc787LeHFOe+lDrDbAuFZNhq00HVQJlc+EFTl08MfcYSR
 qHlMcfC/mkM9ZWiOKQ6d1WE99fg9DRwnur1xTqDkZ+LRAcbM/u/7+AUn53L5K3s8Z6Rd
 4R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728388411; x=1728993211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LtlSqfPrHMDVflzhJjREaxeo7iWi5684iejiLQUms4U=;
 b=AUBZUSBIoqIbkxGg60D9r1zHYu70vFdWku6QH1LzRy8Ug8sq1EjzGocYutPHKo54YM
 eqDHJYgwvBYFLuFxIQk/lgviVLsk3m9A4+ho5f/bJ+4xkeYpoGZMOI39J1Zar7FdNKUc
 PAezcfYXNfexmYOaO0F/zFSbnjo4sLyvY/ZdET8O01HBnn5DBVEkp3n7EzeIaucISnje
 fp2SLLmxTotYIodY5T/pg5S02/ekxEbzlNnO2QkkNrGsUVnQDhzKq5SDLFLb87GO04ZY
 +Mqw+itUOTEHst8TOehnS1sz7kpISOlrKJFkaK/cwBxV7qDWt4brwi3nlN4jtQ16M+/U
 gtYw==
X-Gm-Message-State: AOJu0YxKAqA+c8mht+AHJ4qT5al6wYZI09u0LPmk+Ub/p+AfhvIOKrTs
 t2sy0ImtD07llbYwDWz6zeMJlMBNSF8QJiSnJt5zoAIMBMfyhtheBuuOMZP3qZS2SNeSSYvG6LQ
 CVH8bLzb5O/kjBMz7Dg+pfCdCCucqMa12qr4M+g==
X-Google-Smtp-Source: AGHT+IEzZAecquI2BbBhMCKL7Nu3iAdZNw2rO1LG7O7F17BC8D6r+aqdMYIx+6d6v6aEoUWs2WnwbXWMQnqE2h3w9+I=
X-Received: by 2002:a2e:4611:0:b0:2fb:dc2:21e7 with SMTP id
 38308e7fff4ca-2fb0dc2283fmr11981791fa.45.1728388410855; Tue, 08 Oct 2024
 04:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240927183906.1248-1-annie.li@oracle.com>
 <20240927183906.1248-12-annie.li@oracle.com>
In-Reply-To: <20240927183906.1248-12-annie.li@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 12:53:20 +0100
Message-ID: <CAFEAcA_Hnc84gKDnJgq6jbjNegJVcJUUAqTuSp99fvqoekBJSA@mail.gmail.com>
Subject: Re: [RFC V2 PATCH 11/11] arm/virt: enable sleep support
To: miguel.luis@oracle.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com, 
 dave@treblig.org, mst@redhat.com, anisinha@redhat.com, 
 shannon.zhaosl@gmail.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 pbonzini@redhat.com, richard.henderson@linaro.org, eblake@redhat.com, 
 armbru@redhat.com, annie.li@oracle.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 27 Sept 2024 at 19:40, Annie Li <annie.li@oracle.com> wrote:
>
> From: Miguel Luis <miguel.luis@oracle.com>
>
> For reference: qmp_system_sleep relies on wakeup support delegated
> by qemu_wakeup_suspend_enabled() hence the need for calling
> qemu_register_wakeup_support(). With this, we should be able to
> issue QMP system_sleep command now.
>
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 6be80f042f..370ee4fe7f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2403,6 +2403,7 @@ static void machvirt_init(MachineState *machine)
>
>       /* connect sleep request */
>       vms->sleep_notifier.notify = virt_sleep_req;
> +     qemu_register_wakeup_support();

On i386 the machine has a MachineClass::wakeup method
(pc_machine_wakeup) that does things on wakeup.

On ppc/spapr there is this comment before the call
to qemu_register_wakeup_support():
    /*
     * Nothing needs to be done to resume a suspended guest because
     * suspending does not change the machine state, so no need for
     * a ->wakeup method.
     */

I think that for Arm we need to determine whether the virt
board is like i386/pc (need to do something on wakeup) or
like ppc/spapr (don't need to do anything on wakeup). If the
former, we obviously would need to implement the
MachineClass::wakeup method; if the latter, then we
should have a comment explaining why there doesn't need
to be any action taken on resume and therefore the machine
has no wakeup method.

thanks
-- PMM

