Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0EDC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 10:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viVJa-0005j4-1v; Wed, 21 Jan 2026 05:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viVJS-0005iP-El
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 05:19:46 -0500
Received: from ci-2005e-snip4-11.eps.apple.com ([57.103.89.181]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viVJP-00040w-Rl
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 05:19:45 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 0D5221800226; Wed, 21 Jan 2026 10:19:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1768990779; x=1771582779;
 bh=n/2hISps0nO6IYaHjtQmwBh7VVIpR/iItNzogwjO0+A=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=CK4rQFwHVCuM/WDlsJEkRo/BRtYyZBlD6X6vFSYWL+p8cz4SkNSArDxQc/tbBZelN/tv6RfVSTNKmHeeNNE9zldSQRFP8TCkfLcRAEiPOLPKe1QNEKOS4QgeD021Nrg+Vu4bV+rlOwe5b0HtOHUyu2cmeN9y22GVJpAtodaUV1AIuOlrx4Vx949rEL4btzK9J+ZwUYOsHfZQyfivevNpRQMpTAieQktaku1Ue8HdI8UsF7NKcJWwtzGi7HeaDlYUSr2XgiuUccsTvUFVcKq+HhWuetb6j1OO/wbLgw1luBnphWhSyPU6oW+pUvyX39RaWKT8KjENL5O6L0Lc3wn5Bg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 EB4E2180008D; Wed, 21 Jan 2026 10:19:30 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v16 04/26] hw/arm: virt: add GICv2m for the case when ITS
 is not available
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA9JC1HRboZ=722dsT7a4nDQNF_ECjLK+z84T5MJisfppg@mail.gmail.com>
Date: Wed, 21 Jan 2026 11:19:19 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2FD2C3C6-8FBA-4833-B890-5E81637BE7EE@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-5-mohamed@unpredictable.fr>
 <CAFEAcA-3P6i_w3b7SaFTn4Zmwnot5vpDs89y+zpjcJ=-mEnP5w@mail.gmail.com>
 <8158CEFE-8EA2-40A4-970E-01B30BACC019@unpredictable.fr>
 <CAFEAcA9JC1HRboZ=722dsT7a4nDQNF_ECjLK+z84T5MJisfppg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4NiBTYWx0ZWRfX9zVbE3WGCXag
 CcahGr0MKMSldxlW2qM4e4MKtb+EQG3ROq+Dj8hiLcRB2bhn9H+y+Axfm2sHB84bMHAWWhVYWPx
 euRQT2+qafFXp1tOSN/cyFY62hxC+paddvm+QaYOBlDM6s4cZHbDhBwCCK/OkJCYQEroPUJNIDd
 u+GwR8GqDz8T7UyDdVo8ygHCJZB2dkn01d7obhiS5ivlzmiI84LQDNHy4oOcofx2xJqTxbVGiGz
 58S3dZymt0uDcaXYiBtCXFCd+c4hjxiYenpTo7HWqqAXfxvNsL8RWvpnH774JDVbdzt2Kyg3M/x
 kD/yiTgwsf1t9M43iIT
X-Proofpoint-ORIG-GUID: 5kBUN3drdqW2TYbYcO4RyJf3NFeCElOZ
X-Authority-Info-Out: v=2.4 cv=NtTcssdJ c=1 sm=1 tr=0 ts=6970a838
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=8tVNtdTugjW4QW2w:21 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=ILVyFMIZgqNhlbEAeMkA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5kBUN3drdqW2TYbYcO4RyJf3NFeCElOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 clxscore=1030 spamscore=0 bulkscore=0
 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210086
X-JNJ: AAAAAAABRPRlKuYMXrJfns+5kOsC+YnY+S4CnNaHQgt1UQSHA5w0pobXrruHKVKNlL3z7d3deXBHFRNeiRUrXG6Q1mN6l8JZIQU1C2mNseAo4L3E3/A2ydzQ5VGEyRSDZV0fVk08XYCqBDaX8he6+VQFAeKnseDbidpRqAZbgBUh3GygCD2ZH8OwBXKEfFKpt5Ikzn7Rtt0tL8rh5Rni4BsbLh1XwAxAQs146mZOMDt2Ayv+8TeWAehvWCDOsPoohoNEroYHg6MHDuGBsIi9ypQ9MRCSrX/uhDEnPMkS70bWv5wX41acP6aLzGLVYZtGW4/MotvgPjoyhMyy9f5S/QCiCcwPH8eSMhI0JEWDuxjfZv/5P+9zCnIPnHVIwOe6lKF3DhHOq5Pycd4+8F6LGAhDxG4zx83xVLUJUK/Ox8mPRVqOpGKOEJxe/P0GsOnZPaOmQ0TMnzubqBG1HnyK49yAIxB8aa28BRkdGjT2xgS4KPS+cUA2NJytGvX5YcmwlDx039JBtVRa5Ew2I5i5aUwWwprP7dIwCKuQngCPEmILFkjbip3lyo5uuKozXxa65OiMsUqzEt+vsNPkE7ZwwfdUGGrru0FXuiu0y3QL4/O2LvO2zuKwMhxm/f7Bffvj2wKgzkZQUNwbsWrYYIFFr3Ugyi4RHK74Vg2aaxsPqhwhgsSaF14sf78c2uzYc2j552tL7nveZ0BUwW2QpGCNqBSh2oHfTC14PK9TMuSK6xS8rpZEtVNamYM1xTgPALfurJoNh86mw8uvIxMUwKUfQPB4R9+L6d49RqMsB6sHkqY/dtxFvOoEkdDzjXWZ
Received-SPF: pass client-ip=57.103.89.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



> On 21. Jan 2026, at 10:27, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Tue, 20 Jan 2026 at 18:44, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>>=20
>>=20
>>> On 20. Jan 2026, at 19:02, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>=20
>>=20
>>> The MSI controller selection logic is already pretty confusing,
>>> and this is making it more complicated. I don't think we should
>>> need this machine back compatibility, because currently there
>>> is no setup where you can have a GICv3 that doesn't also have
>>> either an ITS or no MSI controller.
>>>=20
>> Hello,
>>=20
>> This was to replicate the =E2=80=9Cno_tcg_its=E2=80=9D where this was =
done when introducing TCG.
>> And for the purpose of VM save/restore on HVF with the older machine =
type continuing to work as expected.
>=20
> no_tcg_its is there for backwards compatibility: on older
> QEMU versions before we added the TCG ITS, if you said
> "-machine virt,gic-version=3D3 -accel tcg" you didn't get an
> ITS; we wanted to change the default in new machine versions,
> so we needed the back compat switch.
>=20
> What is the command line that works today and where we
> want to go from "default to GICv3 without ITS or v2m"
> to "default to GICv3 with v2m" ? I might have missed it
> but back last year when I was looking at the current
> configs I didn't think we had one.
Hello,

None, was thinking about what its=3Doff should mean but perhaps=20
the right behaviour to do there is to have it mean no MSI-X controller.

The no_gicv3_with_gicv2m flag is solely used for the its=20
config option (which is legacy) and not used for the msi
config option.

Will make the next patch rev make its=3Doff mean no MSI-X controller at =
all
and remove the no_gicv3_with_gicv2m flag then.

> thanks
> -- PMM



