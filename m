Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A730106286E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0I94-0005zb-Mx; Wed, 11 Mar 2026 07:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0I92-0005w1-7k
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:54:32 -0400
Received: from p-east2-cluster4-host12-snip4-4.eps.apple.com ([57.103.78.185]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0I90-0003hb-9S
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:54:31 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id
 668411800235; Wed, 11 Mar 2026 11:54:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773230068; x=1775822068;
 bh=ezBgT9B9v7HyZ9m0ZCmwmGTcNvYHrFJRAGCmzmwAKbQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=KXXFMmA1qX000LoddDp+sDOq2MuqxewNS6+QOmHHfNCiR+UrVzISKLmvaT49wVIb+tLbXL/pU9f/DelwQecKr7DfAkDWGqqkUEZAhSA9jnywx//BR3zQxgHOAQ+XDq/X9zZsgo1ACblu7P85joPybZS43FDcFeFpki2H00aIy6l9HPckf70twKgIPblM7T9iMPsdhIjqB3eix9wJ7ffPPbYhr2sr8jYULwa7/UbO+Ood58JKGBH+Ik8hKdCxbItvPNZK4Ilo+wj7XXaNzd2fMmsm+t0HQP9zUZLOtHqZmBln/tdUdTsAv/9dxlIavbEhlOuUg31EU8Hmwy2uc2GsxQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id
 BD9A1180020A; Wed, 11 Mar 2026 11:54:24 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 9/9] accel/mshv: disable la57 (5lvl paging)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260311113505.1177878-10-magnuskulke@linux.microsoft.com>
Date: Wed, 11 Mar 2026 12:54:12 +0100
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D1F935F-865A-4B24-B616-BEE57B22FB2B@unpredictable.fr>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
 <20260311113505.1177878-10-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: O3Mtqluxp2F1EnWXQrZOT6uewlCaDLzi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEwMCBTYWx0ZWRfX4wJvWxGiOeqH
 2EP5Hkz0G52jVJEFZ6lFNBLwSqPYBOpLJptY6tVqbW034ujlvq0IkBFzmwnsrLNDdxOfwDFesVT
 L1kl/TFsftyAMw32ctEDMuLrQ2Leat9Yu56MmiGy2G504MsrkStc1add3QJ6LSWZutcY7hZkkGE
 DMa97jJcWa1l4mXHCEVJibCfr2IXGsF1DbOiCs4THFsUV9SOLx26SmQlzIEjs6pP78ZZ5z4+k9K
 cahBgD8bGpUQsEBJ2qBh8fE/biJbUeAwlMfZ8sUMJIFKG5PRry/EkSR02lQsVfKxKFDjjZ6HU8O
 P+z+k3G/rSv2HCFp3duys1nuV8VBuOFKtVOI+p7Om/QTmUeiqqX1C02/e8XQqw=
X-Proofpoint-GUID: O3Mtqluxp2F1EnWXQrZOT6uewlCaDLzi
X-Authority-Info-Out: v=2.4 cv=Vtwuwu2n c=1 sm=1 tr=0 ts=69b157f2
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=GySLw-dI4Ghi5hKW5BoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1030 malwarescore=0 spamscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110100
X-JNJ: AAAAAAAB/ytSNRo55A3jxJiabSVziTyqMA8fQxOCvkeRMFOMoCT8ojXlWlg7363EtdRz1vptoUmPRk0Yiy2RRj5uvIOXqsiKyU76dB8Bd4iNbifb1DEhcgj1qWW7PXtIsQgers3GwEPQT39sVOrdUHofuZd1ez0gR/iLFRRQ8WT3K5Z0lntq5Zr3qY4Mhjv5smXehp4wmDoz1agCjrs08l/OGT6pImHXGKhH10/h2JQCIOisFg+kQHuE3g1aCCFdhF/uWc9PRyzjvnzCP+dmQKnwkWnZ0qcjIbcjd6TSeTD/6DvppbUauRfb5Orcnk2VBbQhbfwMq8gNxZ1fgaruDAjDpjJ5ovNcDYVGOmMhUBPKbINrnKfClWlPzoiml/pWRfTTCFeK9hPloCZlLWn0yWhJrBJI6T52ZzPfD+c6YepB1ZjI319BzWYRRPMmc8QM3IAFNbZIJdqy8oCnZIlOdsC89vPTMSUG6tZRiH1PWLhN3UMoe62if0e1VEsxqAXEqeArIf3lAQueCiBgxA7CS4i/MOmfCVUeYMBa89puPlmCYSrPzFO3Vp9nAFp0OQANTgKfsrxPSFmk7wIU/LZAQtECnf6PkTYsXUeRWnN4O7l8xtxtBiRbK9rJkh3jd0tSgk5ObMtQU0yHmLHc15QgATI9EKEP7yP39SkJeT4dY4y4aQ+BdClGxvbgiw==
Received-SPF: pass client-ip=57.103.78.185;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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



> On 11. Mar 2026, at 12:35, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> This change disable la57 paging on the mshv hypervisor on both the
> mshv processor feature bitmap and mask the cpuid feature leaf to the
> guest.
>=20
> Since the removal of hypervisor-assisted gva=3D>gpa translation in
> 1c85a4a3d7 we have seen MMIO errors in guests on la57-enabled hw. We
> will have to investigate and test this further.

Hello,

This should already be fixed on master since yesterday. Can you repro =
this?

Thank you,
-Mohamed
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
> accel/mshv/mshv-all.c       | 7 +++++++
> target/i386/mshv/mshv-cpu.c | 6 ++++++
> 2 files changed, 13 insertions(+)
>=20
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index eab967ff07..ea3aacf6e0 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -142,6 +142,8 @@ static int create_partition(int mshv_fd, int =
*vm_fd)
>     int ret;
>     uint64_t pt_flags, host_proc_features;
>     union hv_partition_processor_xsave_features =
disabled_xsave_features;
> +    union hv_partition_processor_features disabled_proc_features =3D =
{0};
> +
>     struct mshv_create_partition_v2 args =3D {0};
>     uint32_t feature_banks[] =3D {
>         HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0,
> @@ -181,6 +183,11 @@ static int create_partition(int mshv_fd, int =
*vm_fd)
>     }
>     args.pt_cpu_fbanks[1] =3D ~host_proc_features;
>=20
> +    /* features we disable regardless of host support */
> +    disabled_proc_features.la57_support =3D 1;
> +    args.pt_cpu_fbanks[0] |=3D disabled_proc_features.as_uint64[0];
> +    args.pt_cpu_fbanks[1] |=3D disabled_proc_features.as_uint64[1];
> +
>     /* populate args structure */
>     args.pt_flags =3D pt_flags;
>     args.pt_isolation =3D MSHV_PT_ISOLATION_NONE;
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 2c66a52709..31fb788657 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1677,6 +1677,12 @@ uint32_t mshv_get_supported_cpuid(uint32_t =
func, uint32_t idx, int reg)
>      */
>     if (func =3D=3D 0x07 && idx =3D=3D 0 && reg =3D=3D R_ECX) {
>         ret &=3D ~CPUID_7_0_ECX_CET_SHSTK;
> +        /*
> +         * LA57 (5-level paging) causes incorrect GVA=3D>GPA =
translations
> +         * in the instruction decoder/emulator. Disable until page =
table
> +         * walk in x86_mmu.c works w/ 5-level paging.
> +         */
> +        ret &=3D ~CPUID_7_0_ECX_LA57;
>     }
>     if (func =3D=3D 0x07 && idx =3D=3D 0 && reg =3D=3D R_EDX) {
>         ret &=3D ~CPUID_7_0_EDX_CET_IBT;
> --=20
> 2.34.1
>=20
>=20


