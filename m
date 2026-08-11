Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933A0C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrJ0-0006x3-Mv; Tue, 11 Aug 2026 14:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrIu-0006ut-7Z
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:34:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrIs-0002O4-Ms
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:34:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGNwH41164824
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6LahR4PsoDsUon8zyy/2/dQlNlZenYbz4hKFiVvKYPs=; b=U3dy943jr3Pgm/E8
 OFEojGQ40w2tepuviwnFCOR6ZhOondu3iD8WOsY0jDAdHUiHSNzrCIFPUhURw0RB
 GH6TwooSJMwjj5h+aFRebD1pee0XAl46V8LBHVhcsBWaRhcIP4u08ISVNMJ1+GdB
 yelCy6ifuSF8SBaLdtGvwgNTURlGR1MX2g44s6QSA8W9msEN5jSHzilD4KLm7Yyc
 3kqmqJlgivlgvUicoYd8I1llYiJFSf6LVY0W0A3kPlPhcJqzYgkDynHRYU6brRSq
 zOWClrAf0O1hgIoPHbgR4bDJlwstsymxRCejnooKXhHMa+IOfmmQCGqvN9UMBp+v
 MOlCAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01q123x5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c01ff996dso3242531cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786473261; x=1787078061; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6LahR4PsoDsUon8zyy/2/dQlNlZenYbz4hKFiVvKYPs=;
 b=CaizIrdF+l9dGjGq7ErL3TGeMY7ybeLhiN8gRvGfvJ5xJxr9uy5C81GTrgf9bELPdt
 Hy0HR0iz2+MTyWH4pbtEWBZkSJEB0HoZfuiQBETElOQSE6AoCgRJEn4T8P+1ev0dWoYF
 4qnlws6DRjvqwSLAOLm8zVXU5EZWfQxpCi1LGVsD/uzQvGsg1UZvaxM6eH25EFXw51FO
 CeV/QB2GhhTrPWvA2fUy1x+T9Whju9tBoxoLI6rUJAxEJnuuPTRYyj8PuYqaXAiz9/BO
 tgiRbh0wcEMVZXErsk3/2HhhAlknu/+JGO76mbjE2YC1mGANMXNLEZRgArqcxfJ25YAv
 i5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786473261; x=1787078061;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6LahR4PsoDsUon8zyy/2/dQlNlZenYbz4hKFiVvKYPs=;
 b=PISPPkHEURLV2R5NlJMFnYF5bL2NdZWDQzDgW5sXUvAHDB9NnrO2FaL/1KfhHeXefG
 kspYUOxGMxpq13aUqpWuw7xSADOwVZrUFsE/aki76rWN2nj5zWXiskSOTHAgz+/VdPS1
 fixhcYgbmZEcdtKt7FaucSue3gUAWFbIWxeqxj0EHToiPftpL/XdzkVlfQa8vfp7YCGB
 R+djDoF7D54qF4hF55EWutUwVNhtgWdFDEMPZl1vM28GLQrenTeT8eJ3LTU7GK3cYUgV
 lEAqMRwLel4Cfz/PAUb76/OsjK6QEbCtVMVbRY6PZwGCUP46U/kgCeSNmrultMr77m06
 ydOQ==
X-Gm-Message-State: AOJu0YxT1ONT2yAyZu+a+rOPWigAGMfEoxG1FrjX0acCUwY3rwd1V3b2
 Jb7Oqlo/Z4Jr7TBrSKmz9YoY8r9NpdBXhNeNtZAIsV/L1WaRI6uZSqEalomUiX+t7x7i5LBZVwN
 bcP+WQHY8BfXZBgZXKsmT8bfPOVvOyh7azKrn/Sc/qxsKqEDtkg83v9teEUDic9fWRw==
X-Gm-Gg: AR+sD13TWr06Pdjq6wSEQUHTBkWBwIfhoKmlSWeRRB0l0XBXatxEAfrIsRNsQho3Mok
 sdnth6La6xxqGw7bJUMA/BICA3erjOddkvgerSk3lE4R892X6e6Gc69lvOwCrLqerBHIiJVySuT
 f3dh+1GgTWWNyqLY6eEuoODVXUblhyBk7423IvhlmuG+H3DpjtyuqBUHHFtI6jApfMw4DleAlSj
 tbqplI6q0Qcc7Dw/MR1WAYKI9D01uS8RmezX1upfghT9y+POp4Z6p20OO9mVBXS/g3+QvqU1EmZ
 ExQIjec6YLpacpodmuVthWhUZSYnqC+C2JG8lkA61+r+PnXsMml0bb2AxoxlgVACqZYq1yMwQ4T
 SWV73ESZtXPA0IqfRCUCks5Z3MLR4TV/4FW0KBdKvWQ==
X-Received: by 2002:a05:622a:1b02:b0:51b:fc67:c738 with SMTP id
 d75a77b69052e-52d5866ceacmr52372181cf.29.1786473261125; 
 Tue, 11 Aug 2026 11:34:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1b02:b0:51b:fc67:c738 with SMTP id
 d75a77b69052e-52d5866ceacmr52371671cf.29.1786473260652; 
 Tue, 11 Aug 2026 11:34:20 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf5c5fsm390300f8f.3.2026.08.11.11.34.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 11:34:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 1/8] hw/cpu: Correct CPU_GET_CLASS() comment
Date: Tue, 11 Aug 2026 20:34:03 +0200
Message-ID: <20260811183410.22428-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: smZpkvFyg6qeJPnAOD0iD-ALB8udzOXE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX62gHCsVxd9eE
 W6D3gB7IOigIitJlRO7B+nPMjitVxIq20pTmDBHQZMhGJ/nwoe8yVp6UKymRfJ8x8vpPKjkIVdZ
 WDacfdIQlUlk1QJQJ3/yNLWhdYn11O44CO5vd85a5J1ANYYW93nFkqzFzEth9g5yE60xPMxuEfI
 4rNbv06a1+WdMpt53dmk+Vd4E4BVJmm99vikblKbvT4yrmdiNFSYUxVA3byBBYP0/eaHGM3PCEv
 n5bkflCQ0xdmKu0mDefVkh8gDx4LGxCPk7+hBEACB7PT3jQArL5XHla833J2zD9Mw5VnIe+npNu
 UyuWSen5fcW2Q6Ok97Lj2em6FWXmSx/anqmaPKykAs9s6JK5O3nT3M0Mg+2D/cdIwUjcnL9TOTX
 puJtGGxDJhnfgE7z8chwUX0DNRDvT+XkiMNf6vcYfGnqkyP/3PNtYViToVLClDhyAjWA1Ka0tT8
 Ub7gkuzZphmNdsHUn8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX58Lln0Fo6iDJ
 l69UmlRxp6f0SsQRAdEP5T1qj/MXhSlHLked3cSrnW/2oeNFN4VqObF4c4k7+kigT2+4VMHMc1y
 nT1773KDnR3BuNs4mTLvNKJvjiBF7h0=
X-Proofpoint-ORIG-GUID: smZpkvFyg6qeJPnAOD0iD-ALB8udzOXE
X-Authority-Analysis: v=2.4 cv=brt8wkai c=1 sm=1 tr=0 ts=6a7b6b2d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=uwI2kk57myJ7FXLdqBUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

commit 0e86d7a71e8 ("cpus: Cache CPUClass early in instance_init()
handler") renamed cpu_exec_realizefn() -> cpu_common_initfn();
update the comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b54035fb13b..c5064a5449b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -60,7 +60,7 @@ typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
  * expensive given the eventual call to
  * object_class_dynamic_cast_assert(). Because of this the CPUState
  * has a cached value for the class in cs->cc which is set up in
- * cpu_exec_realizefn() for use in hot code paths.
+ * cpu_common_initfn() for use in hot code paths.
  */
 typedef struct CPUClass CPUClass;
 DECLARE_CLASS_CHECKERS(CPUClass, CPU,
-- 
2.53.0


