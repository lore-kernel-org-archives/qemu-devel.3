Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3632DCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsZa-00080Y-Q8; Wed, 03 Jun 2026 16:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZU-0007z2-0w
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZQ-0004Dm-TF
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653HA0xP2650440
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=30eTlKxb9NX
 Kc28gPXWE2gtFrzPIYn61U61CqJr61Bo=; b=dTO9+VQfx0yBBy3UBm7JtJsMGqA
 f/kkdCIakGBZvgBDIGz5bkXZdzj0cUSNnX/yZKHeODWqBgF2mumN3w6u2BQvlNiy
 nSMgBFOomkVKb0ZHIwtc4C2TfN26vNx0TtrZpTBkRrMzdNBA9L0TiE2UET3mx95l
 AN/VB6oa7VnUQDE+X2HhzC1Dhllx0ja86unEFzV/PgnxqXHnl55iCG4zj6bs7eGe
 bjP8W/SqMPkApzFQWC2rf7pURtWUmAgtIQoMPYEK9yU9UaEbp2vWavR2uYDh66qW
 ZQtkPmwnLYp9Kzt+GWxpSrY/+Obu08fXo+Ut7uyrYttLjb4zPlKJ3kVJzkA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejre9gvgb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3075fa5a407so1200302eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519931; x=1781124731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30eTlKxb9NXKc28gPXWE2gtFrzPIYn61U61CqJr61Bo=;
 b=AfUjGvq9zglDp2qJ/6j9UvF4m4TDZ/PcFtGOyW9xEyjvpEuaSwz0fRsr83qFhxKRWa
 /Jzlr43GUR4SMF3UyfZU56XBSq2dFug9/xuHm7NpbkzpC8QPW860PPIPb33x1NzGnGuc
 sfX2c7m26tQ/YrOs0b7NDT+ut/QuHf8HlcKv4/u038J0VKcjyvbmrYzn4emybea7B5pU
 4gx7H+lIelVeX0rvBXnLPD2M9Jb5t3w0ob38/+47ANoBF3OXsUEza75bdN9HVz1QTxip
 ASsgTjbtBYDNWtPpDA98Gmt1BR2AEByr3QHxWdwMA1vgM0AFN2y8Qr5Y2tGnJvri2ZBG
 Mdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519931; x=1781124731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=30eTlKxb9NXKc28gPXWE2gtFrzPIYn61U61CqJr61Bo=;
 b=mtyvWwxjyweZzFUNL/2bM4q1B1oe9MSKbIJV48X1gbga9lok8xK1/8F4G0ciBHBgwg
 BwgxVv+DS/R2dOHzOqs6xUp809x6Bh9ha55TEzpTjL2tcixmymP1glPXiZ9gaZRETGcF
 LSNG53Xq+8D073eWk7CYSFiahuPFHclGSvQfhvhOXFNQ6BttjQjCr+s5oyAjPinnmieD
 T8mkgVUzBou7K4WVSoVjj0EVBGnO0zosuu5GueVzPSg4ibAiQbmi1DK55s+pMOs8hv7r
 S4FUlNv0T+1bD40r0N0rtSYUdlblfAYhNDGFqkhpG6iIgyHNL4JinajCbXnGOC14AxE2
 eedw==
X-Gm-Message-State: AOJu0Yz6MlInvV2LALWVionVFA7DrCzkk5I2p5WQViQldYUAA+UmaqqG
 xNQw1Eonj88zzr5b3YhELpMuS9fuzcS2ZTIcZM1kG1YJtL212tXwp3YttgfoZ3s6OhcHRRILFV/
 z3zkQ5PO2gkiet1gIOVBFGNSHc9lY732/rg0pkvHeABl8ATMQ6XPgkTBWE3HfywGNBtiV
X-Gm-Gg: Acq92OGDXDoKAyoGfn/ljYfKciSseixaNKx/I8KlNaIkYeKYiIpLu8Y8D1B2SOlslfg
 ZgFgVtHvSnU2AoIX4vT8SSTqF2HhdCE4wLBfA5WyYkRBIS8d1munU/Ou7xlxxHYiQ9nyi4Xjd18
 V6kRp2t6eWeX+J5SEjIEy6lpMP8AL3dp94DtADcvVfr+u5y0Voff9oCOuZV1Y/oF+P3Eiry6n5R
 mt/mAOb9IpfXPGTZWj5EKSe9GXTdeNxLyGbwE8xD81Qf6jV8xLwaO8iZsFHexpErdLtK607X3xu
 9Rqg3wqFTLtpJpn5lxM4QJgKX49LMzXj3Hr6HaWy2O6tFRCdp9xjTQgZ7/PxqqqP1AuGjcE6LB/
 7Vm00piThcBUZkexoJWfAqcAN8JEcj6JJmhoL34CiHy3razRptmLKemeg8s4k6cqx9xkpEc+21E
 YOvqlY+SDT1cAF3HQm
X-Received: by 2002:a05:7300:b58a:b0:304:ab8:f899 with SMTP id
 5a478bee46e88-3074fa825camr2564290eec.8.1780519930526; 
 Wed, 03 Jun 2026 13:52:10 -0700 (PDT)
X-Received: by 2002:a05:7300:b58a:b0:304:ab8:f899 with SMTP id
 5a478bee46e88-3074fa825camr2564273eec.8.1780519929932; 
 Wed, 03 Jun 2026 13:52:09 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 08/25] plugins: add userdata to
 qemu_plugin_register_vcpu_exit_cb
Date: Wed,  3 Jun 2026 13:51:35 -0700
Message-ID: <20260603205152.1440291-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fpkFUTR6egp-3dVEyXwhUlxdgMwu_LfR
X-Proofpoint-GUID: fpkFUTR6egp-3dVEyXwhUlxdgMwu_LfR
X-Authority-Analysis: v=2.4 cv=KoF9H2WN c=1 sm=1 tr=0 ts=6a2093fb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=O7a2TYNjfv3XMJ15LU8A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX3e2YzZ2ilBjN
 ZpOI4orEoKwYC2b5oTzo1B46z3RfuzoRRt9j+g9y+eO5JOfJpgvlIdJHGInE+S+/dVy3bvuYoiM
 PZ5tDRYoAxGB/d0JMtc8OcdZayq4uWB1fybfhJaQRo0tMTR3qTcfMxeHJQ1Erj/ytqXZYdqc8Gg
 KBWLUjiubxHC7L86SOTYj/m2nuVvCK4MggbghwVh/PSxbckLRH14rCqmVmfucxE8miS9jhYEL7n
 ck6ZnheBstT0CitQFe41U1aRLrJx/3vuhPSe6zo/Vy9aPsxStMvMZCx2gbCVffEqWAaamhuP1xE
 TjhUuUrioSVke5Kd616t2tPxPXELyqMW2wQOfgXWUNu85bldPppF1Tsdt6zPiYU301QgZi3ZNhK
 t9R/NUZCNTtZPgxwkl93SXaOwz06DoG7XZcOUCcuaj14GRxAEOGmP/Aw6yUPPEPVNU6NQq0VwJi
 w0WOI2ISm0byuIkEcWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/ips.c         | 4 ++--
 include/plugins/qemu-plugin.h | 4 +++-
 plugins/api.c                 | 5 +++--
 plugins/core.c                | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index 1290a624489..2c110906731 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -97,7 +97,7 @@ static void vcpu_init(unsigned int cpu_index, void *userdata)
     vcpu->last_quantum_time = now_ns();
 }
 
-static void vcpu_exit(unsigned int cpu_index)
+static void vcpu_exit(unsigned int cpu_index, void *userdata)
 {
     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
     update_system_time(vcpu);
@@ -208,7 +208,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
-    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
+    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
     return 0;
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index bb4569a2291..d4f8a99027e 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -257,6 +257,7 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
  * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a vCPU exits.
  *
@@ -264,7 +265,8 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb);
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
diff --git a/plugins/api.c b/plugins/api.c
index 68b564bb9c2..849790fe13b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -78,9 +78,10 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
 }
 
 void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb)
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb, userdata);
 }
 
 static bool tb_is_mem_only(void)
diff --git a/plugins/core.c b/plugins/core.c
index 1d5692b3f41..15fb548f68c 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -89,7 +89,6 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     struct qemu_plugin_cb *cb, *next;
 
     switch (ev) {
-    case QEMU_PLUGIN_EV_VCPU_EXIT:
     case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_RESUME:
         /* iterate safely; plugins might uninstall themselves at any time */
@@ -115,6 +114,7 @@ static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
 
     switch (ev) {
     case QEMU_PLUGIN_EV_VCPU_INIT:
+    case QEMU_PLUGIN_EV_VCPU_EXIT:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
             func(cpu->cpu_index, cb->udata);
@@ -306,7 +306,7 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
     bool success;
 
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
+    plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
 
     assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
-- 
2.43.0


