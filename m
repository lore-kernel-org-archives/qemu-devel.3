Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E63CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 15:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBBV-0003kx-9y; Mon, 15 Sep 2025 11:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uyBBQ-0003kS-Lp
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 11:32:01 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uyBBE-0003sC-8o
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 11:31:58 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-887764c2868so376721339f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1757950293; x=1758555093; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aq6RCJ0wdukZ1Q4R5ZbXYvLxhYL8PqHTPfLVyEwUqrQ=;
 b=SdP2tajq7gKsJsAOd0qBhd/8ay97oCESy21FmqGMldtYYcgricycUljm9WGxzv26vI
 j0aw0NAtsJvXPrnZhKO11JzBYwi8uHD/5K5jejSJpA5r1SXOfF4d1Bh3AIP1CAc7HhlE
 UX3Q2smhLSGmsDbsb0qngOD+YP4RJ1BplqtFhANr5eqNTqd532V3LoivdDheDtbD87Y/
 fAhenMS5fQKdzEquhJpZSpEuzh2dTTcA4NvyLHygkt1MVIWdXBXd2DIrYVJ33jNkhxJ7
 vkk5ON94y/aYZJfrYehL/cUc/oXtqubPJHFXAFxzR9cv16OAh6t1yLojPByrP3z0R1U8
 3MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757950293; x=1758555093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aq6RCJ0wdukZ1Q4R5ZbXYvLxhYL8PqHTPfLVyEwUqrQ=;
 b=sgkSrX6ql9svGyJWS7tgLW4bpe/M86ZB+TiD8/M6deu+RqG4WEydFuSdnyaaSj5PYF
 lG8s3P4QaC3kPFTJliDs72pbuhQta12eRJJem8tcaQ/RAZEbW7gZoUviETWQFXkpYGka
 5qN/ZxQbobhfFFn+XZ3Kc24Zg0EruA+caFI65rwbf6ax4KkGcZrsb24I4OqbA4AniZWa
 PFlO15kqJ1ud5Upk/ZYba2aCeV6t7HyWRBqCZHN1GQeph/6Bs3AsRKioxJpBQeRAaT5i
 qKzvxkugNj5R4mLAvVDxvdUtuQusoj99gFswTKd1O3wIviw3l+vPT89vfhakhJpUnuvo
 GOIA==
X-Gm-Message-State: AOJu0YyA6gmPMg2BnVnZE9u9L15mbpka6AgznsC7h672HR39eTRjsMqZ
 2fMJi0T0FGVlGrHBqPAMFw9OdPjc53Zz7Ud9qkFOpQwMd+WGlLpqn2TTHSe64QdgR1s=
X-Gm-Gg: ASbGnctp37PN9cC5UEIcTWoplP94UorT6kAiACelHGvR57kF6tBJNKq1osZB3kGbrYf
 qzfM6g9Zh40b5v4QnOYWYq/4lqztBwrVMhDpWdkpf2QPd2xWbrwcbiWLntdfKzH3N4wXT+AKLkg
 my9Z3OOQcIZRE2ypTA4qDzzFDnoc0ZxGgB4748sXbzqr8Nxhuo7ngSotb5qt5JvI1uV6zerdETM
 twXNNVH+r9WeKv7vOREPsak0fc7eK3Rt0vfUVW4Kn80x1drQpq2rjXUbB5tHrpnZ3ZDQyoDzbjS
 /fdMa3ovDzVqfuDX8kmeap/6tbFu4Y9S6tPQLNTHhCsloRyBcUrjD5ZGRcQoAE1fMwHSQuLNY20
 ZW0brxCiu8rU9pQh/4RaK+f9cxxhiN0ZkzAA=
X-Google-Smtp-Source: AGHT+IF+RoXGyypxsQmN5LU58CWXW+LffefM+VQMEp0Wt0n4UMehnF3ta5VR4L9fSYiwM9x6UIJ9hQ==
X-Received: by 2002:a92:ca0f:0:b0:424:7bb:775c with SMTP id
 e9e14a558f8ab-42407bb7949mr28284665ab.31.1757950293164; 
 Mon, 15 Sep 2025 08:31:33 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4240a4cc099sm6178925ab.29.2025.09.15.08.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 08:31:32 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:31:31 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Xie Bo <xb@ultrarisc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com, 
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com, 
 rkrcmar@ventanamicro.com, palmer@dabbelt.com, xiamy@ultrarisc.com
Subject: Re: [PATCH v9 0/2] =?utf-8?B?dGFyZ2V0L3Jpc2N277yaRmk=?=
 =?utf-8?Q?x?= riscv64 kvm migration
Message-ID: <20250915-da26ba5c012a2d49fb07f4fa@orel>
References: <20250915070811.3422578-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915070811.3422578-1-xb@ultrarisc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=ajones@ventanamicro.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 15, 2025 at 03:08:06PM +0800, Xie Bo wrote:
> This is v9 of the series. Compared to v8, the patches are now based on
> the 'riscv-to-apply.next' branch from Alistair's repository:
> 
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> 
> Changes since v8:
> - Rebased the series onto [alistair/riscv-to-apply.next]
> - Removed the previous 'Reviewed-by' tags due to the rebase

Please don't do that. If the rebase doesn't require a rework of the logic,
then the patches don't change in any significant way, so reviewers
shouldn't need to look at them again.

Anyway, for the series (since I can't see any difference from before)

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

>   * The changes are purely mechanical; no code logic was altered *
> - Added 'Cc: qemu-stable@nongnu.org'
> 
> Xie Bo (2):
>   Set KVM initial privilege mode and mp_state
>   Fix VM resume after QEMU+KVM migration
> 
>  target/riscv/cpu.c           | 17 +++++++++-
>  target/riscv/cpu.h           |  2 ++
>  target/riscv/kvm/kvm-cpu.c   | 60 ++++++++++++++++++++++++++++--------
>  target/riscv/kvm/kvm_riscv.h |  3 +-
>  target/riscv/machine.c       |  5 +--
>  5 files changed, 70 insertions(+), 17 deletions(-)
> 
> -- 
> 2.43.0
> 

