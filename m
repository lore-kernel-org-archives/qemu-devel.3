Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483CCC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrk6-0004Om-J8; Mon, 22 Jul 2024 08:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVrj6-0007uE-UP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVrj4-0006Ym-LN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rj49d4XXo+Edwczy2OO88b+MxeGI1+Y6yHHpkfnHE/w=;
 b=awgE3Q5u/J+CYaESoKr3ss/MfMDaQVgnyfghmlzwotbKa8Psz2/WvSd8A2wHHF2zAgCfV3
 LWPEby5WdkPDoESjSrSiUxDPDRJW+WV1YT12+bIV+U4Gpe6bZX36rZmhqXheXn8RROxtYe
 W43vL2/LevQ6aCJsxZ5Ffs3RuJ7wnwA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-y8KHT0H5MuKqkJIcZKUaxw-1; Mon,
 22 Jul 2024 08:01:08 -0400
X-MC-Unique: y8KHT0H5MuKqkJIcZKUaxw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 978501955D57; Mon, 22 Jul 2024 12:01:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.179])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAB981944A88; Mon, 22 Jul 2024 12:00:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 07/12] tests/avocado: Remove the remainders of the
 virtiofs_submounts test
Date: Mon, 22 Jul 2024 14:00:21 +0200
Message-ID: <20240722120026.675449-8-thuth@redhat.com>
In-Reply-To: <20240722120026.675449-1-thuth@redhat.com>
References: <20240722120026.675449-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

The virtiofs_submounts test has been removed in commit 5da7701e2a
("virtiofsd: Remove test"), so we don't need this files anymore.

Message-ID: <20240718173125.489901-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../virtiofs_submounts.py.data/cleanup.sh     |  46 ------
 .../guest-cleanup.sh                          |  30 ----
 .../virtiofs_submounts.py.data/guest.sh       | 138 ------------------
 .../virtiofs_submounts.py.data/host.sh        | 127 ----------------
 4 files changed, 341 deletions(-)
 delete mode 100644 tests/avocado/virtiofs_submounts.py.data/cleanup.sh
 delete mode 100644 tests/avocado/virtiofs_submounts.py.data/guest-cleanup.sh
 delete mode 100644 tests/avocado/virtiofs_submounts.py.data/guest.sh
 delete mode 100644 tests/avocado/virtiofs_submounts.py.data/host.sh

diff --git a/tests/avocado/virtiofs_submounts.py.data/cleanup.sh b/tests/avocado/virtiofs_submounts.py.data/cleanup.sh
deleted file mode 100644
index 2a6579a0fe..0000000000
--- a/tests/avocado/virtiofs_submounts.py.data/cleanup.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/bash
-
-function print_usage()
-{
-    if [ -n "$2" ]; then
-        echo "Error: $2"
-        echo
-    fi
-    echo "Usage: $1 <scratch dir>"
-}
-
-scratch_dir=$1
-if [ -z "$scratch_dir" ]; then
-    print_usage "$0" 'Scratch dir not given' >&2
-    exit 1
-fi
-
-cd "$scratch_dir/share" || exit 1
-mps=(mnt*)
-mp_i=0
-for mp in "${mps[@]}"; do
-    mp_i=$((mp_i + 1))
-    printf "Unmounting %i/%i...\r" "$mp_i" "${#mps[@]}"
-
-    sudo umount -R "$mp"
-    rm -rf "$mp"
-done
-echo
-
-rm some-file
-cd ..
-rmdir share
-
-imgs=(fs*.img)
-img_i=0
-for img in "${imgs[@]}"; do
-    img_i=$((img_i + 1))
-    printf "Detaching and deleting %i/%i...\r" "$img_i" "${#imgs[@]}"
-
-    dev=$(losetup -j "$img" | sed -e 's/:.*//')
-    sudo losetup -d "$dev"
-    rm -f "$img"
-done
-echo
-
-echo 'Done.'
diff --git a/tests/avocado/virtiofs_submounts.py.data/guest-cleanup.sh b/tests/avocado/virtiofs_submounts.py.data/guest-cleanup.sh
deleted file mode 100644
index 729cb2d1a5..0000000000
--- a/tests/avocado/virtiofs_submounts.py.data/guest-cleanup.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/bash
-
-function print_usage()
-{
-    if [ -n "$2" ]; then
-        echo "Error: $2"
-        echo
-    fi
-    echo "Usage: $1 <scratch dir>"
-}
-
-scratch_dir=$1
-if [ -z "$scratch_dir" ]; then
-    print_usage "$0" 'Scratch dir not given' >&2
-    exit 1
-fi
-
-cd "$scratch_dir/share" || exit 1
-
-mps=(mnt*)
-mp_i=0
-for mp in "${mps[@]}"; do
-    mp_i=$((mp_i + 1))
-    printf "Unmounting %i/%i...\r" "$mp_i" "${#mps[@]}"
-
-    sudo umount -R "$mp"
-done
-echo
-
-echo 'Done.'
diff --git a/tests/avocado/virtiofs_submounts.py.data/guest.sh b/tests/avocado/virtiofs_submounts.py.data/guest.sh
deleted file mode 100644
index 59ba40fde1..0000000000
--- a/tests/avocado/virtiofs_submounts.py.data/guest.sh
+++ /dev/null
@@ -1,138 +0,0 @@
-#!/bin/bash
-
-function print_usage()
-{
-    if [ -n "$2" ]; then
-        echo "Error: $2"
-        echo
-    fi
-    echo "Usage: $1 <shared dir>"
-    echo '(The shared directory is the "share" directory in the scratch' \
-         'directory)'
-}
-
-shared_dir=$1
-if [ -z "$shared_dir" ]; then
-    print_usage "$0" 'Shared dir not given' >&2
-    exit 1
-fi
-
-cd "$shared_dir"
-
-# FIXME: This should not be necessary, but it is.  In order for all
-# submounts to be proper mount points, we need to visit them.
-# (Before we visit them, they will not be auto-mounted, and so just
-# appear as normal directories, with the catch that their st_ino will
-# be the st_ino of the filesystem they host, while the st_dev will
-# still be the st_dev of the parent.)
-# `find` does not work, because it will refuse to touch the mount
-# points as long as they are not mounted; their st_dev being shared
-# with the parent and st_ino just being the root node's inode ID
-# will practically ensure that this node exists elsewhere on the
-# filesystem, and `find` is required to recognize loops and not to
-# follow them.
-# Thus, we have to manually visit all nodes first.
-
-mnt_i=0
-
-function recursively_visit()
-{
-    pushd "$1" >/dev/null
-    for entry in *; do
-        if [[ "$entry" == mnt* ]]; then
-            mnt_i=$((mnt_i + 1))
-            printf "Triggering auto-mount $mnt_i...\r"
-        fi
-
-        if [ -d "$entry" ]; then
-            recursively_visit "$entry"
-        fi
-    done
-    popd >/dev/null
-}
-
-recursively_visit .
-echo
-
-
-if [ -n "$(find -name not-mounted)" ]; then
-    echo "Error: not-mounted files visible on mount points:" >&2
-    find -name not-mounted >&2
-    exit 1
-fi
-
-if [ ! -f some-file -o "$(cat some-file)" != 'root' ]; then
-    echo "Error: Bad file in the share root" >&2
-    exit 1
-fi
-
-shopt -s nullglob
-
-function check_submounts()
-{
-    local base_path=$1
-
-    for mp in mnt*; do
-        printf "Checking submount %i...\r" "$((${#devs[@]} + 1))"
-
-        mp_i=$(echo "$mp" | sed -e 's/mnt//')
-        dev=$(stat -c '%D' "$mp")
-
-        if [ -n "${devs[mp_i]}" ]; then
-            echo "Error: $mp encountered twice" >&2
-            exit 1
-        fi
-        devs[mp_i]=$dev
-
-        pushd "$mp" >/dev/null
-        path="$base_path$mp"
-        while true; do
-            expected_content="$(printf '%s\n%s\n' "$mp_i" "$path")"
-            if [ ! -f some-file ]; then
-                echo "Error: $PWD/some-file does not exist" >&2
-                exit 1
-            fi
-
-            if [ "$(cat some-file)" != "$expected_content" ]; then
-                echo "Error: Bad content in $PWD/some-file:" >&2
-                echo '--- found ---'
-                cat some-file
-                echo '--- expected ---'
-                echo "$expected_content"
-                exit 1
-            fi
-            if [ "$(stat -c '%D' some-file)" != "$dev" ]; then
-                echo "Error: $PWD/some-file has the wrong device ID" >&2
-                exit 1
-            fi
-
-            if [ -d sub ]; then
-                if [ "$(stat -c '%D' sub)" != "$dev" ]; then
-                    echo "Error: $PWD/some-file has the wrong device ID" >&2
-                    exit 1
-                fi
-                cd sub
-                path="$path/sub"
-            else
-                if [ -n "$(echo mnt*)" ]; then
-                    check_submounts "$path/"
-                fi
-                break
-            fi
-        done
-        popd >/dev/null
-    done
-}
-
-root_dev=$(stat -c '%D' some-file)
-devs=()
-check_submounts ''
-echo
-
-reused_devs=$(echo "$root_dev ${devs[@]}" | tr ' ' '\n' | sort | uniq -d)
-if [ -n "$reused_devs" ]; then
-    echo "Error: Reused device IDs: $reused_devs" >&2
-    exit 1
-fi
-
-echo "Test passed for ${#devs[@]} submounts."
diff --git a/tests/avocado/virtiofs_submounts.py.data/host.sh b/tests/avocado/virtiofs_submounts.py.data/host.sh
deleted file mode 100644
index d8a9afebdb..0000000000
--- a/tests/avocado/virtiofs_submounts.py.data/host.sh
+++ /dev/null
@@ -1,127 +0,0 @@
-#!/bin/bash
-
-mount_count=128
-
-function print_usage()
-{
-    if [ -n "$2" ]; then
-        echo "Error: $2"
-        echo
-    fi
-    echo "Usage: $1 <scratch dir> [seed]"
-    echo "(If no seed is given, it will be randomly generated.)"
-}
-
-scratch_dir=$1
-if [ -z "$scratch_dir" ]; then
-    print_usage "$0" 'No scratch dir given' >&2
-    exit 1
-fi
-
-if [ ! -d "$scratch_dir" ]; then
-    print_usage "$0" "$scratch_dir is not a directory" >&2
-    exit 1
-fi
-
-seed=$2
-if [ -z "$seed" ]; then
-    seed=$RANDOM
-fi
-RANDOM=$seed
-
-echo "Seed: $seed"
-
-set -e
-shopt -s nullglob
-
-cd "$scratch_dir"
-if [ -d share ]; then
-    echo 'Error: This directory seems to be in use already' >&2
-    exit 1
-fi
-
-for ((i = 0; i < $mount_count; i++)); do
-    printf "Setting up fs %i/%i...\r" "$((i + 1))" "$mount_count"
-
-    rm -f fs$i.img
-    truncate -s 512M fs$i.img
-    mkfs.xfs -q fs$i.img
-    devs[i]=$(sudo losetup -f --show fs$i.img)
-done
-echo
-
-top_level_mounts=$((RANDOM % mount_count + 1))
-
-mkdir -p share
-echo 'root' > share/some-file
-
-for ((i = 0; i < $top_level_mounts; i++)); do
-    printf "Mounting fs %i/%i...\r" "$((i + 1))" "$mount_count"
-
-    mkdir -p share/mnt$i
-    touch share/mnt$i/not-mounted
-    sudo mount "${devs[i]}" share/mnt$i
-    sudo chown "$(id -u):$(id -g)" share/mnt$i
-
-    pushd share/mnt$i >/dev/null
-    path=mnt$i
-    nesting=$((RANDOM % 4))
-    for ((j = 0; j < $nesting; j++)); do
-        cat > some-file <<EOF
-$i
-$path
-EOF
-        mkdir sub
-        cd sub
-        path="$path/sub"
-    done
-cat > some-file <<EOF
-$i
-$path
-EOF
-    popd >/dev/null
-done
-
-for ((; i < $mount_count; i++)); do
-    printf "Mounting fs %i/%i...\r" "$((i + 1))" "$mount_count"
-
-    mp_i=$((i % top_level_mounts))
-
-    pushd share/mnt$mp_i >/dev/null
-    path=mnt$mp_i
-    while true; do
-        sub_mp="$(echo mnt*)"
-        if cd sub 2>/dev/null; then
-            path="$path/sub"
-        elif [ -n "$sub_mp" ] && cd "$sub_mp" 2>/dev/null; then
-            path="$path/$sub_mp"
-        else
-            break
-        fi
-    done
-    mkdir mnt$i
-    touch mnt$i/not-mounted
-    sudo mount "${devs[i]}" mnt$i
-    sudo chown "$(id -u):$(id -g)" mnt$i
-
-    cd mnt$i
-    path="$path/mnt$i"
-    nesting=$((RANDOM % 4))
-    for ((j = 0; j < $nesting; j++)); do
-        cat > some-file <<EOF
-$i
-$path
-EOF
-        mkdir sub
-        cd sub
-        path="$path/sub"
-    done
-    cat > some-file <<EOF
-$i
-$path
-EOF
-    popd >/dev/null
-done
-echo
-
-echo 'Done.'
-- 
2.45.2


