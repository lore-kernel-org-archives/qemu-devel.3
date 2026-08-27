Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF0FC61DD4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRj-00040r-C5; Thu, 27 Aug 2026 18:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRg-0003fM-KC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRe-0007EM-K8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:40 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLxnf1358884
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M73bynyQNUHw9mOJCKTaWimWobRclxFO1rbi5NLu9GE=; b=eXye0BXNIIACiHcn
 xPHj7QcEde90PEVokvKOaeD6464YAu6I5Kxmzxkjvx4rT6YpggLGv5yxmfT/sZ2L
 /qH7qtq715GB6WhQSznM4eLmlrblOK3LiTrerrdjcrSKpcDJ6s1DIDn2gT5cNRN6
 8fkgRoL3/3p0i37bU9SFwmRjotChNryOonADxdLgaRTYdT5Yp+qqCI3TynfXzWZE
 7m/+UFuUdOl8ygY+M3VAtsxU2k9qcHlllIVUptMJ3kTDCBL4HOl8crYF4Xhf3fSj
 Nd4d49bGE1ph+YB4RFZ5bfu4tra6U9RfRt/QALhddxKDbPs5S4wl72Sh81y6DmTZ
 p/n21w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgvaa7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-396b9ef3070so858307a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869176; x=1788473976; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M73bynyQNUHw9mOJCKTaWimWobRclxFO1rbi5NLu9GE=;
 b=bxTjrwHCoEqOs4oimqADIvt2kyUPYXcvzxNC1KG/sKd38EbI/pheZV1uyM0dppQaVF
 Ml+7tnK/aOaTy9dYJyQX4ZbuRmQOI+Wk8/D6OEc4F0T/Xh+758v/HMjPy9UJGhtYmm4Z
 9+aWufTD4eejpQAuuZNLrUyFXbku+EuWw4Dkmhe+C+HhUdxo9M2+77eKzJ6bgeRvD4ga
 udC4V9wiXc36csjhnLw2/uZjn7IZOAp1rmDguMP7WWNMd9ypiTfKgSRd15m0SchnIbYh
 QRorhjcadycrn2LEzYkDfG8TlSpnCI/UPsYeYOJ8zNRa7xGdDR2LK98l8R3vxwbV1w31
 oEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869176; x=1788473976;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M73bynyQNUHw9mOJCKTaWimWobRclxFO1rbi5NLu9GE=;
 b=Sc6O8qZcuKPmWTnMRZUfnRGnPKYE64TYyNdjqWmeUOZ5fkqXbujR4H+hPx6mUCAVKR
 pLvP6a4JLhxOZoONzN8kuylzTzrUsqSlineQpjEA9XpBxg2g4EahpAkx0XWLbEry8RQK
 B8H74mhLBXbN6sPCr+s65Bvxiu4ITqMxHOUoDO0fY4cJPEEY06QVm1LGx5gaQ9eo2+52
 iSKoKgt0I6/fIwqQ1eHeonDwbVW6xM9qFNHS9BMzQH1r9vWf7eNQedrMfS/zNtkay1+I
 ++WhHWQGjdpwxvYz2JjArkF0lLOI7gI5ga1eK2n4GTXhXWn+6uG7JMcGpFLpHecfcTYl
 +QUw==
X-Gm-Message-State: AFuF++ljUIMs7vjlyvihnKSvGu1sXQ7lJ9oXAgyglba5Ve4TMZgx6Dxy
 chq+IT7JWB5woRm9zGKeWAHy9VChDHsXJyEgyazVHfrc5s+5E5DTPj+vdL4fxrD1j93c9JRKX4I
 i9qIFmaWPikG/Ia6R9x7khvBbWdcwgbfZuXfRXnBZe5m3lTp5BpRd684v4lKmrpdM9A==
X-Gm-Gg: AR+sD13CrLCFzZNdf/QzRyX1TfCAxvaK9V5q685PaFGW2QjKfaiIU+r3co8PuUG6zV1
 5mZkUu2q/yiy3fO9dTmjGusPC9OuiNxEBnrhTqHEGjJ8F7lHelU+85aS3URFOnNWPhZ7EhAnD1m
 JFut7voyUIcYG3LyU41SKVmCEUSXmv7UinGsvcxBgHwcdUJMifpt2/7DDdbeVFVv7dGBCZ498Lt
 VcwCQA9H/uqqcVWuNlcOPHjlbGQGawwsiV3t8fLMqCY0NZGP863eXfD1JMusBuvxt9DlzzUl76D
 rvZszc0hRWdexITOMMzHGViYo1uNLodROev13bVo4bMpm9YNJa41mTZdv3VXJwjK+nVxkjn/npW
 YuopAueLCPZLthYaOkqcnHA2ulkW+LClTTpFEUeAdPtNsWHQ0ShbVpOnAxsY=
X-Received: by 2002:a17:90a:dfc6:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-396d0ef6470mr4849929a91.13.1787869176351; 
 Thu, 27 Aug 2026 15:19:36 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc6:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-396d0ef6470mr4849869a91.13.1787869175991; 
 Thu, 27 Aug 2026 15:19:35 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v8 061/105] scripts/probe-gdb-support.py: add mapping for mips
 architecture
Date: Thu, 27 Aug 2026 22:14:22 +0000
Message-ID: <20260827221506.91574-62-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -tMZHQh4GBUmIwjjaAT7-9lTaGn-0yOy
X-Proofpoint-GUID: -tMZHQh4GBUmIwjjaAT7-9lTaGn-0yOy
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b7f8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=rodC9k6DH4pmb89SaOYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX3zPvzoiadvqz
 FB2fcfYjHrT+/PuAHlod6smohXmFBMd7Q17qwgL25zAPFbSNEhUkM3B864MHqF11U2C1TXMzkGN
 4NGi7muA01c2IAUy/xR55KPMsKVd3pEQTG4EBRzNml4NIGNSqt2zwK1DfYMPwZbgJT7snyYdLxP
 Els1quAs938j6vrZ+QdlKZiqbmnRI3z8IWwbfHXhLGHe8jMndvobrugCFOSBbeYelHxqFg4wAPI
 dgNsLBDUBcl9mJ/TvfInt1//irzCkqB5IikHzHvgaC3CY6VeHsbkkWnQYbmx3rZ9jmyL9ZPNmTy
 X10MLFBQikB9GqI3YB0y4QI39jXidtp3PBClW+KCuUDf7PStMnO8MztuuU/8fVo7z08SysI0kUm
 bkQcAzRtD5DkIsp21iffy76rj7E+wkoUIBHdIn/txN65yqmbJMdFaCYgHWrBF18FFj1jx9dl03i
 ixqdH58a7EHGAOqEZ/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX3cgshTBGVGUy
 e4S6y3ts6lPr39ujlA1pHwOKcxZ0GZxHpqm5cdVC1XO39UZRymphZkz3mJNHe0O51hfiosbCZKC
 ZGMepDRn120lLQV0/7uSq5h5cX2AuGk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/probe-gdb-support.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 43c70302873..da91c528ad9 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -35,6 +35,7 @@
     "Loongarch64" : ["loongarch64"],
     "m68k" : ["m68k"],
     "MicroBlaze" : ["microblaze"],
+    "mips" : ["mips", "mipsel"],
     "mips:isa64" : ["mips64", "mips64el"],
     "or1k" : ["or1k"],
     "powerpc:common" : ["ppc"],
-- 
2.43.0


