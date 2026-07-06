Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139D4C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs1k-0005lO-Ii; Mon, 06 Jul 2026 18:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1i-0005iS-VX
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1h-0000Gd-Hg
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEFDn1639585
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fEIoV428bXj
 QR5YcfFnn6kPq7FdptVDuampU1oIdfZs=; b=cmc5gV366a2M+V0WG74UrrUHJ03
 bVT7GBru/SlZXWUOUsOHy0OzOqhtJfR8IVcyBrD1YKaU9FAy6IlNtK8avV674Q6D
 V68FvVzADi8wcHkVxXjm5RBqrvgsIRfqEazrDbeX1K3z16E/ePHpikugkyWxFCZw
 sfduXxte7/lpyNguBvRHR6glyywuDr6VmgkYSv5MQJ6HtamsEkdCQkPo9cjbsUIy
 PQhewIwBiFtv2nXyvMxYCjZuYaiGMqyiMqmvdbu1H17FRQ45bQa7Up6X/DGnv88d
 pHeelEFR4GHHcF5g8SOpGsabCw9WsJpaT52R2lEe//O9ArrW8WwM+0/pNmg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r35r0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:42:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso2462157a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377776; x=1783982576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fEIoV428bXjQR5YcfFnn6kPq7FdptVDuampU1oIdfZs=;
 b=D1fhVUBwxWsG44ooZZoeBuChRJeTBhenGXQHqhyz9dUbgZOZDVI0gCNeBEmZ4AjVsv
 m7eq6RoT/tXiPqswAH5bpEe1wjGlB8D7v4ieKiFH9o4ZAZ3Msdgn4YPHp5DHCVniF77B
 3tjxwbSIseA6IZ+R/zTDAkW+fKnXeLOkKOFkeowkHrbkVZ40N9e+wmwUFeQ8UOJJt7sH
 YTZPBnXcuhBqhIrA0ZF78gwGme6s7XOxteIZl3ymHArcVg6PwK8z0HiAvVmjP+K/PtXt
 935UXBx9IkjBOI8MBPYRub95AVkOCSY99Iwg2WWylUuVbLLQfghxrOqe62VIJBWKpnVX
 5tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377776; x=1783982576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fEIoV428bXjQR5YcfFnn6kPq7FdptVDuampU1oIdfZs=;
 b=PwE+d5cKtTMGeBTmdWhfJsRKDhaDNgj0ndT6CFWCVbFMpk9kCUrlsgDC5/66WUIBfd
 3vzMxevXEg3TfA4uNprkNbIm/cZUwkiYWFiqo5E055s+qTB+1UMcOmz3nPmqVv4KP6/n
 fzzy2PKnjruy6K3WuZo2xXDC0Qnl/Bc6DYEDnQY5TisOUVcGYRbkuDi75G6ev9wmfNJa
 U3vIKk/VTDZrX2R9yXZv9rK/R5f2CbRNu6xJMj0DcxdMmRvVGfwGDoG9dbuMlg9ZoMYe
 LVtv6FC69v05q8iKnLL2Ov+B++0CchgviS6jZUQwctK39oTl5bV221Wq78msrhIlGRGF
 VFoA==
X-Gm-Message-State: AOJu0YztYMuTm/E5jOeoaHT5mIk/+TcKZxuNvF14N0clMU080pSIEnDE
 JJletNw24G1lAlptxnyyWCFvz+HNaOjoTrUIHPQwMSPEFXDuwU4rBlYNqskakZokB9L1MK/zg6P
 s63qX43w6e+2KzqfPhc36EnOUdbQnPbi4gI8kKOV8YrPH9fWpoY7oBl6Tfo9ZsZGVWQ==
X-Gm-Gg: AfdE7cme+d6IdF/eMfx6sGEr53Zt0TcKvdo6OQ1PIerTBI6gt4CrdVBPgT3MN/RGWGV
 i4YI9ycsT3FEmFltWItrf7yskkX+bad7nlfDTghO3Ukvdczcdkk5fD56TbokEUWBrIaFvf/3r2U
 WEGp9VN/i0Op43NkTUQvh40vrZkHFvTiSez7OL++5m65D2Q+G8RzD4l4ka6PjJ1tz077jp3E3AU
 AUf4Fx921NXi3tyZZKFZ/vL67pQnJw9/K23Gx9lTFZPFj52d9JxusLVsLUswFDMSt0SGzyupvdv
 2vWAlfe1b7A0lVrpd3xobrgMO4ZlywlWgkVlhLLLfzQwY6PF/SC4720wLphG+Kslt3UYNV9aosW
 gPZ/hI7oKFSF2cvB7jVafYuOet0HVmfF1bRTT/muHX8EpAIK/cXvLdk+IfCL6xRhFCOe/r9XKMt
 mBnjEpkQ==
X-Received: by 2002:a05:6a21:648a:b0:3bf:aa1a:d303 with SMTP id
 adf61e73a8af0-3c08ef19819mr2989685637.49.1783377775657; 
 Mon, 06 Jul 2026 15:42:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:648a:b0:3bf:aa1a:d303 with SMTP id
 adf61e73a8af0-3c08ef19819mr2989659637.49.1783377775251; 
 Mon, 06 Jul 2026 15:42:55 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1439200c88.14.2026.07.06.15.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:42:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 87/91] tests/tcg/xtensa/crt.S: align .text section
Date: Mon,  6 Jul 2026 15:33:39 -0700
Message-ID: <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX6Hh0ELAy0T6l
 BV4/n7zzSp1gtBt4YVDSBCSNjYWpse0ZMv44Siv3buHZ01DqahEMMzITpnkvuuO2sxT9Aq6O1oI
 Rg10UcNyOmHrRCYoz7htWdRZWv69SrXFRdynLq36KtknSYpLlO6kHzQljOSbK8y2t1q6H0S7hSR
 ypNo34bfS6LDXIUJfgyDewClAYH6F4zAz+U4P36TVuUc9PAHfdJem0GjUNjIuKJATh/UyjBt/aW
 yBK1zewcEWW/aQcoYN32ta4c/Ef40utsWIdPtFEPEN6fmp8AUsAyjSgk+OO5Cglq1wi9ZUHogSR
 f8gCFey9y76CfEgjlAqRkmndef+6ZVaiSXHA4r4XvHNjNwrPNFDj9/pJCRAjzX3KevT5g7RnDNm
 SIwR2k6zGhGDEy1qX9wFVTI4pZ1Y/0Gvny79YW/ILiqXnkBCf/65YYLvYqB4drcAzVh7lwXb4Is
 Jv6pltYrXXRGb+c/n0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXyolGLUXi8rlX
 pTv4MX6dicinI2Ws3cHnpVRY419h2sJdUc2K0z/IVUkwp4m+zvqyiG72xQc21b6iy+JO/Se5ou4
 ydZczRsZwtRRFK6iscQGMUb3dkVwCz4=
X-Proofpoint-GUID: wdN06bIvx7js_X5Zx7mZ74WnZg6ueheh
X-Proofpoint-ORIG-GUID: wdN06bIvx7js_X5Zx7mZ74WnZg6ueheh
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2f70 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=MR-zhS5NvvYuJcPsf7sA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

Needed, else we get this error:
dangerous relocation: l32r: misaligned literal target: .text

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/xtensa/crt.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
index 909872cd385..de8fd8c1cd7 100644
--- a/tests/tcg/xtensa/crt.S
+++ b/tests/tcg/xtensa/crt.S
@@ -6,6 +6,7 @@
     jx      a2
 
 .text
+.align 4
 .global _start
 _start:
 #if XCHAL_HAVE_WINDOWED
-- 
2.47.3


