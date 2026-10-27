Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B2606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZopkEM75;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BUZGEmwg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmql-0003Wc-DP; Tue, 27 Oct 2026 15:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqJ-00033Q-Vi
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqI-0002ND-DX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:19 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIvrFS1545961
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o24jYxqx1KYFpEMPeG18alFtELNq+iu5O4qnwULGYAk=; b=ZopkEM75r6BbnTDZ
 FEYnu+GcTQ/OdwHKnBUlRiwmYniFj2o7n5upK7Kdvu2+jnSKSMZsXqyHXB6ltFBJ
 PhGOfIzASaJyk8wXbUWuZZds8rvFEe4OQpiKFyJSAuhxvWwfUpdPM4P3aXYD+pa9
 Y0nzTGhaClOPUc7VzICyhVG37BKSjbxxyIjzJ5Q/1a7PnZnQUFkcIOxAX42cgtKY
 BDEln5NhQOrMR7yIEwHa1xUPIbqaEzUeiFTO+Ohub483c3ZLUIC8J5azYKhTcZSO
 hCkAtXZDQYwPWNBMx79gY3yaqiMl5jOmg5hfIaBGLpmq7mXHkq25/egzG6gK54+3
 WYiuvA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy710vgf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f37c94ceeso268996585a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129296; x=1793734096; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o24jYxqx1KYFpEMPeG18alFtELNq+iu5O4qnwULGYAk=;
 b=BUZGEmwgCHZsyt3l53yngOJcqANZF7QlqMFQppOmRcsNROSr5qN08DFqyVQBdMtt7Y
 CkO2GTBXkDYle3hpFAk/58e/sAYqYK1GSSF7VBT7HOpCm3X3ReP2hzDoZsO9ww7MeK4O
 Mg+IFtba48yWXrt5Ew3ksLD/Ld6zENhOrZc9/Pv7YS5mV1mXOBYEhsPiYKaqxUJW6J8+
 soMdZs8aOkl+t9VVbDOqPPypq36exPY8OW4z3fafimfrRjtxaVIFLd8YqZWZ7kPJvXX5
 seVlsI43of3RHb8v98yGBapFheuVmJOecY7j6tcuN70RqdfZ579j3qfnd8Rd4mVneq/a
 KvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129296; x=1793734096;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o24jYxqx1KYFpEMPeG18alFtELNq+iu5O4qnwULGYAk=;
 b=sQRk1E3couRlHbjPn/PNrKhxCbieCIkoStFLWrjWynHpZmRulHhO2l6uDg+Tqw8YDV
 Ix0IWpSb0dxBLDw0IHzx+blqY6gms0RA+19zFLptiE9yUykQisS5/yl+tMC3zdP9s00z
 ENoWkfJ2NUsJbk5gyq2nNisexuymcj18JleYUtTiyoG2SQPj5AKpLYRX2UJ1qus0YZIN
 IbOkC4JSvOY3RXCYW7LHe5Hm6vDD7PGfbZ8pM9di6MbHA3m2OoQtoQ3F4kfZjVxpd/el
 F98uphdVewyrHWJB+5N6bTwohtOzcgqmqvaS/l6KzySAi3/SaGU/kywUd8dO+HEMN+8Y
 VVxQ==
X-Gm-Message-State: AFq9FYKWsc11eiSI8QbGLa3MVJYqnR5t3DLfRp2kXFU/JFdSY9s2ZY6N
 JL6FSRcY9o40X707hxZ0t25GRFu3SyzR1XdtNrRhTL4iv53QCjK6A7iFfTqHzw3O3ZCNfqnuM6p
 RkH6jd3cSSye3z0tR7ehYbhIZE5q82XXW4HiFZoGBLbsccUd0oEugs5v/qN0mUP/9Yw==
X-Gm-Gg: AYBFou2UeddffcFvGSs5LZaV4ouoSn3BUPdpZW/bOpYk9xZ1Ntjw/2pGUIsIxVhLmU5
 oHvywYUQhY5lulpAya13pYBH2h6qrj8SFHPK0jHTiYE3vyWK6b7o39CwqszzuTaZNI9lZ55O/uu
 /yS6W5S9mdUh5GDW7+HjWr8PEOymeBv9bJipoyo4imSB3Xcief8Cy0Tnq4Onv12e8ftITsOPlpz
 NqUEVFY96NVc0NbzcbAsHzE70wsE1+aZHzMZKyMy9PqVrSFxcI1Wh4V236aYxeDY6KZ1nC7otws
 Aw0qRKDMiHinsRaXGnjsZnHOpi3yoNxkKOny0sRus1nFwLn6xyt6UwnELuCxgfDWkVpaQb7AliE
 AMRhPCQD43ekxSrXX8V3W2RYSugg0kaBKVbTiWgOEqOOC1vlWlT0l4tG7
X-Received: by 2002:a05:620a:1710:b0:93e:c12d:4ecc with SMTP id
 af79cd13be357-943f4c2b6d8mr641212185a.44.1793129295790; 
 Tue, 27 Oct 2026 12:28:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1710:b0:93e:c12d:4ecc with SMTP id
 af79cd13be357-943f4c2b6d8mr641207185a.44.1793129295157; 
 Tue, 27 Oct 2026 12:28:15 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f25fsm23732926f8f.2.2026.10.27.12.28.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:28:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/59] hw/intc/imx_avic: Avoid casting from void *
Date: Tue, 27 Oct 2026 20:23:21 +0100
Message-ID: <20261027192341.9197-41-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXxkTvFxc9fLHH
 s+PT71zEBMTDBaovrBBJnpS6w45500tpxMx1thqPRrdIzclFkF67vdkyf0KULl+YQiVmFQoiWe0
 4JSDtoQfZm/SK5LyXPZ+yZ1Hwdj2egdZTHF5fIaDMM0BdK/LVhVv3Ii/WX4YQeHrhBHeiMWlwS+
 P24Zfr8mhmig4tLxachKYfpu98mNSnJJUaSoxF0yv3dRU4Rdv6vliVkhDagjL6Lh5rMvq8moPHn
 OdHApk/qB7YHVFjd75ngiCIfza3Al3EYFXRGa3lxJ1pjK/nvRRCvN3UABk5M8GQzYqjsYbEIfC5
 8fuH0ANatk+3vIdweX9OfFBmcH5hBeeEdjFNqL9bFejL/NIf+aaTJDRaLt0sFOqJlM27rcw0DVf
 HzemmNt+TxZa2lJJITBlfU0GBaIjrZqNZfRN6b1NbDyuUSU8dDjFK/XzhbnAlCKxuHSiwSw9SpL
 b1La3tsfcApZCLurX9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX5zRna4Hw0nFH
 QBR1udlyW9NVsy0qvP0pm4MNkE9MNwe6xvQlAbQJOyMu/0DC+JaU4d3gyv0OBPdccu42cSMEJVW
 0MUjHNevgyUdXjSTKs7fi/00O8doedk=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae0fb50 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=02MBybJkZlpQRTkSaFYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: FoVMWgyMEHRYXfa3Ebd0936z_KvD-2_G
X-Proofpoint-ORIG-GUID: FoVMWgyMEHRYXfa3Ebd0936z_KvD-2_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-38-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/intc/imx_avic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index a3d71aba8ef6..d05c71fb3941 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -89,7 +89,7 @@ static void imx_avic_update(IMXAVICState *s)
 
 static void imx_avic_set_irq(void *opaque, int irq, int level)
 {
-    IMXAVICState *s = (IMXAVICState *)opaque;
+    IMXAVICState *s = opaque;
 
     if (level) {
         DPRINTF("Raising IRQ %d, prio %d\n",
@@ -108,7 +108,7 @@ static void imx_avic_set_irq(void *opaque, int irq, int level)
 static uint64_t imx_avic_read(void *opaque,
                              hwaddr offset, unsigned size)
 {
-    IMXAVICState *s = (IMXAVICState *)opaque;
+    IMXAVICState *s = opaque;
 
     DPRINTF("read(offset = 0x%" HWADDR_PRIx ")\n", offset);
 
@@ -217,7 +217,7 @@ static uint64_t imx_avic_read(void *opaque,
 static void imx_avic_write(void *opaque, hwaddr offset,
                           uint64_t val, unsigned size)
 {
-    IMXAVICState *s = (IMXAVICState *)opaque;
+    IMXAVICState *s = opaque;
 
     /* Vector Registers not yet supported */
     if (offset >= 0x100 && offset <= 0x2fc) {
-- 
2.55.0


