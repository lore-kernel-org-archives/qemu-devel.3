Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7337FC71159
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 06:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS8rh-0008Og-MK; Thu, 19 Jun 2025 02:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uS5LG-0005Pe-TH
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 22:49:30 -0400
Received: from smtp-outbound2.duck.com ([20.67.223.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uS5LE-0002c8-2X
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 22:49:30 -0400
MIME-Version: 1.0
Subject: [PATCH v2 00/11] MAX78000FTHR Implementation
Content-Type: multipart/alternative;
	boundary="=_I1CaL8QgJx1E5j3CWCoICM_="
X-Rspamd-Bar: -
X-Rspamd-Report: DMARC_POLICY_ALLOW(-0.5) R_DKIM_ALLOW(-0.2) MIME_GOOD(-0.1)
 R_SPF_ALLOW(-0.2)
X-Rspamd-Score: -1
X-Rspamd-Action: no action
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Received: by smtp-inbound1.duck.com; Wed, 18 Jun 2025 22:49:22 -0400
Message-ID: <AB4E8716-6A99-499E-B03A-88EEB3E40C6C.1@smtp-inbound1.duck.com>
Date: Wed, 18 Jun 2025 22:49:22 -0400
From: jcksn@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Type: Subject:
 MIME-Version; q=dns/txt; s=postal-KpyQVw; t=1750301363;
 bh=eugVriFZ+9/ZzBZOhUXrWnQX9M1z4hPJ3C6OcOAnhs4=;
 b=W/49K9ms/58XeUx1ba31OowCVYbHjFH9TYhlZ52G7WQsKWyGuNt/ztRyF4Bksl2mf6ZBm4B6z
 M03SWLp31H8SHyLkVUNBqVQ3qQzVXsggxay3dcoMiNVOa7vJAgFbHwUc50RncLReDCtlVKziOk7
 p7FALYCRKxf5EjiaTLSsbjw=
Received-SPF: pass client-ip=20.67.223.10; envelope-from=jcksn@duck.com;
 helo=smtp-outbound2.duck.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Jun 2025 02:35:10 -0400
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

--=_I1CaL8QgJx1E5j3CWCoICM_=
Content-Type: text/plain;
	charset="UTF-8"

 v2 changes: Addresses comments by Peter. For each device: - Switched soc
to use sysbus_realize - Standardized switch case bracing, indentation, and
error case - Added valid min and max access size - Changed endianness to
DEVICE_LITTLE_ENDIAN - Added reset method, if not already implemented -
Added migration support - Split soc integration into separate commit
Machine Implementation: Added user guide URL Removed refclk. According to
https://developer.arm.com/documentation/ddi0403/d/System-Level-Architecture/System-Address-Map/The-system-timer--SysTick/SysTick-Control-and-Status-Register--SYST-CSR
the systick clock can be either the processor clock or an implementation
defined external reference clock. As far as I can tell based on the user
guide, the MAX78000 does not define an external reference clock. I have not
confirmed this in hardware. Changed IRQ count to 120 and noted that the
user guide is unclear on this number Fixed unimplemented device lengths and
names ICC: Removed ICC_Invalidate Added number to device names UART: Fixed
interrupts, allowing async UART Added number to device names GCR: Changed
string-based device search to prop links for device reset Changed
cpu_physical_memory_write to address_space_write TRNG: Changed source of
randomness to qemu_guest_getrandom_nofail Did not change interrupt
generation > Your interrupt generation code in this device doesn't look >
right: the interrupt is supposed to be generated when each > new random
number is ready, so in our "generation takes > zero time" model a read from
DATA should provoke a new > interrupt immediately (assuming the interrupt
is enabled): > you need to simulate the ready status bit going low and >
then high again. I believe the interrupt generation is fine in this case;
by latching it high so long as the interrupt is enabled, the interrupt
handler gets called repeatedly until it receives the desired amount of data
and disables the interrupt. I've tested this and it works with the maxim
sdk's implementation of asynchronous trng. > See also my comments on an
earlier patch about the usual > logic being to have an update function
which does > "set interrupt to (condition && enabled)". In this case there
is only one possible interrupt condition (is there random data ready),
which is always true when enabled. As such I don't think a handler function
is really necessary > A minor note on email patchseries formatting:
something odd > seems to have happened with your cover letter. Patches in a
> series are supposed to be followups to the cover letter, but > in this
case each patch email has a header > In-reply-to:
20250510042043.2056265-1-jcksn@duck.com > but that doesn't match the
message-id of the cover letter mail > (which was >
16B81215-B460-4A49-910E-E5FB479837C8.1@smtp-inbound1.duck.com > ). > > It
looks like something has rewritten the message-ID header > between when git
generated it and it got to the mailing list. > I don't know if that's
something you can fix at your end. > (Otherwise I guess you could work
around it by sending the cover > letter first, finding out what message-ID
it got given, and then > generating the patch emails with the
--in-reply-to=<identifier> > option of git send-email so they come out as
replies to the > cover letter. But that seems a bit of a faff :-/ ) This is
probably because my emails are forwarded through duckduckgo with the @
duck.com address. I've attempted the suggested workaround.
Testing with my own email addresses suggests it just kicks the problem
one email down the chain; may just submit directly in the future if this
does not work. v1: This patch series implements basic support for the
MAX78000FTHR machine https://github.com/JacksonDonaldson/max78000Test
Contains instructions for building a test program against the MAX78000FTHR
as well as results of the test suite run on QEMU and hardware.
Jackson Donaldson (11):
MAX78000: Add MAX78000FTHR Machine MAX78000: ICC Implementation MAX78000:
Add ICC to SOC MAX78000: UART Implementation MAX78000: Add UART to SOC
MAX78000: GCR Implementation MAX78000: Add GCR to SOC MAX78000: TRNG
Implementation MAX78000: Add TRNG to SOC MAX78000: AES implementation
MAX78000: Add AES to SOC hw/arm/Kconfig | 15 ++ hw/arm/max78000_soc.c | 234
+++++++++++++++++++++ hw/arm/max78000fthr.c | 50 +++++ hw/arm/meson.build |
2 + hw/char/Kconfig | 3 + hw/char/max78000_uart.c | 285
++++++++++++++++++++++++++ hw/char/meson.build | 1 + hw/misc/Kconfig | 12
++ hw/misc/max78000_aes.c | 232 +++++++++++++++++++++
hw/misc/max78000_gcr.c | 351 ++++++++++++++++++++++++++++++++
hw/misc/max78000_icc.c | 120 +++++++++++ hw/misc/max78000_trng.c | 127
++++++++++++ hw/misc/meson.build | 4 + include/hw/arm/max78000_soc.h | 50
+++++ include/hw/char/max78000_uart.h | 78 +++++++
include/hw/misc/max78000_aes.h | 68 +++++++ include/hw/misc/max78000_gcr.h
| 131 ++++++++++++ include/hw/misc/max78000_icc.h | 33 +++
include/hw/misc/max78000_trng.h | 35 ++++ 19 files changed, 1831
insertions(+) create mode 100644 hw/arm/max78000_soc.c create mode 100644
hw/arm/max78000fthr.c create mode 100644 hw/char/max78000_uart.c create
mode 100644 hw/misc/max78000_aes.c create mode 100644
hw/misc/max78000_gcr.c create mode 100644 hw/misc/max78000_icc.c create
mode 100644 hw/misc/max78000_trng.c create mode 100644
include/hw/arm/max78000_soc.h create mode 100644
include/hw/char/max78000_uart.h create mode 100644
include/hw/misc/max78000_aes.h create mode 100644
include/hw/misc/max78000_gcr.h create mode 100644
include/hw/misc/max78000_icc.h create mode 100644
include/hw/misc/max78000_trng.h -- 2.34.1

--=_I1CaL8QgJx1E5j3CWCoICM_=
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div dir=3D"ltr">
<div><font size=3D"2" =
style=3D"font-family:arial,sans-serif"><span style=3D"font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:left;text-indent:0px;text-transform:none;word-spa=
cing:0px;white-space:pre-wrap;text-decoration-style:initial;text-decoration=
-color:initial;display:inline;float:none">v2 changes:

Addresses comments by Peter.
For each device:
- Switched soc to use =
sysbus_realize
- Standardized switch case bracing, indentation, and error =
case
- Added valid min and max access size
- Changed endianness to =
DEVICE_LITTLE_ENDIAN
- Added reset method, if not already implemented
- Added migration support
- Split soc integration into separate commit

Machine Implementation:
Added user guide URL
Removed refclk. According to =
<a href=3D"https://developer.arm.com/documentation/ddi0403/d/System-Level-A=
rchitecture/System-Address-Map/The-system-timer--SysTick/SysTick-Control-an=
d-Status-Register--SYST-CSR" target=3D"_blank">https://developer.arm.=
com/documentation/ddi0403/d/System-Level-Architecture/System-Address-Map/Th=
e-system-timer--SysTick/SysTick-Control-and-Status-Register--SYST-CSR</a> =
the systick clock can be either the processor clock or an implementation =
defined external reference clock. As far as I can tell based on the user =
guide, the MAX78000 does not define an external reference clock. I have not=
 confirmed this in hardware.
Changed IRQ count to 120 and noted that the =
user guide is unclear on this number
Fixed unimplemented device lengths and=
 names

ICC:
Removed ICC_Invalidate
Added number to device names

UART:
Fixed interrupts, allowing async UART
Added number to device names

GCR:
Changed string-based device search to prop links for device reset
Changed cpu_physical_memory_write to address_space_write

TRNG:
Changed source of randomness to qemu_guest_getrandom_nofail
Did not change interrupt generation
&gt; Your interrupt generation code in =
this device doesn't look
&gt; right: the interrupt is supposed to be =
generated when each
&gt; new random number is ready, so in our "generation =
takes
&gt; zero time" model a read from DATA should provoke a new
&gt; interrupt immediately (assuming the interrupt is enabled):
&gt; you need to simulate the ready status bit going low and
&gt; then high again.

I believe the interrupt generation is fine in this =
case;
by latching it high so long as the interrupt is enabled,
the interrupt handler gets called repeatedly until it
receives the desired amount of data and disables the interrupt.
I've tested this and it works with the maxim sdk's
implementation of =
asynchronous trng.

&gt; See also my comments on an earlier patch about the=
 usual
&gt; logic being to have an update function which does
&gt; "set interrupt to (condition &amp;&amp; enabled)".

In this case there is only one possible interrupt condition
(is there random data ready), which is always true when enabled.
As such I don't think a handler function is really necessary

&gt; A minor note on email patchseries formatting: something odd
&gt; seems to have happened with your cover letter. Patches in a
&gt; series are supposed to be followups to the cover letter, but
&gt; in this case each patch email has a header
&gt;  In-reply-to: <a =
href=3D"mailto:20250510042043.2056265-1-jcksn@duck.com" =
target=3D"_blank">20250510042043.2056265-1-jcksn@duck.com</a>
&gt; but that doesn't match the message-id of the cover letter mail
&gt; (which was
&gt;  <a href=3D"mailto:16B81215-B460-4A49-910E-E5FB479837C=
8.1@smtp-inbound1.duck.com" target=3D"_blank">16B81215-B460-4A49-910E-E5FB4=
79837C8.1@smtp-inbound1.duck.com</a>
&gt; ).
&gt;=20
&gt; It looks like something has rewritten the message-ID header
&gt; between when git generated it and it got to the mailing list.
&gt; I don't know if that's something you can fix at your end.
&gt; (Otherwise I guess you could work around it by sending the cover
&gt; letter first, finding out what message-ID it got given, and then
&gt; generating the patch emails with the --in-reply-to=3D&lt;identifier&gt=
;
&gt; option of git send-email so they come out as replies to the
&gt; cover letter. But that seems a bit of a faff :-/ )

This is probably because my emails are forwarded through duckduckgo
with the @<a href=3D"http://duck.com" target=3D"_blank">duck.com</a> =
address. I've attempted the suggested workaround.</span></font></div><div><=
font size=3D"2" style=3D"font-family:arial,sans-serif"><span =
style=3D"font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:left;text-indent:0p=
x;text-transform:none;word-spacing:0px;white-space:pre-wrap;text-decoration=
-style:initial;text-decoration-color:initial;display:inline;float:none">Tes=
ting with my own email addresses suggests it just kicks the =
problem</span></font></div><div><font size=3D"2" style=3D"font-family:arial=
,sans-serif"><span style=3D"font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
left;text-indent:0px;text-transform:none;word-spacing:0px;white-space:pre-w=
rap;text-decoration-style:initial;text-decoration-color:initial;display:inl=
ine;float:none">one email down the chain; may just submit directly in the =
future if this</span></font></div><div><font size=3D"2" =
style=3D"font-family:arial,sans-serif"><span style=3D"font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:left;text-indent:0px;text-transform:none;word-spa=
cing:0px;white-space:pre-wrap;text-decoration-style:initial;text-decoration=
-color:initial;display:inline;float:none">does not work.

v1:
This patch series implements basic support for the MAX78000FTHR machine

<a href=3D"https://github.com/JacksonDonaldson/max78000Test" =
target=3D"_blank">https://github.com/JacksonDonaldson/max78000Test</a>
Contains instructions for building a test program against the MAX78000FTHR
as well as results of the test suite run on QEMU and hardware.</span>

<br></font></div><div><font size=3D"2" style=3D"font-family:arial,=
sans-serif"><span style=3D"font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:l=
eft;text-indent:0px;text-transform:none;word-spacing:0px;white-space:break-=
spaces;text-decoration-style:initial;text-decoration-color:initial;display:=
inline;float:none">Jackson Donaldson (11):
</span></font></div><font =
size=3D"2" style=3D"font-family:arial,sans-serif"><span =
style=3D"font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:left;text-indent:0p=
x;text-transform:none;word-spacing:0px;white-space:break-spaces;text-decora=
tion-style:initial;text-decoration-color:initial;display:inline;float:none"=
>  MAX78000: Add MAX78000FTHR Machine
  MAX78000: ICC Implementation
  MAX78000: Add ICC to SOC
  MAX78000: UART Implementation
  MAX78000: Add UART to SOC
  MAX78000: GCR Implementation
  MAX78000: Add GCR to SOC
  MAX78000: TRNG Implementation
  MAX78000: Add TRNG to SOC
  MAX78000: AES implementation
  MAX78000: Add AES to SOC

 hw/arm/Kconfig                  |  15 ++
 hw/arm/max78000_soc.c           | 234 +++++++++++++++++++++
 hw/arm/max78000fthr.c           |  50 +++++
 hw/arm/meson.build           =
   |   2 +
 hw/char/Kconfig                 |   3 +
 hw/char/max78000_uart.c         | 285 ++++++++++++++++++++++++++
 hw/char/meson.build             |   1 +
 hw/misc/Kconfig                 |=
  12 ++
 hw/misc/max78000_aes.c          | 232 +++++++++++++++++++++
 hw/misc/max78000_gcr.c          | 351 ++++++++++++++++++++++++++++++++
 hw/misc/max78000_icc.c          | 120 +++++++++++
 hw/misc/max78000_trng.c=
         | 127 ++++++++++++
 hw/misc/meson.build             |   4 +
 include/hw/arm/max78000_soc.h   |  50 +++++
 include/hw/char/max78000_uart=
.h |  78 +++++++
 include/hw/misc/max78000_aes.h  |  68 +++++++
 include/hw/misc/max78000_gcr.h  | 131 ++++++++++++
 include/hw/misc/max78000_icc.h  |  33 +++
 include/hw/misc/max78000_trng.h=
 |  35 ++++
 19 files changed, 1831 insertions(+)
 create mode 100644 =
hw/arm/max78000_soc.c
 create mode 100644 hw/arm/max78000fthr.c
 create mode 100644 hw/char/max78000_uart.c
 create mode 100644 =
hw/misc/max78000_aes.c
 create mode 100644 hw/misc/max78000_gcr.c
 create mode 100644 hw/misc/max78000_icc.c
 create mode 100644 =
hw/misc/max78000_trng.c
 create mode 100644 include/hw/arm/max78000_soc.h
 create mode 100644 include/hw/char/max78000_uart.h
 create mode 100644 include/hw/misc/max78000_aes.h
 create mode 100644 =
include/hw/misc/max78000_gcr.h
 create mode 100644 include/hw/misc/max78000=
_icc.h
 create mode 100644 include/hw/misc/max78000_trng.h

--=20
2.34.1</span>

</font><span style=3D"font-family:arial,sans-serif">

</span>

<br></div>
</body></html>

--=_I1CaL8QgJx1E5j3CWCoICM_=--

