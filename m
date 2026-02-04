Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8FBE8B397
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 03:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnTjb-0004Yw-5W; Tue, 03 Feb 2026 22:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vnTja-0004Yb-58; Tue, 03 Feb 2026 22:39:18 -0500
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vnTjX-0000xa-P9; Tue, 03 Feb 2026 22:39:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1770176310; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WFDYGdLb1bsWei0csczarQOCmw5GvGRs6DuIvQLzApQdBEeFaJlALUz2YAQETsINrFg+PoDPv1OitDEd4i46ippl9WijvuF4B36adOmLpapqZfsWUf8iW2C9R0B+DJ2iTTuk1KEwcHhSXNlNNV6vmXmhS7BdYunc8BS/XH7JjkU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770176310;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xwTcCMTsvlbfK5xVogufrTQHrp0gNEojmWU75QGw69I=; 
 b=Gx0mNEh9LEfIixysIbC3XwHKKKweZWbqOMLwHxLE9FZ95Dw1NG0IwA9FFha7VLaFzv+EgtSDk0bmJjxKTTaroxLQcp2wix9Dk9V/9jYu3B3/NAKtHQE2NR1jUkWZJzPuBpW6NbDY8yg1pZQLjzUHFsDoRBrC7E7UwQlo0386wDg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770176310; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=xwTcCMTsvlbfK5xVogufrTQHrp0gNEojmWU75QGw69I=;
 b=D3rRVWhj5C5DlyRI7AymYyoTr22Ikzd7pX91wf8LYSKycxFZnTlnvsWiqOVN3tgO
 Nwaw6xvUdMxdK279NghWK8B9MUwZ1Ck4/HlkUbocDsCLcegtIbwEwIQtks9CH4uanhb
 4nQpR82LLH1pzcU0CVcMGG7z6pnbRglMMJglJTrI=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1770176307254144.01059433825696;
 Tue, 3 Feb 2026 19:38:27 -0800 (PST)
Date: Wed, 04 Feb 2026 11:38:27 +0800
From: Li Chen <me@linux.beauty>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Ani Sinha" <anisinha@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>,
 "Zhao Liu" <zhao1.liu@intel.com>, "Song Gao" <gaosong@loongson.cn>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Message-ID: <19c26bae026.4e0422e0822242.1901726439479280077@linux.beauty>
In-Reply-To: <20260203112450-mutt-send-email-mst@kernel.org>
References: <20251211102025.873506-1-me@linux.beauty>
 <20251211080811-mutt-send-email-mst@kernel.org>
 <19b104a617e.133b3feb891309.6986511857690603518@linux.beauty>
 <20251218161253.7f13038f@imammedo>
 <20260203112450-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH v6] acpi/virt: suppress UART device & SPCR when guest
 has no serial hardware
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.12; envelope-from=me@linux.beauty;
 helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Michael and Igor,

 ---- On Wed, 04 Feb 2026 00:27:06 +0800  Michael S. Tsirkin <mst@redhat.co=
m> wrote ---=20
 > On Thu, Dec 18, 2025 at 04:12:53PM +0100, Igor Mammedov wrote:
 > > On Fri, 12 Dec 2025 10:01:08 +0800
 > > Li Chen <me@linux.beauty> wrote:
 > >=20
 > > > Hi Michael,
 > > >=20
 > > >  ---- On Thu, 11 Dec 2025 21:10:18 +0800  Michael S. Tsirkin <mst@re=
dhat.com> wrote ---=20
 > > >  > On Thu, Dec 11, 2025 at 06:20:25PM +0800, Li Chen wrote: =20
 > > >  > > From: Li Chen <chenl311@chinatelecom.cn>
 > > >  > >=20
 > > >  > > virt machines always instantiate a PL011/16550 UART at slot 0 a=
nd describe
 > > >  > > it in ACPI (DSDT and optional SPCR table). When the command lin=
e disables
 > > >  > > the serial backend (e.g. "-serial none"), the guest still sees =
the UART as
 > > >  > > a preferred console even though it is not usable.
 > > >  > >=20
 > > >  > > Teach the virt ACPI code to omit the UART device and SPCR when =
there is no
 > > >  > > serial backend attached. This matches the hardware that the gue=
st can
 > > >  > > actually use and avoids confusing firmware or OS code that reli=
es on SPCR.
 > > >  > >=20
 > > >  > > The bios-tables-test qtests rely on an ACPI UART node and SPCR =
entry for
 > > >  > > UEFI-based virt machines. To keep those tests working we create=
 a UART
 > > >  > > with a "null" chardev backend instead. This preserves the ACPI =
tables
 > > >  > > while discarding the firmware's serial output so it does not co=
rrupt the
 > > >  > > TAP stdout stream.
 > > >  > >=20
 > > >  > > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
 > > >  > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > >  > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com> =20
 > > >  >=20
 > > >  > This bothers me:
 > > >  > won't this mean number of serial devices changes silently?  So fo=
r
 > > >  > example, if you install a guest, see that 1st serial device is br=
oken,
 > > >  > configure it with 2nd one as a work around, now with your change =
there
 > > >  > is no second one so guest will be broken?
 > > >  >=20
 > > >  >=20
 > > >  > I seems safer to have compat machinery around and avoid
 > > >  > changing this for old machine types. =20
 > > > =20
 > > > Thanks for pointing this out, you=E2=80=99re right that changing the=
 number of serial=20
 > > > devices that the guest sees is risky for existing machine types.
 > > >=20
 > > > For v7 I=E2=80=99m planning to take a more conservative approach and=
 only gate SPCR
 > > > on the presence of a backend for the primary UART, while  keeping th=
e ACPI
 > > > UART devices in DSDT unchanged.=20
 > > > Concretely:
 > > > - virt ACPI DSDT will continue to unconditionally describe the UART(=
s) as before,
 > > >    so the guest-visible UART topology doesn=E2=80=99t change for exi=
sting virt-* machines.
 > > > - We only call spcr_setup() when there is a backend attached to UART=
0 (e.g. serial_hd(0) !=3D NULL),
 > > >   so SPCR doesn=E2=80=99t point at a completely unusable console whe=
n the user passes -serial none.
 > > >=20
 > > > In particular, for a command line like -serial none -serial pty, thi=
s means SPCR would not be present
 > > > (rather than silently switching it to UART1/pty). My reasoning is th=
at, for existing virt machines,
 > > > SPCR is meant to describe =E2=80=9Cthe board=E2=80=99s primary conso=
le (UART0)=E2=80=9D, not =E2=80=9Cthe first UART that happens
 > > > to have a host backend=E2=80=9D, and changing that interpretation fe=
els like it would need compat machinery
 > > > and a new machine type.
 > > >=20
 > > > The qtests already force -serial null for the UEFI-based virt tests,=
 so they will still exercise the SPCR path.
 > > >=20
 > > > Would this behaviour be acceptable for you, or would you prefer that=
 I go further and also add a compat
 > > > flag/new machine type where SPCR can follow =E2=80=9Cthe first UART =
with a backend=E2=80=9D while old virt-* machines
 > > > keep the current UART/SPCR semantics?
 > >=20
 > >=20
 > > all described above looks complicated.
 > > In ACPI tables we usually try to avoid compat settings, and do them on=
ly if we have to.
 > >=20
 > > So question is how guest enumerates serial ports when
 > >    '-nodefaults' is used _and_ there is a second serial port configure=
d (is it even possible?)
 > > check it with and without you patch please, to see what difference the=
 patch makes.
 > >=20
 > > >=20
 > > > Regards,
 > > > Li=E2=80=8B
 > > >=20
 >=20
 > Looks like this got stuck.  I think what Igor and me are saying is, do
 > not rush to do compat, just test what happens and document. If guests
 > survive fine, then it's fine.
 >=20
 >=20

Sorry this got stuck.

I just tested the scenario Igor asked about (guest serial enumeration with
-nodefaults and a second -serial backend) on aarch64 virt + UEFI, both
with and without my v6 patch. Without the patch, -nodefaults -serial none
still produces a DSDT with COM0 and an SPCR table, and `-nodefaults
backend is indeed possible). With the v6 patch, both command lines end up
with no COMx nodes in DSDT and no SPCR because the DSDT UART nodes were
gated on serial_hd(0). This means v6 silently changes the guest-visible
UART topology and matches Michael=E2=80=99s concern about guests configured=
 to use
the 2nd serial device as a workaround.

So, for v7 I will keep the UART devices in DSDT unchanged, and only gate SP=
CR
on serial_hd(0) !=3D NULL, so SPCR never points at a completely unusable
console.

Please let me know if I missed anything.

Regards,
Li=E2=80=8B


