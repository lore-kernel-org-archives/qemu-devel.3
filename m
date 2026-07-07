Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7212EC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6I7-0003he-7m; Tue, 07 Jul 2026 09:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6I5-0003fc-1o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:56:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh6I3-0000D3-Gy
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:56:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8qsV3541961
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ibBuYm58xe2e6IjrbMmj336RR3FkZ4lwFHvOiyPJb4E=; b=eJjZOhkK3V5/hu5h
 ZZSbWygK3aQAGJcKUDILYhyzcZWtsA3jfM/jPsQf+0PG8Eo7anO/vUvXi1DTXGTW
 g3uqOrfYM1wAlj57rWVI+gNAJDkOFFAI464Dgnm/w1axHcQFz4l+vmH2I3sQLSOB
 Y3EeDonl32qid16xPV9k2LPY6sFcgmac/meiSFFD+cGo6cuULcLXZkHeSAIDa9iC
 W5wp5G3i2Bc7uySWxi0ZTjFWpqQG1a14L+YS4YCdIMqdW0k04awpSR4YkKMR7ikH
 UCEIaY+mtTnVvuL8ckSL6dCgGrVLRdxKFn5RGRxvlvi/GVhYQcqc8COAloVydBAe
 OTua9g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su728xx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:56:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so53543781cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783432605; x=1784037405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibBuYm58xe2e6IjrbMmj336RR3FkZ4lwFHvOiyPJb4E=;
 b=Nl2Gf59NOSAqc5QtxSWC7coOIAbEHgtlSOSuf9Peuyjxejz8U/IZDyEIfNJGzfRtkj
 FJEVScm38mFU3wFc80X0FFYh1CnHKCDB0ENWrczARuDLXnsQAaT2oe8C+IDR5tv+98oS
 HI5JE8ZvdgdoUBw/UiPAwwUighBVkTlBVlAJfGxtofGwU2xFJekoznvAy+89MGFMtiNW
 GIOeVDFuO12RAEGpH/JpLqNSpzmHiNznFJO1xIpk7bx/nKxZZk09cL6IxAQEl2qswssj
 pH4jd5P6a+STgYmQa66LCjHO6oiuzCGB8UyX/e8tIc5nX5e93J/mvQMQjGZRlPV70afi
 qpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783432605; x=1784037405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ibBuYm58xe2e6IjrbMmj336RR3FkZ4lwFHvOiyPJb4E=;
 b=HfUs+ltQ347rgn5xtghsYbAia6z4PUwKDzmnEmZq7WgPsBMqRbL9G9TEq+nTpE51Hp
 MuMcX/slvE8NclJOUe2QWHMnm7VWR+cXpkZUAIvCeo3C7YK0ZNqxYsgJ1YPUkGSQEMv8
 1gfR4jajWbWRbjk3Vzr6iIqm+BQMI9tD/i/9phX1S3dU6tF+JZ1BeKkugArfQEPOQQMr
 XC7UC2pocB3G8oKVTNrO++im+JxSXzmNnE3odqhSSJo4y3wexZ7zNzK+FEJHeaEbWitp
 AwVgakHSfAB4jPqXqC9sfRiwAQpcFLIpmRLj0aRc7eAL4uRhoh5sphG+8n/3f4xOySuf
 Gw1Q==
X-Gm-Message-State: AOJu0YxLvLrHe69zwkddVhFbp8tojUtYhW16IjKH/5qEjdQCsykWxOhm
 utP2IHNezPUtYQ6cbrOnR9fAOf98Ggmtu9LT82NQZOUFypeYgug9x2EkbVSSrswBpJlJzqR/lAp
 AfPzlV/MDY8ZMhLYnJJ5Z0d5oXiiCjlVySoO5g4rYUQjBHL/rQY4r/VQx5zLv8JE0MA==
X-Gm-Gg: AfdE7cmynWjQfXviRGS7zzF3C9vIJstAMu6D/nv1I5gQoqz2b0jRj4lPt3ckPMC4F74
 5OKwd/2QH/LE6wh8L9UpJ2NxbtdbP//c9Ka6Phx7OORDPh4kXfTfVYiJbcR0dtSxrkgc7y0/+29
 5eHBdZyX9IFfZ7D6qvTFiJSL2HQRwjDEFgLI3GRCuJFrXnkJ8QQUoPpaYEBm2u89lPG3YH0tWyZ
 0rebkG3KuctlwKfUg66zzHeu5+v1rLkowZlgJDDASbD3r9QQCYVPyxwDZ7JF5iL8xCngDRVJHAW
 RI8N/eGRDihyAmOIDaXNGZoH+cS3P7MDFfqSjpOm8L07kRuQWYjqzsRNIL+hc6/XfDZO0iQfYXz
 HNwse0ae13aivi4MkSkQhSbTfoSIuxIJzmoYid0WPArSmg2ZQO6lUeGLxw+s+1bwW/7F9
X-Received: by 2002:a05:622a:64a:b0:51a:8c97:938c with SMTP id
 d75a77b69052e-51c748ed479mr56337461cf.67.1783432604734; 
 Tue, 07 Jul 2026 06:56:44 -0700 (PDT)
X-Received: by 2002:a05:622a:64a:b0:51a:8c97:938c with SMTP id
 d75a77b69052e-51c748ed479mr56337081cf.67.1783432604246; 
 Tue, 07 Jul 2026 06:56:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0aa7da9sm61030915e9.1.2026.07.07.06.56.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:56:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 3/4] meson: Simplify calling mkvenv.py
Date: Tue,  7 Jul 2026 15:56:17 +0200
Message-ID: <20260707135618.53561-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707135618.53561-1-philmd@oss.qualcomm.com>
References: <20260707135618.53561-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNiBTYWx0ZWRfXw9f/1WH4OP2j
 CkYMOCCD1TGL/bJbtp2M30oyzq8Anj39hy/4zv6aFtj7ZtLL1FN8IJ3/JytGVUfjdJ//VkWjKao
 6+unn9g7ZosMUEG25ARAlKpW1zq7y53F+f/9K7MGfRCOc0Qe0CB0Q1+Uytd14BOtpvkLFX/Ddp2
 YcaSTx75vtmrWQpQG+qQrgymkWYLZZ+DLDY5BuDaM+x18FdiRZKZuRg9ZwrXmS40CEx8g+fJt/M
 t+O/VaRtcO862XmcMdmwXLMpYsjVcCdBcezb+PsRYLwHu8ZLbI41B6bFWhvrJ3/O/oFRlDR+eVB
 nSgkruRHgnCseRoQES+GZgKz6SfTc5Q3YP72VHJMmrFo/K7/IVPAZscP11vjfF5rFVB2divSUrY
 ziXhYNxWTSdy10yCs+KOHNjRD3unbshaOb4JisZ0AiihVO/Z7hmJxT3A5Gp1C/LpeBrBd52tf3w
 HUHBKYjpsuhP8IlK3fQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNiBTYWx0ZWRfXwg/sl93OB6SY
 JOPP7SWZ9jCONNKH/X3WEMVSNHLopH7duwidJEARCiAtsUvL9YcRA9+Az/HEz3g+ip1B42gyYrm
 WnnK7b3IDIL2M1wr1FcgnTtzx3iLeXM=
X-Proofpoint-GUID: SxxHW8EiOm8p8PSURENFUIrYtUGHGRZ_
X-Proofpoint-ORIG-GUID: SxxHW8EiOm8p8PSURENFUIrYtUGHGRZ_
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4d059e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=vl9sPsrYKGekLG37FbEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070136
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

We created the MKVENV_ENSUREGROUP variable in commit 913e47cb6b6
("tests: respect --enable/--disable-download for Avocado") when
the tests/ directory was still processed as Makefile. However
later in commit 1aa22ffee20 ("meson, mkvenv: add functests custom
target") we converted the rule to meson, and in commit 5abfe61b402
("tests: replace check-venv with vm-venv target") we stopped using
it in Makefiles. Since pyvenv/meson.build is included via meson
'subdir()' function, we don't need to export the arguments in
Makefile format ant re-import / parse them: directly re-use the
'mkvenv' variable resolved in the main meson.build file.

This is particularly helpful on Windows, otherwise the Makefile
indirection triggers this error:

  $ ninja pyvenv/functests.group
  [1/1] Generating pyvenv/pyvenv_functests_group with a custom command
  FAILED: [code=2] pyvenv/functests.group
  "C:/msys64/home/user/qemu/build/pyvenv/bin/python.exe" "-B" "/home/user/qemu/python/scripts/mkvenv.py" "ensuregroup" "--online" "--online" "--dir" "C:/msys64/home/user/qemu/python/wheels" "C:/msys64/home/user/qemu/pythondeps.toml" "functests"
  C:/msys64/clangarm64/bin/python3.14.exe: can't open file 'C:/home/user/qemu/python/scripts/mkvenv.py': [Errno 2] No such file or directory
  ninja: build stopped: subcommand failed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 configure          | 1 -
 pyvenv/meson.build | 7 +++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index d8bc10060e1..851b6ceeeb5 100755
--- a/configure
+++ b/configure
@@ -1745,7 +1745,6 @@ if test "$rust" != disabled; then
   echo "RUST_TARGET_TRIPLE=$rust_target_triple" >> $config_host_mak
 fi
 echo "PYTHON=$python" >> $config_host_mak
-echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
diff --git a/pyvenv/meson.build b/pyvenv/meson.build
index 4e7d8d9fcc4..c2a3411cf76 100644
--- a/pyvenv/meson.build
+++ b/pyvenv/meson.build
@@ -2,13 +2,12 @@
 # unconditionally installed at configure time are handled in configure
 # instead; namely: meson, sphinx, and the tooling groups.
 
-# Note that this command may or may not include the "--online" flag
-# based on configuration.
-ensuregroup_cmd = config_host['MKVENV_ENSUREGROUP'].split()
+mkvenv = meson.project_source_root() / 'python/scripts/mkvenv.py'
+ensuregroup_cmd = [python, mkvenv, 'ensuregroup']
 
 pyvenv_common_deps = files(
     meson.project_source_root() + '/pythondeps.toml',
-    meson.project_source_root() + '/python/scripts/mkvenv.py'
+    mkvenv,
 )
 pyvenv_wheel_dir = meson.project_source_root() + '/python/wheels'
 
-- 
2.53.0


