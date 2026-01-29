Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A315FD6101F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 14:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlT6s-0004K5-HB; Thu, 29 Jan 2026 09:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlT6q-0004Fk-Ka
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:35:00 -0500
Received: from p-east2-cluster5-host10-snip4-10.eps.apple.com ([57.103.79.123]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlT6m-0002Nw-Ip
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:35:00 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 2F77E1800599; Thu, 29 Jan 2026 14:34:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769697293; x=1772289293;
 bh=iRoHC3cRPCFUflpSj7Dfkxtay1MuxZuuqyP5BLfbN54=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=G9hmJlCQ3hAejWDRxcJWgbcJvjugGyDCcKhH1OFusZJrII9Cw4wkCjS+S1usghumvJxlFWTty43yh2WuNGY0aXeBeiRz8lbQXr/e7SYCjihnbH6C2XTnNmfH9JE3Jj9KONRkb1jHoZcO+voQdXVGeRodmVLwpCjc/8MQcKm9jyWQYps1Hat1q3Tw4rH5UHs6X8n3gDr2+FU8e/bkO2rfP7LXH0+4OwNpE4zDEifWv5dq+di36Z5wB6dPq6gOQMcC9Rg5PTOCM+COwp6BrXSm7tClixEJp+HFaKIQbohpg5WH2rg3B63W4OkiBlS+f8JFRUQf+xvSiiob1pjVD4Tbfg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 446061800402; Thu, 29 Jan 2026 14:34:44 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v18 05/22] tests: data: update AArch64 ACPI tables
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA9qtLv1wOKkEmtNO5UsGTAM0x7YD+y8Fsu8hCQRAD_o5A@mail.gmail.com>
Date: Thu, 29 Jan 2026 15:34:32 +0100
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CDB1385-1197-4D36-A46C-80A8F71DA9C1@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-6-mohamed@unpredictable.fr>
 <CAFEAcA9qtLv1wOKkEmtNO5UsGTAM0x7YD+y8Fsu8hCQRAD_o5A@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwMCBTYWx0ZWRfXxWPN2f+0X59A
 trzCQf1tODzAYm91+7jMrV79aPKPbhLOcmVcSawhUONejzP4axk3n8iiMsxTfyEK/fEoheTSpZj
 0Y8iiWIdtfMgZnykiDLe6o64fOxJYfy2UH/Qd93cwyR3u4LNpktTf0X4xbIMqxNG6hnbl/IoW2j
 yBbO5pgxQ25eOn8ycq2mlgFXBlhnug6ZLA3kOJcFuYm9f1gW37JNSJJCKgWduEqRcJcHn/Xl6tV
 QX+qTQxVFWVg1mhlakjblyU5qlXFwbaAP28m1ZaMHO/Dpw8bIKkx9cOwuJJC85ZEJK4IfDuQu1G
 ICJRfjxjFTzyhmJD62D+04Lm1Nzt+EQI3x9KsNgVGTjBPTWylFGwv1nZk1d9Ik=
X-Proofpoint-GUID: kbK-EERfl4s8egF69-jgVkzIFVYGqUyW
X-Authority-Info-Out: v=2.4 cv=V/twEOni c=1 sm=1 tr=0 ts=697b700b
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=fAOk_Casj0TrArIvxeoA:9
 a=9J1rdWVbI_vzw9Y_:21 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kbK-EERfl4s8egF69-jgVkzIFVYGqUyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 clxscore=1030 suspectscore=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290100
X-JNJ: AAAAAAAB5Ognysan4bPWUbx0qUjzTezjnyba1Bf/yN1SFAxQDvxtbB2xI5DEs0vo2N9qTnb/IeNHbXcUFj2XqQEP1CZ+Uk06roEF29KjIHR7WufHRs5IjVOrqmE/juRXFzwDxK6c/hQkDqRSnDWqnRC5z1jWI9Yf2RvdHM8IKslyFxKP7uHpn0TRj849T4rbji7T/qsGToNQpUMCv7dIXo6YGjV7Hc6RyWHSxUgqJYv6JNDR6PTvzf0ARjRVzQ1WBcvxJ2ZeI8rq2VI0XXtSeav+vMWy4RTDB5owgK7ZlsWpJc50Lx0qAJG+YUxWy+/wvOUvtZui4fMXYt9p9Q5f+3O1zvJh1ziba7/M7U03+BwNWNS7Mu28AYy5txeW5mQNvNswVyfoCwHKVf9okb9V235KofpA1W5kWuDYOvD6Cpuf6/ZjmHmXmTqT1mgoOGxiIOTWkuMX+p0sqkShlud04X3jtT08u0VWhc403UfX4GzLGxc5BPiXWQHW2/tP2WQOjp0nFF5KH5AEaCas2k+L5kFDod2gow7CR+7pGsKfJPsdrn4uWpQa7G/aZkl7+GYrMXqMKgyJOhMYy3f2TH8H7eF1rMNygXbVudJcL+7ZngwHC6UIcP7IrD0PsXawiBYNXzye/rjPo+GtxAOsFxXaPKXBaRVTQ6xXq6h3FlLthVWPi4Dcva+2dfygl3e6LIiY+ikQg81vHVjCAW4YJtrndXq8paubJ2KZXwn7m0kcxSWsMGHV3RBVh5pep9aWXhJK1oiSsfSWqq9SfCKSeJ+gapCChDlXsRItI+Y1ym/esuucVUiN4l+pmw11MElR/IuFaOXmCNcW2VIybfABQYNoZDAOikHUhJx159W+CS3Ebrfr1oRu+BjEKsZK8vQl1ltbcQGOHr0EIWbkxgfobgyEtSdOaT03bv2XydAMJ3I=
Received-SPF: pass client-ip=57.103.79.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



> On 29. Jan 2026, at 14:36, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Tue, 27 Jan 2026 at 18:28, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> After the previous commit introducing GICv3 + GICv2m configurations,
>> update the AArch64 ACPI tables for the GICv2 case.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 84 bytes
>> tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 260 =
bytes
>> tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 192 =
bytes
>> tests/qtest/bios-tables-test-allowed-diff.h     |   3 ---
>> 4 files changed, 3 deletions(-)
>=20
> The process documented in tests/qtest/bios-tables-test.c says
> that this commit is supposed to have the diff of the disassembled
> table data in the commit message, so that human reviewers can
> confirm that the changes are as expected. (If you git log
> tests/data/acpi you can see how this looks.)
>=20
> Can you provide the ASL diff, please? (If this is going to be the
> only fix needed to this version of the series, which I hope it
> will be, then I can update the commit message as I apply the
> series, so you don't need to respin, just reply with the updated
> commit message with the diff in it.)
>=20
> thanks
> =E2=80=94 PMM
Hi,

Here=E2=80=99s the expected asl diff:

diff otp/tests/data/acpi/aarch64/virt/IORT.dsl =
otp2/tests/data/acpi/aarch64/virt/IORT.dsl
14c14
< [004h 0004 004h]                Table Length : 00000080
---
> [004h 0004 004h]                Table Length : 00000054
16c16
< [009h 0009 001h]                    Checksum : B3
---
> [009h 0009 001h]                    Checksum : 3E
23c23
< [024h 0036 004h]                  Node Count : 00000002
---
> [024h 0036 004h]                  Node Count : 00000001
27,29c27,29
< [030h 0048 001h]                        Type : 00
< [031h 0049 002h]                      Length : 0018
< [033h 0051 001h]                    Revision : 01
---
> [030h 0048 001h]                        Type : 02
> [031h 0049 002h]                      Length : 0024
> [033h 0051 001h]                    Revision : 03
32c32
< [03Ch 0060 004h]              Mapping Offset : 00000000
---
> [03Ch 0060 004h]              Mapping Offset : 00000024
34,46c34,36
< [040h 0064 004h]                    ItsCount : 00000001
< [044h 0068 004h]                 Identifiers : 00000000
<=20
< [048h 0072 001h]                        Type : 02
< [049h 0073 002h]                      Length : 0038
< [04Bh 0075 001h]                    Revision : 03
< [04Ch 0076 004h]                  Identifier : 00000001
< [050h 0080 004h]               Mapping Count : 00000001
< [054h 0084 004h]              Mapping Offset : 00000024
<=20
< [058h 0088 008h]           Memory Properties : [IORT Memory Access =
Properties]
< [058h 0088 004h]             Cache Coherency : 00000001
< [05Ch 0092 001h]       Hints (decoded below) : 00
---
> [040h 0064 008h]           Memory Properties : [IORT Memory Access =
Properties]
> [040h 0064 004h]             Cache Coherency : 00000001
> [044h 0068 001h]       Hints (decoded below) : 00
51,52c41,42
< [05Dh 0093 002h]                    Reserved : 0000
< [05Fh 0095 001h] Memory Flags (decoded below) : 03
---
> [045h 0069 002h]                    Reserved : 0000
> [047h 0071 001h] Memory Flags (decoded below) : 03
56,60c46,50
< [060h 0096 004h]               ATS Attribute : 00000000
< [064h 0100 004h]          PCI Segment Number : 00000000
< [068h 0104 001h]           Memory Size Limit : 40
< [069h 0105 002h]          PASID Capabilities : 0000
< [06Bh 0107 001h]                    Reserved : 00
---
> [048h 0072 004h]               ATS Attribute : 00000000
> [04Ch 0076 004h]          PCI Segment Number : 00000000
> [050h 0080 001h]           Memory Size Limit : 40
> [051h 0081 002h]          PASID Capabilities : 0000
> [053h 0083 001h]                    Reserved : 00
62,67c52
< [06Ch 0108 004h]                  Input base : 00000000
< [070h 0112 004h]                    ID Count : 0000FFFF
< [074h 0116 004h]                 Output Base : 00000000
< [078h 0120 004h]            Output Reference : 00000030
< [07Ch 0124 004h]       Flags (decoded below) : 00000000
<                               Single Mapping : 0
---
> Raw Table Data: Length 84 (0x54)
69,71c54
< Raw Table Data: Length 128 (0x80)
<=20
<     0000: 49 4F 52 54 80 00 00 00 03 B3 42 4F 43 48 53 20  // =
IORT......BOCHS=20
---
>     0000: 49 4F 52 54 54 00 00 00 03 3E 42 4F 43 48 53 20  // =
IORTT....>BOCHS=20
73,78c56,59
<     0020: 01 00 00 00 02 00 00 00 30 00 00 00 00 00 00 00  // =
........0.......
<     0030: 00 18 00 01 00 00 00 00 00 00 00 00 00 00 00 00  // =
................
<     0040: 01 00 00 00 00 00 00 00 02 38 00 03 01 00 00 00  // =
.........8......
<     0050: 01 00 00 00 24 00 00 00 01 00 00 00 00 00 00 03  // =
....$...........
<     0060: 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  // =
........@.......
<     0070: FF FF 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // =
........0.......
---
>     0020: 01 00 00 00 01 00 00 00 30 00 00 00 00 00 00 00  // =
........0.......
>     0030: 02 24 00 03 00 00 00 00 00 00 00 00 24 00 00 00  // =
.$..........$...
>     0040: 01 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00  // =
................
>     0050: 40 00 00 00                                      // @...

diff otp/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev.dsl =
otp2/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev.dsl
14c14
< [004h 0004 004h]                Table Length : 0000016C
---
> [004h 0004 004h]                Table Length : 00000104
16c16
< [009h 0009 001h]                    Checksum : CA
---
> [009h 0009 001h]                    Checksum : 4B
23c23
< [024h 0036 004h]                  Node Count : 00000004
---
> [024h 0036 004h]                  Node Count : 00000003
27,29c27,29
< [030h 0048 001h]                        Type : 00
< [031h 0049 002h]                      Length : 0018
< [033h 0051 001h]                    Revision : 01
---
> [030h 0048 001h]                        Type : 04
> [031h 0049 002h]                      Length : 0044
> [033h 0051 001h]                    Revision : 04
34,45c34,35
< [040h 0064 004h]                    ItsCount : 00000001
< [044h 0068 004h]                 Identifiers : 00000000
<=20
< [048h 0072 001h]                        Type : 04
< [049h 0073 002h]                      Length : 0058
< [04Bh 0075 001h]                    Revision : 04
< [04Ch 0076 004h]                  Identifier : 00000001
< [050h 0080 004h]               Mapping Count : 00000001
< [054h 0084 004h]              Mapping Offset : 00000044
<=20
< [058h 0088 008h]                Base Address : 000000000C000000
< [060h 0096 004h]       Flags (decoded below) : 00000001
---
> [040h 0064 008h]                Base Address : 000000000C000000
> [048h 0072 004h]       Flags (decoded below) : 00000001
50,58c40,48
< [064h 0100 004h]                    Reserved : 00000000
< [068h 0104 008h]               VATOS Address : 0000000000000000
< [070h 0112 004h]                       Model : 00000000
< [074h 0116 004h]                  Event GSIV : 00000090
< [078h 0120 004h]                    PRI GSIV : 00000091
< [07Ch 0124 004h]                   GERR GSIV : 00000093
< [080h 0128 004h]                   Sync GSIV : 00000092
< [084h 0132 004h]            Proximity Domain : 00000000
< [088h 0136 004h]     Device ID Mapping Index : 00000000
---
> [04Ch 0076 004h]                    Reserved : 00000000
> [050h 0080 008h]               VATOS Address : 0000000000000000
> [058h 0088 004h]                       Model : 00000000
> [05Ch 0092 004h]                  Event GSIV : 00000090
> [060h 0096 004h]                    PRI GSIV : 00000091
> [064h 0100 004h]                   GERR GSIV : 00000093
> [068h 0104 004h]                   Sync GSIV : 00000092
> [06Ch 0108 004h]            Proximity Domain : 00000000
> [070h 0112 004h]     Device ID Mapping Index : 00000000
60,65c50,55
< [08Ch 0140 004h]                  Input base : 00000000
< [090h 0144 004h]                    ID Count : 0000FFFF
< [094h 0148 004h]                 Output Base : 00000000
< [098h 0152 004h]            Output Reference : 00000030
< [09Ch 0156 004h]       Flags (decoded below) : 00000000
<                               Single Mapping : 0
---
> [074h 0116 001h]                        Type : 04
> [075h 0117 002h]                      Length : 0044
> [077h 0119 001h]                    Revision : 04
> [078h 0120 004h]                  Identifier : 00000001
> [07Ch 0124 004h]               Mapping Count : 00000000
> [080h 0128 004h]              Mapping Offset : 00000000
67,75c57,58
< [0A0h 0160 001h]                        Type : 04
< [0A1h 0161 002h]                      Length : 0058
< [0A3h 0163 001h]                    Revision : 04
< [0A4h 0164 004h]                  Identifier : 00000002
< [0A8h 0168 004h]               Mapping Count : 00000001
< [0ACh 0172 004h]              Mapping Offset : 00000044
<=20
< [0B0h 0176 008h]                Base Address : 000000000C020000
< [0B8h 0184 004h]       Flags (decoded below) : 00000001
---
> [084h 0132 008h]                Base Address : 000000000C020000
> [08Ch 0140 004h]       Flags (decoded below) : 00000001
80,88c63,71
< [0BCh 0188 004h]                    Reserved : 00000000
< [0C0h 0192 008h]               VATOS Address : 0000000000000000
< [0C8h 0200 004h]                       Model : 00000000
< [0CCh 0204 004h]                  Event GSIV : 00000094
< [0D0h 0208 004h]                    PRI GSIV : 00000095
< [0D4h 0212 004h]                   GERR GSIV : 00000097
< [0D8h 0216 004h]                   Sync GSIV : 00000096
< [0DCh 0220 004h]            Proximity Domain : 00000000
< [0E0h 0224 004h]     Device ID Mapping Index : 00000000
---
> [090h 0144 004h]                    Reserved : 00000000
> [094h 0148 008h]               VATOS Address : 0000000000000000
> [09Ch 0156 004h]                       Model : 00000000
> [0A0h 0160 004h]                  Event GSIV : 00000094
> [0A4h 0164 004h]                    PRI GSIV : 00000095
> [0A8h 0168 004h]                   GERR GSIV : 00000097
> [0ACh 0172 004h]                   Sync GSIV : 00000096
> [0B0h 0176 004h]            Proximity Domain : 00000000
> [0B4h 0180 004h]     Device ID Mapping Index : 00000000
90,95c73,78
< [0E4h 0228 004h]                  Input base : 00000000
< [0E8h 0232 004h]                    ID Count : 0000FFFF
< [0ECh 0236 004h]                 Output Base : 00000000
< [0F0h 0240 004h]            Output Reference : 00000030
< [0F4h 0244 004h]       Flags (decoded below) : 00000000
<                               Single Mapping : 0
---
> [0B8h 0184 001h]                        Type : 02
> [0B9h 0185 002h]                      Length : 004C
> [0BBh 0187 001h]                    Revision : 03
> [0BCh 0188 004h]                  Identifier : 00000002
> [0C0h 0192 004h]               Mapping Count : 00000002
> [0C4h 0196 004h]              Mapping Offset : 00000024
97,106c80,82
< [0F8h 0248 001h]                        Type : 02
< [0F9h 0249 002h]                      Length : 0074
< [0FBh 0251 001h]                    Revision : 03
< [0FCh 0252 004h]                  Identifier : 00000003
< [100h 0256 004h]               Mapping Count : 00000004
< [104h 0260 004h]              Mapping Offset : 00000024
<=20
< [108h 0264 008h]           Memory Properties : [IORT Memory Access =
Properties]
< [108h 0264 004h]             Cache Coherency : 00000001
< [10Ch 0268 001h]       Hints (decoded below) : 00
---
> [0C8h 0200 008h]           Memory Properties : [IORT Memory Access =
Properties]
> [0C8h 0200 004h]             Cache Coherency : 00000001
> [0CCh 0204 001h]       Hints (decoded below) : 00
111,112c87,88
< [10Dh 0269 002h]                    Reserved : 0000
< [10Fh 0271 001h] Memory Flags (decoded below) : 03
---
> [0CDh 0205 002h]                    Reserved : 0000
> [0CFh 0207 001h] Memory Flags (decoded below) : 03
116,120c92,96
< [110h 0272 004h]               ATS Attribute : 00000000
< [114h 0276 004h]          PCI Segment Number : 00000000
< [118h 0280 001h]           Memory Size Limit : 40
< [119h 0281 002h]          PASID Capabilities : 0000
< [11Bh 0283 001h]                    Reserved : 00
---
> [0D0h 0208 004h]               ATS Attribute : 00000000
> [0D4h 0212 004h]          PCI Segment Number : 00000000
> [0D8h 0216 001h]           Memory Size Limit : 40
> [0D9h 0217 002h]          PASID Capabilities : 0000
> [0DBh 0219 001h]                    Reserved : 00
122,126c98,102
< [11Ch 0284 004h]                  Input base : 00000000
< [120h 0288 004h]                    ID Count : 000001FF
< [124h 0292 004h]                 Output Base : 00000000
< [128h 0296 004h]            Output Reference : 00000048
< [12Ch 0300 004h]       Flags (decoded below) : 00000000
---
> [0DCh 0220 004h]                  Input base : 00000000
> [0E0h 0224 004h]                    ID Count : 000001FF
> [0E4h 0228 004h]                 Output Base : 00000000
> [0E8h 0232 004h]            Output Reference : 00000030
> [0ECh 0236 004h]       Flags (decoded below) : 00000000
129,133c105,109
< [130h 0304 004h]                  Input base : 00001000
< [134h 0308 004h]                    ID Count : 000000FF
< [138h 0312 004h]                 Output Base : 00001000
< [13Ch 0316 004h]            Output Reference : 000000A0
< [140h 0320 004h]       Flags (decoded below) : 00000000
---
> [0F0h 0240 004h]                  Input base : 00001000
> [0F4h 0244 004h]                    ID Count : 000000FF
> [0F8h 0248 004h]                 Output Base : 00001000
> [0FCh 0252 004h]            Output Reference : 00000074
> [100h 0256 004h]       Flags (decoded below) : 00000000
136,141c112
< [144h 0324 004h]                  Input base : 00000200
< [148h 0328 004h]                    ID Count : 00000DFF
< [14Ch 0332 004h]                 Output Base : 00000200
< [150h 0336 004h]            Output Reference : 00000030
< [154h 0340 004h]       Flags (decoded below) : 00000000
<                               Single Mapping : 0
---
> Raw Table Data: Length 260 (0x104)
143,152c114
< [158h 0344 004h]                  Input base : 00001100
< [15Ch 0348 004h]                    ID Count : 0000EEFF
< [160h 0352 004h]                 Output Base : 00001100
< [164h 0356 004h]            Output Reference : 00000030
< [168h 0360 004h]       Flags (decoded below) : 00000000
<                               Single Mapping : 0
<=20
< Raw Table Data: Length 364 (0x16C)
<=20
<     0000: 49 4F 52 54 6C 01 00 00 03 CA 42 4F 43 48 53 20  // =
IORTl.....BOCHS=20
---
>     0000: 49 4F 52 54 04 01 00 00 03 4B 42 4F 43 48 53 20  // =
IORT.....KBOCHS=20
154,174c116,130
<     0020: 01 00 00 00 04 00 00 00 30 00 00 00 00 00 00 00  // =
........0.......
<     0030: 00 18 00 01 00 00 00 00 00 00 00 00 00 00 00 00  // =
................
<     0040: 01 00 00 00 00 00 00 00 04 58 00 04 01 00 00 00  // =
.........X......
<     0050: 01 00 00 00 44 00 00 00 00 00 00 0C 00 00 00 00  // =
....D...........
<     0060: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // =
................
<     0070: 00 00 00 00 90 00 00 00 91 00 00 00 93 00 00 00  // =
................
<     0080: 92 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // =
................
<     0090: FF FF 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // =
........0.......
<     00A0: 04 58 00 04 02 00 00 00 01 00 00 00 44 00 00 00  // =
.X..........D...
<     00B0: 00 00 02 0C 00 00 00 00 01 00 00 00 00 00 00 00  // =
................
<     00C0: 00 00 00 00 00 00 00 00 00 00 00 00 94 00 00 00  // =
................
<     00D0: 95 00 00 00 97 00 00 00 96 00 00 00 00 00 00 00  // =
................
<     00E0: 00 00 00 00 00 00 00 00 FF FF 00 00 00 00 00 00  // =
................
<     00F0: 30 00 00 00 00 00 00 00 02 74 00 03 03 00 00 00  // =
0........t......
<     0100: 04 00 00 00 24 00 00 00 01 00 00 00 00 00 00 03  // =
....$...........
<     0110: 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  // =
........@.......
<     0120: FF 01 00 00 00 00 00 00 48 00 00 00 00 00 00 00  // =
........H.......
<     0130: 00 10 00 00 FF 00 00 00 00 10 00 00 A0 00 00 00  // =
................
<     0140: 00 00 00 00 00 02 00 00 FF 0D 00 00 00 02 00 00  // =
................
<     0150: 30 00 00 00 00 00 00 00 00 11 00 00 FF EE 00 00  // =
0...............
<     0160: 00 11 00 00 30 00 00 00 00 00 00 00              // =
....0.......
---
>     0020: 01 00 00 00 03 00 00 00 30 00 00 00 00 00 00 00  // =
........0.......
>     0030: 04 44 00 04 00 00 00 00 00 00 00 00 00 00 00 00  // =
.D..............
>     0040: 00 00 00 0C 00 00 00 00 01 00 00 00 00 00 00 00  // =
................
>     0050: 00 00 00 00 00 00 00 00 00 00 00 00 90 00 00 00  // =
................
>     0060: 91 00 00 00 93 00 00 00 92 00 00 00 00 00 00 00  // =
................
>     0070: 00 00 00 00 04 44 00 04 01 00 00 00 00 00 00 00  // =
.....D..........
>     0080: 00 00 00 00 00 00 02 0C 00 00 00 00 01 00 00 00  // =
................
>     0090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // =
................
>     00A0: 94 00 00 00 95 00 00 00 97 00 00 00 96 00 00 00  // =
................
>     00B0: 00 00 00 00 00 00 00 00 02 4C 00 03 02 00 00 00  // =
.........L......
>     00C0: 02 00 00 00 24 00 00 00 01 00 00 00 00 00 00 03  // =
....$...........
>     00D0: 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  // =
........@.......
>     00E0: FF 01 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // =
........0.......
>     00F0: 00 10 00 00 FF 00 00 00 00 10 00 00 74 00 00 00  // =
............t...
>     0100: 00 00 00 00                                      // ....

diff otp/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy.dsl =
otp2/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy.dsl
14c14
< [004h 0004 004h]                Table Length : 00000114
---
> [004h 0004 004h]                Table Length : 000000C0
16c16
< [009h 0009 001h]                    Checksum : 4C
---
> [009h 0009 001h]                    Checksum : 1E
23c23
< [024h 0036 004h]                  Node Count : 00000003
---
> [024h 0036 004h]                  Node Count : 00000002
27,29c27,29
< [030h 0048 001h]                        Type : 00
< [031h 0049 002h]                      Length : 0018
< [033h 0051 001h]                    Revision : 01
---
> [030h 0048 001h]                        Type : 04
> [031h 0049 002h]                      Length : 0044
> [033h 0051 001h]                    Revision : 04
34,45c34,35
< [040h 0064 004h]                    ItsCount : 00000001
< [044h 0068 004h]                 Identifiers : 00000000
<=20
< [048h 0072 001h]                        Type : 04
< [049h 0073 002h]                      Length : 0058
< [04Bh 0075 001h]                    Revision : 04
< [04Ch 0076 004h]                  Identifier : 00000001
< [050h 0080 004h]               Mapping Count : 00000001
< [054h 0084 004h]              Mapping Offset : 00000044
<=20
< [058h 0088 008h]                Base Address : 0000000009050000
< [060h 0096 004h]       Flags (decoded below) : 00000001
---
> [040h 0064 008h]                Base Address : 0000000009050000
> [048h 0072 004h]       Flags (decoded below) : 00000001
50,58c40,48
< [064h 0100 004h]                    Reserved : 00000000
< [068h 0104 008h]               VATOS Address : 0000000000000000
< [070h 0112 004h]                       Model : 00000000
< [074h 0116 004h]                  Event GSIV : 0000006A
< [078h 0120 004h]                    PRI GSIV : 0000006B
< [07Ch 0124 004h]                   GERR GSIV : 0000006D
< [080h 0128 004h]                   Sync GSIV : 0000006C
< [084h 0132 004h]            Proximity Domain : 00000000
< [088h 0136 004h]     Device ID Mapping Index : 00000000
---
> [04Ch 0076 004h]                    Reserved : 00000000
> [050h 0080 008h]               VATOS Address : 0000000000000000
> [058h 0088 004h]                       Model : 00000000
> [05Ch 0092 004h]                  Event GSIV : 0000006A
> [060h 0096 004h]                    PRI GSIV : 0000006B
> [064h 0100 004h]                   GERR GSIV : 0000006D
> [068h 0104 004h]                   Sync GSIV : 0000006C
> [06Ch 0108 004h]            Proximity Domain : 00000000
> [070h 0112 004h]     Device ID Mapping Index : 00000000
60,65c50,55
< [08Ch 0140 004h]                  Input base : 00000000
< [090h 0144 004h]                    ID Count : 0000FFFF
< [094h 0148 004h]                 Output Base : 00000000
< [098h 0152 004h]            Output Reference : 00000030
< [09Ch 0156 004h]       Flags (decoded below) : 00000000
<                               Single Mapping : 0
---
> [074h 0116 001h]                        Type : 02
> [075h 0117 002h]                      Length : 004C
> [077h 0119 001h]                    Revision : 03
> [078h 0120 004h]                  Identifier : 00000001
> [07Ch 0124 004h]               Mapping Count : 00000002
> [080h 0128 004h]              Mapping Offset : 00000024
67,76c57,59
< [0A0h 0160 001h]                        Type : 02
< [0A1h 0161 002h]                      Length : 0074
< [0A3h 0163 001h]                    Revision : 03
< [0A4h 0164 004h]                  Identifier : 00000002
< [0A8h 0168 004h]               Mapping Count : 00000004
< [0ACh 0172 004h]              Mapping Offset : 00000024
<=20
< [0B0h 0176 008h]           Memory Properties : [IORT Memory Access =
Properties]
< [0B0h 0176 004h]             Cache Coherency : 00000001
< [0B4h 0180 001h]       Hints (decoded below) : 00
---
> [084h 0132 008h]           Memory Properties : [IORT Memory Access =
Properties]
> [084h 0132 004h]             Cache Coherency : 00000001
> [088h 0136 001h]       Hints (decoded below) : 00
81,82c64,65
< [0B5h 0181 002h]                    Reserved : 0000
< [0B7h 0183 001h] Memory Flags (decoded below) : 03
---
> [089h 0137 002h]                    Reserved : 0000
> [08Bh 0139 001h] Memory Flags (decoded below) : 03
86,90c69,73
< [0B8h 0184 004h]               ATS Attribute : 00000000
< [0BCh 0188 004h]          PCI Segment Number : 00000000
< [0C0h 0192 001h]           Memory Size Limit : 40
< [0C1h 0193 002h]          PASID Capabilities : 0000
< [0C3h 0195 001h]                    Reserved : 00
---
> [08Ch 0140 004h]               ATS Attribute : 00000000
> [090h 0144 004h]          PCI Segment Number : 00000000
> [094h 0148 001h]           Memory Size Limit : 40
> [095h 0149 002h]          PASID Capabilities : 0000
> [097h 0151 001h]                    Reserved : 00
92,96c75,79
< [0C4h 0196 004h]                  Input base : 00000000
< [0C8h 0200 004h]                    ID Count : 000001FF
< [0CCh 0204 004h]                 Output Base : 00000000
< [0D0h 0208 004h]            Output Reference : 00000048
< [0D4h 0212 004h]       Flags (decoded below) : 00000000
---
> [098h 0152 004h]                  Input base : 00000000
> [09Ch 0156 004h]                    ID Count : 000001FF
> [0A0h 0160 004h]                 Output Base : 00000000
> [0A4h 0164 004h]            Output Reference : 00000030
> [0A8h 0168 004h]       Flags (decoded below) : 00000000
99,103c82,86
< [0D8h 0216 004h]                  Input base : 00001000
< [0DCh 0220 004h]                    ID Count : 000000FF
< [0E0h 0224 004h]                 Output Base : 00001000
< [0E4h 0228 004h]            Output Reference : 00000048
< [0E8h 0232 004h]       Flags (decoded below) : 00000000
---
> [0ACh 0172 004h]                  Input base : 00001000
> [0B0h 0176 004h]                    ID Count : 000000FF
> [0B4h 0180 004h]                 Output Base : 00001000
> [0B8h 0184 004h]            Output Reference : 00000030
> [0BCh 0188 004h]       Flags (decoded below) : 00000000
106,111c89
< [0ECh 0236 004h]                  Input base : 00000200
< [0F0h 0240 004h]                    ID Count : 00000DFF
< [0F4h 0244 004h]                 Output Base : 00000200
< [0F8h 0248 004h]            Output Reference : 00000030
< [0FCh 0252 004h]       Flags (decoded below) : 00000000
<                               Single Mapping : 0
---
> Raw Table Data: Length 192 (0xC0)
113,122c91
< [100h 0256 004h]                  Input base : 00001100
< [104h 0260 004h]                    ID Count : 0000EEFF
< [108h 0264 004h]                 Output Base : 00001100
< [10Ch 0268 004h]            Output Reference : 00000030
< [110h 0272 004h]       Flags (decoded below) : 00000000
<                               Single Mapping : 0
<=20
< Raw Table Data: Length 276 (0x114)
<=20
<     0000: 49 4F 52 54 14 01 00 00 03 4C 42 4F 43 48 53 20  // =
IORT.....LBOCHS=20
---
>     0000: 49 4F 52 54 C0 00 00 00 03 1E 42 4F 43 48 53 20  // =
IORT......BOCHS=20
124,139c93,102
<     0020: 01 00 00 00 03 00 00 00 30 00 00 00 00 00 00 00  // =
........0.......
<     0030: 00 18 00 01 00 00 00 00 00 00 00 00 00 00 00 00  // =
................
<     0040: 01 00 00 00 00 00 00 00 04 58 00 04 01 00 00 00  // =
.........X......
<     0050: 01 00 00 00 44 00 00 00 00 00 05 09 00 00 00 00  // =
....D...........
<     0060: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // =
................
<     0070: 00 00 00 00 6A 00 00 00 6B 00 00 00 6D 00 00 00  // =
....j...k...m...
<     0080: 6C 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // =
l...............
<     0090: FF FF 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // =
........0.......
<     00A0: 02 74 00 03 02 00 00 00 04 00 00 00 24 00 00 00  // =
.t..........$...
<     00B0: 01 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00  // =
................
<     00C0: 40 00 00 00 00 00 00 00 FF 01 00 00 00 00 00 00  // =
@...............
<     00D0: 48 00 00 00 00 00 00 00 00 10 00 00 FF 00 00 00  // =
H...............
<     00E0: 00 10 00 00 48 00 00 00 00 00 00 00 00 02 00 00  // =
....H...........
<     00F0: FF 0D 00 00 00 02 00 00 30 00 00 00 00 00 00 00  // =
........0.......
<     0100: 00 11 00 00 FF EE 00 00 00 11 00 00 30 00 00 00  // =
............0...
<     0110: 00 00 00 00                                      // ....
---
>     0020: 01 00 00 00 02 00 00 00 30 00 00 00 00 00 00 00  // =
........0.......
>     0030: 04 44 00 04 00 00 00 00 00 00 00 00 00 00 00 00  // =
.D..............
>     0040: 00 00 05 09 00 00 00 00 01 00 00 00 00 00 00 00  // =
................
>     0050: 00 00 00 00 00 00 00 00 00 00 00 00 6A 00 00 00  // =
............j...
>     0060: 6B 00 00 00 6D 00 00 00 6C 00 00 00 00 00 00 00  // =
k...m...l.......
>     0070: 00 00 00 00 02 4C 00 03 01 00 00 00 02 00 00 00  // =
.....L..........
>     0080: 24 00 00 00 01 00 00 00 00 00 00 03 00 00 00 00  // =
$...............
>     0090: 00 00 00 00 40 00 00 00 00 00 00 00 FF 01 00 00  // =
....@...........
>     00A0: 00 00 00 00 30 00 00 00 00 00 00 00 00 10 00 00  // =
....0...........
>     00B0: FF 00 00 00 00 10 00 00 30 00 00 00 00 00 00 00  // =
........0.......


As you noted in the follow up email, the blob is probably expected to be =
re-generated in this case after the SMMUv3 patches (if you=E2=80=99re =
going to take it without a further revision)

Thank you,
-Mohamed=

