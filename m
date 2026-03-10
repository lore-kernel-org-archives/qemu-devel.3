Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89964FCC9D1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 07:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzrE2-0002WL-8U; Tue, 10 Mar 2026 03:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzrDv-0002VN-Dj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:09:49 -0400
Received: from p-west2-cluster4-host5-snip4-9.eps.apple.com ([57.103.69.160]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzrDt-0001dd-3Z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:09:47 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-9 (Postfix) with ESMTPS id
 B125318004D6; Tue, 10 Mar 2026 07:09:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773126582; x=1775718582;
 bh=PxpihWYuYWUG+3Pet0UDDCSmrHPXl6ORAjh0ZN8CAM4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Qs5pfEzF4dDFAFJkuIu1eO4s41NL4evfR6so6ppWd2Zc/gFyg6OwqmZ+boqcJ+uBMcMxoLtYai6x7sgXE32rrBWfPiZAtYXlffCPVLjBwpr53NqqAcM0rS/Uzrh+5I6axuQiL1FXbpou3si2rUdps58+9ZaM+N00B+b86s45ChcAp8fnqpbtLPFTnUu9HUBTBPU4TwlZVSaNL87IKMIIh3KQxcGUqB2QgxScVWH+DKD9Yn/5qolnXAZaNqNMGR1EMx6CMXjZ6EQ8yGdXA2nw/S5Ga1lMfeMtTk1zmKfI4rTKZ4M/JQ7B+QRzA+YU2EgL/cThL+2h8YcBTc8ZDpN6sg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-9 (Postfix) with ESMTPSA id
 2ED701801ECA; Tue, 10 Mar 2026 07:09:38 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v5 1/2] vmapple: apple-gfx: make it work on the latest
 macOS release
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <f94bebf5-a452-46cf-ad46-acb71c619917@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 10 Mar 2026 08:09:26 +0100
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <63A01CD9-19E1-4D45-9575-FFDE975A194E@unpredictable.fr>
References: <20260306145246.10274-1-mohamed@unpredictable.fr>
 <20260306145246.10274-2-mohamed@unpredictable.fr>
 <8908689a-f5c1-490e-925d-7a664093963f@rsg.ci.i.u-tokyo.ac.jp>
 <a24c76d0-4106-4d49-b032-35f7f6310e69@linaro.org>
 <f94bebf5-a452-46cf-ad46-acb71c619917@rsg.ci.i.u-tokyo.ac.jp>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: LiuW_No9VjWzk0UBP9JfYcPp5ieotOYc
X-Proofpoint-ORIG-GUID: LiuW_No9VjWzk0UBP9JfYcPp5ieotOYc
X-Authority-Info-Out: v=2.4 cv=Af683nXG c=1 sm=1 tr=0 ts=69afc3b5
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=XaNHVGzJZ3ayr3Wv:21 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=9BwXnSop6uAxbtba5hgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA1OSBTYWx0ZWRfXxQS23W732G4t
 KcDL9HLY8z81e7u6zfypnYDyx8G07KzwWu0mb6e6GgTWD9byeYGy4uxEfTsXoyWDZXQxxsqEaBY
 14lhoAVIBR4t891ZfRtgzxfWXuUXE63bh1H9dH+GtzxRJgFtjcREAtOxs0PEFPq9vtfayURDP3W
 L9NRZbo/fidaTD6jjZRsatvIv+i9cUkRFuzKFy5SfMFpLpafGvFQJyNoIvcNXUJzpC9G4F+2GC/
 9BAN6tEkVqQT1RUTF4uu7hBgjTp9RukKyi092kt1wxpIn969Qik5ENNx2Tf5sKlZIcxkkawsuh7
 pdemLZXCoBSf1iBAH/AwzEUTa2aSQU7baFk3mVUwiQbwsj0L7Zb8j5Wl4u+YH4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1030
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603100059
X-JNJ: AAAAAAAB/DVDuDc1eGPv+6/78yx8ZlpGUigzUByv3GV5FNYhwC4vAQZgtjU7sQbzprgem8CYLdiH4nR2RsfF7mboZTL6jqcveQehq0ihH7eQwzg5ZylFig3bdFeA7cgsWXHE/k4RD2kqeOw13gw5wOBxyemGkngVlaVTEdUWytxY2yERwyoUuhaowJ6eZKZmXPNngxu+ueCgwknscPSlSWZ+23UnN/LF0UvxZ93sCqHcjfd+6GjBnCuo7f8kqC5SCUQge6B48rt70DJfy6azMH1gVr3/vECwb/PF7XZ+/oyDRCTSLuFPln0Xi2AUT3Ixwt5UgXCwp8Uua28V0q3uRAxhpLtCyu2Mf2aW0VXpbwXwLpV7r7X5i9kd2SaOPb16PtMx8So8ffmC1jxInBVVYm6ireFJMro7F+fk+Rgl7MsmalU0M0gyHK6ZMvowsQ76AOmqHT2sDzz42efyCtfFVqCmu2bQEXUiuDsi6DTNeQ67zm/bE35pI5shixM/DP1jJCFdSM4BRDfQwiGlAqNpQ3ljL5UwMaG3fPPpqXFDyQE1Xr44b6JkpH3bafPINq6u5assq14FUNqW3Q4wCnk2GJiAj6iOc0rt0mTbt+QjlSm3psOiloEQJXSx5iwuMRfzG7SjfN3w7HQOEUhOH010aKYi8rCDzS90tZ1DX/6HPONA+GM00Ne0TxTcMzydTrwrcedWP6uNOLpVRJmI3BADgKCYjCofP+SkW3rGJQlEmvD9W385b8q2W6w/7hYRBWh9wU+5EGgFphTWdwBvoRsB4bn7Sf3y1zw=
Received-SPF: pass client-ip=57.103.69.160;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 10. Mar 2026, at 07:55, Akihiko Odaki =
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>=20
> On 2026/03/10 7:21, Philippe Mathieu-Daud=C3=A9 wrote:
>> +Peter/Paolo
>> On 7/3/26 04:08, Akihiko Odaki wrote:
>>> On 2026/03/06 23:52, Mohamed Mediouni wrote:
>>>> Follow changes in memory management introduced on macOS 15.4.
>>>>=20
>>>> The legacy memory management API has been removed for the IOSurface =
mapper on that macOS version.
>>>>=20
>>>> Also enable process isolation for a sandboxed GPU process when on a =
new OS.
>>>>=20
>>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>>> ---
>>>>  hw/display/apple-gfx-mmio.m | 62 =
++++++++++++++++++++++++++++---------
>>>>  hw/display/apple-gfx.h      | 18 +++++++++++
>>>>  hw/display/apple-gfx.m      | 43 ++++++++++++++++++++++++-
>>>>  3 files changed, 107 insertions(+), 16 deletions(-)
>>>> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
>>>> index e0a765fcb1..92404d20bf 100644
>>>> --- a/hw/display/apple-gfx.m
>>>> +++ b/hw/display/apple-gfx.m
>>>> @@ -21,6 +21,7 @@
>>>>  #include "system/address-spaces.h"
>>>>  #include "system/dma.h"
>>>>  #include "migration/blocker.h"
>>>> +#include "system/memory.h"
>>>>  #include "ui/console.h"
>>>>  #include "apple-gfx.h"
>>>>  #include "trace.h"
>>>> @@ -596,6 +597,37 @@ void apple_gfx_common_init(Object *obj, =
AppleGFXState *s, const char* obj_name)
>>>>      /* TODO: PVG framework supports serialising device state: =
integrate it! */
>>>>  }
>>>> +@interface PGDeviceDescriptor (IOSurfaceMapper)
>>>> +@property (readwrite, nonatomic, copy, nullable) =
PGMemoryMapDescriptor* memoryMapDescriptor;
>>>> +@end
>>>> +
>>>> +bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
>>>> +                                  const MemoryRegion *mr_const,
>>>> +                                  hwaddr offset_in_region, void =
*opaque) {
>>>> +    MemoryRegion *mr =3D (MemoryRegion *)mr_const;
>>>=20
>>> flatview_for_each_range() should be changed to pass non-const =
pointers instead.
>> flatview_for_each_range() was added in commit fb5ef4eeecd ("memory: =
Add
>> FlatView foreach function") with memory fuzzing in mind, so const MR =
was
>> the correct choice then IMO.
>> FlatView is more of an internal memory API, I'm not sure it should be
>> used by hw/ layer.
>> $ git grep -w flatview_for_each_range
>> hw/core/loader.c:1656:    flatview_for_each_range(fv, find_rom_cb, =
&cbdata);
>> semihosting/arm-compat-semi.c:158:    flatview_for_each_range(fv, =
find_ram_cb, &info);
>> tests/qtest/fuzz/generic_fuzz.c:310: flatview_for_each_range(view, =
get_io_address_cb , &cb_info);
>> Semihosting is special, as it the ROM loader helper, and fuzzing =
code.
>> We provide MemoryRegionSection, MemoryListener and RamDiscardListener
>> APIs. Maybe one of them is more appropriate here? See:
>> * A #RamDiscardManager coordinates which parts of specific RAM
>> * #MemoryRegion regions are currently populated to be used/accessed
>> * by the VM, notifying after parts were discarded (freeing up memory)
>> * and before parts will be populated (consuming memory), to be used/
>> * accessed by the VM.
>> Could this be what this code needs to do?
>=20
> The problem here is that the reverse-engineered interface is =
insufficient to keep the memory map synchronized so it can only populate =
the memory map during initialization. flatview_for_each_range() fits for =
this purpose.
>=20
> Ideally the interface may be reverse-engineered more thoroughly to =
synchronize the memory map at runtime but that needs more work.
>=20
Hello,

Unfortunately there=E2=80=99s no such interface anymore/no notifiers =
from what I gathered. The new interface has a resetWithMemoryMap
call but that resets the state and use again has to go through the VM =
save/restore path=E2=80=A6

Well, the legacy path is still there for outside of the =
PGIOSurfaceHostDevice path but that=E2=80=99s just because it=E2=80=99s =
public
API on x86, and is going away really soon + it blocks sandboxing=E2=80=A6=20=


I guess it=E2=80=99s good enough for the macOS use case - and any =
potential ballooning handleable via purgeable memory...

>>> Regards,
>>> Akihiko Odaki
>>>=20
>>>> +    PGGuestPhysicalRange_t range;
>>>> +    PGMemoryMapDescriptor *memory_map_descriptor =3D opaque;
>>>> +    if (memory_access_is_direct(mr, true, MEMTXATTRS_UNSPECIFIED)) =
{
>>>> +        range.physicalAddress =3D start;
>>>> +        range.physicalLength =3D len;
>>>> +        range.hostAddress =3D memory_region_get_ram_ptr(mr);
>>>> +        [memory_map_descriptor addRange:range];
>>>> +        memory_region_ref(mr);
>>>> +    }
>>>> +    return false;
>>>> +}
>>>> +
>>>> +static void apple_gfx_register_memory(AppleGFXState *s,
>>>> + PGDeviceDescriptor *desc)
>>>> +{
>>>> +    PGMemoryMapDescriptor* memoryMapDescriptor =3D =
[PGMemoryMapDescriptor new];
>>>> +
>>>> +    FlatView* fv =3D =
address_space_to_flatview(&address_space_memory);
>>>> +    flatview_for_each_range(fv, apple_gfx_register_memory_cb, =
memoryMapDescriptor);
>>>> +
>>>> +    desc.memoryMapDescriptor =3D memoryMapDescriptor;
>>>> +}
>=20


