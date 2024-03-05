Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A763C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 16:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXw7-0004OF-Ki; Tue, 05 Mar 2024 11:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhXw2-0004LR-Ur
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:46:35 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhXw1-0001dn-A6
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:46:34 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56694fdec74so6539629a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709657191; x=1710261991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7vJDaJYIc9kHreCaL1G9cmXattiAUJSOOZuWUD8PMjQ=;
 b=MNN49r2Z1qClHyALQWOzm/tQWtVyWebzNwnb1vQiwoFRcB6i+5N4kjQf0VPRI3lefv
 cZrqmNtGWlKc7PVOxabKIZsx6Sd6iRoYOkvM4UopHgnu6qF/iCBMwun2hOnK1Ic7EjU+
 18zQIpSIAUOt0dOD0l36RGED2ELmVrw2IDwuniQgXmnRsb25kxzCDT4c0W5mT4rozUdv
 oUJmEgaiogUBXQvYF0NhygkIpEpdRS1fTq1nB1WVGYvMO0KA6QYen2oCcqbmfyRAdsgx
 bIleiNtcndAsaxWZ1ky0XIVuSbLBZCsvBTxbRd/DxMaPabAx43iRU5+CWwcjvxKW2K1Z
 ekww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709657191; x=1710261991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7vJDaJYIc9kHreCaL1G9cmXattiAUJSOOZuWUD8PMjQ=;
 b=bS8eJnmhqBsfKMHpK8PzQcb1rnDgSY5OlD9tmvAgFsy+HTUc2NbQ7F3cBEGra5IM8u
 VSrd9m9kBkp+qxXhJNvSvRdWZBwjjFfWcMYMntFX67FDTmmrUiceu9dlRk++oeC0N1aO
 rxB/gCaBmfCUZyCbI2F7RtjUT5plvV42jsxD9Bmsf6oV4F0fPOn73M6zbRwcx9xdwEP5
 aFmiBWnCGLMU1gZFp8ihxWa9v9LRU5ceCweEQGmedM2uS3jkMgsHxqfNTDFKMEMwHna5
 Bf11lT96cOploJNRloJSDzkL4nfuB7gVZ8zLRVo/buwxNR0wNBHPTL28S9OW3AoA774Y
 Cksg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyCXUyBJTkLwZrEC8Icey9dkRkcD7XlCx50ikF/3ATme8fCccKi0Kc/YDYkxlvkdJRPAYyQo+F3KizzMXCUEP9tq6ubfY=
X-Gm-Message-State: AOJu0Yzmm4gFJWlAm1GW9zUj0nDVYVwdHwxWBjULghz04yErJTkYlXt7
 MeffhS+FVsvvmxXDtZrSlCU5h7qusac+xtKfZ3AtDlO9xjvsZ8/9XRj+y7p2/HZQdK0AanvV/75
 7VLwKjxeSkPpBAPv8BfKJeut237Dg73QRxixTgA==
X-Google-Smtp-Source: AGHT+IEtIOe1HH7uJvP8kh/X6NjFSFEvWf0mKHR8jbVQ9Do1B3Y+UP0ZTPoZ9Wxw/KSwL5N+VGw4JzurFbsfrK0O4zE=
X-Received: by 2002:a05:6402:22a6:b0:566:fc25:5627 with SMTP id
 cx6-20020a05640222a600b00566fc255627mr6174293edb.41.1709657191367; Tue, 05
 Mar 2024 08:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20240209160039.677865-1-eric.auger@redhat.com>
 <20240209160039.677865-3-eric.auger@redhat.com>
In-Reply-To: <20240209160039.677865-3-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 16:46:19 +0000
Message-ID: <CAFEAcA-yLbwPyUxQy2s0CGwcE1z04WQd+EX0xmrvhUepfPR5ZQ@mail.gmail.com>
Subject: Re: [RFC v2 2/5] hw/arm: Allow setting KVM vGIC maintenance IRQ
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 miguel.luis@oracle.com, haibo.xu@linaro.org, richard.henderson@linaro.org, 
 maz@kernel.org, gkulkarni@amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 9 Feb 2024 at 16:00, Eric Auger <eric.auger@redhat.com> wrote:
>
> From: Haibo Xu <haibo.xu@linaro.org>
>
> Allow virt arm machine to set the intid for the KVM GIC maintenance
> interrupt.
>
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
> v1 -> v2:
> - [Miguel] replaced the has_virt_extensions by the maintenance irq
>   intid property. [Eric] restored kvm_device_check_attr and
>   kvm_device_access standard usage and conditionally call those
>   if the prop is set

This seems reasonable, but it's not the same way we opted to
handle telling the kernel the IRQ number for the PMU interrupt
(where we use kvm_arm_pmu_set_irq()). I guess we have to do
it this way because it's a device attr so we need to set it
in gic realize, though?

By the way, does the kernel automatically complain and fail
if we try to enable nested-virt with a GICv2 or with a
userspace GIC, or do we need to catch and produce error
messages for those (invalid) combinations ourselves?

thanks
-- PMM

