Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164CDEBFD38
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCEwE-0004Zn-3m; Mon, 13 Apr 2026 06:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCEw9-0004ZZ-CB
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:54:37 -0400
Received: from p-west3-cluster3-host2-snip4-3.eps.apple.com ([57.103.72.164]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCEw5-0005b4-QM
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:54:37 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-11 (Postfix) with ESMTPS id
 00445180010C; Mon, 13 Apr 2026 10:54:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776077669; x=1778669669;
 bh=Vy/FaAGWV2WQVt3b0s5zjxx/Dt+f2YrqzXJiz7/npJA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=GUpSZoxh0783byJdQBnvffUPxqd/jSxi1x+7Zr/BFgSE6ZqbRe2YUuVgEssxVbFmisxlvVu3BnwpXs382ZmECL9WHLgfgqnphb9G2oTNCLXtiaNf8gAGSO3X3fRTEaHQMJlyCrrY/x9WEbPffRT3TNYYOUa7PSl4Fm7jxjHyo7neYlsBtawgitd+IRvKGZtdud+0UoZQ2Hq27F1RsKYQHv2DFWR+YKCCmppogWEUfHbUdRgq4xAQzKx0Qh61geYam8QFsTQEBpQ8fFcTK10UnCFW2kZt45gE7sYVEdrHOfjKzXEvuBMZNb45gsCvsYrCztVcYtlGwFl13ADbPHfqCA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-11 (Postfix) with ESMTPSA id
 E556D180012A; Mon, 13 Apr 2026 10:54:26 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: Cirrus CI about to shut down
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <87ldert9vi.fsf@draig.linaro.org>
Date: Mon, 13 Apr 2026 12:54:12 +0200
Cc: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <635C476A-FCA8-44C5-ADA7-A2E18EF15665@unpredictable.fr>
References: <b8a73eb5-aa21-481b-9120-aa6277492b26@redhat.com>
 <CAJSP0QXJs33g1=yG9c5KSWzdsVpxmF-zSs=xQpPV-hn7rR5giQ@mail.gmail.com>
 <7d223288-dab5-48d3-940a-f4a3ac252d0c@redhat.com>
 <87qzojtbuv.fsf@draig.linaro.org> <adzAhSbs21GGVCUv@redhat.com>
 <87ldert9vi.fsf@draig.linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: YA_q3KE7bKIsj3jNN1Fpy8i4D2zDq2O5
X-Proofpoint-ORIG-GUID: YA_q3KE7bKIsj3jNN1Fpy8i4D2zDq2O5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNyBTYWx0ZWRfX23E2fsfo/cPj
 nli+1iM2gLwtWJrhtDVjPoyuHNOGZJfyz3zssyt4WXnsOSnw/1V/RbVfjIOK6aYUDmeBHB7OFjj
 clZW2yXq6ZBEcI707YfIuOgrdp3leZW3OOG0XHdKtWCGjs9lqY7Pgqs2mrsksOjgG2W295uc/qo
 lAAb24ulBT56nmgIO/SCWoBvjNHuqUKsyl7HpEOvoixrThWSilqDl0ap98s6kq7bNyUSnEVmASF
 mU8UzxvceAJXrXEyxbOj4G0VNbxX6wE5Zg339bU6eR97asVIK2C9WXhXZa7Ym69IjF9I2npfvds
 j4QhkKl+9Yziq6L243MF9u60ppaSI2fueRo17EVlnGgazWpEvJaU8uV/ZcD20M=
X-Authority-Info-Out: v=2.4 cv=AdW83nXG c=1 sm=1 tr=0 ts=69dccb65
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=xTzdydv0GPGeQcyqNc8A:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=792 spamscore=0 clxscore=1030 mlxscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130107
Received-SPF: pass client-ip=57.103.72.164;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



> On 13. Apr 2026, at 12:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
>> On Mon, Apr 13, 2026 at 11:04:40AM +0100, Alex Benn=C3=A9e wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>=20
>>> Not sure what to do about FreeBSD though. Ideally we want hosted =
runners
>>> so we can exercise the hypervisor (ditto Windows x86 and Arm).
>>=20
>> For the various BSDs we have  VMs for QEMU builds, which (in
>> theory) we could run from regular gitlab Linux jobs. Running them
>> with TCG is rather unpleasant though. Do our private upstream
>> runners have nested-virt available to let us use KVM ?
>=20
> We don't have any custom x86 runners, I have no idea about the cloud
> ones that serve the bulk of the CI jobs. I assume the AWS EKS machine
> wouldn't by default.
Hi,

EKS doesn=E2=80=99t expose nested virtualisation today, only direct EC2 =
as an opt-in
for *8i instances.

Windows is a bit of an oddball but is supported with the nested virt =
support
on AWS, but as I=E2=80=99ve been out of sync with that for quite a while =
can=E2=80=99t tell if
what shipped supports MBEC.


