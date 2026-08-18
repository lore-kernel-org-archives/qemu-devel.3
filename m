Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791BDC5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPUJ-0007ME-HR; Tue, 18 Aug 2026 15:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUH-0007Jp-7r
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUF-0007bR-Mv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:41 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IIaaVT1940453
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q4vMgFhsWM4rjoh4uwVn7kAYmfdW+X3xe0f7UD1qC+A=; b=j5okeR1sjpouw1xl
 JHrcq4TCqhvpesHiwoDKd4ze3i2AcHKMIJ90jZ/O5zBBtOZLDLewwpJaRRfTIrgg
 70IZnQ9a+L1fWV4L7i4NP4+PJSfnZ+aCVtYUa4o1rUGH7E3+Jarpm0VVoa1ECeDf
 bRLIaGuegZXDNWZ6S5NCLUyBhpyoQ1PTKjSXA3kh+shfemJvtIp5uJ24Jmgm+VtR
 lF47397TMilLBI0w4RMo6ujM57r+vyTCNy9sNy4FvHstC2uiYRzNG+lNj0UCing3
 rT8yeGt4FDdXBO6kYwduSH8vmObZh/PBKFFjICtyU4MYnktTZnYncoclIaISBVjl
 Gpqgbw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4vtu066a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so553805a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081317; x=1787686117; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q4vMgFhsWM4rjoh4uwVn7kAYmfdW+X3xe0f7UD1qC+A=;
 b=HCcBpPSFrOxlJMsd4YdWKBVyy6xa4XmJAaf5fE/0YF7sRXDO/gDh7joRfnOVnpE7KE
 a9edl5DIpaUXF2qvmmFJ0u0qgjQU7taerYhtZlvGdJlWfQ3bu7nse99eGNTmVzDFsxWd
 Jv/mCMVshlUItKF621HgqBpsWeGSmdNoJ0J8RmKX+2ki4v+2zTkCff8WGknNqIjiC8T4
 PtNQjAdWsBJ1BDvhd5K2BzsWW9mPM/SXfXZZLvhvhn6q5w19II4B3NjOX3xN/tZ90/6v
 aQ3dGNWRQOWx/1IUPdE2/Ia2KnLLYuauAzCux6B1UBCEP43txH2irERTANKUnk66Tceg
 AurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081317; x=1787686117;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q4vMgFhsWM4rjoh4uwVn7kAYmfdW+X3xe0f7UD1qC+A=;
 b=n+yjYjq2N32wcmFVt+2Hzy1171ziIXFVef+PmaivyzkkJOK2SgqI8yh60xY2TYN4Pn
 HYuiFTceZ35eP+K7Yhu4iJfl7gI7BjlZ90NDpf9k1M3nMilS8ntbvDf92HHsPKB311Hu
 VyZ4d36L+6enNw77kmAlZEiiehqiYMpDBLCP6tgH05ya4Ph+XCiTlNmwbx8aEazggBzs
 VMn9BoKPsyKc887NjR1n3vrL51a3nWBrSMwlyGZC2asl7m6CFA3eiU6ZTg4M9fwI9EIT
 hXtgc62w/jPoB2UfQazgemxwlXm9UKoZOEM/eMKn2yHtXPmrO6Uw0fRE8uY1bC7e0a49
 FxZA==
X-Gm-Message-State: AOJu0YwiarQmBx1g8fJePY/2sBgUCq847Yzz46rnhdEGCUdGXs/RCoo8
 abvbH1eF9XfNzNcqGXBDe0QmpMzNgmRjSg+cwAOYIQa/GHMyUta04JueT3mtInoh1aY2cl64Ljl
 /0hRFo+HUhyLucZgk/PbrUhDKOnVTxCuT/tUDx/tyhLgMOfPO6BWlZ/vLC5YcarCcgQ==
X-Gm-Gg: AR+sD13+k/z2kDZ1x/CqHYfrxb7i3HCL4VYNWnXE6AEmQ/9S5dvc7UjP8JjNYqcS9Xx
 OKBX/X6FQKsTaG6mD28CQggTwRnYF8YYP+3r1Ym4aejreofZnHDWesqA88SlkkDyO6d7tw6+/la
 PECaNLUpCSVMQSYN43+c1iOyr8c6BRfGIGr6idPIkziMKQmfQeUkcuIa5brYrWM8BsqEmLRW7rO
 EI+vzSHigJTGdLkzf5WR2948GH6M5vg81Oh0moL+6Q9/e0BD8Ymesi8wet30bHhG5amk79OAtYX
 r0/PDav7/DDQ1BavOZza0/QqCkiFPXTlB4zINRKSv5ubPtWspRiwJDwyrji3ajLC2UbSmlF0Yhh
 1rsRRj+rIRZOz7Q3FmW7N1y0ToOOlCacbRmbvA9sm3nV6TAotA2vegTOrpWc=
X-Received: by 2002:a17:90b:1b0e:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-3957b38253dmr65255a91.13.1787081317445; 
 Tue, 18 Aug 2026 12:28:37 -0700 (PDT)
X-Received: by 2002:a17:90b:1b0e:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-3957b38253dmr65166a91.13.1787081316980; 
 Tue, 18 Aug 2026 12:28:36 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 069/104] tests/tcg/or1k/test_addic.c: remove unused
 variables
Date: Tue, 18 Aug 2026 19:22:33 +0000
Message-ID: <20260818192309.22169-70-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b-n5pNBQJy_VAdyjDkyG-rvCfASNepQx
X-Proofpoint-GUID: b-n5pNBQJy_VAdyjDkyG-rvCfASNepQx
X-Authority-Analysis: v=2.4 cv=FeYHAp+6 c=1 sm=1 tr=0 ts=6a84b266 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=27jwiZK16oKz2i4YsWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6V85B7yAwUaJ
 AAqxk02O6rYSUZn8MOQt5RC6iJ7QMBbMFUauDbUlBVe+QfV3u41Fkk6IpxQWx5VPzJtv/P8pbs9
 CZpU9TbuHIGbCzesmpin2nLT5E6xBNk8OREvB+0M4EvDJghS8liAHGK7HtkKpFaERZgYF6wmTn9
 szwmNZNDla8euV35vYJp1flLdHve+HbKowQvAE0VE7A0IS9JfDqfoZKyePOVLToRzS7K34KAVKs
 u4BXJAQAYXslwKJ57mjk5pddAuVpDIOLd2ffHhGQugnCN61eBu/TfK2qyQ1imZGloZvQQ+aV3Re
 XfL0hsbqqKUBifqkevMt010H4zs73yoo+2R3+4P4z9AFx8wdk86PWgtMEuaN4CGJBNdNwlaQyyx
 NXvB/E1Ma4UbVYcmPpc3uLcmB9H4lZOlBEyoMKuguhpxcsEVk1rrSLeyvIOdF9y5GsB7BVaHdqC
 0qw7sV131YCu5HvaTIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXyy3g2SmIYLAa
 kKrqnG8zrNHN9X6ZpfNgTINebxf/7z1rBQaYeOcJ5pLG1l2VwxvwP53WpQvCu2effBmZYhj2cgB
 gj+C7BuO3oGQq8BeQvKeaeo4amsCBBs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_addic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/or1k/test_addic.c b/tests/tcg/or1k/test_addic.c
index 857aaa13302..27939c64ff1 100644
--- a/tests/tcg/or1k/test_addic.c
+++ b/tests/tcg/or1k/test_addic.c
@@ -2,7 +2,7 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a;
     int result;
 
     a = 1;
-- 
2.43.0


