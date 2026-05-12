Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A8ACD484C
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdoS-0005OJ-4g; Mon, 11 May 2026 23:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoR-0005Nr-5Y
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoO-0008W7-UK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK7Lm93385911
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QqsjhQa6wXC
 EAmuLc30WAj8/J+uLGDsmHrfdtiaK2YA=; b=hO2brRGMUMcDcb92Jne7n8Xr2gy
 6JA1ZbAuouzvaaD25n/idyWcsHQ4ZBoX2R4pVus2B4E+3zdtWK4zMp+LWCfQ8sMQ
 R2hxU6PzRc6ojqy3iT+g99XaGD+qz3qG0GJmpL+axqYfoLzhhgK3sXhLTZRX/SOR
 jffWJtEmoXv7ELjt2o8RkpeKnyQQKRO+wFfIbEQEys0XpNhdzqb84GzWb13dEuV3
 NTyht0sfuBs8byZ68xOtynSKBS8bAy42tPDzxGR5ZEnOWwXikzoGhbDewGZTyFk0
 BDatEhwIABiLL85AJ/HDYdpO5id/9MvwmdjhkN21N6Ft16cdM+I2DHEWMkw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv4h8e7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so6098559eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556574; x=1779161374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqsjhQa6wXCEAmuLc30WAj8/J+uLGDsmHrfdtiaK2YA=;
 b=YRcUfcXZ93WIyaW8NEGmxZowHFXycSguZNG+G1zd9XPSLkL4u9iFu7BAZWvj2jqO3D
 Ea7rNJY4UgV/CC63el867vmcVDqdA1WDYSyYMY1N1elnShBl3lNq3Pz+5Wl3jSmboWaV
 YMM2gb/9Ev5VrIaRVaWuWwJQUqOZxDj4+PyyY6ZDW7FxC/969ZdrBksWm24psEz88AtG
 b/gx3pmcwDvDCL5dgEXMRsnAwIvBxQn/51LoPDUa4zrgFXA2XimbVZokVvzQClrqjSe/
 1tvOBDS0c25OGxxDemgKmxJ8qxN2vbgXI/qiVE+kSqUMu/Uic+VJ92mnWaTytzePhKfg
 UgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556574; x=1779161374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QqsjhQa6wXCEAmuLc30WAj8/J+uLGDsmHrfdtiaK2YA=;
 b=ZzNUd9jbPVgqLBgL+/MRkC8SVAtkiIm54JSPx8BIDngJ7hbKQyD+RAGWy7r6u5cZ86
 eNdDVC7jdlw/ZmUXuxYRXtKeV2c7QXKAJwyfZuvQHdOj1VzeTFR0ItHHUtlQO+JUc+cA
 yyyRiOHckEcxIKAguhDgzyhKtFahvCPUma9ojTWoahiGG4ASPt1qAfajPlBFLvRgWU0M
 cwRDvjcXNiJCSRX7OQuffFJMhGXHJE6dlf8LdpODIIezIUESGXjmZp5TQ7UJooJwZnHg
 696/LrXpXRcq5/5podrBgBS3zmmU1Kdi0du1fsyPONMA9I3hExnureW/2Ajiu+a0Wb/S
 BcjQ==
X-Gm-Message-State: AOJu0YyeVfFf6Jm+YFoeyGN6u3dxErll2TlWFygnpUkcarcWX/d79vDd
 yC6ZF9j1bDNz8vGP55zYtAUTTEsuF7PYbvw7Xg1S+tPgyzLiqJqh5m2nULkzCkdeWCKLC2kkcyH
 EOGYCyrd4Zba25wYSqMQE+va6XrwzrX8OqTvBwMrCv086jo0UKgh6CZXXJZFjU59soA==
X-Gm-Gg: Acq92OEx0dsi/ejxwkY1naiLmkW4HFmUIreHY2+m2FBYpXGfz3pjeuDYdrGhopG+ByL
 GmiqZwZRgdBKGs4n1mh7G9o3ztmWwaM/quN6yHn+ATQhvYeLqqE3LqatDk/asdx5gBoao1favjC
 uT5DjRTbmlve6vkP2HCLHbMn7+OAhrVkVx42rxygsGL9I0Jnu4Kb2DvKwpCh/vrvMC3nSqJ3jFf
 LTw92ugaBk0vjF7cU6XHvTYiYRCOcdUw+B+RsJPM4eUJPNYn15IU4HPpUWI5HS6jC9uAbrk7QGz
 fV3eXC24J63MWIMVdHPvF4mAcamxHKM7KFlKittfkA6rqxF3Bjuu2TPQE/oBBu3CDV7hvhje5WV
 I6n9S/O9zQieJW1v5jWFaCZYndIZNmqFuQmyL3zOA9LhaSXWTW/Mft4VxZQRP
X-Received: by 2002:a05:693c:290d:b0:2c4:4363:3742 with SMTP id
 5a478bee46e88-2ffd59bd3b3mr755690eec.9.1778556574028; 
 Mon, 11 May 2026 20:29:34 -0700 (PDT)
X-Received: by 2002:a05:693c:290d:b0:2c4:4363:3742 with SMTP id
 5a478bee46e88-2ffd59bd3b3mr755661eec.9.1778556573369; 
 Mon, 11 May 2026 20:29:33 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:32 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 01/14] target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
Date: Tue, 12 May 2026 00:29:13 -0300
Message-ID: <20260512032926.1978818-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZrTd7d7G c=1 sm=1 tr=0 ts=6a029e9f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=CgV5rzeiBz6kM6M951MA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX5s2EqqBWWQHX
 gwLtMfYGVyq1ebIvyFIGcNuD/picDxULK4hvy70+tgcM2XemcQM/4MlazmRA8V06Lfi6UaZXle/
 3OP9mY5OZ+vayos6IcVzRS7Gu44vGo9ryLyycOFBwmF7/zjum2qOOZdd7R8IrMPbBElg3qkOcuZ
 EnDKTn6PGcawApLf5bbSZSnSXdl7jICpBWw4SBkaCvquWGbrLAaR1Vur9gIVep1SbzCA1GNjti9
 tQdj+pgNr+gYCt5nlnfG3OYTL1cNoFYz7yRF7u+v+Lt6A/WgY07IdatgbKD3rFUtTOjruBbIvKs
 YYE1VGroC6AhGTCimo71Y4QIL8BkR803Depv2iNhqxUZhZNATjidVdNS4U4SCLQr7/H8mZcXXUC
 hWwNBkqgmLu3W7bxvZl/IS67FZpYxoes4qN1T1YPBC/1MIAsyjHwDH7iVOZrO/zymca2kfulhL5
 tcT2lVQ3RFjFhqtaLPg==
X-Proofpoint-ORIG-GUID: uXNfqjETxAyeDk886f53WA9GVQMQt6p2
X-Proofpoint-GUID: uXNfqjETxAyeDk886f53WA9GVQMQt6p2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The entry was missing from isa_edata_arr[].

Fixes: 32bbab666 ("target/riscv: add draft RISC-V Zbr ext as xbr0p93")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a13727c0d4..a9d9d16c1f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -255,6 +255,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xlrbr, PRIV_VERSION_1_13_0, ext_xlrbr),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
-- 
2.43.0


