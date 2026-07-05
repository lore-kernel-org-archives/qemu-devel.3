Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3A8C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUrm-0007DR-6n; Sun, 05 Jul 2026 17:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrk-0007Bw-RL
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUri-0000Dy-DE
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665Hhe272342195
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7po3aHpbm6lp9kLWdYsA4Vft5rv/zKl30ZI6OZDSLmk=; b=gW6DNfywMno9gUwh
 UT8gPkggwBz6QnihPkLTH4NoxV1tW/JlYEltyqEN8OChrqK3rQFSBmaUbrI43s8K
 MYrnim17Mk1idilV3oRKDxMsu2wH/hwHFcprNw3iInE+P868zLCUHFWOZn9kRj3t
 69IU8uwYjf0sYRsTjei2bqUYMRVC8SjpWOaVuSGkkNTtpvQDxTR3MSjpNNO+iiUt
 TqQNT20MkpC1zUHZr4830UOiA4GNp9X3/ktxSGO8wiYXNYOhu/0i0EHQw198Na/Y
 cg0epYJasYggD5XJ/YYcqAq9zBfy5feRjoo0MzkOo4Qg17vYrKUfmB8VphG7R2t4
 8Nrp3A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3bgkp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:59:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e538afe65so228419285a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288744; x=1783893544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7po3aHpbm6lp9kLWdYsA4Vft5rv/zKl30ZI6OZDSLmk=;
 b=E60mWKfWKEMMrayy0Fut6Ui5CjQUPE4k/6t4F+0l6dzv+UFgWfzJv0cB6PZ+kbBIeK
 u+3MmMmWs368vO5LozO1drNxAS8reOeMcwJVuF4yCmP4rDY0FGKzaqrdHG587mua2vdS
 TUBaJAU+hTYCi0npfiv4sq7ayJFWPrUdTUTA2HZQ6QjMYB05a1WmnUQArt4Om4KwcXmF
 7KnkSXDadoVq7Oq6t3NxrWIm0lj0NkPWruDy1AbXKz6OfVz4ikGMW7CU8WNrMzfWkXWz
 xB9I+AW4untNIxe5fzkdkenv+1sRM9Zk2bB4kW77hQm3PHOR5FauxXETfKamQc52LxUV
 X/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288744; x=1783893544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7po3aHpbm6lp9kLWdYsA4Vft5rv/zKl30ZI6OZDSLmk=;
 b=mFsmHfqH7p8j9mwLhmzotJeU/nMzSubh+sdxbe4C1qVdLwxJc7upMLgSWhfzD910ZT
 rqVo6P/4CdoK4QLpyCidmN8E1APhS1JOndhCoZJz5V0pssM6QKYXFieiSt2gQ98czGTq
 htmZqd7AZSB/uiMnpxKpjLX8NluJ+g0+BMB0b8uCBTs3Q4x7HqyNkZqS+CO3KPJRdBvR
 VEhO/gNFkbAIHfoCWPgj/1HlixuXlWK651rYiBc+Didf/+eTfk38klTlKrDSp1qFUfYi
 eYnVTgGGHOm02mAFupPCz2APcoEQzK6/uwMZHBx9qjoY31u7qvBOoqhV5iLYBO8cPyvo
 sH6Q==
X-Gm-Message-State: AOJu0YydTiJNK2tZ+PQw4vMSagEkKYfgNsmoStGJYT8dPhZl3qeMv25i
 HqfN8BNBo5WsBauQH65yQdH3lnEF5VPtVVW9wTqwqOElViMgIBuOH1siHcOw/3ZU6WsaOr1BDbN
 qUZ1+Dm5tPfQI9IAu2DNuyATyZTzLJOmwesAV0+N2PRmS5dFPlQqxv+HVy8YSMmGw8Q==
X-Gm-Gg: AfdE7clVhYB/hqq8xJQcivHUbqoyQy7qqkWtmHraYxG8OXBU7Dc08qH/j7t35j8v/pr
 5S2JbyygWMzHjrmcIniJltKzTfAIYOMlOIqtxrYbqy+E3JtCb0kkGgbD80qliArbaP7e8j2E+HE
 5/g8Kb7qxfUd9+iLYjc/UpbPocPyusn2Rl3g0wRJSpJf6qpNyNwmwycRBwgnnt5MC9IWqJqIMKC
 IZnQBjYxVUFFLiyhG9L5cpA7e3+TtsTBDz0EhW3RBoNWCMSA/1oAiY61B7u+ceD9YWTh6HLbjIZ
 JCtwl8iIAegaojm7Z2HCYEv8QwVvBfYMYFneVL/OvSCxdSpUQKjblTJtHRtFEi93wjQaMMW74/1
 5e6wXjK8O1cIuGakXmx4S4j9sQBCWhbj98tPcGiUMrhOr71tcmFM355GJXNtVXgThc2dq
X-Received: by 2002:a05:620a:1a27:b0:92e:73fc:154c with SMTP id
 af79cd13be357-92e9a3446e4mr1258430385a.7.1783288743728; 
 Sun, 05 Jul 2026 14:59:03 -0700 (PDT)
X-Received: by 2002:a05:620a:1a27:b0:92e:73fc:154c with SMTP id
 af79cd13be357-92e9a3446e4mr1258428285a.7.1783288743305; 
 Sun, 05 Jul 2026 14:59:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a558easm19130659f8f.27.2026.07.05.14.59.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:59:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 12/32] gdbstub: Reduce gdb_supports_guest_debug() scope
Date: Sun,  5 Jul 2026 23:57:08 +0200
Message-ID: <20260705215729.62196-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX9mGtTEbLC1cw
 e3y19Ma/W2GJBp9cxhcCGSzPiP9k4E7CB8kG8Ny8ctKow1jTmzSLHMgrC+Ar1aP4lJ9aiiA9ftP
 PkLdWuO3VhihseE1WoYYTUQQvDwPTrw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX7aLY12FzyKXV
 V0BHbEv2iqc8MxhKrQINOWFWpQflDdtWE2KIEW2jjbh1+BrGBFSnNU5RCVY38Yq87MUNGd5g3vT
 vOE8gl3FzeBK6VuUVw3B+hBWyU4qhFOYdLGOYXzBgqiMxx2ca5SSzmckP5VhAjoswfXFZorn6LH
 CKmjlrAoDpOX2rRx0zq5dNBnig8iuJnNfxhxGGa/PnIh+GcL0uuJ4+0eZQrNa4Z7F0sSekpKbmV
 DcHvbDKVmMP+LwKu61v678OKuPSae3yH98qChlxZCDb+9SMEQ9YYl0ZI3+ZuwzIOx7SRROQijEk
 JgNiEkPf8Z8nFqE+DcbNmwZiCM1FCj0z/lrhjmhOt7k7nTF/KMXyGhTB9MTtPqTRK1T+pEDwv4O
 K1/rvGSGFxySl3ME1r+7ofeQGaT42EfGCGSHD6FU4Fy/Lg8jwUiub6TDRaYYBL1T5pGCY70gY/L
 /vfUNBto/C0sUEUbzWw==
X-Proofpoint-GUID: 3nWJI4Vf-h37MTFPUFfdytLEbhXKl9Ge
X-Proofpoint-ORIG-GUID: 3nWJI4Vf-h37MTFPUFfdytLEbhXKl9Ge
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4ad3a8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EGoLRYcDdwmvoyRlCl8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

gdb_supports_guest_debug() is only required for system emulation,
reduce its scope by making it private; remove the user emulation
variant.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/internals.h | 1 -
 gdbstub/system.c    | 4 +++-
 gdbstub/user.c      | 6 ------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 9b25bf58b8e..60ddc146661 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -217,7 +217,6 @@ void gdb_syscall_handling(const char *syscall_packet);
  * Break/Watch point support - there is an implementation for system
  * and user mode.
  */
-bool gdb_supports_guest_debug(void);
 int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len);
 int gdb_breakpoint_remove(CPUState *cs, int type, vaddr addr, vaddr len);
 void gdb_breakpoint_remove_all(CPUState *cs);
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 2063b63b2f8..1179c82cb86 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -331,6 +331,8 @@ static void create_processes(GDBState *s)
     gdb_create_default_process(s);
 }
 
+static bool gdb_supports_guest_debug(void);
+
 bool gdbserver_start(const char *device, Error **errp)
 {
     Chardev *chr = NULL;
@@ -627,7 +629,7 @@ int gdb_signal_to_target(int sig)
  * Break/Watch point helpers
  */
 
-bool gdb_supports_guest_debug(void)
+static bool gdb_supports_guest_debug(void)
 {
     const AccelOpsClass *ops = cpus_get_accel();
     if (ops->supports_guest_debug) {
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 97eb13e796a..f7bc4e63dfd 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -796,12 +796,6 @@ bool gdb_can_reverse(void)
  * Break/Watch point helpers
  */
 
-bool gdb_supports_guest_debug(void)
-{
-    /* user-mode == TCG == supported */
-    return true;
-}
-
 int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
 {
     CPUState *cpu;
-- 
2.53.0


