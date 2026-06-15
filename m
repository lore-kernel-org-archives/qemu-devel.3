Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4C2CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6x-0002xh-Iw; Mon, 15 Jun 2026 15:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6M-0002Vt-AU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6J-0001Wo-PV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxJ2h781727
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YdjsSgcz8u6
 /17LgYDQLIzSOZFP9QSSqnKDDH4KO6TI=; b=noEVO42u1nyqnv27KHC3a+R+4j2
 e9VW4MNC0hnqvphM40YT1VhfKf9QWvh8MmE0PiuHyaCldJvDr7JH3rJ4sDhRBS7K
 s9MbqBjNcA0VGtnm+xTY/dHhgTd1HclqNV6WENfj7JYyNT3xraDpvgbmHQwI5ix9
 6UewJ285PS8fKN7Rv5fBwDqTId3AZ0XXSVLEowD5hUTRY1QwQoNDlVDl58Dml/yq
 3NCkrLjEAfUzRHJDGMM+XSfhA45nfx076KrJx1Ah2RhjROv1l9wye94YXXieUENU
 7Ar111EdOCbcTNfoWn/QwM8CFHjZ6kRW44BC1sraLXmyH3yATTpQrCGU58A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjtnt8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:36:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3080bb0267dso351492eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552161; x=1782156961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdjsSgcz8u6/17LgYDQLIzSOZFP9QSSqnKDDH4KO6TI=;
 b=bQ+wSi3Auh45+LvaXw83VNw3NhGcYGjSBp/zUcJGvKbHq376T/zDgFK7CaZQQcpOWw
 5s5HC5WXoZ7T8zvYNifJSILtj/cg8G2aWlHW4cfGQpHzixrKy0fEB6+tvE+qlYj6W47Y
 OdkxruQ6onMRe0Ai5hOeD7Rs4EaGmnO7Sm08nvH4MvQSvBHUl5V4dn3HtGYBaJ2W4H1N
 LXlXWdMjo9uxDGShF5YhUb80wKWCWJ4KsQQBCStcsqS2jYJLB5RyrskxcarRrmny8o/Y
 X+DPXbbhv5UDd/JAKbmOqEiGQPgUz+giI2Lbs54Zmapo98JKzvluwwUUwdDbkuLir4x3
 RckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552161; x=1782156961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YdjsSgcz8u6/17LgYDQLIzSOZFP9QSSqnKDDH4KO6TI=;
 b=d0HpZfNkgnZlxb0HfqWG9IFV4med6qVx0puoq+BUg3FPvIwc6rkS5kGELOuXuZx/GJ
 xOCjJ2Ny/QXZ6Zctj8n9tD8lOglfBapK8dBqtU91U7KEwk6Cng0yK175bbzf8l+9WYs7
 UxyxKm8EmBYjkRlaHojrsexcsOR/ykhUdLfeiQwxCi7CrtF1QWFE33rU9lMUiOI7BXuQ
 K2FWjDf5asjT3aTSX3m7eaBKpv9andwpzzAii8L0+RzS2RgSHlyfJtlX2AafLcbB2dAq
 jW19zwBjz0gVsix0yz02x+Cib74mOMcsnrCFSRz7pdwgO69n0iHxjAEhmEjZuWYk4Es9
 pmWg==
X-Gm-Message-State: AOJu0Yy2PUUpP6DQlVQQwoauqltQV4AuQhbATA746HHOaZp9o3kVXV+P
 X8mCptxNwDZc9vNXhzqV2LRsBVpAfB/ysQQ72/R0T5Acl+eF4Zf9Cezdnv6YBMWqiwk5FDNmtWu
 nkC8veMo0TOLX7BkdRDYRQRtr5XgX+zmY02nxL1YkrLMYMQGSggh4s0D6jC9VKG8n4Xy0
X-Gm-Gg: Acq92OEHmyDY+BjRXxm5vbwE3NsgWIyfS8sTYgls8i2+bLAC4Qffk6tuaHyk4EpnZU1
 yUaUG3IldB4lXqpwMl071LqT09S2NAdxiVdRq+a+gP08Mil+oYan1KoVwehRDKEHpkli6SAKgi8
 zgUrMUMs+A6JwUrCyOT5Umk8Zm7tj3lNUoT/+8HIhRoM4ZJHu9vn09lkQ/xtli2RVijsNLZJXcs
 YCH1YWHjngJHiEQYje/UDPAPESuaWkIFo1DXicBAB6GR0y3C04ws1jpr+0kzGd/h+CALaRXf2te
 njEZawGaWnuPrmL8UvIA7xd8CbAFCq2ApSi/Yo5d1ErYnTpQZUz+NJHfo832yPQAEQU643czIIM
 VNxc0CPpgnws5e/XDmUmMoL9uun0TUqSi1iVz2Sak5zbCtDBlUiqy4zsznw8ZbBFLtOdSjKMhZw
 /pF7BzDw==
X-Received: by 2002:a05:7022:689a:b0:137:fac1:c062 with SMTP id
 a92af1059eb24-1386f2403fdmr5743152c88.7.1781552160909; 
 Mon, 15 Jun 2026 12:36:00 -0700 (PDT)
X-Received: by 2002:a05:7022:689a:b0:137:fac1:c062 with SMTP id
 a92af1059eb24-1386f2403fdmr5743122c88.7.1781552160029; 
 Mon, 15 Jun 2026 12:36:00 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 23/26] plugins: use consistent parameter documentation for
 userdata
Date: Mon, 15 Jun 2026 12:35:22 -0700
Message-ID: <20260615193526.2883349-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX5p+d48WtgjEw
 aoNCzDkOSoddVwWwov1j/mni9nTJcIwRVIjwjKhk5rSl9EmPuVnfTmNkGh94xpvnc93cKrtuQVR
 IG2ymOroksv3f0Qr021m08+FEz/4glGCe1B/dhYG2omsK8Wzc30edA2m/DGXHrylaIejpj2au46
 m3Zvwiws0QMIVSjHCCJAocasSAd+shzRu4ag8iE1jhR7gW0O8gBYzqTNeDeMvFeeYUwuSkeNuWm
 VnegBWM5vnxVromdauJP4YkB/DANHgT7JaDDyyPk1jE1a7FQx3oi1jJDO+wOszdR1BA5qKEhci6
 uJE1coF+We6DTeR1j5ISWiyAqbZXIwLb8waya/5Sw3mmazmuMEu2pqBHp5VHzjlVnbCBMsD2wqB
 TjZoPl9mszgiSzGeblZYeiapYWV+Gmfru0VdlbNp9o4DZcdmexrHjQYlCdQhiepYZpdpVrMXXQd
 SHEfNV1tod1kx6qYMYw==
X-Proofpoint-ORIG-GUID: 3F3e1QLaRJrzRO7SKVIneUh2UDqlT9Lz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXwr6IqJYmxRn8
 W+Y/oHC6jkpi7d3IREEu6AXiBOpu81I4YJW28r7UZ8mjoO0M774dhbgrSz9h2Y5U5tTdPU0kR3/
 wE3ZgcsGoEzYpJHiE11rTHDnpdVpiso=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a305421 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=n1GYMWs_v2V8MhWbidwA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 3F3e1QLaRJrzRO7SKVIneUh2UDqlT9Lz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
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
2.43.0


