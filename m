Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C01606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DP1W4Doe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVg9t-0005cZ-7c; Mon, 23 Nov 2026 21:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xVg9r-0005c1-72
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:21:23 -0500
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xVg9o-0004lP-ET
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:21:22 -0500
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-1b244fb7fffso3704219c88.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795486878; cv=none;
 d=google.com; s=arc-20260327;
 b=ctYM/8fzMWNmzf94/8hBifaweTyfphCCo4v3h6BtUKsf6Y9zl4cYugxhzrO0+HkPNL
 cmIJWOXjs4lhdNbc/hnliRllpM1hrGx+pTIdBPvkTkZo78w6G9RR0rAdIB9hG/hP9Ksp
 lY6jjWKwdp1nygtoGFWFzckPeRNyv4aidWxmLY3O5I+o5GgQVewXXzSRjMqFDEMH/cWH
 IjPEowlsAff00EiW98f3hoVCzYAIMVr2uGzDOjxHBU71EayjdJgWIvSdTpBqDdEKZ6Fz
 j+bEsZCTvny8lAfPdJhzxPLP1eKE1SmvGuwd5IqC+XGVSyokp+XwUuJ2F10NlJXdhUnr
 K48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/EYYii6ZGkbQm7oMtYdbjDLxMk6ioPyaXQ3ogUOZ5co=;
 fh=RPP8CUJxolc+WiwY2OLQ1fszFvoCLqCvcnTls58ueYE=;
 b=k5d8zp2Em8/P/ya9KdaP3C41xiHsiiFydJWIOAKXMKxm38spnASN6cXp5WPIe4ciNR
 h9sKK649HsvojXE59xHQuRaUo77rEIBdJAzcJtrbmZvKc4M6/MpGw3sCKEKOzHvmsqqH
 9P1CCP2/gpToiJBSoowq1vnrt3R9CE8oyyNtHcPz5MUJem4UtUijGgH5rEHokfdoUX5n
 0ijsna/RnDspY8Q0dH2UoIsVmAGkGoWlaoYh41qcZPSrQFTcUjES3JK1IzaTsyE1t/7Z
 G3ngycPQnYFdZuwuBeIBMHWWk8KOGQv6POJ+Wabj+i2h9yXkVeo5R15zPkgyEpXgySjS
 KL2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795486878; x=1796091678; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/EYYii6ZGkbQm7oMtYdbjDLxMk6ioPyaXQ3ogUOZ5co=;
 b=DP1W4Doe18o6bc7ge4tT/eRncw4fpU7+H2Btff/CPiTemCLsILQ49HML6gCkCjR3E2
 BbejX0B2R7iTQ/IMR1Db2agxOFOBn6OY1hKkhh03XSGP7FU6QjcrWBYg9tKDcDy23xfU
 FlEN4Jfz8E586fJnPIC7GjAlc1AgNRzGqI2i4hife4oKC6OJO4TiOttqTOh7WZF6Wn9O
 OxtnZb3CF55LRMnU7S1sOgBWiwhBv+nWQ5DEmJ6hAfz+ylN7Q+oi9VWYeIUTSZviFZGb
 OSjAtZMe1y9q661XWJlmuAqZSBtAV5U/JCRYAXwTq4T+kqHUM6IrMAh62qo4ssd+Hpqh
 QvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795486878; x=1796091678;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/EYYii6ZGkbQm7oMtYdbjDLxMk6ioPyaXQ3ogUOZ5co=;
 b=hlJg0lYRlmV5hd606GsPNUrd3a1UxR3aaC/292AxSTvbiKYtUGlFuepmncSi/cxkAE
 zksUweWX7xfmxR04TeEiWus+bZiBaGcC+BF0sqWLjsXcTRiLCacxXIZ8Zgxz9dxnQabB
 PHFOH5Vnw3XDAZE4h2MPSuCX7w0MzudKMI051sxJQ/y8jPUYFcqYEuacxCdjJp3FgaCN
 WmVvzw7gKc9mx8k676bQ77cSSRI2gyMzNIvVCpl97ptIvY/tXZdrHHxcIUZUv1TaEOI6
 y6/HbgtbFaiAui9PeCd1cy54CK+wIyicmHP0WDeUhSeQ39ZTEFGDHT1mF+9AMZZ6FtP4
 xOBA==
X-Gm-Message-State: APuU4Z8p1JfqZ0krwOP0a/ZC34OB3YU0BMuYhtdOv8dcZX4pdhaJKMKK
 /ZKLHb+jXRz+S/YHldQSukafRb7MNUILxUq1dGllAlGS7cHWY5NLyvfzoK1J8JvO7ALd1tylNmE
 rH9up/djbJhnNWpefVqeleW3hUtKutNE=
X-Gm-Gg: AZFdTZce5vpwggMwBlph0k6oDSOKVzXy2vJMuV96sdVu8RS5KtEwKqLpb9IsO9Rpm7G
 W3Tv+d/bXVW7ZNvto8+PP/xAk+d54vDIh/zDN8+Lsb463D9b/8/xNtgAk/5LlgDU8JHfVrQkQ0v
 LeB6qzWywdaIc/VsiN0BwEek4+DICUWNM1Q2cx91JgJcTtNtkpMh8Os8KFbnj6cRY94YFS3uclj
 sDsDzI/OHPQG9SnHcuIN9SEoXLVEI8XrpMSdQeYfvmc+o5QlwYMng03+auahyE+L9rM6h2f0/Is
 nO3nwkXCLgdMZKLa1pMUuOYWcUk3qC9zYknSFvUVHo2pLIiFGVhOvrfxNkJlW0dexgnpJOBC55/
 IzXNE26p1RDlbwhYoZDlIDnQIdoSNzRhd0iuB+/+1yexc5ciGw1wv/TW6IKJPPuWxYobf+u1Jje
 0a0Ez/14DegoJa0r4=
X-Received: by 2002:a05:701b:2707:b0:1b3:bae1:f5f3 with SMTP id
 a92af1059eb24-1b556865260mr12037094c88.6.1795486878221; Mon, 23 Nov 2026
 18:21:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-dmg-short-decode-v1-0-f7f342097b60@gmail.com>
 <20261112-dmg-short-decode-v1-2-f7f342097b60@gmail.com>
 <avs0HYZSdJOg8Pef@redhat.com>
In-Reply-To: <avs0HYZSdJOg8Pef@redhat.com>
From: Julio Faracco <jcfaracco@gmail.com>
Date: Mon, 23 Nov 2026 23:21:04 -0300
X-Gm-Features: Aa3M54rVepmmztSQ_G4Xcp_IUq48tke9AoTNKQVHu4T_PNlcmvs4iYMEjWX90mA
Message-ID: <CAENf94K8zL51epcMe==19wF1OBT7n_EU8XEFnfZyzwv-nn8_4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/qemu-iotests: cover the dmg LZFSE short-decode
 fix
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=jcfaracco@gmail.com; helo=mail-dl1-x122c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Em seg., 16 de nov. de 2026 =C3=A0s 13:49, Kevin Wolf <kwolf@redhat.com> es=
creveu:
>
> Am 12.11.2026 um 16:33 hat Julio Faracco geschrieben:
> > Add a regression test for the LZFSE short-decode heap disclosure. It
> > builds a minimal DMG (koly trailer, plist, BLKX block, LZFSE data fork)
> > whose chunk declares two sectors of output while its LZFSE stream only
> > decodes to one, and checks that reading the chunk now fails with an I/O
> > error instead of leaking stale heap bytes.
> >
> > A valid single-sector DMG is converted first; if that fails, the test
> > is skipped as LZFSE support is not built in.
> >
> > Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
>
> The last paragraph isn't completely accurate any more, the test checks
> the specific error message now.

Ok. Updated the commit log to accurately describe the specific module check=
 and
the updated test behavior.

>
> >  tests/qemu-iotests/tests/dmg-lzfse-short     | 142 +++++++++++++++++++=
++++++++
> >  tests/qemu-iotests/tests/dmg-lzfse-short.out |   2 +
> >  2 files changed, 144 insertions(+)
> >
> > diff --git a/tests/qemu-iotests/tests/dmg-lzfse-short b/tests/qemu-iote=
sts/tests/dmg-lzfse-short
> > new file mode 100755
> > index 0000000000..fc0b69cee3
> > --- /dev/null
> > +++ b/tests/qemu-iotests/tests/dmg-lzfse-short
> > @@ -0,0 +1,142 @@
> > +#!/usr/bin/env python3
> > +# group: rw quick
> > +#
> > +# Regression test for the dmg LZFSE short-decode heap disclosure.
> > +#
> > +# Copyright (C) 2026 Red Hat, Inc.
> > +#
> > +# This program is free software; you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License as published by
> > +# the Free Software Foundation; either version 2 of the License, or
> > +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
> > +#
> > +# A crafted DMG can declare a chunk output size larger than its LZFSE
> > +# stream actually produces.  dmg_uncompress_lzfse_do() used to accept
> > +# such a short decode and hand the untouched tail of the (unzeroed)
> > +# uncompressed chunk buffer to the guest -- a heap disclosure.  Readin=
g
> > +# such a chunk must now fail with an I/O error instead.
> > +
> > +import base64
> > +import os
> > +import struct
> > +import sys
> > +
> > +import iotests
> > +
> > +ULFO =3D 0x80000007  # LZFSE compressed block type
> > +SECTOR =3D 512
> > +
> > +
> > +def lzfse_uncompressed_stream(payload: bytes) -> bytes:
> > +    """A valid LZFSE stream: one uncompressed block + end-of-stream ma=
rker."""
> > +    return (b'bvx-' + struct.pack('<I', len(payload))  # uncompressed =
block
> > +            + payload
> > +            + b'bvx$')                                   # end of stre=
am
> > +
> > +
> > +def build_dmg(stream: bytes, decl_sectors: int, total_sectors: int) ->=
 bytes:
> > +    """
> > +    Build a minimal DMG with a single LZFSE chunk.  The chunk declares
> > +    decl_sectors sectors of output; when that exceeds what 'stream'
> > +    decodes to, the decode is short.
> > +    """
> > +    data_fork =3D stream
> > +
> > +    # BLKX ("mish") block: 204-byte header followed by one 40-byte ent=
ry.
> > +    mish =3D bytearray(204)
> > +    struct.pack_into('>I', mish, 0x00, 0x6d697368)        # 'mish' mag=
ic
> > +    struct.pack_into('>I', mish, 0x04, 1)                 # version
> > +    struct.pack_into('>Q', mish, 0x08, 0)                 # first sect=
or number
> > +    struct.pack_into('>Q', mish, 0x10, total_sectors)     # sector cou=
nt
> > +    struct.pack_into('>Q', mish, 0x18, 0)                 # data fork =
offset
> > +
> > +    entry =3D bytearray(40)
> > +    struct.pack_into('>I', entry, 0x00, ULFO)             # entry type
> > +    struct.pack_into('>Q', entry, 0x08, 0)               # sector numb=
er
> > +    struct.pack_into('>Q', entry, 0x10, decl_sectors)    # sector coun=
t
> > +    struct.pack_into('>Q', entry, 0x18, 0)               # compressed =
offset
> > +    struct.pack_into('>Q', entry, 0x20, len(data_fork))  # compressed =
length
> > +    mish +=3D entry
> > +
> > +    xml =3D (b'<plist><dict><data>'
> > +           + base64.b64encode(bytes(mish))
> > +           + b'</data></dict></plist>')
> > +
> > +    buf =3D bytearray()
> > +    buf +=3D data_fork
> > +    xml_off =3D len(buf)
> > +    buf +=3D xml
> > +    koly_off =3D len(buf)
> > +
> > +    # UDIF trailer ("koly" block), 512 bytes, big-endian.
> > +    koly =3D bytearray(512)
> > +    struct.pack_into('>4s', koly, 0x000, b'koly')         # signature
> > +    struct.pack_into('>I', koly, 0x004, 4)               # version
> > +    struct.pack_into('>I', koly, 0x008, 512)             # header size
> > +    struct.pack_into('>Q', koly, 0x018, 0)               # DataForkOff=
set
> > +    struct.pack_into('>Q', koly, 0x020, len(data_fork))  # DataForkLen=
gth
> > +    struct.pack_into('>Q', koly, 0x028, 0)               # RsrcForkOff=
set
> > +    struct.pack_into('>Q', koly, 0x030, 0)               # RsrcForkLen=
gth
> > +    struct.pack_into('>Q', koly, 0x0d8, xml_off)         # XMLOffset
> > +    struct.pack_into('>Q', koly, 0x0e0, len(xml))        # XMLLength
> > +    struct.pack_into('>q', koly, 0x1ec, total_sectors)   # SectorCount
> > +    buf +=3D koly
> > +
> > +    assert koly_off =3D=3D len(buf) - 512
> > +    return bytes(buf)
> > +
> > +
> > +def convert_to_raw(dmg: bytes, name: str):
> > +    dmg_path =3D os.path.join(iotests.test_dir, name)
> > +    raw_path =3D dmg_path + '.raw'
> > +    with open(dmg_path, 'wb') as f:
> > +        f.write(dmg)
> > +    res =3D iotests.qemu_img('convert', '-f', 'dmg', '-O', 'raw',
> > +                           dmg_path, raw_path, check=3DFalse)
> > +    return res, dmg_path, raw_path
>
> The test forgets to clean up after itself, i.e. remove the image files
> it created. iotests.py has the FilePath context manager, or if that is
> hard to integrate, the file_path() function to support this.

Great! I've converted the test to use `iotests.FilePath` context managers
so all temporary DMG files are cleaned up automatically.

>
> It's a common pattern to wrap a test in something like this:
>
>     with iotests.FilePath('disk.img') as path:
>         ...
>
> > +
> > +
> > +def main() -> None:
> > +    payload =3D b'\xab' * SECTOR
> > +
> > +    # A well-formed single-sector chunk must convert cleanly.  Skip on=
ly
> > +    # when QEMU was built without the LZFSE module (so this would neve=
r
> > +    # work); treat any other failure as a real regression.
> > +    good =3D build_dmg(lzfse_uncompressed_stream(payload),
> > +                     decl_sectors=3D1, total_sectors=3D1)
> > +    res, _, raw_path =3D convert_to_raw(good, 'good.dmg')
> > +    if res.returncode !=3D 0:
> > +        if 'dmg-lzfse module is missing' in res.stdout:
> > +            iotests.notrun('LZFSE decompression not available')
> > +        iotests.log('FAIL: valid LZFSE chunk failed to convert')
> > +        iotests.log(res.stdout)
> > +        sys.exit(1)
> > +
> > +    with open(raw_path, 'rb') as f:
> > +        if f.read() !=3D payload:
> > +            iotests.log('FAIL: valid LZFSE chunk decoded incorrectly')
> > +            return
> > +    iotests.log('valid LZFSE chunk converts: ok')
> > +
> > +    # Same 512-byte stream, but the chunk claims two sectors (1024 byt=
es).
> > +    # The decode is short and must be rejected with an I/O error.
> > +    evil =3D build_dmg(lzfse_uncompressed_stream(payload),
> > +                     decl_sectors=3D2, total_sectors=3D2)
> > +    res, _, _ =3D convert_to_raw(evil, 'evil.dmg')
> > +    if res.returncode =3D=3D 0:
> > +        iotests.log('FAIL: short LZFSE decode was accepted')
> > +        return
> > +    iotests.log('short LZFSE decode rejected: ok')
>
> I wonder if we should check a more specific error message here, too. If
> anything else goes wrong (can't open the image or whatever), we don't
> necessarily want to count that as a success.

Agreed. The test now explicitly asserts that "Input/output error" is presen=
t
in the output so that unexpected failures aren't mistakenly treated as pass=
es.

>
> I'm also wondering why you chose to 'qemu-img convert' and then open the
> raw image in Python. Is there a problem with the simpler way of just
> verifying with qemu-io that 'read -P 0xab 0 512' directly on the dmg
> image returns the expected result?

Indeed.
I've dropped the raw conversion step and switched to direct `qemu-io` reads=
.

>
> > +
> > +
> > +iotests.script_main(main, supported_fmts=3D['dmg'],
> > +                    supported_protocols=3D['file'],
> > +                    supported_platforms=3D['linux'])
> > diff --git a/tests/qemu-iotests/tests/dmg-lzfse-short.out b/tests/qemu-=
iotests/tests/dmg-lzfse-short.out
> > new file mode 100644
> > index 0000000000..6802cf1a76
> > --- /dev/null
> > +++ b/tests/qemu-iotests/tests/dmg-lzfse-short.out
> > @@ -0,0 +1,2 @@
> > +valid LZFSE chunk converts: ok
> > +short LZFSE decode rejected: ok
>
> Kevin
>

I will submit all the suggestions in a V2. Thanks, Kevin.


-- Julio

