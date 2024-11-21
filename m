Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267ECD6E2A4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 10:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE4L2-0005uI-8A; Thu, 21 Nov 2024 05:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tE4L1-0005u6-Aw
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:23:03 -0500
Received: from out-181.mta1.migadu.com ([2001:41d0:203:375::b5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tE4Kx-0002WK-BL
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:23:00 -0500
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1732184575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeVQZF0FwaNkO3dCJrjK01ITq5xM5OeluXX9EWTRgt0=;
 b=M3bdrsBxb7z9ptW+rXKcq6n6QFejYzvxPJWiwbM1HqzfT7vuy8Ahw6kHy73AQtsXqEroln
 fVXNHD68EkKAl/SrnNQHf2bAG2x8cQnrqdx4+wZ1sRZD5BBQpmZUjZVOdd67SvbxJYDKOj
 U60Ju2WQSz3Ppd9mYy2uE3BonS//8xc=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: New "rme-guest" QEMU object addition
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20241121100000.GA2024976@myrica>
Date: Thu, 21 Nov 2024 19:22:37 +0900
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF591E76-2E35-48D4-B817-80A5297FEEE5@linux.dev>
References: <9FF5EDFD-6026-4C3A-A6A1-A66521D837A5@linux.dev>
 <20241121100000.GA2024976@myrica>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b5;
 envelope-from=itaru.kitayama@linux.dev; helo=out-181.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi Jean,

> On Nov 21, 2024, at 19:00, Jean-Philippe Brucker =
<jean-philippe@linaro.org> wrote:
>=20
> Hi Itaru,
>=20
> On Thu, Nov 21, 2024 at 02:34:24PM +0900, Itaru Kitayama wrote:
>> Hi Jean, Mathieu,
>>=20
>> I=E2=80=99ve been using you guys=E2=80=99 ccs/v3 QEMU for some time =
to bring up an Realm instance without a major issue, and as a one who is =
making changes libvirt to support CCA, I wonder if you could merge the =
v3 local changes under qap dir first so I can query the feature from =
libvirt?
>=20
> I'm not very familiar with libvirt, which changes are needed for =
query,
> this one:
> =
https://git.codelinaro.org/linaro/dcap/qemu/-/commit/250732e03bf0bd2e2a905=
8358707baf51d0193cb#68c067b8d3c460fb3331256759e405f48df64c73
> ?

Yes, but I wasn=E2=80=99t aware of the Kim-rme,c code under the =
target/arm. I am trying to generate C code using the QAPI so that we can =
issue QMP command like other CoCo, SEV(-SNP) and SGX.
Is this the way forward for Arm CCA support I wonder?

For now the focus is on getting a reasonable output of `virsh =
domcapabilities =E2=80=94emulatorbin qemu-system-aarch64` and getting =
virsh edit can be finished without a complain if I added =
<launchSecurity/> and <cca/>
elements.
=20
Thanks,
Itaru.

>=20
> The problem for upstreaming QEMU VMM patches is that the whole series
> depends on the updated KVM API, so until that gets merged in Linux I =
can't
> get the QEMU patches merged
> =
https://git.codelinaro.org/linaro/dcap/qemu/-/commit/bb044aeb5bf888f193b1d=
ef0a4d03de2ff8389ac
> =
https://lore.kernel.org/linux-arm-kernel/20241004152804.72508-1-steven.pri=
ce@arm.com/
> And without the KVM API we can't allow users to create a rme-guest =
object,
> since it wouldn't be functional.
>=20
> Thanks,
> Jean


