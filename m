Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BE2CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsa8-0008Km-Je; Wed, 03 Jun 2026 16:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZp-00089K-24
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZi-0004Ho-3F
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653KgoI41740458
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uHWPJptOowl
 lfeARCp7csyqxhGGe6CXgaqzWc8TBjX0=; b=BI+kOaQhi5RXHR/s2pN9teEQVT0
 NUXx+XkvteGYS4wLrCMxRoN2Zpk4RE6dA0MQ85nNUe0niWuWTocxwHxgRWHW+CV0
 x3i/ccWX4ddb4nNBOe98SiWm40Zz5U61XrthbFkR/rFZqx07LfH7LYw1OYp574sG
 OjV5C4+UjlFLWorHAe3LygcUoUua3cRYvpH0oqViz2iTVShAScx8q2NJTv6Hb1U0
 DKP86AMKVEC1Dmd6EJ95JS2xFhTSxy0AEhCme54TqpGYB6nVXyi95PpcFztlrsoF
 bbucjgYnWc5j/7p+EXxenGYoJfi6D4wAij5n+dkX3t5lkDSyyWxUMCL/g8g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejdq7uycx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304ea42b025so587597eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519944; x=1781124744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHWPJptOowllfeARCp7csyqxhGGe6CXgaqzWc8TBjX0=;
 b=Lp2EBCVfFIRjrD94pssY9uupz8M3KlSPSnWSeIW0avhLymcKFOH3jUYdfFyPANYnuS
 LmWATas/YIPHTsJrHP85pd0fSbQ0PhOSlQuyqpH4aCffBOjy2FjTE6LavfVXTOdX7pXG
 jXKOGli9L6fgtr0yN1W9zpUahUNlw9MrqvufV354Da+nzb/b9GFXsaAOGfJCehGpsH+q
 PvZ7QtkypkL2PC3KC0yFtyybTpmy//dbCzcLBeiKWRnQUUkrYoIgf9o5klD4qkzBhH0v
 4cxcsXMcwrR39MzLfxBr/3WZFrepU6Bk8J2zlli0trr6TLaaqAs4BrvdWDTxt1k/V9UX
 ZfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519944; x=1781124744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uHWPJptOowllfeARCp7csyqxhGGe6CXgaqzWc8TBjX0=;
 b=Xh6/nLtmRdu9PEV74fYlUFync083fHDrUs17WkNcm41iG4rem5wdeZcuJnGer5vDp4
 lTIIcXL76/oToj8W2h1ciaJmVHokCrXdgd84Q6MRhtDDlHYDWW31gsjAd/BMIF0xo/7U
 gvfIVhHLBgzNloABoHVsV6UFGvsIgq5awnrz9Li149U7a5dtt+zfGKU5AYWpyKf1HqZB
 NV8cDjY4ozGDdolUBQ3quszeVuz7F0J7qh76DhOfHV25Yahi/myGaUe9lO1015C3drnn
 WmYyfXbFr3mr7iAJryx8KJh2Zuv5eCW45loWZE9Z09tcwxuPs9PDgR/PtlfzCmlN/mEq
 usgA==
X-Gm-Message-State: AOJu0YzoNPRuT62+Rlfj1c440AdEZs2/i9oyMlTFctj56KxlVSgTpti5
 WJMCID2PTkfuDn+CLqO3iXJNvZ4w/kdly9TAm+7/BU8GW6R4loBczA/BVkhXE536D/uhTVL5oJZ
 +afIMU2Ad6vCshDc/0VxtIMrlHDaApbrraZD7OfUzqCyEWt5koG6LzK4OLbrh8zJAfGA0
X-Gm-Gg: Acq92OFPayKl+6Oc23+oIXNlvKo1Ycvuo9vLL5f4FWeJt/5bV7aKqL6JI2JfLqH1Qaw
 NiR7LdAndyoGNsi4yztpKF/Fcv9qxXVy9s7nhCaqj7X//wyIHwhJ3JLzAoZaq3RB6Sjt3M1DsKv
 +mvdqoov0gPTI064RbFSP6XmkYQaCv8vBjo4ZN39OTJntkbgeWdaq+Z9nodEpKudon39HW61pvs
 E5l3owpp9fqKLj1ekJgZZk38YKQxmFGzY2JlpAb/VkPeD5fJZklvkU+kOYJNZMAUCWOmpMSj3gT
 vQDwpkkZwUZcERVZVY5BIRvfgk3Zjvfv8WrQ7VdwAcSi38aNyC2zCs3H2hqflULYfPIhcxBRqEp
 KX9mg/VXuktAu7Qy/FGwQLlpqY23VUIyldzW0E76xbJoiesBB7gH8LQT7nqXQzAzQVOOUxlCWML
 +gMCRIhefAyK1UcFBa
X-Received: by 2002:a05:7300:d505:b0:2f3:b7b2:cbd3 with SMTP id
 5a478bee46e88-30761eff6b3mr478334eec.5.1780519944254; 
 Wed, 03 Jun 2026 13:52:24 -0700 (PDT)
X-Received: by 2002:a05:7300:d505:b0:2f3:b7b2:cbd3 with SMTP id
 5a478bee46e88-30761eff6b3mr478315eec.5.1780519943667; 
 Wed, 03 Jun 2026 13:52:23 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 17/25] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_cb_t
Date: Wed,  3 Jun 2026 13:51:44 -0700
Message-ID: <20260603205152.1440291-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX0icQPFlCunjr
 Bvik89Xv2OwsBMBpfUj44mbhccbbCLAaSIMwNdXddl53nm5Wh1SPMcPsN7zY427tjyTCvsfFXQU
 WHZVGKOCL8SIIXqEh16mdBJ3jjfL2/VwqPndFhocZEmpUL6/comZGGkG02N66e07BA1xf6WcSKy
 g/uIYHjRJyWLkxAT0rdjG36yBS+qPN8mkefEcaaNWL35sUGYTWSDDqbk/dhbgJm/rZbbSJmm0X9
 egZ9wWmwYWvdvCZTrGySRUSp/YdphGyhHyL4RUWvnYXHbfEwBdYcCK+2MNrpAJowdqan9XlEIe4
 CRDKbEnazIeGD81RlYL9K400Nyf5ULt0pYWMj98I7WDG5pMJ3LW51kCJbSaB7xhw4LUdGDb5/ep
 WIEFtDXLyhqM65etEUEnuQeJrcPO3r2d8d0Y7fIUy4S1Ab9GT+z4l6llPOdlPNmBm2WR9EiaIEc
 5g/ig5PTd9qzDJ2j89w==
X-Proofpoint-ORIG-GUID: 1P4dClDotyIws9puQ1R-bTmRUxrvlLpn
X-Proofpoint-GUID: 1P4dClDotyIws9puQ1R-bTmRUxrvlLpn
X-Authority-Analysis: v=2.4 cv=ccniaHDM c=1 sm=1 tr=0 ts=6a209409 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=XHT7D-x7ZMtFmikgfWMA:9 a=bBxd6f-gb0O0v-kibOvt:22
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 3 +--
 plugins/core.c                | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 53daa09fc72..d82d996bce6 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -830,7 +830,6 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
 
 /**
  * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback function type
- * @id: plugin id
  * @vcpu_index: the executing vCPU
  * @num: the syscall number
  * @a1: the 1st syscall argument
@@ -843,7 +842,7 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
  * @a8: the 8th syscall argument
  */
 typedef void
-(*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
+(*qemu_plugin_vcpu_syscall_cb_t)(unsigned int vcpu_index,
                                  int64_t num, uint64_t a1, uint64_t a2,
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);
diff --git a/plugins/core.c b/plugins/core.c
index d891da93040..878fc47cbe1 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -533,7 +533,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
+        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 938646f9359..bfe12ad5558 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -125,7 +125,7 @@ static void hexdump(const GByteArray *data)
     qemu_plugin_outs(out->str);
 }
 
-static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
+static void vcpu_syscall(unsigned int vcpu_index,
                          int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5,
                          uint64_t a6, uint64_t a7, uint64_t a8)
-- 
2.43.0


