Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1767CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKn-0001DS-GB; Tue, 29 Sep 2026 17:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKe-0000xg-Li
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKb-0003tg-Rx
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TL8ViP942352
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=h8WLMlNF+Ib
 uvet58YgrPbFVlbAGvOgkUqStTjzLjaw=; b=lNc9ZKyXF7MeaKlUtuZz4egwUPG
 0eQjz/LNVhc1o4eWRPQSvpf0m3VC6SDqUqkSS1bueQIBGg1BlPLYW7ieSZ5Jnzvt
 LOSuq5hnYQYfW73/GVdnR+lQmNUrDomxDUtgIrUMqnSrLD2xVzC2G+OsKLMdnPJ2
 p/x/WU1c690Kc3IN970ynG+GjOXleGVK2rtrbO3Dgl8WDN0Pmqp8o0W6DjrBCy+V
 Pv+mQ6gX3Xvsi2dSXMzlD6tr/pfG7uVnegrrvICe/y32n87OyoWanhT8vEj8x4Dh
 mOry7HWoulkC6jY4/5mkNUtuZoA/h/rORsqDQ14vfjKTfwQHuPMygjxUPLg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0ftuhjus-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1606326eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717134; x=1791321934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h8WLMlNF+Ibuvet58YgrPbFVlbAGvOgkUqStTjzLjaw=;
 b=EOasUmUtTnaYIYqCPV5Qrja38RTxmmRLy/T/vWHcTSvQr34tphmpvXtLOGkXLIEEqe
 bB+RwJ7l2DE7aUiAOnEvTrsoWoCLzAJ8mgmG2Xki7dIZHSywNBqXH+LJyihaWjv8xqOt
 M+e838o0V1+RNK5j5c9lyGrpq4iFsXwHYNxtvXlE3XvvnLwtzO9nVgP55YLHNNdPEJHQ
 4PR5YwAfD+T5UVAr2fVio9QGsfX326Qwq1bUgAjo/YIRCeF1x6OfPNvuNj+9FwxYMBvI
 mZQBl7UathiwEEVagVzutcXvj6YLaLAi9h5CUDDWYcot4+4KSb7icglwxjcbyJLW0ekC
 ePxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717134; x=1791321934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h8WLMlNF+Ibuvet58YgrPbFVlbAGvOgkUqStTjzLjaw=;
 b=LaQTir2XdLvpvzCCmRuG43pJQkDJrq4b//x5bAn4qsCZzvxwn6gAKz2lb1A+hcgKsM
 37bBc3E+ylwOjJPKty7QY/ac9uSCpvLFgDB+s2dAApG9qjKOltAFHO0r2fqk2EhNut4G
 II3GJSjFudeF5bqlaoSmcSRFF4WjyZKdB5uQzbuUoQfuKWgEA8fG6yyer1o4XDRiPBb0
 gQqTY7ILA07NLhAIqf8wnrwFIXcj14jmUfQT6BfRPJc9tFrgg/7+18umWc8nLFklFtfB
 j2QEH5fhN8TDgXv7XPcOGrc+GGTDGEvywRojt0x4jKjqZWjoX68e99C7OA/7owX2niZV
 KJUA==
X-Gm-Message-State: AFq9FYKWgHYhx0D0jxY06KswULIrQmOH2kJp/lS3ebgeiD0/bRD8EqaK
 RN6vNSqdrMCdnfPTuDLV1q9AqbAqquX4LlJZ2gNT3RWGltTk2oNnWuzHp0HVmxYGRwGrmaBb42W
 VDF//njI9UVXshQ7drcwq79B4WrRPTp6nmSsRQFkWDu4mxUIuU1wcQA256rJJt+6ROw==
X-Gm-Gg: AYBFou1NsXbnnx945o+6MZqqfC4Ueizzhwk4fJTNlCHyzJcVzeYp3Id/w21WnCQ6A4K
 I4n/MzU4n2ohfqlfTOYBaH6urUErevOZa4XcbN92WXfK9MHMNKJBvv0cyRtXEBeVg0pVWOj3bJ+
 WodD37t1K12Hk6JnVKxaAgRSFbJ+Edjonxxeuxa8VOQnjpJQew+0przQJaRu0uPyh+JkYZWh20z
 h1Xo1VpbSj1qojkay+3AdKpY/qtusP019mmY7I+ePmSAJP75gYdHjupg5tW7reWqWAVpUVZx8Q2
 jQOqDISFAZO47/YCZDm+SQJ/ACP5t31hZM0Y1UkPL6e7ImfTzfNIhPTJqouwfsAlpMnk6Q75C05
 KraTvGMn9Aosgn8ql/IrIdSOb1ZH4Mtrn6Qu6c5NxKNCQ+1jMoDHZS6orJLxo
X-Received: by 2002:a05:693c:4018:b0:341:fa74:9ab with SMTP id
 5a478bee46e88-34c66e0139amr672725eec.31.1790717133410; 
 Tue, 29 Sep 2026 14:25:33 -0700 (PDT)
X-Received: by 2002:a05:693c:4018:b0:341:fa74:9ab with SMTP id
 5a478bee46e88-34c66e0139amr672663eec.31.1790717132023; 
 Tue, 29 Sep 2026 14:25:32 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 20/24] tests/tcg/mips: declare msa tests sources
Date: Tue, 29 Sep 2026 21:24:35 +0000
Message-ID: <20260929212439.110454-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfXzHrFtZpFTZC7
 +B2b3gme9xT5l7LijnC+3EKU3heUidvxiGHzXjf7HZi2341iJVKhlA+oufog4RujhXdF2QDkUSY
 9b2YaSw17HTCp9y/brKXs990XywsreX0eKESRKDJElXRwhj9Sl8lBaTntehSZZLMTqcyI7e3q3/
 O9I/2is3/HX1xj6tgoNoBup8yEJdE4LhNbNv0znzDSyw+sqZMpkV6euhomAkJEO/b2qr4dEV+lJ
 vzDt7xokiET5/3MX4cRNAh5gMlQ4NUtu3THFN8nK8S1Po19yj81qUnOGHiN4QopBvdRj3K6b670
 s+5eR6khcHOujryvB7JzpABjYK6hP9hzN9xFiTylY0BrM37pKEamzPrQh/kRmq/Xdtw9HatfOnD
 NbUyQ1nFnO8xiMqyRYuDZqY83HLLN1ri1NREZpG2huqbekLai+lc3W3KUbLV3Us+FDUgolTIM3R
 4ncbLRYHg8qGKsN6B1g==
X-Authority-Analysis: v=2.4 cv=AoB7T+9P c=1 sm=1 tr=0 ts=6abc2cce cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ummKjg7t1DANX8qufM8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX9DCjgZ5yfLrp
 mcD6tT+FR7CXpNPT0y0gzXa1BTQe82EJ64NwqgcxVZW99LnQcQ+KQAt/p5I0kkHU59O+w5Tn3qZ
 1mXgyqsqCEVeLF5neyprD2/nRJRsN+8=
X-Proofpoint-GUID: Hmcj1QZbQpfZT0sA4AVWsqsJJm2Vi0fj
X-Proofpoint-ORIG-GUID: Hmcj1QZbQpfZT0sA4AVWsqsJJm2Vi0fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/meson.build | 277 +++++++++++++++++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index efda857ab61..2164f143ea8 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -22,3 +22,280 @@ if 'qemu-mips' in emulators
     }
   }
 endif
+
+tests_mips_msa = [
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c',
+  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subv_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subv_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subv_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subv_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c',
+  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmin_w.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmax_w.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmax_d.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmin_d.c',
+  '../mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_mulv_w.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_msubv_d.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_msubv_h.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_maddv_w.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_msubv_b.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_mulv_b.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_maddv_d.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_msubv_w.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_maddv_b.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_mulv_h.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_mulv_d.c',
+  '../mips/user/ase/msa/int-multiply/test_msa_maddv_h.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_s_b.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_u_b.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_s_d.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_s_h.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_s_w.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
+  '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
+  '../mips/user/ase/msa/bit-count/test_msa_pcnt_h.c',
+  '../mips/user/ase/msa/bit-count/test_msa_pcnt_b.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nloc_h.c',
+  '../mips/user/ase/msa/bit-count/test_msa_pcnt_w.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nlzc_h.c',
+  '../mips/user/ase/msa/bit-count/test_msa_pcnt_d.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nloc_d.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nloc_w.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nloc_b.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nlzc_d.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nlzc_w.c',
+  '../mips/user/ase/msa/bit-count/test_msa_nlzc_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_addv_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_a_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_add_a_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_a_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_u_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_s_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_s_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_addv_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_a_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_add_a_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_add_a_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_s_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_u_b.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_a_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_s_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_addv_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_u_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_addv_h.c',
+  '../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_add_a_d.c',
+  '../mips/user/ase/msa/int-add/test_msa_adds_u_w.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvl_b.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvev_w.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvr_w.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvr_h.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvev_h.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvev_b.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvod_w.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvev_d.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvl_d.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvod_d.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvl_h.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvl_w.c',
+  '../mips/user/ase/msa/interleave/test_msa_ilvod_h.c',
+  '../mips/user/ase/msa/pack/test_msa_vshf_b.c',
+  '../mips/user/ase/msa/pack/test_msa_pckev_b.c',
+  '../mips/user/ase/msa/pack/test_msa_vshf_w.c',
+  '../mips/user/ase/msa/pack/test_msa_pckod_h.c',
+  '../mips/user/ase/msa/pack/test_msa_pckod_b.c',
+  '../mips/user/ase/msa/pack/test_msa_vshf_d.c',
+  '../mips/user/ase/msa/pack/test_msa_pckev_w.c',
+  '../mips/user/ase/msa/pack/test_msa_pckev_h.c',
+  '../mips/user/ase/msa/pack/test_msa_pckev_d.c',
+  '../mips/user/ase/msa/pack/test_msa_pckod_w.c',
+  '../mips/user/ase/msa/pack/test_msa_vshf_h.c',
+  '../mips/user/ase/msa/pack/test_msa_pckod_d.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsr_w.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsr_b.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsr_d.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsr_h.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsl_h.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsl_w.c',
+  '../mips/user/ase/msa/bit-move/test_msa_bmnz_v.c',
+  '../mips/user/ase/msa/bit-move/test_msa_bsel_v.c',
+  '../mips/user/ase/msa/bit-move/test_msa_bmz_v.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsl_d.c',
+  '../mips/user/ase/msa/bit-move/test_msa_binsl_b.c',
+  '../mips/user/ase/msa/shift/test_msa_sra_d.c',
+  '../mips/user/ase/msa/shift/test_msa_srl_b.c',
+  '../mips/user/ase/msa/shift/test_msa_srl_d.c',
+  '../mips/user/ase/msa/shift/test_msa_sll_b.c',
+  '../mips/user/ase/msa/shift/test_msa_sra_w.c',
+  '../mips/user/ase/msa/shift/test_msa_sra_h.c',
+  '../mips/user/ase/msa/shift/test_msa_srar_h.c',
+  '../mips/user/ase/msa/shift/test_msa_srlr_h.c',
+  '../mips/user/ase/msa/shift/test_msa_srl_h.c',
+  '../mips/user/ase/msa/shift/test_msa_sll_d.c',
+  '../mips/user/ase/msa/shift/test_msa_srl_w.c',
+  '../mips/user/ase/msa/shift/test_msa_srar_b.c',
+  '../mips/user/ase/msa/shift/test_msa_sll_w.c',
+  '../mips/user/ase/msa/shift/test_msa_sra_b.c',
+  '../mips/user/ase/msa/shift/test_msa_sll_h.c',
+  '../mips/user/ase/msa/shift/test_msa_srar_d.c',
+  '../mips/user/ase/msa/shift/test_msa_srlr_d.c',
+  '../mips/user/ase/msa/shift/test_msa_srar_w.c',
+  '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
+  '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_u_d.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_s_h.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_u_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_s_h.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_u_b.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_s_d.c',
+  '../mips/user/ase/msa/int-compare/test_msa_ceq_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_s_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_s_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_u_w.c',
+  '../mips/user/ase/msa/int-compare/test_msa_ceq_h.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_s_b.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_s_b.c',
+  '../mips/user/ase/msa/int-compare/test_msa_ceq_b.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_u_h.c',
+  '../mips/user/ase/msa/int-compare/test_msa_cle_u_h.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_s_d.c',
+  '../mips/user/ase/msa/int-compare/test_msa_ceq_d.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_u_b.c',
+  '../mips/user/ase/msa/int-compare/test_msa_clt_u_d.c',
+  '../mips/user/ase/msa/logic/test_msa_or_v.c',
+  '../mips/user/ase/msa/logic/test_msa_nor_v.c',
+  '../mips/user/ase/msa/logic/test_msa_and_v.c',
+  '../mips/user/ase/msa/logic/test_msa_xor_v.c',
+  '../mips/user/ase/msa/move/test_msa_move_v.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c',
+  '../mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_u_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_a_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_s_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_a_w.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_s_w.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_s_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_u_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_a_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_a_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_u_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_u_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_u_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_s_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_a_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_a_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_a_w.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_s_d.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_u_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_s_w.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_a_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_s_h.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
+  '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_s_b.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_s_b.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_u_w.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_s_h.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_u_w.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_s_w.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_u_h.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_s_d.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_u_h.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_u_b.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_s_d.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_s_w.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_u_d.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_u_d.c',
+  '../mips/user/ase/msa/int-average/test_msa_ave_u_b.c',
+  '../mips/user/ase/msa/int-average/test_msa_aver_s_h.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bneg_b.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bclr_d.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bneg_h.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bset_h.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bclr_b.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bclr_h.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bneg_w.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bset_w.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bset_b.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bclr_w.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bset_d.c',
+  '../mips/user/ase/msa/bit-set/test_msa_bneg_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c',
+  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c',
+]
-- 
2.43.0


