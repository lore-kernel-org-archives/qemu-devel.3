Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B0DC61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YM-0000lz-DY; Fri, 28 Aug 2026 19:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y6-0000We-EH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y4-0005my-Vy
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTPJL4105021
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uD4827XBIuo
 0NSW6+3ybXY33hV4V4jIzz3ceu3CiJm8=; b=E7+pV5+AlQN2lGwmPa6k3jds+ul
 hwTA6iu3GePnBWVazEstHMRh50WkJX5FP1Of/K1AEHTA1E6uD3LZgrQa+Jtb6xt7
 fsCAKNqf6J31Pt2zweFYhMjB+YeEcvzqd3ER/4BB8c2ImFWTYsyh+PKiE76FnG4a
 wshUWsthv9dJxcywUjRz4cW/VaYd72rOvqqY4GUtrXSKUnL/Lnw4SFAWRblH5Wzu
 9aSwHwLIPS9UV9vTt23Zfx79GVAMU6L3XqWAoOVCBH0O+K2aS7IixhIQS02uub5I
 jiX6y95Y/IoNSB9fKfD2cleqd3/gs5x8ac3dZcOotr6BeMq8kqWKnorMsfA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3hs3xce-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d54187d8b0so39096245ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957987; x=1788562787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uD4827XBIuo0NSW6+3ybXY33hV4V4jIzz3ceu3CiJm8=;
 b=Rt5UX8hMPGXEI8hJrcbT9onYB87lxBY0OTQm4f7LwqlyEJ6JNOp3M5CES3JrQQ6loH
 F6qS7pRnhFNpnLNuC7flHh8rfOmY89ZQFqFtj2Crw2PH3Q+txVY03y/uZgf09TlcrB57
 eObLO7sd1TFDRGdjPCANAqGm+8By7WeiTHablKXwQcxi0H2rU/sS5YmcEP7k0BeY0369
 rNrScGiBjjJP5VNjnkL5U1t0zRAJ1Wd5OJ6dK/VbtA6LvdnkExJ6JjndYdUJ5zhQFVRT
 rcDlffqP4b0oUfNoaaRGqn7C7iMVTYV+EAo190QN5ff7HVo/vAkov2K4xAecqpXYgEm1
 V2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957987; x=1788562787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uD4827XBIuo0NSW6+3ybXY33hV4V4jIzz3ceu3CiJm8=;
 b=VIvJI6L/bZgZhW7kI5XQh8yUrlwvRNEWOWnL0WrBgdIcrl0Z43DiqtoTc/UXoXNyZu
 Dyh+tqMy+xC5xHiuPK5T3TndKxAPoFaU0D4wXinDPAo3V82LDpzt1kKLees6s3Mj9Jik
 MhPjq8bixBxYl0yDGpQklaqUf4j3TarUjtriV0k7iqTuNC59Gq+oKxtMiwqmCcuQGOxg
 wYvi4uhjmDc5ioWIGNmAdnzhQipM9IBqQbSIrRyxSnzlqxC1EPx3/sbHDt/ee4GWmyMv
 mma1QT0LU8gLG7r/Erux3nHFuF36/Dr+wAGWl/lNsVeSNRetcJ12x0QYF9+4KHVuVtnq
 6NOA==
X-Gm-Message-State: AFuF++lyURYbQvysdmYiEMSw7wEPX4hhs6zZfKtFZw8+KhOkU3+gHRCe
 jbs/KrWfODp8IzED5WKC+f/HBHf30tr3UvKqx0Vx2WKZJq/+UjQASoAQYXhJ67u5nt++CF+QOj8
 Je3PicjHMJb8ol8hyxiswB+2Xzh7COoEDP8IaAvdVQsG8YdCHszG8hDaALxKnvLBoyg==
X-Gm-Gg: AR+sD11YvDltuzBXGOXeFKxobSlAYZ3jV0LmP1uLBJgvmv4/Uux02pkBIgFmfMNw0gC
 KyjKyotDCCIz4LZC/nDby7wndIeQLvPm36rY7J1O1Pg6PwznyvjGsJ5GlOtKqqsnFBfHkutBOro
 xlYJC2bpYoM5Gh7EXVwaYcYaEzP4Fvh/YnSowsQlXJKEcF/B3vlv9w9sFsOjbZdB68lsIeXb+n0
 keQV+9ROl5vLbzEOVsAyFA+uUkpFOuCvFe8ReFVk7ZLcCBaQ11w3npHY4TKVfDQ/HyjWZJ95ETv
 8YSzHHc0ZXSVXomvpi9+9cq8qtjVNNe/qUxJs6oJHaXrY7TuO9sPOW376ESb3SYmQAQjfCEcg/+
 gVfDaxhumT+O36TLnXlycKBrA0Y4hQmkhOnI2c3HWGM5zm4XowVA4y10FB2Y=
X-Received: by 2002:a05:6a21:3482:b0:3c3:bbe6:95c7 with SMTP id
 adf61e73a8af0-3d267f817cfmr22408133637.17.1787957987187; 
 Fri, 28 Aug 2026 15:59:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:3482:b0:3c3:bbe6:95c7 with SMTP id
 adf61e73a8af0-3d267f817cfmr22408088637.17.1787957986802; 
 Fri, 28 Aug 2026 15:59:46 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 31/47] hw/remote/proxy: filter from CONFIG_MULTIPROCESS
Date: Fri, 28 Aug 2026 22:58:45 +0000
Message-ID: <20260828225901.367438-32-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XKYAjwhE c=1 sm=1 tr=0 ts=6a9212e4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=97lXeUCQXBHHhISn8AQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX5xEUv05Ihd3p
 pUpu196QASHh9COSdPHZcYq/+XnBDRYagYs93kud5Nb0v6IIE14sQjxdvlg40on6mpYrFEJvjxg
 jlaFWMdDV8Ikg9fMqmU+tIetLgY1Py2w84sylzD62b4SFBZEIVVZ1JxXRfyJqaicDxUgyU4vIiT
 pukOVl3R9CEjhErTRwufq9oDTg72l6TXjxD0yZ+6UwogJ1Jb29ooNLjTdW0ichTNWSHdzYlwZIR
 9waauwIMqSC71rrEgO2RY9Pq+i/cDLlXRUBBzqd9FDB+Dr+CwaSeNhRZ2NPJAKg+r7Nr6VCKyBl
 LZula6hZu/78O1e+b02WaNXl4NedmZs7KBIkZJyRN9bZRCl+VViSknM5stUNTIJ5V8LFmLcnHSE
 ZVNb+9OWSkhEdM+E3GiohjzYPcveynIDVvDBGzbYUzUsJuu3Tonice8ESKM3irBr4Sa98HVyerG
 KaYXrhFyNpEReHpt9ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX/LjWOByve9aT
 HPN17Nc3hiQgtpXnBgBpxZ+u6M8wA1L43jfhhykDEiCYIRIWdz0KdZ2rU4eMpMXeAiziOxw57Uo
 dZn9NmBXgLgz0E1zU8xhECrts3hUKwI=
X-Proofpoint-GUID: 93yxNqRJwXFSf9L3O_mlQQgnKm_4_UAv
X-Proofpoint-ORIG-GUID: 93yxNqRJwXFSf9L3O_mlQQgnKm_4_UAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

We now have filtered all devices between arm and aarch64 targets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/remote/proxy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index e91566509f3..68df12cd8f5 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -230,6 +230,7 @@ static const TypeInfo pci_proxy_dev_type_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIProxyDev),
     .class_init    = pci_proxy_dev_class_init,
+    .is_available  = target_config_multiprocess,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
-- 
2.43.0


