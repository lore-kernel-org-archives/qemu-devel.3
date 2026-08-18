Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107E6C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYT-00043W-OK; Tue, 18 Aug 2026 15:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYB-0003hD-0m
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPY9-0000Kb-6j
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH3FL1943387
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XtQt2ieJFZWb1xoB0jrT2WpOM+4E9cDdpjQLfHZUUSE=; b=EWRTOmkuHAkxEHdc
 sN8ZKON5sZn+n52ACGuEkvqaQfXcmNepQrda+Y1hepGwXFIreEd/H9ZykmTmr++u
 ukkuyIJyPjN1JOssF3o0c2jSJNun4K8YUc0T5X2FnpyVoTtBdA0O7uxJVBvCpGGV
 +y9vRQT5+1joQ+tocax4DHOw2PtHX7a5p52NpsmqgeusxzTZ9MBURd8IdM4dqijx
 8fBtSpTyOlW3oqTtHtCLfqcSRhdDP3Yq6GodRsSmJoEQpOAEdS772l2EI9dbtPmN
 Rllk6SNxAZ8Q48CJiHSkyIMDwMbkTK0NX5FLUFAEMxpUVzDDxZ3iYP95J890lgDf
 B+OO5A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn27x0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfa55c9430so1840145ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081559; x=1787686359; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XtQt2ieJFZWb1xoB0jrT2WpOM+4E9cDdpjQLfHZUUSE=;
 b=IDqZ+Ugxy+iFwPWfdHrxeHpUZJ9vRWLvtv7sGNdaIAFOF6EcYit1LYMShfF++qbZvg
 EV8v9YgTdrax1IMEZj8QEUqB/mUDrskPwezrLMb+eaoAhXdHVSdr+nKptthks6jvddNu
 2QnMLgI5ROqNvX6Zdjw9LqMoZ35Ojwj7l1QY3wjSDZ0sbF2zpRwIMRk7PBgl8pMOU1tR
 suEfcuKOVqn8LloEwtByaJUobGq5TDH1LXfKspmebZ62RkNCHV9P0d2xIacPkUBrXG17
 RwYHoiS7FicURFgcKjnd74HIdZ7MyeqV2KFhTImZ/1bRrkPxs0zNi11/rmdb2jO+kG3F
 v//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081559; x=1787686359;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XtQt2ieJFZWb1xoB0jrT2WpOM+4E9cDdpjQLfHZUUSE=;
 b=o7QVul3wcRgHV31RHOn2VItQOH20qCaybE8JsbOqoim0q70SNQhvKAVJ9OmM/1O9/K
 CS84l6qeA6gr5tTF4azmoKxqiPvY3xG90McASqMc5pg2VkJE/yWBN0T5t27NoJKluGMt
 VE08CHsO09BCLG7r/mXqvcxEiEb5oRvGeSt/nm85hW/SlnVSWQQ/eEO1stDVkctnWMdd
 0Qrokl/86rmZNDyT3JVPY4Z2qwE9HYjxvfUC4btDNrzKKEK3X3iEsZUmuKJw2wJa4tIf
 tzkSDaodsQM+ItCyaWWmVYtgxskHwYI71GKc6+lRafPVAbjwNptkbDOwiaDjqJjKsh4G
 M+qw==
X-Gm-Message-State: AOJu0YwVxLi8wZQtO5Mw3+PV2gndBpQnrwS0v27nzWJ/OIKs/m9k3b1v
 lW4F3YdJ7BpcQwMCahXmXc9390tXsV3hwkF1Lvprgo5ZCHdJBAEO7DPMfGk3lIWyg0a6SvuYrTV
 MzVBaUjLSTPUFncGNGa3E7ul/1bstTd9y3++MfYy3w5Y4mJqzuHo36LzIIlqVhrZ3fg==
X-Gm-Gg: AR+sD10ecHH3LyCd9sFUFcS9l0WLOEPzglDTyJiuqdR+xnHPK+nmNPVr8p1nsiMm2ed
 Nrs8uVnx9BRSAjhRVRmbDvFFsyS0p7nVSygw0VBVnnNRp3hoVzJbx0Vk6QZaR8CClAusNolh78P
 sWH00gNNTJq3aG4Z2/0/Brulz/TwCaHP+ChtJIF4aRe6WvRngTytsECjdJFU2z6agTYomRfyoK/
 lG7CGzpvkngyIrNbOzf7L6VYKqbxUOaBTGJA6fr96JHGgZApDERhEAwD6OMvy0VT2c4XCy3wN26
 CyBNoNiBrFSUnxIvsVuq0LyclRRvmG7lILHY9BneZMEwPsw+NKrv+wWMXrjj7jZVMOrXQJKqdDO
 fZqBRCYdq+H7dkK/atFLGcV7DiL1nWTLv4NKY53RzhZRJVBcnuh30GvzajjU=
X-Received: by 2002:a17:90b:4acb:b0:38e:5ac1:9517 with SMTP id
 98e67ed59e1d1-3957b25df0bmr153832a91.3.1787081558686; 
 Tue, 18 Aug 2026 12:32:38 -0700 (PDT)
X-Received: by 2002:a17:90b:4acb:b0:38e:5ac1:9517 with SMTP id
 98e67ed59e1d1-3957b25df0bmr153767a91.3.1787081558279; 
 Tue, 18 Aug 2026 12:32:38 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:37 -0700 (PDT)
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
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 093/104] tests/tcg/xtensa/crt.S: align .text section
Date: Tue, 18 Aug 2026 19:22:57 +0000
Message-ID: <20260818192309.22169-94-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX3PkiNpLp9o9e
 H/MKMIfyuZ3iBwftiRJD4vCKgRqtmFNhm8AkFwUxeZ5gOrp9B7JCYlVJR54b1v9unIiCp7rslnw
 58bh115jTXgwdB9jvho+rAbWimrXOjU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2jFH1VgwRypy
 7/RdRbip8xkv7qG1IhExKbhuifW9p/4s9bCAyQWQ9tCy/DvX7mSdahYlMbixOaSUe1EotuetL+1
 lZjBcm5IQxcsiBL77WZ5yWnh9dHEHPgXlcZrBozbEPaXLmY9jIqthsGk9o6Rl6ZCVXqPuVEoAgb
 9jnUbpaUzIuT5etlAR1md17rfmOW2JBS1l+DLmj/LRa+CQ2HFeUChLrkzYi6ZNFEO6cC7KmwYg3
 9Ouz18wOBO4MIOGkHXmdSUY26NItxLoj4fNM8NlzZnvQIy3F2eiX48VSVfBeaUU8IclWUlFY8/E
 MeXHdAVg6ou18U0OVeJ89ttwFl4zlTl9Xemytp/V/DhuLY3xkuWRW+KWpjYWXv29WKvkeWH1vz0
 wDqj5hFxSjiL6tGSrFPbGQqDGe91VqSiz3LguoZ+9UiwTvVmTVGk4Iyet4JG8y5TRoiYA2LQtxL
 +7cifzp9zzWTjkrpG2w==
X-Proofpoint-ORIG-GUID: MTF-_ADcpR1TwJpLizy5R0YlnHAVM53u
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a84b357 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=5InQkvVgWux2XAX5AMsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: MTF-_ADcpR1TwJpLizy5R0YlnHAVM53u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

Needed, else we get this error:
dangerous relocation: l32r: misaligned literal target: .text

Previously, .S and .c were compiled in different steps, with different
options. Now, with meson, we have to provide a single compiler command
for all the files (no intermediate steps), which is a *hard* requirement
to save user from dealing with compilation details in arch files.

One consequence is that .c + .S combination gets
-mtext-section-literals, which triggers this. Easily fixed by adding the
.align section.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


