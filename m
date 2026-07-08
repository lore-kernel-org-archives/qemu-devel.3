Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B02C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 23:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whbid-0005nT-AA; Wed, 08 Jul 2026 19:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1whbib-0005nD-0Z
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 19:30:17 -0400
Received: from p-east2-cluster5-host3-snip4-5.eps.apple.com ([57.103.79.48]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1whbiY-0006Kb-M5
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 19:30:16 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 7AE5B1800116; Wed, 08 Jul 2026 23:30:11 +0000 (UTC)
X-ICL-RepId: 019f4411-48a1-7e5e-8143-64ac01fa37f2
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkQOQQdVAF4EXQlIBl8aXwMyfFUKXHFTHzULPQIvA15zRns+BS1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1783553413; x=1786145413;
 bh=r8ko/PoKW3wJ76mqfLR4CwvjgcisfBuVZaRqvgKnuak=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=dDe298JlVMdvWGiDUcSJDAEyuYrXQx3p3Roepf4LsNq7foB54kHv857fP/Ie24Fc6rzopMzz50VpPEVWVFjzOjVpgKgFxKilDqaD5xDuDKCo+369RsZpUBP6vCFm2XOx9ZHuSfQxH3PCKFOTEqwHPkG2eQoiQYlSQJdaxQzznag5w2kk8uCoNHPt4BbRZuTTg9Nmp+BaAiYwiuLnj8CzcgMKPgXvvyHmjJRY70F8rl3xcnMKJTzvdeyFcENdAGk7VH9rG6lRL1JTIgcH5OTgrF4LSf9+YSjA0Qec4w1DvT/jUFTtqgtjvRlzB3lZavVRJyWNDc5GRy41LSEJKVUe/g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 EA156180040C; Wed, 08 Jul 2026 23:30:09 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3895.100.17\))
Subject: Re: [PULL 28/38] target/arm/hvf: Keep calling hv_vcpu_run() in loop
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <51024f9c-2b0f-4a92-b512-1c79fda0338a@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 01:29:58 +0200
Cc: Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <47948756-0052-41BE-91F8-E2E1B45A6BF6@unpredictable.fr>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
 <20251031183310.3778349-29-peter.maydell@linaro.org>
 <51024f9c-2b0f-4a92-b512-1c79fda0338a@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3895.100.17)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIzMSBTYWx0ZWRfXxxg360UttFz0
 fdqjuivkosv6jCIzXJkZgiow4AAwG+DZYxQNjmWUyJIH9tL3TC4fd0wnrqd6ykaP06ousFoXzKA
 dGzY/gOzryq6WA4TtwcqspC/xpzqXlslVU2Z5E2bet2G3/DIczmpZGp/fBL1kI3MbRnOeCGnGkK
 r5iH+aa1myo3JWepcrajW7KFk/2RHUVnrJDkS4Rr1ArBr1JtldWwhQPhRAJF8pzjVLxlXgYjljz
 c7dDlK2EL2oloUfJRa4ET3TXoyWaptqcEqQKXZenRAyJgRKilZoY6ocjVX43j4huYhhUC5i3NCI
 dSKPex8+jlyAzdnHQpY
X-Proofpoint-GUID: IebYeadmNW9YNj3R08Nnzu8AeSC6i4mM
X-Proofpoint-ORIG-GUID: IebYeadmNW9YNj3R08Nnzu8AeSC6i4mM
Received-SPF: pass client-ip=57.103.79.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



> On 9. Jul 2026, at 01:16, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> 0xfae94004


Hi,

That corresponds to HV_ILLEGAL_GUEST_STATE



