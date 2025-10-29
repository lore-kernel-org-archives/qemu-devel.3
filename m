Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30093CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 20:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vECh6-0008Dt-KM; Wed, 29 Oct 2025 16:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vECh2-0008DN-Bi
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 16:22:52 -0400
Received: from p-east3-cluster1-host7-snip4-4.eps.apple.com ([57.103.87.67]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vECgh-0003ml-01
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 16:22:51 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 F2F7A1800BD1; Wed, 29 Oct 2025 20:22:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+yYFXfNNcPlUszAxRn5e83ggxda1VDHNyHFrklr02y0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=PVceSGUxkjOykRgpAASyXecC77AGcYq0YGTtCzR0VAZcAR+c7FPkn/SMyi2wAEPgJgGCH7C5KZwksIaPagWQXv8ykTSyNTuOdC4TGH2l1j/YLAG+uYe/eg4SFiAUFuY57Orw/1HfCdKe5nH231xSnkAbriY/5bIYaNg/b5NXQH3zin09TaEZmFRKWIxTFu0iSQLZQ5p/fv1ZXagFtCmrI8rNSKi36ZoP+ekDohavrNE/luXU0PzlaY2ID+1OrXcwoKNVOiPMrLP6bYCIQr6oUJuHJULwN2E+PcGW6mlTqM3e1xdROoH6rY8TSRRQtZ1JOunyPp3+iSnY+eGsuTgxyA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 B03091800BC0; Wed, 29 Oct 2025 20:22:20 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v10 00/28] WHPX support for Arm
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
Date: Wed, 29 Oct 2025 21:22:08 +0100
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C946322-334C-40BC-AC60-F51EF86F42CF@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
 mohamed@unpredictable.fr
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-GUID: meQgQPzd3rrACpieXp2dOjRCNdTtPQk3
X-Proofpoint-ORIG-GUID: meQgQPzd3rrACpieXp2dOjRCNdTtPQk3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE2MyBTYWx0ZWRfX+lGH7WAe3X7n
 fEySopjVVccADVcxnflGh3IciahEUtmovJGsvSuMZac+DUxRyrYF8v9BRh7v1nx8hLLmUmbfE9t
 tKTnQk2seBfvmPOa2vmRUjmAQe1KznaiX5xvgqsY/gsM8CGcMecjTJ1oKJYhaa1oRD01bBMC6A+
 jlKnsioWBjYYQnd3NEJ9P7Anl/EpMkqwbG0k7++m2dDC+6Eeo3pcwPb12rvaBD4hpkS+eDEsBED
 v1IlUognFfwtXoqHOw2TSUOdvigzODsivZVgVjIni85kZkudQEcSwbUcDPKxhWmn9rYb2KpqA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1030 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290163
X-JNJ: AAAAAAAB9JGPSyuckpNxeH+m0Q8l0XNMc+LZTElhCHCjHRo4HMiqzTkh0BU2dGvREgNOZD/rWNmuJgN4qTN4dNTxhoMXEevvrjEhKfgU0n4Bn7jFrp5dnmvrpjIGJtjtSkyT6Wrjer4oQFpvWsW4cJ9FIdzgjgQil6aZ39AvY1wouRomnu8Ab6brJ5JmNfK+ckEA0RDy+C4ZxDbfLu0KGJ2ipHlOdg+CRfi7XduhBSS9Q7hUIiSuaaLY2DGILuLMUiR1W/WI3nWmnFPgKT5a9yIk4oO2p0U1ocGmcDPU4bi0wGCo+3eu3BO+peZe+ldF47DIsJ9u+8/mTdzvQ6mEUvV9AJPcfTDRc5LB7eqIOTtTwpM4RhHZOVxdLZsGxg/lHxuIkbRhshAP8Ed7j/b77pJ937oYT+y3n1F00MS6q+A7SVGE5IRKHl0T6h8HiQdAMYeS8hdqtWy5CXGgf2LxtqGXf01egAeFTDDL0NvY3VdAU1WGuXJuhZZKMEosY9hsKEG4SLDRb83g4qwHK1HbeK6ZyUMw8v3K8fl6/SZrD80X0hLFVENg4OrocQ+qcrpV00fhKSMyuFhhZ/BgxvjRUB60VVDPBN1cvgK4d4Zg3YrR8hobm+cCGQUdB2T7PChrynqI+Ub7e44TJsqDP/vjB7POdme27fzueFzKwsT50MVrwuvQ4cXPC6Xb6aYzaLzNv2J6rHFEmF9Wzysmklc5cQxw5CF/pu01ntIxuByWna4yPyVa
Received-SPF: pass client-ip=57.103.87.67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 29. Oct 2025, at 17:54, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this =
submission: whpx-v10)
>=20
> And yet another note:
> On build 26200 on Snapdragon X, I often observe CLOCK_WATCHDOG_TIMEOUT =
BSoDs _on the host_ when using WHPX qemu. This is currently
> being looked at. This also affects prior revisions of this patch =
series.

More details on that:

When specifying both -cpu to a valid value _and_ -bios to firmware (or =
the pflash arguments), Qemu will work.
When not doing that, the host OS will crash with a BSoD.

Currently taking further a look into that...

Thank you,


