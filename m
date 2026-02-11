Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205A9ECD6F6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 22:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqIZH-0005Np-FG; Wed, 11 Feb 2026 17:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqIZ4-0005KE-TD
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:20:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqIZ2-0004w3-Er
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:20:06 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61BEV8kX1507117
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uKOLv5qOepkHTGXOvnBhr1IhMU6Wo2ariQ8B5PpV5Sc=; b=iIk4ZMpCuqHP6Gy0
 NzciPOwLY68f0TgeszJ3hzeAC6jQDyXe0Q54QZqTlDgdFK+Q2iWRxRjVki32GBt+
 4/bVX4upd/ldjsPYkv423EfxlPe1vvtDX4lB1tQYsvIUGimG2GimFTP1XRPqvxjJ
 z75hzHnspzdwCedrrJ+vII5ku6h8cd/rJ0/77a0KvJggJyx7tg1+CyMaM1ML7jBO
 Nh0uRR6bI3C93PCCbgCMCI/hnokZtf5q30/jxbbzlj2xT6ZNE6Ag1SKpYd2RxTi1
 YekWw/3ff8vJhXd1x1dKqZCWkfUUrpFthzC01hbWrcprboc/tUHlGA7M4+ibZIQN
 RIMGOw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8ukt1ghb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:20:01 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1233b81a92dso1291452c88.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 14:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770848401; x=1771453201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKOLv5qOepkHTGXOvnBhr1IhMU6Wo2ariQ8B5PpV5Sc=;
 b=Gnrc4XxPCjdgRI65q/9MZ5LrF1tPdRrNPfWbQwfIJYWMoKh/hbey/L0aIE3qw27WZS
 MPxWfM13Z55IWRFGn8KYOrS4sCx3mce7RM3M44VYLAji9TKUdktDC0HBZloiOkxSa2Uz
 wVe0Du83bsw0xe7F/4AWho0NI2o2/kW1FH1zuw2aT7Mt4ZEMEEVp+Hy042VzQ03nBZBc
 MLcw30nPTKzgmdZ+pnkBcwitU0ivRBK1RYDru9VkYt4GECqGO/cPphI9do1Y4eJmtJyV
 2qibpoZJR/8vtQZpJInjoilP7AxycJqYe0GzO8UgaarXSKL2HKm+gF6kUdARjssYEzdC
 7DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848401; x=1771453201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uKOLv5qOepkHTGXOvnBhr1IhMU6Wo2ariQ8B5PpV5Sc=;
 b=GkESCNM8z57Yk2OnwO3+uQc8umlmLiaZ8NNxkLn719oN+wB0wxNhPQd7NUgcnGlSif
 Ika17ZCPZvtKmf4gCGIdVifBPcNlEOSn5cdE90zX1ZJou1F2egLbriOcWZtRCtcmv6rF
 FSjFwRvjbK4XOWjKUxr5r/h0c/6fv9TeEkiK3kqu1LJQ9hh96qIfkIgNOIo4zR73HJvu
 FwlC90lSI7kb8GthsPBpxGghcFoQp+vFPIFBZQRk/YX9K28q4C94ooz71DUIt7J1Lv8M
 m0FqtULUTr8K26rLLGTTG4nuO7889jR8h2/cm877LAak9BmlH7wjRfVT8D8Ai1b4BtQa
 e/GQ==
X-Gm-Message-State: AOJu0YwLh68/FI00dY0x0Gh8MJvV7x2cEH+QlrNsO75bAhy0b4Go+EEX
 tOTH5jzN1taPoK5XaSTvBHofFOpljQCzZ8TI7pnva6ae7GozlVrWnSvx6OFzi6WFZBLSKv+ZDUY
 sMHqy3x7sLCQdqAzPdrvPyEDBL6NRngrKsprCa18mUI13OELQovenEDUQUBqgN/VOqw==
X-Gm-Gg: AZuq6aIf52vRLEDqeAcRPeuTmRnCNEixxu4sgUQTnVmQDZbfAKcutNBI6Vd6NOxjfQF
 ZTgTY+a2kyqq7sgyQCXGJBfjHDZhU11cnRWHiHS8np3rPVI1TxFXTSMBVyConwMlx+pr/Of8OKu
 AVThAgMmK4x4BYATbgxucLRfWpvwziKSmR9MBHRDvHrKyilgLPIEPxXt98O4zJbtNp7AlShCRrp
 XnbQe58kXZMf1eBFr9NoWnfCVmBsb7t6s/fo7uPKpT7yUxlR+BGJPp3neYyIbR6ynmBqa6VQqax
 n2p8ERdrlU43vN6bA7/ZwCPiRXyY++C7AP/zba++p0dTv5LS9YF98Az893HtDG+8USRJALGmpfN
 dieDwvDwNTezkIrik+yHJzIZs980ICLj71gIegZC7Vn0VHmfHXA8Mfmc4+9wLpnj/h14VLg==
X-Received: by 2002:a05:7022:404:b0:127:fa:7758 with SMTP id
 a92af1059eb24-1272fd73f6dmr290948c88.9.1770848400867; 
 Wed, 11 Feb 2026 14:20:00 -0800 (PST)
X-Received: by 2002:a05:7022:404:b0:127:fa:7758 with SMTP id
 a92af1059eb24-1272fd73f6dmr290930c88.9.1770848400327; 
 Wed, 11 Feb 2026 14:20:00 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba9dbe123asm2588379eec.13.2026.02.11.14.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:19:59 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 2/4] target/hexagon: Return decode failure for invalid
 non-duplex encodings
Date: Wed, 11 Feb 2026 14:19:51 -0800
Message-Id: <20260211221953.4099441-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211221953.4099441-1-brian.cain@oss.qualcomm.com>
References: <20260211221953.4099441-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE3MSBTYWx0ZWRfX2NngbnLEjbdo
 q4X1vtfp0FXyEeiGNGn7+p8tt1Ztljx072zpbmcQYo0QpXCPhGbmyssXw+oxT51VHR40pZXSqaV
 E5WN/I0Bmr7xkW0g/z9jDHb4DBq+DBxlw2AfWvpu+Z7D09X2xBaFDu35PhAtNYu1BAAMvKW++QZ
 zE4KT3UrFXOMVWh4TZ2zSoCMZbTNXDX6vicTKaodADhBxbubLijX97CK4kmsbWkqg1UR5YC1Yhy
 MaVTSclgYfTsI2swFP3UgXmUzSeC9Q+CnfmN02DEXt9OmfkWMEQ8XuzxrVROT/qIFMOHyDpQaVZ
 nSFOj6SHyIkRt+zMSNvJtThApksu/nKpAvJUOUxVEki/RKYy0jWfYzWGHtR6DE4glgX+AVuc8nt
 DbYJDq/imLgUaRfRuEoMk5BNptrwecjOXgMBcvPDtPUQ0KKIZfXjsTh3Y0NPhPSWDaRw9p11Uum
 vmtuLuac1+s6lD8eeVg==
X-Proofpoint-ORIG-GUID: cDNbEYDE-4W85JR_jgi5bksjUBPp3eUr
X-Authority-Analysis: v=2.4 cv=INIPywvG c=1 sm=1 tr=0 ts=698d0091 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=D67r-eMCZ0zeLs--bqkA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: cDNbEYDE-4W85JR_jgi5bksjUBPp3eUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110171
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When a non-duplex encoding (parse_bits != 0) fails both decode_normal()
and decode_hvx(), the decoder hit an unreachable.  Instead, handle
the decode failure and raise an exception.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/decode.c              |  3 ++-
 tests/tcg/hexagon/invalid-encoding.c | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 69ba1ec96c..33ad60c5b4 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -489,7 +489,8 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t encoding)
             insn->iclass = iclass_bits(encoding);
             return 1;
         }
-        g_assert_not_reached();
+        /* Invalid non-duplex encoding */
+        return 0;
     } else {
         uint32_t iclass = get_duplex_iclass(encoding);
         unsigned int slot0_subinsn = get_slot0_subinsn(encoding);
diff --git a/tests/tcg/hexagon/invalid-encoding.c b/tests/tcg/hexagon/invalid-encoding.c
index 010a5eb741..639d7f2495 100644
--- a/tests/tcg/hexagon/invalid-encoding.c
+++ b/tests/tcg/hexagon/invalid-encoding.c
@@ -65,6 +65,30 @@ static int test_invalid_duplex(void)
     return sig;
 }
 
+/*
+ * Invalid non-duplex encoding:
+ * The encoding 0xffffc000 has parse bits [15:14] = 0b11, making it a
+ * non-duplex instruction and packet end.  The remaining bits do not match
+ * any valid normal or HVX instruction encoding, so this should raise SIGILL.
+ */
+static int test_invalid_nonduplex(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0xffffc000\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
 int main()
 {
     struct sigaction act;
@@ -75,6 +99,7 @@ int main()
     assert(sigaction(SIGILL, &act, NULL) == 0);
 
     assert(test_invalid_duplex() == SIGILL);
+    assert(test_invalid_nonduplex() == SIGILL);
 
     puts("PASS");
     return EXIT_SUCCESS;
-- 
2.34.1


