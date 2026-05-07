Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66AFCD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKyaO-00076N-Rm; Thu, 07 May 2026 09:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKyaN-000764-NM
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:16:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKyaL-0005Ax-V7
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:16:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488ad135063so7848185e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778159772; x=1778764572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Z0+oa938l3ufeED3BGbuZ+8qnsGi+jWTcLM9XcDp6A=;
 b=y/dwI+L1D6yebRaljeQ9jQh0mXv7muJB63Op7ORNmUUM5CWWuy1H1zcU1r6PJKQjhg
 mWBiBF3dSJs0anoeuzlCYlcvYWsndH1I92wCRU4+s4zgTYsflAdKbtoPT30SfG/oO/GN
 JTavuNfBzw78rq9fHo5QaoLGc9hLVnWyedsCNlm8XyAd0cJiC9eHnvYbOqpnLxdwtgPV
 uWu/4kqp3bkTZ8zvoqjvs2gt0f359xQVjYyucdx2aG8gV5DfuyhkziafmZEX6nSl3d8l
 oWnspOeT5TKaWhz8YGYgyayJoRLV9jEr9mP4oSai+kceJ0NnXkrIAbyIfFG9iS3Mbm3C
 +PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159772; x=1778764572;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Z0+oa938l3ufeED3BGbuZ+8qnsGi+jWTcLM9XcDp6A=;
 b=p0irAJ0tQP3LWZpBcGiropwxCCDxdgvAvKWyZDzhv2wpAfpLSY8AOrsK4PT4Uy/p6Y
 V9CBXfVm6uChiPQaVp/ta4nd6GKUPZNdeN161IgOXQ1++q/7mlKUcOEwysxAF5e23VUF
 RqRNhLfSmROjV/c8mR8/sFDqk68Mnb31f1nj+G5L/pRbBtVDXM/f2HhdthwerwRYrsC9
 rbGcArN+xOl3KdVlR9QEsM6H9hG6UYiYYDkKIyZmZUiX0PwTi0LdmrRzCT03dBqUIwb7
 OsQsQdU/Uu8O9hzN+HvS5sIG7g2KDJMsNHk9GX+hoq7FXKskuOg4Z9+4MJokwdA7fWR2
 VW/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7vt50YcTT1xkxFM+yReYoX602sMQ645KpthPMeSC9wMPeSt53pj2eHj2oeM5CXo7cFtnwGKYxmEbE@nongnu.org
X-Gm-Message-State: AOJu0Yw+XjbX1D3K3QMoSpc9HJaihfZUD57XolvFJdBFqUWmVs0vHXL8
 OF4fnNRWo3FN9cDzZmQAFK8akqrsaXcDWT4ZQUXK1n7EfIvOByodBhb5g9ZpfnHh5jQ=
X-Gm-Gg: AeBDiespLrE/XqbDHZdrC6j/NAdAcuARTKyEoyD8fsz64gGXTCVI5uwB2OFHeP/nsEG
 3z/pgwnwe9tdYuKnAlUaArpWi3wPfnZLpLvaeP872nJ7cW2Tr0uXJd1eO+5z3ygGeU6n3WAXTU9
 dukBY7FT0Y7rgLVBev7OOJEslOKb1pz8aNTWnRi4GlVlONyEQiCsJAMCOTpWhr/6g6Q0fzN+cUT
 895tOJcppGoudOq1Pj8AyLI9bJeoXSlBdbiiRVfcJzbkUYbh1FADp7aynalfF8JVTWzQi2amVOB
 3iquolGgqk/kUDFBsjsv3MvbwoalHtjMjBASFQW/bNetKPmHfvDofGSEltnR0+Quvcd0Ls51DCp
 lLmb0mgm2pWrya3nVEN6HFusynX2OkiZa+/xS1THdTLwL6twkHrC0LwnBGU+cglWh9vpOKzq72h
 C7OgJIlir06yF+EPRa1PwFP3SM95dLBNtY8Bxzw8JHrOpVablCfg364OBJejBYr2YmvB7bqAZJd
 WtQ
X-Received: by 2002:a05:600c:a305:b0:48d:361:4df6 with SMTP id
 5b1f17b1804b1-48e51e19680mr92005395e9.9.1778159771738; 
 Thu, 07 May 2026 06:16:11 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53826022sm134267745e9.0.2026.05.07.06.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 06:16:10 -0700 (PDT)
Message-ID: <7bfd11f9-66be-4e4f-8e9e-a031d848f890@linaro.org>
Date: Thu, 7 May 2026 15:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Replace abort() with g_assert_not_reached()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260506152353.1657838-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260506152353.1657838-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 6/5/26 17:23, Cédric Le Goater wrote:
> This check was originally introduced in commit b3ebc10c373e
> ("vfio-pci: Add debug config options to disable MSI/X KVM support") as
> part of a debug block to retrieve the MSI/MSIX message, and was later
> moved by commit 0de70dc7bab1 ("vfio/pci: Rename MSI/X functions for
> easier tracing") into the main interrupt handling path, becoming
> production code.
> 
> Under normal conditions, this code path cannot be reached because the
> BQL serializes all handler registration, vdev->interrupt updates, and
> handler removal. Replace abort() with g_assert_not_reached(), which is
> preferred nowdays, and add a comment clarifying the purpose.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 09acd3f6082b0a9c5223780bf7e9847b57424cf7..7ca2ff4e7c1cb570cd60d35454b33b5506dae36e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -453,7 +453,12 @@ static void vfio_msi_interrupt(void *opaque)
>           get_msg = msi_get_message;
>           notify = msi_notify;
>       } else {
> -        abort();
> +        /*
> +         * Interrupt state transitions (MSI/MSI-X -> NONE/INTx) are
> +         * protected by the BQL, and eventfd handlers are strictly
> +         * unregistered before vdev->interrupt is modified.
> +         */
> +        g_assert_not_reached();
>       }

Could be more readable using switch(vdev->interrupt).

