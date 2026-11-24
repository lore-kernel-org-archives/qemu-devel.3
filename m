Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA696606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KyoKTIzB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wj2CsA6h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzeU-0000T8-Mz; Tue, 24 Nov 2026 18:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzeE-0000BW-ON
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzeA-0004vD-3P
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:00 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMax452656238
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k3xQl/8Cw0iXBQ3H1cKWfwE3GLVBLDnUXuv2rcLIG9g=; b=KyoKTIzBoyMK9DFW
 XC2JsqsZVBeXPKagYOSGs4ocn1ytjfI1WQiEcknQ8N9qLl5oDrNyJBVOOgZjOMw3
 iTikGAvbxFWpCgK7g1zuwCqFaPVqm6paDDTNtokt8CZq65Gf1RUKZhBT7oQEDU8V
 /LF8pznstjvDlXUwFzV7oxdEoo49MXmq2+IrzanSPmSdEt/EyDZ3wpfSXLyi+RX7
 BFgYN1jrp6xdG4OXeiLcKW4kqJWh+SQe3JmexVFKaevGYfwVBCNlZyvW0zxVaVNN
 i7fnbGA9ib2aDKmulBkbq7YakUFPwEfhEM1Q7dBBq2lGgJDq/qefOP6wnDz6N7Mo
 HM57pg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b802hcj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94967c6d4f4so546874385a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561796; x=1796166596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k3xQl/8Cw0iXBQ3H1cKWfwE3GLVBLDnUXuv2rcLIG9g=;
 b=Wj2CsA6hAOyIeeJ3qsY1dMKpWcd1mFHc3gIhPYveRZqNWyXJatnaqOR9WEMJFXEMrD
 1T+UnVH5pbJv3qJiDbtvGk0IVkYARhX/sgDolApg+zm7R4IRqjbBMGvl8OXUC4E5OR2q
 /Ia6x/XFFDdtem1tI/lTMn8U4rhEnx8Q2hcSTE2Q8F8ds2kOOjxts2eazlduJcsWVThl
 SVkj8GcN2da2XIgAlyCHl3GUpt+qKETjMwRcNQUqwuRwZa7XFl3tVEMBrEtk+3pxXAe4
 nR8SSjGoDoAytyzY1S6DX1lFM6UGVNLjfLMfb2sPCBJRpJl3bH1gfJLeoivbpOgj/sxO
 LtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561796; x=1796166596;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k3xQl/8Cw0iXBQ3H1cKWfwE3GLVBLDnUXuv2rcLIG9g=;
 b=gKjZZKfe8Qm053oOs5sZlZm9d0zMWNHmr5lsa9cMWTfhYcgUc63Kb7Rrb+dozq1/gY
 beu5P+16mXSC0V33wQg5AgcsBU/9mDhozT4xQLoDwTXw8QwPzf689gWvGW1F/SUC//JK
 51AWhgAFZRMsRmgL8julY5Vae6nLbJaCBTDmH8pa5Qt5TMFi3/VowsI8iGZcHscnpNnX
 1fpilzDvpjSIi/nnblmPc3IUx387xuy1qNcJXxIoL3pWJCTpVNbvtOMMoN9VK0qLttwW
 MJecfxXpkLNs5AKYckgISg8QeJyX+K+lH+NQrqYwQQ9eMyqffBuYDhiGzmTC0H0FjBrP
 Q0Ug==
X-Gm-Message-State: APuU4Z8snrRe29NuaVYgP4CfJZN9WqaEO8y8CEyTnBmarW4Ma4GRhpNt
 9amhSuMxnWjLsH+PiZzms1SZH0u7b5oHf3esLZx66vmDE0BAzyXXrHBv42GxDr4FYqjIr6I1Om9
 fOxQh+W6d2+a7pgTfGM5Q/Z6bBYCvTcOWnTlr/K1IyJIuT/2ISvXLZvD1uMevwniQtz0g
X-Gm-Gg: AZFdTZegoHAp+tu4QpwQsCLxI2SBjioa0izJMVSEr2CtRyUt5xybRIVCkvjeuB/0xl8
 VYYoRdd0cSURIL4dh72ibt+I3W8ec0Rx0oUHY0xqmY2Zxt98IOHbhpzQXAPbJpc73+YTH6b4qHn
 aAAL5QEOf1UfBi6rljz5PKv48Q0K978qLj2DBqz61+t1F3q2up8P3v8FmHAlzJuUKJhj9rpH+vn
 /GRfmOA4+eInezK2TxrnCkBqYhGc42uj4YSZjcLXRd4nyCulusudLECJLY0KzE4JWYWcMCZClMr
 Y8fiB6/n4Pw/xAZkQl4gZanGMhijvv1xzxJTaUP/+kj7s8rmp2J9Eo3ItOCkT+10fN7ZqzD5h0e
 GPncy0YYbnoSINNnC6iUPWxuN6TyMUL5FTGIBHZ6VlGMxbz4yAnsoeaW+un4BaKCqXHhuzrrd+j
 jlIXRB2P5L+QOaaw==
X-Received: by 2002:a05:620a:450e:b0:949:8901:dc67 with SMTP id
 af79cd13be357-949ba9b8cb7mr2951671485a.29.1795561795610; 
 Tue, 24 Nov 2026 15:09:55 -0800 (PST)
X-Received: by 2002:a05:620a:450e:b0:949:8901:dc67 with SMTP id
 af79cd13be357-949ba9b8cb7mr2951666585a.29.1795561795050; 
 Tue, 24 Nov 2026 15:09:55 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865b1sm467780265e9.5.2026.11.24.15.09.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:09:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/17] hw/sd/sdhci: Report Auto CMD12 response timeout in error
 status
Date: Wed, 25 Nov 2026 00:09:05 +0100
Message-ID: <20261124230917.88704-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX/cNOn/DQKbSB
 v6rTcKjwVDBZWWj3HDw1K3c5NpsVR9jjXlibm53tq0zmbmY9zXYX5tkqWrNzqCE6EOVTV+zjQfR
 Rs8fQb20/gaYhusGWgOkaRN1Yw3uz0YjlyL/gaLS1e+FkeAviIcKSBWA/cHH2RnO+uo9TvEtVhQ
 5G/nZLA+6zXFK5avxwaoevip/5EpySmyHrm4wGZ8zQiFMoEYAtlmoBLwYkfX/cnAitfOsqLb9Xa
 MCUXFqJE5nTaF7zaUTwn0VPxJh/fKMQXOVmKyOoTbCX++K5eQp/82KRRF6ixZoPUDaEdGqoo8w6
 FRo0usxttY12p7fzUP0NzqpWHZwxcQsg1H7tjRjnc4TdSyrMJz97X26ECNY4AYaVB1dNEVZvvqd
 91v2jnL84yJfjwzlJkYFjwCh/v+2bS2cj65QZoHWJhEmH/B3PaxXmblVajXsMV9T9YtIyL1ghFv
 AN3rMCRomfHuiRwMouQ==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b061944 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=E3Kq4i6MJonbbSQa9EIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YmulAptkjii46duAZrteTClXtDWxKgZh
X-Proofpoint-GUID: YmulAptkjii46duAZrteTClXtDWxKgZh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX2BjWzFMcugMQ
 NjuzUkWeMFv5ASv2qhVnwxfB38wTG8gF/L2UQcWJ075iTOB2kFibEz2ZGqs8ikP/Pza+CWpD4k9
 nZLm4aW1IemKh8jccYBPzIzIQcAVSnM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
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

Auto CMD12 copied an uninitialised stack buffer into the upper
Response register when the card did not respond.

Store the response only when one is returned. On timeout, set the
Auto CMD12 Timeout Error status and, if enabled, the Auto CMD12
Error interrupt (SD Host Controller v1.00, sections 1.11, 2.2.23).

Cc: qemu-stable@nongnu.org
Fixes: Coverity CID 1619307
Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261124073406.87537-2-philmd@oss.qualcomm.com>
---
 hw/sd/sdhci-internal.h |  1 +
 hw/sd/sdhci.c          | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 2116995dccaf..9bc6f302b62e 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -174,6 +174,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 #define SDHC_EISEN_CMDTIMEOUT          0x0001
 #define SDHC_EISEN_BLKGAP              0x0004
 #define SDHC_EISEN_CMDIDX              0x0008
+#define SDHC_EISEN_CMD12ERR            0x0100
 #define SDHC_EISEN_ADMAERR             0x0200
 
 /* R/W Normal Interrupt Signal Enable Register 0x0 */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index bd74c60f7287..1e70e1e7dd52 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -415,13 +415,24 @@ static void sdhci_end_transfer(SDHCIState *s)
     if ((s->trnmod & SDHC_TRNS_ACMD12) != 0) {
         SDRequest request;
         uint8_t response[16];
+        size_t rlen;
 
         request.cmd = 0x0C;
         request.arg = 0;
         trace_sdhci_end_transfer(request.cmd, request.arg);
-        sdbus_do_command(&s->sdbus, &request, response, sizeof(response));
-        /* Auto CMD12 response goes to the upper Response register */
-        s->rspreg[3] = ldl_be_p(response);
+        rlen = sdbus_do_command(&s->sdbus, &request, response,
+                                sizeof(response));
+        if (rlen == 4) {
+            /* Auto CMD12 response goes to the upper Response register */
+            s->rspreg[3] = ldl_be_p(response);
+        } else {
+            trace_sdhci_error("timeout waiting for Auto CMD12 response");
+            s->acmd12errsts |= R_SDHC_ACMD12ERRSTS_TIMEOUT_ERR_MASK;
+            if (s->errintstsen & SDHC_EISEN_CMD12ERR) {
+                s->errintsts |= SDHC_EIS_CMD12ERR;
+                s->norintsts |= SDHC_NIS_ERR;
+            }
+        }
     }
 
     s->prnsts &= ~(SDHC_DOING_READ | SDHC_DOING_WRITE |
-- 
2.55.0


