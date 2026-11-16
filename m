Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFDA606A334
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MZgKpDqi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSztu-00070r-S6; Mon, 16 Nov 2026 11:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xSztq-00070C-7S
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:49:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xSztn-0004A2-AJ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794847780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9inNnmdLSInotKj/p6H4pyoBjY/RrpVqMSiYoqMVwI=;
 b=MZgKpDqi8EMG2pWElup7JRmr3zJtM2UYhjS60MXKjU2A3mwMNcgLnkXRBLmKIxJam9cGPW
 XbzS2X3A3S/pBeyOPGeezH1PpXpoM+YrS04xYYhZ2BesJ7yIvSI7/0s3jvqiutCzQsPMmK
 OhlbfpO/MgFXm7JMgZ3h7g1FunumCe4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-PPictHucMdWuO_1INSev3Q-1; Mon,
 16 Nov 2026 11:49:38 -0500
X-MC-Unique: PPictHucMdWuO_1INSev3Q-1
X-Mimecast-MFC-AGG-ID: PPictHucMdWuO_1INSev3Q_1794847778
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AF1F1955F41; Mon, 16 Nov 2026 16:49:37 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B909180056E; Mon, 16 Nov 2026 16:49:35 +0000 (UTC)
Date: Mon, 16 Nov 2026 17:49:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Julio Faracco <jcfaracco@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] tests/qemu-iotests: cover the dmg LZFSE short-decode
 fix
Message-ID: <avs0HYZSdJOg8Pef@redhat.com>
References: <20261112-dmg-short-decode-v1-0-f7f342097b60@gmail.com>
 <20261112-dmg-short-decode-v1-2-f7f342097b60@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-dmg-short-decode-v1-2-f7f342097b60@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 12.11.2026 um 16:33 hat Julio Faracco geschrieben:
> Add a regression test for the LZFSE short-decode heap disclosure. It
> builds a minimal DMG (koly trailer, plist, BLKX block, LZFSE data fork)
> whose chunk declares two sectors of output while its LZFSE stream only
> decodes to one, and checks that reading the chunk now fails with an I/O
> error instead of leaking stale heap bytes.
> 
> A valid single-sector DMG is converted first; if that fails, the test
> is skipped as LZFSE support is not built in.
> 
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>

The last paragraph isn't completely accurate any more, the test checks
the specific error message now.

>  tests/qemu-iotests/tests/dmg-lzfse-short     | 142 +++++++++++++++++++++++++++
>  tests/qemu-iotests/tests/dmg-lzfse-short.out |   2 +
>  2 files changed, 144 insertions(+)
> 
> diff --git a/tests/qemu-iotests/tests/dmg-lzfse-short b/tests/qemu-iotests/tests/dmg-lzfse-short
> new file mode 100755
> index 0000000000..fc0b69cee3
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/dmg-lzfse-short
> @@ -0,0 +1,142 @@
> +#!/usr/bin/env python3
> +# group: rw quick
> +#
> +# Regression test for the dmg LZFSE short-decode heap disclosure.
> +#
> +# Copyright (C) 2026 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +# A crafted DMG can declare a chunk output size larger than its LZFSE
> +# stream actually produces.  dmg_uncompress_lzfse_do() used to accept
> +# such a short decode and hand the untouched tail of the (unzeroed)
> +# uncompressed chunk buffer to the guest -- a heap disclosure.  Reading
> +# such a chunk must now fail with an I/O error instead.
> +
> +import base64
> +import os
> +import struct
> +import sys
> +
> +import iotests
> +
> +ULFO = 0x80000007  # LZFSE compressed block type
> +SECTOR = 512
> +
> +
> +def lzfse_uncompressed_stream(payload: bytes) -> bytes:
> +    """A valid LZFSE stream: one uncompressed block + end-of-stream marker."""
> +    return (b'bvx-' + struct.pack('<I', len(payload))  # uncompressed block
> +            + payload
> +            + b'bvx$')                                   # end of stream
> +
> +
> +def build_dmg(stream: bytes, decl_sectors: int, total_sectors: int) -> bytes:
> +    """
> +    Build a minimal DMG with a single LZFSE chunk.  The chunk declares
> +    decl_sectors sectors of output; when that exceeds what 'stream'
> +    decodes to, the decode is short.
> +    """
> +    data_fork = stream
> +
> +    # BLKX ("mish") block: 204-byte header followed by one 40-byte entry.
> +    mish = bytearray(204)
> +    struct.pack_into('>I', mish, 0x00, 0x6d697368)        # 'mish' magic
> +    struct.pack_into('>I', mish, 0x04, 1)                 # version
> +    struct.pack_into('>Q', mish, 0x08, 0)                 # first sector number
> +    struct.pack_into('>Q', mish, 0x10, total_sectors)     # sector count
> +    struct.pack_into('>Q', mish, 0x18, 0)                 # data fork offset
> +
> +    entry = bytearray(40)
> +    struct.pack_into('>I', entry, 0x00, ULFO)             # entry type
> +    struct.pack_into('>Q', entry, 0x08, 0)               # sector number
> +    struct.pack_into('>Q', entry, 0x10, decl_sectors)    # sector count
> +    struct.pack_into('>Q', entry, 0x18, 0)               # compressed offset
> +    struct.pack_into('>Q', entry, 0x20, len(data_fork))  # compressed length
> +    mish += entry
> +
> +    xml = (b'<plist><dict><data>'
> +           + base64.b64encode(bytes(mish))
> +           + b'</data></dict></plist>')
> +
> +    buf = bytearray()
> +    buf += data_fork
> +    xml_off = len(buf)
> +    buf += xml
> +    koly_off = len(buf)
> +
> +    # UDIF trailer ("koly" block), 512 bytes, big-endian.
> +    koly = bytearray(512)
> +    struct.pack_into('>4s', koly, 0x000, b'koly')         # signature
> +    struct.pack_into('>I', koly, 0x004, 4)               # version
> +    struct.pack_into('>I', koly, 0x008, 512)             # header size
> +    struct.pack_into('>Q', koly, 0x018, 0)               # DataForkOffset
> +    struct.pack_into('>Q', koly, 0x020, len(data_fork))  # DataForkLength
> +    struct.pack_into('>Q', koly, 0x028, 0)               # RsrcForkOffset
> +    struct.pack_into('>Q', koly, 0x030, 0)               # RsrcForkLength
> +    struct.pack_into('>Q', koly, 0x0d8, xml_off)         # XMLOffset
> +    struct.pack_into('>Q', koly, 0x0e0, len(xml))        # XMLLength
> +    struct.pack_into('>q', koly, 0x1ec, total_sectors)   # SectorCount
> +    buf += koly
> +
> +    assert koly_off == len(buf) - 512
> +    return bytes(buf)
> +
> +
> +def convert_to_raw(dmg: bytes, name: str):
> +    dmg_path = os.path.join(iotests.test_dir, name)
> +    raw_path = dmg_path + '.raw'
> +    with open(dmg_path, 'wb') as f:
> +        f.write(dmg)
> +    res = iotests.qemu_img('convert', '-f', 'dmg', '-O', 'raw',
> +                           dmg_path, raw_path, check=False)
> +    return res, dmg_path, raw_path

The test forgets to clean up after itself, i.e. remove the image files
it created. iotests.py has the FilePath context manager, or if that is
hard to integrate, the file_path() function to support this.

It's a common pattern to wrap a test in something like this:

    with iotests.FilePath('disk.img') as path:
        ...

> +
> +
> +def main() -> None:
> +    payload = b'\xab' * SECTOR
> +
> +    # A well-formed single-sector chunk must convert cleanly.  Skip only
> +    # when QEMU was built without the LZFSE module (so this would never
> +    # work); treat any other failure as a real regression.
> +    good = build_dmg(lzfse_uncompressed_stream(payload),
> +                     decl_sectors=1, total_sectors=1)
> +    res, _, raw_path = convert_to_raw(good, 'good.dmg')
> +    if res.returncode != 0:
> +        if 'dmg-lzfse module is missing' in res.stdout:
> +            iotests.notrun('LZFSE decompression not available')
> +        iotests.log('FAIL: valid LZFSE chunk failed to convert')
> +        iotests.log(res.stdout)
> +        sys.exit(1)
> +
> +    with open(raw_path, 'rb') as f:
> +        if f.read() != payload:
> +            iotests.log('FAIL: valid LZFSE chunk decoded incorrectly')
> +            return
> +    iotests.log('valid LZFSE chunk converts: ok')
> +
> +    # Same 512-byte stream, but the chunk claims two sectors (1024 bytes).
> +    # The decode is short and must be rejected with an I/O error.
> +    evil = build_dmg(lzfse_uncompressed_stream(payload),
> +                     decl_sectors=2, total_sectors=2)
> +    res, _, _ = convert_to_raw(evil, 'evil.dmg')
> +    if res.returncode == 0:
> +        iotests.log('FAIL: short LZFSE decode was accepted')
> +        return
> +    iotests.log('short LZFSE decode rejected: ok')

I wonder if we should check a more specific error message here, too. If
anything else goes wrong (can't open the image or whatever), we don't
necessarily want to count that as a success.

I'm also wondering why you chose to 'qemu-img convert' and then open the
raw image in Python. Is there a problem with the simpler way of just
verifying with qemu-io that 'read -P 0xab 0 512' directly on the dmg
image returns the expected result?

> +
> +
> +iotests.script_main(main, supported_fmts=['dmg'],
> +                    supported_protocols=['file'],
> +                    supported_platforms=['linux'])
> diff --git a/tests/qemu-iotests/tests/dmg-lzfse-short.out b/tests/qemu-iotests/tests/dmg-lzfse-short.out
> new file mode 100644
> index 0000000000..6802cf1a76
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/dmg-lzfse-short.out
> @@ -0,0 +1,2 @@
> +valid LZFSE chunk converts: ok
> +short LZFSE decode rejected: ok

Kevin


