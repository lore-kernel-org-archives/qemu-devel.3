Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF5BCA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfJv-000099-TP; Tue, 29 Sep 2026 17:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfJt-00008W-7z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfJr-0003ey-Qt
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:01 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THTrwB826723
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yvSMREjdoIn5byRoC6fnr8QVxiVSwHjm7nRWBw7btj4=; b=AWXWkFB+7A+U3Ds3
 jXNkKG0aJ9Om40pijwLCkTi8iS0MWq6w/JXaCvt9H9+YrdK+tcbtwhiWUiP5ZRzQ
 k1pJX/BFQ75eLuMUeqOlgXwOiH3rfuiULSDkhSyBlMXBHofLQ9rl4LV7rRGV0tlD
 +/EP2AblVVwSI7pywjGkC3t2obzC9dVPbUHrtvqmYbUSGYuIdzGws5ROelFl8ScJ
 Uyi0WtqJ4k9rJPXbhVYbpHeD74x0QpKE5Hj1paryL1lllCJgQEb319OpVAPzEm47
 KjCQEYEatcQrUxFSaBlSmODYvHJkLvKtZlMCCykssoMVQIwNL3NwImaXjyKXKB41
 SfWgJw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0hsh0w4c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:24:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6896925eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717098; x=1791321898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yvSMREjdoIn5byRoC6fnr8QVxiVSwHjm7nRWBw7btj4=;
 b=Uayz5RSf8T5wLXM2ICA6Tb4AHp1io2pjg3SVs+uSp7rwLz/yEKGVlQkc5/Z+gA0poW
 F0/w1dwk1DNrkHPp0lYXrLPSQaQSYhrYAGGeAzT/qO9O/PYkuKChtI91394HWG4tQkAT
 LRbeSgECvLe4P8GCaKeVN1lhbYwTdbQ/tJ9kDYfMk24LayPFj3imQ+iJPAWNGwEF0GVT
 Sx7QBFtmpxB/NjFqIXO2cFYisBdHGGVW76lYT2EvVWXEUh9xj/xIfhGRNI6JPkGz2hSx
 AxHSjDL/1TaRYaXAiKlLj1mJfldUo/92GQbe7+fSApIMpjyWI+6PbpW4IwyK3eStyXrn
 GMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717098; x=1791321898;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yvSMREjdoIn5byRoC6fnr8QVxiVSwHjm7nRWBw7btj4=;
 b=FypXvh+54H7hs4dJXpLWp29vz8r1+FSyHw3vXD8TZ+c2/PLCiKkdpMW7aSl+2lwolI
 CYotkoHBjCdsrR5pvlOKGBtowVtD7dyFrrrbqw2Mx0/EZBpeT7fWGbnfRyEt5Egxnl8q
 SRsTmVJChcooYEHIpan5xyZzsHDVxav9gSBmPkrNOdpnbFFotis6xlShRXW57TY5jc2F
 iUOYeG/m0goraFs3OJTAYABTurL4XvhHBV2mMuVO+zk3eeepPGhR57cCM7DjvaC1ufAe
 jjw89iKdOirk/yHuwO2sDeG4DEsGKZadZ0OUw/zCLGGztY11DtsfTpw2EBzDNTWMx+cw
 8o3A==
X-Gm-Message-State: AFq9FYKf+Ya3uPANZu3t8UbmUppnq/WetrLZRQJuL7D6iIBprrS0SZuv
 kOcpATAMcKe6ied8MEshx8YyqHf7JTRxWVak+Ur8D5M3WCGmpIpmjAfAv2Fbquqq/vaeyjkoy4m
 fA1Jy+q+8oIhF8OzQhJL6ZG8OcWmTp//rkNKq+GFBdq5O6jbAnZ5c1rZ+b9Korg7zuw==
X-Gm-Gg: AYBFou3i14gQ9euKRfWcAIU1ZVTF3mCN6Eg8N9f4y7DMfYR5f9fyxHKfkN4RwAiJLn5
 l72CuZCzDAmTxNQsmgL5LckcdcNylg0COy7kP78WANRPIptNmmmzNT+g/4g4nS6XClopKnLOiLQ
 VoG0GNf1uATtwidH+MYdDf2gVSPe2HVc2PKDuKciJ4LPDcw+qsQEwX7NIKSSg9Mfy0qd9Hae4z5
 NEJk8KNH75Wf7DeLOST7x511mFaldaPM5l3Lqt9TfxYGU/FzcvqumuPgseJLV4ekBmg8tiyIrvr
 6Is+5umXxM3Ze/jdHNUJVDyxNEN+acL2UgL/SpyJGatwq3Suuru8/qDrPF5vxTcoxp8wCHWcjPN
 z9TDDbHOTAj2UetEEihAATdW1xR9GSG5CeriB3juu3aQCT9feFr+Wf2OsqCo9
X-Received: by 2002:a05:7301:150c:b0:34b:fd9e:ad4f with SMTP id
 5a478bee46e88-34c636156ffmr700996eec.22.1790717097786; 
 Tue, 29 Sep 2026 14:24:57 -0700 (PDT)
X-Received: by 2002:a05:7301:150c:b0:34b:fd9e:ad4f with SMTP id
 5a478bee46e88-34c636156ffmr700967eec.22.1790717097046; 
 Tue, 29 Sep 2026 14:24:57 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:24:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 05/24] tests/tcg/mipsel: add multiarch tests
Date: Tue, 29 Sep 2026 21:24:20 +0000
Message-ID: <20260929212439.110454-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX7pAB3U3phiWS
 fSKGmGbFFCH3wnzBUhPAGhdI7FMMB1wSltYcLhBPCs9a0BhHycJcjo4mJzK4ScNQ4l+9e/rBGuu
 uIDkRSCN0gV3liinBNrQ7kBequ9k4IesHrIZm0cKynzPr1m5BMaQ/+K/mp+/71+HWJU5CtVpGcz
 L07YFgpMsO4y90eBxXeyOUh43yiOx8OOZWdQ+wuiL0l8HFBtRusu0etcnkw9a6xk9pNMnOPZwUT
 pxxV3olfpkZLcQAEk5OiKdaAkEry9JBptpMk08Exn9iLHd54qNOHh6idg1TqjcqEXnU2cp7fR0D
 en3xazOeVzY1hOrBY3cXcWDwJx7VCao7x9UZThmeMzbOYpdKpomsoe0JyxPPqx4Iah7SGdT+20m
 k076jH9/pnSt+kwkmcw9OHhSlruA5s2vV6OnNuiTCZGyLT9FFfR6MvoIy4b+8EHJ7DBf6ObM48w
 S3P/gELXr6VTs7Eu94g==
X-Proofpoint-GUID: TVh6D715ADilCx7oab0owb46Yl0hMkVQ
X-Proofpoint-ORIG-GUID: TVh6D715ADilCx7oab0owb46Yl0hMkVQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX4ZHXgRLSEUXx
 F+pAzHGNmXaMD/Nm9lyT9auarptkJrgGGnteXf8/6hJSTh3mbeenEmdvNJi373wg6JMCqGVA4ky
 3tIHpZ4ecXJpB5njL4Kainkx8gg4LNc=
X-Authority-Analysis: v=2.4 cv=cZZHPXDM c=1 sm=1 tr=0 ts=6abc2caa cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=UxoTx-g5h8q4z3wlkrIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290085
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 0bf7e840a7d..a02a4bac289 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -1,5 +1,8 @@
 tests = []
 
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
 tests_dsp = [
   'test_dsp_r1_absq_s_ph.c',
   'test_dsp_r1_absq_s_w.c',
-- 
2.43.0


