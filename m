Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0352BCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKC-0000IC-9h; Tue, 29 Sep 2026 17:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKA-0000G8-14
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfK8-0003h0-5W
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TL0qHp942361
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cqqH3eLMo600/uNJl8ArWPaQibuIRZanG29IyNNyrq4=; b=IoJm7tiYwsWAMzyd
 Wtj6fGSEMXGGpRbSdwLdhW9G/+4cCsEQANoj5dkbXI/QPBDg3xbTi/n+y1RjVepb
 Q9FcnVv/pre/ELIujo04uElKlOuUE+dlxDexGA5azuPMf/ohPECC1rewigQo6sSa
 aNjERKiw5vR+xma2FEsrF53B6n/NO+HEljJY7qhm7zyHwyQnCSitXSfQ6ZhBPiGK
 JqFDouruZAXZF1oPPEOImmg8fAnP4QhET88HsG6j3WO35VjR3Ig5CHmg1pn23TFG
 kZc9ikibGXYomEwj+kdQKDWXr2wv3OmwZ9K1JVrVMkr4t0v+M4n6S44AfTVo0t1R
 hjpOBw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0ftuhjty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33baaba6371so17335760eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717114; x=1791321914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cqqH3eLMo600/uNJl8ArWPaQibuIRZanG29IyNNyrq4=;
 b=CLRNmX68UjojK776xANib2x1/F8cdtenpE3cFJQnjHifXnLHl7gnsgMDhtsgfnh6yK
 K6ENORUadHGCpF4FuPwyg6bh2MTmZOGr9X1fGcVO1nXk8r79du64BG0quJnx5Rmu+VDa
 IfeODlMm+3idN0GXZrl6JTzDhyzj/IUOPmAFORlEs+fiDMTZ3YM0UO0STdSrVKyuXp/N
 4knM7eyrkelP6gEAtSDK+SMT4zsApSDtqd3f2GGCzvpTSF38qkThrLcXt1O96jes178i
 2Pwl3uw6RNNuRdX97RcFIVi3Al1HRsC4FRWPFX60CmFwZ2VYqJNfP5SSSrzeNqeWaZhE
 rwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717114; x=1791321914;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cqqH3eLMo600/uNJl8ArWPaQibuIRZanG29IyNNyrq4=;
 b=1COQRATIuC2ZL7j8pHpPqA+SHnDosNrvkY/RQzk9WZXUtieTpFW4dqAt+GlaU45xcv
 YrkDoKP3Koq34vHBTsO7T9g4OdHNc931bfJfymLSrcci52hmxgj2UdaKJj81+qema/ia
 M6BXeCzS15d4AV2hVbkDeNDzjC7cub8ZzIvc3uRdVjqTAHz3icu6ASSEBkAoOSJmT8uw
 K6FvPRgiKRBocK4IgFpU3lawJwqEzi3PD4BMPitxfmeTsxm6vqgAGWb7dC2WtOveMcGB
 K85T8ZQWX7HOTEn1hVfafmyOb08qUGOSe1YA1SeZFjTCLgOf4zzZO62rUrakv9kNo+88
 QYrg==
X-Gm-Message-State: AFq9FYJNJj9mjmye4ezvXN5AWWBIxqr8FaEBTFi7q2xj701A08b+bb1+
 ZyXJ/eR5vQMBwF13z6sRKmrr2U28e52dnXEWPt6/WOy8nVB5fhIDhmQZA0adGicLeamq0swhSPi
 PbfMJE/kZ2DrIisCfGyb02l33CVVkrHnsybdr1YG2sF4KiJtFpq7ULhtLFGu3+fEkcQ==
X-Gm-Gg: AYBFou13bU0BsZa6U+Pq5dmxdd093EzdqEZHs1fwImP5RIyI0l+hVEuKR0SgfI3Vkzw
 Cc7JW72IrXkOuP/+HG2wgAxWsC5lWw6xn+BtxP3+LC8fWovdkLldVp9XwVfIcDGmDC3U9m+wwz+
 lqeP9Hr7K4GQLFoa0ckLZlEzkOOL99qCnJr4sWs63/7pzQFWF+1u9dlaMCpuDBl6NOapW+0S+OB
 rLI+WKHjgTK/H0BOSSawsNXgnpU7B6q+JhJ0NcMHqpBx8T7uMNxvlvKjxM08ApbnxZnhyHAHal5
 0yPXh/hEs50TsHR5Oazlw+DF0SnOnfvzSnd3hXcb9y+OKEMhyVbEbSzGfjakt4gA9N6+wWelMKN
 YHWcgS8ifpcfTlyvAK9PQiGKQtbyoiyHT+6Pa1ZDB/y3VKqhiLQlG573RPnrl
X-Received: by 2002:a05:7300:2722:b0:342:645a:5cf with SMTP id
 5a478bee46e88-34c61895b5bmr711203eec.1.1790717113796; 
 Tue, 29 Sep 2026 14:25:13 -0700 (PDT)
X-Received: by 2002:a05:7300:2722:b0:342:645a:5cf with SMTP id
 5a478bee46e88-34c61895b5bmr711169eec.1.1790717113257; 
 Tue, 29 Sep 2026 14:25:13 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 11/24] tests/docker/dockerfiles/debian-all-test: add
 mips64r6 toolchains
Date: Tue, 29 Sep 2026 21:24:26 +0000
Message-ID: <20260929212439.110454-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX0AJaVbZnsuRX
 1SQF2TxPtw0MdZ9k4hZOU4ehXcEb4q6HxFRlLQT0PZ9NAbNmIA3/mx3nUStDEeGqUFAm3VzxY6N
 NkQRL9wGiEQpKQsh1Xs9hVESl/9SE+88C8NxG1T/wb4vCAlZflwtaWWHkLw0COhvzhhzN3mqjXf
 z0sqHn0TfI8iwVjL4vZzfj2EC9Axh8IZp1456zjoXB8r8Hr73PCSXUgSHStIKU39JvqZPShrKMr
 Jps6otnHmcIQaVP/3d4SdtKGu0JjWezjoQ8UTSUGJjsIPqgWiq+Yqk+cH4lXOGAXEDTlo+dALMG
 EJxHiDEG6+KIHrAWe217PwGBxwhi3Pgk3YcR4Cmn6xFLhKrBrVLOvjTkESxzwY6Zzr7W4B2anPK
 WqcsMdS0Nn+TW6WNpZ+8Vsfe44xGPLc5+tHtCduUcpTOZDiejrEnLT6sYBx4W1459Gnsdz3xHS2
 +7pOMY3Ek+kNlszKSsQ==
X-Authority-Analysis: v=2.4 cv=AoB7T+9P c=1 sm=1 tr=0 ts=6abc2cba cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=W5-BjZYuLqWngTJxaqwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX50QNQMdoIqOh
 bME9ksrIrf8aLhQJQto1hes7Sm4CIMAV4hS/A13mmA2Yzn7v2Aq2H7gc3MFJCzvDimUWUe/flOu
 GeYKHA15BdxQK0/Q0IEWsIN2bQ5mAQU=
X-Proofpoint-GUID: _EeQgriJrTdUDUCRhecl6VIT9MjOa1MR
X-Proofpoint-ORIG-GUID: _EeQgriJrTdUDUCRhecl6VIT9MjOa1MR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ++++
 tests/lcitool/refresh                                 | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 97d3dae6d7f..94524480880 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -89,6 +89,10 @@ RUN apt update && \
   libc6-dev-mips64el-cross \
   gcc-mipsel-linux-gnu \
   libc6-dev-mipsel-cross \
+  gcc-mipsisa64r6-linux-gnuabi64 \
+  libc6-dev-mips64r6-cross \
+  gcc-mipsisa64r6el-linux-gnuabi64 \
+  libc6-dev-mips64r6el-cross \
   gcc-powerpc64le-linux-gnu \
   libc6-dev-ppc64el-cross \
   gcc-riscv64-linux-gnu \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 31c06734879..662d8a79f3a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -200,6 +200,10 @@ RUN apt update && \
   libc6-dev-mips64el-cross \
   gcc-mipsel-linux-gnu \
   libc6-dev-mipsel-cross \
+  gcc-mipsisa64r6-linux-gnuabi64 \
+  libc6-dev-mips64r6-cross \
+  gcc-mipsisa64r6el-linux-gnuabi64 \
+  libc6-dev-mips64r6el-cross \
   gcc-powerpc64le-linux-gnu \
   libc6-dev-ppc64el-cross \
   gcc-riscv64-linux-gnu \
-- 
2.43.0


