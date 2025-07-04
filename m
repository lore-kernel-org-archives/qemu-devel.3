Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F2AC83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcTk-0003h2-V2; Fri, 04 Jul 2025 05:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcTj-0003fU-Gs
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:13:07 -0400
Received: from p-east3-cluster3-host1-snip4-4.eps.apple.com ([57.103.86.7]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcTi-0000rQ-35
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=btZRqsU/Rxwg4MUJoirKZHRrRnLk4Ti/4xhj2QRhk1I=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=WNSso8fIh1rMXyKeMp9jSaJg55r7me1NaHyvuIOjp+X/BNScliA5Fre4LDaeDFKJO
 2UhYpIpmtFgacJOdO1dPQzXn6RI7P+ptO+n0e3KDxRt279NHFY7Zsv1ycDYvdEdw9/
 31U8oT34bSG9vcyvKPdFwdO+hTiOhMXujftOtG2bgmP8+LDaR9IatNJ9zwGuwk9wih
 0w/UuGBgAsh86CwYIhgv2iLjb89djxy29myomphIPycuALvOvTiASyVDtwHT9EwhC1
 7ntU08CgXMInjtpLh7FGH6jBLtA+KY2x5z3dYfdrBA+xBOVvZ4/BoO5Hdok/v55qDF
 mYOCGNa1jp11g==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id A97E51800111;
 Fri,  4 Jul 2025 09:12:59 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id 77D95180013D;
 Fri,  4 Jul 2025 09:12:58 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 47/65] accel: Introduce
 AccelOpsClass::cpu_thread_routine handler
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250702185332.43650-48-philmd@linaro.org>
Date: Fri, 4 Jul 2025 11:12:48 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DC48DD3-A95B-4414-A456-8DE724E8C74B@ynddal.dk>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-48-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-GUID: 3Hx5EtpPLWG_PY8_LcEBC9pk4kb5rRnC
X-Proofpoint-ORIG-GUID: 3Hx5EtpPLWG_PY8_LcEBC9pk4kb5rRnC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA3MSBTYWx0ZWRfX+KFuI9nqlPXn
 xdylZahIJuDgFMQOwX7hUaWDVhnC+dhdouDG8OrcEBxGUdb24pLJ1cszNERWQ2R9VqUCeUtrRMe
 z6mhWY9n3qi9o6eVSHFluh05cCAXX4aDbV96qb9Wo+MTJVOns+EX92ZUbVmdPjo4X/gp97nRoR+
 kJNmHWJpJ6d8zBsL8KYp+gVsU/2Zhk6NVV5Vh8N8BBUDHhPS50+nJcSY8UpW0FwnFtdSSVzZnGR
 nOucOaMUbby9KrT1uzHS/u0IE28BY/RVXaDdYDM8szUrdCX5YJTopQMWG73GTba/hzo0ryol8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=937 spamscore=0 clxscore=1030
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507040071
Received-SPF: pass client-ip=57.103.86.7; envelope-from=mads@ynddal.dk;
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
> In order to have a generic function creating threads,
> introduce the thread_precreate() and cpu_thread_routine()
> handlers.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> include/system/accel-ops.h |  5 ++++-
> accel/accel-common.c       | 16 +++++++++++++++-
> system/cpus.c              |  2 +-
> 3 files changed, 20 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Mads Ynddal <mads@ynddal.dk>


