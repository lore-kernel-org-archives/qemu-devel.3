Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F39CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 04:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEJSl-00057p-NR; Wed, 07 Oct 2026 00:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEG30-0008Ra-KD
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:02:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEG2n-0001PT-Sw
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:02:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696Hf3o8913635
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 18:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zsdse14ZgnBuEWT1pukPed
 XcJoNM6JUvX/oxug6T+3Q=; b=OPjqpV9KC0S4x665kQtG2VRV8q6hmbh42nvdsj
 QVUMVr3MvH/n9Q/YoKwbybkWZ4ob8rdwCgxlwNAzLFaa1Enwp28f7a7mJsGw7Kcx
 gll6LWHV8O/LSmsWSBltsfQs50xhAnyK1vpJlXcRBKiBm7Fw+RNx522c+55d9tZk
 jMt1FosBl6ATrt5zLbUfDdMIVLJnLvA7iuQebFniZ6yy6Rixv6p3wO7KxgbSmKal
 bWQVMzpEyH1TCjKdPAZfga7ZZrtZ6m713TKy7eMfvupl/6v0JgZHiXv8B6YdZvGU
 Mr51N+ZaBuYGdLQ0VPpRGPKSVRH80kVnPufCU9JCh+ikiKgw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xf7t512-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:26:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35158d674e1so679304eec.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791311179; x=1791915979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zsdse14ZgnBuEWT1pukPedXcJoNM6JUvX/oxug6T+3Q=;
 b=jMgED06OWfVv7mF1+PzSyC8bcREkOJALRmg2lcdAZnaAUb6nRe0VW2y7mkex+Kwhta
 m6EuY/mOewIR5WeKQk65FddKEtyfNDMpI6zRiXpqaaXbEwPDsE9xr9rScmE0Uu+F8mrb
 794mzQnf1POyVSlItoZG316aG3LzwRuMKm2R/U/5vdav7Efa8RXqahh3GZVe9Gc8rQyU
 VILFtvRIeyIHc1pjNsleNPysydSUP6L84U0v3IuXgIxNbijSPjYxa7c7KI7BYPz4b5Au
 X6HBeSuFM7Peg31uytyWQL3SjFlZgAyTATAbvU4zDz9fJmejAtFVk/QuDkN3yvvsfuNC
 /NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791311179; x=1791915979;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zsdse14ZgnBuEWT1pukPedXcJoNM6JUvX/oxug6T+3Q=;
 b=b8zWoU+TmsiV3vUxWpRq52f4znreyScwoCzp0yEMqs6hpby8b511fdvYUHKGVEfgbC
 xUSr/IzAJEF46OJjKAlTU3JQut5EjUho6q532UTwh5xDRdvGbS6VN5iBBIUSP9P4y2yF
 7x/Vw7VLX7YcvzR8+65i/MuN4h1RO67AEMIWqdZFkrQFsOzNDDcBwQTemlHcjgLr/YtG
 JWzUNczK0FlzwuHMHL1ls8Hb4PdhjAejWcSUM/6fqcSCi0Eq4ay2jt5xLK1FkYy//kGd
 m7pBAadRddacLb5QD4LhI9Mzfhv72MNoaWzO9BaxFM8vfqrK6yVeJP5XEs5wDrO67DKL
 W76g==
X-Gm-Message-State: AFq9FYLDJ8MkBMoHlyCGKTuiBaErabIxOjhduiHNtw8D8QtW8v3l0Y89
 DL/SA+UtfvrhTf7XQSSj99Wu8cUn0Pk/ofTDWEV/4Q8Nwk8Tu3C+/e7W9mB8+TLzunJCOWTKNLr
 pAJsCxrgSXEe0q1aFnzfnxwxC1yMbVDOyKvwTQbQUmEg9DbqOXPPBjxisxKxqMfhdcg==
X-Gm-Gg: AYBFou2vQJIOtYptJiYo4pDdWfJ1R6zwecMkYjpSJzY1K+CCyiuTVQtBaQWOOhJD5UW
 t/7zIaHtSv+/Rdfsx7QfkdUYp/WgwfN6yMfpfrXIwq1XBU4VWxiUg54ld3G3QzqL3N8BhdI2xtg
 FMK1VZNGbzRrypjQHDAv6GznWC/WEvR7VS01uroaVVR6lsOhmsRXLD1o1CLFCKVUeFPGQhW6Sdc
 Ppno4kmd2sOQhzyC04313ePEyA8O60FtnS2jGHM0Y2/KX1GLtVbxI0Md2NlJqmxhi38LxeJqX5j
 lUSpmK7OJ+l0QgSrGAlxbkX3FygJ38VaPIUklcIal6lo3jnW4kMBIgVGFx2OW9V6ZlDjZZVE/QD
 cgQK1F+TeWWyPmN9QBohqJsVnhmTTk1qnOu/yrY9x8/0wOXrVGPm1Y7vdyB5O
X-Received: by 2002:a05:7300:d788:b0:34d:861c:99b8 with SMTP id
 5a478bee46e88-351116a0c6amr14208994eec.21.1791311179210; 
 Tue, 06 Oct 2026 11:26:19 -0700 (PDT)
X-Received: by 2002:a05:7300:d788:b0:34d:861c:99b8 with SMTP id
 5a478bee46e88-351116a0c6amr14208810eec.21.1791311174634; 
 Tue, 06 Oct 2026 11:26:14 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515aff5dd6sm242567eec.26.2026.10.06.11.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:26:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/2] target-info: expose full target variant
Date: Tue,  6 Oct 2026 18:25:56 +0000
Message-ID: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MyBTYWx0ZWRfXyl0wjOgIjkji
 1ZeMYsG2/Oy/vF+7OJsmug2bTqrHSVOgTWYmfltQV6NwyQnLYDlTnrx26oGAWbsi9T1vF/wtqoP
 5ETaLHVvtXu8aCy2Xp/NKBuUQnBYzI4=
X-Authority-Analysis: v=2.4 cv=FpSQbGrq c=1 sm=1 tr=0 ts=6ac53d4b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p44_kfD4ypdLu85DTYgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MyBTYWx0ZWRfX+1QbQ/xN63Ov
 lxulcGMJ/48JSUR9kIP2Y0eFCTxRGdUt+Ti1v4jqzmR3w5G7LZGjGI3So2PYOHP26u4CyaBH0f8
 9cgSWiax1shKy1+RN46+O+YBao42TsyqgsOVJ7bSycB781r93m+A4xZit9z2fR1qQDyCmVjg5Tr
 9oogOHB0exvfJT4Eandfs7gZ7bA4VTBIzZHhLFb/5oJqDr9Lorc60zs9fUcWvVY/cyKe0SYBq4C
 qZ+j/bUfuXUVOfnGe9FqqG/SU45oSTHEanZ5l4z0pbRxjAMwlUSlr6BohFuoZ6Sd+vIZjUsmpY3
 YLZvY90yK17NIbmLdwmU4f6c63I/D1TjyrpYiko4zf4+Ku/cJA98WCluWlAEwR7scuXK9P1e2AR
 vTKmjSR9h2rPSDDllDUx2oqcRKVl0fyMSr05uB6nAAlyKAG1rQQBo8EUWHWjWdxSuO5tPzLzI69
 8dHc2IEUxN90j791UEg==
X-Proofpoint-ORIG-GUID: 3dmLMSwLdk4FHo7_C_xQ1D1U-aPDez1B
X-Proofpoint-GUID: 3dmLMSwLdk4FHo7_C_xQ1D1U-aPDez1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060073
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

Recently, a regression was introduced that restricted list of targets returned
by target-info by ignoring endianness variants. As a result, qmp query_target
output changed compared to previous releases.

Fix that by exporting the full variant, and use that to define arch in
target_info, thus giving us back a 1:1 mapping with SYS_EMU_TARGET enum.

Pierrick Bouvier (2):
  meson.build: export TARGET_ARCH_VARIANT in target config
  target-info: use TARGET_ARCH_VARIANT

 meson.build        | 11 +++++++++--
 target-info-stub.c |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.43.0


