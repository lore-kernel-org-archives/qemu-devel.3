Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C8DCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 12:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvaYj-00073t-9d; Mon, 08 Sep 2025 08:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvaY5-0006nb-7V
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:00:41 -0400
Received: from p-east1-cluster3-host4-snip4-1.eps.apple.com ([57.103.91.162]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvaXo-0008I9-0r
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:00:33 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 ED7591804184; Mon,  8 Sep 2025 12:00:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=SuLAzvOhLVipLoTmqg4V5ZeEMLw2CfCEVTT2lV2DADg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=SHn6eGp6Ui/NzotryxFFgPusi8QVvZZDKyFmIEvR2S0amYOsT3lOvXsLwPTBR0HIGTfTL7YUn8p9CbmYcv/N5FUgb1hEQuw2uJxIwYifcs58drGsczIq6T7giHCsYTMiiTQ3z7L0yzw8gk0rtwb7oxmo4J6KfR124lpuAY+ZmcweANeHFSHJ76shyTvJi5Tj/0jsejXKzWoMdnAEv3+vHvT7ijmYFHe9VzLCYNOFCzHTQt3/2mxE+bR7Blk52OV5jMwRqCGLgM/CveRvfydW9/dcd/puG3QtaJLM5ht+Y6FP3xtlmOHUF23A3Q/51CzZ1TjJ5WX1LVigWhoRM+7JGA==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 C4DDB1802886; Mon,  8 Sep 2025 12:00:14 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 14/24] target/arm/hvf: Hardcode Apple MIDR
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-15-philmd@linaro.org>
Date: Mon, 8 Sep 2025 14:00:13 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <961B6832-7A11-43C4-BD96-F3D496E890F1@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-15-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-ORIG-GUID: vQ14YlMs-WTRcdd6IbB3rUxyYxVD6fws
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEyMCBTYWx0ZWRfX3iZdWC7G3/4t
 1qyLrclcxXwKjRQCRoDZ56Sj5DZpqDf2fEBsxQPFUfGrftA93I43Fuzs1la80JuDahVV96wGUua
 rGLqq9RCJ3cUBh3vOtD5XyKwZ71tzGXJLV3BNcGSE6GdfbGS6lCAmZOb09/k8sPf2zFGz4utThd
 bisI9G7oYnEXEGKtc2TNnE4xAamepJ6UqsXiMaeTerlv2vF7h2AQSA2pbft3Rctou8g8+xj9v+L
 bqe4mXVChv6m8We+mZzUGMjr5Bg5hJWk8nnyDy4QlCL5LyoE8B9vTzoaLo6WtqHvf8d+beLIU=
X-Proofpoint-GUID: vQ14YlMs-WTRcdd6IbB3rUxyYxVD6fws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0 spamscore=0 clxscore=1030 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2509080120
X-JNJ: AAAAAAABy2XgT/RIeFo9kDDZ01/Gu+1DAjbROSwtPqEpexHhlzx6krnbEfzVt9So8qW0G9GIyzHhR2f8ORlYNckBix65QJDbSVo0fAojjYd9HJBkxALGlNDQnr8gzpkS8sKtCB9bx6Gr3rUOZsQaKTgwkL/DRoFR8rcnbu0bj7GvCcMR+bDh9U6UoqjO56ULaz3K6ncKg1CI+nQ15rq0BI7Ag0wnuJ4O8p8w3g97/ndBn1gzHmmg9OxzCtSWRdcEdRPjTU2q6Arv41wmRoas4D5tlfinM4LVhU9CO331EHn7g7oSm5y5ilzPT0BxT3DmoU/gAGvfiZ98tpyKTgmNKeN/Y/rAgGZBjSonVk1SeTyk3M3Vnh2zQs1Xu1z5tljLcl7iMSBB9ktlotdUrtUIeqm7AmLWMghaFtRz+tjFPzita4IAWuS9fy5yQ0rN3OyOw+E0u8VNgD9E/RibbQhL05fd6Y5ocWR4reYrX7pIeZw1WztNLKUZQD7IfOnmvTtiJL9AF/MTIpSrqKoWY55Mu92hKrXB6QbLmVicjfCFsdfna0gUYeDGaEMYBSwpq/+1LOIeV/uUgsUjbPYoGlPUPRKOTQdtrG8+/D61HkO7jcKSE60d6H8EL6LJJhLeFMHtVFKsI+APE5dLtW4FKxZjjohw9ls8HH6Ag39yo3UrlBETIP8R/ygaelal5cNam+joQeJ2X7LCc/b+c1qu8y2VrVtHrJR9lr2cM9RiHjNQcZ2RE8pxfQI=
Received-SPF: pass client-ip=57.103.91.162; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
>=20
> Hardcode MIDR because Apple deliberately doesn't expose
> a divergent MIDR across systems.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 5b3c34014a5..3039c0987dc 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -887,6 +887,7 @@ static bool =
hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>     hv_vcpu_t fd;
>     hv_return_t r =3D HV_SUCCESS;
>     hv_vcpu_exit_t *exit;
> +    uint64_t t;
>     int i;
>=20
>     ahcf->dtb_compatible =3D "arm,armv8";
> @@ -908,6 +909,17 @@ static bool =
hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>     r |=3D hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);

This line above seems redundant, if we override it in the following.

>     r |=3D hv_vcpu_destroy(fd);
>=20
> +    /*
> +     * Hardcode MIDR because Apple deliberately doesn't expose a =
divergent
> +     * MIDR across systems.
> +     */
> +    t =3D FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0x61); /* Apple */
> +    t =3D FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf); /* v7 or later =
*/
> +    t =3D FIELD_DP64(t, MIDR_EL1, PARTNUM, 0);
> +    t =3D FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
> +    t =3D FIELD_DP64(t, MIDR_EL1, REVISION, 0);
> +    ahcf->midr =3D t;
> +
>     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
>=20
>     /*
> --=20
> 2.51.0
>=20


