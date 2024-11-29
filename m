Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07653D729E7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH3Br-0002Up-Ce; Fri, 29 Nov 2024 10:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tH3Bc-0002KC-H6
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:45:40 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tH3Ba-0002Q9-IR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:45:40 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cedf5fe237so2224165a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732895137; x=1733499937; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xY0FKEodQHPz/11pBa7OFxejnwb9hbb/WI5ABs1FEHQ=;
 b=mdPh37Tirvb04rwHGy77ZKo9f6tblxZfXOQevyp6h7oqLdnXvjLHI8N4n1ouaDtB1z
 WtQbiJzVwnFf/iY/1BKEFteMoYVlwLl+tnHCTS6N7+5kyugXvlDmFqbXwvNATCjUTn+M
 xIksrgV/3hUTSPWiYybryA1FMFQ+kkDNX5DTyXf0K4ZuAP+LA7Vf59dNdCx3TwqLtwDc
 n0RTMIqiE4IPzNiG+BjOAwviyEk8MU/vf3eJFKHfKmKizurrIrwnR5nndNeOqDib9mPI
 +o902bjyrVscnVVh2KI2uytvvJuPKIUaTWAuZ7gNQk2mPhst19ocDBP7umy1/f/BSkqY
 lFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732895137; x=1733499937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xY0FKEodQHPz/11pBa7OFxejnwb9hbb/WI5ABs1FEHQ=;
 b=JaJW+jEmyaRwhbBVTxEY4L4Gy8R0t+siqeeSmkzUSRQZ9QoS9MkhT+MXxcoA818f44
 zyDgtAXgHwhOJV9r4/NyGWt3yyQ8+D/mIONnJf2FBSdYUIDcEEhRrsMO8vlwIpmhZnpY
 MhpQkFx0+ZBWWXjSMRxhbDu/M+MqTcSPnhRf5rkx8uV15ZiUxdeCdDrXmIMq5DMdeCdN
 XvXviRqMUOX5pwreffz566N7Ub8s3cksamoyBk/kuYaS8utdDI9m/4/1pO4eE7hHMLH/
 X0cz2mI/ur0cAkSAtHnc+gafj6gJZSWQ8rDREJv05HZV1j4aHMiCL2LUG1CJ4Z4YauRl
 OzFw==
X-Gm-Message-State: AOJu0YwyMGlHxrf+/iySH0ECcFGU/A92+jcubyoW8MDKg3YjFTX26Vqv
 9hkNfLonzg0PqWqH5+HfIvItcfj+AP/cPTNjNMYSO782Pz4jvadcQQar6rbSxOtjs8kdw1HInH0
 0YBEBZy8XMea/6qaJWXBoskp4s0e3A8qM/LtLTg==
X-Gm-Gg: ASbGncuebOGgXdvfDcNZ9EBrAfF1BqdADfrUevdxsqEfb+EalnbgO15leBed2F7FE9u
 2/dDmj+5mnEwnARi/6NBosPKp2OpSjDbj
X-Google-Smtp-Source: AGHT+IGOkDFVvXN7vxGRixQ2d+8EHIzAgluxMOLFNGofe595di13w5kPt57ZBs3yhMIiMXymc0bERLwwyWYp6nUu4pc=
X-Received: by 2002:a05:6402:13d1:b0:5ce:fa47:2597 with SMTP id
 4fb4d7f45d1cf-5d080b989cbmr10731242a12.9.1732895137042; Fri, 29 Nov 2024
 07:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20241128190349.541014-1-pbonzini@redhat.com>
In-Reply-To: <20241128190349.541014-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2024 15:45:26 +0000
Message-ID: <CAFEAcA-PFWSv88Hy3BzOHD6oc3+0NpA2FCA1NEHjcAXUpqL_UA@mail.gmail.com>
Subject: Re: [PULL 0/3] Bugfixes for QEMU 9.2 rc3
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 28 Nov 2024 at 19:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 24602b77f5658ae8377958c15fdef2f44affc743:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-11-28 10:50:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3abb67323aeecf06a27191076ab50424ec21f334:
>
>   scsi: megasas: Internal cdbs have 16-byte length (2024-11-28 18:02:22 +0100)
>
> ----------------------------------------------------------------
> * amd_iommu: fix clang failure on non-KVM targets
> * target/i386/hvf: fix advertised 1G page support
> * megasas: fix CDB length
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

