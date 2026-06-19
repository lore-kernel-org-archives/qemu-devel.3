Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B415BCD98F8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waTg8-0003mg-7A; Fri, 19 Jun 2026 03:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1waTg6-0003mE-D9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:30:14 -0400
Received: from p-east2-cluster6-host9-snip4-8.eps.apple.com ([57.103.76.199]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1waTfy-00088B-DL
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:30:12 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 0918E18000B9; Fri, 19 Jun 2026 07:29:43 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQ5YWwhbBA8fTAxRAkIFVl5KDB0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQVVkNUBF9QVBFXUAtfd0INQHVdAEYHQgpJHll1WHBde08KLhpfcEQBSnUpc10AMXw4XggZCF0dB1hHFEcODxlaFFwYUw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1781854186; x=1784446186; bh=Z1cE7nSuAUzlZMpNMMOdF9JuGer33+ZsLEOu+LYChMc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=OkJczO1IJ3UFRHdeOY7foKsN0nufXasvyHm/uPMHiLFrMw5gMrm/Etdn15zBnS8oPX7OuqnuMNu+xWvhkwfpTSGNbgjZDqf/M+2gKcOYjOYlvQkuoSDazwd3w3/Cusz+b4i6G0VRwxvOWknr61y8TJmsgEd29fV8e3mdlwscir3xhkKZxyY/qFNJHZQTj5LEQrSJneAqvlKA2xNsG8zDaRVOWRqStVbHUi6YezcaqELuiM460KVUvX9L7J9jAA3dALSmNQjoV9mQrX3ZKR3/0vhJbGU1F3aDW67Di+CEHV/SNwxj7H55B9Hy3Efkm2f2uOEYwwKwnIew84/yfzptGA==
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 1F2EB180057B; Fri, 19 Jun 2026 07:29:43 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: [PATCH v2 1/5] hw/block: add Sony/Apple "SuperDrive" diskette
 drive
From: Matt Jacobson <mhjacobson@me.com>
In-Reply-To: <758dd5cb-ebdc-325c-37c1-e9120883f468@eik.bme.hu>
Date: Fri, 19 Jun 2026 03:29:40 -0400
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E248F07-5231-4B3B-B79C-4B482FDD62AE@me.com>
References: <20260617235032.21491-1-mhjacobson@me.com>
 <20260617235032.21491-2-mhjacobson@me.com>
 <758dd5cb-ebdc-325c-37c1-e9120883f468@eik.bme.hu>
To: BALATON Zoltan <balaton@eik.bme.hu>
X-Mailer: Apple Mail (2.3696.120.41.1.10)
X-Proofpoint-GUID: E9fbFcUbQTZQZ8Xcqf9UScDXeT6VYRvf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA2OCBTYWx0ZWRfX8Rs2iAXLrQjw
 UIqsPUKOMXiDCA/yLjjrMKEhk7ctIg14lxMRrobMjFVLlXxIB+nYYPg3nI1FNMzl/XU9VOy9qUM
 SSPSVAgt7QMqlCmEpVcVYPJYlUT0XlTBL/fD3rQoAdC4ugVMggXS6tsjO3G3J4vYi4vIobsyPtN
 TbH9bTsdtZmN3dKm9TnEQ2QVZq1NJEamhtpB+wg/Jr19yeL//s05JEd/3KHD+r7L/RryOqthSHI
 TIkiOUG1YEfOJHYbnuZW+Vfjnl7Umxv7ziP4zMU/Omy13EhUc2PBzEXBr5vqsvuX5KlmC9W0vzp
 mJbTdIYUY79vg45a9TF
X-Proofpoint-ORIG-GUID: E9fbFcUbQTZQZ8Xcqf9UScDXeT6VYRvf
Received-SPF: pass client-ip=57.103.76.199; envelope-from=mhjacobson@me.com;
 helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Zoltan,

Many thanks for taking the time to review.

> On Jun 18, 2026, at 7:11 AM, BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>=20
> On Wed, 17 Jun 2026, Matt Jacobson wrote:
>> The Mac Quadra 800 contains a "SuperDrive" floppy drive that supports
>> both GCR (400 kB and 800 kB) and MFM (1440 kB) diskettes.  Implement
>> an emulated version, to be controlled by a forthcoming SWIM2 device.
>=20
> A bit more explanation could be useful here. In the cover letter it's =
mentioned that GCR/MFM encoding is generated by this emulation. Maybe =
that should be mentioned here. But I don't see what it's needed for. I =
thought maybe for single bit reads but those are not emulated. So is =
encoded data needed at all or could be added later when emulating single =
bit reads making this a simpler patch?

Apologies for the misunderstanding.

The GCR-encoded data is filled into xfer_buffer, and from there it's =
accessed through sony_drive_read_byte().  In fact, the Macintosh does =
the GCR decoding *in software* (in the ".Sony" driver), so the encoding =
is definitely required for the I/O to work correctly.

In real hardware, the SWIM2 floppy controller reads the data bit-by-bit =
via the RDDATA0/RDDATA1 sense bits, but it seemed like overkill to force =
the emulated controller and emulated drive to deal in individual bits.  =
So that's why I left that unimplemented (though it could be added later =
if needed).

> My original question that lead to to above was if the asserts in GCR =
encoding and elsewhere could be caused by the user supplying invalid =
data (i.e. bad disk image file) and thus crashing QEMU but I think if =
the disk images contain decoded data not raw GCR/MFM encoded images then =
these asserts would only be caused by errors in encoding functions in =
this file but I'm not completely sure.

I don't think there are any situations where a bad disk image would =
cause an assert.  The asserts are for internal consistency only.

However, your comment made me realize that there are cases where bad =
input *from the guest* (on the write path) could cause a crash.  That's =
a bug, and I will amend the patch to defend against that.

Happy to answer any other questions.  Thanks again,

Matt=

