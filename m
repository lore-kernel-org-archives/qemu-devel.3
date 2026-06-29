Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D501C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBo4-0005f7-Ex; Mon, 29 Jun 2026 09:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo3-0005eB-2J
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo0-0003Gk-PF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:46 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATTT72592877
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=; b=EVfZceJzIzsqXCbh
 4mZckzEzj+cw2VBeu9OCSOOQtUVqRpuqHRTcVSHWlpfdEvx0FQJiwGe5GHumYbYw
 XwpEbDC+iT+iHcjGtg8QJ57L5WsOERIrxuB2RLqCVwYh9lkEELp2trvH0/mQp7O6
 TPOtpuCpcAQ3b/9n3oO4RBCInjgukvJYtUf0KjwoQpOQgzm4tFg2vv085MRGIlAE
 HvE52gkEcIjF9jqb5zXybg/0vnyjj1K+Fn4z3Nai1l+aF1cAXQijwbziuTut2N/H
 0iDUI/YraLI39/oWNOYofw8SluvNtXwVbtfgA11dU8FFAexr0A+63HAkf01uoJn+
 WMbLQQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vhsvj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:33 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso5835049c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738813; x=1783343613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=c8lwNwKYlVHLufyF2GOFIznlvFEwHjMLec3qIm7N0mTsEGPFoneGsrqe/VPzD6xZzZ
 kUyEU8dVuVTjP6+06LsMGGYlHZhWvbs+m7EcgGl7LToZhl7q4uLamNunFLwoILCxDd0X
 dAVIrzc+97SE07um/dAMMWMH8iqfqrHLNDotKBLXFaAUFhMQRBJV2sCBDbIRfdMB3Ogz
 BmhJ0c23dqPQm658FkBy5tvK+sJGl5omZ81TlfGFlDCuIQYdKuocDUGt9wrP+Q88SdzN
 oH7koq8ba2YEpFFuS99PLBIlf5PVYcfF7MPzP7ogpab5vpq6Kyw3Tm+vBYONk7qLYscd
 /v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738813; x=1783343613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=kLrGW9n2xh34zRoA9quc94Tx39weuj/x8SVtvdBZz6cSiKLAxqZQ+z9iNVmkp7BUbu
 u9RxkoiQsnepRmiMrca9ck1jdNy2Ph4mgNcTSEaOmL9Ujv+7Ulz51cNpzo8CVMjB8cOH
 psi/X48nWcUGV/C4xTilKLUrdlGLufF2ZQgWpfksjtRzXq1uZiFv76tOdvnZYzjtol+V
 tIL+qZ2S7WJlL3Ldpj7kotEu6eWD5Y7oMELh0FiPtrlEMt3imq8jXYYj5TTxKZHT45HB
 PwWyBYSmwA3DBJfI4NkuSuFreIvPiVtjcIKtJXMh23OK701/4+kNiBcm7cXx3U5PPFlm
 9ADQ==
X-Gm-Message-State: AOJu0YzOSB6ze2A339eZEL7cnpS3KVfq6XUI1gkOmizs6Y61WdIAI9Cp
 McU8TH8h6dNyayCfZpeqOOojFczy/LqjkqgKDD5q1VagdlaZ3ShBz/DzATHQYKpPsmOgryU5gCl
 w+CSUOGbDf8BHkgJXQMlj4J2OBiKYX6y5Czkw2hbwnZ7C4EkUgfJnZgUYLVwn2MxXog==
X-Gm-Gg: AfdE7clQbwMmaN6AEarxr/xs0cXXUjqxTp+QYW56a7Ro/CKa28Z+wHCvnW+MdRgSQm/
 oDJzC4fBvdK6rLo9R6J900hArwr3RsCJACKvSh/fEUbLQFR5sl09OLwl1YGNrzgb9NxAizfn//G
 fGVQRllfefY/SpcmEv+67r+QN/UDBW2C2mm9zlHgFtycWasPv53vFzKuKLzWtIfDFy5kivFhZw3
 rytw5ToLmi9eAoeIbqWUsU+RH2KJMttioLuYfWBx2PS+SERxAE9JXvicUsSkLd0ibrhe9aqTJMa
 VfrXRM6FEe+4dIzC/utQ55CAQuQqWNm5BCUcQS9UuykSBrLmr2Y0sxPpSlQahTzy5ar4OZYMdcc
 i1EKeEzvX50f6elhrV86hnjIULVc8N/5VB4xyPMl2Ms60XH5/kNIBAzi5HPs=
X-Received: by 2002:a05:7022:69a0:b0:139:d66e:687f with SMTP id
 a92af1059eb24-139dbac859fmr15436928c88.24.1782738812843; 
 Mon, 29 Jun 2026 06:13:32 -0700 (PDT)
X-Received: by 2002:a05:7022:69a0:b0:139:d66e:687f with SMTP id
 a92af1059eb24-139dbac859fmr15436908c88.24.1782738812320; 
 Mon, 29 Jun 2026 06:13:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 33/77] target/hexagon: Add representation to count cycles
Date: Mon, 29 Jun 2026 06:11:48 -0700
Message-Id: <20260629131232.2487780-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: gBR4AQ5_YWw5RTDkKnwIT5EeabwMgV2G
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a426f7d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gmA5YO3DfmenxuRff1QA:9
 a=tsLLKIjAKpJP5df9:21 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX05tRf1huHnFI
 gtDxavbIHb1NgOrhLoEhTiJ36zSNpmNFyOHGLubQRJMYisJ3VS6iPzkQ8WTjxlQhpiBDh2Y9QM9
 Yaa78/rxYM9RcojfAEpRm/CNY8lGUdQ=
X-Proofpoint-ORIG-GUID: gBR4AQ5_YWw5RTDkKnwIT5EeabwMgV2G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX8ytw72jTLuam
 I8PhQdNTcP4hfmUbQWZeEpoRqslg/uqNEDWc7rUbTaNEC0w3MavbgnLslqVCE7scPDMtyGs5H4P
 3ZaeyxJEpYPybCTvJS/+pbW0FezDJyn3YzroT/Ux776aVeXpShMeabfr9+eMGvfGUm3Ek6S6qR2
 Phsehquqnz7bg37FgAkPEpKKazJoPOZ2a7XNdONCkiUF1a10WldoAq5qH5qmTwLCd9pxmQHBzFm
 bJNRF0aQv41sRvW3z12edkwamszbSx46LX5ieG5yQ+dqqA2/WcMr/ATfEWW5puxfKBTWB4j9J/l
 Ptzpj4S/lRjZe3gYzavrbE4LxjaVEpsVbWTxDUq0detuW/c08q+fLm3vVRgx/0is4KooyJS+51D
 VB4rjBJgahOFliJmy1hUOdVNTxchT+PEaVylW7ljw40bbVWoT3/d+Fbz2GyAwpyFf2AU/oH2qev
 NYLGzhHubuiVR95JZVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

QWRkIHRfY3ljbGVfY291bnQgdG8gQ1BVQXJjaFN0YXRlIGZvciB0cmFja2luZyBwcm9jZXNzb3IK
Y3ljbGUgY291bnRzIGluIHN5c3RlbSBlbXVsYXRpb24uCgpSZXZpZXdlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5o
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDRiZWE5NTNhYzcz
Li4yNTQwNDU4YjM3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTExMCw2ICsxMTAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogCiAgICAgLyogVGhpcyBhbGlhcyBvZiBDUFVTdGF0ZS5jcHVfaW5kZXggaXMg
dXNlZCBieSBpbXBvcnRlZCBzb3VyY2VzOiAqLwogICAgIHVpbnQzMl90IHRocmVhZElkOworICAg
IHVpbnQ2NF90IHRfY3ljbGVfY291bnQ7CiAjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3Zh
bHVlX3VzcjsKIAotLSAKMi4zNC4xCgo=

