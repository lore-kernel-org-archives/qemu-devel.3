Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3D6FC72AB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 05:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Bet-0003EG-Ql; Sun, 22 Mar 2026 01:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1w4BeZ-0003Bd-OM
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 01:47:13 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1w4BeT-00071q-9w
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 01:47:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1774158406; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QHAo2IQidkMDiKlnv1Kc+cZpyNmZQWFJtEIBnld6NC6+ajffIuJK64jQRqQkk0wzgQWZyEk3D9bQHWJGNkZmg9HaOJnKSCAcydb1uI8CHA4jUyVecBZJD6lNqKyfM/taGb6SQQqhMkZGnHsOIL2hCFCiQ5WtG3eKbOtxy2pDxuA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774158406;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7P1xYMLeUjE9+Hfi/dJETq6lzV3wsL6TMHI4LGtIDBw=; 
 b=dYufDDKeAF8h8GvN9oeeaLs5uNv9Ag74N5qKTKWmoUFDd82lSqoxPlf0ZTplMXKAj7CAyqQrWRebj5wfTZpginlFdfNR12sYBHQuRhvp3XPW3au94xnBkbpOyyQoFNIXrbNffPrkeQglP+XK7UfpdQg+wru/z3UfX8jICTq4dkM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774158406; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=7P1xYMLeUjE9+Hfi/dJETq6lzV3wsL6TMHI4LGtIDBw=;
 b=mSbp/iiDYFyz4u522kDrbd99VZhkilFvllVR32wpbZcaAq3WThLWC9nL5Od88XWH
 OuxpJbiGk0PTVA7VTi298khe1sHJaqk2V5WGNpwOn49H41V/vCnkU+SpR1PMT34Q92P
 w5S0U2lTX/9qPN8btDC5Hvm/+SsOIT8uEJXrc4pQ=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1774158404498550.4959337986081;
 Sat, 21 Mar 2026 22:46:44 -0700 (PDT)
Date: Sun, 22 Mar 2026 13:46:44 +0800
From: Li Chen <me@linux.beauty>
To: "Alireza Sanaee" <alireza.sanaee@huawei.com>
Cc: "Jonathan Cameron" <jonathan.cameron@huawei.com>,
 "Fan Ni" <fan.ni@samsung.com>, "qemu-devel" <qemu-devel@nongnu.org>,
 "linux-cxl" <linux-cxl@vger.kernel.org>
Message-ID: <19d1414db80.826e8bdb1235052.3769762728645896585@linux.beauty>
In-Reply-To: <20260318150108.00001a5f.alireza.sanaee@huawei.com>
References: <20260317033304.3185291-1-me@linux.beauty>
 <20260317165702.00003c98@huawei.com>
 <20260318150108.00001a5f.alireza.sanaee@huawei.com>
Subject: Re: [PATCH 0/3] cxl: avoid KVM internal error for fixed memory windows
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Hi Alireza,

 ---- On Wed, 18 Mar 2026 23:01:08 +0800  Alireza Sanaee <alireza.sanaee@hu=
awei.com> wrote ---=20
 > On Tue, 17 Mar 2026 16:57:02 +0000
 > Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
 >=20
 > Hi Li,
 >=20
 > It looks like what you achieved is quite similar to what I have done in =
the patchset Jonathan shared earlier.
 >=20
 > You have used memory_region_begin_transaction and memory_region_transact=
ion_commit calls that I believe they are useful to be there given other exa=
mples I checked in the qemu code base.
 >=20
 > I will be using those calls and will send another version. Also, please =
let me know if that patchset actually addresses your usecase and fix the bu=
g you have in the cover letter.
=20
Yes, exactly! Your patchset addresses my use case issue perfectly. Thank yo=
u very much for your effort!

Regards,
Li

 > Thanks,
 > Ali
 >=20
 > > On Tue, 17 Mar 2026 11:33:00 +0800
 > > Li Chen <me@linux.beauty> wrote:
 > >=20
 > > > CXL fixed memory windows are currently modeled as an I/O MemoryRegio=
n.
 > > > When running under KVM, this makes the entire window look like MMIO.
 > > > If Linux onlines the window as system RAM (e.g. for a CXL Type-3
 > > > volatile memdev), normal CPU stores into the window trigger KVM
 > > > instruction emulation. Instructions like XSAVEC are not supported by
 > > > the emulator and abort the VM with a KVM internal error.
 > > >=20
 > > > Repro:
 > > >   - Boot a guest with a CXL Type-3 volatile memdev and a fixed memor=
y window.
 > > >   - In the guest, create a RAM region and online it as system RAM:
 > > >       cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
 > > >   - QEMU exits with a KVM internal error. =20
 > >=20
 > > Hi Li Chen,
 > >=20
 > > At least at first look this looks very like:
 > >=20
 > > https://lore.kernel.org/qemu-devel/20260306121151.883-1-alireza.sanaee=
@huawei.com/
 > >=20
 > > Which was ready for merge as far as I was concerned, but missed gettin=
g queued for
 > > 11.0 (as last PCI pull request had gone) and is currently ready to go =
in next cycle.
 > >=20
 > > Please see if that works for your case. If there are improvements I'd =
prefer
 > > to see them applied on top of that series than reinventing what I thin=
k
 > > is the same thing.
 > >=20
 > > It's not KVM specific as linear mappings (when valid) bring huge perfo=
rmance
 > > benefits on TCG as well as correctness for KVM.
 > >=20
 > > Jonathan
 > >=20
 > > +CC linux-cxl which is where CXL folk tend to hang out in larger numbe=
rs
 > > than on the qemu list.
 > >=20
 > >=20
 > >=20
 > > >=20
 > > > Serial output excerpt:
 > > >   KVM internal error. Suberror: 1
 > > >   extra data[0]: 0x0000000000000001
 > > >   extra data[1]: 0xc0314061c70f480f
 > > >   extra data[2]: 0x024080f610478b48
 > > >   extra data[3]: 0x0000000000000400
 > > >   extra data[4]: 0x000000010000000f
 > > >   extra data[5]: 0x00000004a0003140
 > > >   extra data[6]: 0x0000000000000000
 > > >   extra data[7]: 0x0000000000000000
 > > >   emulation failure
 > > >   RAX=3D0000000000000007 RBX=3Dffff8eace0001a40 RCX=3Dffff8eace00031=
00 RDX=3D0000000000000000
 > > >   RSI=3D0000000000000007 RDI=3Dffff8eace00030c0 RBP=3Dffffd48ac1747c=
08 RSP=3Dffffd48ac1747bc8
 > > >   R8 =3D0000000000000007 R9 =3D0000000000000007 R10=3D00000000000000=
0d R11=3D0000000000000000
 > > >   R12=3Dffff8ea945b51a40 R13=3Dffffd48ac166c000 R14=3D00000000000000=
00 R15=3D0000000001200000
 > > >   RIP=3Dffffffffaf77a14d RFL=3D00000256 [---ZAP-] CPL=3D0 II=3D0 A20=
=3D1 SMM=3D0 HLT=3D0
 > > >   ES =3D0000 0000000000000000 00000000 00000000
 > > >   CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
 > > >   SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
 > > >   DS =3D0000 0000000000000000 00000000 00000000
 > > >   FS =3D0000 00007f997da3fec0 00000000 00000000
 > > >   GS =3D0000 ffff8eab0535d000 00000000 00000000
 > > >   LDT=3D0000 fffffe7600000000 00000000 00000000
 > > >   TR =3D0040 fffffe767cf8f000 00004087 00008b00 DPL=3D0 TSS64-busy
 > > >   GDT=3D     fffffe767cf8d000 0000007f
 > > >   IDT=3D     fffffe0000000000 00000fff
 > > >   CR0=3D80050033 CR2=3D000055fd193a6468 CR3=3D000000010930c000 CR4=
=3D00350ef0
 > > >   DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D00000000000000=
00 DR3=3D0000000000000000
 > > >   DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
 > > >   EFER=3D0000000000001d01
 > > >   Code=3D0f 1f 44 00 00 48 8b 4f 10 48 8b 41 08 48 89 c2 48 c1 ea 20=
 <48> 0f c7 61 40 31 c0 48 8b 47 10 f6 80 40 02 00 00 c0 74 1e 48 8b 05 98 =
f8 e8 01 48 89 47
 > > >=20
 > > > This series keeps the existing MMIO dispatcher, but turns the fixed
 > > > window into a container and (when the window maps linearly to a Type=
-3
 > > > volatile memdev) overlays a RAM alias so KVM can create a memslot fo=
r
 > > > the range. The mapping is updated when HDM decoders are
 > > > committed/uncommitted by the guest.
 > > >=20
 > > > This patchset is based on master branch 559919ce54927d59b215a4665eda=
7ab6118a48aa
 > > >=20
 > > > Local validation on this base confirmed that the issue reproduces
 > > > without the series and is fixed with the 3 patches below.
 > > >=20
 > > > Li Chen (3):
 > > >   cxl/type3: expose vmem mapping for fixed windows
 > > >   cxl: alias fixed memory windows to RAM under KVM
 > > >   cxl: update fixed window mappings on decoder programming
 > > >=20
 > > >  hw/cxl/cxl-component-utils.c |   2 +
 > > >  hw/cxl/cxl-host-stubs.c      |   1 +
 > > >  hw/cxl/cxl-host.c            | 189 ++++++++++++++++++++++++++++++++=
++-
 > > >  hw/mem/cxl_type3.c           |  59 +++++++++++
 > > >  include/hw/cxl/cxl.h         |   5 +
 > > >  include/hw/cxl/cxl_device.h  |   3 +
 > > >  include/hw/cxl/cxl_host.h    |   1 +
 > > >  7 files changed, 258 insertions(+), 2 deletions(-)
 > > >  =20
 > >=20
 >=20
 >=20
Regards,

Li=E2=80=8B


