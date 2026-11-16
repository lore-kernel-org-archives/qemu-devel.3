Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE23606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aWkLe1v9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OQeQNZPk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT65X-00084d-SI; Mon, 16 Nov 2026 18:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65S-00081Z-18
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:26:10 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65P-0008PW-J4
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:26:09 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGNQ6MT2523998
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ep8MVixpGJ7ArwBPYaRbKFY02m8SkUhydUHctpj49Oo=; b=aWkLe1v9AeFZ51YH
 YnA9Ye45zjyEy7xrTKY2gbw3jtE3Vi/bQtVx5iWCB4/QeA6ffFI9qj4lAMWXwIjT
 CnFFqr8BPjdlCCji6fJ6eZLV/sggZbogEO/FOfoHHevX83xokiQEyJ1fSZ68LN8a
 0ShKJlQPO/9jp/gVJZkyiOL+/SRSF4A3PbWL/+2az0iEXyl3EGehi2chtS2BNy7X
 f80Wt5fshYAWxrbJBQKDzB+DmFXvWeyIooiTLY+f0jSIx1dLjw7DxzUWqm8/GYj9
 YQnDhkhrr72Zsr96PeovSNy8y7izeuOXenQ1T5o4x93v2O7ZgZO1m7hXncq4LC0L
 bNgong==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m08d92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:26:06 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99089f9591aso622616241.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871565; x=1795476365; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ep8MVixpGJ7ArwBPYaRbKFY02m8SkUhydUHctpj49Oo=;
 b=OQeQNZPkvHhvlysOmZOW9olGI4twhDkytHFtvTxbxPw+2CR5CRRDndU7ibYyBEKBVg
 CFZRZ7BLM7+brj3fdzQrJysv/Ob8ORufQ9wIMuE7g5MYLr/mvHreF+aUA1LiPsdwndqg
 PVO8fXtCEy6B7LunjHHijXBHn3vn+n86ITk5JskieJG2ichvu1dkNXj+4KW/KF6hjLi7
 nkD+raw17Ah0C9G/P2XszvVcaJvbpoCBL6NeHsL1DqVUl5Y44SzJkXoa4FD23aOWC1Vy
 NBrUIgKFPjUFv2R0t3u3B1GiHkCZNssCEM1ev1fJ4eTi1WLFSHk/8RUMf/f4lOKI+ISY
 pqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871565; x=1795476365;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ep8MVixpGJ7ArwBPYaRbKFY02m8SkUhydUHctpj49Oo=;
 b=VFuoZhHfw1dE6NZ1zloecuPXiK/ZVC3kcDPGww8uKUF7ERW/ROE6DEBiPyJK1TR4VS
 DpBp/0PIg5gJ403jhjshkh9zJweEBiDdRvglaUDwujD+lgQqeyokq2uqyIDKfBweGg81
 60RUBpO6cTEOYruh2Nf4eGHa5yzggxW4LzFDkTN4cKtksGT1jCRXHCi/FqmBR1F/xNp1
 8RLrCDuSOSaaoCd++N0A338o1eeL0nEq2QMp6bs2/+xadWxtiOB+N5eNS75caAxN4dJ4
 XHKOEAu+g6aNAhM3zDt/ccAzv/+JVb/KbS9r1DOR5JU2+96Img9+4fn3pFEwtwPtg0sN
 0SvA==
X-Gm-Message-State: APuU4Z/cWwCaX/dPCB1wWGZaQNUIWXrsKrjbOPO2CnihbaDOGp9NNJ/8
 KgjNYi3flxdX8hlgEe/dsM90CyEpGrNWjG0mAy6yo2ECza9OY3BClfDYHMiP9WZneyyIPp/0s6Q
 Q4RyoauEwUN3CUBiQAkzKR66gG4B6N1BXm0Thw0YbRFEGVmx1iSuSg8Xi7gzk+WpG+g==
X-Gm-Gg: AYBFou2X3MCmLjzIl+eUnB3hUECHKZqHLO7mtb/945A8uIgfbIE2Cu5GodZmvfmzm+V
 I3K5ilwNfl3sVSF++FJ9+rTZcJJhA9TLoFaweUsn/QXhhQ0Bqb/1K2U4TK8sI2TxbZXBkIgj3Ff
 /FTKkBkUv8V5sXZZzVWY1pVwKN3EJ5px8xtZj20SJB0qgDeWaV9WSeE0KE9ko+I4x1R4IBP1UQY
 rFaw4AN23o2NBTPOrKByr6Vc5Ok6KpiVmZab3z1zegJJeIBFuESwbs3z0AITnk8pCmjP9BF84TE
 i0zv+KIpSSSXWp+oHyxTnRaAnx1hcV6S2kpBbxaECU0dJl5wjr03GARBZ00+mltTJB0c9dtSrww
 H6W2Iv/dkBYfwC701T+7HFmyFmcogzw/5aj0l6VSc+C8zNJ6MNXfne+XDI53IrEGbKgaK2+tQTz
 Yo6w2yngUtWBUSHQ==
X-Received: by 2002:a05:6102:4426:b0:7c1:5862:a97c with SMTP id
 ada2fe7eead31-7d64d874efbmr3192542137.37.1794871564979; 
 Mon, 16 Nov 2026 15:26:04 -0800 (PST)
X-Received: by 2002:a05:6102:4426:b0:7c1:5862:a97c with SMTP id
 ada2fe7eead31-7d64d874efbmr3192536137.37.1794871564375; 
 Mon, 16 Nov 2026 15:26:04 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb70105a98sm91363135e9.5.2026.11.16.15.26.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:26:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/22] hw/usb/dev-mtp: Stop processing SendObjectInfo after an
 error
Date: Tue, 17 Nov 2026 00:23:32 +0100
Message-ID: <20261116232335.31593-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX8DUcwwdZThrp
 xAejp1TWsqD1J+GRS2wCeu+9dPgWahJoHbfqe+rNWP6p137X7xlkLBHgGXOM2JFnV9jlfmqwUUa
 XQQxGg8JhqYe8lZ+r1/YHjzT0HEZB2I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXy8oj0h7CYNhQ
 P6xJnSyKQsTuLM6KclyyNUBKU6h3yl0X/YKUAww09vR+o3+wmVCTQalHkZI2BRZPGG1wFW06mcT
 eRFsnzyKMUFuIpWN2IlSpzDJ9jSwS1IZsCVUOkCn8Mpv0syxum/jY0ZjTsvxXZ/cl6lDuaMq1PB
 1Jmp67hpv468AXH7RTio4lwgb2JKbfrbIJ9Pdtf0mprb+Xhdfnx3G5YJtWJ1tstvVog2ocB4lgk
 cFmCX/U+REWgAuoEovQ2J+uqLpXiWKbhQ6j9NcJ/iMZP+P3Lus70uOp/ywBJpJ5fZfzyOwt6gUX
 haTPEgaMV/zMtfPr8IkUmORmk2a0Lj11+zOGCoGnnHFXcZwr+UJZeaUevS/i9k5eCtCNoWDFQC4
 CbElL4yYNNQ6hyu1AGU2D2uQD5bAHvME/UWRvtuaCF50EPzvwu15K5JvCm24+wKs/O3acl1phI/
 bRGJf8xlSgBbRrSeZZQ==
X-Proofpoint-GUID: 50C4U1853KdGgPeHZbXixsnGjiEv6474
X-Proofpoint-ORIG-GUID: 50C4U1853KdGgPeHZbXixsnGjiEv6474
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afb910e cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=jnBkMc6g5Ra7nlCbMScA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tommaso Califano <tcalifano@redhat.com>

When SendObjectInfo fails its checks, usb_mtp_command() queues an error
response and then falls through. It still allocates s->data_out. The
data phase is then dropped because a result is pending, so s->data_out
is never released.

Return right after queueing the error response.

Cc: qemu-stable@nongnu.org
Fixes: 53735bef108c ("usb-mtp: Advertise SendObjectInfo for write support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
Reviewed-by: Junjie Cao <junjie.cao@linux.dev>
Tested-by: Junjie Cao <junjie.cao@linux.dev>
Message-ID: <20261112174907.158825-10-tcalifano@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-mtp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 92dc9a9e21d6..a8b89c938b79 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1393,14 +1393,17 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         if (!FLAG_SET(s, MTP_FLAG_WRITABLE)) {
             usb_mtp_queue_result(s, RES_STORE_READ_ONLY,
                                  c->trans, 0, 0, 0, 0);
+            return;
         } else if (c->argv[0] && (c->argv[0] != QEMU_STORAGE_ID)) {
             /* First parameter points to storage id or is 0 */
             usb_mtp_queue_result(s, RES_STORE_NOT_AVAILABLE, c->trans,
                                  0, 0, 0, 0);
+            return;
         } else if (c->argv[1] && !c->argv[0]) {
             /* If second parameter is specified, first must also be specified */
             usb_mtp_queue_result(s, RES_DESTINATION_UNSUPPORTED, c->trans,
                                  0, 0, 0, 0);
+            return;
         } else {
             uint32_t handle = c->argv[1];
             if (handle == 0xFFFFFFFF || handle == 0) {
@@ -1412,9 +1415,11 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
             if (o == NULL) {
                 usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE, c->trans,
                                      0, 0, 0, 0);
+                return;
             } else if (o->format != FMT_ASSOCIATION) {
                 usb_mtp_queue_result(s, RES_INVALID_PARENT_OBJECT, c->trans,
                                      0, 0, 0, 0);
+                return;
             }
         }
         if (o) {
-- 
2.55.0


