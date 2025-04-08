Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3165C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 20:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2FM1-0002TL-Br; Tue, 08 Apr 2025 16:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1u2FLg-0002GG-M0
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:15:15 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1u2FLX-0004yD-Pf
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:15:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 70807446A5;
 Tue,  8 Apr 2025 20:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0C9DC4CEEA;
 Tue,  8 Apr 2025 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744143294;
 bh=nhhtsinaOBQHNfYgiTQPRXdYH8S92/y0v4vPFKB9/BA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=n4FHa5nKGLwiNjZWyknh8Ys0s7GHb6D7QIT/TGjENqMT8Kv1sdg/wkFZq83LlRm43
 pMaikmFkJZsGPh25Uf37VxFhPGAZ/n8p4gsDA+rFJHFge8GMf5BLGDJn8tilzTZtv/
 DdLSA6+PP24V/Uww7BC6eIygHsXBnGUu5ELCRizBsrwCAVwArC7HtoPHZMNizx3VSN
 by8+F5E34bBYqNMoWdONyOa/XBFDgbOwXHon3OAv8Wcov6EcvWKyDMkhwhjx/RhZk/
 G3VOTca60/Tb0hmc+uPLgNNoDD9LQumiFNS4WKYUbGGq147qfstoCPRnR5w6+3oYfR
 Ufhsa+m4Ndqyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DB8B3C369A6;
 Tue,  8 Apr 2025 20:14:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 08 Apr 2025 22:14:47 +0200
Subject: [PATCH 2/3] scripts: Add root dir to arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-jag-sysctl-v1-2-3f4f38b751be@kernel.org>
References: <20250408-jag-sysctl-v1-0-3f4f38b751be@kernel.org>
In-Reply-To: <20250408-jag-sysctl-v1-0-3f4f38b751be@kernel.org>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3596;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=nhhtsinaOBQHNfYgiTQPRXdYH8S92/y0v4vPFKB9/BA=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGf1g7v/y9Ezk1NvJXRjuojbd77VkNpWMHK8I
 9p1k0WWuCKa24kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn9YO7AAoJELqXzVK3
 lkFPXjML/23NQ8FqFqNI86LpKGfSCW6r9yPdBw0TMaXu/pPYyUVr0TIv2SAq/7+7KYrk825rIvj
 rv7zSvKgg8DAHGqc2cakgTraHjmHxhw2QECqZG7+CF4ZNczefUucxtYFXE52YFupGCXc42ZC3n/
 99J7SxyhIVict88P5hnj0M8GM/TFcD+q59u+jF9aEueXggYFS4QZ64Hy3n4XNTKdGhOLWEbOe+v
 rdjBnVRMp8sgOJL/P0Tyr2gcMBKpaKIICj8c3nHr8ZOqNK8YARRN9uExb6EwHGaTiC+/oJJyyJw
 5HbWEL01XRGF4nxan2vvuzXDbUvc3kl7huVtOlqbVlkWBK5tRnAwS9JT/cEL7jNWxbBvPe4XIkm
 MeU77gVhgwNtthGJGfFS1bPOpLf38mnrdjw/JwhAPT0hosfdHxymSdtrvAHC6BOJVyWwEQL5dtU
 6sqv9BovTZ57dYyQuh7MHl1RWqXWIdFCpp1gPAyWyMFYeUzYgHYd2zl2CWJvbOvp9WNhcsGw628
 WQ=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=joel.granados@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The archive-source script appended everything directly on the tar root
making it unusable for creating nix overlays; nix expects all files to
be under a directory in the tarbal.

Add a "-d|--dir" argument that places all files under a custom root.
Behaviour is unchanged when the argument is not given.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 scripts/archive-source.sh | 78 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 15 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index a469a5e2dec4b05e51474f0a1af190c1ccf23c7e..7143aaefc1133fe991b329df3c78e6ed7726322f 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -9,19 +9,6 @@
 # This code is licensed under the GPL version 2 or later.  See
 # the COPYING file in the top-level directory.
 
-error() {
-    printf %s\\n "$*" >&2
-    exit 1
-}
-
-if test $# -lt 1; then
-    error "Usage: $0 <output tarball>"
-fi
-
-tar_file=$(realpath "$1")
-sub_tdir=$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")
-sub_file="${sub_tdir}/submodule.tar"
-
 # We want a predictable list of submodules for builds, that is
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
@@ -32,6 +19,61 @@ subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 sub_deinit=""
+git_archive_prefix=""
+tar_transform=""
+
+BASENAME="$(basename "${BASH_SOURCE[0]}")"
+USAGE="Usage: ${BASENAME} [OPTIONS] <tarball>
+  <tarball>             Resulting tarball name
+
+  OPTIONS:
+    -d, --dir <DIR>     Files will be placed into DIR inside the tarball
+"
+
+error() {
+    printf %s\\n "$*" >&2
+    exit 1
+}
+
+get_opts() {
+    local short="d:"
+    local long="dir:"
+
+    if ! tmp=$(getopt -o "$short" --long "$long" -n "$BASENAME" -- "$@"); then
+        exit 1
+    fi
+    eval set -- "$tmp"
+    unset tmp
+
+    while true; do
+      case "$1" in
+        '-d' | '--dir' )
+            local tar_dir_name=$"$2/"; shift 2
+            git_archive_prefix="--prefix ${tar_dir_name}"
+            tar_transform="--transform=s|^|${tar_dir_name}|"
+            ;;
+
+        '--' )
+            shift 1
+            ;;
+
+        * )
+            tar_file_name="$1"; shift
+            break
+            ;;
+
+      esac
+    done
+
+    if [ $# -gt 0 ]; then
+        echo "Superfluous args: $@"
+        error "${USAGE}"
+    fi
+
+    tar_file=$(realpath "$tar_file_name")
+    sub_tdir=$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")
+    sub_file="${sub_tdir}/submodule.tar"
+}
 
 function cleanup() {
     local status=$?
@@ -73,13 +115,19 @@ function subproject_dir() {
     echo "${dir:-$1}"
 }
 
-git archive --format tar "$(tree_ish)" > "$tar_file"
+get_opts "$@"
+
+git archive --format tar ${git_archive_prefix} "$(tree_ish)" > "$tar_file"
 test $? -ne 0 && error "failed to archive qemu"
 
 for sp in $subprojects; do
     meson subprojects download $sp
     test $? -ne 0 && error "failed to download subproject $sp"
-    tar --append --file "$tar_file" --exclude=.git subprojects/"$(subproject_dir $sp)"
+    tar --append \
+        --file "$tar_file" \
+        --exclude=.git \
+        ${tar_transform} \
+        subprojects/"$(subproject_dir $sp)"
     test $? -ne 0 && error "failed to append subproject $sp to $tar_file"
 done
 exit 0

-- 
2.44.1



