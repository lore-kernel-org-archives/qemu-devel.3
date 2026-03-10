Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5317BFCC9A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 01:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzlrC-0001iW-Qm; Mon, 09 Mar 2026 21:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzlr3-0001i0-GR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 21:25:51 -0400
Received: from p-west2-cluster1-host8-snip4-5.eps.apple.com ([57.103.68.98]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzlr0-0000q4-7H
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 21:25:48 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-10 (Postfix) with ESMTPS id
 2F74C180029C; Tue, 10 Mar 2026 01:25:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773105944; x=1775697944;
 bh=SZnb2t5+GZGj+j7twuMN3+W9nN1rysKq5qDjA0Fr8SI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=PzVXZObKqyFv4voAjvE2gqPR0whbzk7NZEnALn6MbsdN1xc+WhDcvzYxjaORPR/sZZGSTMAgj+ieIVVj5+MmPBlnXgthrKKK53LHXZ2wFVZyWOnOzyIZ81zpJaQj9xnkwqYvPCPWDz/S4dZHRQPRoL1gipoQVVVASbGFZzcsxNrtEEMW86rAzVdvFXNFKAyll/s7kt+uABL90LHXCL42Kv+bYq9XUzdJU3qU2uQfvEoLLOPF6tlfcRT/osOOJj+K0UAqCSV8P7JkhEGPKBmZ7GhKIgjVLubWImIP0NDMB96v4nOlbExtpKl4n4DhvR7HijSOyczuxrmwPrIV/skKJw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-10 (Postfix) with ESMTPSA id
 EC2A4180014D; Tue, 10 Mar 2026 01:25:41 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 2/2] target/arm/hvf: set 4KB IPA granule on macOS 26
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260309214906.92578-3-lucaaamaral@gmail.com>
Date: Tue, 10 Mar 2026 02:25:29 +0100
Cc: qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,
 agraf@csgraf.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F44C633-16F9-4A09-A264-F376500ABBDC@unpredictable.fr>
References: <20260309214906.92578-1-lucaaamaral@gmail.com>
 <20260309214906.92578-3-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=cbXfb3DM c=1 sm=1 tr=0 ts=69af7317
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=8rPa9FTpWmDybJs0ZW8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4YlvB7q9_d4FMRxvFVqvEkX1S8L_FOSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAwOSBTYWx0ZWRfXxTeCVVXn+sL8
 duvV5laiaOjejbUpjYjJb7+b1Jp4S58buGhGLlomzyhOlu1nobBD2BOYegInaGwg25WHEYcrtA9
 t1HVwCFwDQhVHqTuVCSaR1hcTHIIBNjr3aEVzB21u/ro5wH22UTbnGV454L0TSr0tlsO7dM53To
 3F/oDJF5Wx49gapDX/KPg1hTsKnHIGKEyUudxqPNLXVpGIxRq/UZxHLNdQFHZIyeltN0DiVPZQ1
 27LHdm2UDuqolC+LSlDqnUeuLwrDfmKqMKX6KMDg2bu3G6kSVwR2T2nbCZ3GBjxXIw5nQauTWAh
 WjD9+kQPN8Jz7Bzq8dBz5tqGmJLwYJdB4Nj5MqwxDxpX0Y9n9C3+Lac5wtOjew=
X-Proofpoint-ORIG-GUID: 4YlvB7q9_d4FMRxvFVqvEkX1S8L_FOSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1030 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603100009
X-JNJ: AAAAAAABU3f1EIt+N9Oe7b3a9KnVKoau7LAzVS6Wm+6Sup4xSdroCr6H9FzUeE5HauLcken7GmGyMh04rygslr/H0IaqqDjQwpQkZ/KgqlPAyIGQypct3lRVNi6sk8c6WoGQkOKshqOxuDYiEJmGG8DA1n/4KazpveESlz4PYo1zf5pOCqoHrASNv1ov0QJr3UZIboUQrgFQQ5bBja3o7zLhkY+hEQ0dXjS354A+EbE70kU7YPF6otuOUKDXlF3fTsNHrJ174tLeA13xTFfuEWRDpWjvA+W3O1+menL4DIbHRGx3tP3YQfpsvv5fWza0EaRYlo7aW008seRNCypPbqgtNHRakv9Pa+9AmGmlUxYoi/b/e604pFyELu8qphq3Q0gcsk1Qe2UlU59/p2pBm7AcssqoiNrWr8n6eopgQnk4i+tSFRTC5GwLy5YU+AsH6IaG/lknvw2OKjvLqJO9w9pY2eHz5xvjLzSF3mmfMb3VQ981TonzZCIOs+asLBrDQWw4Uvqsvdce3n3wyHOrF0G9oeSv4KflnMYvAtEx2+FGsrGYuD/Px0gpCh0IAd/nm7kuod83w9qneoPPSePtlnI5qX9mdcn1UibAzs2yjDTMq6GGCnSpTwj+e5tQHNUyg/31/HdzJdlliA==
Received-SPF: pass client-ip=57.103.68.98;
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



> On 9. Mar 2026, at 22:49, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>=20
> macOS 26 introduces hv_vm_config_set_ipa_granule() which allows
> configuring 4KB IPA granularity for HVF virtual machines.  This
> enables hv_vm_map() to accept 4KB-aligned addresses, matching
> the guest kernel's page size.
>=20
> Without this, virtio-gpu blob BAR offsets that are 4KB-aligned but
> not 16KB-aligned cannot be mapped into the guest, falling back to
> slow MMIO emulation.
>=20
> Gated behind MAC_OS_VERSION_26_0 compile-time and __builtin_available
> runtime checks.  Falls back to the default 16KB granule on older
> macOS versions.
>=20
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
> target/arm/hvf/hvf.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 87ddcdb..b71a98a 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -960,6 +960,20 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, =
uint32_t pa_range)
>     }
>     chosen_ipa_bit_size =3D pa_range;
>=20
> +#ifdef MAC_OS_VERSION_26_0
> +#if MAC_OS_X_VERSION_MAX_ALLOWED >=3D MAC_OS_VERSION_26_0
> +    if (__builtin_available(macOS 26, *)) {
> +        ret =3D hv_vm_config_set_ipa_granule(config, =
HV_IPA_GRANULE_4KB);
> +        if (ret !=3D HV_SUCCESS) {
> +            error_report("HVF: failed to set 4KB IPA granule: %s",
> +                         hvf_return_string(ret));
> +            goto cleanup;
> +        }
> +        hvf_set_map_granule(4096);
> +    }
> +#endif
> +#endif

Hello,

Not really happy about having this as a default=E2=80=A6 I see a double =
digit perf impact on compilation workloads here.
So having this as an optional, off by default option sounds best.

Thank you,
-Mohamed
> +
>     ret =3D hv_vm_create(config);
>=20
> cleanup:
> --=20
> 2.52.0
>=20
>=20


