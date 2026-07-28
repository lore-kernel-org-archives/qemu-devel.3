Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F675C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZkh-0003QG-04; Tue, 28 Jul 2026 00:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjc-0002Kr-MN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjX-00027N-J6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S40fkf1593513
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dI8KDH83gtjPcdzvlZUpW22Kn62ST4iV3p6dUzDs2OM=; b=naX6M5SfODs+rDMH
 8aFq7Wq+QF29Q+yKgGnIQ7GnF0ida+9CdgKXfmAmG9fzN3u84rzzY0+Grm+5npTB
 61HnNa7S98mEd/kmuWhn3cZbzzREavmO+f/N4lIfC2XhM4krSVQmifktc6fB/P8c
 9reyYxboZ3nzfkSExZZh35wmB4O4wTBCQrq7dP4Y9wqwzZiI6te/OXbT1CZPOOHN
 LJlf/RenhH10IMhJIBT6qzzi6sEiZE0mDbIJsMOj/AfJSgfwLkZgnS42yGernhDc
 4cq0jEcwBFtbmL2eWSB07abSDBT9PkfStGtHM7AuwVrbbyDGJHqoBLiDWo+AhkFD
 2KUZjQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19g4jy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:02 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso4325560a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214081; x=1785818881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dI8KDH83gtjPcdzvlZUpW22Kn62ST4iV3p6dUzDs2OM=;
 b=N+vLhNayMoCLUTUsRBvegi+rHwx1qM8Qbo4lVECSpx3L1YfBIAVdMTi+US3XDFHzFi
 lCmKIJkseZMAe9OdmNJUnFXONzYjyzoQ5sJZdVApILCXKR0me3ShRLKSrYsOVAgLQ7XE
 RR8Ei+Hd+VcqaWP25qqce3AqFH3iKDXHF8sNa5vE0OAexjq9W7hpHVvfijXy9j9e/eHa
 ooHpdI6FxEN77Bfd7ONe+dsDZ4OtyW0DZZEsZgVq+pFWP5xmcz6HnXWWxfRnEzQtkGOm
 BHLKY5vluXLhVE9M71LxVLH7HKJAKf2s89HQaFnQmONPWeBJPsQezU3EiIw7CZ8Gy6e9
 6QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214081; x=1785818881;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dI8KDH83gtjPcdzvlZUpW22Kn62ST4iV3p6dUzDs2OM=;
 b=MgkyxFVzwiaRssAuJvZrRdHGCT8Z6a8CF7JUUPPq1fimNmFnYJnznnwv2ZQkfx9HkS
 aXPaOvzelRu5rrCYRrWvYEkZtDruiFmuneGj6h/4ldYo7r1yyhIJEX+/rkPcFGdJnUHl
 czRb54aKw5Z2i9FLuGYbaHq5FBQOzouCS8kRTsM6V63w9NHOuxuTjHxmHY1T6Q70ofmx
 v/WRXb+dLiQgWQM2icZMcP5kl9WQqx0RizhL3+lkZ0AvOLf1yW9tLI6a69kHAk9jJeDK
 9BmpaznMHabUvCToq7W5E27tXLd8W1kgRWbGCIIsqmxK664lzqFirGljRA6RmtGhaGwO
 lj+A==
X-Gm-Message-State: AOJu0YypNappPNqQJtWttIZ9yInOGoDUymwov2hI1Yy4UyonbafbO/y1
 SAADva1PZosr5NBk3lyB1NBpWdPk8QRw8xbfTFFY+v+gGP0GOYaPH2Asiv69Ef2aRl2P+Wyw8OT
 oDvxEG8XMO45fOj50jxr9wVb/6rVq2hxR/owwRjds86h/4qF4aOt4B9TRjXs2heJXGQ==
X-Gm-Gg: AR+sD13PCz6v7n0FBF+6LMkysNI3UPmU8Lx2lW+mlZDIzpimPNnMXCIF20WaXhSqoia
 tpLRvKTXlWyoUBHJJodQV6meCZeHKE26tS0Beq1P49aba+doNWax+54HL1hRaKvHN8iaxTWb1fv
 WQHXhVrkjCmnt41HkcuQdXn/DdvyGm1yuZcrxUJmlTCQ/W7PdYqy8c5ESkGuoE0t/0UmUyqO8e+
 F7uXeIGvTNPEJTti4Zxu/0ErMpmIAE4vGWpC+K5SGejs9oEGVNvHlNe5G+YsY5X7uDwoR+EBtDx
 HNVL8ewqkR8Cb7U9TeQowAnrTVKPlmjyuCje2cTuvByh0yj3N3QEPwnUWDyI2T0cD+5xfeOZS2S
 tmQPwyFlAI9qoSdOU0pVrgKLxiUxKIWcKXMD/oCgSeIhMSAyuze2inXTjo7gqJCR4SRUmKK0=
X-Received: by 2002:a05:6a20:7283:b0:3c6:3c5b:f32f with SMTP id
 adf61e73a8af0-3c8ba5f5230mr1133763637.51.1785214081506; 
 Mon, 27 Jul 2026 21:48:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:7283:b0:3c6:3c5b:f32f with SMTP id
 adf61e73a8af0-3c8ba5f5230mr1133737637.51.1785214081091; 
 Mon, 27 Jul 2026 21:48:01 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 060/103] scripts/probe-gdb-support.py: add mapping for mips
 architecture
Date: Mon, 27 Jul 2026 21:42:04 -0700
Message-ID: <20260728044248.137626-61-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a683482 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=plJD_5OMxHvttXuW0nUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXyOkJCe2HaVMY
 Ez7Q9uJ1DhK8GFzgJ8PEY0ZvBdRDREkTpWzuGLQZ8Ae8ntAZq/COTuS4S0cmHiLvUB4qRHMOy4F
 evyErvvVlNOn8DFrrXXtRdZE+M9n6eyDzFXazaC+AuuUXUz/qrXxPLZQVRpR/bpbPy9yWTjduwo
 Ha+t1+sK6NiINjipRU6l0YPTquz2bmu0ngmwPR1SFKzw/5bxu4Y5Dop+wz1KpsItZHKXv3Qng34
 nd1V5ZCJmjo9L66jEv5aEzTzxQVhe1bgzvJLsDZ6LUCs+PZSTaz7t1qtQVS1J1sD3NTHvcyeLRO
 NLYRlyI36UTaeHk290DnURAbcOIL2uRmibAZu5qT4TzkVjSz+ntHG2+L45Iij9mz5jsi/NzPWMS
 NGB2Zqo/tKqV2Y3zi6o+iIYs7bI8ltrYC/sA0mg6qYxRQb6boiUE3mNv6O3GDr0vpvyHII0CR85
 DCeYXPZ4RYKuwOwc0Ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX6Rz0DN7zPz21
 UdxtctWS2QoI7vBXdrQLU7HxyqVpivHITbdO0s7I97RdlqvrNcnEIxG0T4jalmYV+NstOREsGmn
 31yWn0PpJ90gVpW0im+OYnS0jQires0=
X-Proofpoint-GUID: JTrr5em7iNx8wztWYZeIRVxPH-aIP1Vo
X-Proofpoint-ORIG-GUID: JTrr5em7iNx8wztWYZeIRVxPH-aIP1Vo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280041
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/probe-gdb-support.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 43c70302873..6e3b2579770 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -35,6 +35,7 @@
     "Loongarch64" : ["loongarch64"],
     "m68k" : ["m68k"],
     "MicroBlaze" : ["microblaze"],
+    "mips" : ["mips"],
     "mips:isa64" : ["mips64", "mips64el"],
     "or1k" : ["or1k"],
     "powerpc:common" : ["ppc"],
-- 
2.47.3


