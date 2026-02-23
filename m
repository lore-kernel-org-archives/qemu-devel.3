Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2657EEA4FAD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuUIC-0002Yf-HW; Mon, 23 Feb 2026 06:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUI7-0002YJ-Oj
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:39:56 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUI5-0003GN-UL
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:39:55 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 20D30418EC;
 Mon, 23 Feb 2026 11:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC6CC116C6;
 Mon, 23 Feb 2026 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771846784;
 bh=5gghoDvFll5rJRWoJA25CjvdJ3sRTIFQTQVzD2X+Kgs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=REo9wr/QrPdkhvZ+GL9+hadi4oa8XCkmgJJeNMyQfJ9ugNmw6QTSvCUiH/Tnmi3Nu
 r2It2XgKjQsNNIFOjsRdOewWOtL/tDDqf20aXyDLVtU742bcGU+j08iikCyILk+/RI
 oo49KOxlEXJUj+8Va7Nww++anJETQ+6U1x8AUR2XZeiUoJFEIILx5HmXTmj9JBKR1z
 sPoxBt3jcTw9co9p+fvjLJ21djLEA0ynRuV9CVhqdWEMBJLD8MoKwEP0UPXkI/eK8i
 Lm/6cZ2r9Al/Uib8SdTt5yKtLB1JTcv1fEI4KqaxASXoXGcVsBLIpn1u6AtjkWBHwD
 gSs81c761KvqA==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUHt-000000073FT-3GQ6; Mon, 23 Feb 2026 12:39:41 +0100
Date: Mon, 23 Feb 2026 12:39:40 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH v2 00/13] Add more commands to scripts/ghes_inject.py
Message-ID: <20260223123940.2b668dfa@localhost>
In-Reply-To: <20260220130241-mutt-send-email-mst@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
 <20260220130241-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 20 Feb 2026 13:03:01 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jan 23, 2026 at 02:35:14PM +0100, Mauro Carvalho Chehab wrote:
> > Now that we have the basic stuff merged on QEMU, add more
> > commands to scripts/ghes_inject.py. After this patch, this
> > tool will support the following commands:
> > 
> >     arm                 Inject an ARM processor error CPER, compatible with
> >                         UEFI 2.9A Errata.
> >     pcie-bus            Inject a PCIe bus error CPER
> >     fuzzy-test (fuzzy)  Inject fuzzy test CPER packets
> >     raw-error (raw)     Inject CPER records from previously recorded ones.
> > 
> > Where arm is a pre-existing one.
> > 
> > The pcie-bus command injects a PCIe bus error - currently not supported
> > on Linux (GUID: c5753963-3b84-4095-bf78-eddad3f9c9dd).
> > 
> > The fuzzy-test command allows injecting one or more CPER records
> > for all GUID types supported on UEFI 2.11, with its contents being
> > either zero or random, and with the payload size that can also be
> > random.
> > 
> > The raw-error command allow reproducing a CPER from a text file.
> > It is helpful in conjunction with fuzzy-test to re-test the OSPM
> > after some fixes.
> > 
> > Besides the commands, a new helper logic was added at
> > scripts/ghes_decode.py: when the tool is called with the
> > --debug command line argument, it will translate the injected
> > record, allowing to compare what it was injected with what
> > the OSPM/userspace tools would interpret.
> > 
> > The first 6 patches on this series improve the qmp_helper
> > logic to support the new functionality.
> > 
> > The next 6 patches add the extra functionality to ghes_inject.
> > 
> > The final patch improves its help message when called without
> > a command.  
> 
> 
> Pls run checkpatch on this and make sure the output is clean.
> Thanks!

There are 3 warnings there due to the usage of the old SPDX "GPL2.0"
which is identical to "GPL2.0-only", but were deprecated on SPDX 3.0.
I'll fix those. 

The remaining ones are mainly due to long strings, or, on two
cases, related to very long class and/or method names that should be
passed as long name parmeters, like here (*):

        parser = subparsers.add_parser("raw-error",  aliases=['raw'],
                                       help=self.HELP, description=self.DESC,
                                       formatter_class=argparse.RawTextHelpFormatter)

I'll be fixing the ones that won't require mangling strings nor
use some tricks that would otherwise make the source code for,
IMO, no good reason.

(*) on this specific case, the "fix" would be to create an
    "alias" class:

	class Formatter(argparse.RawTextHelpFormatter):
	   pass

    Just to make checkpatch happy. IMHO not worth it.

---

On a side note, IMHO checkpatch should be using a better default for
Python, setting max columns max requirement to be 120 columns and
ignoring or relaxing such limits on triple-quoted strings like here:

	ERROR: line over 90 characters
	#83: FILE: scripts/arm_processor_error.py:83:
	+[Hardware Error]:     bus error, operation type: Generic read (type of instruction or data request cannot be determined)

(this is part of a comment there describing the Linux Kernel
output for an ARM Processor Error - we should not enforce any
max column limit there)


> 
> > ---
> > 
> > v2:
> >   - the bus error injection is for PCI/PCI-X, not PCIe, so
> >     the command was renamed;
> >   - added notes that not all CXL types may occur in practice;
> >   - removed a field from common_fields at DecodeGhesEntry
> >     decode class and make it more robust;
> >   - some cleanups at patch description.
> > 
> > Mauro Carvalho Chehab (13):
> >   scripts/qmp_helper: add a return code to send_cper
> >   scripts/qmp_helper: add missing CXL UEFI GUID
> >   scripts/qmp_helper: add support for FRU Memory Poison
> >   scripts/qmp_helper: make send_cper() more generic
> >   scripts/qmp_helper: fix raw_data logic
> >   scripts/qmp_helper: add support for a timeout logic
> >   scripts/ghes_inject: add a logic to decode CPER
> >   scripts/ghes_inject: exit 1 if command was not sent
> >   scripts/ghes_inject: add a handler for PCI/PCI-X bus error
> >   scripts/ghes_inject: add support for fuzzy logic testing
> >   scripts/ghes_inject: add a raw error inject command
> >   scripts/ghes_inject: print help if no command specified
> >   scripts/ghes_inject: improve help message
> > 
> >  MAINTAINERS                    |    4 +
> >  scripts/arm_processor_error.py |    8 +-
> >  scripts/fuzzy_error.py         |  208 ++++++
> >  scripts/ghes_decode.py         | 1158 ++++++++++++++++++++++++++++++++
> >  scripts/ghes_inject.py         |   30 +-
> >  scripts/pci_bus_error.py       |  148 ++++
> >  scripts/qmp_helper.py          |  164 ++++-
> >  scripts/raw_error.py           |  175 +++++
> >  8 files changed, 1857 insertions(+), 38 deletions(-)
> >  create mode 100644 scripts/fuzzy_error.py
> >  create mode 100644 scripts/ghes_decode.py
> >  create mode 100644 scripts/pci_bus_error.py
> >  create mode 100644 scripts/raw_error.py
> > 
> > -- 
> > 2.52.  


-- 
Thanks,
Mauro

