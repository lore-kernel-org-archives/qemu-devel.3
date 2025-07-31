Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7599C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 16:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhW3d-00068Z-Oi; Thu, 31 Jul 2025 12:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhUjk-0003fq-7x
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 10:58:29 -0400
Received: from p-east3-cluster3-host2-snip4-7.eps.apple.com ([57.103.86.20]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhUjh-0005l4-Ti
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 10:58:27 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 E91D218001A4; Thu, 31 Jul 2025 14:58:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Kx3OFevsggf5QevjKHY8QlQ/4BM1Y+lp+65Acjm4sfI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=XUEv8yn0GW6GNbm8/KcEqvZqcAtitsLShmGrlwdl/ZPaA0kkE+jJ414r65nnVta/APgyl/7tdvdfsZJcpUz2Lb2/euK25BW/opgCF8XRRjkLmq1+NEDr61jvnkcEO53fI9/+6UgSvx19EKymLgwM0OpJgBhwwDPN5n9OOmOVlfYS6CkasZsIeYg63KWcrwkl+8qL0aP6F0HmsyDf0KXsnf8gCE4knLiYGq3nSM480d7FXp7Lb13mM5xq7Htj2XQ0s2aVGIPs5HJwHM+nRKw35w/kJ+9EArL3RsCknhyQBe7PvVVpirP2sFLiDgn6//yMJMmIBXuazor9YlrH9+en9Q==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 DA7D91800180; Thu, 31 Jul 2025 14:58:21 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [RFC PATCH 2/3] tests/qtest/migration: Only test aarch64 on TCG
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA-acYCCXNy-udHTeL3zUFxonh4k6JwTJyxzHTMWTDN2NQ@mail.gmail.com>
Date: Thu, 31 Jul 2025 16:58:10 +0200
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <80BD56B4-BCD1-4C80-A7EE-91A9F1029557@unpredictable.fr>
References: <20250730205245.2118-1-farosas@suse.de>
 <20250730205245.2118-3-farosas@suse.de>
 <CAFEAcA-acYCCXNy-udHTeL3zUFxonh4k6JwTJyxzHTMWTDN2NQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX1lT17gZTuCjg
 GLLCepIBgJutAFf9z3kysyp/VO9GjkmWEhlnXrvTQfEul3KCgk+Xr8FQZ/y/pkkLBnMQZrWtY8+
 ImwKKl7BkG2gb8TY4IIfeXeJIQ3Jnzj8jZPYTqhQJXa89SfkecskyvULSjhQACgX7lk4ozimZl7
 BU+Uv6MfKqKghmHV6KJPNqD5Js2GXy4RxqqMPPz/FwFMNfyihpznQebrbAzgfsQVveyJxsgaLV0
 g0cs2eeuoihFmZTngQXUguZaSmGqTtoFQAnqAB7cwuircMc0jOkQo2lqheHrqjJdJTJK7xesc=
X-Proofpoint-GUID: FMl2sz_7wRt-YChbVXGlhyyj5ZsrFk-x
X-Proofpoint-ORIG-GUID: FMl2sz_7wRt-YChbVXGlhyyj5ZsrFk-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1030 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507310102
Received-SPF: pass client-ip=57.103.86.20;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



> On 31. Jul 2025, at 15:37, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Wed, 30 Jul 2025 at 21:52, Fabiano Rosas <farosas@suse.de> wrote:
>>=20
>> Currently our aarch64 tests are only being run using identical QEMU
>> versions. When running the tests with different QEMU versions, which
>> is a common use-case for migration, the tests are broken due to the
>> current choice of the 'max' cpu, which is not stable and is prone to
>> breaking migration.
>>=20
>> This means aarch64 tests are currently only testing about the same
>> situations as any other arch, i.e. no arm-specific testing is being
>> done.
>>=20
>> To make the aarch64 tests more useful, -cpu max will be changed to
>> -cpu neoverse-n1 in the next patch. Before doing that, make sure
>> aarch64 tests only run with TCG, since KVM testing depends on usage =
of
>> the -cpu host and we currently don't have code to switch between cpus
>> according to test runtime environment.
>>=20
>> Also, TCG alone should allow us to catch most issues with migration,
>> since there is no guarantee of a uniform environment as there is with
>> KVM.
>=20
> The difficulty with only testing TCG migration is that now
> we're testing the setup that most cross-versions migration users
> don't care about. At least my assumption is that it's KVM
> cross-version migration that is the real use case here.
>=20
> For instance, this migration bug with the DBGDTR register
> isn't a problem for KVM, because with KVM we use the kernel
> to tell us what system registers are present, and whether
> a register is defined with a cpreg in QEMU or not doesn't
> affect what we put on the wire for migration. Conversely
> there might be migration compat issues that show up only
> with KVM and not TCG (though the most obvious source of those
> would be host kernel changes, which is kind of out of scope
> for us).
>=20
> Though of course with our CI jobs we're probably not
> doing AArch64 KVM cross-version testing anyway...
>=20
On the cloud provider side*, we do rely on having rollbacks work.

We rely on staged deployments with rolling back if things go wrong
as we observe progress.

Note that the set of MSRs KVM gives (at least on AArch64) does sometimes
vary between releases so for rolling back you=E2=80=99ll need to ignore =
some (new)=20
sysregs in the vmm. With careful planning so that you deploy a VMM
release with a point-fix to ignore the new registers and then the kernel =
update.

So not dealing with that would make the cloud use case not usable =
without=20
downstream patches.

*although we don=E2=80=99t rely on Qemu for Nitro System VMs

Thank you,
> thanks
> -- PMM
>=20


