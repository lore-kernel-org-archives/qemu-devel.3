Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5740CDE009
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcpUV-0007Zm-3s; Thu, 25 Jun 2026 15:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wcpUT-0007Ze-Bm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:11:57 -0400
Received: from ci-2001e-snip4-11.eps.apple.com ([57.103.91.43]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wcpUR-00043T-AM
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:11:57 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 7B3CB1800174; Thu, 25 Jun 2026 19:11:50 +0000 (UTC)
X-ICL-RepId: 019f0032-162c-7ab9-a0bf-709f783e8da6
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0NWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkkJTAdZAyoHXQlJAV0aX3A1D1ULKAZaHzMOSQVacVlzQ3s8cS1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1782414711; x=1785006711;
 bh=k3bHai5MsnNhoA2je+/j+0yK5JXYzMI84mdg/RNZtMQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=KCZOpoZXEU3qWLTFZmzBmDgzGMm0ZgmR8c5iHkTrq0qD7rhNx1xtqsIzl1Y3gLO8S2Lcrj7eACpMrzPgwUlT2a3R+BJHe+bSB8A9be+q/ewuwEiwE3V1RfC9G91F3Rq+AOjfbBHTHfON54yBvrqg/9DPY7RQZrak5Jk3LuXEo3qT1hklEAK+j1350DLTpbQmY6T5hHkTUqfH+Trup5mYPei6IVWpWjssnz+UiRRRSMn2wW/gTbP1lmV4UB5rHaLj+chfLJxAIWTik2DRzJ+/1U6uW9Ie/nKGB2N2dD2fp3dwyy2svQMfvhDOfUBSRSa8+qQF1qIYLmKZkK5PfwIBeA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 486481800A09; Thu, 25 Jun 2026 19:11:49 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3893.100.7.1.1\))
Subject: Re: macOS builds broken in CI
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
Date: Thu, 25 Jun 2026 21:11:36 +0200
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <904444A5-0120-4BE6-8E11-C7167F2A3BDB@unpredictable.fr>
References: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3893.100.7.1.1)
X-Proofpoint-GUID: zOMPS6Nxnjd2Yo1DOLno2Gt6_KuTD5ID
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE2NSBTYWx0ZWRfXx1IUjLvJ9EOz
 /9N4zu3QcylhaLRBbBb6pVnftwRlLcTUVxh5Bgjd2HGvi59P0D4jVHYBLOl9d8WhEda8/Azt+ju
 8bJ74GZ/Lbidz7u8VzVCWgYXLq66pi3274qEHKsJf+xBmvtIBoxCBWPdGtWF3hSFLorkFaOCnJf
 qAoTE36NPk9RN4OrHJRyt5tG6N5YtGkxlsVHWEvEV229bxNRZZ+YMtM4cIHrsrjbHKfzWP3DxbH
 iu0NVp1KOMWdUluxuMDlPBUj69N+srM6GIP5A1c5dWmFiKTZoi08p6i4xJQHZjMucuukEPHu8bl
 z73oZso4yV8baG0rrns
X-Proofpoint-ORIG-GUID: zOMPS6Nxnjd2Yo1DOLno2Gt6_KuTD5ID
Received-SPF: pass client-ip=57.103.91.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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



> On 25. Jun 2026, at 20:38, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> Hi Alex,
> tests/tcg/multiarch/system/Makefile.softmmu-target's
> run-gdbstub-interrupt seems to be broken on GitLab CI macOS runners. 5
> days ago it still passed, but now rerunning the pipeline on the same
> commit ID fails:
>=20
> - Good (5 days ago): =
https://gitlab.com/qemu-project/qemu/-/pipelines/2615134022
> - Bad (today): =
https://gitlab.com/qemu-project/qemu/-/pipelines/2629704018
>=20
> I've tried many CI runs with different pull requests applied on top of
> qemu.git/master and they fail in the same way. Maybe it's an
> environmental thing with the macOS runners?
>=20
> It's unclear where the SIGKILL (Error 137) comes from. Could it be an
> out-of-memory condition on macOS runners?

Hi,

SIGKILL is the known symptom for failure during signature verification
by AMFI.

Now that we don=E2=80=99t have separate -unsigned binaries anymore but =
relying
on in-place ad-hoc (w/o certificate) signing with entitlements we might
have issues linked to that.

In the past file modification had issues with verification tied to the
inode and the workaround being a reboot or a cat binary > new_binary;
chmod +x new_binary so that the old (now out of sync) signing state is =
lost

>=20
> I am ignoring the macOS builds for the time being and continuing to
> merge pull requests.
>=20
> TEST memory-sve on aarch64
> TEST softmmu gdbstub support on aarch64
> qemu-system-aarch64: -gdb
> =
unix:path=3D/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmporwqcbrdqe=
mu-gdbstub/gdbstub.socket,server=3Don:
> info: QEMU waiting for connection on:
> =
disconnected:unix:/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmporwq=
cbrdqemu-gdbstub/gdbstub.socket,server=3Don
> qemu-system-aarch64: QEMU: Terminated via GDBstub
> TEST softmmu gdbstub support on aarch64
> qemu-system-aarch64: -gdb
> =
unix:path=3D/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmpkfurbf2mqe=
mu-gdbstub/gdbstub.socket,server=3Don:
> info: QEMU waiting for connection on:
> =
disconnected:unix:/var/folders/fc/8_hzw5tx3n7c9c04tzd6tv_40000gn/T/tmpkfur=
bf2mqemu-gdbstub/gdbstub.socket,server=3Don
> gmake[1]: *** =
[/Users/gitlab/builds/qemu-project/qemu/tests/tcg/multiarch/system/Makefil=
e.softmmu-target:35:
> run-gdbstub-interrupt] Error 137
> gmake: *** =
[/Users/gitlab/builds/qemu-project/qemu/tests/Makefile.include:75:
> run-tcg-tests-aarch64-softmmu] Error 2
> WARNING: step_script could not run to completion because the timeout
> was exceeded. For more control over job and script timeouts see:
> =
https://docs.gitlab.com/ci/runners/configure_runners/#set-script-and-after=
_script-timeouts
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/15038503463
>=20
> Thanks,
> Stefan
>=20


