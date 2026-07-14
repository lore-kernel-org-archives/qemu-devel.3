Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2500FC4450B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiwO-0004Ey-Lg; Tue, 14 Jul 2026 15:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiwB-0003za-HM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:37:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiw9-0005Dc-3a
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:37:03 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIwMLr1455241
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A9KUtwcX12cFPngOtQ3U/6n9iQ+WAOvVkJf1tZAGPQw=; b=lqIa+V/K0xVJE6y3
 CsryOcizChJe87oOzypzYdeeYI+cHkEyrBe0nZhDOzceMQ8Misu3eU9aai+dS30P
 daUKAbPvfF9DEG9wwpuzsBaFPSawEOb37bGEUz5hO1HXHM4CuxeqNvcw7CH8EUcQ
 008U/tfO4D5edfdeQwP5ICDHYSGYRNDTR9Y7slwCtk6pMGtmSd9hZAFsCAgmwk67
 fwW0ZAnQrHOeLq1Z49pNbv8ltCakQ602wkDTp2dDFK3bcbJZXfaX1tWpMqDixbr3
 DEL8eenDziSX0pbcvU/xs0ftDSe0icv3HUATw4UgRakymrGT0JFPXKvOfFFmdrUn
 MAcS0A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq1upd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a97644aso94520621cf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057818; x=1784662618; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A9KUtwcX12cFPngOtQ3U/6n9iQ+WAOvVkJf1tZAGPQw=;
 b=Ec6KUFTveqRoslFqC5361yYkQ/NU0Y8l/r9OSQWiNRc60uqequTta+qQ9jMyJsYFVs
 e3qLofknzBszpM/zhYL4qijtCjELoC9UpIaFCAxg1Yw+lrC5shQdsVbbr7uN4zv3l3H4
 H2vCT2MyqTNZR+vKK+8I1MC3Of49aClU7WTsXpStnElu/YWbzyesUwe9TaxGD9RZNvmV
 nzLF/Os66IgEPT3LfP/+tWnnWNvzDJhVY+bznnDYTB9fo0k0KgPqnFOejHjC6jnaVAeD
 JRSnCBmWwZHg8d1imlKYVmT9qwURVKyHgm1WlhNeWi97VQAPcFjilaIYAnAlGT7do54H
 P2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057818; x=1784662618;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A9KUtwcX12cFPngOtQ3U/6n9iQ+WAOvVkJf1tZAGPQw=;
 b=ShVGPtJGK2RqEZGCik50spuPMTCHUjIocFCoU2oC0ZqmE1IxXehfxeXum0Aty9xLW8
 Y0BUGQUrajGx2DeKeEhmlwvE6qNT2o7UWX7rPq7gdkyYdZr/T8c5SGK2RtpBX23jWsAF
 RYl9r+S8fi3Dq8d8osoxUyyul04Mh9CXxhw86bd5LCDpc8eDMxse8ujep3yffm84ny/r
 iZPKrFRN8aXutCslhwCaIMT5Ht9ji8EFUvrfz7EklFvb3tuiJDqd8qKmQUZ1VWakx1qx
 fWmSAVpn7GzTw+2v9y4voLv8uIGT+v6MWgsPrnh7X/ihn94OSnl1XL8P9G+YcTw05Vwp
 jfqw==
X-Gm-Message-State: AOJu0YxVswwuDDIaKIFNQmyk6HoOQlACOJXWEc5d8qjNMHMAVAdoAZlB
 eWUBB5N4FhyrhDrcBVF/+Cxkk/fEEfgWBBXe877HG4iKCzbCqwCCyKSH3IVABL6sZqs6GGwV52e
 GmSCduZfvPag00zZbfxGOUAdS/fcxe/waYTGTBX35KIpCIC8YHqDBrWMT1aq2WOyZfg==
X-Gm-Gg: AfdE7cnfkGZw07MYLeR47TXbwmO3E6XmbJWsem5M+xs2SLmXWssYFSvlXX2c3t4mmAX
 V8npoBdermHLCFC6Ywgx6N3iXpb1t/N2gQwlzsk+TUQXWR/I5BIk8Xh9B90cemhQyIJddh08/tD
 c899urDBAJ2b+P1+Tz/c0uj8zpJAKM9i/mXlFHyE+G9MRfipWfh7o40zuDzbu6USYfkPVdX82ub
 6Q/+6g+JV+Pkp9qPmuh//1UwMeg6ebp/kGh2nbuzrFqBpe2C111gSZwiZM8f3codhUfQoQfxO94
 xzlJH+rMz0nmT5oKhyUUiKTjPqoD74/xuW65YdYOCeXSMBUa4Bt2l0FsQ/7b5t714EZo6+M9o/D
 DZyHNZ8+/Uqm+m2k6FB/fVacVRytYxwwuCNbm5ia2xjg4WbLzNEZBPg==
X-Received: by 2002:ac8:7d52:0:b0:51c:7b11:41bc with SMTP id
 d75a77b69052e-51e4251ee9fmr35039531cf.88.1784057817595; 
 Tue, 14 Jul 2026 12:36:57 -0700 (PDT)
X-Received: by 2002:ac8:7d52:0:b0:51c:7b11:41bc with SMTP id
 d75a77b69052e-51e4251ee9fmr35039161cf.88.1784057817060; 
 Tue, 14 Jul 2026 12:36:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950871d1bdsm96204895e9.1.2026.07.14.12.36.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:36:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/13] net: only advertise passt in netdev help when
 CONFIG_PASST
Date: Tue, 14 Jul 2026 21:35:17 +0200
Message-ID: <20260714193517.60708-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a568fda cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=nDY2nR1hV-CHX_SQYdUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Xt3K4j2BtV-SoaUnsMFUo6vFZp8mpNFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfXwj9HoB42rAvv
 g+emMOPyEnxHpXqAIy5hI/JfAuchI0f4ZUMPuVPb6alNSoPmLGP9KohuOa10szQE+hB6or4caH8
 Vhm/0VPJac1SB4Xt8dncNfnPAknUZXZyv2vE8+j8wCwMvP5j8RbkZJjQAtSRRUOSOy5bWuWOtOV
 htkbIJ00tRshLzgWMnw1U0bStyR8KsegKsUECV6jf/4eWxdS/hFkl0oVk9JXx7CxE3zMhz5iY0S
 KM5jS8u+lcYyxHm8OgrjcavTn/0pZh8OKRLzqFU4yYoeRMbA7A7G8x2ADyfnK0p314nsAIMQ+h4
 DUXPVMEZWgRY4m62VaJhey7GycAXz4ksBVYj7h/PCcFz/ttK8gWhcRsKTkjUsLc5OdntLyeUJ3n
 EU2njQX6NQzBF4PJqu0PWN36ecxPF7W/FUCiPeVT8zrlhRdYRYwGS1tduy9HZNfRHEFWFiHu2Pz
 NkpGRHa0q6HM3WuDS6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX0JQGuH/nTELu
 7b982M9bCOMahcmeIYTMnruB27TQOmkFpLzpfWm+C8PcFygC/C8lqKAQq6YJplbGcXCYo3rmC6g
 XkTRoLfWVY63K2rcb2YXAsWxfH/cBxE=
X-Proofpoint-ORIG-GUID: Xt3K4j2BtV-SoaUnsMFUo6vFZp8mpNFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140202
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Rohitashv Kumar <roohiit@amazon.de>

show_netdevs() lists each conditionally-compiled netdev backend behind
its CONFIG_* guard (CONFIG_SLIRP for "user", CONFIG_L2TPV3 for
"l2tpv3", CONFIG_NET_BRIDGE for "bridge", ...). The "passt" entry was
added unconditionally, so "-netdev help" advertises passt even in
builds configured with --disable-passt. Trying to use it then fails
with "Parameter 'type' does not accept value 'passt'", since the QAPI
NetClientDriver enum member "passt" is gated by 'if': 'CONFIG_PASST'.

Guard the help entry with CONFIG_PASST so the advertised backends match
those actually compiled into the binary.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260713194511.1058450-1-rohit.kuma1313@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 net/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/net.c b/net/net.c
index 2892f1730d1..5c39f8e7b44 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1385,7 +1385,9 @@ void show_netdevs(void)
         "dgram",
         "hubport",
         "tap",
+#ifdef CONFIG_PASST
         "passt",
+#endif
 #ifdef CONFIG_SLIRP
         "user",
 #endif
-- 
2.53.0


