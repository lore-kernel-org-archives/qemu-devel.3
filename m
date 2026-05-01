Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62894CD3427
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 23:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIxAT-0002Sl-Sc; Fri, 01 May 2026 19:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIxAS-0002SX-Al
 for qemu-devel@nongnu.org; Fri, 01 May 2026 19:21:08 -0400
Received: from p-east2-cluster1-host7-snip4-1.eps.apple.com ([57.103.76.64]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIxAQ-0000AM-Ct
 for qemu-devel@nongnu.org; Fri, 01 May 2026 19:21:08 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-3 (Postfix) with ESMTPS id
 90B5818000B2; Fri, 01 May 2026 23:21:02 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRLEwVSB11NVg1HD1geXBQXC0dDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTA9JcCxyXnFIFDoKKQJGBkYOPB5VBCh2XQ46ci9yKAFGDzkGL3ceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777677664; x=1780269664;
 bh=ht0w5h0EOU+eBdzReEnQLFAJTueavkd7qtwKgtTeE0U=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fOVXv6t6H8lbS/4Rs24LZZnTcA08Mr1eLi/+NLAy5kzl7ebiaYvUGzqd3nFE65sDbInGZwvDpL+867agb9gaiaZz0w5MjmnZoEvwc1DVRgjOlLRJ8v/p6Mfgl7FNqBfR3gBHjJuFkUKs6D1Rnr5kBD41U4KX26k3e6cDGN/SHB/noY7yCjXIsFb2yFz4SxU392P7s+6RCPomoQGET+kgPeu3Ng4EyVMRYXQS3vcvl6FJHR4EDTHNgHxH7l52OX7ZcERY7fW18lVeHczxD9kBrIEY7S6MvH3pazeoZl2rM1vOZm0YSTEqsNF57pPISwHmtNqvSad5RrdyT6TOgD31+A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-3 (Postfix) with ESMTPSA id
 5049A180013E; Fri, 01 May 2026 23:21:01 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PULL 23/28] hvf: sync registers used at EL2
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAJSP0QUuu8Vt403H1BpsuPFcuCA4WWbvoTu_GHUg7OrbBBPdPw@mail.gmail.com>
Date: Sat, 2 May 2026 01:20:49 +0200
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <61CAE5C8-B9D5-467D-83CD-7BABEC366A5B@unpredictable.fr>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
 <20260501101505.3485916-24-peter.maydell@linaro.org>
 <CAJSP0QUuu8Vt403H1BpsuPFcuCA4WWbvoTu_GHUg7OrbBBPdPw@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=eLQeTXp1 c=1 sm=1 tr=0 ts=69f5355f
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=BGBRJ4FIzYpjLOC2vMcA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BxLMCWPJmb0E4PNMUoxj9PWEt8w_bpT2
X-Proofpoint-ORIG-GUID: BxLMCWPJmb0E4PNMUoxj9PWEt8w_bpT2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDIzMSBTYWx0ZWRfX1T0zQLdPjbwL
 oZZY1UxTKzNomVgYQ5zfh0Q4YksBGLKIil5pbjtOLK+FCL1jiD9CF4D6YmpPso5pFrAXAwELNNc
 WQkE3ouqsgKFq2SHciGT3Uhnul2Y5A6D45Bvyv1e8yRerRJ+/aCHP41MSFQAL5S47c/SNVa7jij
 S2zDaNG0MyVoYxTaXaQuEtqj1kVnRmxqwBglB5gj8AUiMSf8QvMkj9SA4lSq/ZUh4e/v/oXC0WZ
 mV0/OcTrjzKwB/CWjrsyGtP/OwfcbXqR6BkSHiVufeiG4T9nWUq7mZCDXtSv2KAzZrq210L9ASo
 oS7AJllS4ZNSn9AAXr5Q6K8GVE0z0X+62HnZBou43E3tZNudAKOYYmbO4VzIqc=
Received-SPF: pass client-ip=57.103.76.64;
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



> On 1. May 2026, at 12:59, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> On Fri, May 1, 2026 at 6:18=E2=80=AFAM Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>=20
>> From: Mohamed Mediouni <mohamed@unpredictable.fr>
>>=20
>> When starting up the VM at EL2, more sysregs are available. Sync the =
state of those.
>>=20
>> In addition, sync the state of the EL1 physical timer when the vGIC =
is used, even
>> if running at EL1. However, no OS running at EL1 is expected to use =
those registers.
>=20
> Hi Mohamed and Peter,
> Please take a look at the following CI failure:
>=20
> In file included from ../target/arm/hvf/hvf.c:497:
> ../target/arm/hvf/sysreg.c.inc:187:1: error: static assertion failed
> due to requirement '!(HV_SYS_REG_MDCR_EL2 !=3D (((((1 << 28) | (19 <<
> 16) | ((3) << 14) | ((4) << 11) | ((1) << 7) | ((1) << 3) | ((1) <<
> 0)) | 13510798882111488ULL)) & 65535))': not expecting:
> HV_SYS_REG_MDCR_EL2 !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(3, 4, 1, 1,
> 1))
> 187 | DEF_SYSREG_EL2(HV_SYS_REG_MDCR_EL2, 3, 4, 1, 1, 1)
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/arm/hvf/hvf.c:489:3: note: expanded from macro =
'DEF_SYSREG_EL2'
> 489 | QEMU_BUILD_BUG_ON(HVF_ID !=3D
> KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
> | =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> =
/private/var/folders/q_/v_6k8zks62lb0q_8f10mvn8h0000gn/T/cirrus-ci-build/i=
nclude/qemu/compiler.h:74:30:
> note: expanded from macro 'QEMU_BUILD_BUG_ON'
> 74 | #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not =
expecting: " #x)
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =
/private/var/folders/q_/v_6k8zks62lb0q_8f10mvn8h0000gn/T/cirrus-ci-build/i=
nclude/qemu/compiler.h:72:51:
> note: expanded from macro 'QEMU_BUILD_BUG_MSG'
> 72 | #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
> | ^~~~
> 1 error generated.
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/14176182142#L5618

Thank you, it turned out to be an issue with older macOS SDKs
that macOS CI still uses.=20

Did send a (standalone) patch: =
https://lore.kernel.org/qemu-devel/20260501231353.63184-1-mohamed@unpredic=
table.fr/T/#u (looks like patchew is down at time of writing)



