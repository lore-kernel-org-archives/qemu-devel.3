Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9643CCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wST8i-0002ZU-VS; Thu, 28 May 2026 01:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7m-0001tj-CR
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7h-0003pE-MH
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKmh931638354
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bNWTYNGwliX
 gR5yN7yApPakICBNiwgMn1PqqkUBtSeI=; b=LqLg8HFNOg35FeH+aPJ4h0bcxBb
 5S9iMEu45JVSMz/BjJlCL1WJ+d7AmJWasdK85oFqbwoflN2QbFFAJ204+NJOu0Gz
 D8Sm0sjTWJFxcYnMbEMa+K9AHBi+leaeIJNBXjkNAVHiTmyPYPxZ4kLnNPu4jacR
 FluuVRlLjkEnQiCfKJXMdDB7e96flnL2KJ6ukr/HU/V6bLpSibzZs6P8fySiYTDZ
 fOLmt/rpHdkUhopO4gGsPG93UekvBeWPyv7g5U5NUGuAAd1FEtEdkPcl2CGcoVwa
 PJAyImQ5/DDKgbf4CeTuV0u4/BDS5vgV72HfL8WPWkMwwoLZ7QW8k+YmCwA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynhd58-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:26 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1365060ac82so4742089c88.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779945446; x=1780550246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNWTYNGwliXgR5yN7yApPakICBNiwgMn1PqqkUBtSeI=;
 b=BeMtXigAP+6XfAklesQViEfywuJc6Qe4iaOQkhJAUKWefUZFyXw9rB2LXDHFkJYX+/
 KypypORWfhes+S5aN1MNSqwcgpCq4T/FK+3xne/E3HDrssQ708YfijsY3ydKX901J1KC
 9wUt5NP1mXXh9L532uGauOsSO+F1eWCrbij2JL4t/FMXj0gU2/u7WUltNRV//zMV0FPH
 CuOssjcugZXrvq6fytyMEfOrqybaozlfC/LsecligQ4Eo9KWAFC9VQ/Qce9YPN0mYUkk
 Zhr8kC2LnxkYN8Ya8tEfUAN6alFw1cIj4P+Cj+gb0pet9G6Hww1bh1N0DjwtvzF2ehP3
 mzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945446; x=1780550246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bNWTYNGwliXgR5yN7yApPakICBNiwgMn1PqqkUBtSeI=;
 b=kCNVUi/ASL5gChd81MXY4T5g7Feag5c5CX+ojTTb6UJLIxmVbzsI7DQriRvUyDCarU
 6QQ/8jVs1GyjEgcLfXDhBrPxyNGVEPD12HA6Oj8Nnp9sYOwDdmuGFeiFMktAbnDMx8F2
 YtPUa8YgDqdrc4881N5DYvn81m1m79u8QjF1U2cf04JbYbKLlqH9E4I5S3ra+APzidXj
 W30SAB5eLCtWrPFosjoLn+gq7zN7BQe7rUAJS8bXFRtTou+aQT+vRett4Ue7dyrs+uzs
 Yb3Pq9RGFiBZbvvHorW9qdEckbqvHFpFV4DRntUebPiImvsfWKgKDvV5hnFe/kU1IV/R
 sTLw==
X-Gm-Message-State: AOJu0YzvjB9IV049uWgA+nr+VDMRJ4GizhmB6mntMpdfjH0uuZK5pf+a
 qcffYrS/umbILP/57YpgQcu4wPy0ceGv63tv1tIFR5eZJU15ffGFc0/74pQp588sr8jZpd5JtoA
 ZivKN4R1rnY1XQhy2kNIeVNL7X7rnN/APZ9JPM3A0mroS+XDl2jss+C6dzsPTSvgT+IWI
X-Gm-Gg: Acq92OFODZ28zdDhHk1y+rBkK2Pl+APOIsX7fYkTbbapSijiOJ7tY4vFJcRWYXubJDw
 R5ZlssV084vpb5gMZupEup2QDxjcwgfBmO9qKbbHU56Bod5GZ5W8Uz9EqL/AuGV0qBR4TfrJSok
 V/Kw7GfGktSoYNwHsElXoK/HWHobfHOOBul2FwlOdqegOSkYcfnn14j9ONl33fHT032LsFZQHH2
 rn7i9DAJS/L2ES/ttzxvfPzN5Z3VoliFdUCEW0gi1FPjKh1Lbei6zrB1/L7UegPCGRaifpNW2bk
 jSPRKND4lURtVhC/URBhNMHc/9bSR2wLECT9NFTKMMa1zwp98B4eLY1vz3i5J/TxbARbBSPPbbO
 e6lNPRsjEjuuvBWM1PfXzj0dfp/HvOOFBdQYBlImsr5g3qbs45pxGR9ObSoS+F0NaMcGx/j3qC6
 m81PbQTglxbbCsqR2z
X-Received: by 2002:a05:7022:458a:b0:135:1ae8:39a1 with SMTP id
 a92af1059eb24-1378ecd0cf4mr40726c88.17.1779945445641; 
 Wed, 27 May 2026 22:17:25 -0700 (PDT)
X-Received: by 2002:a05:7022:458a:b0:135:1ae8:39a1 with SMTP id
 a92af1059eb24-1378ecd0cf4mr40693c88.17.1779945445123; 
 Wed, 27 May 2026 22:17:25 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304b984d9b5sm4094607eec.7.2026.05.27.22.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:17:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 10/10] hw/vfio: use stub_ss for iommufd-stubs.c
Date: Thu, 28 May 2026 05:16:42 +0000
Message-ID: <20260528051642.115721-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0OSBTYWx0ZWRfX2VtsHHFm4wHb
 bslmENl0Xb2OKU/ITFeQI+vrj3dNrhIroX+34+iMrvP8DJyzvWa9jl0VflXMZoisAIRBSUemNXc
 +vWrwlXBUdnEVXtMN/Q31lSDhmA0drNgFmSieFiNS7nb+nD6Rzx3a3HFIioi1etP3X5N2nulfGV
 6X1owhsNuIHps9u6hfMrMJfUd/BuThyZqB5oBJe+6/rDuo0OvxhpBWMWdjAfwr9kJdjT3PUs2P4
 JWA2a2+GCFawbY2iqvGRitnEcdP4uBHmNJE0e7L1xIqI0zdNJT/LpiOnvBKexiES5OpvtA154al
 lfYJtKwDnw0dsrVjD7GrlV/UAiYR0/XTG0ITA87jiqf7c5U+1g3mH/lt7tOCK/ofzwf53UyRaBl
 RfxEtM5vNb1Scuraw1dZHuI3JEKcRehAeK/0rKwfWvAKbdFwe0a/9QUgGD6ZEtR0ND7K4Mo62T6
 WFmyy4zlBzQd5TaAAyg==
X-Proofpoint-ORIG-GUID: Lt5wma3Lps-gKw3Lnt7v3G9KHnj0iRs_
X-Proofpoint-GUID: Lt5wma3Lps-gKw3Lnt7v3G9KHnj0iRs_
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a17cfe6 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Q9VBMtJfUB6wdbeww00A:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280049
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

Solves conflict for vmstate_cpr_vfio_devices.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/vfio/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index fa0ea6ecf0e..c7c31b78f68 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -34,7 +34,7 @@ system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
   'cpr-iommufd.c',
 ))
-system_ss.add(when: 'CONFIG_IOMMUFD', if_false: files('iommufd-stubs.c'))
+stub_ss.add(files('iommufd-stubs.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
 ))
-- 
2.47.3


