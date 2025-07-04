Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1A1C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdhY-0005a5-CG; Fri, 04 Jul 2025 06:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXdhN-0005T2-NC
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:31:18 -0400
Received: from p-east3-cluster6-host10-snip4-1.eps.apple.com ([57.103.85.222]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXdhL-0005tf-Mk
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=sMuvWNAlThdQUT/Jm7Bs2UfiTYxk4u/ZKdImK+MyzHE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=KQA9ilY+zLk/ev5yDcg6mI7uP2UwKDDek2FgQNBPu3X8F6yeTpo9yz9NTJqLzh7q0
 fbA8xsY06V3wI5Tnb97jXJoG1InjTd5e6qTcqUbQXqhbb/0WyKEAgtfpUCplAZ5BcH
 m+hdCMd9TaUu2n+COz/CB3+G7iDgGf8kC7mVVJNX9LJMDuDIoyLqTUzEPuPG2dnTb8
 FiHULwMsMARvwg0ew8zkoTqppFU6hopNzdttzWfXO587RQHWA3w3T9fmDye0tEa48f
 AuyWM0DIyaMYqYCZFNbzX6NbcRyDhp327CwGQyVQv5Ty7I9Wt8FQmvLAxD/VBhnn9I
 4y5tDZvqmpHPA==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id AF6B218474DD;
 Fri,  4 Jul 2025 10:31:08 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id 201081800D26;
 Fri,  4 Jul 2025 10:31:05 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 56/65] accel: Expose and register
 generic_handle_interrupt()
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250702185332.43650-57-philmd@linaro.org>
Date: Fri, 4 Jul 2025 12:30:53 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2974E816-ED2F-45A3-988C-ABA4F52B3CCE@ynddal.dk>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-57-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-GUID: KQj32bSACKGkz9oeNzR-NIMXRigV6oVh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA4MCBTYWx0ZWRfX9balHnkxxi/e
 VU0upZooqQ0VYpwfKxM8EcAGk4hlTjFqBvN4x6d2apopuSDiOED5VzlE/O2FLhnWsp3LR4a/vzX
 vFLAMIEhhf/uxwm1MbJRzh6XhgsHqE+7xQ1HfBe8xym7SL/++rJRO6L0bbCMiP85fT+gr9BpUOV
 TDZsUjpZ6r4uNldEPAkDBJSEVqUQAliaffVx/0Q9Gbk93bAfFbav4DKAFqhQfPe+tiIbYty7Ic5
 FjyUTPSVQ3qfJGGVguN7cFDqT12dQ3NZB89x0HES3JRu0OZ8mqBC/trvm0E1/ul19OIU8j3i4=
X-Proofpoint-ORIG-GUID: KQj32bSACKGkz9oeNzR-NIMXRigV6oVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 phishscore=0 spamscore=0 mlxlogscore=704 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507040080
Received-SPF: pass client-ip=57.103.85.222; envelope-from=mads@ynddal.dk;
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
> In order to dispatch over AccelOpsClass::handle_interrupt(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::handle_interrupt() mandatory.
> Expose generic_handle_interrupt() prototype and register it
> for each accelerator.
>=20
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> include/system/accel-ops.h        | 3 +++
> accel/hvf/hvf-accel-ops.c         | 1 +
> accel/kvm/kvm-accel-ops.c         | 1 +
> accel/qtest/qtest.c               | 1 +
> accel/xen/xen-all.c               | 1 +
> system/cpus.c                     | 9 +++------
> target/i386/nvmm/nvmm-accel-ops.c | 1 +
> target/i386/whpx/whpx-accel-ops.c | 1 +
> 8 files changed, 12 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Mads Ynddal <mads@ynddal.dk>


