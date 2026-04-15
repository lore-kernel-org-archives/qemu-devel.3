Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E000F43824
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 14:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD1GM-0000jB-JT; Wed, 15 Apr 2026 10:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD1GI-0000hP-6b
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:30:38 -0400
Received: from p-east2-cluster6-host1-snip4-10.eps.apple.com ([57.103.76.181]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD1GE-0006Y7-Qz
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:30:37 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id
 02C90180037E; Wed, 15 Apr 2026 14:30:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776263432; x=1778855432;
 bh=ICu7ZGHxMud+D8wf+7zf+7R4yABri7DrwnMk/kW6/QA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=DvFGwIC5R46QeDp4qaKbDxtrOSCFS6d3Az2+asfiCnTRIhOVriSdBmiv38QqsJi6jB1t6uqB/Xh1f2yhT6B5m09acpqtTDayMsoWycWzKEzxqMFQi2nh65TspS43Sr0xBdjBQ6p8FtAm1P54mjJBUpVn2Lx2MLgUJ2ntbMR3teUPBNQXs3NzjUXoayCQENw2AJTqZhFQaqPVMHpSbbJdFQ8V2NLSm/3SUVZFpxVyFLQTujnRxoxBG/z6BLFkchsjebLCUdlQmjLXYo3++jIT6P3QA8dvhaBWNeYUA6tZSyamhpWDe6stLtmkPXavHRCa7lFSHnPbE21m0UE8opzreQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id
 94563180191C; Wed, 15 Apr 2026 14:30:22 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v4 8/9] target/i386/mshv: filter out CET bits in cpuid
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <ad+eOA8gz26GBgzD@example.com>
Date: Wed, 15 Apr 2026 16:30:10 +0200
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Wei Liu <wei.liu@kernel.org>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC49AF2B-9E21-47BF-BC92-531F77606D14@unpredictable.fr>
References: <20260414155433.483186-1-magnuskulke@linux.microsoft.com>
 <20260414155433.483186-9-magnuskulke@linux.microsoft.com>
 <32594f82-0268-4844-830a-4147bd1598f6@redhat.com>
 <ad+eOA8gz26GBgzD@example.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEzNCBTYWx0ZWRfX4o2+mlpixPNc
 O4JwWcyhmaJ9bKyAqdmUAO5akHBCy/ibQvMdB6kaHwIBc0UCVyuqMH8G1/Up/49iZXHmjxM68lS
 A7x+IacXRDrADzu18I9SMIFekp03pWZ0LHraozjyOLFtuimhwz7/vxE2FxsCGEVRzZ7mxvd5RaQ
 sEASaj56ZTrZbUNKk6NOUQbqtwyW9N/xMfZ4vS/MgGPR1c3aZNdWPQkSocQj7rS7FmkL4u3preJ
 k+W29D4tzU1qCr1MMerxc2DvLtGY/UWEqbMnM5wI2mauUnKsiYTkNM4XmGPgbeFRZVvBkn+ERt5
 6MyfUNu+9MKwb7B4hgr/W37BgZmUJD9xDOvAlylWetB/mFxn7TyOfSNryequ/w=
X-Authority-Info-Out: v=2.4 cv=HNLO14tv c=1 sm=1 tr=0 ts=69dfa106
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=vrMa2spNJQEUmAP-M0IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UMzBClDkeawbQb6nXUFUXKrXaWYKkP9p
X-Proofpoint-GUID: UMzBClDkeawbQb6nXUFUXKrXaWYKkP9p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604150134
Received-SPF: pass client-ip=57.103.76.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 15. Apr 2026, at 16:18, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> On Tue, Apr 14, 2026 at 06:10:19PM +0200, Paolo Bonzini wrote:
>> I don't understand this, but it seems to be a Linux bug.  Don't *all* =
xsave
>> features cause changes to CPUID[0xD,1].EBX?
>=20
> oh, you're right, thx. the CPUID[0xD,1].EBX responses (also =
CPUID[0xD,0])
> returned wrong responses in all cases the introduction of CET in QEMU
> probably just triggered some overflow, but it was broken before.
>=20
> We cannot statically register size responses for xsave features that a
> guest can dynamically enable/disable.

Hello,

Is CPUID performance such a problem?
>=20
> I was planning to implement a dynamic handler for the xsave size
> responses anyway, but maybe there's an easier way: We can provide an =
ebx
> mask =3D 0 in the payload when we register the cpuid responses at the
> hypervisor. If we do that for CPUID[0xD,{0,1}], the hypervisor should
> return the answer based on the guest state (XCR0,XSS).
>=20
> I'll test this approach and probably post a new revision with one of
> those options.
>=20

What I have from WHPX on this - where for now CPUID vmexits are used=20
instead of this fancy interface* - although that might change in the =
future:

Those have been seen to vary dynamically for a vCPU:

CPUID[1:EDX].APIC
CPUID_7_0_EDX_CET_IBT
CPUID_7_0_ECX_CET_SHSTK
CPUID_7_0_ECX_OSPKE
CPUID_EXT_OSXSAVE
The whole 0xD leave

I used the default result to override with the Hyper-V stock response =
for those bits,
although masking as provided by the new interface would work too.

* not using it yet because Windows 10 Hyper-V didn=E2=80=99t have it, =
and the perf impact for CPUIDs
 didn=E2=80=99t sound like an actual problem so trapped as much leaves =
as it could make sense




