Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C012ECAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYw9-0007K1-LQ; Mon, 08 Sep 2025 06:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYw0-0007Ek-2K
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:16 -0400
Received: from p-east1-cluster7-host3-snip4-8.eps.apple.com ([57.103.88.31]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYvq-0001UM-2G
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:13 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPS id
 035BC18001EA; Mon,  8 Sep 2025 10:16:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=tmKsZoKf+Uy3jOFBDkiL7LRAOXRyQXo19aT/gXMpONA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=DOps6US9/zq7y8b2nsDQzxv8BdSicwW2YL8I8MvZZ4vAmGTDu+cMjn5RsykAvVyeWyMiGkpTYjZQjP1RlVjbGz8lEOH5t/PtJKpYTJJBmkuk2galM4sYDNmog87gjzTpmIGKoeMZRj/ZvqhLlhp80aYtONDXCQ7Y8Ac9zZosolyAZLUHcNiGzGy/s1sW3STDDzSObUXv5MEwz2WuH3gC49W0DVoNaivVCTnmF9eEdOL8lKHTUQUowwwMVoYt6urEvVelZ+6mTn0LsFkh1sExNVAAyUT/c2D2VZAPJYD/ixAoqzQPXmTSo/buq0naL5L028Ubb4wfi9R1i83IqiMjZA==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPSA id
 A57EF180089C; Mon,  8 Sep 2025 10:16:57 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 05/24] accel/hvf: Rename hvf_put|get_registers ->
 hvf_arch_put|get_registers
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-6-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:16:56 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08023CA0-7581-4646-9B39-8DE6FD546540@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-6-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfXzf/AEil7dmuq
 l/A2Sjay8JtjneXAhQasJxphasjvH8fYNASE4e/NvAPI6caOqO0kj4zq/LJD2zDwF4xayAdJeFJ
 8c54bz5ZI1pXOQ042P7Ag6uuU9nBwqxwCCrISTpplTFUVSvKcFAZlj8kqJO9Thyv99cYy5Q905F
 zRS1Djp91ui5Ln38wY8Cz6AiPdBzQEWH8mPYjjbHA608xelk0En2f2yTMB8GaYYeKhHge8vrRbI
 M86wdbWSgBGskcBaU5pN/aNqWCh/ZxGtHQlBzVqI0ofTTIo3RsNm30Xs1ViN5dBu1eMR3Hgw4=
X-Proofpoint-GUID: dkdtUvocF_yVwABVpv-jbT65_cSmiwDe
X-Proofpoint-ORIG-GUID: dkdtUvocF_yVwABVpv-jbT65_cSmiwDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 phishscore=0 adultscore=0
 mlxlogscore=850 malwarescore=0
 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAABvVoAsXjBnK4dy75a9qDdbmh8pNaGcT4TMu7TzuZrlhtwnPV+0TXIgMbzS7f6xwi7pqREyqNhbg820wjO9zEPvUSOFbYVBuXRARNg+wxrNSgtZykkvD8DaiLmFOlqlXc+qttIuNDsDdT+o8nPUrB6nxvQ9b3tU5beR9PpE5oEQzdTVdSJQDyTQPKLO7L/4pNDQQLIbkCf85rwyayy4+TdKejQMczErkrp9MNLhZ2+N9Q02rUVAwjx0W1VQo45NOk7XPMLqiQyT9P5TkuksAJYQrARK8iL9Wm5WWChVj3hZh/HkKi2AR7xYDjutgjI6AcWpRJUeJ8y21AG1XaLE5XOUL728pbInbDvZ0pzaRC8b52AaXDUMmuRrsxhnp7cwXzHcvWImnlaOJmoKfQaXsJnVOR34XeCv+QHTllaIqz9cIdb6uqnrb/WHolIrRhTujMTW+gmOVUfJYDlKQDigGVF04iYoAiZPbI828CdeGz96Ya5ksokdLLPo3nXPD9+JBM/T60PxJIgDrlFEi3tvNIlXK3vmKgkQiGNKpuIJGuR22rJajprffh3Iw+HO9N/lR1a8DTzztTpUVukpPNoM5jyc1nNOSimbEc/DNvFochGizRyk3UJoir/HZqWbGKRhjzfeVz5IXX3s1JGxrfo9KicAfxoQUpyZ2CdzAxfOg1SSHbLPX5EzOs9T00+kRHt4j4JbaT3QxLCari3UbN73OR5Qw==
Received-SPF: pass client-ip=57.103.88.31; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> hvf_put_registers() and hvf_get_registers() are implemented per
> target, rename them using the 'hvf_arch_' prefix following the
> per target pattern.
>=20
> Since they call hv_vcpu_set_reg() / hv_vcpu_get_reg(), mention
> they must be called on the vCPU.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> include/system/hvf_int.h  | 6 ++++--
> accel/hvf/hvf-accel-ops.c | 2 +-
> target/arm/hvf/hvf.c      | 8 +++++---
> target/i386/hvf/hvf.c     | 2 +-
> target/i386/hvf/x86hvf.c  | 4 ++--
> 5 files changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

