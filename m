Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4279D2F35E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 19:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfjnk-0001fr-Ky; Tue, 13 Jan 2026 14:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vfjnf-0001fX-SH
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:11:31 -0500
Received: from p-east3-cluster3-host12-snip4-10.eps.apple.com ([57.103.86.123]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vfjnS-00084L-Ub
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:11:20 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 5A7AD180016B; Tue, 13 Jan 2026 19:11:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=QZjqv2R9z7DyONz4NYBFpZPJ7liUJwN67PQWtNdRY20=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=XCypDJLpSZnQoxGpn9iG5Oj+VSpMHeg96SuqAICdfn9g95RkU1p2lVt5HVk8784N3Kv4ObrsWNYndmkaT0OMwoV+jKVnd+/EaroyByX+4x+hPXYZQ0vDRwTkhD3F3cNXTPKpg1KHm8dvG0eTo7e+21j4IIS1R7b4527ok+bkrvDZQOsE+EpAYDZj/pxT73YNuoMeFAoHaJeXdBwzC2Lz7A8mP7bMyfS/3jBhd+sbylMlXWXJxYn9gruRgNbws0IBHp0qA/o7Xjo/axAIRJnZLDTx7x2yX3HvGE+xu414Z4yAdQXhpxUgAkqXzEWx7VxcNqJNVThKUFsYY77OsI3gng==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 E8BD51800120; Tue, 13 Jan 2026 19:11:09 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] accel/mshv: Remove remap overlapping mappings code
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260113153708.448968-1-magnuskulke@linux.microsoft.com>
Date: Tue, 13 Jan 2026 20:10:58 +0100
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0BAABD8-DC26-431E-A1A0-C9C8BD07EFA8@unpredictable.fr>
References: <20260113153708.448968-1-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: ITF8D1gL6DxTEkvjrtyzojgySNUr6i2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE2MCBTYWx0ZWRfX2BTXie8Tau7S
 XvFE752wlZGlv5030bDeU6GU5sFLt/iu1LPduXCLLO18B/PyuFbJkuYN79BHs7wlrZV7IHMBCna
 k24Vk3QaxGGN/1ZIulKiEa183xypsakYgdErDtN65yVaY8MbM46YRu03FE8tLvFZ9tjcpuKdW9D
 hLAqlECLdbhQjYZg2eo9bQA+I6yuWVPqZz57cfBf/onCLhTVExzeZCdIcglHCABlrPVAI9WXp45
 EOCXXfg5W69feE5MyeFK2DClVH0TCbDmwEzMOVk0haV1O1S/QWeeooez9a59cQPiQm6MTyFXKUP
 8t0FjUC9yKEsJoRlCU4
X-Authority-Info: v=2.4 cv=Qs1THFyd c=1 sm=1 tr=0 ts=696698d0
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=57JGEKEj1fhd59RVf4IA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ITF8D1gL6DxTEkvjrtyzojgySNUr6i2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1030 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=995
 suspectscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601130160
X-JNJ: AAAAAAAB0EnnGHElkbnTH4rcDeO/z9OE16IoLfd2QT+2oRLUS63Cjlx9tI8YlPYqoA2j3MU25cZFRFKxas95C4rNfLUJ2E6Wvi//joqwhfnjK6j5h1Wb+QniaIr/TLiBGIEg5I9EJQxy5dOOy8QP9VzunEbRgEOrvkzzSotYAHnc+nUboDIHWj7V9VN1C5/l1jTlhQZMVrvJ4y1VLGmtXvicx7GB1QK9DEq40sncD5JRAY+MSrh7XCB1AJotW2dxb5QRmjKf8Ov84ivDjVCpp/rxLn/0GURw7xgZ3Mic9RqSsxAlvE2R2MYXRRjhnA3qo/6v4TQQy2fa7W6eU0M2x9CDg9Lw/hC1c/cFXkZd/b72bI2l3k1n6tGU8V9VTBOKmZuVdFb1HYSNYropDn0KD8OJR02wxnjOR4Sbv7urqpoWT2ebaJNZBnUiaRqtPSkUB8xIo51gsL+A9Rm/Yp3prHAj1cl1D1+gVRMC9z2ER2QLoYWFVbC3X1YGaRsmtuRehLwYIYy6HRfNn5SP1xBVnvdofI2JNdq0PqMQsklzWGuEZMa2K2Wl0mPIRqWgshgnpUZ0i3ouQCqvCAu+FfhvKbnmZqs/bG9RyuiAnSAQtaUFTv5HVO5VIs4GWaWoacaoyw1GuqzkFrUb1enMpRevioRolVqwLpLKu+Y=
Received-SPF: pass client-ip=57.103.86.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 13. Jan 2026, at 16:37, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> This change removes userland code that worked around a restriction
> in the mshv driver in the 6.18 kernel: regions from userland
> couldn't be mapped to multiple regions in the kernel. We maintained a
> shadow mapping table in qemu and used a heuristic to swap in a =
requested
> region in case of UNMAPPED_GPA exits.
>=20
> However, this heuristic wasn't reliable in all cases, since HyperV
> behaviour is not 100% reliable across versions. HyperV itself doesn't
> prohibit to map regions at multiple places into the guest, so the
> restriction has been removed in the mshv driver.
>=20
> Hence we can remove the remapping code. Effectively this will mandate =
a
> 6.19 kernel, if the workload attempt to map e.g. BIOS to multiple
> reagions. I still think it's the right call to remove this logic:
>=20
> - The workaround only seems to work reliably with a certain revision
>  of HyperV as a nested hypervisor.
> - We expect Direct Virtualization (L1VH) to be the main platform for
>  the mshv accelerator, which also requires a 6.19 kernel
>=20
> This reverts commit efc4093358511a58846a409b965213aa1bb9f31a.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Tested-by: Mohamed Mediouni <mohamed@unpredictable.fr>


