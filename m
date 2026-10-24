Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70550606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O4GNDzvA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MfG3VYSV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKVto-0008WQ-4Z; Sat, 24 Oct 2026 03:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKVtm-0008W2-Co
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:10:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKVtj-0000Lp-T3
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:10:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O3Yg71529153
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 07:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oGd5wKK0Jpf
 26AXx2qVXar86xbVQGY5fVfut+QuC17I=; b=O4GNDzvAmU/aYmv09+bA0LXN0fO
 O3xHMwgtueGgOutFJ8hC0ZMoH9um0noG3kgwCKDtpJL7P9/vW8MRLSVsaCgpnR3H
 MZXc2LpF9juj3fKYDZkgZA8JPANDoS9BsHsRlyZZ7PVBdVAWW9yuUfW6fvx5rc4c
 cUtviQjMht4oL7pBUyqDRKtRfa92CN/g5d7Dq4qJTaqM9nJVWKXn9eCor/z0WbUi
 jK3qOo4U2JkjtbvCU5y+UOUxD2Kwhu9zxzNugYBtCmVJ6Papfq/MnTdVBQKjUt4D
 SAAyXF+37azHtkUwB1SUmjlqrdsCPqOoutY01P9es/K8G1NRrSrV8S91XWg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3gcfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 07:10:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad98380ccfso2337736a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792825834; x=1793430634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oGd5wKK0Jpf26AXx2qVXar86xbVQGY5fVfut+QuC17I=;
 b=MfG3VYSVpnIKv3FMQ+BhLZ8bY5eUBqDHCyzUzvv8dTh99e4n6ICAE2kTM0PumpiFBI
 c5OqcUJ8NTSBD+Krtst87nHmSySUe3kafJT69UVS08zUbe0Gq8t6azqqIm4j7ROBOU4D
 x6RAJqGrcxG6/ia52KE92vq3gLO3n7K67a3aq+lLZGaPkt4cDBgvpS3HHliJv6VA4asf
 8SjodcB05AGau1juxGnLHuZDuSyewwdaH8E373gs+5wiHLgxHIKHA+RHxhIXo2WJdjyI
 3tiv45RnO2r2eSAQSpEQIU094L6aFvkLH7/N5PzSsKnZmyUqw7Kw5dJrV0rrNDLNki+K
 MV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825834; x=1793430634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oGd5wKK0Jpf26AXx2qVXar86xbVQGY5fVfut+QuC17I=;
 b=dddanHjrAknZqU9ZJVu1+UMSTc5U0cNRe+nYuwgH5DAkuK37+wYYYBOdV0DDfv1Xjm
 H59ye/03xv4np2O3NsE9MKtpUwLFdw7s6P/46WzjEZFed8IM/s3N1jlr8A3pBq8fVTxo
 2NkYQmMY2Dmw0YsAeMvDm9NQHEEZX3QiKdki68QGQD0ngpj/JMLhtX/IaEhJW+0VqbqD
 2orhcVE2MTFAjUAvKMGgsgetNhuWl4IFIusp2I2mJ5H1COSjYS70Tu2J4fMZoLM97BLG
 fHbI7/++MlNfYe0UzPMA4j3Qx/WDMcAv3DdIvGQvAMQwdhybvQx8zlialw1AZ1HwSAMJ
 CN8w==
X-Gm-Message-State: AFq9FYLJHcwV++MILyasaOHj8HxrASeie98FApfT/KM8cHoaIOrJHBUi
 JEcEgSs5lEwbdm4Rr1xPxr8vONpFxVL8Wdyxo6ivZEmtTm8Ij8+Q8zKUsol5AM3M2sa+6y2izgu
 MXw4lzfPwu3JIw96ni6DQtKwBSis4GcRlrcAClhgH9fh4QfHj7Aqx1sSaGZN/GTOPfA==
X-Gm-Gg: AYBFou3I6XOtWV8xbX67SGGChMoVHRE4f7uC8GdUw9gdZzcWCIl1w4/9wuKQmEZczz/
 7kYIYQ2p5X3GSfEfRVw6lkTJVbjmIt8kdNvXhJIEVX+ub7TWv0FQheYnSJy5CjtrGSLoGGxQQKU
 MU6JxIFp3AiKrEbZunxq6KB3FOec3meQXWBjGPyOWCCP1GCgIbmTI3QDXxXKLv8OgdCMuiAmbXO
 Elc5ftcKDBa+LDe2zItzHUU6tJ212fPbI0G0BbtRWLvXlcyMAEOLW59KCVo2XGU55dSgjVkDi9z
 9q6U7vB2RhdAtrVyEZGCgGqnQOprj3XdmwJhM1VKJ3nSMksy/yjtbSR4yc37QQFPXdhsq6C1p5/
 QrSMM4HiU3+61I2cup5m7rIk8dvHwRv+YWMbxphuLkWd+4O/7BgltPljB3FTdHjQ=
X-Received: by 2002:a17:90b:524d:b0:3a7:b260:9ccc with SMTP id
 98e67ed59e1d1-3adeafdd84cmr1164673a91.65.1792825833902; 
 Sat, 24 Oct 2026 00:10:33 -0700 (PDT)
X-Received: by 2002:a17:90b:524d:b0:3a7:b260:9ccc with SMTP id
 98e67ed59e1d1-3adeafdd84cmr1164658a91.65.1792825833415; 
 Sat, 24 Oct 2026 00:10:33 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb0639bsm1936919a91.12.2026.10.24.00.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 00:10:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/3] tests/tcg/loongarch64/system: reenable gdb-memory test on
 aarch64 hosts
Date: Sat, 24 Oct 2026 07:10:25 +0000
Message-ID: <20261024071026.5092-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024071026.5092-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024071026.5092-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zIIMH5AvngKlGLSZTFAtfcG-kX94h8cG
X-Proofpoint-ORIG-GUID: zIIMH5AvngKlGLSZTFAtfcG-kX94h8cG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyOCBTYWx0ZWRfX0iFFqfK1Tirf
 m15f2zHbb75KEqvCIWyrUD9rqbQjMQuUCa2UXdu/LsLPwYZjldj+ixfRsEdVbLOjX72Kifk1kin
 0W2szguk9uXzYJQcCprn9SdH7SfLl0s=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adc59ea cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-f14e7MdJ4CnexN5ccYA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyOCBTYWx0ZWRfX3hzODau83NYq
 kEpZ5QMziZh2IvdyMC62QwqxK2ZvHUXD7wKlaj7ycoXoxSG5OMKp/46mrYQYmfkiAB2wSn6+pFb
 /f+CQ/eiT0fUSQvLiwT/facUb4jDpDSMYBvupY8fz/45CfOvfjwYCZ6M1kRkmMMkKC9+d6VZcW7
 WZPSFqTHo7oyXjJa3qdKMmAEi8C6rKsdJHGJkhP8HJOZGc51gBUVM6SwC+sRJ5pYXBXUqgaIyGJ
 j9M9S79ONtUjzl8W154Wjyx6mN/SR+SHfs52OOKt7oU74LQwIR8jgFVeUJZHb+Lo38yMd925vgY
 dQcwIepiuB5ftWJsFLWnMpUdpPX2OOVEaSvo/msWEGy9DgLbjKhSssDvwv6Eb5Sw43i1X3xB16b
 lScvjheXS82hP0lggdqLNoo4o3OxvaBSm+vV45hSzCSgBanZbCWEybBLgc5+kiOdfZt933VbHC/
 x336jYcvaaex0ASSqGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240028
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks to check introduced in previous commit, we can get rid of this.

At the time, my aarch64 host had gdb 15.1 installed, while my x64 host
had gdb 16.3. This already exposed the problem fixed in previous commit.
Unfortunately, I didn't investigate enough to notice it was related to
this, being busy upstreaming tcg tests series, and instead assumed we
had a bug somewhere in our gdbstub.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4567
Link: https://lore.kernel.org/qemu-devel/20261022201733.1941651-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/system/meson.build | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
index 0f81ef9cfe3..93e76b696ed 100644
--- a/tests/tcg/loongarch64/system/meson.build
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -24,11 +24,6 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
     new_cflags = cflags
     if fs.stem(src) == 'memory'
       new_cflags += '-DCHECK_UNALIGNED=0'
-      # TODO: memory test hangs on aarch64 host
-      # https://gitlab.com/qemu-project/qemu/-/work_items/4567
-      if host_machine.cpu_family() == 'aarch64' and 'gdb_test' in setup
-        continue
-      endif
     endif
     if 'gdb_test' in setup
       setup += {'gdb_feat': 'loongarch64'}
-- 
2.43.0


