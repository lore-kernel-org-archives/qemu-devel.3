Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066E0C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 10:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udnhD-0002nD-Oj; Mon, 21 Jul 2025 06:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udnh0-0002d3-5J
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:24:26 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udngu-0007D2-Oy
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:24:20 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-718389fb988so39251287b3.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753093454; x=1753698254; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GJ6uqOViAPbOJLlHUrS3N+RdrRHODubV68Db/kn3ld0=;
 b=sveU0Pe9gUrRU16dSwQzqDYaxAZdJb5rKIB9mCXl/mgl0guc92qfk10mscZlu1r+UH
 fOFyBH6PYpNebBnzaYRtK4Exzqavu0f2UgsGNkyLVuGJVguurlq2pM6e0lg5IknE793u
 3ffdKP2OvqIrmI+xpZp6xr4FlpzvC0dzWPY7rNG/fmz25vDNwWQJ6YvzsftkaybNxbHi
 5fZrn27ppxk2LfP2KI87qYYoY67SAURAzBMFY7rFMO9+AOj8cLTLIOv4bDN5larJHNtY
 102NlRR+kK0xEWTpVsyoF7IxUQsYuMd4zIf908vZ8klUBTjemCtl8sMXp0GTjlqzYqdd
 Wh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753093454; x=1753698254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GJ6uqOViAPbOJLlHUrS3N+RdrRHODubV68Db/kn3ld0=;
 b=VwhOuv6eNFLWZ7b7bZX8LS3CEDG+FwfJwj0c8WE1v/CcMmXUjnUDXgJcp6xzIL+GhR
 ZBZOapa5x1LvBHAQOvIviFEZhQXswaD8pfl9jmapzIGbQllJFyMmkJ/gg19JpaWea7Ls
 9qQdfuWPociudUpf0nRFIiKFU/XS+4wM7m6+jxTsP6PlrKzxdpwuhK68StRhdNzu/mzd
 tzecaODzO4t3MuwnRp84F5FMRy/Noxmqt5zIZ1YrGbvQobF5h2esKmaSQws13x0o7t6T
 43Wt7dy6Y7XOsMzi1GPNF63kgNE1FXTPqm3TtNkClIDyGxR5vp0awJQ8fVZcO8lbRqif
 hRsQ==
X-Gm-Message-State: AOJu0Yx2fuOAubM94rsvl+cjH+bJSytFTvUL9cwrdSU1/+aUxJveYC51
 0ktJVDh4N6sUexGoEFG9jq66weUDFXuKUNZSoRKb1oDmec8JHU6qXs+CNwBTnalwEJD9jnLfvVs
 +6LaiptQODADSHHnNXfvalEJ9efEbU0TnG5X6AX/PsA==
X-Gm-Gg: ASbGncsE/926R15ED4TVbogLJJEkB/rX33/WcUK0eCQ5UZOqIYoXnfOWP/TFammYImq
 E3tLIB3JRhmAzpiGyKeL4Ij3W0WjNrXGM6RDf+DLM6cW/QCDAzbViGkIkSP4UIHoErgwNV36dbw
 ICz8bqySutZKWMlLOTTe3ZcIsmQwLcuf1FNsF85CwHG6Vi1RXbnw+ISCKm/i6frOlLf/UBnjXFH
 TLy/WzToLOzc1g2dY8=
X-Google-Smtp-Source: AGHT+IEgwaVzG4dA2EqTWbfV2LWgTRz4F7pmlf7dT7+yvuBFv5XSMGWd/iwIQv7MDlUcQs0GjFDnQTGMdJ5kXsWNNnI=
X-Received: by 2002:a05:690c:708a:b0:6f9:7920:e813 with SMTP id
 00721157ae682-71834f35972mr257448697b3.4.1753093454129; Mon, 21 Jul 2025
 03:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <1752689274-233526-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1752689274-233526-1-git-send-email-steven.sistare@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jul 2025 11:24:02 +0100
X-Gm-Features: Ac12FXyJSZl5bbScTOPgx7crSn9ufYk-18PhO6bLLQGobQw11xFUK9qOhuNGDVc
Message-ID: <CAFEAcA8P4H7n=uXe3qredxVMwB4QtDfZtVyuuTWBLwa6enGR3g@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Cedric Le Goater <clg@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 16 Jul 2025 at 19:07, Steve Sistare <steven.sistare@oracle.com> wrote:
>
> Close a race condition that causes cpr-transfer to lose VFIO
> interrupts on ARM.
>
> CPR stops VCPUs but does not disable VFIO interrupts, which may continue
> to arrive throughout the transition to new QEMU.
>
> CPR calls kvm_irqchip_remove_irqfd_notifier_gsi in old QEMU to force
> future interrupts to the producer eventfd, where they are preserved.
> Old QEMU then destroys the old KVM instance.  However, interrupts may
> already be pending in KVM state.  To preserve them, call ioctl
> KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES to flush them to guest RAM, where
> they will be picked up when the new KVM+VCPU instance is created.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

> +static int kvm_arm_gicv3_notifier(NotifierWithReturn *notifier,
> +                                  MigrationEvent *e, Error **errp)
> +{
> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +        GICv3State *s = container_of(notifier, GICv3State, cpr_notifier);
> +        return kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
> +                                 KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES,
> +                                 NULL, true, errp);
> +    }
> +    return 0;
> +}
>
>  static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>  {
> @@ -883,13 +895,17 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>                                 GICD_CTLR)) {
>          error_setg(&s->migration_blocker, "This operating system kernel does "
>                                            "not support vGICv3 migration");
> -        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
> +        if (migrate_add_blocker_modes(&s->migration_blocker, MIG_MODE_NORMAL,
> +                                      MIG_MODE_CPR_TRANSFER, errp) < 0) {

Why did you change this? It's the general "if no support, can't
migrate at all" check, which seems unrelated to cpr-transfer.

>              return;
>          }
>      }
>      if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
>                                KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES)) {
>          qemu_add_vm_change_state_handler(vm_change_state_handler, s);
> +        migration_add_notifier_mode(&s->cpr_notifier,
> +                                    kvm_arm_gicv3_notifier,
> +                                    MIG_MODE_CPR_TRANSFER);
>      }
>  }

Otherwise the patch looks OK in general shape, but I know
nothing about cpr-transfer so a review from somebody on the
migration side would be helpful.

thanks
-- PMM

