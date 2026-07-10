Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11941C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4hL-0002h4-H2; Fri, 10 Jul 2026 02:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4hB-0002Tm-Qy
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4hA-00065w-D5
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n1833661666
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JN+OdpeHcMmltGI116CNSMKbTGMPNAS7mvZhZp5Oq/U=; b=Edaiut31k2sV6/PB
 V0ufgYCdrpyrObaMVKUBJJXdjvgBNQ/UF4H5NPPXfMSHqzKDtPOu5FB5/VpSS6Vj
 XHC+KwjnlvchGdss7WElmWdFNwIXbkhfNwhv8SMfMY9qpkwAgU0ALAaXkUNHTe7i
 pbc3gPTaBV69rUTa3vsJLaG1rVs16iLjJhZm4wnNjylDsZDjJchn2kA8MNrsUmdj
 mJ54V+ruzwOmJeTw+E3ZFmFhSgB/YMVxo4QTHC3ANVb1T7QZo2TjYsn7eV40qzDo
 h1dA3qd/7uuF48OZkz0vpu5DPG8VGWGXucRax7i+6sWcDKfP5/Ou8p+s8k48dDIY
 cXNf+g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24twvb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so1279208a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664792; x=1784269592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JN+OdpeHcMmltGI116CNSMKbTGMPNAS7mvZhZp5Oq/U=;
 b=D5MGo4J0fDAYVnGUq95mrnKD43m6CkgG4irXv3Iz7q+segDdC+kIRI15JYLxyFkQ1r
 oVlfWigx4hD9hrM6tucEbBW+9XVo1ABp2cblj4ERrVt8K0Pq31HTj7uYHNFYuIDCvcFd
 dIu8XO/Unpp3t/EHpwA9YSdkNppoafzdf3mAiWX4zqyfedmPvSYlnUkyiUe34fVu7Ics
 Y0Hg9FIcex9n2x5iUZBCIIAtl8ANybo0qVesCUK81WPmiRFFgIajfJ+xszXice8hwK19
 c0QPBssi2CYTXCAMv2O8BZiSEWIJB1qtjW4fU+YzrEFd611s3pJ/op3wOleplW/eksXP
 airA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664792; x=1784269592;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JN+OdpeHcMmltGI116CNSMKbTGMPNAS7mvZhZp5Oq/U=;
 b=F9norRXKjhCN+Qb3Vnoos9ZdTvf/DhgJnHOb/q8EeTXEhd6Fhc1QilHwX4KFhHUtCz
 iitrRrOGeXKyRjbq6exvYia32LxWtmZPPfTaZklYUa29w2hV6yH5TqqhgrFjQWzC3Ykt
 O8ssk9d7ti/GarWMbxwF+noe0eI6wXOXGKGUyDInhVEXOzxrNDbZo7Rg3OXPdk0WOZm/
 1dcadb0o+zGGzBBlElT7dANHI5AQY+U0itsvUQOYk5WLRvY1BlhQTYPuhMmwz1T+GKVJ
 cnX3d64bpxYtUWT6lmA6ZZ8nIBaZIHfoG8r9SC/nIrBwtPsExdiZ2Ge5gm4Mo0YydjDE
 LtzQ==
X-Gm-Message-State: AOJu0Yz6Jy8ZL8MkegklS9A5twOHDwzbXSJq39AeZg9Eeu0gQafolQdJ
 RfCZ5MQ6GzxN6vhdw761AapVoEygpc1oOnixaJ/+hurP+NO59tTWLCDIVysCQaOqQq+uEqhGL5G
 PuXxQSud2LAQWHFrc0FXAbcWc6stJdPCZPg3HUmPd0dGF95C6KSy/c25QOvGNs0F5cg==
X-Gm-Gg: AfdE7cn5M+TFe5aa3KztX/h+G/RRwdERGiMkmb+N9apvdN5j5ZRGNunIEjUMDIUBXrb
 63N8sTDe5ksJJQ/CxBYWDwaf8ZiAnSh1ZjgFAB8N0ytFSPMgbgUh37mvbBq1zvZ3DhqYWXtkMeq
 EnWnqJ6K9ksamdhbizMbyVuS4hZxaKHohprWSblt7A5vuiD3lKY6vXkgCtJyqBMh/YPv/Zh9vHC
 gnsHTLzTyPqIb51wotBTLqrBupc4dZcnTI6mpcNCs4LH7K4N1GF2wcDmYgKpMPDOGZ3pkc1XpPr
 cVNkKugNofhR8fPjlDN2fm3QHBEiHcrB8NonXQflLwpXBREavSWFRezRZQBvUpF7VhzDwnpyPpJ
 KZ7ziJS431ztiWO4OdYnciWzcM0b9MkY33pEJ36xTD2zV1F/ZAIThFB9NJSIhghNXI13vIxORx2
 mf//kjXA==
X-Received: by 2002:a05:6a20:ad98:b0:3c0:9c19:6585 with SMTP id
 adf61e73a8af0-3c0bcfaa7d8mr12354580637.63.1783664792439; 
 Thu, 09 Jul 2026 23:26:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:ad98:b0:3c0:9c19:6585 with SMTP id
 adf61e73a8af0-3c0bcfaa7d8mr12354542637.63.1783664792010; 
 Thu, 09 Jul 2026 23:26:32 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:26:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 79/97] tests/tcg/s390x/head64.S: declare _exit symbol after
 main
Date: Thu,  9 Jul 2026 23:19:57 -0700
Message-ID: <20260710062016.1818125-80-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: omhX1uyzIvWJZHcvDWnkmo5E2fJQ84D5
X-Proofpoint-ORIG-GUID: omhX1uyzIvWJZHcvDWnkmo5E2fJQ84D5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX6aiMdUtmCU/M
 DZt7D6/9bEGYrgfNBvjrx2autHMUXOkevEk+X6gtf3upCHz/pY86Yzzw0vfRgL2eagsjxumaj+d
 pUhJhXqnMNGY1hOmlgYQNKJ9r/IMiAs=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a509099 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX5oaRNKN1nUsz
 suHFn3BoZotKY1SeqDQ7y+4yMIgHPcqsweorwcSHKU+mjD4QTpQtV9CJAOnnJju5kI0wcPLpnpg
 IuRygO5EEQBmr1XuJ69vnwcjhiBHkVEw7u1dmgyrRhysP0RDAmc20vVdxSPVMQS0OXOYz+rF892
 aieW2/NV+HF8o6wFcizXPBNMr2RkV7hzHfPcdDdM4G5nNgM9wjXrwOHui8uDKjvgyMoqcW2HBVg
 CVZhGrv0KuEGqQxRv0fR/RtHh2eSyypmlGbWi/qykf0gBQer0OGpEa5NxjIi3RTDqO/3Ti0O6vo
 IL58jFT68BRucBhfZS/1nAWGCj8ZZ8xNCOl6VsPSouWK3K4+JALdUYLx7g4LpSgTruUpcKeXTpV
 NkI+UaPzsFDBSkSAKy9haYDmgTY7JKYN7YPSZooBzW4F2nYdF3fysHtIvXgGYsiOyWh44BrYtyQ
 TXNPkuYHaZ9MM9eEzeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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

tests/tcg/multiarch/gdbstub/registers.py expects to find this symbol to
compare state of registers before and after execution. Define it
explicitly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/head64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/s390x/head64.S b/tests/tcg/s390x/head64.S
index 4fe288388ab..0523fcacb33 100644
--- a/tests/tcg/s390x/head64.S
+++ b/tests/tcg/s390x/head64.S
@@ -14,6 +14,8 @@ main_pre:
     aghi %r15,-160                     /* reserve stack for C code */
     brasl %r14,sclp_setup
     brasl %r14,main
+.global _exit
+_exit:
     larl %r1,success_psw               /* check main() return code */
     ltgr %r2,%r2
     je 0f
-- 
2.47.3


