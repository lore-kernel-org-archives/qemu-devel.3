Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1CFCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYl3-0005Nx-3j; Tue, 16 Jun 2026 14:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkp-0004qM-Is
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkm-0000Uv-B0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOcbf382311
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6a/dqxfG3A/Aev/oPDhWaZKrpInAwI8mspSH5mJbZb8=; b=ARBrGdjb7syzT23+
 FPOe6ZPB2PGc8bMHl+jEke+v5Ji7Ini81F+fibZ7ZooB1aqSog2zVqG5bXIBPPo8
 W4g96DJjGuwZZfmwnVBT3y4pZy++SrLTop339lwnYKt1s0mmhYJFPBvjlIKHAfj0
 5tF5wQIvfBZG77Q/gJv156THKC9qaEzl7aUOd+THdKj0PtSGbKEmGtvTx82ePe2M
 C4R6WHITp0PwWPqUSK84+hxX+fYCSw0qAMCjYb4NvaOyvZPhzLQXlVBSnQDk0I+6
 tafqIqKPFNjlBsRJjVDAUJIKE3XCyiNK+D4NNIvGQlhUZcvUkl7vZfbP95n+BgMD
 pT9X2Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkjfn6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8423970cb30so3323460b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635384; x=1782240184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6a/dqxfG3A/Aev/oPDhWaZKrpInAwI8mspSH5mJbZb8=;
 b=bL09kfVsGSkTZLfijwJyM/ZLEnCoPohC1oyRGzJ8dy8BTBqPUfsPHV+qeJ54o3sCDo
 TB3GZTF7Qb+XmDYqLTPG31F3TzSOxS/vuaEvs3mfOjrv0lY6qW3zaNRm54aQPaEzRh3c
 n5iBJHK7PsdUxP8LF8DXFWweJb+RsNmpySW3S/wOiSwPX7k62l9eIMck1iqYEFzojsQ6
 AyO7DPUKrhcPMkrJ9rwegH5/LMQ2Xc1Cz3blhUGY4ekdBB2neJ/A/4C+QaLPUEIHUfaL
 VumnzfzxLwM7E/Ya6IO8LZV5vkz6oAGCPjiqg8aBAm33a6iHg9sTbnJpZr5Ioo+Cu9V+
 XLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635384; x=1782240184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6a/dqxfG3A/Aev/oPDhWaZKrpInAwI8mspSH5mJbZb8=;
 b=Bm4qjHE0E8BOewMCANTkTDfptG6XD4zBbLRhai6QlnHOnraWGg/NK22+rv1Iir3Vhv
 LnDTPlo5/3OiSh+R/3xcqUB7duPR7yWJgJIJ9DXVO0hFl7hzZhGFzNj2xlUiXpQZ6ggB
 HQ6JbrKF+22lql4Ywol4ViRUBkk8SZ9SOfkDyQefhKc1FX9/A1J1YU9yU9dsuB5lbnfM
 5dKdOFVLlNCyyYNfqyWlcRtcpXv2npetSoTM1qoTl2XzcIICEj0CcxZXYz1iaWezRMxt
 rZpAoV7kr0UHeh/xh3BHO3VSxOzmGCiUOE/8wxcQYiTLNGIM7su9lZ5T+szOdIT9iCEU
 rU3w==
X-Gm-Message-State: AOJu0Yzfag8sTtAAA6DoJNUvg+xGtSU0tZXkHY5fcZhIGPafQwPIleDY
 LqJl0u421vLauA1BST0xBxQjEusGiTyA4hxRLPW5lgj0WSJ0xk1GLBLcdaPUHN4foALBxRI4WVm
 clHeCHJ2XhlvNEU7Ff28y57kVmshTItxPW5309jeq+q1oAGkeLzxrJoBa6AKHUa72RFMc
X-Gm-Gg: Acq92OF0tc8I/ZIowHyFfGhDHYS4h8TvFeG1NEyTMe5QRslGEc4D+nPE2Vr6zLQmjSb
 ruiIglclk4Aeic7xTKY6ioZwVj47eS120R28lQ8wIHx7bzpOsaStcLV9JMmp3LzS/jNmjuKscD/
 4DCdI8lHRyddY/2v8Qj63W2+lr2+uPADAJc7ugrMEBDMuE6z+eOdh0MBPGWYARxFgFY3fp8EWr1
 emVFQNjl4bB071F5LF5HJBG+9eBVlUWbtMnmOQAbt+7nY65uqtmNL8faqjjcFm7sNyUc/87jhfh
 MA/v/uCgZEemRIvxgrDkt2wwv9gX3RXxS9QP1JdSkv9o1LTCti5l0GT+AGVMEAC1l7QJdqhWFTt
 xUOlAQh+cprNytHb1Sei2efl2Uo4dGlAV31sckwbGk6qo2/Bj8O403RhX7+bptv8axTH+z1xkuU
 imIK6iDYs=
X-Received: by 2002:a05:6a00:2e87:b0:842:3be7:4d55 with SMTP id
 d2e1a72fcca58-84524452dd7mr342292b3a.11.1781635383881; 
 Tue, 16 Jun 2026 11:43:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e87:b0:842:3be7:4d55 with SMTP id
 d2e1a72fcca58-84524452dd7mr342269b3a.11.1781635383343; 
 Tue, 16 Jun 2026 11:43:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:43:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 23/26] plugins: use consistent parameter documentation for
 userdata
Date: Tue, 16 Jun 2026 11:42:27 -0700
Message-ID: <20260616184230.303038-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5OAksztmwwjzyNt6vWosk9FMSb_xarcs
X-Proofpoint-ORIG-GUID: 5OAksztmwwjzyNt6vWosk9FMSb_xarcs
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a319938 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=n1GYMWs_v2V8MhWbidwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MSBTYWx0ZWRfX/IMuJtGNH76f
 6g30KQtzgQtlJs0DWxDns7UlLIgKjmmyzP7uGftP4fc3LSdz4LpTEgManjDMqMYEayGDrUoSNRM
 Ad5PRYnMLn0OLDj4VY74OaG9N5ivN0QWmX8+EsAGxsE+mWyLTg0scTI2saOqQeDsUehIVJQX3Oh
 5Fcl52In3P85Tot5Z6xjr9txj7DPQTqXkvatuoC0mNuOT8ysCSx9F0djcQdObUQU8Pre8XAzut+
 4QY9ZmdGSNb31HRxjd9sVy4rhUo/NnL9aY8/Cq38TDlFV+4ig6C3SY+aqqx2sVZ/20GjX0Dx/BP
 hNtNgA8uAz5wXvlMfBjZeLzcHeoI84Ihoz5DcBuaV6rrLcrUMYxUpHXfpGYtQDma5UH9QaDrC5q
 /7QG+Ya/T4YDSRsVAocAe8TyOogGCqfHbstHtjMitPGIMWCt9TecjJ7Y4iVSZuBzl4RP2oavmOt
 VNSJ0Iz3VHaW/wCjEUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MSBTYWx0ZWRfX0hadDh/DPiqP
 l5JOdd37gPy5oBflH6rvn7cqPn7ee60ub5AD9AfPSC9Y5WQnwfcmA8GgK7uFHOa2ZqbhNoTZckN
 UocEXVHFygGjZ0bqcAxns8+8jckaQuU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160191
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-24-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 36 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 50a39e51d46..d8d4b373842 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -142,16 +142,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
 /**
  * typedef qemu_plugin_udata_cb_t - callback with user data
- * @userdata: a pointer to some user data supplied when the callback
- * was registered.
+ * @userdata: user data for callback
  */
 typedef void (*qemu_plugin_udata_cb_t)(void *userdata);
 
 /**
  * typedef qemu_plugin_vcpu_udata_cb_t - vcpu callback
  * @vcpu_index: the current vcpu context
- * @userdata: a pointer to some user data supplied when the callback
- * was registered.
+ * @userdata: user data for callback
  */
 typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
                                             void *userdata);
@@ -185,7 +183,7 @@ enum qemu_plugin_discon_type {
  * @from_pc: the source of the discontinuity, e.g. the PC before the
  *           transition
  * @to_pc: the PC pointing to the next instruction to be executed
- * @userdata: any plugin data to pass to the @cb
+ * @userdata: user data for callback
  *
  * The exact semantics of @from_pc depends on the @type of discontinuity. For
  * interrupts, @from_pc will point to the next instruction which would have
@@ -204,7 +202,7 @@ typedef void (*qemu_plugin_vcpu_discon_cb_t)(unsigned int vcpu_index,
  * qemu_plugin_uninstall() - Uninstall a plugin
  * @id: this plugin's opaque ID
  * @cb: callback to be called once the plugin has been removed
- * @userdata: any plugin data to pass to the @cb
+ * @userdata: user data for callback
  *
  * Do NOT assume that the plugin has been uninstalled once this function
  * returns. Plugins are uninstalled asynchronously, and therefore the given
@@ -220,7 +218,7 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
  * qemu_plugin_reset() - Reset a plugin
  * @id: this plugin's opaque ID
  * @cb: callback to be called once the plugin has been reset
- * @userdata: any plugin data to pass to the @cb
+ * @userdata: user data for callback
  *
  * Unregisters all callbacks for the plugin given by @id.
  *
@@ -236,7 +234,7 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
  * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
  * @id: plugin ID
  * @cb: callback function
- * @userdata: any plugin data to pass to the @cb
+ * @userdata: user data for callback
  *
  * The @cb function is called every time a vCPU is initialized.
  *
@@ -251,7 +249,7 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
  * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
  * @id: plugin ID
  * @cb: callback function
- * @userdata: any plugin data to pass to the @cb
+ * @userdata: user data for callback
  *
  * The @cb function is called every time a vCPU exits.
  *
@@ -266,7 +264,7 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
  * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
  * @id: plugin ID
  * @cb: callback function
- * @userdata: any plugin data to pass to the @cb
+ * @userdata: user data for callback
  *
  * The @cb function is called every time a vCPU idles.
  */
@@ -279,7 +277,7 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
  * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
  * @id: plugin ID
  * @cb: callback function
- * @userdata: any plugin data to pass to the @cb
+ * @userdata: user data for callback
  *
  * The @cb function is called every time a vCPU resumes execution.
  */
@@ -293,7 +291,7 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
  * @id: plugin ID
  * @type: types of discontinuities for which to call the callback
  * @cb: callback function
- * @userdata: any plugin data to pass to the @cb
+ * @userdata: user data for callback
  *
  * The @cb function is called every time a vCPU receives a discontinuity event
  * of the specified type(s), after the vCPU was prepared to handle the event.
@@ -427,7 +425,7 @@ typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(struct qemu_plugin_tb *tb,
  * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
  * @id: plugin ID
  * @cb: callback function
- * @userdata: any plugin data to pass to the @cb
+ * @userdata: user data for callback
  *
  * The @cb function is called every time a translation occurs. The @cb
  * function is passed an opaque qemu_plugin_type which it can query
@@ -446,7 +444,7 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
  * @tb: the opaque qemu_plugin_tb handle for the translation
  * @cb: callback function
  * @flags: does the plugin read or write the CPU's registers?
- * @userdata: any plugin data to pass to the @cb?
+ * @userdata: user data for callback
  *
  * The @cb function is called every time a translated unit executes.
  */
@@ -464,7 +462,7 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
  * @entry: first operand for condition
  * @imm: second operand for condition
  * @flags: does the plugin read or write the CPU's registers?
- * @userdata: any plugin data to pass to the @cb?
+ * @userdata: user data for callback
  *
  * The @cb function is called when a translated unit executes if
  * entry @cond imm is true.
@@ -514,7 +512,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
  * @insn: the opaque qemu_plugin_insn handle for an instruction
  * @cb: callback function
  * @flags: does the plugin read or write the CPU's registers?
- * @userdata: any plugin data to pass to the @cb?
+ * @userdata: user data for callback
  *
  * The @cb function is called every time an instruction is executed
  */
@@ -532,7 +530,7 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
  * @cond: condition to enable callback
  * @entry: first operand for condition
  * @imm: second operand for condition
- * @userdata: any plugin data to pass to the @cb?
+ * @userdata: user data for callback
  *
  * The @cb function is called when an instruction executes if
  * entry @cond imm is true.
@@ -748,7 +746,7 @@ const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h);
  * @vcpu_index: the executing vCPU
  * @info: an opaque handle for further queries about the memory
  * @vaddr: the virtual address of the transaction
- * @userdata: any user data attached to the callback
+ * @userdata: user data for callback
  */
 typedef void (*qemu_plugin_vcpu_mem_cb_t) (unsigned int vcpu_index,
                                            qemu_plugin_meminfo_t info,
@@ -761,7 +759,7 @@ typedef void (*qemu_plugin_vcpu_mem_cb_t) (unsigned int vcpu_index,
  * @cb: callback of type qemu_plugin_vcpu_mem_cb_t
  * @flags: (currently unused) callback flags
  * @rw: monitor reads, writes or both
- * @userdata: opaque pointer for userdata
+ * @userdata: user data for callback
  *
  * This registers a full callback for every memory access generated by
  * an instruction. If the instruction doesn't access memory no
-- 
2.47.3


