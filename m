Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4FFC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPua-0001gY-Qe; Tue, 18 Feb 2025 10:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tkPuY-0001g1-Ki
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tkPuX-0004Na-5O
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739894004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2zxSz1CqwY+GhnY4zwjzPve3eNygbdqAT18E2j3Et+A=;
 b=aWWMF7dPF1wjUf4Gptjqfz2AjXGYCjIFoL+ueySfYXTuDbcfXmp/TXeQf0j3p1QabPetgL
 DAzGX8XNBtjP3N2HjtKDRvJkqP754OvxuNzURhegbWAuMbMbn5U+BHI/c3DvqZkQS6mo1v
 mAu5zcs4BnQ4UNbqsbLa/7B5Jm/IwcQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-c4uPWJKaMaeuDK7A1_1L-w-1; Tue,
 18 Feb 2025 10:53:18 -0500
X-MC-Unique: c4uPWJKaMaeuDK7A1_1L-w-1
X-Mimecast-MFC-AGG-ID: c4uPWJKaMaeuDK7A1_1L-w_1739893997
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A16118EB2C9; Tue, 18 Feb 2025 15:53:17 +0000 (UTC)
Received: from gezellig (unknown [10.44.34.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D12A19560AA; Tue, 18 Feb 2025 15:53:12 +0000 (UTC)
Date: Tue, 18 Feb 2025 21:23:08 +0530
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com,
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com
Subject: Re: [PATCH 0/8] riscv: AIA: kernel-irqchip=off support
Message-ID: <Z7Ss5F3t4R2GbIcu@gezellig>
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217081730.9000-1-yongxuan.wang@sifive.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 17, 2025 at 04:17:20PM +0800, Yong-Xuan Wang wrote:
> This series introduces the user-space AIA MSI emulation when using KVM
> acceleration.
> 
> After this series, RISC-V QEMU virt machine with KVM acceleration has
> 3 parameters to control the type of irqchip and its emulation method:
> - Machine prop "aia" controls the type of irqchip
>   - none: use PLIC and emulated in user-space
>   - aplic: use AIA wired and emulated in user-space
>   - aplic-imsic: use AIA MSI, emulation mode is determined by
>     "kernel-irqchip" and "riscv-imsic"
> - Accel prop "kernel-irqchip", effective with AIA MSI
>   - on: in-kernel APLIC and in-kernel IMSIC
>   - off: user-space APLIC and user-space IMSIC
>   - split: user-space APLIC and in-kernel IMSIC
> - Accel prop "kernel-irqchip", effective with in-kernel IMSIC
>   - emul: use MRIF as in-kernel IMSIC
>   - hw: use hardware guest IMSIC file as in-kernel IMSIC
>   - auto: use the hardware guest IMSICs whenever available otherwise
>     fallback to MRIF

Hi; as someone new to the RISC-V ecosystem, most of these acronyms feel
impenetrable :-)  I see they're all RISC-V interrupt-handling related
terms.  I hope you don't mind my spelling them out here:

  - AIA   : Advanced Interrupt Architecture
  - MSI   : Message Signaled Interrupts
  - PLIC  : Platform-Level Interrupt Controller
  - APLIC : Advanced Platform Level Interrupt Controller
  - IMSIC : Incoming Message Signaled Interrupt Controller
  - MRIF  : Message Routed Interrupt Facility

[...]

-- 
/kashyap


