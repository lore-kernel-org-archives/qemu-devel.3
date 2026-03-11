Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FB8FD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0BOb-0007Cu-GO; Wed, 11 Mar 2026 00:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0BOX-0007BX-2k
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:42:05 -0400
Received: from p-west2-cluster3-host9-snip4-10.eps.apple.com ([57.103.69.73]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0BOV-0000sn-I5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:42:04 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-10 (Postfix) with ESMTPS id
 EF32318000B5; Wed, 11 Mar 2026 04:41:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773204122; x=1775796122;
 bh=9N0j/JMZSrhLu9KBn4ihwqUY1Borf8UihA9I6oyEEmA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Jf9RVDzjck/BM4QqmYIJQxyS8oJqoyJzC01sMOJ7Q1ORDr16RSLcXtKaR3UwMZ8mmgfbaPKJkTO06PMRW7fRBNZYQOEzh75VlWsDGaZqlwbFIf7ByXJ468PzKLYPv0X0U5A5zl+rp9jkPhrVdWA6eUuTnnRmk4hJrk/VfmO287mqGL7t6QVRmFU/aqswDmN63P0xuH2ym2q4XCEChnqYL0ZOX83F00zk8tF5cMbvtWzThi6Kr3ODLHuqgs3/TxOyUMstvaHL6G30kBa/LpBPRG+iExUwSov26crkBJ9NvSgUZcN/dBoUL3B14o7Al4Kn+A6pT9JbgB4+4n0ByYv29Q==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-10 (Postfix) with ESMTPSA id
 959EA180018D; Wed, 11 Mar 2026 04:41:58 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 2/2] target/arm/hvf: configure IPA granule on macOS 26
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260311022732.64141-3-lucaaamaral@gmail.com>
Date: Wed, 11 Mar 2026 05:41:46 +0100
Cc: qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9438B20-B58E-448D-BD23-6A3ABA90B384@unpredictable.fr>
References: <20260309214906.92578-1-lucaaamaral@gmail.com>
 <20260311022732.64141-1-lucaaamaral@gmail.com>
 <20260311022732.64141-3-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: sn-VpV_J0lxe9-KYEytAhtAu94jhoNQD
X-Proofpoint-ORIG-GUID: sn-VpV_J0lxe9-KYEytAhtAu94jhoNQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzNyBTYWx0ZWRfX2YgcS9uMC12r
 lMkd/s3r3SzBhpyc7T+QXayJEMGD1gRs0s34Ax3Wqme8VCS2vC3YHXoNrcBayTtmpwO2fEgAv9A
 rHbuLqi9sJE9CRpE+WINYT8IIZ6w1ACgxicIFKXsdIKnNScDUfWLREU1sATGY2th9ykDFv0q5w/
 UHdfkEyzp/HhlkThjb8hQk0/Rgr9QQh/7KsfBxJtkAfuEsWKpSji6AYD+o5kBHdkC9+AinaLK54
 Qu/i6xsY2vGb2CcNJEQG4huGtNuwRtmm8N4gdtAxhnBtgg3Vxm9oJGbM61/6vA6uOoV5UDUhZy1
 5vr6rmXMIm6kFy4/N2OTmIJpP14JxJL237GOy4FlUCt453jpu7d8h2JjHPU8b8=
X-Authority-Info-Out: v=2.4 cv=dfmNHHXe c=1 sm=1 tr=0 ts=69b0f298
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=vnEtX3AOTeo4fqEWj8EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=983
 suspectscore=0
 lowpriorityscore=0 clxscore=1030 spamscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110037
X-JNJ: AAAAAAABh314aZjwd46Z2/QZRsSUFUm5xtGEccg5E+qQiVkFQfCAVOrO9uZlksUZHP7X1bZTDuJvPLO+XNjWeX+ldAy+b5ClAWgzn+sA8EbhZXnyylJa4gwaMr/uOtNr8BVb6KOXUoLAwp4OsoXhWt6Au9naZZDn0l/OuLhzxVDdWk0kPGccAZ6ufpAeiyZUE8IxLm3WgsiQ7h4O/78hBlFlxH5gdiELSEejcBz9InZs/B3NG0o+ZNYPAnLa/VmKwhWpt1OSRACfp4wyeDwX45MXWRa1hECDJHo39DoPO8qUACWmsTQHCr62dvbcjJkeUgRdS1wfQmzyam4CWxq4qbsmiGoK5UP3mM4yJfD94i4EfHV8cKwWgCtiXlz9aZ+ijpgdaN7emWdRfeK9Y5I1acuZS2c+XhFaZBdJJjym88c/6pAh1pVEB1BX8K7Y0JHGcxi3r7IkLy8BRBjipWZ94adhMiYmhIYLj+SWfEOsiS1oyKDHcofL0mIOdITRi5TvRDA/GMdZh1ZQTQDz0cl3G7FGInA2D7cwYHW4Gq4yqQaXYrzp4suF+sikLwGmcclCQbSnWUbXFcRJuDjwG0eKtgZflVSlhqfsC3M1k4Z9K3EKNV/AuoruC99599cqJW4=
Received-SPF: pass client-ip=57.103.69.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 11. Mar 2026, at 03:27, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>=20
> Read the ipa-granule property (set by hvf_accel_init) and configure
> the HVF stage-2 translation granule via hv_vm_config_set_ipa_granule()
> on macOS 26+.  When ipa-granule=3D4k, use HV_IPA_GRANULE_4KB to allow
> HVF to map memory at 4KB granularity, matching 4KB-page guests.
>=20
> If macOS < 26 and a sub-host-page granule was requested, warn and
> fall back to the host page size (16KB).
>=20
> After resolution, warn if the map granule exceeds the guest page size,
> as Venus blob BAR mappings require page-aligned offsets.
>=20
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
> target/arm/hvf/hvf.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 7952b01..a6f139d 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -11,7 +11,9 @@
>=20
> #include "qemu/osdep.h"
> #include "qemu/error-report.h"
> +#include "qemu/units.h"
> #include "qemu/log.h"
> +#include "exec/target_page.h"
>=20
> #include "system/runstate.h"
> #include "system/hvf.h"
> @@ -960,6 +962,53 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, =
uint32_t pa_range)
>     }
>     chosen_ipa_bit_size =3D pa_range;
>=20
> +    /*
> +     * Configure IPA granule from the ipa-granule property.
> +     * hvf_get_map_granule() was set by hvf_accel_init() before this =
call.
> +     */
> +    {
> +        uint64_t granule =3D hvf_get_map_granule();
> +        bool granule_set =3D false;
> +
> +#ifdef MAC_OS_VERSION_26_0
> +#if MAC_OS_X_VERSION_MAX_ALLOWED >=3D MAC_OS_VERSION_26_0
Cosmetic:

#if (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 260000)

To match hvf_sme_stubs.h
>=20
> +        if (__builtin_available(macOS 26, *)) {
> +            hv_ipa_granule_t hv_gran =3D (granule <=3D 4 * KiB)
> +                ? HV_IPA_GRANULE_4KB : HV_IPA_GRANULE_16KB;
> +            ret =3D hv_vm_config_set_ipa_granule(config, hv_gran);
> +            if (ret !=3D HV_SUCCESS) {
> +                error_report("HVF: failed to set IPA granule: %s",
> +                             hvf_return_string(ret));
> +                goto cleanup;
> +            }
> +            granule_set =3D true;
> +        }
=E2=80=A6and a single endif
> +#endif
> +#endif
> +
> +        if (!granule_set && granule < qemu_real_host_page_size()) {
> +            warn_report("HVF: ipa-granule=3D%zuKB requested but macOS =
< 26; "
> +                        "falling back to host page size (%zuKB)",
> +                        (size_t)(granule / KiB),
> +                        (size_t)(qemu_real_host_page_size() / KiB));
> +            hvf_set_map_granule(qemu_real_host_page_size());
> +        }
> +        /*
> +         * Venus blob mapping safety: warn if the resolved map =
granule
> +         * exceeds the guest page size, as virtio-gpu blob BAR =
mappings
> +         * require page-aligned offsets and would hang otherwise.
> +         */
> +        if (hvf_get_map_granule() > qemu_target_page_size()) {
> +            warn_report("HVF map granule (%zu) > guest page size =
(%zu); "
> +                        "Venus blob BAR mappings may hang. "
> +                        "Consider ipa-granule=3D4k (requires macOS =
26+) or "
> +                        "guest F_BLOB_ALIGNMENT support.",
> +                        (size_t)hvf_get_map_granule(),
> +                        qemu_target_page_size());
> +        }
The warning below doesn=E2=80=99t have much sense to have here I think.
At least not in this form.

With that warning removed:=20

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> +    }
> +
>     ret =3D hv_vm_create(config);
>=20
> cleanup:
> --=20
> 2.52.0
>=20
>=20


