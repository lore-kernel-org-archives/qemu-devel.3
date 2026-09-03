Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2A9C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24wx-0004Dh-Ns; Thu, 03 Sep 2026 06:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24ww-0004D1-FL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wu-0007Rd-UX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHBjt1328202
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KFtuNuJQzlFXmwO25agl4qJWfBENhsuy5w7rq2nSqZU=; b=FlEbgOSVdeF5NDdT
 drFvyKfzC3hAF4PcTtqeJvqUnZTxNl+swmYF29Is1fND0NyFRMU1dfwk4riCqqjb
 vhu4qn7/SiOWNghOgj+4FPEBSf7VoezTjZDkgpU3KkDmIgtYAKl6jFprp7T99Ak7
 9RUJ7KN1kPkQXNZY6CzXbXE5bzzG6sAkr5Gn4Q4282FQ3HQUiFZzWDJ6Gb0O6VI1
 AXkdJrZaihzfDsbZhQw8LXs2LWo7uVH9FoGIjNFyn8GNKBUdfHzyMSe1m2BB2YK8
 DdvYK4JqEuyTUCtz+c1IPGOnBf8J9Agt+j39GjQWBZUzYVNdqZZgNROGd2fCEGQE
 ZLKabQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnmmft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:45:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930b571432fso150039385a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432338; x=1789037138; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KFtuNuJQzlFXmwO25agl4qJWfBENhsuy5w7rq2nSqZU=;
 b=Ryh4pvv9YDY+JaHdGWQa+Cgm0xqg+RBiHJo66jEOKwzkS8u68ttRBuJjQmy4ylzqL5
 COIPkfxlemCVx6DaltncQuABYVLPDVCK371G4dow6Sc7Z/ekxbBhcEDjb2eXJsFgPWAG
 HFOsxk9KKfUNz2k4rc0jT4ufrO7Xw/NhL3V4IiCGNE9mpaBTBMhkvYRYl80p1xxymLcl
 0L1dN5aN+dU983zpJdfxGtXNdj0SMErFlqDKzu9xQvTNbmTV48YgsySX+wKYjb3dCFTv
 e0woU3xXRng/M2U7moy3ndEVO/2ZmsRWIGuLCr18a/x9o6qTloJiqrvyqWa+VZjj3Pg7
 YgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432338; x=1789037138;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KFtuNuJQzlFXmwO25agl4qJWfBENhsuy5w7rq2nSqZU=;
 b=KZ/zuNG+IefMm8igkNfDevImxiWlStGrDcSJE7kgOlCth+fbXx6bF/IA21sa42tRPV
 hE/1iO0+o3+AL6jSiRK/JWdYozw92acQ1neB+JUkmsg1L4ryKOKbcLgcTgrWP+JMAmFH
 S2SOBynRUtvOg73JC3FiwDgwCSmzsbLuVqeJrBs24IB+R4qnzG6SA9Xgx4X6U/aiMLo0
 oC2VU6sGAdH02bD+mnUZYU1SCzrYYxGqz0bbDGW5jnn012rtuiSdcqCSFIUcxmBotKhY
 mdYDH6YhU8Vnh6ukMP7oVVctH1oNpwahVOXyGlWkubb30+9TqWP7AsOrR3zjUaGLbYnF
 UK7Q==
X-Gm-Message-State: AFuF++nYYaXFrm0TmVDBGpDpdX744XetDi7FeV80ZN7TFTIrklrC0SE2
 Gyfss1eMSGYlky98ZyTYek5WlHlcFVTXAyEyVYrBpCnXF4eK2mpeKf0ccuNSgK+beIski0e1wNM
 PlkHu8dkIS18YSfqGbuKD6HkBOovI+yaKz5JMnNVTTIcah+Yi4TDAyT6A9iqU3njEZQ==
X-Gm-Gg: AYBFou0Z08E5mih1eeWRC1Dhs+bslneUkaU1jsYU9nG+9zEOKEoYo40Jo+JBXI/bg5S
 IlLkNV6XJUW0uM7/hj3V5Z0dCAzHV8c369CkXOn6ngZkFTnCnkg1ZXDWgGIrfNRdn1X5uD7sv6i
 F7HGEQxNpiEogP7/kYeJm7bP560wndsVEp6xlh6e+qBjEiKd71k38NLektOgQadTZfN6K+E8sRs
 PxLX0MeHrCuZ4RKUrzeRCYN8wCKi1q/rpXJI9kgOQJnPSzsyvqjOl3vlZDtgmvFk3Lpo28PzW/X
 9CdAQXXbpmwaIAs2yx0wUWml1k6KrgaNmNTaJgxUX4Pk6noAgcUZMX4iKKmsrqTMm9MItu+JzFe
 w1Nn91Zz1sxGwqQwNZF81ScmRCY6PtYSMuX9VWigY
X-Received: by 2002:a05:620a:4621:b0:939:72cb:baf2 with SMTP id
 af79cd13be357-93972cbbc95mr193248185a.41.1788432338375; 
 Thu, 03 Sep 2026 03:45:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4621:b0:939:72cb:baf2 with SMTP id
 af79cd13be357-93972cbbc95mr193245585a.41.1788432337936; 
 Thu, 03 Sep 2026 03:45:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f914bsm74282785e9.3.2026.09.03.03.45.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:45:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 48/51] rustfmt: disable wrap_comments
Date: Thu,  3 Sep 2026 12:39:32 +0200
Message-ID: <20260903103936.62355-49-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gT1dBPxqlvd49au_YMryMzbhu8CCJ6PV
X-Proofpoint-ORIG-GUID: gT1dBPxqlvd49au_YMryMzbhu8CCJ6PV
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a994fd3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=uawEZQS_clvRjjTe5l0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX8aNr+vY86i79
 xOhdRAkOZBOCMQH1v6+wB03TV9a86lPu14BoPZ7KxdPDMSHaAGnkqugeH022xmgRg++VyvMhaGe
 t2bv4rMfaZkMxzre+caKgVN2PBMwDrfN05D1ggmzsonaB+9TmaUh1XtvFy6LEZjpu0O9xdDpYmF
 +qHAfTWZQWtyOgNQad/LSTymOGNYSGYs5tqkZEsk0/YJcrPuoRPetjECtx6upBeQhaFIMdraoLy
 y+/HzMBcQVGpjd/lLXvzDhH9pnsdBfeVMwm5xeE9w23bJl070XkgftDr6KSCsGuX1aF6wHpGueQ
 bI7mkvZaorZyN2szwmJclXfmOG/aa4tl312rlSrNNT8u4I7Dd9gfBJbb2e+oU0xo8qJwg0tn++3
 xiPG3HU7pZDSX8N6ZJKFuN7qNutLyRyZQurhqzwqFkwJI+h90GEETxbqZdIl7Bnz5b/t9JCGr+D
 pTREDpJLSxMd5Wk5oZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX0s71a3oWjCmw
 QLCKBeAhGmPAd/h67CFElnb+DSzjZw6NWpFmej5AvzigzVyklx6pHHBG9qqk5bqlCDuM/G83YfR
 /aWyXVOvAOwaeNGiyB4WNgQtwoRR5A0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030092
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

This was in practice not enabled until now, and now that it is
the results are not great.  Disable it so that the CI job
check-rust-tools-nightly does not fail gratuitously.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260902083624.419157-1-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 rust/rustfmt.toml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/rustfmt.toml b/rust/rustfmt.toml
index ebecb99fe09..a7d610bce21 100644
--- a/rust/rustfmt.toml
+++ b/rust/rustfmt.toml
@@ -4,4 +4,4 @@ format_code_in_doc_comments = true
 format_strings = true
 imports_granularity = "Crate"
 group_imports = "StdExternalCrate"
-wrap_comments = true
+wrap_comments = false
-- 
2.53.0


