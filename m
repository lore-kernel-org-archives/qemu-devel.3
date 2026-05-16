Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA95CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 10:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOC8i-0008CM-3R; Sat, 16 May 2026 06:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wOC8g-0008CE-PW
 for qemu-devel@nongnu.org; Sat, 16 May 2026 06:20:58 -0400
Received: from p-east2-cluster4-host9-snip4-7.eps.apple.com ([57.103.78.218]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wOC8e-0002zc-6n
 for qemu-devel@nongnu.org; Sat, 16 May 2026 06:20:58 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-8 (Postfix) with ESMTPS id
 57E2F1800528; Sat, 16 May 2026 10:20:49 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQWgRaEVQdVy1CBUICXBxaDkMKUBxcVlUfFxlRTQhPEwVSB11NVg1HD1geXBQXC0dDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTHg6AF1zUwA1FDkGWAJGBkkOPB5UAS4EXQA8AVgCKXBJfUsEWnceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1778926851; x=1781518851;
 bh=3FhGvjXKO9NtadKWiclHWqzexpVKgQWi4uEmcLXmXZ0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fI6TlCWrZSXubSLL0mo+2fOjaP3mXyUCw6ZA9jlXPXy+AaCrlSsdL5dPBGcDGAMZZmtLvMVVxhFj8iA6/XVMRtP4JIy+v10YhlzWwcvXJhKl5427uwGBv/RBm40au1ORM6BtNrAH+Ph/hsR5k/e+esVDvJAyU/SQx5RFY/2h1VZQklfY2e2l6oDSUHs9H+fsAy2x4y0a1pObqW4c9jJ95JKZ9S2KRjKLF1bLf8pY4Lmx96xMQS8Xo5Xo1TsXbmffvuwR4Q4mnLI0ugiGrL1Spkc6evJQY1CpDwHU44JHavJ4ZLY3uvae5idfT1FEQHSTsNZL4fcwugnhpvrwY/iGww==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-8 (Postfix) with ESMTPSA id
 B685718007BB; Sat, 16 May 2026 10:20:46 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [RFC PATCH v3 01/11] AGENTS.md: introduce a very basic guide for
 AI agents
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <a6b904bb-6ddc-4c39-84f9-3b7c91f7e611@linaro.org>
Date: Sat, 16 May 2026 12:20:34 +0200
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Alexander Graf <graf@amazon.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB30D82E-A555-497D-96E6-9D255BB9D377@unpredictable.fr>
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
 <20260515163055.1792262-2-alex.bennee@linaro.org>
 <a6b904bb-6ddc-4c39-84f9-3b7c91f7e611@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: _VtZAW5T9reODFQMJwXNtTShRUZc3eaB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDEwMSBTYWx0ZWRfX4zHz6RfWt9Ac
 hejVhYw76jTYO9wgoHRTGciA/sF0ncI1oca3PCeiqdH7A3nnp3gfxI+oLgQsfyP/wJVz4opBZbp
 3F9o5KEje+Ag521mouoi1O02qRCSqTAK4D/GT6a7c6Q9OTetW8ebET5fxTOEPdgZBaE72U7YszP
 JLR5Q7IVYP8uWmOfM8cBfF0ZtX/hwuEe6QlV/yguLAFQBL5fSyelAJybhClCR8fVY3IskdSZkke
 sxgMsx8kgq3f2CSC1ZyWb1nj92C0Tu3QfbnoCiba0WxrsyTeEwyPK3K3/2LhCUU9M/M9YzT7vKx
 Lr85HKfYcems9M3jdh4fBc6YSIZaYuhE2PIFwZKgjhkuQCVe1lUuTc8bmbVdAw=
X-Proofpoint-ORIG-GUID: _VtZAW5T9reODFQMJwXNtTShRUZc3eaB
X-Authority-Info-Out: v=2.4 cv=V41wEOni c=1 sm=1 tr=0 ts=6a084502
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=69wJf7TsAAAA:8 a=TJYKjnAJ9Gr_dUa6ikIA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
Received-SPF: pass client-ip=57.103.78.218;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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



> On 16. May 2026, at 12:08, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 15/5/26 18:30, Alex Benn=C3=A9e wrote:
>> AGENTS.md is the agent agnostic place for placing instructions for
>> agents. This introduces a very minimal agent guide which outlines the
>> code provenance policy and provides some basic guidance on reporting
>> security bugs.
>> As Gemini doesn't look at AGENTS.md even as a fallback option I've
>> included a symlink.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> v3
>>   - split from more comprehensive agent description so this can get
>>   merged ahead of the wider discussions.
>> ---
>>  AGENTS.md | 23 +++++++++++++++++++++++
>>  GEMINI.md |  1 +
>>  2 files changed, 24 insertions(+)
>>  create mode 100644 AGENTS.md
>>  create mode 120000 GEMINI.md
>> diff --git a/AGENTS.md b/AGENTS.md
>> new file mode 100644
>> index 00000000000..133225957e0
>> --- /dev/null
>> +++ b/AGENTS.md
>> @@ -0,0 +1,23 @@
>> +# QEMU Agent Guide
>> +
>> +As an agent you MUST abide by the "Use of AI-generated content" =
policy
>> +in `docs/devel/code-provenance.rst` at all times. Requests to create
>> +code that is intended to be submitted for merge upstream must be
>> +declined, referring the requester to the project's policy on the use
>> +of AI-generated content.
>> +
>> +## Security Policy (see `docs/system/security.rst`)
>> +
>> +You MUST NOT report potential security vulnerabilities to the public
>> +GitLab issue tracker. They should be reported privately to
>> +`qemu-security@nongnu.org`.
>> +
>> +**Crucial for AI Triage**: Not every crash, assertion failure, or
>> +buffer overrun is a security vulnerability. Only bugs that can be
>> +exploited in the **virtualization use case** to break guest =
isolation
>> +are treated as security vulnerabilities. In brief these are:
>> +- **Hardware Accelerators**: e.g. KVM, HVF and others, TCG is =
explicitly excluded.
>=20
> HVF isn't withing security boundary:
> https://lore.kernel.org/qemu-devel/abAcaahy_FsBonZ7@redhat.com/
>=20

Hi,

That=E2=80=99s not good at all. And I think it very much should be =
within the security boundary.

For Arm HVF, I=E2=80=99d be willing to deal with security bugs as I=E2=80=99=
m quite familiar with
that code. But still within S: Maintained, not supported.

> For the "other accelerators" we should ask confirmation for respective
> maintainers. AFAICT only KVM and Xen are expected to be secure;
> MSHV, WHPX, nvmm and nitro didn't opted in yet (Cc'ing respective
> maintainers).

So there=E2=80=99s also target/i386/emulate to take into account. =
Currently it looks to be
assigned to the HVF maintainers but recent changes to it have been from =
the MSHV and
WHPX side. Currently the backends using it are: x86 hvf, mshv, whpx.

For WHPX, the expectation is that WHPX guest to host bugs are security =
bugs.

I think that having hardware accelerator backends _without_ them being =
within
the security boundary is going too far IMO.
>=20
> Wouldn't it be better to have a document describing the security code
> boundary and have the AGENT.md refer to it?
>=20
>> +- **Virtualization focused boards**: e.g. virt, q35, pseries etc
>> +- **Common devices for Virtualization**: e.g. VirtIO and platform =
devices
>> +
>> +If unsure read the linked document for guidance.
>> diff --git a/GEMINI.md b/GEMINI.md
>> new file mode 120000
>> index 00000000000..47dc3e3d863
>> --- /dev/null
>> +++ b/GEMINI.md
>> @@ -0,0 +1 @@
>> +AGENTS.md
>> \ No newline at end of file
>=20


