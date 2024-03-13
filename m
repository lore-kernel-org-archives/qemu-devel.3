Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7C4C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 17:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkS4o-0007Bu-SK; Wed, 13 Mar 2024 13:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkS4n-0007Bl-6K
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 13:07:37 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkS4l-00022a-FD
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 13:07:36 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5684c3313cdso39376a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710349653; x=1710954453; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1dndxGRUVfj+9M4zce/Dtz2IL1hO6I1odBCY3PbzfdM=;
 b=Kd4jBkd5fDxdlLXYL+c4v5og1wq03H1ZzlBjkTotOgo2QZLzvynaMQwJAHSrAZ4wB7
 ScGTnoXrV/4lGQSGmk7qa7RT26Eau3trkJmtbnTGeiCDaDLtcuzksuVwIIQCv6cI3/2/
 cEREuGJjN2GT/qP/mnuAn6oI0VAHyTffKfHCE63cN4BCJ9SIFy4pPMuk/1DFVFKROpGJ
 Iuaf4fULDj5Jmc6m3E95xfehcm9l4UD5nBEAdElDd8xkFsN/56N4Z5jetYlEF18uGS+X
 GgWD6y8ogTAk4Xy366TjFoEzjEKmlbhK9jKTYYtJyVf59DpNqfUyi4kQwM2J8HwXhmLM
 Jz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710349653; x=1710954453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dndxGRUVfj+9M4zce/Dtz2IL1hO6I1odBCY3PbzfdM=;
 b=dGbKiE/9Sh0GO+0ZKuenzTBouacsjoePd/7Wt/bCKW9DhCAv9L6Dm12LTFCI6tQt9G
 OcbpX9tllpfuZC7sxwGL02E5nyiIliOnWKqZGPpZ6yZ+kjfKN6OTFwGtDtXwq6Q5vXbq
 X3hXub9DGTzQI2UhbCsr4MXJQO7sDcun/vEiAuv6t2Br4bn5HdqjKn821C9b7pU9CmKE
 3uwLrr/B9LfpkY0H3ZsIYXYaucSgFPKfrP5ZbKZ93thS3rD2f+Mcxxpm6oN1SE5w2kTZ
 nsUY18XTEyfH2DEjd96on4y0HREaPaxcBMCBKpDedxT9hvVS59bF2SIG1CS1QfWIQpyi
 0vYw==
X-Gm-Message-State: AOJu0Yz7jUYzaT1OoVVuui8PGMpbWiHep4VfqCtAEiiBL7xLFQSfeahN
 orQScT4+2glcEVX19doCVysKVUVd60g976H1eSMVOGnmuRdGXPR+81en1pnlXqHO/dl/Fmh2gVP
 LPAMSMB/YdHiNWbg5TVAIkMrNfTputothBpU7UA==
X-Google-Smtp-Source: AGHT+IESHCBJ2BsUCQiSgam9WVZcEvKVL2WOD0s5KUFcWw+QqBvEVg46JlW8m58pZGYvvHIGUUd/6Ih+gea8ISEeSL0=
X-Received: by 2002:a50:99c3:0:b0:568:1983:4913 with SMTP id
 n3-20020a5099c3000000b0056819834913mr9239163edb.23.1710349653155; Wed, 13 Mar
 2024 10:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1710282274.git.mst@redhat.com>
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Mar 2024 17:07:21 +0000
Message-ID: <CAFEAcA_6dBsFM8E6HGd6=v43FQ+vn-n8q3aTB58yCGLB00hVmA@mail.gmail.com>
Subject: Re: [PULL 00/68] virtio,pc,pci: features, cleanups, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 12 Mar 2024 at 22:25, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:
>
>   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 73279cecca03f7c2b4489c5fea994e7349eaafaa:
>
>   docs/specs/pvpanic: document shutdown event (2024-03-12 17:59:57 -0400)
>
> ----------------------------------------------------------------
> virtio,pc,pci: features, cleanups, fixes
>
> more memslots support in libvhost-user
> support PCIe Gen5/Gen6 link speeds in pcie
> more traces in vdpa
> network simulation devices support in vdpa
> SMBIOS type 9 descriptor implementation
> Bump max_cpus to 4096 vcpus in q35
> aw-bits and granule options in VIRTIO-IOMMU
> Support report NUMA nodes for device memory using GI in acpi
> Beginning of shutdown event support in pvpanic
>
> fixes, cleanups all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

