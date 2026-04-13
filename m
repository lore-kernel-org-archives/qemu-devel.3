Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968F7EBFD37
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCEn5-0001gf-8w; Mon, 13 Apr 2026 06:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCEn3-0001gK-Sy
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:45:13 -0400
Received: from ci-2007k-snip4-3.eps.apple.com ([57.103.88.106]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCEn1-0003Gj-Mh
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:45:13 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 A2D081800108; Mon, 13 Apr 2026 10:45:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776077108; x=1778669108;
 bh=kvpUHxG1fSduAkGhoOnHOglk6QAGi9NMYXUiuQG8gvk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=d1jPuJTRPmjDZHO6QyuHn2gWuNANIFXmxAyRV6ebyqRJtQZ4m2lE/Qs9bwTpZr6WYeIuyid4a6F1LZGaueee39M4q9rn+NopznlSSmBGNNwtDOoSb95/ILTL/THI6sji532No1NWc60ISzOx/JIxX9lQtGid772GNGEqQlmMAtI7XDAytA25PGLk6JdtxiS1rMBSLzIClXsEcK0cEJ8aJBJdE1DQ/zxhv+M/7z5ePDfrwTD6xGRNVYfAKPU8URsCuCTsAYG0i5806Jj+1oQftDuyRpzDUW4ObLmr8qef0CiClAdchwQkW20yrWRKI0uPEFnr7oTRzWyRTXTawPR7vw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 7BD991800938; Mon, 13 Apr 2026 10:45:05 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for-11.0 ?] docs: Deprecate Arm OABI and NWFPE support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260413103754.45745-1-peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 12:44:51 +0200
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F20654A8-2ECB-477B-8B64-9688B5FA9EB6@unpredictable.fr>
References: <20260413103754.45745-1-peter.maydell@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=U/qfzOru c=1 sm=1 tr=0 ts=69dcc932
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=m0MIS4uQmYall_Cdt4sA:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NFgdbMIlLS5cUoYo-xNuZmpNa-Aimr2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNCBTYWx0ZWRfX2utFdo2l4ODn
 rnjJYPSB5ifXQGyZVNGxRquTGSqapRx5+ZIJMhwxhD/1ztOGRhecn0LaYNoGorfyP65OUcR+7Rp
 LJ8UovCx35OFyksp0bNYJIkM5EDem++/ifPSfMgoeZPRNHBB6owyKcXZvG2cxf3WaA0TgU1JEyN
 x43xOs7VXDfQebwrEOc8sqiP9Y761f8GcDBugszx3k+oSQCcW2V6it2KHri2BL+UX1ybJgoL+xW
 s3TSIKzPjQb4bbHt3IrXM3Z/sopjpVi/dyf84tD+MWW7B70dSBunbhcwfmuOieE/KUpnron0i9W
 xwcUbMbi+oPOcJMvHAUJrGdw1rnK38LIBkO19d7px4o1dRosS0/CSKWiLH3kB0=
X-Proofpoint-ORIG-GUID: NFgdbMIlLS5cUoYo-xNuZmpNa-Aimr2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1030 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604130104
Received-SPF: pass client-ip=57.103.88.106;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 13. Apr 2026, at 12:37, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> Linux for 32-bit Arm has had two major ABIs: the original OABI and
> the more modern EABI.  OABI support was marked as obsolete in GCC 4.7
> and dropped in GCC 4.8.  In the Linux kernel, compatibility handling
> for OABI (OABI_COMPAT) is not generally enabled by default and is not
> compatible with building a Thumb2 kernel.  Distros dropped OABI
> support fifteen years or more ago.
>=20
> NWFPE floating-point emulation handles the ancient FPA11 coprocessor,
> which is only needed/supported with OABI.  Our implementation is old,
> untested and not thread-safe.
>=20
> Mark OABI and NWFPE support as deprecated so we can remove it in a
> future release.  Our main motivation here is to be able to drop the
> 2500+ lines of NWFPE emulation code.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi,

Especially that this has ISA emulation code inside of linux-user (!)

If this is (unlikely) to continue to exist, it ought to be moved to
common code for system emulation...

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>=20
>=20
> ---
> This just came up today; it's tempting to squeeze the deprecation
> notice into 11.0 so we don't have an extra three months before
> we can delete it, but we could just deprecate in 11.1 instead.
>=20
> docs/about/deprecated.rst | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index a6d6a71326..10de10dc23 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -452,6 +452,31 @@ It was implemented as a no-op instruction in TCG =
up to QEMU 9.0, but
> only with ``-cpu max`` (which does not guarantee migration =
compatibility
> across versions).
>=20
> +linux-user mode CPUs
> +--------------------
> +
> +OABI and NWFPE support for Arm CPUs
> +'''''''''''''''''''''''''''''''''''
> +
> +Linux for 32-bit Arm has had two major ABIs: the original OABI and =
the
> +more modern EABI. OABI support was marked as obsolete in GCC 4.7 and
> +dropped in GCC 4.8 (released in 2013). In the Linux kernel,
> +compatibility handling for OABI (OABI_COMPAT) is not generally =
enabled
> +by default and is not compatible with building a Thumb2
> +kernel. Distros dropped OABI support fifteen years or more ago.
> +
> +The original floating-point coprocessor for 32-bit Arm was the
> +FPA11. This was not present in many CPUs but did get baked into the
> +OABI for how to pass floating point arguments, and so the Linux =
kernel
> +has support for emulating it via the config option FPE_NWFPE; QEMU
> +follows that. FPA11 support was also removed from GCC in GCC 4.8.
> +
> +QEMU's NWFPE code is old and untested and not thread-safe; the OABI
> +ABI is long-obsolete. We are therefore deprecating both OABI support
> +and NWFPE emulation, and they will be removed in a future QEMU
> +release.
> +
> +
> Backwards compatibility
> -----------------------
>=20
> --=20
> 2.43.0
>=20
>=20


