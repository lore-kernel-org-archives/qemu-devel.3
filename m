Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD08C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjfj-0008Ut-3A; Mon, 06 Jul 2026 09:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjfe-00086h-CP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjfc-0006eo-Mq
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxE2j395314
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NdBTd+WvzQi4nySk/yevAlv5usvJ/B8ISNHXKWOfYPM=; b=P/gScUS+knzi/J9H
 7ZNI93INetx6ruJhBo7xRYhWAayd/0UedqmUr9ILH60m5GZevKkDJfFW7qsklG2X
 ab/+7Tqv5tk+pW+DxIfRgym7SopGZwFXX+mrp6OyM6nvHOvlYz1lOLVWmi8LE83w
 ZK/RkUeCQWgfKUVZqarv5bkFOYhlMz0itvOlwWrJGEfWVermYAFd8SWlMSRCL1Iz
 pCK+CCdksiBW6gSc1Lxf5Avj8Y4vZncvQOxoLtqDbip6yO8Yk3GTXoGlNngI4+4j
 teYf8g2pIKGeAQezhEYApzsiCXl/XAOUnWJbbqNDYpWrCJv7n3a3jVJ/kiDx0Tfi
 dR5/FA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qph0e6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:47:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso4608706d6.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345655; x=1783950455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NdBTd+WvzQi4nySk/yevAlv5usvJ/B8ISNHXKWOfYPM=;
 b=InM+da75WTQSx62EYVQmUoSVdVllp1luF/21h92hGMt8aG6P+DuwwDpVp/oREbDjUZ
 g7ut56IUMhQqjZYx+K4H7CTzFXuVIq9tmp6Oryimbhn4tzctAmNtwJvaVA++ESWRDgob
 cDDxCeY7ht5Srde+PtFFcAPSwmb6aaUBFfg60zsQne43wEDvDRsa+D3M6IiNreF3Ip3e
 xEfPfTV0klKgX+PMcWF96LNRSOjrWXlkOg+FnjKw4kDxEYy9fM6GKG/sVn3GyM9ADuBH
 2qZHdlUBN1U0c8CwArMYnwmfHbR2qLTGVegkYnBwx7HN0alNJV5Jzav035dUVaT5QHeG
 JxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345655; x=1783950455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NdBTd+WvzQi4nySk/yevAlv5usvJ/B8ISNHXKWOfYPM=;
 b=T0nYF6SP+a+rqyNiXYWF7aBo+9hNkessqalwPJWE56NG3RcXQagEqF93aUBzEwdCLz
 0x1GwmeRoL/q/g+UMyo7aaTxLcgkuZg2BqvefQG2yGFjpXJoBDY3fzKZnby7NODZdZkH
 U+PwpIVjt05egE8F3mg/Lfvsym2x+vTxuVOqwvOoYpj1VBOYerBxrQMtiYDCyypSjaf6
 gBedm+1cGQ663cw74ICrAmiAf6zxCoeAzALDNK7iP4BTQK6rfbZYGflxeze9nRsWZMZW
 6j+Ay2idNzTLbinQ/d0JJKYJQzuOamzzFL0a0SQ3xriRZZJWzjFkpuxzyx531yOjqMvF
 ui/g==
X-Gm-Message-State: AOJu0YxYzvE0C7Abd4EkB3jWK6tvVcI3wPXUOhsbI3UE5vm/vgmZ8wuc
 g83kMRATY0IPCeyRzLDbtmAX1M9SeWmTXy2SFYZ6Lh6NADl2g5RHYIIcvUf7e3OWSn+lhIJbWjU
 qcZWaP8Dtw6uDpQrxIuTcolP4BDyo0Etqp23nOcl+G/tf0jcFO74e/wfasxc32byvag==
X-Gm-Gg: AfdE7cmhQz0prdyA534wf77otlBIaJONk9wSkBu31ME7jOIpMiT9CXSw9bQIovo1eKS
 m6YFVt5foGrQ70cgj7DrWRJ5SBzYPwMMFjOt91zTLvIPJtEfnkYKd1ksNGAeMwQ9rumV7XBbch3
 id/RFRtp5i5n7jlrVYHFGv+lA2IPDmKF26uc7IbRixYOeYmuFPTNG9gkpKOiv20cyN0QCL724nP
 L7iMYD+CZFQManCE/dft5U4cQAN1PBf2tl1gufIniBa+X0QXMY9m3y1+EBM0g3plM9bRRiKSw/m
 TJciy9hdv1D5vXBL6g6iJWNYC0EZVBTdFUy1HxErDQhwJ74LdjElsHPXSzPwxPkT8hLu/osEx+v
 RzZw8/4R1Cl87h4D+xKsQncoHFXXoipg2RLEYBFCBleeKT2ZzVLBBEOrWeg==
X-Received: by 2002:a05:620a:28cf:b0:92e:5d76:743b with SMTP id
 af79cd13be357-92ebb600d64mr78100485a.56.1783345653867; 
 Mon, 06 Jul 2026 06:47:33 -0700 (PDT)
X-Received: by 2002:a05:620a:28cf:b0:92e:5d76:743b with SMTP id
 af79cd13be357-92ebb600d64mr78090385a.56.1783345652673; 
 Mon, 06 Jul 2026 06:47:32 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6381e4fsm429530315e9.8.2026.07.06.06.47.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:47:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/32] gdbstub: Reduce gdb_supports_guest_debug() scope
Date: Mon,  6 Jul 2026 15:45:08 +0200
Message-ID: <20260706134527.84808-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4bb1f7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EGoLRYcDdwmvoyRlCl8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QoBGI0VmVBzkr_lumUFHsBUHClr-dg2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX1KusOvbhbMhf
 MPiuqbah0xBNfZcTppKVID+alMBO3a+3EgSqzj0RzPJD3v0so/dJEx34yn6JNOAoQjn7xULOIzW
 CbL35qomSSmIE9/DBugbX8E5+PKEGwMd+aYZX0lneSjrpv95OYa3vSNoKXCjJwVnz6jinugeTAF
 C3ovFhI+P4BqS9Ug/VrcQ87lJYe7Nl4VOV1oibI96lxmOYGb7OPNJMMm84++JkcctUXUoZOLIOZ
 FBpNYzIBuPmGe1MerDdLi8llHsbdqlw4LqQI8pVojmVju9FAVdrB2y07Iv/mrEAp7ijgtatlEP4
 Hx3Dsdx38GWsSASmL5/qxVbsWXYbV5ecyyCmtS6w6DjWL3frXxla3yQ+gKtO4r6papXO2cn4XPN
 ibVCyMRfieGeMFpz17MIgfyKsAu8WggQkUc/kDCsM9jWGkpfok1FWDuHlWvGWtqENcd4UMP+XnF
 lv+1LvXNBtPqwpWUxow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX7sYACjfn14Uy
 muUum4U5Ev+hsVrIlX6YYJIy3B/mQ0bu+QAxY7YpDIalsbEqkQOyx1eAkgBMfmZmFU++p4Z4YDe
 dRM4tqG1EmApOKoxH1MHpw6ZgWKhX5w=
X-Proofpoint-GUID: QoBGI0VmVBzkr_lumUFHsBUHClr-dg2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060140
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

gdb_supports_guest_debug() is only required for system emulation,
reduce its scope by making it private; remove the user emulation
variant.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260705215729.62196-13-philmd@oss.qualcomm.com>
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


