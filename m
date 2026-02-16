Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750CFE63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vruGC-0006BT-Lm; Mon, 16 Feb 2026 03:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vruG7-0006BA-Eu
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:47:11 -0500
Received: from p-west3-cluster1-host9-snip4-1.eps.apple.com ([57.103.73.212]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vruG2-0000Z8-3E
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:47:10 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-2 (Postfix) with ESMTPS id
 82F2F18000B2; Mon, 16 Feb 2026 08:47:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771231624; x=1773823624;
 bh=IUXO5RykZ7TGD+JuWdWVjGrlYVUF2LV8wkumAPJcpdM=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=IPokkryghuU07TOI5hei9FO3U3vAcCUReGlKnro8JL2LbhYEinaNMt/3nJDwL4hdRwa1NJ4bJVkSDw4VPK2/Q1hkpsTxex4K7wnfKZJs6xLRT2NlC/0tFJGuscZ8nlPhwXloXNheZom2EaWmE6sntv9ef2lsh/JA8Uv/n99qqFXkqGHxp3sYzncmakdQTaPPtZZ8wVfvCsvXrC/eFWNlFXt7k4LWS4QwEeYRXyrhBIePAWa8RiCw4v3kCb+upEQXtGoNr0hRBINcZarr+PYdI/0ZNzc/mb5UbWBz9GycOyj5VrhqVdZAflkNidBOoQbHJBU/tVrRvneWbYFCa5S89A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-2 (Postfix) with ESMTPSA id
 53B011800247; Mon, 16 Feb 2026 08:46:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <10A1F57B-F6ED-492B-B88B-E7DD773F8846@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_A78332F2-CDE4-418F-8778-B9B95AD765D8"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 00/11] Introduce ACPI watchdog for Q35 and arm/virt boards
Date: Mon, 16 Feb 2026 09:46:39 +0100
In-Reply-To: <CAK3XEhNNRDRyg5hNUwpoYo8KS2CbyPEBHnzqjFH1zY8jjFhwCg@mail.gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com
To: Ani Sinha <anisinha@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <CAK3XEhNNRDRyg5hNUwpoYo8KS2CbyPEBHnzqjFH1zY8jjFhwCg@mail.gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: sVyMafKpQNr9HHeRURgQ-gfEqErwrl_i
X-Authority-Info-Out: v=2.4 cv=LYYxKzfi c=1 sm=1 tr=0 ts=6992d987
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=IA0wh2spAAAA:8 a=p0WdMEafAAAA:8 a=yMhMjlubAAAA:8
 a=07d9gI8wAAAA:8 a=voM4FWlXAAAA:8 a=20KFwNOVAAAA:8 a=76dO8S3k8TJV1FyFqrUA:9
 a=QEXdDO2ut3YA:10 a=-FpVgtzr5MWN_hjmuu4A:9 a=dT3wBKxCJbLlM6qh:21
 a=_W_S_7VecoQA:10 a=e2CUPOnPG4QKp8I52DXD:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: sVyMafKpQNr9HHeRURgQ-gfEqErwrl_i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3MyBTYWx0ZWRfX2UhxhU5csLVC
 5oWvkEE1OIVKIwUBRBp+bVw4mdxm4/ONFWmkQynWoSb8Qwj603089cvqJFMBiaDj9TxP6b5YEos
 ol+b+/uLAaMNf9msVVgBYQ4tJWyBwuuPBS5TzkAl+wsZjfOkv6VETPV2rKN6KQSGjXiRoQq3b8v
 0P80AuQpPQ7ee7J0rKlrZqJKkhMFaFILF/8Yy0vZYV0qy6eI4OgSTVOXmP8oGo0PgbO+dvB7EDJ
 nqp83cLmngZSU3MPmftEqzve7rIQwETyVHq6SBipc0w/WKLvYme3eWORpAn0ah+BcsMEXAN0psk
 UXjeWTB4nRijiBn3np7kgIFzfMBaOo0a0VFFroyxbAYEQ/kVQ45HtUyqPgo110=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1030 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160073
X-JNJ: AAAAAAABNUcExuCame8GuSZExAsUONLKZ3IzfSg7Srob/bHN1ISy+RSQXcyTwFcHdJA2Tr7q2DG9vs0T65L/0WidJ/F2UdTgIuJqFnwvh6mDD3jK714vtXLKx9P6426FqGBJLRuTMjsuAsVlqG84C/+m2r/2rQ46y8l6P1woOf5dPetvDz5tp7/teDtg6iCauuSnIRrEz3HMKrrnHE61B0fYOWyFPjfezyqRLk7//WYAc5nyF8GHTE07xoyBsnE8817D2BCcC7XEvtm3EsMs4LaBFIB7vllqH3K5tzk1lMCWj8MFaAtz7YSIHEhY1ozHVhQbfAsMFd+oHhPTZyw8gLcQDz6CL7RXmH3X69Vqan9bPDwet7GsVa2nw9nqu4t247NMoOIwbkS9WDP6IBpG2lDh6AmSsqkK1dk7DEExsdRAvEb513cOI7FTXUKRP7IuTV4JxTZPOWGYQvSxJC42yBF7QGA3oW5ttYK3bt8XG/xjcK6oerrZ8OfPzBvka4Nwif7zy2PSHQy4TZp0kmL2RC+lKcR24LEYdqfd5hDcA5rnLyxVGoQ8ComlFHTvttdPd01JSa5G/CbGbtbytorZkybxl2qcBPO8yyt42kXdgN1x+Kxe9jiafcQ7Oz8fXP3zNkerNmklcaBADAEB/zh2Mwq3IUU+d8wVHGYMZrJUZqCFoHBxxdSsKw3q7WN9LytiaKY174Q8WOr7ivgDjDbCR27RdjCIsi3n9mhwXjfbCyY5ZST3L/QAJWD9cqB3ntNkW54COtT5pGg=
Received-SPF: pass client-ip=57.103.73.212;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_A78332F2-CDE4-418F-8778-B9B95AD765D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 16. Feb 2026, at 08:39, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> On Fri, Feb 6, 2026 at 6:44=E2=80=AFPM Igor Mammedov =
<imammedo@redhat.com> wrote:
>>=20
>> Windows doesn't ship built-in TCO watchdog driver, and users are
>> forced to install vendor specific driver(s) if such exists.
>> However OS provides a generic watchdog driver that uses
>> ACPI WDAT table [1] to abstract actual hardware behind it.
>> The same applies to ARM version of Windows.
>>=20
>> This series adds
>> *  WDAT table tailored for TCO watchdog that Q35 already
>>    has as part of ICH9 chipset and a knob to enable it.
>> *  SBSA GWDT to arm/vit machine with WDAT table tailored
>>    for it and necessary tweaks to GWDT to make usable
>>    with WDAT driver.
>>=20
>> Guest OS support is present since Windows Vista and Linux since =
2016[2].
>=20
> I am confused. The linux documentation for arm64 says WDAT is not =
supported
> =
https://www.kernel.org/doc/html/latest/arch/arm64/acpi_object_usage.html
Hi,

It=E2=80=99s outdated documentation, support for it has been added in =
https://lkml.iu.edu/hypermail/linux/kernel/1609.1/04003.html

>=20
>>=20
>> One can test it launching VM with following options:
>>   -machine acpi-watchdog=3Don
>> to trace access to TCO registers one can add to CLI:
>>    -trace "tco_*"
>> to trace access to GWDT registers one can add to CLI:
>>    -trace "sbsa_gwdt*"
>>=20
>> To verify that guest uses WDAT (both Windows and Linux would use it =
if present),
>>  * on linux make sure that watchdog service is configured/enabled
>>   (use wdctl to check what watchdog device to use and confirm that =
it's
>>    wadt based one) and then trigger kernel panic with command:
>>      echo c > /proc/sysrq-trigger
>>  * on Windows kill svchost process, running cmd in admin mode:
>>      taskkill /f /im svchost.exe
>>=20
>> Tested with WS2025 & RHEL9.6 & Fedore 43 (aarch64)
>>=20
>> git tree at: https://gitlab.com/imammedo/qemu/-/commits/gwdt_v2
>>=20
>> 1) http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
>> 2) https://lwn.net/Articles/700524/
>>=20
>> PS:
>> previous revision (q35 only):
>> =
https://patchwork.ozlabs.org/project/qemu-devel/cover/20251030123750.13617=
5-1-imammedo@redhat.com/
>>=20
>> Also CCing SBSA folks to see if they are interested in adding it to =
their
>> reference machine
>>=20
>> Igor Mammedov (11):
>>  acpi: add API to build WDAT instructions
>>  machine: add "acpi-watchdog" property
>>  x86: q35: generate WDAT ACPI table
>>  tests: acpi: x86/q35: whitelist new WDAT table
>>  tests: acpi: x86/q35: add WDAT table test case
>>  tests: acpi: x86/q35: update expected WDAT blob
>>  arm: add tracing events to sbsa_gwdt
>>  arm: virt: create GWDT watchdog paired with WDAT ACPI table
>>  tests: acpi: arm/virt: whitelist new WDAT table
>>  tests: acpi: arm/virt: add WDAT table test case
>>  tests: acpi: arm/virt: update expected WDAT blob
>>=20
>> include/hw/acpi/wdat-gwdt.h            |  19 ++++
>> include/hw/acpi/wdat-ich9.h            |  15 ++++
>> include/hw/acpi/wdat.h                 | 118 =
+++++++++++++++++++++++++
>> include/hw/arm/virt.h                  |   3 +
>> include/hw/core/boards.h               |   1 +
>> hw/acpi/aml-build.c                    |  14 +++
>> hw/acpi/meson.build                    |   5 +-
>> hw/acpi/wdat-gwdt-stub.c               |  16 ++++
>> hw/acpi/wdat-gwdt.c                    |  92 +++++++++++++++++++
>> hw/acpi/wdat-ich9-stub.c               |  15 ++++
>> hw/acpi/wdat-ich9.c                    |  87 ++++++++++++++++++
>> hw/arm/Kconfig                         |   1 +
>> hw/arm/virt-acpi-build.c               |  16 ++++
>> hw/arm/virt.c                          |  26 ++++++
>> hw/core/machine.c                      |  20 +++++
>> hw/i386/acpi-build.c                   |  12 +++
>> hw/watchdog/sbsa_gwdt.c                |   8 ++
>> hw/watchdog/trace-events               |   9 ++
>> tests/data/acpi/aarch64/virt/WDAT.wdat | Bin 0 -> 260 bytes
>> tests/data/acpi/x86/q35/WDAT.wdat      | Bin 0 -> 308 bytes
>> tests/qtest/bios-tables-test.c         |  34 +++++++
>> 21 files changed, 510 insertions(+), 1 deletion(-)
>> create mode 100644 include/hw/acpi/wdat-gwdt.h
>> create mode 100644 include/hw/acpi/wdat-ich9.h
>> create mode 100644 include/hw/acpi/wdat.h
>> create mode 100644 hw/acpi/wdat-gwdt-stub.c
>> create mode 100644 hw/acpi/wdat-gwdt.c
>> create mode 100644 hw/acpi/wdat-ich9-stub.c
>> create mode 100644 hw/acpi/wdat-ich9.c
>> create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat
>> create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat
>>=20
>> --
>> 2.47.3
>>=20
>=20
>=20


--Apple-Mail=_A78332F2-CDE4-418F-8778-B9B95AD765D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 16. Feb 2026, at 08:39, Ani Sinha =
&lt;anisinha@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Fri, Feb 6, 2026 at =
6:44=E2=80=AFPM Igor Mammedov &lt;imammedo@redhat.com&gt; =
wrote:<br><blockquote type=3D"cite"><br>Windows doesn't ship built-in =
TCO watchdog driver, and users are<br>forced to install vendor specific =
driver(s) if such exists.<br>However OS provides a generic watchdog =
driver that uses<br>ACPI WDAT table [1] to abstract actual hardware =
behind it.<br>The same applies to ARM version of Windows.<br><br>This =
series adds<br> * &nbsp;WDAT table tailored for TCO watchdog that Q35 =
already<br> &nbsp;&nbsp;&nbsp;has as part of ICH9 chipset and a knob to =
enable it.<br> * &nbsp;SBSA GWDT to arm/vit machine with WDAT table =
tailored<br> &nbsp;&nbsp;&nbsp;for it and necessary tweaks to GWDT to =
make usable<br> &nbsp;&nbsp;&nbsp;with WDAT driver.<br><br>Guest OS =
support is present since Windows Vista and Linux since =
2016[2].<br></blockquote><br>I am confused. The linux documentation for =
arm64 says WDAT is not =
supported<br>https://www.kernel.org/doc/html/latest/arch/arm64/acpi_object=
_usage.html<br></div></div></blockquote><div>Hi,</div><div><br></div>It=E2=
=80=99s outdated documentation, support for it has been added in&nbsp;<a =
href=3D"https://lkml.iu.edu/hypermail/linux/kernel/1609.1/04003.html">http=
s://lkml.iu.edu/hypermail/linux/kernel/1609.1/04003.html</a></div><div><br=
><blockquote type=3D"cite"><div><div><br><blockquote type=3D"cite"><br>One=
 can test it launching VM with following options:<br> =
&nbsp;&nbsp;-machine acpi-watchdog=3Don<br>to trace access to TCO =
registers one can add to CLI:<br> &nbsp;&nbsp;&nbsp;-trace "tco_*"<br>to =
trace access to GWDT registers one can add to CLI:<br> =
&nbsp;&nbsp;&nbsp;-trace "sbsa_gwdt*"<br><br>To verify that guest uses =
WDAT (both Windows and Linux would use it if present),<br> &nbsp;* on =
linux make sure that watchdog service is configured/enabled<br> =
&nbsp;&nbsp;(use wdctl to check what watchdog device to use and confirm =
that it's<br> &nbsp;&nbsp;&nbsp;wadt based one) and then trigger kernel =
panic with command:<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo c &gt; =
/proc/sysrq-trigger<br> &nbsp;* on Windows kill svchost process, running =
cmd in admin mode:<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;taskkill /f /im =
svchost.exe<br><br>Tested with WS2025 &amp; RHEL9.6 &amp; Fedore 43 =
(aarch64)<br><br>git tree at: =
https://gitlab.com/imammedo/qemu/-/commits/gwdt_v2<br><br>1) =
http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx<br>2) =
https://lwn.net/Articles/700524/<br><br>PS:<br> previous revision (q35 =
only):<br> =
https://patchwork.ozlabs.org/project/qemu-devel/cover/20251030123750.13617=
5-1-imammedo@redhat.com/<br><br>Also CCing SBSA folks to see if they are =
interested in adding it to their<br>reference machine<br><br>Igor =
Mammedov (11):<br> &nbsp;acpi: add API to build WDAT instructions<br> =
&nbsp;machine: add "acpi-watchdog" property<br> &nbsp;x86: q35: generate =
WDAT ACPI table<br> &nbsp;tests: acpi: x86/q35: whitelist new WDAT =
table<br> &nbsp;tests: acpi: x86/q35: add WDAT table test case<br> =
&nbsp;tests: acpi: x86/q35: update expected WDAT blob<br> &nbsp;arm: add =
tracing events to sbsa_gwdt<br> &nbsp;arm: virt: create GWDT watchdog =
paired with WDAT ACPI table<br> &nbsp;tests: acpi: arm/virt: whitelist =
new WDAT table<br> &nbsp;tests: acpi: arm/virt: add WDAT table test =
case<br> &nbsp;tests: acpi: arm/virt: update expected WDAT blob<br><br> =
include/hw/acpi/wdat-gwdt.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;19 ++++<br> include/hw/acpi/wdat-ich9.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;15 ++++<br> include/hw/acpi/wdat.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| 118 +++++++++++++++++++++++++<br> =
include/hw/arm/virt.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;3 +<br> =
include/hw/core/boards.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;&nbsp;1 +<br> hw/acpi/aml-build.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;14 +++<br> =
hw/acpi/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;5 +-<br> =
hw/acpi/wdat-gwdt-stub.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;16 ++++<br> hw/acpi/wdat-gwdt.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;92 =
+++++++++++++++++++<br> hw/acpi/wdat-ich9-stub.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;15 ++++<br> hw/acpi/wdat-ich9.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;87 =
++++++++++++++++++<br> hw/arm/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;1 +<br> hw/arm/virt-acpi-build.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;16 ++++<br> hw/arm/virt.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;| &nbsp;26 ++++++<br> hw/core/machine.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;20 +++++<br> =
hw/i386/acpi-build.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;12 +++<br> =
hw/watchdog/sbsa_gwdt.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| &nbsp;&nbsp;8 ++<br> hw/watchdog/trace-events =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;&nbsp;9 ++<br> tests/data/acpi/aarch64/virt/WDAT.wdat =
| Bin 0 -&gt; 260 bytes<br> tests/data/acpi/x86/q35/WDAT.wdat =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| Bin 0 -&gt; 308 bytes<br> =
tests/qtest/bios-tables-test.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;34 +++++++<br> =
21 files changed, 510 insertions(+), 1 deletion(-)<br> create mode =
100644 include/hw/acpi/wdat-gwdt.h<br> create mode 100644 =
include/hw/acpi/wdat-ich9.h<br> create mode 100644 =
include/hw/acpi/wdat.h<br> create mode 100644 =
hw/acpi/wdat-gwdt-stub.c<br> create mode 100644 hw/acpi/wdat-gwdt.c<br> =
create mode 100644 hw/acpi/wdat-ich9-stub.c<br> create mode 100644 =
hw/acpi/wdat-ich9.c<br> create mode 100644 =
tests/data/acpi/aarch64/virt/WDAT.wdat<br> create mode 100644 =
tests/data/acpi/x86/q35/WDAT.wdat<br><br>--<br>2.47.3<br><br></blockquote>=
<br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_A78332F2-CDE4-418F-8778-B9B95AD765D8--

