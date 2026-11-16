Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA6606A33A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pTmVru5V;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dpsbba8m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT65S-00081Y-5w; Mon, 16 Nov 2026 18:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65O-0007up-1A
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:26:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65I-0007so-Fq
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:26:05 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGNPpOO2053388
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C14WuFXat2K4Hw9sJ7qeqySbl+x2zZ7v8ykxqrOhGtA=; b=pTmVru5VTSZkhoaD
 E+qk5egVWn/I2aATfCQ0upeaCa4VuSWtiCQ4hW8gnMEQdGYc8IzcP2gBiaTeouGA
 Dfu7NYj1QvuI8UMdGOQ97DIzGeUKyKoiwkOk426lc4lTcN0GF5jpa7TgqSZkMPPq
 wt9X/+yIwG+NXcsY4NtcmNPy9z5VDiMzxpq6GFMGWUDqy4RI9mAPnwPaJ7QWRfDu
 eOe5TK4dtApx2hhe7byIHUBh2gfPTyLkNhf8FHKMvyJt+Y2ulo9NaP9164TuBP9j
 iucHnDa9fUGG3chVvgyjHANJ/1OwSxdUfvmjO3dgfylEt2PYTod7Z1umhW9xGcxY
 POzQDg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqgk08g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94961511b61so554059585a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871558; x=1795476358; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C14WuFXat2K4Hw9sJ7qeqySbl+x2zZ7v8ykxqrOhGtA=;
 b=dpsbba8mstF4ZguW9Y/ffK1PfK0202C+ChqCmDQPCBI00YUw6KhJv6yTGkTmoClcjI
 wdl+pCZzU3/YLIdbctnAhylAPB/DIJAC8w6LpgNGCqHmV8fihZQEVDK7qy7LQpKbCkrX
 rZ9dc6zx/fsAni07E1JTgr/g7J/cD+Yqfz4mkPKwhHKthVSGfr+bAvEYlMQZ9qFjARME
 nmEQG7u2xwgvV0f6ysjsu8FDyxEPk2+6VYAiM0BEuBLpWuQsSq+Ix2AsWcu2cK1utJ3G
 qVs8smA1hTe3Inow3ncTCyMI9a2kXTK/cGiAr5xhxBDhWIzq75dX4fI5ZEGaMXY5CaWC
 8KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871558; x=1795476358;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C14WuFXat2K4Hw9sJ7qeqySbl+x2zZ7v8ykxqrOhGtA=;
 b=m7Ze13SbBH+4TF6ydLhzN04Nlf94YhfyL0brI4weQl3Q3qfHTA2DfXgZezOoGiN/Kx
 ooGV1RYuOvUhfJaBfOt7QNuFJ9jTbqN44jpEsV6wcnEN3ePQK5sQL7WH9XTyJN0yQgig
 vQD7VtO/6tfa9FAs5H23LMHZgtqvvFim7KLbFERZ4aG0v5TX8+SBQeSHSXxjepYG0lPA
 w82O+aPPRLYIEdxswqoHb7SEFcZdIsRrlrDoTxXvIqHvyGU5VBrR6GcQYNCPKz5dLG16
 2J6XgVA4UkQkQwFGrIEgXByQJ7/fRLdUaMJW2EfVWtKy6K8Z4D8NsNApRc8kcAWqJpmQ
 oq8A==
X-Gm-Message-State: APuU4Z9WnGjg9MeFjF4m/IzBNL93GEsBT0dB1fUJVnjGUAI4RgedqfkF
 0eOxbHDjzU2uGuEuPff5qGUy4LqXFYnoLSl/1h+/kbQDPJqpXgE60sCuJC36QAFSJP4oa+Vt3bh
 DT8LYvtc7NepBluz9p0ywczZxlXxb2qKjMiaFUE9QHC13l7hqohpxlt39+IOrxLmApQ==
X-Gm-Gg: AYBFou0OcxmMX+E5po8fwA+wa99CDGHMbZb2J+Ai8fKw02tlf3I/URExp8XKvr3JGFu
 uFdxuUXoVe7vwH4yRoKrbY+DakWgYlHN69Hwo8AWkMFdMqb40slAFj+YNjNAI20grUF9IVG4ST1
 3Y/5GjwzbcbszupVY7xEy0EiNyIaVK1DYKchld0rmSBQapq0pbaoXL+7ksVeXrf7hXxHLk1xA4r
 OU/FGvghzhzM2Az/MgRMpHNFVEDf95QEb49hRPjIAJnrWInH5cvV1Lnp+z+tBPikPcX5a9LvsiK
 vW8mCV+CrD03i8XnEvK1EFnUQhodfLRaVPfpQMr6bOzgsGdxlRRCNyfDBwyxYnE1JCDE9gwJZ8p
 TqjKgx+ZLE416GAUkqY4m2SVU7xSgJP65ymASU7FHaxZR5y35cqWR4cCzvdPwFkNFWq9He17YST
 jBFn4YESzgIZxttw==
X-Received: by 2002:a05:620a:6cc5:b0:93f:3863:268a with SMTP id
 af79cd13be357-9494bb52405mr2061601885a.37.1794871558055; 
 Mon, 16 Nov 2026 15:25:58 -0800 (PST)
X-Received: by 2002:a05:620a:6cc5:b0:93f:3863:268a with SMTP id
 af79cd13be357-9494bb52405mr2061598685a.37.1794871557543; 
 Mon, 16 Nov 2026 15:25:57 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783965d4sm23443555e9.7.2026.11.16.15.25.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:25:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/22] hw/usb/dev-mtp: Check length of class control request
Date: Tue, 17 Nov 2026 00:23:31 +0100
Message-ID: <20261116232335.31593-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX6TG0xh1PN2CR
 q2G5eC/g9UzVzF3OeoR79hWVjHcK2Qi4tX+KFcrPzuGSHKNHKjPnNFyTQ3cdJF+7E9nRBwG38tr
 Br6qZi9MeOqqweHBwZgyyVHUq2TODlc=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afb9107 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=QhRklrCY__EjxJLf2pUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: lPFrEfHSjDtiVyFMcgDucBHURpRL6gWz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX/Y6ljAhkLQof
 W+hPbEL3Y8UACiA6Hs6vJ6CS1qxQMgqLhq3HftV8BBjnNh6CqpDnuINKiY5nxBqaO1JYAVPOlv0
 FDNWBKxMWmileAQwDduGy3Fri3Ecsj6I0RLWRh5MF9PdRZS8jzRZPFULVCknKIyWkKyXsqdN8hN
 L9Y9bC3UT3wExg+D+yQF+0dRJq8mkM9ZDC13u8+A02aiD/FajcI/fVreTlCuLtjrenS9l2ZWaj4
 H3q37OoyxOysrgXmSApALfNkIfvAK+Cq+TI8mNRpKlB74PAwzRmUPAIGmMAF08ARlaprMjiM0+v
 EOvqzNcMmF+3LapTXOsIxcxxQDVNn9qDyQp/NfgY1MxUYj+eeAB3QLQjOnTpEfps0gJn6aoAy7S
 JSxOETScu6jwlxx5pJ8y61I7FhrV7UWpukFOAI7VeW7HlSQ1wWPK1Z2+AqpubsLqU8cbQMyS2HK
 nWxk5fZGK3tZtaxSYWQ==
X-Proofpoint-GUID: lPFrEfHSjDtiVyFMcgDucBHURpRL6gWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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

usb_mtp_handle_control() reads a 16-bit event code from the request
data without checking that the host actually sent it. A request with
wLength < 2 makes the device act on stale bytes left in the control
buffer.

STALL requests that are too short to hold the event code.

Cc: qemu-stable@nongnu.org
Fixes: 47bff13cea8d ("dev-mtp: add support for canceling transaction")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261112174907.158825-4-tcalifano@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-mtp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index bc5a6f089178..92dc9a9e21d6 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1516,6 +1516,10 @@ static void usb_mtp_handle_control(USBDevice *dev, USBPacket *p,
 
     switch (request) {
     case ClassInterfaceOutRequest | 0x64:
+        if (length < sizeof(*event)) {
+            p->status = USB_RET_STALL;
+            break;
+        }
         if (*event == EVT_CANCEL_TRANSACTION) {
             g_free(s->result);
             s->result = NULL;
-- 
2.55.0


