Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BF2C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA7r-00088A-Uw; Fri, 25 Sep 2026 13:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7q-00086i-Ii
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7m-0000dM-DO
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG5LAS1759225
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=duFLwoZHcPa
 ylIKsr4isIhgCqrhrv+PUGicQrvaHUiw=; b=K8k6+pVlBi4kCBbvATM1fzixl5j
 7gyl8aJrN0busyxMYzYc9w2tBaBsa2aum2wjIF6o5gI1jk7bSyjUFOkVARfqx0j2
 cY82XOpdbMw3kTQZxfWYvtGwx7tq7Rym0h8XhfTJY59EHNQwW0n0bQ4Mg6rYdDl9
 Y5uIyyB2a5bioCBD9yp2oH+dohbgV7o51Dhxj7hHskXVLsWfLApogcoA4S7IOCYW
 xC9Wcpf161SXEK0vi4l+fFRBZ3iUtkUCPJ6mZjpcMY6V/M/AuLbMtopNGR09w6dy
 JnYYKmCjLHR6T6ILLDPK3qOOp0l1c5X3ogNHL3g7h+HZ1oFm0KHyMFR9Fww==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwv5yrctc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:09 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1466ab2bc8dso1840794c88.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358848; x=1790963648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=duFLwoZHcPaylIKsr4isIhgCqrhrv+PUGicQrvaHUiw=;
 b=AYSQirxI6SSPapNWfiNJW5qQnN4sIqaEtV2F9URFzzSI0syLe/XVnJkflFpS7NL837
 bu+XdnI5wOLVzAlbFmi6BEwujLDEmicIWKpkXwNs4PImUamavBlMvVJca/0e/Kpp+6bG
 78udzOwedaD0gCA8LRigqiSo5p7ronRjpaCShlLx2xPo1yMvWLJni+t25idJQ/CVn08V
 E0atttE11ZMqjzziODpH0UBDGyU+SOoXaBE0QsyZLNPa3qbXLCtLse86w8GJQkmMWHHc
 MQjYUcrAms26uGY1fZ7Da5Hg4qRe9AeuCec3wx6zTH/BQDPbSKhtKqz6aISAehUTu7vQ
 ynzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358848; x=1790963648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=duFLwoZHcPaylIKsr4isIhgCqrhrv+PUGicQrvaHUiw=;
 b=aRn4DkHlzChSCq/gNhCcNxYZRX3xRuiNev03heMe3Q/1KaqKUi76qw+C7I7SstQeyo
 e0a9sDipC5fooYQ/5rTrZ6Uj9KLICufeVryqr6eavAdKo2oScWLbgX7zJjfckBGk/LNA
 QTII4p8wPXnIX9POKW2y47Pv3gMUOisnelRV1FE2zIY1ibcedIjFTvZsVhk/8YclYNn5
 M/mTDqtUSQF/yMtXo0C/sfhM+36I9a1em7++sx6N62L1Exc13undxPMgaMCLxF2wBnlm
 a3CcUpvWq4XZVYT/noYG9YpBPDoTNrz268oFQvwc1Z+8GF1wLRxIu4+poAqEkMVcj94Z
 QZHw==
X-Gm-Message-State: AFuF++kSY5DHoZtAhix65EOshxHYOmo5+RZ8bNDa3zJDMyAgSJhrPDfK
 VwbYiSoY+U251vgVyAQa04nAOa9W1tTawMjVE9DnHgiLcrVIjYil4Ot7hmO81IojXKs8SZqcPMc
 1w4qk5gpfDlOrzsSgzh/UPHXVQ8KQJvJqHdXjh30iUraEssg5Pvnkr7aabyzI18odFQ==
X-Gm-Gg: AYBFou2JiiT4Ir098iQE+m2mvRnIJrrH2MKN/vsYgPzRPqMNApzZ4gJjy1wx3Npo2WK
 FN4O008uGWD9fJEEaImUlCQr3q3pIOY62kT/wGFwB/2PK40X8JuREGgGmAK6lbIWAvsrvNQWEpO
 F2NDocGn8Zjz9k4Me1MeHAlMHXXOsZgg6qeRSQoC6Wi8mzhthtkqrvJAKuZ7HUs9VUsZKpwRoav
 5Q6CvXfbX+cYi7rB6QLmCxMynZaMKKHhFEnTSxph/alnAHvCr2MVk8EFiue25iDwsStKOL3uA7F
 PhN+XZKx4DTZtCgjrdqtX5bMR0xefdFXGz+wadmE/u1uS78UlBXLg9dxU5uN8foZBJogUWV34Hb
 jbNUUE1viNOk2UqR3Hipo14ohzvpR85ZLvuFcF0vH4/4QOUTxT9IVKu12lg==
X-Received: by 2002:a05:7022:5f02:b0:13b:2f26:6881 with SMTP id
 a92af1059eb24-146ce67f46dmr890698c88.4.1790358848087; 
 Fri, 25 Sep 2026 10:54:08 -0700 (PDT)
X-Received: by 2002:a05:7022:5f02:b0:13b:2f26:6881 with SMTP id
 a92af1059eb24-146ce67f46dmr890670c88.4.1790358847528; 
 Fri, 25 Sep 2026 10:54:07 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 01/13] tests/tcg/meson.build: reintroduce build-tcg target
Date: Fri, 25 Sep 2026 10:53:48 -0700
Message-ID: <20260925175400.1897574-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX+LW/tF60P6O/
 fi1rDSghy8hiqDPOLT7itNSyT/rFJzZtczdBDtCcicGQPCiEFlP+DD3TTN5hNVSXz9HKRlTwspR
 9KzEiRhpJ2fcY/lIY4HxMMm0aJybNVOS+ByGnoaH2ylEroovlvu3247n3nG0DAzvU9Aw8+THExZ
 k4+MGa+y/lya/4V7Nep9skt4lLLdPwJ+yhIAxU0ZM2gsi83/2PevY8lpmMwa/hGkPjuwXZDDNXC
 EGmorgwP+vwx1rRzramQQ2ab1SsqyIf4DuYuxaFETrMofi069QBOyZtj3ZCKRXvxERyN2vBDSAD
 GUolmfIMaLpuwjvSaLAd6R8ei6magkbHjlBu8+oJVdf+7bNkU8pBeIK5YDAg+LM/fOJLKd/XmnH
 9/BnIpK9Afh3kMgsrNrUPCpwKY/G/GL0+7xFabN8kGCapr7x4ORKRfQWaUGFHwAgZpGa5n33eB2
 UecWdAGFniUejoSZjSw==
X-Proofpoint-ORIG-GUID: jnViiy6SffGllLZU01BMZFSVcjrzLB0B
X-Authority-Analysis: v=2.4 cv=EoRHPicA c=1 sm=1 tr=0 ts=6ab6b541 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=QDOw5-jm7CSiVGTWIMYA:9
 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX506WbqN1A8pQ
 B/o50RW1KnoGS756nuxDKkFGhI4pb445BImjxYPL3zr0xyniO9eWjO9oE8Pqz1C/xqyvyL16K9+
 vxsFqTsBdlfD/Lvy1kvBhH4Y5uIyAik=
X-Proofpoint-GUID: jnViiy6SffGllLZU01BMZFSVcjrzLB0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250071
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

The refactoring introduced a new target named tcg-tests to build all
... tcg tests.
Previously, this target was named build-tcg. Keep both for compatiblity
sake if people were relying on it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260918202704.9790-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 75f0a52fd22..3151c5bd63a 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -524,4 +524,6 @@ endforeach
 if exe_targets.length() > 0
   # finally create a top level target to rebuild all tests
   alias_target('tcg-tests', exe_targets)
+  # before, this target was called build-tcg. Keep it for compatibility sake.
+  alias_target('build-tcg', exe_targets)
 endif
-- 
2.47.3


