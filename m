Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840CBCC6B22
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 00:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnFw-00078p-AB; Tue, 13 Oct 2026 20:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnFu-000784-Er
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:54:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnFs-0004Km-KL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:54:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHuoUZ1125161
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cG+9+UjqU73
 mLQsoMNj8wRvHWfQWm5DtP5psJ0TsNd4=; b=NuEUBkeanpOskhYE0SDSgkaBnNC
 a8OlBRxZUGqqJfJPsDhP0FCkAS7H6TlnlcpHP/E8EIPYHjj3WMkTzWBE/nPKp+1Y
 G8eQnI3lqrShrBRLea9UZ5HTBfOsvPtTV22PcImeJ1BQ4XOFlgk4iC5XD7z+NGAx
 tspjT7il1+nRBAbzKPKIoHX/infLq3oR7uEZax34AMCkAPeCi1f6VTEW9+QTguqp
 tH2ejPgmhjp/loVxYBheGyPEz4c9bLX4Dmu0vFHeWytpVVsv8QQkqN8yn5Ptd2SR
 q2k5vk5blM+mkCHaJ//J437DR9rW8+Ykw00umxEQKJsUECsWo6ds1XIXbsw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sg81fvr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:54:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso6025773eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791939241; x=1792544041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cG+9+UjqU73mLQsoMNj8wRvHWfQWm5DtP5psJ0TsNd4=;
 b=SkjMKIEvsckXyeZQsCSP5H3Hw6xfyeKVkYPEbS/p0md7BapU82XzSchz1TxLIlrf+z
 EoR/++9Oti4EwDr+FbuDKzOoxXm8Ecji4VZmuxqLdiolCG28j6FnT4kwj+iwTeCMeliN
 SIl35kO0ykB2JhuG4XF9qj51KO24zvY9AgdVmQpVneNHLOK30feYu//3+yZLdGebsrrR
 1El6WSQDVcIrTrZuq8wjXXTaDDbfICKV4Vxy9uEuxJCoWim2fpgGsJtWD7pLGEBQAs9W
 lXHz+zREKaXw2qKd3wp9xKIfz7K+mCpQyESkX05JvVZOugQ09tYABPpPE08a5h2Gh6Jg
 +lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791939241; x=1792544041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cG+9+UjqU73mLQsoMNj8wRvHWfQWm5DtP5psJ0TsNd4=;
 b=Hxr3g5XOuA8yu1gBbNwjTsc+LlIYwo5PcBYfkjNZToDXfY5+Bn9UNq9+aqQeq+Pww2
 VhkYZ6fOEBx6LqNogHbEbZ6++xWOLPbXdZ3OLLwOcnFFn+O04InykJ+LkM4h+9iIWdAa
 vWD6MJG4TI0hke0FYkwMfaG5B0xaPWOrY4Bdyed39WgCR+t0u5dIe95Rp2kd7VAGipo9
 rLrDfaKRamNZLedcJonDO+n5xgsAhpbHcx58gV8GK10smP26OYrEHsClKh7bX8iXVTkH
 uIpgoqKv7b4pZSDKh7SL93PC8cPE0rIsDVWjdkxmFJg1hR8r1/tcQepOncmKmK+7GqIW
 60Lg==
X-Gm-Message-State: AFq9FYL4mytiUdVKKV4josZ/M/fSubUo+J4kw8tF5RvCFOFxdRxXriMa
 PQ/Il+rVlnJN3B6dGT3B+tHr8UvUIqGAOeKfDhJXzsoTfx9VZHBjdRBivFyxuP7F5mkv24tE1Lu
 moIwdxXLjK7mn5PQ8SZxZmnQ0u82EtiFO3yBPX+guCBQpOeuP0YV2cG+2qEO03BwsZw==
X-Gm-Gg: AYBFou1bSu152KQQ9kPf+Spn4lMFE9JjbOB8+4GDTR0mJ9shWWk9WxtxEHv6U3WZLXD
 i80itsEVxrWVdr4wrKTZjcRfcjcpr3mYkjKvJ9bdiX1eIuvt4a+WrVhuTC7hYBwzkofeXWz+EjC
 vm1/eV2CoEVEA2ztXByk+3thI5oM4+liCAANR4Kh3NdZgPX5KEaEOdbqWnigIcr08NKGiT1g8C6
 TLxd6y2JepMqaaUzYHMuT94q8Y/s8X9fGw6XdtWSTSgw8F5H2PSrptMuCw229TzA9XKUlG4yAbs
 i0ZMBsW6R7220IwVmbLuMZQp2Xu8vqWuY8sVdyMwr1z3Sq+AUvopNnmE0AWvSghpGx61HcS8gFk
 8WSFyy9sqk5jAh41p+SosgdUUN0llDTONk198fMLwpZqoqXQuTh0ljejEv3zX
X-Received: by 2002:a05:693c:415c:10b0:351:1133:8780 with SMTP id
 5a478bee46e88-3537dfd18cfmr21762020eec.25.1791939241441; 
 Tue, 13 Oct 2026 17:54:01 -0700 (PDT)
X-Received: by 2002:a05:693c:415c:10b0:351:1133:8780 with SMTP id
 5a478bee46e88-3537dfd18cfmr21761972eec.25.1791939240801; 
 Tue, 13 Oct 2026 17:54:00 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-359789fde97sm31823564eec.20.2026.10.13.17.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 17:54:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 mjt@tls.msk.ru, peterx@redhat.com, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 3/3] scripts: add generate_release_wrappers.sh
Date: Wed, 14 Oct 2026 00:53:38 +0000
Message-ID: <20261014005338.34657-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jAy-BFuyWA3530tf7WequEWki77r0kpP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwMyBTYWx0ZWRfX/oF+bAY65jje
 9vB2qYF3JH0f3RopRT7MhhdO5Y1X40zPN+f3/6UiqH5fgeux2BlvHhMDrZghGB79XQfEVxaXOGJ
 rRpJN7LI75mSMcEV87uxyeuuC/Bwsjs=
X-Proofpoint-ORIG-GUID: jAy-BFuyWA3530tf7WequEWki77r0kpP
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6aced2aa cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=n6MYwUk4AAAA:8
 a=EUspDBNiAAAA:8 a=TynfjPBJ9GV2hGmLUgYA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwMyBTYWx0ZWRfX94qIZSfZGAzV
 b6HKpqYBH4lD2hMy7FsrohfQi9bY3rpD4AX9hZ3Sid+EscBFPnj2Dv1FEz8HncfT/ftNHBpwMOJ
 94FDRDLfWtLgKWtLmQoY3L6feopCKvsvpBNhR9xuWqTKnKctW2gIMKCOuUdYgORiA4+wQqd6tgT
 g2dhIcyXebb6JpYLm0EZvYd0VHsIBcGmAHBFQmuKzSThXHYSVwJgNMKvyAtN/letPlHbJlGeRG7
 QyGH/pOPBZhVAK/vxOi62hMZIOh9v3hB9DKtXDL34SpQW7njVw4OBIudxv+ficjx3dZLKe8y0Ju
 0xCs+ew+NDC6gRdsb1EiKGF0JuKFqv4TIgtxt+xvnS9hEA/SztsUbbmkWfzbr1B2cFBxVSEkhFk
 OVF6PJ+3T8SebSHOl9KFZNoXlyByv3yXXU1W5ZyrP7e+oHk3uhzCjn0k78mVy1HSZdLZaBQ+IkW
 nOZvVlD1sOjh0gvOptA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140003
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
further and offer wrapper scripts to all qemu binaries from all
buildable versions.

Note: this is based on prebuilt container images, that are hosted on my
dockerhub (https://hub.docker.com/repository/docker/pboqemu/qemu-releases).
If there is enough interest, I would be happy to relocate that on an
official QEMU registry, or even add it to our CI in case people get
paranoid about where those binaries come from.

$ ./scripts/generate_release_wrappers.sh qemu-releases/
$ ./qemu-releases/v0.12.0/qemu-system-arm --version
QEMU PC emulator version 0.12.0, Copyright (c) 2003-2008 Fabrice Bellard
$ ./qemu-releases/v11.1.2/qemu-system-arm --version
QEMU emulator version 11.1.2 (v11.1.2)
Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers

Container engine automatically download and runs the right image, so no
build is needed on developer machine.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/generate_release_wrappers.sh | 71 ++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100755 scripts/generate_release_wrappers.sh

diff --git a/scripts/generate_release_wrappers.sh b/scripts/generate_release_wrappers.sh
new file mode 100755
index 00000000000..3f37ecad4a1
--- /dev/null
+++ b/scripts/generate_release_wrappers.sh
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
+        grep -A 10000 'v0\.12\.0' |
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
+    echo "generate wrappers for $release"
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


