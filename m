Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7435CC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlwSY-00005r-AI; Mon, 20 Jul 2026 18:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwSL-00005C-NR
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:27:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwSJ-0004lo-R8
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:27:25 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTe0r3637646
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=MAvFo3n6Gjs/ushR/NA6bwilDO4tfRrH4pI
 sAyNeYjA=; b=USdsCnW/ykFHJA60dqE0PaaMwlRICR2ULOR09fB3V1mtzXzhrxr
 1rJCZkDMCSfzmdNyRUcjjJEIQvxtVhS4qonzJNZ8gUtBZpJJJhecrSMo2TdBae7e
 16sKB7ZcOYFmVpneoJfVkGhcIu6syusbVMBev6VAn/T6FDcBFHnF0J5bB/ceIZBt
 kFcJhv9YfSzpgWOQ8CXnxWhqHkCCfKnDVOXoUpghXs43RBhgOzgH5KvHOqxyx3eh
 tq7pO4DNekz1bTJbBuACJRN0RBijoj7dCzYjGpUHipZkHir+Vy0RpLFU5LKPYHvs
 zUwGLrjOHIy5pt15EjSmGcMM9yuedz+oh6w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhhgyu44e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:27:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso14932963a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784586441; x=1785191241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MAvFo3n6Gjs/ushR/NA6bwilDO4tfRrH4pIsAyNeYjA=;
 b=ixhwCDvdpnLvVeKzNqbCgUQEhqI6B73r8B981pWiukDTa7WB/dPhgbxJf/m8bDkhRc
 LhkonEQ5SichoksqdTmlq/1zhn9mbWjIFVT0H0b5h6IQ/2Ywk/dfLQB/BThwZ/Ln/mBA
 1HwyrdMky11nZzEuDkXPKNngZI+9cD0niv+JD5XuakueXpu3UFxqYov0Lh+G6w4BV8yx
 YWWGESrL9KSggQl8cWNAkrRTGUjJMeEhxX6UykNYtZk3u3O0j+tR8zWUFZMHsGfuVnVK
 GOMigBUHu1RgN/LMB8Z3knag7OEpnRTcDa6RIZ0FS2NQpm2/LGRARB8OXmDvZtysR/it
 HxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784586441; x=1785191241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MAvFo3n6Gjs/ushR/NA6bwilDO4tfRrH4pIsAyNeYjA=;
 b=J0su2cL+OaEaLh652lSryPbDVnW3cLIZA0yh1a9hZpP9WATEQwD4jk2jSp+BdWhGYW
 7/AaJRU34XJMFN1Kqv0+0oYjBet7/B1yRe+k667QMj/BMLvlzfg9jj/X02Uufpy24vdO
 cm4LSPxdZWQkz6v1GcHmU5r4MJblV0PFpBb/e7OsGt9Jlk0muRHjQKexwjep2o8WGjgg
 XYHlaAjAZiFr6kNdsVZgoyzM5OwjT8H66DSOqv05tujeTe+s/V7CpG+Kccp6p4h4+7RA
 /FFe0bQRf/Nh3Mt+4t7dQZ6/SZKuQ8xdbxNIQZnfPSpfbiAyUNaDiVYZK2Tbe085BzYe
 okJg==
X-Gm-Message-State: AOJu0Yz/ZtcHQHTJ+dPMmY1KCDP3aYdQRR3LR5u/QA9d3U2FAMC8xRmj
 1Zp+hzbE12rYZl9+ewPUlKI0pfk6SsJRalJ/4+cNQJLDmAq1XciIXdwpwzG5GF/CfoClnEEm1Ni
 59rO5Jj6ICdyse7IMDzMfwnbfjmBioTmhPMu61ky6HDp4OI1aXDDts7dkpCewgB6OXQ==
X-Gm-Gg: AfdE7clW8oXaXblmIcAAiLv51SLvyk+jccZnXZTrlkiQZd4LpJVCPdt0fiMqD0Fi11L
 R+IhTgaLw0sy25eI/zUsSoyNBBzhfKzi3KMFUTj1fC3h5+93tzq/y5uXPYoDsBo0aF7aZMC77aA
 0dwwfGx44x2QsRGuT0zq94ZuYCIT6EmNUfySbjG8e5nd8CXbIK04gPQ5+LOg+MpLVvUDqJdXK6u
 p8eTJo8NTS+252zGdkGN71ssJwbiXCYuc2X7BnQJBTjhext/ApkjC3/IXVfWO1/om74RQO+bb5X
 ce4pQvA4SZBSkH3mFveUJI1c6ietN4Lvjs0MG5m8qPrD62IKJtBsxPeFaAdt5WNYI8SW6UrdqtV
 kULbHjqFkMsWDZhm9/Roha/dd11XF3Ic6uUfxaT6x3t7CO8VezilWK1dtMKWrT90E83l72p4=
X-Received: by 2002:a05:6a20:cc0b:b0:3c3:9a7f:7307 with SMTP id
 adf61e73a8af0-3c3ad7ec489mr18341441637.24.1784586440985; 
 Mon, 20 Jul 2026 15:27:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:cc0b:b0:3c3:9a7f:7307 with SMTP id
 adf61e73a8af0-3c3ad7ec489mr18341418637.24.1784586440497; 
 Mon, 20 Jul 2026 15:27:20 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a210571sm41138795eec.31.2026.07.20.15.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:27:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] docs: fix sphinx build failure
Date: Mon, 20 Jul 2026 22:27:17 +0000
Message-ID: <20260720222717.33078-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDI0NCBTYWx0ZWRfX5NRzbym13QUq
 1BoBEOli7NUcavEADwa1Mp1DfSrn1wQR25LZLLUcULvD8MPawT3Cz2GbcHvXy4HS/1J1ZFm5OkF
 zFCg82VHn/KqcAbGibWuVEDdfCELy8k=
X-Authority-Analysis: v=2.4 cv=LK9WhpW9 c=1 sm=1 tr=0 ts=6a5ea0ca cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=ImoT4asuE-UzBlIn8mMA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Xa9ndFAuECxRPpfbvk49sMIrnvAFXqOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDI0NCBTYWx0ZWRfX4ZFfpVAE+0yB
 rpnQRSAFKgEUMts/IKq+PVYq8r8aFfTzjZluXpHGOnqJ6eq9T2tFMvPx2RbTlwsA2i0fpucm5N0
 tfPUmpqPxgwilAWWaEoV02EctVOx9+JOyhyAnH7SdouMlxlhjWYqtUaXeZMM0DyGiDUNvMvrzbj
 Kb/1GFY/WdNRvVUr7cObsg3ccxtPh/yJpIQJu7e7GKPc1mUzMBE1r56FsYMrZ0C1flHvZL5pzjx
 4/2PMXDO1mQpJWVUMqqAT1Ve0WAb83WmOA0ttQSRd1VfP2Za4h/LCFuWrlahIDBFCOEyTaUdHvm
 MDJKlxFEKfGp30vae8i/LD9aadlzgudSIFKymxbAAqnFRkKqoRQ3Zm6N0UoPDSjyukHmfidn72J
 0fD/+M/5t27mF8RcP7grz1DJCNb3aVNjziuDeYnsDxtgnRHLGER3hVVYSE4fJStk4w7PQ5J8Bug
 Ch78otzUsCSfa2TjILQ==
X-Proofpoint-GUID: Xa9ndFAuECxRPpfbvk49sMIrnvAFXqOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200244
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

We recently started to have those failures appearing when building
documentation. It's hard to identify if it comes from a python, sphinx
or sphinx extension, but it blocks us.

Exception occurred:
  File "/usr/lib/python3.13/multiprocessing/connection.py", line 399, in _recv
    raise EOFError
EOFError
The full traceback has been saved in /tmp/sphinx-*.log, if you want to report the issue to the developers.

This seems to be the generic error message for "something went wrong in
sphinx multiprocess":
- https://github.com/sphinx-doc/sphinx/issues/11449
- https://github.com/sphinx-doc/sphinx/issues/14458
- https://github.com/sphinx-doc/sphinx/issues/8973

Solve the issue by simply going back to sequential builds. We didn't
notice a huge speedup anyway.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/meson.build b/docs/meson.build
index a8d893681ec..4d8cc545fcc 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -4,7 +4,7 @@ sphinx_build = find_program(fs.parent(python.full_path()) / 'sphinx-build',
 # Check if tools are available to build documentation.
 build_docs = false
 if sphinx_build.found()
-  SPHINX_ARGS = ['env', 'CONFDIR=' + qemu_confdir, sphinx_build, '-q', '-j', 'auto']
+  SPHINX_ARGS = ['env', 'CONFDIR=' + qemu_confdir, sphinx_build, '-q']
   # If we're making warnings fatal, apply this to Sphinx runs as well
   if get_option('werror')
     SPHINX_ARGS += [ '-W', '-Dkerneldoc_werror=1' ]
-- 
2.43.0


