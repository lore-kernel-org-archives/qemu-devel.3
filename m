Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35614CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcpY3-0000Ic-Kg; Thu, 25 Jun 2026 15:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wcpY2-0000IU-FA
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:15:38 -0400
Received: from p-east2-cluster6-host8-snip4-10.eps.apple.com ([57.103.76.171]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wcpY0-0004Yy-7x
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:15:37 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id
 8E5C11803F37; Thu, 25 Jun 2026 19:15:29 +0000 (UTC)
X-ICL-RepId: 019f0035-6e1d-7128-80b9-bc3ce9c6a1f3
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0NWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjQASXcuAlwEXQtMBV8aXwRFC1UKKA8oH0V4T3BUAVwLQQ9KAS1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1782414930; x=1785006930;
 bh=0HtqdfA9qhbfqUWgONt5cJyb9k4LyqmP+9xwPT/EF4U=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Bbqo8YB4pvnp+fXJ3rTcOtEOHBZirXZyz+dIfrWgF+GqNhR9FEEkEYaONY/yR0t6hyjWd8iSzwhOpZwVU96ZGlH3bG7U6vkMRlOuY8se3197XzYupO9Ia/VC/iJiq0pFQf5IUG0v3QMOBZDTT4gf35VMlUiXDyiDMs06iE2bJvmgOoUvI9pXITtN2ULhLN4PMG3/NoHXpTB3Mwue4MjmOhkt3aWXaFX7yoy16Jn48lIt4pvcHvSnL3Phhh1kSLxg4lZeq3MuYP0m8l/hAqyJbL+pv33DlDiPB3y/FB/IOb68b40gVYWe7PiZ+9kHUyrQs95nPUQ1J7gM41w0ZQs3dw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id
 94AD01800395; Thu, 25 Jun 2026 19:15:28 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3893.100.7.1.1\))
Subject: Re: macOS builds broken in CI
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <904444A5-0120-4BE6-8E11-C7167F2A3BDB@unpredictable.fr>
Date: Thu, 25 Jun 2026 21:15:16 +0200
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D91DC576-2462-4652-9E8C-5A7C96791622@unpredictable.fr>
References: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
 <904444A5-0120-4BE6-8E11-C7167F2A3BDB@unpredictable.fr>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3893.100.7.1.1)
X-Proofpoint-GUID: 9NpvftpXHDjlkCOEO0s9KFR35HCUjE0q
X-Proofpoint-ORIG-GUID: 9NpvftpXHDjlkCOEO0s9KFR35HCUjE0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE2NiBTYWx0ZWRfX+KIOIpBqAiCG
 ycPnNuctIy6MSMweHZtTG33ceEia0Lr6tdG3h9wbnMSucAhnx+i1BAmC1KP31O7jCkXzdZzxO+W
 TeY/xDRDytdTSpsc3CDxLVgxVI2qj7txSCmR56hBR6/wQY3+4yHovle3x2HAQQt3jYS7AU7Bc73
 3sKWoXOIt0e/+EahGbWcAvy/yz2OrkBDEFrsw8zs4g1Qu7fZAY4ZjYlafps70KkZmF2Bq9wcOKU
 8tcBYQ0oxbTKaYLWOKwHCc4ZBo7F/adv9KUdSN08SRwsRgzG0eOwRnqXP/BCvQkY+qgO0moMcai
 7bqDPlkzWFgf7mQ5WtN
Received-SPF: pass client-ip=57.103.76.171;
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



> On 25. Jun 2026, at 21:11, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
>=20
>=20
>> On 25. Jun 2026, at 20:38, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>>=20
>> Hi Alex,
>> tests/tcg/multiarch/system/Makefile.softmmu-target's
>> run-gdbstub-interrupt seems to be broken on GitLab CI macOS runners. =
5
>> days ago it still passed, but now rerunning the pipeline on the same
>> commit ID fails:
>>=20
>> - Good (5 days ago): =
https://gitlab.com/qemu-project/qemu/-/pipelines/2615134022
>> - Bad (today): =
https://gitlab.com/qemu-project/qemu/-/pipelines/2629704018
>>=20
>> I've tried many CI runs with different pull requests applied on top =
of
>> qemu.git/master and they fail in the same way. Maybe it's an
>> environmental thing with the macOS runners?
>>=20
>> It's unclear where the SIGKILL (Error 137) comes from. Could it be an
>> out-of-memory condition on macOS runners?
>=20
> Hi,
>=20
> SIGKILL is the known symptom for failure during signature verification
> by AMFI.
>=20
> Now that we don=E2=80=99t have separate -unsigned binaries anymore but =
relying
> on in-place ad-hoc (w/o certificate) signing with entitlements we =
might
> have issues linked to that.
>=20
> In the past file modification had issues with verification tied to the
> inode and the workaround being a reboot or a cat binary > new_binary;
> chmod +x new_binary so that the old (now out of sync) signing state is =
lost
>=20
This is highlighted in the software update context in: =
https://developer.apple.com/documentation/security/updating-mac-software

> This code is incorrect because it modifies the command-line tool=E2=80=99=
s executable file in place. macOS caches information about the code=E2=80=99=
s signature in the kernel. It doesn=E2=80=99t flush that cache when you =
modify the file=E2=80=99s contents. Modifying the file in place yields a =
mismatch between the file=E2=80=99s contents and the in-kernel cache, =
which can cause a hard-to-reproduce code-signing crash the next time you =
run the tool.
> While this example uses a command-line tool to demonstrate the issue, =
updating any file that contains signed code might trigger this =
code-signing crash. That includes executables, frameworks, dynamic =
libraries, and bundles.
> To update a file that contains signed code without risking this crash, =
write the updated code to a temporary file and replace the existing file =
with that temporary one:


