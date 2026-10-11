Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4009ACA9EC7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFwP7-0001aF-Qp; Sun, 11 Oct 2026 12:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFwP5-0001ZN-Ta
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 12:28:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFwP3-00078V-Us
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 12:28:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85ZE61946440
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 16:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=09nA4JNp4Q+
 xcM7sqdw3bupnKCqQJZVniniVyl1PCb4=; b=RGqImn4S99BhouvjNsTpRlrVugi
 BzFcN2oyDbfs1ldDMIaENbyD+opSTHqIGuyPn9rCJDvk0RfKZQwH1Gz8Al+/aSGM
 2uQ87AukpK0DnK3HkvT4tRO8f7JYETIII5LB3I5nT9qE1Xhjfzlh8ocorPIWl3qU
 sOktfKwPHd+eSKLC/tgFR1GglPvp1mLkoc8ksD1h4HbhcGnsrB0bWDfiQKQGBAMH
 UjXPUEgtl2FGYkJqA5qtzGAQVtWR456W4fhth790p7P1qyklWJrWs9JN7io+hQU7
 sVxpoRKFM8b7TvX4Ywt4OE72thb+ff+UUN4Lr84LgTAU1puPqIxmQBarg0g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dr7katn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 16:28:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so2889209eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791736080; x=1792340880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=09nA4JNp4Q+xcM7sqdw3bupnKCqQJZVniniVyl1PCb4=;
 b=XXSPJFMCVhGS7H87wx3exPDEjeGulLPUPmgMCEY0Z3Eo2CnmwzTPIGbdM6rxXe8BZo
 kh8T6Kz6Mc9StODRahDHLaxONz2/5cjEgMKENnawvayHtPdFkJTD8P0/2CJD0I6pU6YR
 6ZppqDAMRKYXP3d10pclP/tF7TvW7YwLctrTNJkeqQgUelZkmvLgnkOpuxG9USF3s34K
 ZlPsMRW1d3eO4ZXon5I+TLh5h0qy1vIzG1+3tIiraitNO3kVEQppRWUMj52cfag2u39j
 wqKXMqP+LvzOL8MR0p5ISMBHuDxYRrY0IOV+/zxRk6uGmH/b7Klr6aZHU457kf0dphgk
 dRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791736080; x=1792340880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=09nA4JNp4Q+xcM7sqdw3bupnKCqQJZVniniVyl1PCb4=;
 b=LLnI98qm4d85CFI2vlueJU+gMSzGMYLv2HLx/U3DxD5rQCfOCsEjrk2CWLKXxAUfZ+
 aPL6se2vkM6OwidD80gSx19tbew9c0Y10ZOstxfVZsZcuDABRLivaHnI02PnvCP1X6ri
 mxcJ5wNwHBSa1a92iAfWPxerS1xOoZ3pSL9Pm1m1qJkrDAK3hmove5Znt3HbElIAAkq9
 KPz7wTm2gXL20Td9HyUNbFxjW6c3nEvRNpQWjcbcGYUlSjTD8etJMgMW0mFS4NZWeg5Y
 9x51xYwbNPPZC6hQJ8F9se5RP/hxvo6fpH+AgYJQ0307lywWH9eRMAf1ZZwD2rconl3j
 /dzA==
X-Gm-Message-State: AFq9FYIEyhOIgniUqXDHNqcO1PyicnMN1B4cOPmjKbOGhfWsqJ6K9M4m
 sJiXMbBI/dC3wK21314kCzYrroOSGsOn8o2Be2JLPf/QE460hy7mzX0VDFbWTkMpc8Z01xMViNX
 gnmJDE57PwR99envE5yldsgU0jJILzFJp91SJA7k4HB1xboqoj2mPPjTaU/069V9ojw==
X-Gm-Gg: AYBFou0q4cgihb78G7lqp0v/aPoTo8OQkZKLcFSywXEMF+FbPN3+us9JGqnFq6hSciy
 SsqrUqraXTlwCLztY/RgaQ+WfzXfbDVi5zqrH+pd7e0o94KGGWvlql/A5J9YLOG6ThDcpb9C43q
 Nsi881iQLUHB4ymsVdCoFvVryAZJKyt4g4vpsdMA/67wlZYm++GRcgqlIFkX3+u3WStWNzLZHGV
 UiAr6ktcfgtUZm2e2UE88y4jm14Y5t+288UjOCpoDpYLcEp7z0GAaEyFgsWko+L+RJ+lYFVbiDE
 N7FQlV4O5nbqy+ksjcY8taNeENBKdaVxaZ6o4ol9FzF749iagDtr7dgQX4NIN0z915EebygVsCF
 jjbrtClfi5nBnTvKwc/yxKvCXPiznkzr60wBnsIARO/aSLgh2tkFow9fu0bwl
X-Received: by 2002:a05:701b:21db:b0:166:29a2:f83f with SMTP id
 a92af1059eb24-16a56ab04e9mr10493565c88.5.1791736079999; 
 Sun, 11 Oct 2026 09:27:59 -0700 (PDT)
X-Received: by 2002:a05:701b:21db:b0:166:29a2:f83f with SMTP id
 a92af1059eb24-16a56ab04e9mr10493536c88.5.1791736079408; 
 Sun, 11 Oct 2026 09:27:59 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becf08sm25001242c88.5.2026.10.11.09.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 09:27:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peterx@redhat.com, mjt@tls.msk.ru
Subject: [PATCH v2 3/3] scripts: add generate_release_links.sh
Date: Sun, 11 Oct 2026 16:27:37 +0000
Message-ID: <20261011162737.3024-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xmxJF8jfWmwXCzChy6nRZyy62jXsuz2G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA2NSBTYWx0ZWRfX3jaiBwjQiDgH
 G/skGStN+4SG0J17VRuG7vYQtAEbGV4bB7pSA1aceKC+8WjSNtovJxqN4Lks5EL+DvPZSeFUsxM
 9cH68onfCi5T1UhZqJljeVzKxPZY26k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA2NSBTYWx0ZWRfXwH/oQPif3Npk
 uqtfM1pITT1/AtTOxOwvV83eI8lmn8QtbXAuyOpxCzBGKPsX2PguXJbkdp4DhY/2aU8+n40tINC
 H3Xjv5JJkm4RbKhDAIBPg3ud6t4gQgUB72AGmhJUxYIaEXPGInNbbEITTl2yJI984y+sti+rq+w
 RiRoQF+4ydVhm7QRG1rY6K2zeEDaQwgxVdXGJ8dgdBGtvvtJFT3fbsub8wmI3+4M+Lk7S7TyNk0
 31EfJ6pHUNN2xKkINon4Z7CW4vn94eL3+fvnOvxfbh3QD6tuuy4BkFer+AdfZ5yejia0+LV+4XD
 J8WolF5uwzixZInTMf9gLGakBx7webNtQhSPJD7fqgA8BsO9eEkfAxwMJpAEhVGUi+t7hG/GAYw
 oUO8mc6f0Gh3AF6ZhVPrydMZDtka99Gst1FhpPvDMIUtZhaXD5UxxiWemPPgl6UYrqYtSFgK8d7
 RW8EcMqJ+8DAiATb4Vg==
X-Proofpoint-GUID: xmxJF8jfWmwXCzChy6nRZyy62jXsuz2G
X-Authority-Analysis: v=2.4 cv=asknmiZV c=1 sm=1 tr=0 ts=6acbb911 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=n6MYwUk4AAAA:8
 a=EUspDBNiAAAA:8 a=z6BG1H5jNmwsGlzAzHUA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Now that it's easy to build containers for all QEMU versions, we can go
further and offer "links" (scripts) to all qemu binaries from all
versions.

Note: this is based on prebuilt container images, that are hosted on my
dockerhub (https://hub.docker.com/repository/docker/pboqemu/qemu-releases).
If there is enough interest, I would be happy to relocate that on an
official QEMU registry, or even add it to our CI in case people get
paranoid about where those binaries come from.

$ ./scripts/generate_release_links.sh qemu-releases/
$ ./qemu-releases/v1.6.1/qemu-system-arm --version
QEMU emulator version 1.6.1, Copyright (c) 2003-2008 Fabrice Bellard
$ ./qemu-releases/v10.0.0/qemu-system-arm --version
QEMU emulator version 10.0.0 (v10.0.0)
Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers

Container engine automatically download and runs the right image, so no
build is needed on developer machine.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/generate_release_links.sh | 71 +++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100755 scripts/generate_release_links.sh

diff --git a/scripts/generate_release_links.sh b/scripts/generate_release_links.sh
new file mode 100755
index 00000000000..2213f0f56cb
--- /dev/null
+++ b/scripts/generate_release_links.sh
@@ -0,0 +1,71 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+script_dir=$(dirname $(readlink -f $0))
+
+if [ $# -ne 1 ]; then
+    echo "usage: out_folder"
+    exit 1
+fi
+
+out=$1;shift
+
+releases()
+{
+    git tag --sort=creatordate |
+        grep '^v[0-9]' |
+        grep -A 10000 'v1\.6\.1' |
+        grep -v '\-rc[0-9]$'
+}
+
+qemu_targets()
+{
+    version=$1;shift
+    git ls-tree -r $version --name-only configs default-configs |
+        grep configs.*mak |
+        sed -e 's#.*/##' -e 's#\.mak$##' |
+        sort -u
+}
+
+softmmu_binaries()
+{
+    qemu_targets "$@" |
+        grep softmmu |
+        sed -e 's/-softmmu//' -e 's/^/qemu-system-/'
+}
+
+linux_user_binaries()
+{
+    qemu_targets "$@" |
+        grep linux-user |
+        sed -e 's/-linux-user//' -e 's/^/qemu-/'
+}
+
+root=$(readlink -f $script_dir/..)
+docker=$($root/tests/docker/docker.py probe)
+userns=
+if echo "$docker" | grep -q podman; then
+    userns="--userns=keep-id"
+fi
+
+registry=docker.io/pboqemu/qemu-releases
+for release in $(releases); do
+    echo "generate links for $release"
+    public_image=$registry:$release
+    mkdir -p $out/$release
+    for bin in $(softmmu_binaries $release) $(linux_user_binaries $release); do
+        script=$out/$release/$bin
+        cat > $script << EOF
+#!/usr/bin/env bash
+
+here=\$(pwd)
+exec $docker run -it --rm -u $UID $userns \\
+     --security-opt label=disable \\
+     -w \$(pwd) -v \$(pwd):\$(pwd) \\
+     $public_image $bin "\$@"
+EOF
+        chmod +x $script
+    done
+done
-- 
2.43.0


