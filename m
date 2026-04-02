Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C491FD3942F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8J0C-0004wX-8R; Thu, 02 Apr 2026 10:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8J0A-0004wA-RA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:26:30 -0400
Received: from p-west3-cluster1-host9-snip4-10.eps.apple.com ([57.103.73.221]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8J09-00042r-3W
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:26:30 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id
 5C98718000BD; Thu, 02 Apr 2026 14:26:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775139987; x=1777731987;
 bh=1y/UEeq6vRliePSxlVpxLJQP+ufy+JqtHN/I7Lku4co=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fwz3ZeC2JO9ug4Vyl0Fk0qBkU8DACBNVDurEnE35x3ey9lgiYx/wBqDWlnkwkyKb0U/23N1xLnpfGn9ZYMdz6+uzgrxMQaLsyLOtZXZl2zFXz8JwfQVnG3PqjVV2EkLsQ8IIyEA/66YDXztsmqlLuYu/PVFjixeZClp1odKh7jZqFW0MluhwglyW6NVVauAriaT+oGfcZrHB+h8WOkwHKq8CbH3ovbtcC8kxPFAvPs/Iv7SzhNxmQP15feqwnmAefud7M86GhBVc7YjizpNzPcgQSZdIw4FYyDB73cnzD7KLVsvhP4xb3WTjsQtuBRkiB4MLbYwMT73Bw0lQ/ad6hw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id
 DC1E01800364; Thu, 02 Apr 2026 14:26:20 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2 06/14] accel/mshv: add arch-specific accelerator init
 hook
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260402-mshv_accel_arm64_supp-v2-6-754895c15e9e@linux.microsoft.com>
Date: Thu, 2 Apr 2026 16:26:08 +0200
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA3D9272-4972-4922-B6C2-26306FE19139@unpredictable.fr>
References: <20260402-mshv_accel_arm64_supp-v2-0-754895c15e9e@linux.microsoft.com>
 <20260402-mshv_accel_arm64_supp-v2-6-754895c15e9e@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-ORIG-GUID: yWlUHXkZEcn4ULLpWhHI67V0PsOUTCNo
X-Authority-Info-Out: v=2.4 cv=BdjVE7t2 c=1 sm=1 tr=0 ts=69ce7c91
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7e0Bp55JX4NyRwa4NggA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzMCBTYWx0ZWRfX2oDk98z8QuU4
 FRJcrnfnZNvG2Q9TnieZXaFCKzvGt3NlqTK5QdnVHrMxLL6iK66ksVcvqK+bZw9NRunFLnf14q7
 OoZKnYCi5KkzsKIBY9GWX6cy8+XP0W3qKETUCtpWzpHrrylT8TVBj0qFvLKXZvPEMzvZSh5IOxT
 oV/RUXRQCUWXGd8ewxSRQ1t8Nm2RnvL5GHhSmBkHKN86Gy4dU0pwiu82S8XAydU3xZl2MHH3wsL
 W/By2OdUzDT7zRfqaJkDU76H/CJ995YaKQlc8vf6pmF/lWSH2ZhMu+0G4awc6N+/ds4aRQZC0HC
 QXuF+B7wSsABHTNgmxG52AWKTSwewkNxKTsjIycGpjfYE7x5BxfhUr0ItFWuJo=
X-Proofpoint-GUID: yWlUHXkZEcn4ULLpWhHI67V0PsOUTCNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=982 malwarescore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020130
Received-SPF: pass client-ip=57.103.73.221;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> +/*
> + * Default Microsoft Hypervisor behavior for unimplemented MSR is to =
send a
> + * fault to the guest if it tries to access it. It is possible to =
override
> + * this behavior with a more suitable option i.e., ignore writes from =
the guest
> + * and return zero in attempt to read unimplemented.
> + */

Hi,

Is that desirable behaviour on arm64? I think it=E2=80=99s better to =
_not_
do this there.

Thanks,
-Mohamed=

