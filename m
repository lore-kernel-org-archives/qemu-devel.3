Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B40606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xs/DaH38;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dfRb42UE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzLj-0006w3-Eb; Fri, 27 Nov 2026 12:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzJM-0006DT-6L
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:00:44 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzJF-000271-35
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:00:34 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFpR8g2925361
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 isCJpVpC6PS1ros04QDhT9pArciZy8W9VX+gz8LH/Uk=; b=Xs/DaH38IqjVoE3y
 pAm/ZWodExvcG0HaCIz+1O8b7XfTBNcSFaMAjUPS9XL10WKcXtyIClLL/aR+m4+b
 6iw7dxkARMhodtU6L5ax9+tzg/kLtWELE8JfKcLp270WUqxwzfZcZuDngZ5KfDoI
 0G8eMDXnT+bLX9aL+/ht/LnIfNB1HDyO35qgwiAINVtHMjiSM7bwAZzvsWJqVCyz
 FAN7rp34y1p+EAZTdrX+MBHytqTSbv9dI4VMES/2p9ySBXWnK5ST1RxR068ro2CR
 NCRjQgphbBl3yCYzgNepYfZfTld2dyFYioCbDsRIq78+JTj/Z8KqdUx2LBXuLmTD
 hEKUzQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhjj7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:00:21 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8b69d1f2a18so5653608b3a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795798821; x=1796403621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=isCJpVpC6PS1ros04QDhT9pArciZy8W9VX+gz8LH/Uk=;
 b=dfRb42UEgwp3qHb9tyTa6IT4gxLM3zlkW0HaB9FV21CIsqCCuUclXcsY/xnQ2E9aLH
 2kFCal4x11YqzgEl+4ghJq01SN7tE//AahS35BLkvUvk9GjLhwZniLLmFoKq8pUagRGS
 tOwMa0s9yM5D2T3b0XeQg1dx9KadQHfU1Y9A16DWr2Rsz68I0E48KQAGI/vX8crkMMZY
 bQOBe/Ox5vpANiWA3EDRPDekXZA0quev27C9JQOLGMDKnicn5ivsCudaA/rfXwsLgXBD
 hZSv9eAKEURNShvYa4Cw2MkkEFvKICcmhJV9OeSasMZ9l6PsW2NF9yzzxGlXxwbaG/or
 HWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798821; x=1796403621;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=isCJpVpC6PS1ros04QDhT9pArciZy8W9VX+gz8LH/Uk=;
 b=ooAFA96PShj+Zm8V9yZq0DTCWORtY5gyEhZyIgNuUhHZBziLhv0hH1MApYo/QMI6Yb
 vz0aM7GQqjbHGhb31g+RU6h8H5Klw1N4JnwfrUlVr57hxjx9Opw4XC0+iyoNVZpFURBH
 RAi/RZOuMt2CWiIMjomy+Cak4WA7n7prnzRVkYO8DfR5zKRKndynfdlU0leAYd86XT/f
 JaVrOjPfBHA/Kch032Qj8bqDREIRkFGmMGGAW3BbUEbhP74WNCxmq0ceRoUuZ4G9Hz8B
 HQMO0rnP2sweMXWAzgux1kJLWUiEL3bhrc9qoK2dW/ggQw4ZfxkjWbxDPywWWtDn+gij
 RJ9A==
X-Gm-Message-State: APuU4Z/uxRah+zl5zS9aU++/c1bvjaEcfzSB71Mo2PUESo3WplXDhTYu
 lLmXJ3Z0vAn3Fn1zhZh/R6B3bnfOG5vc6phh4LwR35oK4gG5S6xF5zPFEQR7XgZShkqYGT4q5fh
 juY7R6eDnnoU8P1RCefJNBkW9or58wvYDkMFQxkK5wW99oCK2SBKLBl3Ct/titBFDyg==
X-Gm-Gg: AZFdTZdHY9R0+reclWoFGryelStoeRlaYuO3YR4NHtyxGg1qL9qH27k2R6VlCC4sfgQ
 utFEIJltBRyxeukJqDzRd6d4O6vOf1OedAlFCbhLgKsXs3LQ/iq0CXxFkLxMmOQEoVvFYuSneDu
 oBgnDhqfjI4Nwf896c3Z6GBh6JJIBCocW4bz/YcCkRp3Avg0zck6r+7Ibj+Ss4Wn6Uo6LFOLWNY
 a+AA9B7DgUDpFhZgGw/Ew48mU/UhSFxCV7PKh4DAVJzk+2WJlLrFLs/0bXs3+SBfm5oUkfTG1/8
 L6iZ0hcpulht37nF6s5tJV5ZIWfKQF65H23RLJ0ASKyA8K5EL/i92dS2yAMzd9Pxfl0doVHBFWv
 gaaV2w+J44+L4zU5aHbKYyiLOjJ9K83f1pl3MmFn4h/VCVUNH+8m+1NNcZYu1ij98+TV0oRnYw/
 ZpBpDdVGlveQ9Xw/abGGfF4qPBQOyW8/GZsLXz
X-Received: by 2002:aa7:858b:0:b0:8b9:66d7:1016 with SMTP id
 d2e1a72fcca58-8c831e18d81mr14008041b3a.8.1795798820900; 
 Fri, 27 Nov 2026 09:00:20 -0800 (PST)
X-Received: by 2002:aa7:858b:0:b0:8b9:66d7:1016 with SMTP id
 d2e1a72fcca58-8c831e18d81mr14007972b3a.8.1795798819794; 
 Fri, 27 Nov 2026 09:00:19 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077a058sm13014650b3a.8.2026.11.27.09.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 09:00:19 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/3] gdbstub: reset supported features on Supported request
Date: Fri, 27 Nov 2026 16:59:53 +0000
Message-ID: <20261127165953.51257-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127165953.51257-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261127165953.51257-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX0nflmSbZQCVQ
 dknrh/+JIiYhDhjFgd6tXICzckILnPXpDc567abvv/Sgj7BwjL7Dy88M4OCaQYUea8SFh7jttnI
 uTHQ3K3jJ0zq0Y2qpNVbU9/zfXMDeC0=
X-Proofpoint-ORIG-GUID: 5AzLYlXEytJTHgTDcm6OzfgldVBVDmx0
X-Proofpoint-GUID: 5AzLYlXEytJTHgTDcm6OzfgldVBVDmx0
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b09b725 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=CCpqsmhAAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AqOQjYCRd4s2zt9NDMsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX8fclKrkVXntX
 gkmNgIQeL5iFtQiCzVKt/yIgZdhBnt5jPKOLLJyZD2dAdNGo25daJ+Ktku+CBx5H53k136t43Az
 2mxl1BeBbNbIP9ecHajinvMbYT34iFEhl2NkuUvpuwSez88zUqt2QVebFeFF4iCHp/G2kT26jFF
 cArIBlR6tRUv36pVlb6byLujEBRgVpReiPION2heZEtiRCyuupofjGJIz2/jUnoQBDKdpgWgJYF
 YOaXE1esdrtrLw611bpoWRDlyjOTxrLkSNyxjHxCpJLWU/Hot3iKDND3DkmAN0fcuOk6SyMjJdi
 77uSC7XwJzuz0i23iqPHtPKGJDdP5mpaFCjowO+L42bKUJI8emDrpdxt9xIuGmFyL2eTdW4haMy
 dYtVqt9vfZXOONE3zF9S6lOMzfv358muYjZPs7k94gYmtnCYSa55NXTgDXFoCSJPYITvolJYOn9
 3EOUIh13AbdRbk55+2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270067
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Justin Sapp <jsapp@qti.qualcomm.com>

https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qSupported
```
Whenever the stub receives a ‘qSupported’ request, the supplied set
of GDB features should override any previous request. This allows GDB to
put the stub in a known state, even if the stub had previously been
communicating with a different version of GDB.
```

We exposed this by connecting to gdbstub using a gdb client first, and
then WinDbg (EXDI) for windows kernel debugging. Since they both
differ in their multiprocess support, this was confusing EXDI.

While we are here, fix the same for fork_events in user mode.
Simplify control flow to always call gdb_handle_query_supported_user.

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 gdbstub/gdbstub.c | 15 +++++++--------
 gdbstub/user.c    |  4 +---
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 0a328b0dd48..38fe56a5d36 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1679,6 +1679,11 @@ void gdb_extend_qsupported_features(char *qflags)
 
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
+    const char *gdb_supported = "";
+    if (params->len) {
+        gdb_supported = gdb_get_cmd_param(params, 0)->data;
+    }
+
     g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
     if (gdb_get_core_xml_file(first_cpu)) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
@@ -1701,16 +1706,10 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
 
-    if (params->len) {
-        const char *gdb_supported = gdb_get_cmd_param(params, 0)->data;
-
-        if (strstr(gdb_supported, "multiprocess+")) {
-            gdbserver_state.multiprocess = true;
-        }
+    gdbserver_state.multiprocess = strstr(gdb_supported, "multiprocess+");
 #if defined(CONFIG_USER_ONLY)
-        gdb_handle_query_supported_user(gdb_supported);
+    gdb_handle_query_supported_user(gdb_supported);
 #endif
-    }
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index d810f0f38c3..6526200a360 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -701,9 +701,7 @@ fail:
 
 void gdb_handle_query_supported_user(const char *gdb_supported)
 {
-    if (strstr(gdb_supported, "fork-events+")) {
-        gdbserver_user_state.fork_events = true;
-    }
+    gdbserver_user_state.fork_events = strstr(gdb_supported, "fork-events+");
     g_string_append(gdbserver_state.str_buf, ";fork-events+");
 }
 
-- 
2.43.0


