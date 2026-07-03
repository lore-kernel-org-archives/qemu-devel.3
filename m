Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7341C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfguf-00058F-UA; Fri, 03 Jul 2026 12:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgud-00050L-U2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfguc-0007pQ-Gm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GInU5348221
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1x7QSxrq42ew5YZruERIhg8L4kv2+83eMIh0NOzptfw=; b=P8g21Ib/TmSGAS3Z
 KhTdUhvB4AniMWPCgvQLTbib2uBcqamaZtIZuIZHEX5eC8CqzmjLLsDnGLRRG4it
 H30G13fQiD8JMTtnDdupZi3ELLFDYAhp7PfilL54S5Hum5KsieDUlKs96MDDFzrX
 lz0MidQG4s70fg6JRmmbijXYki4ur2sbU6cWoiY/caNPlq9vR3hz+pb1IEjSUmDN
 m1vALhiZ5eGK8DwrRI31BDpftqGc7TXwBtnxUszIovyXx6mjItvWPHwkmJ4cP+JN
 SkCJANd3MAkdRH+t7rih3++uLFZEWPlFZl1ItIbK87H+8HlhUPkIsNLx3Beu5VYT
 FkZ0xA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n387w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:38:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91ed0e140c5so130729185a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096725; x=1783701525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1x7QSxrq42ew5YZruERIhg8L4kv2+83eMIh0NOzptfw=;
 b=QFwv3IzRRgBSFR/iPXuiOrIS5KpVUISJoEBj3Wy6GFo3MteUpA2kIy1OGIY+P4Tbk1
 5nmEXMU67kEdfdhsp5tcbWLlBYrqnpmSjde5e822cqrLoP8uw7k7wJYOTb90tY65IWTm
 NMToA1DGMpKff2cFpfSXHyAZSKYcNOEx1lzFdAX43NKzwsiRKfxwNvt+NtuJ1QXILLFy
 3W8RtzH6MXQmw3iSeSJp6IdbybJILQICMiO+TsfahJeFUhIbJlFquBvAACniEP0OzGtU
 yYpvO718bHzHsdDfRIvL0kSl8DmpCy1lS20TTEcW4wwmmfQavI17R7i6wHmRvSsUuh7F
 QIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096725; x=1783701525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1x7QSxrq42ew5YZruERIhg8L4kv2+83eMIh0NOzptfw=;
 b=WuD1ZX9v7fMIkwuVFr0htkbXAtiJaN/vYpFUDM02C0EVUak5NWWhuTG31w8NZyP7jc
 Df7A9A2hmUP17PVqCx+qX+oM4deDSM+vCFs4xIbqnhEBJK8SZVgQUJaOKhzmOWpHEFb0
 JfOtVUXLAhgr1P/HGZWARtiPFo5dsJwJYdATqpdS+5d8T13Mir8Y2F3+oZJoIFd6eE2z
 qbQVl0SrAshGEaZhkj3mBloBsHp0ibFNXMeopHcIvsnNpNs3+794t/mWF/+rR1Epxphr
 /vKwWGLf4JA0mWZwvxvmT1nK1Gg4V1UVLprCdHlUACZFGYn+dWb00bwmzY4Z2vAT+bkW
 mF1w==
X-Gm-Message-State: AOJu0YzZNoKnBJ7/DZvZx0tnaX8wOgNUmtggm3QEGMSjA01sRgoeEG7Q
 QIaIXolMsw/tDvSfSyCBqpoLUouXy0lnewM/uItc/QPM+sToj5u40xrSNY5co9khzD08ybGyOJ9
 dYFCln0kRt34rlcxUl3olZ4ejMvcR7ORYlOPLMbjnvo/+l1syjObeZ1lW5v1J44Ximw==
X-Gm-Gg: AfdE7cmNz6Nmc5S6nrMC6nyQoC5fjYADxQbqBf0pImXHhvJct2ouwxZhFB6GJWEtyJA
 81rUpPXW/q5AMgaM/UB0R4zxG7DtnTnZ3q0bZUVNF99IDQuOtzB+SLx44o9qxEu9zf9SnvoiNWw
 SrVe1G3kpw+L2XIGN8m57Xba8vrj0fzLrW5bMoB+ixbvjkgou7AjlRnm2eTf31Si2bDiS/Kcbjl
 A2Oq5mOEdNTHFY/kJSlEoYLq3JhW8qkYLrUj4yTmXiPi3T/lITeT3f6HawfMU72p2+oxo3RsTqq
 I7lqau//4kyjOhT5q3YQEKfO8UeQ3ZHvUJurpcy70UrOLnmtW5MYvMgyDdNU8s5PgZaKhWccMR+
 x6wy1WBgN8BT8spvy5rt2xW+05jIIKx7v99Cj73jR07bW3aJ9CRb0rExw2BuxOSN2GS7K
X-Received: by 2002:a05:620a:3710:b0:92e:541e:632b with SMTP id
 af79cd13be357-92e9a3621f2mr29396685a.2.1783096725068; 
 Fri, 03 Jul 2026 09:38:45 -0700 (PDT)
X-Received: by 2002:a05:620a:3710:b0:92e:541e:632b with SMTP id
 af79cd13be357-92e9a3621f2mr29390985a.2.1783096724531; 
 Fri, 03 Jul 2026 09:38:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm536590f8f.10.2026.07.03.09.38.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:38:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 06/33] gdbstub: Add trace event for STEP packet handler
Date: Fri,  3 Jul 2026 18:37:29 +0200
Message-ID: <20260703163757.55500-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX/yMgtntJC73G
 COKo/kYsQWk19vx6/PhikDUnxrP88sY19pbjcdiN48J2GMtb+tQErPRvmR3LOAm2Cg9KzlJ6yIx
 xJjm0N3WQORqf+ZKQYYolN5FSWPgkVM=
X-Proofpoint-ORIG-GUID: _dEBDxBjO8Wdg2Qx27DvEL-m9BYLNEEJ
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47e595 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=nS8E-dRYisaDM6zJQEoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _dEBDxBjO8Wdg2Qx27DvEL-m9BYLNEEJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX7hWldXtOvuxJ
 gsTmRtZOAHp+Z2hIFvA8ERMarfdr1IwGPBqNhRG8+0+d9bk2j15xUJ1Sf+5KvNhVVfzEj0rXle9
 rZizdcW2buA6gjjxsjEW8zSajTkxiK59u6HtWoB05b5TP4AbYjxP60qhcLuUHwh8pREJA612lXd
 bKLSmJuziu/N/6m5HHBAiKlXOPGo3O6dTQ9OV26hfevVxK7faoyUKfQCabTbQMsOIMFlvPmuWhK
 muL0yQLWt1TvsEj0wzkU4lh9kd5Y6OGsLAyuriTF8E5pt4SoVhFn1M4+DF8V210CCxqT+ofIXtL
 CxHnmhtJeG/Z9b3wdFV31L+IKFRdEBI0sW7oeAWGv/55/i4xKpN6FioUe1BeVW8EOpNWwMBsQtd
 BlZk9Bk0+7ndus/1lqY/t2Ub8WW8sQK2jUFt6m2HgjXaGo86LKZFRocVRSUtLFYD0vxVPo/Y4Yc
 tTQwREFkj4I+bC84YCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 26366acb674..246e7746300 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1369,6 +1369,7 @@ static void handle_step(GArray *params, void *user_ctx)
         gdb_set_cpu_pc(gdb_get_cmd_param(params, 0)->val_ull);
     }
 
+    trace_gdbstub_op_stepping(gdbserver_state.c_cpu->cpu_index);
     cpu_single_step(gdbserver_state.c_cpu, gdbserver_state.sstep_flags);
     gdb_continue();
 }
-- 
2.53.0


