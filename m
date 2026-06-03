Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81E5CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsae-0000XU-Rj; Wed, 03 Jun 2026 16:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZR-0007xi-Ao
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZL-0004Bq-Vm
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:10 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653K0Jtl1740892
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5tjvain+huF
 1mu/Cio1vuPKXHmlHFJ3xapE/A4m350M=; b=H/dyXbKxQUtrVGDiKNLArZymR0H
 CDl/exX8aNhhAqM7P7kbll2tKdaxMS26xhoUQIC++UYPDfEFwJ8e/YZ6I7pYA9qS
 xoO9MWqAbfpUEpXGNffI/o2k08FNggJuxwYkGHcy3AIuIjuqdBIFJ1/Wm1oV8hm5
 lh5tKhfBmZ80p+p/2KfpSKhhr4UqeEdoFoIwJq7nPEYKZzw1Tave3KP3YLh39aNO
 QfY2BKpjdg/40H9Ry/LVdaCt363iT7389DtgE/ItcMD2FofLkMHI2ueQPD0hblxf
 rt9Zlbi9XlmXnyOfGnkwcctcDWW5VJf0cqllIMpJIkFjMji84xyklsYLtIw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejdq7uybb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f23c55b2so5686023eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519923; x=1781124723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tjvain+huF1mu/Cio1vuPKXHmlHFJ3xapE/A4m350M=;
 b=KkcuGnrOG4mzjLqZJJiPiYmKOBr1UH25pY0onB3eB2tMwygK6MsurPJZrhTm+Bt4RC
 xSeb/j59OJsk7hDsjaG5kM4N235qeM8ZtxVkXU6yUvFv3Ch24s7G6m8dn5lFUlqOPMaW
 +9GVjXJPUj7LQDrpK2+5Aj+cQnCaOjqLA3wYhcvOrxnCy/Jad9Ff3UBSIAR3rzR7ib6w
 ZNZbyenpdqt6IKjromR3gp+BOv/PU6nW1qL+nW+Bzcxt8aJLi7Tqe3aw3ur/utTGTxYE
 0k9AzLjkHn2AFWUPEVqIt79xjdAhif9RbSRO+K7M7h9OUixct0uEowwh8aLZmFJLKY8T
 89Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519923; x=1781124723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5tjvain+huF1mu/Cio1vuPKXHmlHFJ3xapE/A4m350M=;
 b=pNE02Iq1Ap5exTsxUiEYiLIoC4dyCSSUgKJ7TeV5KETdYrrcbvtXBe82pcldDg9uk7
 TwVap+SKr1bzLhwg1VK2sP0rSYGswx2rCN2SyOC7hISLNO+UylTkNu/23ilcWgapsXM9
 P8EYTieIDGJNfSLSsb0bgRWMeKyV2FByZzQ2/+iDEVFmIdpbGfa8R+n6CeuYJaLy1XGV
 gwUY/BUV7W/lKWFX1xg4BjDO/XNzxBfepJTkl2KYcARsEPmpv1hBgz/q8aB+BYuLy14m
 PAcSDMK4LqWGAvfDHaBL/3L3Aehp780Uq+NmF1/n88fi3VRIZ6RMtZeARnRLK9194gPB
 uU7g==
X-Gm-Message-State: AOJu0YyUn5VHHQpfOStE29SVLKvGEE+fJDuKzLoskcrcgl0QegjpKP3G
 92gBe/FrKb/PFE4SVC7Ji5oMwATBumfpHkaqtZqbT6/RyAOdNOqYZALgJGWx0WVTLv4K34UX4/l
 lzNGqgTIE+VhxCUFaHiGapfAncUv0C6bOvNgvUgwoxpAZif2wXt5h1OKbtH1RJq6LaFqF
X-Gm-Gg: Acq92OFfQbuAF0nEBOwPgXX6uf02q8mpLQyvgnEunqjSJY5/sQJgeBJVbaipkHb5P4T
 vMntim3gzYhAS7lTTbo7JX/Aux+irt20VgUDPihqoYADWRms2Ucolxs8FILG+NE2jlknij+b0Ek
 mczUxElOK16BPIQwavpElbd37okgXC28zFYaemkM5m9mvf6nm5OUBAL/QCM0xn/rmZt/zGbT9rl
 RRR/rD1iwFMMNYnhwaPSduqTiqWyMhjkyXG1r3Z85KpGZWzWlYYHoGbgo2szXI46qJAH5mk9iuc
 l30mO9MaorhX5s4cgEGpGwnSBpmeDZupoqWJb/I+Hax09xJHv02T3YxzMJz+edTDZDXKPFghI2K
 4JVsbq8/TpNvDT/oNADH/Ynaiirtcs7FLHUSEMmxo+KXU6U6dgzd+WvOjQWkCwyOfkeed6C9w0B
 YYNsfqG+VYD1lwpDSk
X-Received: by 2002:a05:7301:7c0c:b0:304:8870:2ac5 with SMTP id
 5a478bee46e88-3074fa3c1a4mr2545779eec.6.1780519923078; 
 Wed, 03 Jun 2026 13:52:03 -0700 (PDT)
X-Received: by 2002:a05:7301:7c0c:b0:304:8870:2ac5 with SMTP id
 5a478bee46e88-3074fa3c1a4mr2545771eec.6.1780519922609; 
 Wed, 03 Jun 2026 13:52:02 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 01/25] plugins: bump version
Date: Wed,  3 Jun 2026 13:51:28 -0700
Message-ID: <20260603205152.1440291-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX0uymXAOEIeBN
 K+fH2exwphFw2iwrHTUuhAwcCm4eR0D8hvrYXcMW4Nmo2D5/lHQHn1nXImtHKKevImeha59Jel6
 EstU13SlOH5JoMS31n4R1b0golNFJeIEtruNycE3aE/FeydzQeugS8ft3paz602tOt8ZwDFKQzW
 VxATju0yYKRJ/aWinYeZ4q7n/n+C70EmOJKN1nVN0CYQOTDZeSwnzwIeBzrnGf9TJHFOtkLloqC
 74b+EEuoenAv1N9WI8j1H2UFvLoZUr8mqub+YbGX0nRFcFdGpKHcdGzzWopYS76DcOH2rnRCcdz
 VE4oz2VCnTcf6CNVGDvx1FhMUZPmU51FTWtzQ7hBIe2vjdfci4plHQbKHUjfGG73MrZDBaLPkQy
 btf2p3Zpzh4nsovu6A35b22p2kEftGVVrHA5rV1Z4QbX+JWx90IcmObwZ2lbQYlCOO4bX4qLl37
 Sp6loQJs7KC4leqgpsg==
X-Proofpoint-ORIG-GUID: PuaKPI77blYAIqtxWc8M79Q5YpDjmuqN
X-Proofpoint-GUID: PuaKPI77blYAIqtxWc8M79Q5YpDjmuqN
X-Authority-Analysis: v=2.4 cv=ccniaHDM c=1 sm=1 tr=0 ts=6a2093f3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=A7FZhrvmqJkW37y3txMA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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

Next commits will be breaking changes, so bump min version and version
accordingly.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 6 +++++-
 plugins/plugin.h              | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 4eb1d2cd85c..435a14f5a00 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -80,11 +80,15 @@ typedef uint64_t qemu_plugin_id_t;
  * - added disconinuity callback API (for interrupts, exceptions, host calls)
  * - added syscall filter callback API, which allows skipping syscalls and
  *   setting custom syscall return values
+ *
+ * version 7:
+ * - add userdata to all plugin callbacks, allowing maintenance of state
+ *   externally, and easing interfacing with other languages.
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 6
+#define QEMU_PLUGIN_VERSION 7
 
 /**
  * struct qemu_info_t - system information for plugins
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 6fbc443b96c..9179da43851 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -16,7 +16,7 @@
 #include "qemu/queue.h"
 #include "qemu/qht.h"
 
-#define QEMU_PLUGIN_MIN_VERSION 2
+#define QEMU_PLUGIN_MIN_VERSION 7
 
 /* global state */
 struct qemu_plugin_state {
-- 
2.43.0


