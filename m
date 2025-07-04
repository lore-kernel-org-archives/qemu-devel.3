Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C84C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcTi-0003aK-3O; Fri, 04 Jul 2025 05:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcTg-0003aA-2N
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:13:04 -0400
Received: from p-east3-cluster1-host11-snip4-8.eps.apple.com ([57.103.87.111]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcTe-0000rL-6j
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=J/zNRMX17EirHAYiCF12q+UHtZrLrF179GvBMOdQDVQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=FP7mXc9yET4Tt51pQeAS7Yc0IT3mBLcGL/RiqJhHJxQR6s1zaloWk9+3bMq9VYIOd
 XAKauSKxgWtfUJUOqLVXCtxZ2CKykQunlGIVxTayZKga+zRDUlGC0W6V1AVPcyQ57u
 WiyTSMJB1u4ujyuNnR6xXWhtS7pjlGrH4KLwMLDgNtJW9P08GwcegktBTXReoKLE3C
 BsNyuSXjUe7eMzQkQ16XOdkFHNr62kt3kmoPKiLlL/WW3sM3MaECckT7b06nXgqssW
 RZRGEKcXfYd0Jtgnvg5UzTkaZw1rMAr2Plhr9ADGITCN+PTyQdLL1qk6Jr/CycEChV
 vc1QaOK6ARzcw==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 903C01800200;
 Fri,  4 Jul 2025 09:12:57 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id BD5CC18001BA;
 Fri,  4 Jul 2025 09:12:55 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 50/65] accel/hvf: Convert to
 AccelOpsClass::cpu_thread_routine
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250702185332.43650-51-philmd@linaro.org>
Date: Fri, 4 Jul 2025 11:12:44 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <52BF9AC9-6690-4939-8AEE-5BED9B07EE10@ynddal.dk>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-51-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA3MSBTYWx0ZWRfX+8BXCSD2UF8G
 jtW3BMLvkCbGptb+zlaCv37qlpCkuyU3RmeY+WA/uLwBm4wjeygnzGH2RG7gqfIO85tKJ0T73Ul
 JLQoVJJdERmMU2Zm1V3aGUP6wq2IOnxyXn/T7k+wWpDE6q76Prmn4Dt3tsma5ZpSWcGZ9hXFqWs
 gxF3JpGbspRYSOV5gWo5D0Uee/nK8mIml+EY9sv/86/0D5rMvNXHmZOHY32pNQnbBCLI2AXDAMv
 iwGnggriehuEH1WGfTpXtBCazpiDH7XkU9B7GLaG2vPv5cJGbzUJT8jfcFkm5AgEjDfFCcLbU=
X-Proofpoint-ORIG-GUID: wToZzANOOLVsqZxMt82t-JeI-5KCs9wW
X-Proofpoint-GUID: wToZzANOOLVsqZxMt82t-JeI-5KCs9wW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=860 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507040071
Received-SPF: pass client-ip=57.103.87.111; envelope-from=mads@ynddal.dk;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 2 Jul 2025, at 20.53, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> By converting to AccelOpsClass::cpu_thread_routine we can
> let the common accel_create_vcpu_thread() create the thread.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> accel/hvf/hvf-accel-ops.c | 18 +-----------------
> 1 file changed, 1 insertion(+), 17 deletions(-)
>=20

Reviewed-by: Mads Ynddal <mads@ynddal.dk>


