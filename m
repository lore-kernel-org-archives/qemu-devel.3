Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F364FCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3fu-0003ul-3I; Wed, 14 Oct 2026 14:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fq-0003u0-1N
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:25:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fo-0001yv-DZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:25:57 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEafGn500302
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n6iwn0RVSBt1UI+L9sH8dEvRd/busJPAgCkh2EUMJb0=; b=I7y6s/2zAzcM44dQ
 riJS53AaRmEfosWfF1JSJE3WGXMQUZQiHffEdyJoaxxqTmv15d6PawvEvOq9ARuo
 7EAfq7grXJi/roSlLnh2aHlstxHGxAB2cW47gFYN2Npwul3Wcz7AoYA/J/q3aZUk
 NpCxaM+5I4+aY+6IPGTN2lGa6lNQ5MoxqVWBx19jU/sTPoSrEB3Ffa4vx7P2M2Vl
 At5iZkEfzfL19LSTPK+ES4LKKe5AKj1zy6n83GoqDnBwIIxiSOv3NmCVcQfZWfNK
 f5UVvgvy8gRMmj1YjXLvzMnqL/mupmeYdkymOcgz2DY4JWKqaxecFiNTGSyzq63z
 LTP+qw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf185p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so12320126eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002354; x=1792607154; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n6iwn0RVSBt1UI+L9sH8dEvRd/busJPAgCkh2EUMJb0=;
 b=UY1kBCDt0dX4KzSYU210i20h07ELapbkBMKxA3hJe1/ABaVFeg6Rg3wjSu4dOq8WEb
 eU3+bHrq7qia3XjktRtXoOY/VsxbWHDFCDqSmT1VZpl6mhp44KVzITXbQUNn3Q7bsdIQ
 2HUmYhlhnXjby8LcJLpJqZGx/3jNLJqWdyf7snTifrvQGY+2CeO2x6Nc0FGQVT0mPclz
 v5hYYrQ2fqhb3CQEUU5aEIXE8Xu4/+XsZoYIez5UmJzWWSFH9CxpERbjkLxXjI82Fe/s
 4msBbbYXIIoWX1VYOGovV+PwC4au3iRNphedXetn4U8n38uwVR5sRDXKFQCzT+GVbiE1
 Sm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002354; x=1792607154;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n6iwn0RVSBt1UI+L9sH8dEvRd/busJPAgCkh2EUMJb0=;
 b=g/tvJpUhGB6CkJHvYHalJC59u48Rn4DqmpobJLE30vVUNcA1x2VAfLJHH5nxlbbM4x
 GVivhr1lMwK+djFdac837kAzHoH2BXn5500N9MN1P7/m0oogVadBC+W3kuMH0WvZx164
 5ZLxAdAeXuVGEsmJt/d/rRokovDEPS4U67/y243Obabe3Js1nK2Lat14YmaFiYHSComO
 6Z5gxQQfIn/adg5KcAqHUUOVN+aujLU0Y8bxofaPTBHJ1a/VOmkeOKW51DhaIfBnB+t7
 f0h+JIF0dQPOYp5YCRQFJ+Taruvg++BAjNDZpTTsJ0QcC0s0iSIpnuAdHE89jsAur+Zi
 1yDg==
X-Gm-Message-State: AFq9FYJsIl0MMSQowQ8IReNC9P86eBT6ii/Cp4iUFDgXwAI1Xnd6moSK
 z7ZZeC8fVFiwBqQRIPqSNdJVUCaxsjKXSZJyd7vFDYkTFH/PcG/wPdQKzKkvZvhSQ0WdSUt7DbV
 dnnuRF6lSBs5U9hXvYjCq/yDCNxKYG8pxFHpRCsJXM8Bjhq0trhBW8s/7UFiJmbKM9g==
X-Gm-Gg: AYBFou2t1TMlzb9yYLPWbHYRYJGj2uJ+pf23WtbMfzRvJ5CxvHoYqDF5boUzA+LVqzT
 EwS/JYGKmpKzi4MCP9KUtc9bSYc+EqXXGPUBocOrWt2dZQMHQJ+sTz/WEerg6us4BW+QYsrX/mf
 CITxyKS6QyrMAn1IblXoiNWToCifK9eaBd8iVeNruOmuETcy2p2UBq1uanExNHmT2YgUvpmOY67
 72vjn2z/YFXAFtpGUhfv1l8FXo7jYCsxTjNdqb66jjWSbvZl0yeSCBWj20ZP6MP/Y3XmeFbRICj
 Szdc7tbXxpe7XVZLpZ+LUJsoIjZvXko5A7lV2P5ViRlEVovaExzxNjFStNh18DE8+qQDzqxJ8nA
 U/5L7nFEsjSDHsCm46nTDtFrcGp04SonsicYqEGLGuaXsdAZevALLtkeMkJdc
X-Received: by 2002:a05:7022:ea8a:b0:165:1f2c:5c1b with SMTP id
 a92af1059eb24-16a57b0c43cmr23426651c88.4.1792002353974; 
 Wed, 14 Oct 2026 11:25:53 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8a:b0:165:1f2c:5c1b with SMTP id
 a92af1059eb24-16a57b0c43cmr23426611c88.4.1792002353291; 
 Wed, 14 Oct 2026 11:25:53 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:25:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 02/11] target-info: add target_hexagon
Date: Wed, 14 Oct 2026 18:25:34 +0000
Message-ID: <20261014182543.135965-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX7xHMgwmw5lns
 lqQBRCe0gDwyRmV4A1Ny64hNrhLWXdsRkZQraBdeVjoe6f+q3ZS0ANSkpxCbr/VaAQG28/VHjEk
 Dw0iFiunQ4Y+EF5aFfi7aD5acNW9fjAiSp1MI0vbxHh9l8zuCbm+3SkvSBvIwlYNKKYzGDoEZQG
 q5r8G/q7QoZivhN6Se8NTGS6xMgIsmmjtimy3hhbelP0H/aBYKh4roHrNQF61r7UJcNJgTF+MX1
 PuqYQETmdghpF3vxwNnNBt5H0y3pNr5Tcbp9Tzu8rSqfuWmTolrKOKV1A9r7o2BstNeRbeYlMwe
 Qe961ja/KvdF9oDvP+OB9mEgoHvILZu+FD58rTFZnNKHbiYiHVXqJJ8HwZUnYzdFTTtHEIeVbLf
 TEyiGwlx2HdBM8Zt2txOFQfSvTKt3Q71GF4xEBjbjLjIqPifbrxfDnG5HqZ7eLER9zu+gCWwAhe
 8q5hGi93C5rU0/Io7sQ==
X-Proofpoint-GUID: Axtlahz45NMCMhx2yovYfhHo5rt8Wx26
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX1ETsR97c/L3z
 VOiPrD1QgV7zYnn3rVXuDu3Llp5IEzdQqLPeeWGZhuk6t9tzOUNfPJadGAt4zrGt00+3fYoqaGg
 6rWmh7lenMWe+7pFdGjpeC6KY4lNyxg=
X-Proofpoint-ORIG-GUID: Axtlahz45NMCMhx2yovYfhHo5rt8Wx26
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfc933 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=oeoYDfJPrL2azRNJ8Y4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140073
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index adda363ac39..862097c6c63 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -70,6 +70,13 @@ bool target_aarch64(void);
  */
 bool target_m68k(void);
 
+/**
+ * target_hexagon:
+ *
+ * Returns whether the target architecture is Hexagon.
+ */
+bool target_hexagon(void);
+
 /**
  * target_or1k:
  *
diff --git a/target-info.c b/target-info.c
index 6b365113955..254530d8ea5 100644
--- a/target-info.c
+++ b/target-info.c
@@ -68,6 +68,11 @@ bool target_m68k(void)
     return target_arch() == SYS_EMU_TARGET_M68K;
 }
 
+bool target_hexagon(void)
+{
+    return target_arch() == SYS_EMU_TARGET_HEXAGON;
+}
+
 bool target_or1k(void)
 {
     return target_arch() == SYS_EMU_TARGET_OR1K;
-- 
2.43.0


