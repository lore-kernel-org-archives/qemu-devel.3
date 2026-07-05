Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55982C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 06:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgFyA-0002gx-Uc; Sun, 05 Jul 2026 02:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wgFy6-0002gO-Mv
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:04:42 -0400
Received: from qs-2003h-snip6-11.eps.apple.com ([2a01:b747:3006:204::53]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wgFy4-0007lQ-VK
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:04:42 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPS id
 D35A430000BC; Sun, 05 Jul 2026 06:04:35 +0000 (UTC)
X-ICL-RepId: 019f30e0-f077-788d-a2fa-17cc298ccb57
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQBYWwhbBA8fTAxRAkIFVl5ICx0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQVVkNUBF9QVBFXUAtadDYOOgFbBEZ3MgpPHllyL3Bdez4HKxovcEAJQQNdD1wHSAk4XggZCF0dB1hHFEcODxlaFFwYUw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1783231477; x=1785823477; bh=s3w2vZ1Di5f0vhuefBbUobWi3uLpIUkppQ6EJfUfBjw=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=KduHOnJTYTxGIzz9xaJRxFqmzcaonIqrb2wkQeyVAdKZpPyhnYJcDMTfuy3asbOLL42nozPN2FEOVTeYERFcwdOaDqQFDCGIeXsW8w5Rs1qJz+iviBlsFXoLqNtqPqmcwzh9Pqt/7KuwMRCtlzWOdmA/NaBGLUhJEtWpyqG5+BpZBTQPjjYHtxPVwGXGMzoTpTYNY+PaXAHClS582+tYk57bpDTsfphaug+HWA7Wj6w7MhJcoX7k48LTi7lJI352d6HQ6UQ/ihbEn2f4HjqbIS09vWxdx4Ko/hyQs59YUxj8njEi9mZoann1lPUDB3fTObIS7YIELPmE7TgmnCB9Nw==
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPSA id
 364B6300011A; Sun, 05 Jul 2026 06:04:35 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: [PATCH v3 1/5] hw/block: add Sony/Apple "SuperDrive" diskette
 drive
From: Matt Jacobson <mhjacobson@me.com>
In-Reply-To: <4ac46a1a-4125-c792-1d6c-9ccd204d6ed4@eik.bme.hu>
Date: Sun, 5 Jul 2026 02:04:33 -0400
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FF7B263-EB37-4EDB-BF4F-DB0090087580@me.com>
References: <20260702022927.46510-1-mhjacobson@me.com>
 <20260702022927.46510-2-mhjacobson@me.com>
 <4ac46a1a-4125-c792-1d6c-9ccd204d6ed4@eik.bme.hu>
To: BALATON Zoltan <balaton@eik.bme.hu>
X-Mailer: Apple Mail (2.3696.120.41.1.10)
X-Proofpoint-GUID: 75XvlyeJXjM3P8L7fnWSGpGU66nHKMqc
X-Proofpoint-ORIG-GUID: 75XvlyeJXjM3P8L7fnWSGpGU66nHKMqc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA2MCBTYWx0ZWRfX75OkvMOJhX30
 RS8im9qb2NP1oe3ghw0/LeI23nxUF0ZMmU8QZcPDfsdf0y4aD+WYZUGp3M3bAQtkiQ21R6gZnlY
 BkGZy+Z2f11OXubJlTeUteL0Zn1eycjLx5m0oudqQHTAx9a09HgG/mVuv1+hmYtOU6b9AjBAcHk
 +sAkh8GnwhaIhtDRHZhambAKTzB3/KvIf5mxuU0B93rYyq7YWIWASqYFCkxuQWzfI/Kn0xLPJtZ
 tcfLpZjGBJeg134D63Pnf9Og2HDdP67ZKZZNULK7IRWULYwqkhhXZkauACLArc3W3qdapx7OI4b
 TFY3FSE2ASjlxAu4xCU
Received-SPF: pass client-ip=2a01:b747:3006:204::53;
 envelope-from=mhjacobson@me.com; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On Jul 2, 2026, at 8:53 AM, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>=20
> On Wed, 1 Jul 2026, Matt Jacobson wrote:
>=20
>> For GCR, the emulated drive encodes the BlockBackend's data in the =
Apple
>> GCR format and exposes it to the controller via =
sony_drive_read_byte().
>> The bytes are decoded not by the controller but rather in software by
>> the Macintosh ".Sony" driver.  The drive also adds the sync bytes and
>> addressing marks that software expects.
>>=20
>> For MFM, much less encoding is needed.  The sector data passes =
through
>> from the BlockBackend unmodified, and the drive only adds sync bytes =
and
>> addresssing marks.
>=20
> Maybe these last two paragraphs explaining theory of operation could =
go in a comment but which is easier to see than looking up a commit =
message but I'm OK with it either way.

Will do in v4.

Thanks,

Matt=

