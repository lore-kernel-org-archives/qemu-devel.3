Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6148606D817
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NQw4s0wF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=caAEns/r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwyA-0003Gh-BE; Thu, 05 Nov 2026 07:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwxx-000306-NI
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:53:17 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwxw-0005m4-0V
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:53:17 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5B3Lt03193494
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vNx0jZscZB8Ug/Xf1qxtPaJJhN0JMyd4yC5ugrqN8LY=; b=NQw4s0wFF6jWAnRB
 2fC2dUFZ6YxQvdDJX9P1jMzLIyhFL15K1Jl2vBPe8MAKzyNAoXHaiyJEB+QWgnKm
 D1N4rLSYPwHuKIXO2B98v40xOXPkqUVJ6AqFRkK42UOqEBPhefj1QLZEG9IUEKwo
 go2YSuq1kQf63kgHqxFbOBhrNEdeWjy3XTbHlg+0i+uEdwTXTA7zd14OCJ65W5Kq
 L48wZl5KGmDqidhgaO1SWOD/PxAjzw3WZ1i+QiF3U0+wjnptTSIH6WCLXnfwVmGr
 VKhda17tsMC5onZPe179hbvV1waLhfk2DThGAOyychrRDst8hoSwYEwUx5C8jzv9
 DDN97g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkdrer7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:53:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844e383so360529385a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883193; x=1794487993; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vNx0jZscZB8Ug/Xf1qxtPaJJhN0JMyd4yC5ugrqN8LY=;
 b=caAEns/r2AkWKh8lXiZM6SztWLMdnhpIzBfQWxvEvyQY1ejusNl37ct7FPB1JDbWFs
 rHNHOj0qGb2haMSFaGANcExH4zFbX6sARA8uKWk1pXKXucyLNE5lsUBkCTnLTXlvWfRG
 GT5U9mUb8n9CKMdXPTR684NgYuD49mEhK1rZ2f6FpY4rtLP/eiVd/jXy5EaDMkLCwLei
 Dvk8n7VVyXymkE8K7IY9ZaVY79gW+vSSUeckP/Vikk3HfPAbo6BuVL1Z2xlqxw4vTvhl
 SmVT5nz3GULyRm6s9WAyRdNS43ALyRdcn1GSfEHR/XCJqnICR72kbwuQbHc2mbsZWH+j
 ITQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883193; x=1794487993;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vNx0jZscZB8Ug/Xf1qxtPaJJhN0JMyd4yC5ugrqN8LY=;
 b=CIPr0+qB/wbgtnjOgUmpOmzxQwPAe45r9Las+36RK2HUlRcydUetjxUbGV/pEq6DTl
 aTx55Jhc1bkzvUbZNE8jNcgNURSWkTid30JnjzeXX//UBQwPh7O8p2/O3sfK4KW6nksJ
 7LF+EjupuAnTdeoSezm4cNyV3QE2wNPO8SVARDM9YsYQh6uafQ87uetGWhe90gbeOQUb
 Bl1q2fI/iDPsDC8neGXOwaB+5D1mfBTDxsvLarZMX0SBGS70Onj2MXve/JRCA2FmOJ7h
 ubhjiXSgsb+5W1n2rjxGAcxpBBIo19Q+zu1VRX/B8yLXD4Qv/uc6w4PODh05iSOHLdBL
 Pjzg==
X-Gm-Message-State: APuU4Z98WrpARM4JsiFpZ5Z3cfLTWXJyr4sY5J3BdSzLf2aXtGbqspOh
 k9KfINN1CW+5xccZgaMROvqzpDde7WmPqMjm7QAQ7cTouVUryX+PTqXHKhVFeVdHAYJ17l+So5u
 55e5wzY9RUV2yROxQZUFI02zhbqLYLOhqlHYnBB7R3wWWEJL0/p6n92ofn0KNn/fG8Q==
X-Gm-Gg: AYBFou09QzIwvpCM2pEntlqEfllOCT4HM3lL1GtgiXwFuIC1VsbsGZ3IWCURAnQWaL3
 PeTprnc1M+yMDGk2TfD+j2OBDW3IaRD4hKcYk93dYyua+1dO24fDXjudwhYfi4ZrcHAZNCjraEp
 iSSy0X/PzW+InWKnlKwRMfH75fQaNRLNH56KxGoj5InA5o+/ob9hfNw1+pMj//go8DaHHoJ3e+Y
 qS93AqgwXkPF+bqnXa1/XQEnHw0DmmHdDYMYM5KjBUeDw2/MqQHJse88rxRVSv8+1hr5v6iIrx/
 HqDz51QXrsueU6dE+Iq5N30FRxkEKEZkPDU5gSO402NfJrJKoOiK/ZRYzIzdJRgPE5Vksum3QB3
 kWlEXiW+uitX56mG0rAZVOPNz8LDEB+PD7Q2m4qSzOpQD0uXd1yUPqBU/48WMGW4BGMml81kya/
 7AVhtAasNptAioweItja5kQ4eQf1iK/A==
X-Received: by 2002:a05:620a:3181:b0:944:907:8f64 with SMTP id
 af79cd13be357-9442174703bmr3151287085a.67.1793883193354; 
 Thu, 05 Nov 2026 04:53:13 -0800 (PST)
X-Received: by 2002:a05:620a:3181:b0:944:907:8f64 with SMTP id
 af79cd13be357-9442174703bmr3151284385a.67.1793883192857; 
 Thu, 05 Nov 2026 04:53:12 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e140005sm176780966b.5.2026.11.05.04.53.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:53:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 06/17] hw/usb/hcd-ohci: Replace deprecated sprintf() with
 snprintf()
Date: Thu,  5 Nov 2026 13:51:51 +0100
Message-ID: <20261105125203.40320-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aec7c3a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=gRCD0AujNZxhkLCY9qcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: OU-P2sXzqHjhmfL_iyYgS5YC1kTUEQmU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX9YZ3eY7k5YNk
 PbB7O0I9JC3+rMBjSxXQMBPChYTHOLYCRq1qjpRfuWNLGy+DkD4yIuvVyCSnnNfyelfHbIe8Xbw
 EWssxPdrK8CzAd3RaHtLxTrTyVixkIc=
X-Proofpoint-GUID: OU-P2sXzqHjhmfL_iyYgS5YC1kTUEQmU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfXyCcfJnYWf6lY
 vRGdKOjHHycJzaNBOWUvzvNkhVcV2Jmyp7dx/xRMSQApgqE/GTSy4EIZBIQ+otsK8QdtOSXcpyl
 kFFm8NxZSkRGFTsNAI8kgQUHi1gV9pnha8gWE1XoUQoOhW/sSQroq+657aPVv9BhPEoHxl2bUoj
 yOMlP6Woyieb8DMS0iY5/kzEeGicfuereDG0FGpRnOomP61nCYK7jG8chwXw2Q7UPHGTUvLhtLZ
 VTjkUBtYvas9iqqDwkC7Vkx48zRolEihYkuhf7UC/KNtAO/oDfML+XR4hI8vaF+4JTljBBkZef1
 6VS5df/g/cCpNXItnwyvnWygu6PLBgspI88V/ew5N1PLU5V1j4Pacq0SiJ0oezBUycgzhIWhvvP
 uIEgYylVr43JHKK0/ieT3Hlesgry4TD92Fl7Kqzvcw01M7EfhpqfywN6LyfpksQj7DN2wZD6FFY
 oYmB0j+C1cJZpq8GSzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to avoid when using
Apple clang 17.0.0 on macOS ARM64:

  ../hw/usb/hcd-ohci.c:875:14: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/hcd-ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 4d38150a8458..d9fcee6c0b4b 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -872,7 +872,7 @@ static void ohci_td_pkt(const char *msg, const uint8_t *buf, size_t len)
             break;
         }
 
-        p += sprintf(p, " %.2x", buf[i]);
+        p += snprintf(p, tmp + sizeof(tmp) - p, " %.2x", buf[i]);
     }
 }
 
-- 
2.55.0


