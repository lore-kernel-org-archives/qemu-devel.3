Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22168FCC056
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZzh-0007mE-Lh; Fri, 06 Mar 2026 13:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyZzg-0007lz-IZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:33:48 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyZzf-0005IC-2F
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:33:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E540F4387A;
 Fri,  6 Mar 2026 18:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBECC4CEF7;
 Fri,  6 Mar 2026 18:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772822024;
 bh=AwVYXbCXk72QE/5e52P+we8ip2zEXcp6OE6gyiShEYY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mh1PpSYFs2B426In4NN368RI4UE6wQi8YN2Im+aMS8NDZOSjL2W9Y7WBhF8zH35gQ
 qk2J6vlNKWtnDEfw458Fpouqo7eZbKI+S6TGI+B3LQrtlpEiqocQbaDlzaD3mWUcmf
 fs8wGenaK4pa5ijMEPSVVAhhrulfQerfp+ZfE0SyqdKUrDxmQgpLzw9SQDhzWGBIdz
 DN/49/Njyphu7AxkxrkYGe5S5vEpzWucaelZPFZfxsZU/EMAynY8nWsX/C7mx3yke1
 Oq8CEAIkRnlhgl+QUV4osFNfQ+v3DPlQDiE1B8pTudX0Kqb9wIrS0pv6KbGg0AfIni
 i6LVErYCLS/5g==
Date: Fri, 6 Mar 2026 19:33:41 +0100
From: Helge Deller <deller@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
Message-ID: <aaseBa-3GVyjKGXh@p100>
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
 <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
 <aasZKZ1FQY5ytrb2@p100>
 <CAFEAcA8MLNYfDe_0chBmo+wwwNJoUHWj4Sg1nhCNSjodCzTOtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8MLNYfDe_0chBmo+wwwNJoUHWj4Sg1nhCNSjodCzTOtw@mail.gmail.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

* Peter Maydell <peter.maydell@linaro.org>:
> On Fri, 6 Mar 2026 at 18:13, Helge Deller <deller@kernel.org> wrote:
> > Background: During development of the various machines it was
> > easier for me to just disable/enable the Diva card from the command
> > line via the "disable" property.
> ...
> I think we can also now delete the "disable" propertyi
> in the diva-gsp device itself, right?

True.
Patch is below.
Ok?

Helge

From: Helge Deller <deller@gmx.de>
Subject: [PATCH] hw/char: Drop disable property of Diva GSP card

The "disable" property is not used, so drop it.

Noticed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 280d0413c6..b945dab37d 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -51,7 +51,6 @@ typedef struct PCIDivaSerialState {
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     qemu_irq     *irqs;
-    bool         disable;
 } PCIDivaSerialState;
 
 static void diva_pci_exit(PCIDevice *dev)
@@ -166,13 +165,11 @@ static const VMStateDescription vmstate_pci_diva = {
         VMSTATE_STRUCT_ARRAY(state, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS,
                              0, vmstate_serial, SerialState),
         VMSTATE_UINT32_ARRAY(level, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS),
-        VMSTATE_BOOL(disable, PCIDivaSerialState),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static const Property diva_serial_properties[] = {
-    DEFINE_PROP_BOOL("disable",  PCIDivaSerialState, disable, false),
     DEFINE_PROP_CHR("chardev1",  PCIDivaSerialState, state[0].chr),
     DEFINE_PROP_CHR("chardev2",  PCIDivaSerialState, state[1].chr),
     DEFINE_PROP_CHR("chardev3",  PCIDivaSerialState, state[2].chr),

