Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D98C982C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 15:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vglIP-0004ep-3u; Fri, 16 Jan 2026 09:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vglIL-0004bT-7D
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:59:25 -0500
Received: from ci-2002g-snip4-10.eps.apple.com ([57.103.88.200]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vglII-0007Nt-Kj
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:59:24 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 BBDC318001E4; Fri, 16 Jan 2026 14:59:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=tC6YTFAovhFLg23/Pz+1+VAx5b1Wl6hq1RxiNRKdork=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=HKmtF/76m7aQBx10eQx9rA1moY/Se3rvA6/zSt/U/wkaKnTdFVFNdn/QpVDLgqCGyZGHA6vBzIfLRvPhwL4PI9Q6RJFMbKEjeTpKMn7xFHMY5snQc4WGLpz1ExBtez5XyOuZ/eO094zSBm3qTXMW6eCC8rYjV+nXgzjv8YYv8x0eoJrQupU4op4J8FNNB88HJ4bnMBRJ9/zDYwAykqq9K9cpUVCIOzmTFQEl6ZDLjirjDrwaN8rkLmpgTNJTZ/pLXfmypUydX1uPy6aTmj6EtbEHNbN87LlDMVU+wSsa2g1QBOhNFU0zKXpAKJ/TtumKy6eAAF4RTBhfHFuaUeCT2A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 54D6F1801A90; Fri, 16 Jan 2026 14:59:10 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v16 15/26] whpx: add arm64 support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <23800170-66aa-4e31-9e74-e256933c8a8b@linaro.org>
Date: Fri, 16 Jan 2026 15:58:57 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D57D8689-9535-41D8-9818-79E544E46DB1@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-16-mohamed@unpredictable.fr>
 <23800170-66aa-4e31-9e74-e256933c8a8b@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: lpA-fp68N0FMgz95DAnz1zplqCi6nuZW
X-Authority-Info: v=2.4 cv=GdIaXAXL c=1 sm=1 tr=0 ts=696a5247
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=9N9iz4hUtBtpV_NYapMA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEwNyBTYWx0ZWRfX3izUvUkwxwCg
 fqLIBmUbM6Susu0moWqKbbAJJPqqV9Nfo/Xl4cpP4Jr6hyY128x+VRo2IqLBFh0+GY3Noj3qz1y
 vgqKHCKmcm6hev8Nyv8vMIllua7+Xcc9xXCPhUe6vBKSJB+2tAD+acRiMXhCkGpEcK43gn5Jxdq
 IOJDjO5VhbVxiJEfqY1fy7e3x7mnxiBpcsjSPmXjCGuy4ZmhFoKNMH4cbDS8byOZc0OZ6y2ZFpC
 EsLbG8SPwLOV2GKjv/kY57sDLWk6nQsxLH5MSaaaKQtG6mbSV8+0FbBbppcOfpQBJTjl/+Ic4sf
 1y/EaYZQ2IBKO1pyPpj
X-Proofpoint-ORIG-GUID: lpA-fp68N0FMgz95DAnz1zplqCi6nuZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 clxscore=1030 mlxlogscore=746 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160107
X-JNJ: AAAAAAABr9qRnLQ1jXJ8XHYL/ft/hyAipQY+ydk/vW4Yq6AWJChqEhHCzcSOGIwpA0LmeD0SAZ/cI+cIhExpAuYT93EYt6kz7CjN5GLsq43epSghzbKC0/GZ6vYZ6xnlUFRaS5ikWSfkiEGkvC3nfSC7ZXvuosbQbqIofVB3scsKbrB/cu0s/RwFDDpJAIsreIjPs7ukjWDG+hsnDs69FtopAKL0nUFgLA8HtlLn0ezMA9N67PUuzOPgX2InKRnKApbFWnIIFtwIosJoOaC8MjtGKIMtvOhjtrlW8TvkUPMJYXqhcAktJHN1Qm2Ebsm1R+gTFv4yx5T8mjNBI4YzJgHCi1UppyUyNsEQAaQR433UxMFmc/i45/K+HpYDqDZizCqVx1sx5HaXM7M/Fli3oTBhZzeohynzl5ETfNtH5RUvWMug3uqyU5yvzHzYEa1Yp9SPhcc2jc5S3GIs5m6+0a9DZ+0heXumsG9kMSXGc3TFzs56sHjeX98/MNuZUEvFN49LUTOvnCozNEwTCsSQvFUaPaojhJMG6Lq71MruscdNuRgX9b52+gO/v3w1nB+CPl6JbI8fVkmaHwxia4kUa/bXkESLRIZQcDT0w4B9xm2kX0sregleOhAAOhws2MkGM6MfhAgUGfoIS+sfoWwyQ2xrJHCv4hY3CkytIYnTHbsVSeENka0qVsGOdPMvlvF6MUSnP3MYIRiZ83qVqBLPCeNWIT5XiJjui1TzL2El8C0Iktoxo7G+xNK4Hfqj83UU8ixFhACRDoG25mnIBGe9dJbcrukhS0nIUHfvkDWEvw9YDN+ang==
Received-SPF: pass client-ip=57.103.88.200;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 16. Jan 2026, at 15:21, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 16/1/26 14:52, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  accel/whpx/whpx-common.c    |   1 +
>>  target/arm/meson.build      |   1 +
>>  target/arm/whpx/meson.build |   3 +
>>  target/arm/whpx/whpx-all.c  | 810 =
++++++++++++++++++++++++++++++++++++
>>  4 files changed, 815 insertions(+)
>>  create mode 100644 target/arm/whpx/meson.build
>>  create mode 100644 target/arm/whpx/whpx-all.c
>=20
>=20
>> +void whpx_apply_breakpoints(
>> +    struct whpx_breakpoint_collection *breakpoints,
>> +    CPUState *cpu,
>> +    bool resuming)
>> +{
>> +
>=20
>        g_assert_not_reached() ?
>=20
>> +}
>> +void whpx_translate_cpu_breakpoints(
>> +    struct whpx_breakpoints *breakpoints,
>> +    CPUState *cpu,
>> +    int cpu_breakpoint_count)
>> +{
>> +
>=20
>        g_assert_not_reached() ?
>=20
>> +}
>=20
Hello,

Called unconditionally today from the common code. But does nothing as =
breakpoints aren=E2=80=99t supported on the platform.

If trying to actually enable a breakpoint, common code will go through =
whpx_set_exception_exit_bitmap and error there.



