Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120B2C2A062
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 16:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcQmI-0000Af-Ua; Sun, 04 Jan 2026 11:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vcQm9-00006k-Lk
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 11:16:18 -0500
Received: from p-east3-cluster3-host3-snip4-10.eps.apple.com ([57.103.86.33]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vcQlr-0004gr-0r
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 11:16:06 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 DFF781800613; Sun,  4 Jan 2026 16:15:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=KfaSwAMEtx+X4HNczRDD6txv7uJquY0ig8685onqh2I=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=B58mRuvikaocM4cmAddd503zJXon9wbuTJrXGoat8ZokxelERzOw3g+nGcdXZIPrSVPwZscqpcyh7ujjFzPvO/Zcdc43HzlvqW5NLluck5QAEys40VajZCaMLgDPwdl5k7bVY0l57DSobn4LQTwoxWo21gGoxNN0SXiQWe9msDj5+RaXRR619OmAGKhtRlwkgK391QWt5KLZBAV1/KrvFglgpU0+1iGqgYQozIKm2i6MxTcrraiksB696ORHkagofJzZgiMUtokw5dCGQCyrCZrgbeQNXayGX/Vo35uciFKHS9MWXdb9J5rha4VDKZmBIMiZwaFCwQkultMfiZ1AzA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 0144F1800119; Sun,  4 Jan 2026 16:15:44 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH RFC 1/7] egl-helpers: store handle to native device
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <207deefa-9f9e-498a-8568-96fe7424706f@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 4 Jan 2026 17:15:33 +0100
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <33981354-90A0-41FE-9B40-0AB96A342358@unpredictable.fr>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-2-j@getutm.app>
 <3a401334-700f-4b11-b006-a93470d38a66@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSBOEzzb-aO2B_yWtJeoK4QGvjf=pB555+GGE2U0OH=vbw@mail.gmail.com>
 <f246dcbd-2a13-46e8-97cb-d6959d8115dc@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSCJ8y8RnGe99kFVSLbex_jE71z74+pF4aom-LMbjXgzPQ@mail.gmail.com>
 <a4e9815c-8641-4250-9bf4-ec13fa49e1ee@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSAKYCui8huYrZ=0Vw5pKQHXoGJjRPYb1Pr6ozSezXyUgA@mail.gmail.com>
 <bfa37bf0-78bf-47be-9c67-af2a7911fc30@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSBDppoSFaYDJWw82aHcm1U2iYtzOckD=jagBV11+7-wtg@mail.gmail.com>
 <207deefa-9f9e-498a-8568-96fe7424706f@rsg.ci.i.u-tokyo.ac.jp>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: ZMX1ThiEq0c0q1LjUbWcL3MYwFSx7liu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX/GOsCbWbqm4L
 qvvPvTIBnRvE2KC6Wd2HetOdWyyP1eT2LT0Jp4dCSWukKEkhKvxt+ATwaA5E5bsPs544Xx9Bo5L
 gP59VXTEIQz6UD2deRvLzCPRcHI5O5NVoCsxL3wAk+nzl0F3HPvGajYsSlfIpHTpImHqw1qQoOo
 exSGSEoJzp5Yb+uE8mKON81MDpNTnTadT4DlbkbjAYQQovHWtrF/TxIkxXMI8Ut4/gypbEXwU5b
 BTk8vEnOQguP5CyHVbS6mFyVOH2V8WbgqnDtDQLQdG+o0pkj1i7xnz8z0QVcv6BHdPsB6R1We7C
 fzQmPHflnTNoPL8aes9
X-Authority-Info: v=2.4 cv=PoqergM3 c=1 sm=1 tr=0 ts=695a9233 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ZeBP_3k6spsOvqXfUQIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZMX1ThiEq0c0q1LjUbWcL3MYwFSx7liu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1030 mlxlogscore=999
 malwarescore=0 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601040151
X-JNJ: AAAAAAABOw3/u4nVPP2vXdZKPAmI9UbsdsbfcQE+ymzKacJn7t6a6EcYmlCmqj2ZcdS1LUcKMPaLnPJl64RsCebvy0LZRpCjalmLrQR3GKpleqokpjKucm94BrDKxXYmPsDNCypqBqqyVxQcOx6M3VTAyd+AWJt5c5ADrzG1+1SYYq2VqMJ6NHEc5LRM7Z3MBskgrGBdXlMhPVtI4ssi83A0uA/rswkbFcMesU25L3D/n5Wl+Fw4BIx5yPjtnVoR/ea9gd9LKahofRCMUMibYc9Y0xDKFEGY0jEjJUhDlVWWtBQK/5BqpShOUL5XebwgTuR0M2zU0K63LHgRjQgYxmEJWm0fayemSP1JCoXgCoqaSBDZ4l/6KKATfzR8KYiDwyQ6Y8ME/uANlVjxRs1+pbrHdpY0A1sDpDoK1jD56BygVhJBY0lceunE7U6e5SpTTTaHfh/0hV7JcxDwEeTzCkYZ627C6WtJ8zIt5yHVMJ/gQ/moCf6etTd243yeRR/p1IcdHgihtigEYDBgIevh8oYCGASl9OLhUbMzQOIzR0v7lhMoq6yerMiS2G/T+e6eZoXKT9Gt79UiuAdSWNeccs7B6Z+zI9gDEU45EdOZBSBmbVD366Uf4oashYX5n+uPNgnYssq+k3WoXVeMzSfnEq/OkZ7e8Hs2/SWSiY1bGG6ipR+RV6dg4WnwEn/J
Received-SPF: pass client-ip=57.103.86.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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



> On 4. Jan 2026, at 12:01, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> =
wrote:
>=20
> On 2026/01/04 13:27, Joelle van Dyne wrote:
>> On Sat, Jan 3, 2026 at 7:35=E2=80=AFPM Akihiko Odaki
>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>=20
>>> On 2026/01/04 7:24, Joelle van Dyne wrote:
>>>> On Wed, Dec 24, 2025 at 12:22=E2=80=AFAM Akihiko Odaki
>>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>>>=20
>>>>> On 2025/12/24 16:54, Joelle van Dyne wrote:
>>>>>> On Tue, Dec 23, 2025 at 10:23=E2=80=AFPM Akihiko Odaki
>>>>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>>>>>=20
>>>>>>> On 2025/12/20 1:11, Joelle van Dyne wrote:
>>>>>>>> On Wed, Dec 3, 2025 at 10:31=E2=80=AFPM Akihiko Odaki
>>>>>>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>>>>>>>=20
>>>>>>>>> On 2025/12/03 13:07, Joelle van Dyne wrote:
>>>>>>>>>> Make way for other platforms by making the variable more =
general. Also we
>>>>>>>>>> will be using the device in the future so let's save the =
pointer in the
>>>>>>>>>> global instead of just a boolean flag.
>>>>>>>>>>=20
>>>>>>>>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>>>>>>>>> ---
>>>>>>>>>>     include/ui/egl-helpers.h      | 2 +-
>>>>>>>>>>     hw/display/virtio-gpu-virgl.c | 2 +-
>>>>>>>>>>     ui/egl-helpers.c              | 4 ++--
>>>>>>>>>>     3 files changed, 4 insertions(+), 4 deletions(-)
>>>>>>>>>>=20
>>>>>>>>>> diff --git a/include/ui/egl-helpers.h =
b/include/ui/egl-helpers.h
>>>>>>>>>> index acf993fcf5..c239d32317 100644
>>>>>>>>>> --- a/include/ui/egl-helpers.h
>>>>>>>>>> +++ b/include/ui/egl-helpers.h
>>>>>>>>>> @@ -12,7 +12,7 @@
>>>>>>>>>>     extern EGLDisplay *qemu_egl_display;
>>>>>>>>>>     extern EGLConfig qemu_egl_config;
>>>>>>>>>>     extern DisplayGLMode qemu_egl_mode;
>>>>>>>>>> -extern bool qemu_egl_angle_d3d;
>>>>>>>>>> +extern void *qemu_egl_angle_native_device;
>>>>>>>>>=20
>>>>>>>>> I guess ANGLE will not be relevant for Metal and leaving it =
will be
>>>>>>>>> misleading.
>>>>>>>> What is your suggestion? This is just to remove "D3D" from the
>>>>>>>> variable name. If you want to remove "ANGLE" from the variable =
name as
>>>>>>>> well, it may be misleading because this variable is only used =
with an
>>>>>>>> ANGLE EGL backend.
>>>>>>> Looking the usage of the variable in your tree, I realized this =
variable
>>>>>>> may not be necessary for this at all.
>>>>>>>=20
>>>>>>> There are two use cases:
>>>>>>>=20
>>>>>>> 1. To determine if VIRGL_RENDERER_NATIVE_SHARE_TEXTURE needs to =
be set.
>>>>>>> 2. To pass the device used by ANGLE to Cocoa.
>>>>>>>=20
>>>>>>> Regarding 1, virglrenderer can simply pass MTLTexture whenever =
the EGL
>>>>>>> context is backed with Metal and Venus is in use.
>>>>>>>=20
>>>>>>> Although your code is modeled after the code dealing with =
Direct3D
>>>>>>> handles, the functionality of your code is quite a different =
from it.
>>>>>>>=20
>>>>>>> Direct3D handles are used to "share" texture with other =
processes in a
>>>>>>> zero-copy manner. It is an optional hint; dbus can fall back to =
use
>>>>>>> OpenGL textures if they are missing, and the other displays just =
don't care.
>>>>>>>=20
>>>>>>> On the other hand, MTLTexture plays an essential role in your =
scenario.
>>>>>>> There are no corresponding OpenGL texture so no fallback =
happens.
>>>>>> That's a good point, but there's two uses of MTLTexture: one as a
>>>>>> direct parallel to D3D handles (vrend allocate a texture backed =
by
>>>>>> MTLTexture; returns it in info_ext along with a tex_id) and one
>>>>>> returned as part of the new API
>>>>>> (virgl_renderer_create_handle_for_scanout) which does not have an
>>>>>> associated tex_id.
>>>>>=20
>>>>> Thanks for clarification. I think the point I mentioned below =
still
>>>>> holds; virglrenderer does not have any code that can be skipped =
for
>>>>> MTLTexture with the absence of =
VIRGL_RENDERER_NATIVE_SHARE_TEXTURE.
>>>> We support the same "hint" use case in vrend for MTLTexture. So,
>>>> without that flag set, there will be no attempt to allocate a
>>>> MTLTexture. This works regardless if Venus is used or not. However, =
in
>>>> the Venus use case, the hint does not matter at all because as long =
as
>>>> the new API virgl_renderer_create_handle_for_scanout is used, a
>>>> MTLTexture is returned. In this sense, I think it makes sense to
>>>> rename *D3D* to *NATIVE*.
>>>=20
>>> MTLTexture is always allocated; If virglrenderer doesn't, ANGLE does
>>> that internally. There should be no practical difference whether
>>> MTLTexture is exposed to QEMU or not.
>> The difference is that if virglrenderer creates it and exposes it to
>> QEMU, then the UI can use a faster blit path. When the flag is set,
>> virglrenderer creates the MTLTexture, passes it to ANGLE, and holds a
>> reference for QEMU to retrieve. When the flag is not set, there is no
>> way of getting the MTLTexture from ANGLE.
>=20
> I suspect it is a premature optimization. There is only one blit per =
frame and it is a simple blit, so I don't think it can create a =
perceivable performance uplift.
>=20
> Besides, if the optimization turns out useful, you can still =
unconditionally let virglrenderer create the MTLTexture, so the flag is =
unnecessary.
>=20
> Regards,
> Akihiko Odaki
>=20

Hello,

It might be worthwhile having a way to do partial damage from the get-go =
- which entails not doing full blits each frame. It has its importance =
for battery life.

Although there are more aspects around that still look in flux within =
virglrenderer=E2=80=A6 and ANGLE (at least on Vulkan) has a stub =
implementation of EGL_KHR_partial_update that doesn=E2=80=99t actually =
implement partial damage...


