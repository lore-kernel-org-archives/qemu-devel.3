Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4CAEB5967
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3Cr-0000fg-Nu; Wed, 11 Feb 2026 00:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3Cp-0000eX-RF
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:56:07 -0500
Received: from p-west3-cluster3-host5-snip4-10.eps.apple.com ([57.103.72.141]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3Co-0003LD-9t
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:56:07 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPS id
 711361800097; Wed, 11 Feb 2026 05:56:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770789365; x=1773381365;
 bh=56sXoYOxPX/sVf+px2q6TZUX1B0IWIQipNS6jK0DejM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=bBTDApaeTl1DB0a/R8dZFUv9g7jsnDNVtsBBL/ceYimhIZoOKRbqhB+GsW1qNeFiF008Ak+IJP7X3jsjyjXYLEsIMS3MOgYkYMLGqdevflexG5TCrG0C6oUIbTTQ4tnw7xF1Ewb8tNflD0bQzs7WswZV8z/xn8WWDvYLqsXoTWQZtVerimL0QdTSxj1QGxuO+aSrpdvMM9Y+iN0JRZM9cWZJlaoCk3qLpQbfcPmL59NHp2JDVfAu6imgmJaQB1ZjaAve/PZ0G5FToXMUWzF5YXw6yBAz0Q1qzjZClBqXUatYSBCygQHLK5yadPzYjVFtotUlefuLgqJ58hT0ARuM/g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPSA id
 4F058180009A; Wed, 11 Feb 2026 05:55:59 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 0/7] whpx: x86 updates (2026-02)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260211055356.44664-1-mohamed@unpredictable.fr>
Date: Wed, 11 Feb 2026 06:55:47 +0100
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <59BE8AAB-AAF6-41C7-9784-E3103A2FBB97@unpredictable.fr>
References: <20260211055356.44664-1-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: wrxHirdb08Y5kVTKkWv58C7XunnsUUqi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NiBTYWx0ZWRfX2F+AqThWVfzz
 bTIylpgbNFfHgH33n8UpYmHJs/GGaQ3sLYWDiiwDEs10iqRg1NZQ1TenS9LzGFTzAJ/UCXXGvmz
 2gSiXvaOgb1zOvVplsVIN8VRLBOcn7ETZlAeJ7EJkzvWe9AEL97jtMH+b9Kpf7MnHWTT8CDANUU
 9EzysCiPUNDwnNuq7hh1WgXH6lR785zWSPETai9R5+jh6Nt7ePei2gzSGAmeE0LWbyKjXDFzHTC
 wX1RJ7n+MVnOyfbNMILOKLOo950eFMSf4WegS2VCNOuUlXyteXEuHMZ39Kzfk+YW4wwBnOe4pPw
 qz7NVNY5Zox75R8SBhGOdcO1RoEbp1KCbLGhpAoF3v8Zb1+SUCKOz5YP9l/Eck=
X-Authority-Info-Out: v=2.4 cv=Q7ffIo2a c=1 sm=1 tr=0 ts=698c19f3
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=haW0fTxJ24_bn6PRMP0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wrxHirdb08Y5kVTKkWv58C7XunnsUUqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=834
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 clxscore=1030
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110046
X-JNJ: AAAAAAAB28uoKib700k3C2zToUrsphoCDpuF7aE52+PWvVfZA+XPgs55jEKUlc435bSdCO8TFgivrG0Aw2iu0/oYSn+K57fETZ9kbCO3En3/N2SLoyMKPx2K5KdaS/FdgyO6vMBdTr4V3jRHanhSn+oMEmA8wCW4aW7gJ2MYlzcq1J0RgjLWOC4RrWpUBCnUBq5x11tjm5sIacHZIgYrdHbH6pJtt+WZkQLMvejFSQE/Xe7ePxAhWxZBxnmUQC0oxDs8oetWWKMFjXMOi9xxW+IYIIfhpw7NZUsbfz2LsfZg6O9qTGyeahuQPiXTOCrG7kwanflda7N9rZ5sOKbUiCKCSoCVOS4alPHm5RI5TSRS5azrO+Ef1+9gZms821yy/c8iaaol3eXqaXr4vbgWIjqlgU+HbtA4uyOScZ4f4gTcD4fstfVT83yMxyBokJ3EYMAcwy0sDUO1bUIAkYUGm4KvRUoLvpJcwM9MibltC0C43x/spTnqwQVJoruLEMNUKW1kRNQbkGpeASjeUHA0bqs9XAgBFuo8dtbeZW7xgUODXT7zNO1wLNYj8D4Q+FUpgUlS/goVrUDV/iC4QV9fG0GPYsu6oUrAB43jTWHDUZcG2Ot2ELWtgkCDHU8o9+0wJuaGZi4+IZ9vB0b27xsuhjczwgN8wuMGx2H440NuxLOjcP0bYe0tzhM6N4YRfwtuHOKJnddWswmP2QRsxUpOJR2ge2oQwZv1i4a+Kwe3MR0cma9TREJUQJqa4Z5aopWFVSgw+ICGuiUZJA8fIc5M7RPrVLbPv32RDnhy3ik=
Received-SPF: pass client-ip=57.103.72.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Oops, forgot to note:

This is to apply on top of target-arm.next (which includes the arm64 =
WHPX support).
It won=E2=80=99t apply on top of current master.

> On 11. Feb 2026, at 06:53, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> x86_64 WHPX updates:
>=20
> - fixing debug support, which was broken since around: "gdbstub: move =
guest debug support check to ops"
> a48e7d9e52f8fe8b47f4c74f3e99d9d677b87fe5
> - switch over from winhvemulation to common x86 VM exit emulation code
> - remove some log lines
>=20
> Mohamed Mediouni (7):
>  whpx: re-enable guest debug support on x86
>  whpx: preparatory changes before switching over from winhvemulation
>  whpx: refactor whpx_destroy_vcpu to arch-specific function
>  whpx: move whpx_get_reg/whpx_set_reg to generic code
>  whpx: x86: switch over from winhvemulation to target/i386/emulate
>  whpx: remove remaining winhvemulation support code
>  whpx: x86: remove messages
>=20
> accel/whpx/whpx-accel-ops.c     |   8 +
> accel/whpx/whpx-common.c        |  62 ++++---
> include/system/whpx-all.h       |   5 +
> include/system/whpx-common.h    |   6 +-
> include/system/whpx-internal.h  |  16 --
> meson.build                     |   3 +-
> target/arm/whpx/whpx-all.c      |  33 +---
> target/i386/cpu.h               |   2 +-
> target/i386/emulate/meson.build |   1 +
> target/i386/mshv/meson.build    |   4 +
> target/i386/whpx/whpx-all.c     | 308 ++++++++++++++++++++------------
> 11 files changed, 252 insertions(+), 196 deletions(-)
>=20
> --=20
> 2.50.1 (Apple Git-155)
>=20


