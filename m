Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E09EE88D72
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 23:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8nXD-0007ri-FC; Fri, 03 Apr 2026 19:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8nX9-0007qR-Tk
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:02:36 -0400
Received: from p-west1-cluster5-host3-snip4-1.eps.apple.com ([57.103.66.152]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8nX7-00073t-Hd
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:02:35 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-1 (Postfix) with ESMTPS id
 53A5218001BE; Fri, 03 Apr 2026 23:02:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775257351; x=1777849351;
 bh=5ZVydFP4kCNN3u4IIfy5YY0AYFONomqOn0xlyzs7jDQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=JXgXO3Gpcl/KFo+nDIO2ZSh8R9rTasApvGLzhhviz1LC5foJ/6C4kxJZTZ91KgFHJ2ZQJiOu6v1lIak032riSVPSMq1KE3pgWJc6Yx03hfpyk76kyhHbsKee6VJ4kcg1zBI9Jjn0595qcm7Rig8znnLmaFIwgpaRzWLjnL4WST2FH2xT+avi/iQzdZO1JCFlj+mOX9QHQDm80o90GsIyErpBGam06U+e6dyNmvgUvBqFtwMm1arV2UzV8UkeqKnjBXvUaeD05ZupZ8DQzlvEVKMt86Hnzdt2SDe5erHJH92IQR3UQntgVXJmgP8V75LoaEdsE3q0FbzMY/pAdcZnlA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-1 (Postfix) with ESMTPSA id
 5F1BA1800590; Fri, 03 Apr 2026 23:02:27 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] target/arm: cpu: add HCR_E2H on reset for EL2 + !E2H0
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <6af2abbe-2626-4401-b446-6a2f603cf1c2@linaro.org>
Date: Sat, 4 Apr 2026 01:02:15 +0200
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2AB1F1C8-8092-43FC-A072-15F271A54B16@unpredictable.fr>
References: <20260401220720.19555-1-mohamed@unpredictable.fr>
 <CAFEAcA8qchsEganwrejiqoWabUd_BmNfnS0AXzWR+tT61OsjyQ@mail.gmail.com>
 <6af2abbe-2626-4401-b446-6a2f603cf1c2@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=B+u0EetM c=1 sm=1 tr=0 ts=69d04706
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=tCBua7DQ6L0qMCO42SwA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NfZs-O9O3WPTOH5Ckhp4njaZq6QnJHyA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDIwNiBTYWx0ZWRfX4F8FkZIesSoV
 SUOAe36a5QhFP7KoYFNjL61y2wqhfJ6TXacF7lkrQ3nffRC5FBxuqNEL+isyo+/QmjLn4Jm7y2A
 sScTA/DZRdgNK1LqeJy557EGI1xWzM308Gi86amS1XeSNC6nrFxDP+tOZqftYV6yBYO3nW0kVlq
 5AayGi9khoOJBd1xtL8RG1NJ3bX+2r9fmPa60vG3E9SAHvrrShDa0N0ah4YKo2wKiSKxyGZHu58
 pHKN6o94M5vVYraNhxj/ZtdFcgk0aJQ4wQEvZj1gJZVo92DOeo7AJ4L9DlmBAkzcngAgC7CPiE2
 /WJy0IKxnVQGW+hLiVMYD0qyrvCpzDlDpbdUB3zduINhsyxIL8tmewqerTZXI4=
X-Proofpoint-ORIG-GUID: NfZs-O9O3WPTOH5Ckhp4njaZq6QnJHyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604030206
Received-SPF: pass client-ip=57.103.66.152;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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



> On 3. Apr 2026, at 23:53, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 4/2/26 21:17, Peter Maydell wrote:
>> On Wed, 1 Apr 2026 at 23:07, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>=20
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> This could use some rationale in the commit message:
>> why do we need it, what goes wrong, etc.
>=20
> Indeed.  I would expect this to be handled via hcr_reset and
> a2834b853d9 ("target/arm: implement FEAT_E2H0")
>=20
> Specifically,
>=20
> +        /* Strictly E2H is RES1 unless FEAT_E2H0 relaxes the =
requirement */
> +        if (!cpu_isar_feature(aa64_e2h0, cpu)) {
> +            value |=3D HCR_E2H;
> +        }
>=20
>=20
> r~
>=20
>=20
Hello,

That=E2=80=99s indeed the case, missed that commit.

Some context: the issue is an edge case around nested virt on hardware
without FEAT_NV2p2 where the guest cannot flip between VHE and nVHE=20
at runtime - but the OS supports both nested virt impls.

While KVM handles HCR_EL2.E2H=E2=80=99s effective value via a KVM cap,=20=

that=E2=80=99s not the only option around. An HV tries to be clever
and sets the state depending on what HCR_EL2 is read as.=

