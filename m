Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935C606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nSDcbS1t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kI1B6B4R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxKU-0000Fa-8I; Thu, 05 Nov 2026 08:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOxKI-0000E0-Oa
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:16:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOxKG-0001MN-So
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:16:22 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tEBO444508
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 13:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VxGhDKBUZw/fjWbMcbRQ8WPMBRm2i366rvQWlpcf/y4=; b=nSDcbS1tj1cOknW+
 kpJStpWSEzn0UVTst8RBWrF/tMet2oeEGcef+Ss/RPF8UnAaIbKzFv33lVDasSIQ
 /W1XN6yPs9CvzRlRORz0rm9BPHB/ctGnnykNe3hq9PmElUVS/K2eHKGgqHnsj4/D
 yhLulTpgLqElJ2iIrNUDfV2YyFDu6xYOljs9+oY7+jZ4mDoJg/E+eefrl+f2feEA
 qndR8P4bsfY+YxZiq8ux+oRWLfRAmTCX3XoQO+FSL2ZkKc793IGk7eZEikQVWxSI
 jDhCryzPCn0bIYAm2zKITNv63Q77x6CXNqIHKcGlcwhpRGhA7h1EX1nM3d9Y1IHR
 VnXYlQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaah5vp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 13:16:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9308eafb465so518658885a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 05:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793884579; x=1794489379; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VxGhDKBUZw/fjWbMcbRQ8WPMBRm2i366rvQWlpcf/y4=;
 b=kI1B6B4RGoSdZAdYa0Oh4ep7vp4Ac4qQqjl/jdBlJ5JaFKQYclLWWBq7h2/Ly5tl7u
 /AnGn4KmAPhsjpJCNV+itytyi468APj6JR8WZhrayPk82LhBesK/t3jofZysTU/NFDgN
 uXGNyiZFK/L1FVP8r2yHYnQdd1TnjJjgb+BOkWUtHmig8rvNnbAZaN4ytubGTAkdISow
 y7GTs0DUvo25zmN5ddTsHKSvKo5Zbiuz58I1HKcag0QrHKFLlWb/GBw9dVltsHbVW13q
 y+l/97nfyk4b8Xe8P/Dx5grtuvWIdWLSrSx/7HNoKt9UMZ7DJs/aED6tJL5QZTNbW1VM
 cSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793884579; x=1794489379;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VxGhDKBUZw/fjWbMcbRQ8WPMBRm2i366rvQWlpcf/y4=;
 b=i8G6zIS0DRkUtBuYiydi+WM+KQHUpxou8jeLAOa921heIxvYeiWLp0q1D5vIJrXXmJ
 vmFV3YO/Ml9amXaE1CggVuJIHidSyTxpH7JViPQqRtz1RNj/3GMXz6HrKsAwZQhZf+Pf
 X7bp23HIZONxpeDA0M+7yPVAmVGf2OGidvlR/CFtDlvrGQo7y9lLlj/sJ4BfbpT0Oogf
 0/rZHxN94J0fp3iB6PTv1aj0JEWP0flZj9wHeQF7JhYNm2I0aE8AvRBeHaa/srhsy5mt
 qqsacaflKVXW/qfZafIO/5c6WxDzCNN+WtInJw4Ur0Sv8mjBYi8y4tdL+1prxnoFxpop
 cGKQ==
X-Gm-Message-State: APuU4Z8VB2UJ9MjTbGBZNk9EHYAm8de8F+g0Re7JTIYrXgC/OXaYJKWh
 9pTUQJXG6m8OwjrjhwOtsg4g0B8Kl4HXimNCrbUQm4d5iXsWE4I01tS1DF0VVB2kzrWe0eBZshY
 O8Xdqd/LGTIFICSfJzuVEOD4ZVnu1OsrQ4pYqTTkBZE3z4oJVxPy9BsTG9+4BYABdcw==
X-Gm-Gg: AYBFou2/tF5xksFYCZy2Pyi1KSYnt0LMxSe3k9FRjmGofzLo8sxR5X7fcNprrjwu7jI
 sy+oGLki6frC7kKVdr56qrFIA+KuvWcOBIRzWWQDTZDYuX83KK985F8TsUEFhQ8NJEYHlKRZU9W
 RDrrBoLUIx37Y5JGd6FDmZoIR+naZLGmAXZJwUGf/Hj4LpDXNlghYhtSFA5Js5Wyu0NLvKQS/7U
 FsreaMdtxDTqHLy2Mq7N70TFq92/akkpc+5kbJ08szm9HLZ6yDhWzF06PLCnAC/296YJBvrumLZ
 /sUChyIDU4g0+MNQnSp48kxxS+UvGT59PpS1C6Ls5Tnas2i2INj4pYhnqBdpXkuE+eQNZbVhEoJ
 i/UKcC3ehDaLJlsQLLZFDY7gM7O7akZbe+6T04a8y3uXyA+DADzYN3w8To/KbAtVXTfJ8D1ykX0
 IXH4xJxS8p+hjRk03s1KJsnqy2
X-Received: by 2002:a05:620a:370b:b0:93f:1af1:7951 with SMTP id
 af79cd13be357-94421729826mr3177159485a.66.1793884578775; 
 Thu, 05 Nov 2026 05:16:18 -0800 (PST)
X-Received: by 2002:a05:620a:370b:b0:93f:1af1:7951 with SMTP id
 af79cd13be357-94421729826mr3177153985a.66.1793884578223; 
 Thu, 05 Nov 2026 05:16:18 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b55abd5569sm1858934a12.5.2026.11.05.05.16.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 05:16:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/2] accel/tcg/icount: Fix shift=auto incompatibility checks
Date: Thu,  5 Nov 2026 14:15:49 +0100
Message-ID: <20261105131549.42175-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105131549.42175-1-philmd@oss.qualcomm.com>
References: <20261105131549.42175-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX8kPPVTwLxixh
 eTyT0gp1Lxp6fTGNZr60JGTtl+/ulpppKYnvHraJoLkqsaym5Jgc55MGF8DcTpoPaFRNOOvi63k
 ySdiH0RXAnuKQAN6Qq6+yx+B4mg4AMc+9jp3nphma0oPeFUsFbDUu9YwDUIZQizjkcrWhCaUeJ5
 lxhTc4Z1sV17U7COaEWYCMF/jw0hqrYu4x5RgMDJvekYiD0XMzbWTNsyeYa+QfwJY07FGfCnhov
 YfmF65ABja0CbUSoq49pHU49x4WMQcqMLjD9u194f0h8Kba+sDydqdDGTF9bzW22tHCaZvNDK6J
 ykKb/ezbJ6XtCpSmsEifHKqP+aIhBa/ZbnuW3Dd4qHZjothG+scgqs3Zy0CriNyBW5QXFikN639
 o64R91nbXArnAjrdMcZfNcRoARs1TozcWS9CDEp0VV6wSoWDhm7Yvkqh7Fx8NKEu1RkoLr/u4fV
 lWKQWiq0Nv07Tvcnk4g==
X-Proofpoint-GUID: 7vO02RW783CquL81bfDvx0Q7YhEQqgVD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX7gOYkPk4sQ9j
 GMzNUsr5oHf9I3V0Zj1R7pPR1mVss8x578Chi7W3AIkru+q5BCNPcvQ2fs5fda/ma0vDkmb6TT4
 44RytlBjz/EwGc6kk/SzIdAkVqIOYlY=
X-Proofpoint-ORIG-GUID: 7vO02RW783CquL81bfDvx0Q7YhEQqgVD
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aec81a3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=z13N04a_aYECidN-mk8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

icount_configure() rejects "shift=auto" combined with "align=on"
or "sleep=off", but the checks read the file-scope variables
icount_align_option and icount_sleep. Those are only assigned
from the parsed options after the checks, so at that point they
still hold their defaults (false and true). Neither check can
trigger, and both invalid combinations were silently accepted:

  $ qemu-system-aarch64 -M virt -icount shift=auto,sleep=off
  $ qemu-system-aarch64 -M virt -icount shift=auto,align=on

Test the values just parsed from the command line instead.
Both commands now fail with:

  qemu-system-aarch64: -icount shift=auto,sleep=off: shift=auto and sleep=off are incompatible
  qemu-system-aarch64: -icount shift=auto,align=on: shift=auto and align=on are incompatible

Valid combinations still accepted:

 - shift=auto
 - shift=3,sleep=off
 - shift=3,align=on

Fixes: abc9bf69a66a ("cpus: Fix configure_icount() error API violation")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/icount-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index b1b6c005fe71..840ac418e658 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -441,10 +441,10 @@ bool icount_configure(QemuOpts *opts, Error **errp)
             error_setg(errp, "icount: Invalid shift value");
             return false;
         }
-    } else if (icount_align_option) {
+    } else if (align) {
         error_setg(errp, "shift=auto and align=on are incompatible");
         return false;
-    } else if (!icount_sleep) {
+    } else if (!sleep) {
         error_setg(errp, "shift=auto and sleep=off are incompatible");
         return false;
     }
-- 
2.55.0


