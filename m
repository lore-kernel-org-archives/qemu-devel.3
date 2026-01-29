Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4D5D73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 22:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlaRs-00011y-MI; Thu, 29 Jan 2026 17:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlaRq-00010Z-HG
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 17:25:10 -0500
Received: from qs-2001l-snip4-11.eps.apple.com ([57.103.87.123]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlaRo-0002ov-7b
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 17:25:10 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-13 (Postfix) with ESMTPS id
 D021618000D6; Thu, 29 Jan 2026 22:25:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769725506; x=1772317506;
 bh=0mVO3lXqrwMt2slutf97evdyvwbv0gA7alMo88CFVgA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=dS+DFa6sZ8z1dkFupMl0bq7evaEtJSQJfIOVT/LQW+NtE+bgLfP8H8jDUVESnE8MKFrLV+kUOeeS4gOkekt/3KNIh1TLpoyIgpkJX/aa30hoEsKzLEbJoUfNgqbM68mdED65vaFZHji4fty8D2Hj97BkzOxet2SZJXuR/g9dJE2t6a+fN393Li3xB5AEGllg6erE65CytpT4gDyCYeRWo3j5rQ4a2p6jjJllKV4gfP12nh0Ga4ljEEFfcih2CnPj180+ak1odX1PIEejgGMuucYNHsApimytzCbI6NWDpnPdCJkYwPt4w0cJC0s4IHkI++koOhqntm64LjcFP7Y0tA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-13 (Postfix) with ESMTPSA id
 876F618000BB; Thu, 29 Jan 2026 22:25:04 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] tests/data/acpi: disassemble-aml: rename and change
 interpreter line
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <c7a77c16-2b43-40a7-bae6-1e6a579a99d2@linaro.org>
Date: Thu, 29 Jan 2026 23:24:52 +0100
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <61A7B50A-1034-4EB4-A58D-614BF8CBA112@unpredictable.fr>
References: <20260129164004.222-1-mohamed@unpredictable.fr>
 <20260129125744-mutt-send-email-mst@kernel.org>
 <a25e4042-0df8-4e46-9e74-3b4c55f90778@linaro.org>
 <c7a77c16-2b43-40a7-bae6-1e6a579a99d2@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: FUj9lAg2X_GD9BlcG8J4NqGdj0NZDvIi
X-Authority-Info-Out: v=2.4 cv=dozWylg4 c=1 sm=1 tr=0 ts=697bde42
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=uPZiAMpXAAAA:8 a=KKAkSRfTAAAA:8
 a=i7vTLBzgnDMdTzaG1hUA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: FUj9lAg2X_GD9BlcG8J4NqGdj0NZDvIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE2NCBTYWx0ZWRfX5o/1jkL8zgYk
 404F5j66Tsx84RspmJtui7UJg65UneS4iVS9pqpQnB5zhYJP7MKnm/F0g5VR3vQInMw8dr3Kt3B
 m9z8lMeMHEdEgWamWIDtEulx3lUcz6+h0zNr0nMzxK86y+C/2pLZeXoBgF1ClsOyxjMjTSO8CHw
 2dNb43rR9pHCAb7miOblv3kDFC6l0ycNskpLkzuYpSLmL2sPk73TChNRJPggGVor5SzOQp3lCgC
 nlDm2Cx/dvbQagWGTiNPd5pvEUNxYVcUgSDNJXtyqD3O07VHABlBJLATN0P2bEQAgJkYZPVjKxL
 ureAZbRtIwhfuG6R54cRbvW9yjRXseCsD6RUNC4l3EUuY6pZidUbI1MUICmwXU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=698
 phishscore=0 adultscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290164
X-JNJ: AAAAAAABLRlROs8JEZekYcSJOGxF0vUnDjbth/KgpSdtXpIM515Kh1yV02J0AujTnxFXa45cIJIei0AIkME+m1ZhPci3KwMHsLiuO+6NDV7kea6MzGKnIHwioe8XZGORjzZ7X50JFHcdzH5DRFEGecqSYA9ZRgrYXg4qw6pl1Tl9i0Ysn73E0uqg8KW7ooLXzEnFapbE8E4kEjXE7LMTvPU4ktK2QOnTCqz5pAWD1wl7O0ql1qZXLqIZPJlGvOrSxGUfW6JvkLT8Q7kMpa9IYpJQw9v8Yqjk4By0ZyLUcyQMhkuEUNnNyha276062OWZ1Ed+bZFTHg0wdabjLfx70+tJyvtyjJftHK3BUhMy0d/iIwHKwvWBfGKuNS4rKNUNqjxwApbV6VEzci0ySss8i5mLrnbiyj3ZknOzuhD+pyo3jQYZATiAbmAt2Aa2ocVwxIps35XzI/BbYE9ydtRD9KqkKdnA/d4UtxIODgb8izXKileKxpGGCfpiwhvU0FUdDxt29EPfqFtgqGouatO6UtRLrvqIpYhlY5c+13uYJZ2TjrA+AY5Zh5TswvdmGDw2/om71/I24B0JcJF8cTncnuqO8vXT6fQQD5kh2gADV+vyVvyY/s29P8br4uAi42s5DpFz7d/4Lcg2nIy6bpJe1fKaFqYFgTsQcntkFdL97BZHm0wRaJ0Wl/8=
Received-SPF: pass client-ip=57.103.87.123;
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



> On 29. Jan 2026, at 22:48, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 29/1/26 19:52, Pierrick Bouvier wrote:
>> On 1/29/26 9:58 AM, Michael S. Tsirkin wrote:
>>> On Thu, Jan 29, 2026 at 05:40:04PM +0100, Mohamed Mediouni wrote:
>>>> /usr/bin/bash isn't guaranteed to be present. Switch
>>>> to /usr/bin/env bash.
>>>>=20
>>>> Rename disassemle to disassemble in the same commit.
>>>>=20
>>>> Adapt the correponding message in rebuild-expected-aml.
>>>>=20
>>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>>=20
>>> /bin/bash then - that's in the posix standard I think.
>>>=20
>> Using /usr/bin/env bash is a pretty "standard" and good practice.
>> https://stackoverflow.com/questions/21612980/why-is-usr-bin-env-bash- =
superior-to-bin-bash
>=20
> On Darwin/macOS:
>=20
> $ which bash
> /opt/homebrew/bin/bash
>=20
> WRT QEMU source tree:
>=20
> $ git grep -E '#!.?/bin/bash' | wc -l
>      43
> $ git grep -E '#!.?/usr/bin/env bash' | wc -l
>     242

For reference macOS has a /bin/bash but it=E2=80=99s only there for =
legacy reasons as it=E2=80=99s the last pre-GPLv3 release:

% /bin/bash --version
GNU bash, version 3.2.57(1)-release (arm64-apple-darwin25)
Copyright (C) 2007 Free Software Foundation, Inc.


