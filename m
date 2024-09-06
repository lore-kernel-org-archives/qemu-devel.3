Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ECFE6FE27
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smaw7-0001GW-Cf; Fri, 06 Sep 2024 11:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smaw5-0001E1-Ck
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:31:45 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smaw3-0005vK-OE
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:31:45 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so2325910a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725636702; x=1726241502; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A9+gbxCIPjczikelfZDHbBbmO3fyOOpEb+ES5eFNeK4=;
 b=b5TH7BuXbNVoqmMAeoeRBRJ6CkyLPS2GpHiNvzDJ+xiAvk3DGeFi37qlmsIia6CFll
 47+Fh93bEY0pYXGHRac5k5l5fOx97Cmkv3JtuuKEFNr6CuFksrVS7CEZj8j8k5KEsBAu
 nQ5mSDtS5migd5IFssHBKsJYkZ889L88SSWAt6G71UQm+iFd9nqhGJ84+6ZyywcRtZzx
 4POPnPc47JzKSVKEqz9wn+Wux7B/ysCKQ7+dus55Ek0A8W1JzlPnZ3BBPWJj9CICL5rK
 X2IY5Cw8PJFTbteObpjT2kHPKEnB4UCkefQDK7WPESPeF1a/XPtLKeJWqir/vNx2fgF9
 cJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725636702; x=1726241502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A9+gbxCIPjczikelfZDHbBbmO3fyOOpEb+ES5eFNeK4=;
 b=mO1+rD3o1gCk3NKfic/pUOtUZUChBBBF19S4u9qgR1gFSWmoD8NWwfAKkuGss0als0
 nZ33UQ2G7mmfDWA5ylztNVnM2wSCmVaSb0lekogmEkwy8ayj1TPQkXrj73Y8DReBgpBX
 YNebMfpes7SI/yOXHcex1ybUZ69XA4h02iYFwAv/yFZsFycNuwIIh/rQzV0TyMqqiwYm
 HV8u+G+M5tB5X1sYdf9qHzw394AFhFtcGr36lmMq2+67crb1vzzn4mxmN18pZZ6jcsP/
 +OA39+vTJr73kKdEl34s58bgsjBYP/2Q117SyZPXUu9hECA8MedfY3yy2UrwkiaIcNhF
 9pUA==
X-Gm-Message-State: AOJu0YyzgwmOoqPAaF5ye4HCCnWi81cXl+q+nsS21kQgCBZoSPF5BXZV
 3bQtQKMjqnMaDUfykhmFaMCpED3N4SNsP7lqSmiJMKteXrjNOUmxfvhEZg+pGqQYEZRFwvOBJFd
 Qt5m2x5daRHDa1jwe9t/WtfCIxmCVmz+AHZgeSw==
X-Google-Smtp-Source: AGHT+IGoUU9jhEyIzyOFa5nTPtzbc+FXy7FE33HWB1i4t8O2lQafpwLM3W/JB606Y3FyXZ4P9ixssM8YPhgcdqP4x3M=
X-Received: by 2002:a05:6402:2793:b0:5a3:283d:b05a with SMTP id
 4fb4d7f45d1cf-5c3dc799624mr1608940a12.17.1725636701954; Fri, 06 Sep 2024
 08:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240828111552.93482-1-danny_canter@apple.com>
 <20240828111552.93482-4-danny_canter@apple.com>
In-Reply-To: <20240828111552.93482-4-danny_canter@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 16:31:30 +0100
Message-ID: <CAFEAcA9ss=VL=hRZMgN32XmeKGjXmQW9aYjcLmSe_sWSAcQKHw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hvf: arm: Implement and use
 hvf_get_physical_address_range
To: Danny Canter <danny_canter@apple.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, dirty@apple.com, 
 rbolshakov@ddn.com, agraf@csgraf.de, pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 28 Aug 2024 at 12:16, Danny Canter <danny_canter@apple.com> wrote:
>
> This patch's main focus is to use the previously added
> hvf_get_physical_address_range to inform VM creation
> about the IPA size we need for the VM, so we can extend
> the default 36b IPA size and support VMs with 64+GB of
> RAM. This is done by freezing the memory map, computing
> the highest GPA and then (depending on if the platform
> supports an IPA size that large) telling the kernel to
> use a size >= for the VM. In pursuit of this a couple of
> things related to how we handle the physical address range
> we expose to guests were altered, but for an explanation of
> what we were doing:
>
> Today, to get the IPA size we were reading id_aa64mmfr0_el1's
> PARange field from a newly made vcpu. Unfortunately, HVF just
> returns the hosts PARange directly for the initial value and
> not the IPA size that will actually back the VM, so we believe
> we have much more address space than we actually do today it seems.
>
> Starting in macOS 13.0 some APIs were introduced to be able to
> query the maximum IPA size the kernel supports, and to set the IPA
> size for a given VM. However, this still has a couple of issues
> on < macOS 15. Up until macOS 15 (and if the hardware supported
> it) the max IPA size was 39 bits which is not a valid PARange
> value, so we can't clamp down what we advertise in the vcpu's
> id_aa64mmfr0_el1 to our IPA size. Starting in macOS 15 however,
> the maximum IPA size is 40 bits (if it's supported in the hardware
> as well) which is also a valid PARange value so we can set our IPA
> size to the maximum as well as clamp down the PARange we advertise
> to the guest. This allows VMs with 64+ GB of RAM and should fix the
> oddness of the PARange situation as well.
>
> Signed-off-by: Danny Canter <danny_canter@apple.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

