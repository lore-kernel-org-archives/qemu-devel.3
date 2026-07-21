Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE34C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDhj-0001KK-1l; Tue, 21 Jul 2026 12:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmDhg-0001Ja-V0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:52:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmDhf-0004vL-C0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:52:24 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDg6ox1707990
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 16:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/gmrRPYHlNS
 XoJrS0pXLum0wHFN8GikrEXa5oIDrdAo=; b=MseuN+ywqZ8Bs6hHGi4f02IIZeE
 AmiJoxEI5ULqYV/71l/3tsv+bWOT3ANHzBuYSBSyzl92RLEZDjuPkq7Glp/QGMKP
 ad0sqjVzBqKESWSbGr8cXyc6CnRC0aTkQPRe5FfCJJKN+oveDEK56ryLrtsjxhRZ
 j6aAGuKbBFh+Yj2+juaozuvOLv+G0CSmy+hsikalkvenNOjHo2AipQ2sesKcwJoC
 un/3sKCuX8QmyHcor8fv/2ARlXQ8AQrURdpaSyMib0kJOiR4eoiYjFu8oW6gQ7tW
 QnWQgAcnhaH79jir7ocJFgg9b18ggUonprEuzp8P4SfNuUraMCP8jcNGDBA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9ae95wn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 16:52:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb7049fa552so2178221a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784652741; x=1785257541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/gmrRPYHlNSXoJrS0pXLum0wHFN8GikrEXa5oIDrdAo=;
 b=a+myEMXrLcvxfn/1VAAC5Ka7cH7wNUoYDLxgLYUis1vzrUT9hkZVzQjotGHonNQUTv
 g0i9S0EJs6GsiAZIFmvZ3ON0NCiAeviEMLqwc1wUkq04fqb1U6MJYWDoKDmQcW5tjq8w
 X6/L08tZqahpNUMTxKb/f5tu9Mfu5I/A4IMv06nbbKM82i+lM9rKPR5+QB1ef2tGl2VR
 r29ypyprJ51yp1TAASQBA1mlI2gyH9sAUIxB7Zxy87QAYETQiVjBURzoTAHEcMIbLwX1
 7OCTRUzikmHvA5qSkv0IMZWD9KqgNnAnUbvlu8gX9N8v2Vf/PR/PPidDZ4RzaZJXzbED
 6g+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784652741; x=1785257541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/gmrRPYHlNSXoJrS0pXLum0wHFN8GikrEXa5oIDrdAo=;
 b=HQnAe0XvEom9rcGsbE7/TkNJI2NqSE4jUI5cJktHZrJilWZyEX46BWb9CAk0DulsYJ
 cnWo30E/FiAl7yNBnmEHjOgjfIBS9fakRguAqpjzPCE+nerVgW8Uki4Mjl9yTrdudRLR
 qNnO062xMYPCO062jFYap6ESKxZLYMqa1ikQA/5WfgxX7c1/UweLPnrgLptIEVFrQlZj
 ur3Pa5dwIpO6xa06QaNqgEOCncqu5PducYBmzzPf7/kK9SWelp4fTt9UzzITvq2rusTI
 jZomstR9ir4ojf77fyriqEpcTf+g4OMpgcjI7ZkpcX1YZRaIS4M15hO8A+9JOVPTIEXM
 osqg==
X-Gm-Message-State: AOJu0YzQG0uEcCjIDJzDzh3uShWKmHw6X7tZ5zEiUMXh4+xd2EAitww+
 cigCwQ2cuQGjX036itQnKFO04kmUZyAMfKobLUjDZzdhM2VFSipkrACCI92/d2iGqEwMy6FNCoz
 T9dPXJxY5WOcnAjOnEv8xCvlTg6yfoAdreErQIpiHFcupwM0cYHG7TUS1GR2jHzwkbw==
X-Gm-Gg: AfdE7ck5/9G/awCDFxrjNGu+6mTIbgxtaQo+3uLhl5mWjDqyNcy5/Ikr8YndBt0B4WN
 88Zegs9GD760CHfVW22k3lxYGhgLWZR67BCpmD3q5jI1SFt5QunTL9tMx8cIIjCr67SGykYxgxU
 KjSFfDtpZK537/ayUDQoGSSsVH0MWhWToqXQtrKKCWh6ooif9er/kqr45AGcakU45CMtDBbRKpU
 +Mam/dwdqzspPcADBMjxidmxyTw5C8TP2TssumPq6o+qr2ABpfM459d25VxzC3X82CNbf4Pwv6k
 LogxOSuOVzUQ7la43N4SzambEdU84mxFPrQtD9MTMvwbT/CCtJBJkE0PrPligQ2sObkmjaJBziv
 MXGGFe4Kw5DjqJVd+xBDow5xx8uzgb9oPAzAp4Aj7Y5TwuZNaKiRdLF8vKRBsJl6P8RO0kkI=
X-Received: by 2002:a05:6a21:b97:b0:3b3:241f:66c6 with SMTP id
 adf61e73a8af0-3c3ad857fd7mr20965088637.26.1784652740575; 
 Tue, 21 Jul 2026 09:52:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:b97:b0:3b3:241f:66c6 with SMTP id
 adf61e73a8af0-3c3ad857fd7mr20965054637.26.1784652740106; 
 Tue, 21 Jul 2026 09:52:20 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc1a6adsm644018eec.6.2026.07.21.09.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 09:52:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] docs: fix sphinx build failure
Date: Tue, 21 Jul 2026 16:52:11 +0000
Message-ID: <20260721165211.36903-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721165211.36903-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260721165211.36903-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7oUcm1-84ziyON5iD5N_HTK1q8YjahmP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE3OCBTYWx0ZWRfX3Oj9gBMQcX7e
 FVfOf3I3kzFLy2qJfNrI13aCFkYXe2asIsJp6yzegsLk+6Iz5K/ou4wGVh6jrv1jCtVuAWG90H4
 TLUeCwdtgUABQ7HR9NEr61NCmHHF758=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE3OCBTYWx0ZWRfXzMpdOz/ShgRW
 8u+aIvL0WnFkSKotKvdKioiDQAb4N1GNCIwqiyTbhwsNNN77yXMoz5CPLdtSMaPoJii66xOZV5f
 1pIl8o4P5vFm+CxVZiugEOvV4WvAQxDyfWU2zjloHopd1VUQDcBCFjwgrgyvOFqU6hJH1j/dZoj
 VgOEf6WRlgFRmOUyeK6/AmIaG3alZHcL6RAhuFtsQXf7ZwuvAzAqBNEqiM33xR8IOjsi0DyMMdJ
 yfnWw4v7SAdLBP0cg8VqQtAtoWKm6dt+a4hfFFIIA7d0/0uygepmRUBz1ENxpzarhy0Fu/B11Tf
 ET92xA1lFV5aPTaa+TXEI4excjOaRNQo/yWU98sl+DNtcHdnd54KsLSY45p1HTFCnhGzJ5PbyCz
 7Q+n2o5FNYO6yeQXY8Wfg0ob/Zwm39DFbltgQ1L/SQWXcIoB9flPPex8Awgf/iFxePLCRYYgW2G
 5i9mh0PaNsKleHgbOrw==
X-Proofpoint-GUID: 7oUcm1-84ziyON5iD5N_HTK1q8YjahmP
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a5fa3c5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=ImoT4asuE-UzBlIn8mMA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210178
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260720222717.33078-1-pierrick.bouvier@oss.qualcomm.com
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


