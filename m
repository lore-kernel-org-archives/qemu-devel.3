Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42581088E58
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 01:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w327o-0001rD-GN; Wed, 18 Mar 2026 21:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w327m-0001ps-2O
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 21:24:34 -0400
Received: from p-east2-cluster5-host3-snip4-10.eps.apple.com ([57.103.79.53]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w327j-0002vy-PN
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 21:24:33 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id
 795BC1801636; Thu, 19 Mar 2026 01:24:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773883468; x=1776475468;
 bh=s5R37oWHqji/UUcBuPL/k7euyz7faFAaBQYMUfOKokQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=RpeXvSCndPCxJUtpEIV07QjUR6imyBDWGme/AOO8Bx9/ZIzEkpLqJ1vVDZebxlkRqQdXTLo9Rp9bPC8JXYFyUfS/xewTpvca3JrDhjjqw2gK7JxlvLxjkspBHuUbKfYuvA/6cdADzUuYi1kKo+IUlaGkruepsynaaHLAVhETjwWWFZHEzYpI8HH/N8PXBtMn/3unhGYg62Kn1SAkW3PtLGi7Nu6HG9hWaKpoejoY0NJZAOsY2sLJwGNuH3IbfNSQ07Wsr4vD17GbScFq1OY2rkN9ZeV7Ovwc3p9nVLIOWDEOy61FQ0AWlPO02d30Hj4o3MmAFnKlfqEsJm92JQpmeg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id
 7AF5C18030AC; Thu, 19 Mar 2026 01:24:25 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] meson.build: Add --enable-use-pdb option
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <MN2PR02MB6622718572E2A2B5E4EE3C039B4EA@MN2PR02MB6622.namprd02.prod.outlook.com>
Date: Thu, 19 Mar 2026 02:24:13 +0100
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <13DF1B88-DE82-4948-9749-A83D4163ACDE@unpredictable.fr>
References: <MN2PR02MB6622718572E2A2B5E4EE3C039B4EA@MN2PR02MB6622.namprd02.prod.outlook.com>
To: Steve Aarnio <saarnio@qti.qualcomm.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: kNsR9-kInCAqPVfuXF0CbvPNLevaUgFD
X-Authority-Info-Out: v=2.4 cv=e9cLiKp/ c=1 sm=1 tr=0 ts=69bb504a
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lsRcH5Gk26C9aY8VpZoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAwOCBTYWx0ZWRfX94t+ekE6dKFH
 GCyhrxcsi7A6GPpHh49AMgQQn24yq+CRKoc378ZH1WMDu+amAQ4wCCeUodJ9zu6wrJZTaiUIkxC
 Zsvf5K1N2Xt71E3r58Gfk25KPTTINsxJp+75TeZyAELyUYeKJvGVuZEBU/oALhhT2lZGIR44UlU
 h24BANIS4WjsgvudQp29jyJZJOTX+3B5a8ZsWl/YkipTYg8nX22xeSfYVZAlus5vZAKq9M9bTTw
 MZOlbEToCBW1OGrVZuBYxINRXfbOsVI6sqZsRtdELwv/EvgxJjc4yRfnIX6ZEg3qTdZelYjJoN4
 VvZeufgBMbjiYpu4lGlWWD5dPN+uP6RhhFsWfP1ALsdTpj+lBGeB+A7nBrrxbM=
X-Proofpoint-ORIG-GUID: kNsR9-kInCAqPVfuXF0CbvPNLevaUgFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=804 phishscore=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603190008
Received-SPF: pass client-ip=57.103.79.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 18. Mar 2026, at 20:18, Steve Aarnio <saarnio@qti.qualcomm.com> =
wrote:
>=20
> This option will (attempt to) modify the QEMU compile and link flags =
to
> emit PDB symbol files rather than the standard (DWARF?) symbol output
> from gcc/clang.
>=20
> This enables using native Windows debug tools (Windbg/Visual Studio) =
for
> debugging QEMU.
>=20
> Signed-off-by: Steve Aarnio <saarnio@qti.qualcomm.com>


Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Already used something like this, it makes Windows debugging =
substantially easier.
> ---
>  meson.build       | 5 +++++
>  meson_options.txt | 2 ++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/meson.build b/meson.build
> index d7c4095b39..d27581e0c2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -692,6 +692,11 @@ endif
>   qemu_common_flags +=3D hardening_flags
>  +if get_option('debug') and get_option('use_pdb')
> +  qemu_common_flags +=3D =
cc.get_supported_arguments('-g','-gcodeview','-gcolumn-info','-fno-omit-fr=
ame-pointer')
> +  qemu_ldflags +=3D =
cc.get_supported_link_arguments('-g','-Wl,--pdb=3D')
> +endif
> +
>  # Collect warning flags we want to set, sorted alphabetically
>  warn_flags =3D [
>    # First enable interesting warnings
> diff --git a/meson_options.txt b/meson_options.txt
> index 31d5916cfc..b1f3250d5c 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -372,6 +372,8 @@ option('debug_stack_usage', type: 'boolean', =
value: false,
>         description: 'measure coroutine stack usage')
>  option('qom_cast_debug', type: 'boolean', value: true,
>         description: 'cast debugging support')
> +option('use_pdb', type: 'boolean', value: false,
> +       description: 'use pdb symbol format on debug windows builds')
>  option('slirp_smbd', type : 'feature', value : 'auto',
>         description: 'use smbd (at path --smbd=3D*) in slirp =
networking')
>  --=20
> 2.53.0



