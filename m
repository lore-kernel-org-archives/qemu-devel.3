Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAABC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0LH-0001YU-CI; Tue, 12 Mar 2024 07:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0L1-0001PD-Bz; Tue, 12 Mar 2024 07:30:32 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0Ku-0001Xa-Mq; Tue, 12 Mar 2024 07:30:29 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so4632352a12.1; 
 Tue, 12 Mar 2024 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243022; x=1710847822; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uor0G67/D+BwbZvzpJc+hvLYP4vJA78Iixftpd9ykdk=;
 b=YZVsYp+RCz72oJsyz9loICocNZkfh0CBPqjJMM4ail3c+Hlam9z+1zsBl7J8Qql/Gc
 za7ankB3BALG7NiZJ6GPHgCzePJkpVjhuFeOrP9Ie/Mr8mrb+f1AYcJN1C2kQa6AH1Ox
 CcsYRYzFAXBilKD7sWOTWKMvye7mbZIOar3AdX/XRQlwua+gy63WrUbKLHc0u7+tKKau
 v/9qadfHj4bVB4nlqyX09/8OslYn/wxnaGRZvuj7zq1Tgh3O2Hll/SzDRZeNPNKnJGiM
 TRhFqEG8iCh5Yi3TRRJq/t6VGV4SaN/TAv3RM374eJrCNcQx4mO447W3LrnBlg0laqtf
 R8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243022; x=1710847822;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uor0G67/D+BwbZvzpJc+hvLYP4vJA78Iixftpd9ykdk=;
 b=jby42vKsD0DVrWoHBOEXMC3/Vt6BHbEIT8WAeaTTOsWxrVsQII5LOiJsjcdHDpqhwi
 uEliEgWNkpnlzzoR6tjMdR900Lgmzp7b9m2iGcbRC6oXg5ZK6Aj+kyH/iVLg7TvlqSx5
 MPr4d0h8PPJ5gaO+zQ/mA7DvjDm3PiFxoJt+dGdo5ueJSR8zNhUa3BQPQwqSry4FXT0b
 4zcKa5r0eHlKLOl+ktAxVv0T48CNHYxxB9OnIbmQKYIEyNHjYyqyu6UL+nSg5IrhlFnB
 pyiCXPCXAOYqdvgVyRgX3ng30ufYpLf14Ct7u5JOp3sw5bhJLdkMv/Rc8dQwkHuCl7ft
 zAqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrc7eswxEx7KC3P1BMHewgFzQPHo7VtdkgJXZ2OzzRGbmWUfooqdyukp6MYx34BK7mG+uXpNeSNmI2+lsD6cKCrvBIH3VcxMsPrG6F3ltZigEa6uW9vSzp2Js=
X-Gm-Message-State: AOJu0YwgGWX9D7g5wxSK+4lssSUuB/I3Hb6wE8hHinkdsVkZSWvCZlHM
 8bOfeo5Im6HlbMrIHOG322EtAcoqgCbgP1E/ozgZVy7Zais721cV
X-Google-Smtp-Source: AGHT+IF3F9NJF/zEWSjqpPiqvajT6FYziPwG53A/661tNA8937kvWX2LHLRITW3H9n6kfecuIZAdLA==
X-Received: by 2002:a05:6a20:3d01:b0:1a3:f17:dfca with SMTP id
 y1-20020a056a203d0100b001a30f17dfcamr10087510pzi.9.1710243021884; 
 Tue, 12 Mar 2024 04:30:21 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 m22-20020a056a00081600b006e52ce4ee2fsm5922076pfk.20.2024.03.12.04.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:30:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:30:16 +1000
Message-Id: <CZRQJV9HJMW1.VW4G3Q080Y1O@wheely>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 05/14] spapr: nested: Document Nested PAPR API
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-6-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-6-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Mar 8, 2024 at 9:19 PM AEST, Harsh Prateek Bora wrote:
> Adding initial documentation about Nested PAPR API to describe the set
> of APIs and its usage. Also talks about the Guest State Buffer elements
> and it's format which is used between L0/L1 to communicate L2 state.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  docs/devel/nested-papr.txt | 119 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 docs/devel/nested-papr.txt
>
> diff --git a/docs/devel/nested-papr.txt b/docs/devel/nested-papr.txt
> new file mode 100644
> index 0000000000..90943650db
> --- /dev/null
> +++ b/docs/devel/nested-papr.txt
> @@ -0,0 +1,119 @@
> +Nested PAPR API (aka KVM on PowerVM)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This API aims at providing support to enable nested virtualization with
> +KVM on PowerVM. While the existing support for nested KVM on PowerNV was
> +introduced with cap-nested-hv option, however, with a slight design chan=
ge,
> +to enable this on papr/pseries, a new cap-nested-papr option is added. e=
g:
> +
> +  qemu-system-ppc64 -cpu POWER10 -machine pseries,cap-nested-papr=3Dtrue=
 ...
> +
> +Work by:
> +    Michael Neuling <mikey@neuling.org>
> +    Vaibhav Jain <vaibhav@linux.ibm.com>
> +    Jordan Niethe <jniethe5@gmail.com>
> +    Harsh Prateek Bora <harshpb@linux.ibm.com>
> +    Shivaprasad G Bhat <sbhat@linux.ibm.com>
> +    Kautuk Consul <kconsul@linux.vnet.ibm.com>
> +
> +Below taken from the kernel documentation:
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document explains how a guest operating system can act as a
> +hypervisor and run nested guests through the use of hypercalls, if the
> +hypervisor has implemented them. The terms L0, L1, and L2 are used to
> +refer to different software entities. L0 is the hypervisor mode entity
> +that would normally be called the "host" or "hypervisor". L1 is a
> +guest virtual machine that is directly run under L0 and is initiated
> +and controlled by L0. L2 is a guest virtual machine that is initiated
> +and controlled by L1 acting as a hypervisor. A significant design change
> +wrt existing API is that now the entire L2 state is maintained within L0=
.
> +
> +Existing Nested-HV API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Linux/KVM has had support for Nesting as an L0 or L1 since 2018
> +
> +The L0 code was added::
> +
> +   commit 8e3f5fc1045dc49fd175b978c5457f5f51e7a2ce
> +   Author: Paul Mackerras <paulus@ozlabs.org>
> +   Date:   Mon Oct 8 16:31:03 2018 +1100
> +   KVM: PPC: Book3S HV: Framework and hcall stubs for nested virtualizat=
ion
> +
> +The L1 code was added::
> +
> +   commit 360cae313702cdd0b90f82c261a8302fecef030a
> +   Author: Paul Mackerras <paulus@ozlabs.org>
> +   Date:   Mon Oct 8 16:31:04 2018 +1100
> +   KVM: PPC: Book3S HV: Nested guest entry via hypercall
> +
> +This API works primarily using a signal hcall h_enter_nested(). This
> +call made by the L1 to tell the L0 to start an L2 vCPU with the given
> +state. The L0 then starts this L2 and runs until an L2 exit condition
> +is reached. Once the L2 exits, the state of the L2 is given back to
> +the L1 by the L0. The full L2 vCPU state is always transferred from
> +and to L1 when the L2 is run. The L0 doesn't keep any state on the L2
> +vCPU (except in the short sequence in the L0 on L1 -> L2 entry and L2
> +-> L1 exit).
> +
> +The only state kept by the L0 is the partition table. The L1 registers
> +it's partition table using the h_set_partition_table() hcall. All
> +other state held by the L0 about the L2s is cached state (such as
> +shadow page tables).
> +
> +The L1 may run any L2 or vCPU without first informing the L0. It
> +simply starts the vCPU using h_enter_nested(). The creation of L2s and
> +vCPUs is done implicitly whenever h_enter_nested() is called.
> +
> +In this document, we call this existing API the v1 API.
> +
> +New PAPR API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The new PAPR API changes from the v1 API such that the creating L2 and
> +associated vCPUs is explicit. In this document, we call this the v2
> +API.
> +
> +h_enter_nested() is replaced with H_GUEST_VCPU_RUN().  Before this can
> +be called the L1 must explicitly create the L2 using h_guest_create()
> +and any associated vCPUs() created with h_guest_create_vCPU(). Getting
> +and setting vCPU state can also be performed using h_guest_{g|s}et
> +hcall.
> +
> +The basic execution flow is for an L1 to create an L2, run it, and
> +delete it is:
> +
> +- L1 and L0 negotiate capabilities with H_GUEST_{G,S}ET_CAPABILITIES()
> +  (normally at L1 boot time).
> +
> +- L1 requests the L0 to create an L2 with H_GUEST_CREATE() and receives =
a token
> +
> +- L1 requests the L0 to create an L2 vCPU with H_GUEST_CREATE_VCPU()
> +
> +- L1 and L0 communicate the vCPU state using the H_GUEST_{G,S}ET() hcall
> +
> +- L1 requests the L0 to run the vCPU using H_GUEST_RUN_VCPU() hcall
> +
> +- L1 deletes L2 with H_GUEST_DELETE()
> +
> +For more details, please refer:
> +
> +[1] Linux Kernel documentation (upstream documentation commit):
> +
> +commit 476652297f94a2e5e5ef29e734b0da37ade94110
> +Author: Michael Neuling <mikey@neuling.org>
> +Date:   Thu Sep 14 13:06:00 2023 +1000
> +
> +    docs: powerpc: Document nested KVM on POWER
> +
> +    Document support for nested KVM on POWER using the existing API as w=
ell
> +    as the new PAPR API. This includes the new HCALL interface and how i=
t
> +    used by KVM.
> +
> +    Signed-off-by: Michael Neuling <mikey@neuling.org>
> +    Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> +    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> +    Link: https://msgid.link/20230914030600.16993-12-jniethe5@gmail.com


