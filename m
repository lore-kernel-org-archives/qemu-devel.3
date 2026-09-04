Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2593C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2aFO-0001xT-1H; Fri, 04 Sep 2026 16:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2aFM-0001wx-5I
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:10:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2aFK-0001U3-2H
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:10:47 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HHuKf313212
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 20:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uEDJPtEhx/B
 tMrbC1HVnaYN8SneIB5KMvq8q5DxXyv4=; b=fd+CdIv6hgwwMXkVtRnk57mu8z+
 XG1R4+VL2Fry7MCdTdnppwgPGPg/XG4xcAAg5Lkr6uPvrZRyf29qQJAnHBQ7Eu7e
 oJuzKtWpp/PQD2dcRB4x0MbJlsH27SBU2O33cJhmeCcEzHRN1ronpJWkaAEaIQiG
 cWoy+lE8FpgTAG5dLRBBBmxrA8zkBcIg5G/+T8LcI+PovU3iNbZuA4onY4+i6AQk
 9yX8BUq7NbWRxVmFChWCVfXm58+A/AYF+miHfXJ+kx/Ajv/x4vd564UDqcUQ75Ax
 4eSdN0bvtwNvWyysliTxCjdm9S9ACNmnVuUeOvsGPY5pkh3uwrfISUKlObw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg011hthd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 20:10:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so2316431a91.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788552644; x=1789157444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uEDJPtEhx/BtMrbC1HVnaYN8SneIB5KMvq8q5DxXyv4=;
 b=iGuL80HO+5p1OeWh1Wl6tTSTz3VL2Dhr3KvNuUSrspHtlbNxYxrGzRvKAhConTDe9z
 eEM6Mf+soy0TDhQ3xSGi+KMdraqhGVhj6sb2LdkZDd9OYPmSjqqk6l6ggnvbPaIkIwC7
 D3MMZfPuI3ESaZ/oVFDsYpIELBKprFsU1Ofe5iRIW0jinBCnUUshWhYjBjw8GJInLSZI
 A/vZVNqMw7h+wR0a61Pwqjb8AUJq/rYLM5FSSTj5cHVaNbfZLhUUc8nQEUr5MV0ieLtJ
 83wN4qzYzqVK8EoZev/w4otRyHS64UFOi26z1iY8sDQJah17fFgQNANykZBSwhT6oI5L
 9CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788552644; x=1789157444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uEDJPtEhx/BtMrbC1HVnaYN8SneIB5KMvq8q5DxXyv4=;
 b=Z+hOK3kv5UXRMehi4JVjyHmM0PqCks8glJpLzrgw5EOlKfa8oqlnlqPbkoAHj3TrOm
 FPm38v1CvuD7LZqlop4vrO20V3QRUYVVw981KwpFMccwmGub6lPEMCcUqYJ/weGEHqPS
 +44fJrhYVP4P2N3FEqLY8nRFNsKAO4GaRIkek9LdVNcbBRxlbGjunMfNC6RSq7EhaOUE
 iydIjXjjKf6h9/QWp6TSlJTEEzu/f/jciTOq2fjGC2cnVraUN2XTxaPnIlLgM4+q0Eq1
 AP0UMlWaB/lCWs2TqU1dtWki2QqOgzxw3lYJ+4eVddDQMFU/PIZATDrdKG3zYyaAw/HF
 37xw==
X-Gm-Message-State: AFuF++nXkAP4iuzxWwnwNEf2p7pojt3RSGt/a/JquLLE7hLeaX1KeitV
 v0PJFCMafwWQFDeTkFiUrigR0nlsQClPGNJzWxfV1oUFvvFNOwRl2fpsDWRIDUiq/5FgalsBpkd
 5szUhZVYkPpoaUcnxvSgFufMSaHOGKrvQ0ZFB1auZkD9PxPEZMWokm0prmPc4Enh7wQ==
X-Gm-Gg: AYBFou2bChpum9mWFFvPaMxDd/EJ5tTE7iPmeuf6u9lnGUN7nSv5Mx5tnGZmqspuLz4
 z1Og66MhJjuii+eVyCM3J4yoQ350v3V6wKuxJ7kouODbG+nIxt2FlFbzhd+/eBL59vc3dlfC6/j
 O3qvRlI8UNHMSk1Rm8MOow4xhngaNQEZQgUPdz1xfjcjcvYezXbmgOtKjGGVIa6boUy1rFC2zvQ
 4jrtx82X/NZbOaoWWZpo9kVXc99V5EGhjhQuN93LOXkKI+YSR7b3z86j+s/taX6SKQ/b4O/TiWO
 1ahrxX0gO5472UdwgnWOJwBxz02A1/r4Z5eQ/JLmb62I3p79ZOYYLSdvsPItImXHGesp6Ca2Cjt
 9uCQSBfrmR0JtkOFzLMAGHm/SxH6uz3g8TPB9MhsVON1RXUnbX/Eolf/Ye7g=
X-Received: by 2002:a17:90a:da8f:b0:398:9be5:b41e with SMTP id
 98e67ed59e1d1-39b26299957mr12006253a91.25.1788552643746; 
 Fri, 04 Sep 2026 13:10:43 -0700 (PDT)
X-Received: by 2002:a17:90a:da8f:b0:398:9be5:b41e with SMTP id
 98e67ed59e1d1-39b26299957mr12006188a91.25.1788552643296; 
 Fri, 04 Sep 2026 13:10:43 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm10117751eec.7.2026.09.04.13.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 13:10:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] tests/tcg/meson.build: fix build_test_depends
Date: Fri,  4 Sep 2026 13:10:34 -0700
Message-ID: <20260904201034.2811585-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904201034.2811585-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260904201034.2811585-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4NCBTYWx0ZWRfX22HMnOZvH5iU
 Q7LwXnmXjX1drIx5fkdA+hXttu/iyck2e+o/n7WWeJk3+r7cufxK2acZRULxbEBZTcCPR/QnW5E
 TfcpSHdnywDElDGNhL0+1h/iB4bG4NNrAEt4QqHqBBzNsdsRkbQO1qDPV4o+Wz2l1L1C0J61Jm+
 hOa3U577kH3a+d3QN07Aza5eHg1qZYKLq/iCcuTtw32aPB4ipyDEcJkD1GiDbY5E4NiLZj9q096
 XGerAplxGmqZ9vG9naRuTIM8Yj1l1tpqalNYYb3SCRU0K0ugmhlZJhTmjA4GTxIP35JqtjbkDfK
 kREd1ZEvV+Ba5uOOd3MiS/MN96NfXJid0jUmcTQE4jOhfuNjACR4jthDt6hEZVwZdxgsG4fKjML
 6sfukR1NrvI4BVHTEIG2NKgFXY0+4UnmJehyeg/iHFiNLpYyiMSOeY9dGiTpqRhv78qr2o4/FKj
 nZne8tZcfm26T3crcAQ==
X-Proofpoint-GUID: RKycOFGHTDpA_tHwX_slrJ5B2C5q4Vtt
X-Proofpoint-ORIG-GUID: RKycOFGHTDpA_tHwX_slrJ5B2C5q4Vtt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4NCBTYWx0ZWRfX0DJkvUm1KCPe
 /hPeocpO/z1ZxPfmESZmR7eMUTFVDiKIm1SSwI0vnO0G/VhDmkFIxt6FSnjwLUK+GosvgDjSEm7
 PrIUfbYKD/lHBbKzKdmSQ9eQl+zfHkw=
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a9b25c4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=qGe-MntRKviEIDiUTp4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040184
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

build_test_depends is supposed to be an array, not a custom target. In
case we go through this path, we have an error with following lines:

      exe_depends = build_test_depends
      if 'depends' in setup
        exe_depends += setup['depends']
      endif

where meson complains that custom target has no += operator.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260904200614.2808877-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 243cdb5fc8c..d41a228fb3d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -263,8 +263,8 @@ foreach target, plan: tcg_tests
     endif
 
     if not has_cc and has_docker
-      build_test_depends = image_targets[cc_dockerfile]
-      build_test_depend_files = dockerfile
+      build_test_depends += image_targets[cc_dockerfile]
+      build_test_depend_files += dockerfile
       mount = meson.project_source_root()
       mount = mount + ':' + mount
       here = meson.project_build_root()
-- 
2.47.3


