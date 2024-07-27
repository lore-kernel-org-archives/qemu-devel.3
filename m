Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5030CC3DA61
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2024 22:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXpTw-0005Cy-B1; Sat, 27 Jul 2024 18:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sXpTs-0005CK-I4
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 18:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sXpTp-0005f2-KN
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 18:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722117690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nk09iqES8zxfh0gh5CVHWtjU6zH6znG4h3wJMWmwh2E=;
 b=jOcqXP7HdF7sDwqvkXiC/1JeEVORKUZnL3zlrXAzGpY1Pdzmnx+IgmFSAKpBq5L99bFx8x
 OD96qMQEc/ZHvB2K0scQAwWM2r8f6xBPVW3oKwIgO5OB3zjNvd/talvcMxrYNTiYZjYWri
 jsXZCpc+M20BNk8fcbbdWYAQz4CncQE=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-Y8ELy2LkMYuxAk3kH8gSMA-1; Sat, 27 Jul 2024 18:01:25 -0400
X-MC-Unique: Y8ELy2LkMYuxAk3kH8gSMA-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4f51e7b921eso443936e0c.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jul 2024 15:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722117685; x=1722722485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nk09iqES8zxfh0gh5CVHWtjU6zH6znG4h3wJMWmwh2E=;
 b=Eu+E4kqG9nsIZTmZMlXPY3825xBDSL/uhX4IkmEaDnkwvAXd196x2NVgdOKj+ErWm9
 lIedgY/SD0Hsy4d+3JrLjLPhfe/nQOOwhZ7V8oG0mBBVY7SRDazzNrliXHv8GPZkNhx/
 Wm8SWqc+ercX+RBfZ5srQuNi5AmQe2xepwh3dbWsCI9IuqT8wKcf7+OKgUQC+ebVWk07
 JzjERUfDKGE6kMI56ncgHDFVHHC9Bn2RUmC1YlRE7zzviNhd+wDTC3/nbTcGVbB8XwC6
 /0DjDcdwP+u6TdgsdS42ElZkfJKt2iqwDoIlwtvYCVzbx4cbwOsJppMKLEHTbwHSlIMd
 rYsw==
X-Gm-Message-State: AOJu0YwyPaJiQoW2UoQXPGZy31OTfVFP018KM9r+9xLYIJVYC5JXB4jO
 ejT54POL7sfOZ05FzZFW1fCsNr7mYXac+d4UdPFb9ERZeLtLw8QhslFITKDr0hDFXaFnVxCuIcu
 /YBnOFpvWL380QqNf/kWJKt3QZdv+Pc+ztDsgsk6mQEcDWTbORS96x0hADr2LfO2dBfPhCDshPZ
 +CcDn2Tcm91IuinCRHYMcUIQjFq2A=
X-Received: by 2002:a05:6122:319d:b0:4ec:f996:5d84 with SMTP id
 71dfb90a1353d-4f6e68b8c4bmr4113294e0c.2.1722117684599; 
 Sat, 27 Jul 2024 15:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2XNLiznvUC8rLIVHYfSBvpV57fsR/f+4W3gJWKZUUeApyp76pIr74RrsA9GXkDEMeaT9YFTfc8Onov5/1SfU=
X-Received: by 2002:a05:6122:319d:b0:4ec:f996:5d84 with SMTP id
 71dfb90a1353d-4f6e68b8c4bmr4113250e0c.2.1722117684064; Sat, 27 Jul 2024
 15:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240701151140.29775-1-berto@igalia.com>
In-Reply-To: <20240701151140.29775-1-berto@igalia.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sun, 28 Jul 2024 01:01:07 +0300
Message-ID: <CAMRbyysVzAB9DnJsrXfbdJJ5uDYJHEsgiNk=3wLkOisus59q5g@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Madeeha Javed <javed@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.139,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 1, 2024 at 6:13=E2=80=AFPM Alberto Garcia <berto@igalia.com> wr=
ote:
>
> This tool converts a disk image to qcow2, writing the result directly
> to stdout. This can be used for example to send the generated file
> over the network.
>
> This is equivalent to using qemu-img to convert a file to qcow2 and
> then writing the result to stdout, with the difference that this tool
> does not need to create this temporary qcow2 file and therefore does
> not need any additional disk space.
>
> Implementing this directly in qemu-img is not really an option because
> it expects the output file to be seekable and it is also meant to be a
> generic tool that supports all combinations of file formats and image
> options. Instead, this tool can only produce qcow2 files with the
> basic options, without compression, encryption or other features.
>
> The input file is read twice. The first pass is used to determine
> which clusters contain non-zero data and that information is used to
> create the qcow2 header, refcount table and blocks, and L1 and L2
> tables. After all that metadata is created then the second pass is
> used to write the guest data.
> By default qcow2-to-stdout.py expects the input to be a raw file, but
> if qemu-storage-daemon is available then it can also be used to read
> images in other formats. Alternatively the user can also run qemu-ndb
> or qemu-storage-daemon manually instead.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Madeeha Javed <javed@igalia.com>
> ---
>  scripts/qcow2-to-stdout.py | 377 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 377 insertions(+)
>  create mode 100755 scripts/qcow2-to-stdout.py
>
> v2:
> - Define the QCOW2_V3_HDR_LENGTH and QCOW2_FEATURE_NAME_TABLE constants [=
Manos]
> - Define the QEMU_STORAGE_DAEMON constant
> - Use isfile() instead of exists() for the input file
> - Refuse to write to stdout if it's a tty [Manos]
> - Move the bulk of the code to a function called from __main__ [Manos]
> - Remove the qcow2_ prefix from qcow2_cluster_size and qcow2_refcount_bit=
s
> - Formatting fixes suggested by the Python black formatter [Manos]
> - On error pass the string directly to sys.exit()
> - Capture the output of qemu-storage-daemon [Manos]
> - Use a contextmanager to run qemu-storage-daemon [Manos]
> - Update patch description to mention why this cannot be implemeted direc=
tly in qemu-img [Manos]
>
> v1: https://lists.gnu.org/archive/html/qemu-block/2024-06/msg00073.html
>
> diff --git a/scripts/qcow2-to-stdout.py b/scripts/qcow2-to-stdout.py
> new file mode 100755
> index 0000000000..d486a80e86
> --- /dev/null
> +++ b/scripts/qcow2-to-stdout.py
> @@ -0,0 +1,377 @@
> +#!/usr/bin/env python3
> +
> +# This tool reads a disk image in any format and converts it to qcow2,
> +# writing the result directly to stdout.
> +#
> +# Copyright (C) 2024 Igalia, S.L.
> +#
> +# Authors: Alberto Garcia <berto@igalia.com>
> +#          Madeeha Javed <javed@igalia.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# qcow2 files produced by this script are always arranged like this:
> +#
> +# - qcow2 header
> +# - refcount table
> +# - refcount blocks
> +# - L1 table
> +# - L2 tables
> +# - Data clusters
> +#
> +# A note about variable names: in qcow2 there is one refcount table
> +# and one (active) L1 table, although each can occupy several
> +# clusters. For the sake of simplicity the code sometimes talks about
> +# refcount tables and L1 tables when referring to those clusters.
> +
> +import argparse
> +import atexit

This is unused now

> +import math
> +import os
> +import signal
> +import struct
> +import subprocess
> +import sys
> +import tempfile
> +import time
> +from contextlib import contextmanager
> +
> +QCOW2_DEFAULT_CLUSTER_SIZE =3D 65536
> +QCOW2_DEFAULT_REFCOUNT_BITS =3D 16
> +QCOW2_DEFAULT_VERSION =3D 3
> +QCOW2_FEATURE_NAME_TABLE =3D 0x6803F857
> +QCOW2_V3_HEADER_LENGTH =3D 112  # Header length in QEMU 9.0. Must be a m=
ultiple of 8
> +QCOW_OFLAG_COPIED =3D 1 << 63
> +QEMU_STORAGE_DAEMON =3D "qemu-storage-daemon"
> +
> +
> +def bitmap_set(bitmap, idx):
> +    bitmap[int(idx / 8)] |=3D 1 << (idx % 8)

Should use floor division operator (//):

    bitmap[idx // 8] |=3D 1 << (idx % 8)

Same for bitmap_test().

> +
> +
> +def bitmap_test(bitmap, idx):

bitmap_is_set() can be more clear. For example it is obvious that it
returns True if the bit is set

> +    return (bitmap[int(idx / 8)] & (1 << (idx % 8))) !=3D 0
> +
> +
> +# create_qcow2_file() expects a raw input file. If we have a different
> +# format we can use qemu-storage-daemon to make it appear as raw.
> +@contextmanager
> +def get_input_as_raw_file(input_file, input_format):
> +    if input_format =3D=3D "raw":
> +        yield input_file
> +        return
> +    try:
> +        temp_dir =3D tempfile.mkdtemp()
> +        pid_file =3D temp_dir + "/pid"
> +        raw_file =3D temp_dir + "/raw"

This is fragile, better to use os.path.join()

> +        open(raw_file, "wb").close()
> +        ret =3D subprocess.run(
> +            [
> +                QEMU_STORAGE_DAEMON,
> +                "--daemonize",

Any reason to daemonize? managing the child process is easier if you
don't daemonize.
There is no need to read the pid file and since the child process is a
child of this process
the pid returned by subprocess.Popen() is always valid.

> +                "--pidfile", pid_file,
> +                "--blockdev", f"driver=3Dfile,node-name=3Dfile0,driver=
=3Dfile,filename=3D{input_file},read-only=3Don",
> +                "--blockdev", f"driver=3D{input_format},node-name=3Ddisk=
0,file=3Dfile0,read-only=3Don",
> +                "--export", f"type=3Dfuse,id=3Dexport0,node-name=3Ddisk0=
,mountpoint=3D{raw_file},writable=3Doff",
> +            ],
> +            capture_output=3DTrue,
> +        )
> +        if ret.returncode !=3D 0:
> +            sys.exit("[Error] Could not start the qemu-storage-daemon:\n=
" +
> +                     ret.stderr.decode().rstrip('\n'))
> +        yield raw_file
> +    finally:
> +        # Kill the storage daemon on exit

Looks like a good approach...

> +        # and remove all temporary files
> +        if os.path.exists(pid_file):

If the pid file is deleted, this leaves qemu-storage-daemon running
(avoided by running qsd as a child process)

> +            with open(pid_file, "r") as f:
> +                pid =3D int(f.readline())

This pid can be reused now by another unrelated process (avoided by
running qsd as a child process).

> +            os.kill(pid, signal.SIGTERM)

You don't kill as promised above - I guess because you want to wait
for the pid file.

> +            while os.path.exists(pid_file):
> +                time.sleep(0.1)

If qsd is a child process we could simply use p.wait()

> +        os.unlink(raw_file)
> +        os.rmdir(temp_dir)

We could avoid both by using tempfile.TempoaryDirectory():

    with tempfile.TemporaryDirectory() as tmp_dir:
        ...
        p =3D subprocess.Popen(cmd, stdout=3Dsubprocess.DEVNULL)
        try:
            yield raw_file
        finally:
            p.kill()
            p.wait()

> +
> +
> +def write_features(cluster, offset):
> +    qcow2_features =3D [
> +        # Incompatible
> +        (0, 0, "dirty bit"),
> +        (0, 1, "corrupt bit"),
> +        (0, 2, "external data file"),
> +        (0, 3, "compression type"),
> +        (0, 4, "extended L2 entries"),
> +        # Compatible
> +        (1, 0, "lazy refcounts"),
> +        # Autoclear
> +        (2, 0, "bitmaps"),
> +        (2, 1, "raw external data"),
> +    ]
> +    struct.pack_into(">I", cluster, offset, QCOW2_FEATURE_NAME_TABLE)
> +    struct.pack_into(">I", cluster, offset + 4, len(qcow2_features) * 48=
)
> +    offset +=3D 8
> +    for feature_type, feature_bit, feature_name in qcow2_features:
> +        struct.pack_into(">BB46s", cluster, offset,
> +                         feature_type, feature_bit, feature_name.encode(=
"ascii"))
> +        offset +=3D 48
> +
> +
> +def create_qcow2_file(input_file, cluster_size, refcount_bits, qcow2_ver=
sion):
> +    # Some basic values
> +    l1_entries_per_table =3D int(cluster_size / 8)
> +    l2_entries_per_table =3D int(cluster_size / 8)
> +    refcounts_per_table  =3D int(cluster_size / 8)
> +    refcounts_per_block  =3D int(cluster_size * 8 / refcount_bits)
> +
> +    # Virtual disk size, number of data clusters and L1 entries
> +    disk_size =3D math.ceil(os.path.getsize(input_file) / 512) * 512 # R=
ound up to the nearest multiple of 512
> +    total_data_clusters =3D math.ceil(disk_size / cluster_size)
> +    l1_entries =3D math.ceil(total_data_clusters / l2_entries_per_table)
> +    allocated_l1_tables =3D math.ceil(l1_entries / l1_entries_per_table)
> +
> +    # Max L1 table size is 32 MB (QCOW_MAX_L1_SIZE in block/qcow2.h)
> +    if (l1_entries * 8) > (32 * 1024 * 1024):
> +        sys.exit("[Error] The image size is too large. Try using a large=
r cluster size.")
> +
> +    # Two bitmaps indicating which L1 and L2 entries are set
> +    l1_bitmap =3D bytearray(int(allocated_l1_tables * l1_entries_per_tab=
le / 8))
> +    l2_bitmap =3D bytearray(int(allocated_l1_tables * l1_entries_per_tab=
le * l2_entries_per_table / 8))
> +    allocated_l2_tables =3D 0
> +    allocated_data_clusters =3D 0
> +    with open(input_file, "rb") as reader:
> +        zero_cluster =3D bytes(cluster_size)
> +        # Read all clusters from the input file
> +        for idx in range(total_data_clusters):
> +            cluster =3D reader.read(cluster_size)
> +            # If the last cluster is smaller than cluster_size pad it wi=
th zeroes
> +            if len(cluster) < cluster_size:
> +                cluster +=3D bytes(cluster_size - len(cluster))

This should be done only for the last cluster.

> +            # If a cluster has non-zero data then it must be allocated
> +            # in the output file and its L2 entry must be set
> +            if cluster !=3D zero_cluster:
> +                bitmap_set(l2_bitmap, idx)
> +                allocated_data_clusters +=3D 1
> +                # Allocated data clusters also need their corresponding =
L1 entry and L2 table
> +                l1_idx =3D math.floor(idx / l2_entries_per_table)
> +                if not bitmap_test(l1_bitmap, l1_idx):
> +                    bitmap_set(l1_bitmap, l1_idx)
> +                    allocated_l2_tables +=3D 1

This could be much more efficient using SEEK_DATA/SEEK_HOLE, avoiding readi=
ng
the entire image twice. Or using "qemu-img map --output json" to simplify.

For example:

    $ qemu-img create -f raw test.raw 1t
    Formatting 'test.raw', fmt=3Draw size=3D1099511627776

    $ time dd if=3Dtest.raw bs=3D1M of=3D/dev/null
    1048576+0 records in
    1048576+0 records out
    1099511627776 bytes (1.1 TB, 1.0 TiB) copied, 322.051 s, 3.4 GB/s

    real 5m22.054s
    user 0m0.463s
    sys 5m18.054s

    $ time qemu-img map --output json test.raw
    [{ "start": 0, "length": 262144, "depth": 0, "present": true,
"zero": false, "data": true, "offset": 0},
    { "start": 262144, "length": 1099511365632, "depth": 0, "present":
true, "zero": true, "data": false, "offset": 262144}]

    real 0m0.010s
    user 0m0.003s
    sys 0m0.006s

I think we can create the l2_bitmap from the json easily. If you want
to do zero detection you need to
read twice only the allocated clusters.

Parsing json from a big image can be slow but much faster than reading
the entire image
and doing zero detection by comparing 64k bytes.

> +
> +    # Total amount of allocated clusters excluding the refcount blocks a=
nd table
> +    total_allocated_clusters =3D 1 + allocated_l1_tables + allocated_l2_=
tables + allocated_data_clusters
> +
> +    # Clusters allocated for the refcount blocks and table
> +    allocated_refcount_blocks =3D math.ceil(total_allocated_clusters  / =
refcounts_per_block)
> +    allocated_refcount_tables =3D math.ceil(allocated_refcount_blocks / =
refcounts_per_table)
> +
> +    # Now we have a problem because allocated_refcount_blocks and alloca=
ted_refcount_tables...
> +    # (a) increase total_allocated_clusters, and
> +    # (b) need to be recalculated when total_allocated_clusters is incre=
ased
> +    # So we need to repeat the calculation as long as the numbers change
> +    while True:
> +        new_total_allocated_clusters =3D total_allocated_clusters + allo=
cated_refcount_tables + allocated_refcount_blocks
> +        new_allocated_refcount_blocks =3D math.ceil(new_total_allocated_=
clusters / refcounts_per_block)
> +        if new_allocated_refcount_blocks > allocated_refcount_blocks:
> +            allocated_refcount_blocks =3D new_allocated_refcount_blocks
> +            allocated_refcount_tables =3D math.ceil(allocated_refcount_b=
locks / refcounts_per_table)
> +        else:
> +            break
> +
> +    # Now that we have the final numbers we can update total_allocated_c=
lusters
> +    total_allocated_clusters +=3D allocated_refcount_tables + allocated_=
refcount_blocks
> +
> +    # At this point we have the exact number of clusters that the output
> +    # image is going to use so we can calculate all the offsets.
> +    current_cluster_idx =3D 1
> +
> +    refcount_table_offset =3D current_cluster_idx * cluster_size
> +    current_cluster_idx +=3D allocated_refcount_tables
> +
> +    refcount_block_offset =3D current_cluster_idx * cluster_size
> +    current_cluster_idx +=3D allocated_refcount_blocks
> +
> +    l1_table_offset =3D current_cluster_idx * cluster_size
> +    current_cluster_idx +=3D allocated_l1_tables
> +
> +    l2_table_offset =3D current_cluster_idx * cluster_size
> +    current_cluster_idx +=3D allocated_l2_tables
> +
> +    data_clusters_offset =3D current_cluster_idx * cluster_size
> +
> +    # Calculate some values used in the qcow2 header
> +    if allocated_l1_tables =3D=3D 0:
> +        l1_table_offset =3D 0
> +
> +    hdr_cluster_bits =3D int(math.log2(cluster_size))
> +    hdr_refcount_bits =3D 0
> +    hdr_length =3D 0
> +    if qcow2_version =3D=3D 3:
> +        hdr_refcount_bits =3D int(math.log2(refcount_bits))
> +        hdr_length =3D QCOW2_V3_HEADER_LENGTH
> +
> +    ### Write qcow2 header
> +    cluster =3D bytearray(cluster_size)
> +    struct.pack_into(">4sIQIIQIIQQIIQQQQII", cluster, 0,
> +        b"QFI\xfb",            # QCOW magic string
> +        qcow2_version,
> +        0,                     # backing file offset
> +        0,                     # backing file sizes
> +        hdr_cluster_bits,
> +        disk_size,
> +        0,                     # encryption method
> +        l1_entries,
> +        l1_table_offset,
> +        refcount_table_offset,
> +        allocated_refcount_tables,
> +        0,                     # number of snapshots
> +        0,                     # snapshot table offset
> +        0,                     # compatible features
> +        0,                     # incompatible features
> +        0,                     # autoclear features
> +        hdr_refcount_bits,
> +        hdr_length,
> +    )
> +
> +    if qcow2_version =3D=3D 3:
> +        write_features(cluster, hdr_length)
> +
> +    sys.stdout.buffer.write(cluster)
> +
> +    ### Write refcount table
> +    cur_offset =3D refcount_block_offset
> +    remaining_refcount_table_entries =3D allocated_refcount_blocks # Eac=
h entry is a pointer to a refcount block
> +    while remaining_refcount_table_entries > 0:
> +        cluster =3D bytearray(cluster_size)
> +        to_write =3D min(remaining_refcount_table_entries, refcounts_per=
_table)
> +        remaining_refcount_table_entries -=3D to_write
> +        for idx in range(to_write):
> +            struct.pack_into(">Q", cluster, idx * 8, cur_offset)
> +            cur_offset +=3D cluster_size
> +        sys.stdout.buffer.write(cluster)
> +
> +    ### Write refcount blocks
> +    remaining_refcount_block_entries =3D total_allocated_clusters # One =
entry for each allocated cluster
> +    for tbl in range(allocated_refcount_blocks):
> +        cluster =3D bytearray(cluster_size)
> +        to_write =3D min(remaining_refcount_block_entries, refcounts_per=
_block)
> +        remaining_refcount_block_entries -=3D to_write
> +        # All refcount entries contain the number 1. The only difference
> +        # is their bit width, defined when the image is created.
> +        for idx in range(to_write):
> +            if refcount_bits =3D=3D 64:
> +                struct.pack_into(">Q", cluster, idx * 8, 1)
> +            elif refcount_bits =3D=3D 32:
> +                struct.pack_into(">L", cluster, idx * 4, 1)
> +            elif refcount_bits =3D=3D 16:
> +                struct.pack_into(">H", cluster, idx * 2, 1)
> +            elif refcount_bits =3D=3D 8:
> +                cluster[idx] =3D 1
> +            elif refcount_bits =3D=3D 4:
> +                cluster[int(idx / 2)] |=3D 1 << ((idx % 2) * 4)
> +            elif refcount_bits =3D=3D 2:
> +                cluster[int(idx / 4)] |=3D 1 << ((idx % 4) * 2)
> +            elif refcount_bits =3D=3D 1:
> +                cluster[int(idx / 8)] |=3D 1 << (idx % 8)
> +        sys.stdout.buffer.write(cluster)
> +
> +    ### Write L1 table
> +    cur_offset =3D l2_table_offset
> +    for tbl in range(allocated_l1_tables):
> +        cluster =3D bytearray(cluster_size)
> +        for idx in range(l1_entries_per_table):
> +            l1_idx =3D tbl * l1_entries_per_table + idx
> +            if bitmap_test(l1_bitmap, l1_idx):
> +                struct.pack_into(">Q", cluster, idx * 8, cur_offset | QC=
OW_OFLAG_COPIED)
> +                cur_offset +=3D cluster_size
> +        sys.stdout.buffer.write(cluster)
> +
> +    ### Write L2 tables
> +    cur_offset =3D data_clusters_offset
> +    for tbl in range(l1_entries):
> +        # Skip the empty L2 tables. We can identify them because
> +        # there is no L1 entry pointing at them.
> +        if bitmap_test(l1_bitmap, tbl):
> +            cluster =3D bytearray(cluster_size)
> +            for idx in range(l2_entries_per_table):
> +                l2_idx =3D tbl * l2_entries_per_table + idx
> +                if bitmap_test(l2_bitmap, l2_idx):
> +                    struct.pack_into(">Q", cluster, idx * 8, cur_offset =
| QCOW_OFLAG_COPIED)
> +                    cur_offset +=3D cluster_size
> +            sys.stdout.buffer.write(cluster)
> +
> +    ### Write data clusters
> +    with open(input_file, "rb") as reader:
> +        skip =3D 0
> +        for idx in range(total_data_clusters):
> +            if bitmap_test(l2_bitmap, idx):
> +                if skip > 0:
> +                    reader.seek(cluster_size * skip, 1)
> +                    skip =3D 0
> +                cluster =3D reader.read(cluster_size)
> +                # If the last cluster is smaller than cluster_size pad i=
t with zeroes
> +                if len(cluster) < cluster_size:
> +                    cluster +=3D bytes(cluster_size - len(cluster))

This can be done only for the last cluster.

> +                sys.stdout.buffer.write(cluster)
> +            else:
> +                skip +=3D 1

If would be easier to work with if you add a function iterating over the
l2_entries, yielding the he cluster index to copy:

  def iter_l2_entries(bitmap, clusters):
    for idx in range(clusters):
      if bitmap_test(bitmap, idx):
        yield idx

The copy loop can read using os.pread():

    for idx in iter_l2_entries(l2_bitmap, total_data_clusters):
        cluster =3D os.pread(fd, cluster_size, cluster_size * idx)
        sys.stdout.buffer.write(cluster)

I'm not sure the offset is right in my example, it is hard to
understand the semantics
of skip in your code.

> +
> +
> +if __name__ =3D=3D "__main__":

Usually code is easier to work with when __main__  calls main().

For example:

  def main():
    args =3D parse_args()
    validate args...
    actual work...

  if __name__ =3D=3D '__main__':
    main()

This does not leak unwanted global variables from code parsing
arguments, and we can test any function
if needed. This is also more consistent since we can write any script
using this style.

> +    # Command-line arguments
> +    parser =3D argparse.ArgumentParser(

parser is global - is this intended?

> +        description=3D"This program converts a QEMU disk image to qcow2 =
"
> +        "and writes it to the standard output"
> +    )
> +    parser.add_argument("input_file", help=3D"name of the input file")
> +    parser.add_argument(
> +        "-f",
> +        dest=3D"input_format",
> +        metavar=3D"input_format",
> +        default=3D"raw",
> +        help=3D"format of the input file (default: raw)",
> +    )
> +    parser.add_argument(
> +        "-c",
> +        dest=3D"cluster_size",
> +        metavar=3D"cluster_size",
> +        help=3Df"qcow2 cluster size (default: {QCOW2_DEFAULT_CLUSTER_SIZ=
E})",
> +        default=3DQCOW2_DEFAULT_CLUSTER_SIZE,
> +        type=3Dint,
> +        choices=3D[1 << x for x in range(9, 22)],
> +    )
> +    parser.add_argument(
> +        "-r",
> +        dest=3D"refcount_bits",
> +        metavar=3D"refcount_bits",
> +        help=3Df"width of the reference count entries (default: {QCOW2_D=
EFAULT_REFCOUNT_BITS})",
> +        default=3DQCOW2_DEFAULT_REFCOUNT_BITS,
> +        type=3Dint,
> +        choices=3D[1 << x for x in range(7)],
> +    )
> +    parser.add_argument(
> +        "-v",
> +        dest=3D"qcow2_version",
> +        metavar=3D"qcow2_version",
> +        help=3Df"qcow2 version (default: {QCOW2_DEFAULT_VERSION})",
> +        default=3DQCOW2_DEFAULT_VERSION,
> +        type=3Dint,
> +        choices=3D[2, 3],
> +    )
> +    args =3D parser.parse_args()

args is global, is this intended?

> +
> +    if not os.path.isfile(args.input_file):
> +        sys.exit(f"[Error] {args.input_file} does not exist or is not a =
regular file.")
> +
> +    if args.refcount_bits !=3D 16 and args.qcow2_version !=3D 3:
> +        sys.exit(f"[Error] refcount_bits=3D{args.refcount_bits} is only =
supported with qcow2_version=3D3.")
> +
> +    if sys.stdout.isatty():
> +        sys.exit("[Error] Refusing to write to a tty. Try redirecting st=
dout.")
> +
> +    with get_input_as_raw_file(args.input_file, args.input_format) as ra=
w_file:

raw_file is global, is this intended?

> +        create_qcow2_file(

The name does not reflect what the function does - this does not
create a qcow2 file, but write
a qcow2 content to stdout. Maybe write_qcow2_content()?

> +            raw_file,
> +            args.cluster_size,
> +            args.refcount_bits,
> +            args.qcow2_version,
> +        )
> --
> 2.39.2
>
>

Nir


