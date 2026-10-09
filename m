Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F95CA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSL-0006X9-Sz; Fri, 09 Oct 2026 18:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSD-0006Ve-FD
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSA-0002cM-N2
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhrZm3986786
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0Jqa1mx1uAD
 xxA1dOl2QJUothdKjUapjlA7h1fwZLlU=; b=InHtTqHSTiq95G6QrKuxaL928xn
 UTt92aaKpGCCkTyiWoDb6/xmhxDViaLbhxxwG73OfBEocjEH937KiGJ2lfY+X9kK
 Qh1YEU7lO1DH/licXMYeoHPYjF5ZraqLybhLtk5ed3shLvAa4qqWSlp27uMITtsE
 u4zQ89CHNhlGDp3TzUjoWowLOVHY3u45INRaMhbwZfrkGFAg51q05WCx7QFCWzPq
 BG+cRCCmYsBL+YiA2npDOY4UbsTxKWY9fjNyYUs+pa+cPbfZXFqoiOSKKYmjTQdm
 e3sP74Yi/IufOL+jgT8yOWVhMSchUWTgBAWx8dKZi9KKI28XPMoYCia5eeQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t710tg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:35 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-151ba226e1bso355162c88.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586354; x=1792191154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Jqa1mx1uADxxA1dOl2QJUothdKjUapjlA7h1fwZLlU=;
 b=KVhm2Gz9yuwQWjfNaoQJmJ5/nEbkg1ES9ca3sUocQJQXhe3E4g/T7wRG8Rba+gMgjN
 axCH9kNGDgZXrCJMb62CdnCgdveNstlw6trsRB1JehjhU3BVilRfpEg4wrtLCkzEvuOU
 ln4YuIuXxjbpsfXoDsfKOqDci0zglk5mIwtGSdfu7190DYGW00bC6dKOgk+l+yR0c+eC
 3c8VzZSsoqIxkwFzaUcEj6vnlfGurwTj2AeQTfO/FOI8cy9lxtEl2P0592iOiiVwClo1
 /tGaac0NKDxA+xemDLyDduJxwTEd4HPQuWp9D19NG94IwfYjuJCFmi5C0bxJMevZJVOZ
 wWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586354; x=1792191154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Jqa1mx1uADxxA1dOl2QJUothdKjUapjlA7h1fwZLlU=;
 b=lBAfQu95607jWsFxll6V9KP4yBrTJ3dLgdM2k9y44YzMxtKgJn33VRcvzq2ektCYi0
 lQaDwD/ojaLo/r93TuNElSkHRz1wxn5s3ZU5uIlMEypSspXln4kWYaJGVCb6EaxhkYvO
 gearn7iy7oM7GEhb0lVH36FKhYO2a2eWApU3Z096cJV5LQt5LE7yf1KVT/XUsyTNoYVv
 XJVAk6Xv4smF1tppB0FwhSUgZvZGYGP5PvQGrjLT8p08MLGfolsVtBHDlROSBAtht0hy
 75Nla3RaBjkqtxG0bnQjaljz935h/IJm9qPVLvhrMH8JkK6gAem2dm7Lk1HG2a7DC1GZ
 SMAw==
X-Gm-Message-State: AFq9FYJdqd5q9W4XuKHR9YXXaEUslDCt2K/maifmOp+K9SSDYv7x/9N7
 tXpVn3wK5VVp7Hnpf0C8CkURvQp+6ZP7uLQVTK/2UtI4268o9I7/ucRnzF9FAMJ+4leMrnZCXC0
 CfSYWIgRU7fVs2vPvQfWIHtRpX37zOkNVyAzqR78MfAwZU8CpD99R3DaixNNny1TNJg==
X-Gm-Gg: AYBFou39iXuEszdMsR50viedXdIYxcmloSZuTpdSgREybFB9S6NLfjTxdClSatPzu8u
 zw0NZ0fAHlnlvZpGnO7Yy1+ptJLbLywFM6foeMJRnNcfiZEgSu0VyTScbzHw+y/Uf1HqzLXlLRC
 X4ImzgvmK3LyjSYpiTLhDfBNLOLtO3FYVgzIzGAiKWY19DCR46+Nz1Nj98/xsp/+9MUlh1EqAB8
 DVdd6s8gLAMBFZCURAHzLTio4XALzd3a86H8DPC9Z3UKPCmvZ/auAV1OTBkrVyXAvEnUzSsAZJL
 AL8S87hp8XklsqLpn05r1e4ncy02kL4gxbrMGh++k0+duNsVuaF2pa+KUGJJQfI5+Vri8G9+NxZ
 zJB3Hr4uPOu80pp3RX62Id4/VWGred7Qko692lww6UtNvCxjqdNcPYC5YYTqf
X-Received: by 2002:a05:7022:1608:b0:143:3da5:cada with SMTP id
 a92af1059eb24-16a610ca97amr3300416c88.37.1791586354468; 
 Fri, 09 Oct 2026 15:52:34 -0700 (PDT)
X-Received: by 2002:a05:7022:1608:b0:143:3da5:cada with SMTP id
 a92af1059eb24-16a610ca97amr3300384c88.37.1791586353799; 
 Fri, 09 Oct 2026 15:52:33 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 02/11] target-info: add target_hexagon
Date: Fri,  9 Oct 2026 22:52:17 +0000
Message-ID: <20261009225226.10657-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OVLczgdeiYbnpWoPttivn2jhQ3RGJ4SK
X-Authority-Analysis: v=2.4 cv=Mbr5KJ/f c=1 sm=1 tr=0 ts=6ac97033 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=upjuZsUD9oIM7hwv7PIA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX/TGhm04tsSwk
 2q98/OXPg3Jo5lK4mUp+5GiQ53a+LtQQudEYUuY20kI4ss5IWn+Z8eXjlZ7LbxveM4pGPGqh+5b
 +blvUtWGj9TsgmE4q0k7IbJhEOqhQXk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX5xBgCpjuEGPi
 OqWUeWFeRGiSWuoshcLDQJdtSeT+Kr9xaob4OmyYnRxa4gE690yBjDg2ySDqmH8chRTG7gqkKG/
 TZkh1LViXTJPLwX/CScOfIGF8USFEAobwKGdqaTQxsvworB63s+YUw4feSUmxqDbPp9lgQfZyu6
 j15cj8RhPX6AkD8Sp+P6+m5jWPrMyrDrT1MIyjFlpfVi/bhLCKXrBor5+Y2D3Iq41Dk0w5Khd11
 LCLPpzSYQ7EAeOJmtLRMVPJ/dEGJDEAP03JXav8yTTTssHt0GD0QwYs2n5ihI3x3pUnaPK/XSEI
 bMd9kMozbm5OaGCK707e3ZK9HGkIyzCXK6Cs6ypRvQj2rXahteUT48k7LGbfsGdUjs4eeqvcWse
 dJQJ3fUPM/rMefZpk92LS0ir9okKpqXSquZFFJt9BSWz5B1npymqcsXzPuGF/MOO/rrvOPeFU1F
 cp/n56iiihBQLgcSnFg==
X-Proofpoint-GUID: OVLczgdeiYbnpWoPttivn2jhQ3RGJ4SK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090091
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index adda363ac39..862097c6c63 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -70,6 +70,13 @@ bool target_aarch64(void);
  */
 bool target_m68k(void);
 
+/**
+ * target_hexagon:
+ *
+ * Returns whether the target architecture is Hexagon.
+ */
+bool target_hexagon(void);
+
 /**
  * target_or1k:
  *
diff --git a/target-info.c b/target-info.c
index ab43c9f802c..0efa4d32546 100644
--- a/target-info.c
+++ b/target-info.c
@@ -68,6 +68,11 @@ bool target_m68k(void)
     return target_arch() == SYS_EMU_TARGET_M68K;
 }
 
+bool target_hexagon(void)
+{
+    return target_arch() == SYS_EMU_TARGET_HEXAGON;
+}
+
 bool target_or1k(void)
 {
     return target_arch() == SYS_EMU_TARGET_OR1K;
-- 
2.43.0


