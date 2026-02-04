Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201A8E9539B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncrs-0005tL-IM; Wed, 04 Feb 2026 08:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1vncrm-0005Vj-MI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:24:22 -0500
Received: from mail.8bytes.org ([85.214.250.239])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1vncrk-0003E1-HT
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:24:22 -0500
Received: from 8bytes.org
 (p200300f6af1d9600edf6ea9beaf0756d.dip0.t-ipconnect.de
 [IPv6:2003:f6:af1d:9600:edf6:ea9b:eaf0:756d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 7127B1C1208;
 Wed,  4 Feb 2026 14:24:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1770211456;
 bh=FRKH0TLps0vsonu18O4EdSXiGx0M2rPwGxjmyx3YpLY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c0t50Wdx+9Eff+RmrWSboFZgXTttpCbKcOhMi3Yw4V3/l9vLxpqnEx+5t3YREBu4C
 KnGDqmPHF6kJO1eR38kEaUx2Ah7BjEfHmknAGdONc1t4ZSTp2ps00JNHbXsH1Php7z
 uIdhxGTFS8YCG4R8HodUxzwXWLtd5BHfHpTj/to0iE3z2O4nrf8sxlM9kcjujDdC8v
 1Gqxq0xYQdJF4JiE7QrSnKqqRb7RxTpKb3x6yOzPR1cSWbrzu3mRgyx0UGhlG/bxgx
 khPWQtbFYvGlyCrosrMaWfW3lU3j26F59MNU8Ivm8kFFOtIqAExCGGhblJC9YPDy4j
 e0rJM4+FZbx7A==
Date: Wed, 4 Feb 2026 14:24:15 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: COCONUT-SVSM project ideas for GSoC 2026
Message-ID: <2dzs6ukw6gwndluqlzarsmrueug5t7vtic6toxs74k2zewrzwe@337u533iprja>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <h4uue2ekbnlh26rylj4ilsqzyxdrfzrq7czleysrkbowlgp4q2@wtbm7zi4kev5>
 <CAJSP0QXu+fmKuOKLw=OXL0GqTQS58pM_-REtnnOCiSaZJp9=LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QXu+fmKuOKLw=OXL0GqTQS58pM_-REtnnOCiSaZJp9=LQ@mail.gmail.com>
Received-SPF: pass client-ip=85.214.250.239; envelope-from=joro@8bytes.org;
 helo=mail.8bytes.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Stefan,

On Thu, Jan 29, 2026 at 09:18:15AM -0500, Stefan Hajnoczi wrote:
> I think the mentors should provide the extension to the SVSM protocol
> specification. That way the intern can start the coding period by
> diving straight into the implementation and there is no risk that the
> project is held up because the community does not like the design.

Thanks a lot for your feedback. You are right the the project as described is
too big for GSoC.

So we settled on defining the protocol on our own before GSoC starts and
provide it to the student. Updated proposal below:

--->8---
=== Observability Support for COCONUT-SVSM ===

'''Summary:''' Implement Support for COCONUT-SVSM Observability within the TEE

COCONUT-SVSM is a Secure Virtual machine Service Module that runs at a
privileged level within a Confidential Virtual Machine (CVM) to provide trusted
services, such as a virtual TPM, to the guest operating system, independent of
the host hypervisor.

The goal of the project is to implement basic support for observability
of COCONUT-SVSM from the guest OS. When finished the guest OS has a way
to fetch runtime metrics and data from the COCONUT-SVSM running within
the same TEE. Runtime data includes the log buffer, memory usage, and
possible future extensions.

The project consists of several parts:

1. Implement a handler for the pre-defined SVSM observability protocol
   within COCONUT-SVSM following the other protocols COCONUT-SVSM
   already implements.
2. Implement a Linux device driver which uses this protocol to get
   observability data from COCONUT-SVSM and make it accessible to Linux user-mode
   via a device file.
3. Implement a Linux user-space utility to fetch and save the observability
   data using the device driver.

'''Links:'''

* COCONUT-SVSM Repository: https://github.com/coconut-svsm/svsm/
* Development plan: https://coconut-svsm.github.io/svsm/developer/DEVELOPMENT-PLAN/#observability
* SVSM protocol specification: https://docs.amd.com/v/u/en-US/58019

'''Details:'''
Skill level: Intermediate
Language: Rust and C
Mentors: Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>
--->8---

-Joerg

