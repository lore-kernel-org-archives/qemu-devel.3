Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F44FED2CC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 05:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0YTI-0004Br-O3; Thu, 12 Mar 2026 01:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0YTG-0004BO-T7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 01:20:30 -0400
Received: from p-west3-cluster1-host6-snip4-3.eps.apple.com ([57.103.73.184]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0YTE-0004PL-KX
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 01:20:30 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-1 (Postfix) with ESMTPS id
 A84B9180010A; Thu, 12 Mar 2026 05:20:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773292826; x=1775884826;
 bh=yS6B1JcGDx10bvOoiJSRSPM5/ujtdqwQkneRnD5xcn0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=em8z0RfgfntSNRQqdao2UDSRBk6rIVn3BjAtlFk15vYAEkWK9XNviwsbe1uUPpb5kOqWv5jHnazaW8eYemMHu+qstgM62SzF6cVuhh8C1Fvx6hmNnzb5tIzN/68RWWt8nmvjTFhpnmNjTmKvvZj5tdPxbWklyYH6Y70WZJFEyKVC2QbOnzGLVPXmB298fkmpHfoa8zJlNZ4I1uAGoQIVlwHokz0yqltSYDfk7XHB1zcjKjlPRGMrexOWtXfPVx4AU6p3+gJSyNu2vBPYYINU0QhVFBra58wOAXAdooAdD1/U0Y8bvodLptGoiGcu6cHoBUwrw0HdBFKntFip7bBfeA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-1 (Postfix) with ESMTPSA id
 05E101800107; Thu, 12 Mar 2026 05:20:22 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 00/14] Add ARM64 support for MSHV accelerator
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260311171240.GB3612627@liuwe-devbox-debian-v2.local>
Date: Thu, 12 Mar 2026 06:20:10 +0100
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>,
 qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FE1FA7B-653C-4088-8F27-BCE249F50FEB@unpredictable.fr>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <877brii9wq.fsf@draig.linaro.org>
 <9D4583F5-0591-473F-8FFA-1EDF416AF447@unpredictable.fr>
 <20260311171240.GB3612627@liuwe-devbox-debian-v2.local>
To: Wei Liu <wei.liu@kernel.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: WpRlXmd8LFi4KilxbHtTlFkU-AR7_wuC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA0MCBTYWx0ZWRfX7WO+7PVTrK4h
 MB7/D+Y3nXMaTZWntWrq6bRYFCUAJMLySPWW9eTlOSb7w1jkyHjASCan38GhVzv8vDTrPNvAWHM
 JiuxKZ8sTcoOHG195EMlesXZVuPBrRrcF8rNaggO8UahmKgxOoZ54mElzbe82L8695qFEKMzpT/
 KbxhJzDxgTwIbZGH7LF4XJk5ZQxcg0EYdWNGiHymnpCZYVPDlhC5P/xFXCFZqtJl1n+gwd3Ulxo
 9qIvlfhjfZYUOnQxhDfxYWaoNL8ffyzDAS9zTe5cLFNvvElOOFeVPviVwpvD7cPqrlWEv+NKlJ/
 ba/Xs5I3pdj5WS6QFVw0DDNai1tG6SAEJo5VjgHW5/YluCgZUN9L3usFYYZp54=
X-Authority-Info-Out: v=2.4 cv=L8oQguT8 c=1 sm=1 tr=0 ts=69b24d1a
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=tFGNSmrwAAAA:8 a=-5Xdn_xT0vs44axsZl0A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=LpD6Tdepsyerr7eS-Jg7:22
X-Proofpoint-ORIG-GUID: WpRlXmd8LFi4KilxbHtTlFkU-AR7_wuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603120040
X-JNJ: AAAAAAAB53zLdxb5vE+fVO9XxR3A6MurhHwySMffiad+CQoB3hw+43ikxu72ytIIeGq23V/X/HXR3BF7nH+hYaH+l5Mbwe+HpfibG64AoKtKd9ivhosB2QkBQa3jDsAYFFmHzi8oLNRmK3Ym8SfsB/H/9tGX6i8ufz3F9vzQYecPlBUWNwhPOi5NGbyrTsQpNSFIaCPHeRYY5T28nRHSTNQ8rB+ZSgni2DbkVQ1ypGTuf9tkat4/62jtCs2IzAx4VjVOyDAyl7xUpk59DlnyymnPzebfIeSaE6zGp+zATvvuBtGwAYfidx6DIz89drudSqm2j/RUQ74QW2Lqm5UMAQVr/GBgWzVImx7fkiOaIptXtIZtUBiFIiWj3nD4Mx6oYNUcbY9M4fDSPjp/u/k926skDrdvh4Fwn9yEXQIRSTCs9xyVvpWiyEQ+CfKfnlXa7tIpCtg59prCVTBYWVvxhXLBU4hjl8Yhbw/urL1ndTlKI3FcHnD8/hm6wpjKRkRbHDUf+3dEsa5z9wgR0k4OqpNoqtz9yO3BDc/b7taCKwqRYDP0FUv3lTiWeH2NVHRmgKXiFgo1YRHbxyMYrEsfUO13WoocMsmEbpTaa/pXIbt7TpXiPfoha4qXWI9Kq6oX7vHjKoSdmSVMkbWdjAMZhXxmiwkuY2b5LPOp1cD7gTfjeD9tqVKlLRn+viUXyUCcpNHjA8iSaNNHVUFMoHRi3d5VwGw8KQYeXkJMigmYoEW3QVArIj614GDUqYJYWpedZEsPXn1MO6+pCF8tpnQ57P2qSE8q
Received-SPF: pass client-ip=57.103.73.184;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 11. Mar 2026, at 18:12, Wei Liu <wei.liu@kernel.org> wrote:
>=20
> On Wed, Mar 11, 2026 at 06:02:26PM +0100, Mohamed Mediouni wrote:
>>=20
>>=20
>>> On 11. Mar 2026, at 17:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>>=20
>>> "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com> writes:
>>>=20
>>>> This series adds ARM64 guest support to the MSHV (Microsoft =
Hypervisor)
>>>> accelerator, enabling QEMU to run aarch64 VMs on Microsoft's =
hypervisor
>>>> using the mshv Linux kernel module.
>>>=20
>>> Does GitLab (or anything we plug into it) support runners on Arm64 =
with
>>> HyperV and a Linux Dom0?
>>>=20
>>> I looks like we would need a dedicated runner to defend the
>>> functionality on CI.
>>=20
>>=20
>> The MSHV license doesn=E2=80=99t allow for any use outside of Azure =
Kubernetes Service,
>> despite MSHV (for x86) being public.
>>=20
>> And Dom0 is technically not required as there=E2=80=99s L1VH, but =
that=E2=80=99s even less documented to
>> the outside and not set up for more local use - but hopefully will =
make its way to Windows=20
>> client at some point :/
>=20
> Direct Virtualization (the marketing name for L1VH) will become
> generally available on Azure at some point (hopefully within this
> calendar year). I am not sure about Windows client though.

Hi,

Could you ask if it=E2=80=99d be possible to have Windows client as an =
L1VH host, if even just Insider builds?

Either as a Windows Hypervisor Platform privilege (even no save/restore =
is okay, just being able
to enable the privilege is good enough for testing), or through HCS for =
WSL2 (or just Hyper-V VMs)?

Because at this point that=E2=80=99d solve the testability issue=E2=80=A6

Thank you,
-Mohamed
>=20
> Thanks,
> Wei


