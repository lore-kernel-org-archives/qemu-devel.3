Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5C4C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNv-0005jI-6P; Thu, 27 Aug 2026 18:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNt-0005dV-DV
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNr-00067n-Jt
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLp6l236096
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NTjnP6YGK7igY4faPuDs6OCMohdl1EcdIcvjs/2JPd8=; b=kFucxv35yqZaGVEn
 mOKyOs9nt6wDgMDsVMVlzJUemckteiz8atahIdzojWoLFRKDwGI5K+lNXeo4Atq9
 h2RCGzU/Ju23MVcdal8o79qsDeXxoOxsc42yRHqulQ6VzsJJlETEbIqIM9boqhbY
 gpMPrAygoqMhC30Gfvwi6CdHNy+92YC0A4NrigbMDhwzuih+8izajp+7aKYPSczx
 ysM8vqKHsRAAKcC5/GFesjZthpPn/wqVxYWOcnxfXEwKC4b4K60cWihKxFpzJW3P
 wDm+2IP/sgEEc2MqeSBLQajBMu5vD88ahlkW3QK6qvglo6LEFhj9rabw6VUk6uVy
 XN+aLg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjgttt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:41 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e13b57b2cso575447b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868941; x=1788473741; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NTjnP6YGK7igY4faPuDs6OCMohdl1EcdIcvjs/2JPd8=;
 b=M507GQjOZDUxXxBvDKZZkujP6LogG3bnzNhMTyK9CHQB0NMU5oxz7igPGCXKoUYeC8
 6nqHCoJpcc/Jsir/naz8cljNQbCTgPp3jYGGZWLBgYztSnsm0xuL17MAAK4nj7BYhpkE
 e/JAqsKGFud1vjJk96XKJAJg/NzDEupFXHasMUYC1OiQb6oWWEb9BQapkOnN+Ll/7gsc
 PvXiLrTkPJo6VktpXsxTjW4vTo/EWFxCLXG4eMNGc6lz2MqCH68Tz7J8LOL3DC+dmSMm
 NVw2uVzrwIpqwu5/k4zOHh0kBZxzGY3PN2+k2W7gCTs4MkYJTWHBqORTGN+3oFkuDNkh
 GrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868941; x=1788473741;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NTjnP6YGK7igY4faPuDs6OCMohdl1EcdIcvjs/2JPd8=;
 b=RjJ06R2xlZ0x3yiCuxZmuDmdWY5sz12uHgLZEwYqZ3SUhJ4RMC2gXM3HZOnVluwUGG
 qaalj7UI9SLY9fb70Jd+mD8xBBnDvRYG6s+JW6CLvZJjfupfLbR5WmKMvHwCOrt3jU2u
 BObl6qlMHvl5TaLfsfvHKAN9XqO/PFKKvLGJUUhMXeM021zH/fBPwX2VAq4i2+Jgeen0
 /QQMr89sazrtLvOGxlgYhpGTNKjz3PWGhKn8YpauK0V29Ihk2hEmJaA4QZMSLwfcm14w
 5tLLQ0877s6sBkk81+pkXg6VXCrVxay2ev8PTOKRvPF5RFCFaxxMn6ukW5L51ilZr3Fl
 e0IQ==
X-Gm-Message-State: AFuF++mE14qlmZuufAQsUixCDkLPF1EEyH2dkUakAEG69KyJlscpsjVU
 GjOkgwIOyrIPqOB4pe71CJAZE5E02eLY3wtBWp+J6t1IwECbtjblhS3HYtdeAq0/h9WskNlrT8Q
 3D/jkBGv8trxm3HBItxqEtrp4pSZ1DO/5RZVSudCR8cOABVeoJfrvWh7IVc+44AgN5Q==
X-Gm-Gg: AR+sD13rnS7iSKWV4IYa6VVsOlPqrYjDu0dVnvEzRWzYScZRYEZpJiI7X3ql+vfXaHT
 LhToHgQSMlvMaDkKsaLjIH7kK/EAuAsr47l/QlEtFLRQhVtc8RzWGK61YDQ5yBIzb0NpCjPGB4l
 yy3h8LY1zDexJRMoUw42EjYCW866jrlx1bEv024B/k1TyBQj2fPfG/lEeFS8JT2Patcsy+haXDD
 E8Vles+5UG9nX9MBYkjLlMs3gsJhQTzVQtnXOByceiNpDUpY4Miyi7cGl5XgpZ+oNDmRlTpstZ2
 ONdRDpAFtEyvbN6lhICxO22XtuzS6lKOtvQ2DeD9FyQ2IjWmLXIOeg69ym6qBEu2iDvK4a77igW
 ZEOVINkbLdIr/EQhX0ck2La1s9SmAJ9nZDMjaGCGh2c5fsie7BWSnnORPrBg=
X-Received: by 2002:a05:6a00:3e04:b0:855:74f7:40c2 with SMTP id
 d2e1a72fcca58-8562b1a0ac0mr5075943b3a.14.1787868941314; 
 Thu, 27 Aug 2026 15:15:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e04:b0:855:74f7:40c2 with SMTP id
 d2e1a72fcca58-8562b1a0ac0mr5075820b3a.14.1787868940930; 
 Thu, 27 Aug 2026 15:15:40 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:40 -0700 (PDT)
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
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 026/105] tests/docker/docker.py: return error code if probe
 fails
Date: Thu, 27 Aug 2026 22:13:47 +0000
Message-ID: <20260827221506.91574-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LWr-dlGQJ6-DYZvYwVThsIEfCrpm5U2a
X-Proofpoint-ORIG-GUID: LWr-dlGQJ6-DYZvYwVThsIEfCrpm5U2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXzveR1JI/Gcpe
 z3jklBLwkvD25FVnpTuTtUN9rY7OzXCchnk3sHsAfQ1OkkwFUbh3VHgcU+Gp9GzROtgPzRT/B2J
 bLmoVQjzXyUWKtyAeB235lw+0yJpRFuVeA/ua712YFnORvT3Yw94+XZPmh+SY/1G0XJlZ10WDz8
 4r4jN2B6QN8lwC+9SwvOJgTAUotZgfm3VZG4KT0Sf9m8HpNNyjSUYXKTJOoqIXjiJheDutUhJZL
 JVZYJrNx5J52S9ag/oCKsw44ZJ42xxf++iN2bsAE6ZJMNhV0qOcWZbgJMzmIDGcpO2VgYFb/ICg
 XojIzaqecdg7Ye1fF0sNtKppkUHmpfuPPgsF9P5MgCqEbiFUdrMtoRUPN7elQbOlF9KA3skZk4J
 G8DC7Ku1CK+FsmijeKsaIbqJGRFyI80+oujivfBiS7F4FEFLd/O4OcWZ5eOEEZSNP3vPS1JW9ab
 KzNX/PjaUT5BJUtzdIw==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b70d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=27jwiZK16oKz2i4YsWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX/wCc+q1vwo9I
 wDopx4YyC8Pr/s5eC+zhkGJsJSjINoa6ngfk1nvQcnlZqYknZIxvyvx3t+X7pPlygkRcVufGurK
 Cahz3TFyXM7IXIP9dBQQTnOAj4vPQxs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

We are not necessarily interested to know which engine is available.
However, parsing "no" as an answer is not intuitive, compared to
read an exit code.

Thus, exit with 1 if no engine is available.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index d2f39b5645b..fea6d0f85af 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -604,6 +604,7 @@ def run(self, args, argv):
             print(" ".join(docker._command))
         except Exception:
             print("no")
+            return 1
 
         return
 
-- 
2.43.0


