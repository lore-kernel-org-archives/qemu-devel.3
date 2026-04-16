Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC93CF8E48C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVzC-0002YH-Sw; Thu, 16 Apr 2026 19:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVzA-0002Xb-NK
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:19:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVz8-0006VB-Rw
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:19:00 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GKp6iO219273
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pYM1/6v7hes
 K5W+SWbDHmSUEZ56rMQ5zmbHRTFHT/uk=; b=EDVguYr9AHoeZjsPRMJkh/k47gQ
 5ld8iHcK1JdHTFgylr15nAV7KF4aFApdYsxMGmHLSP4Po2eX63ej44puqmeGZ33z
 rpCP9VG50XZxaGD+s1aq2xvZG1+JBCRVQTKJkloe5MqgF+VZi7b5JlznxChUcSth
 JK5neEzKPOal587C4ZqBQXEUzZU4pDofA9I5Korie8emYY/SmUZpn7HJycx7Yx8s
 Z6K8GwQ8dm+fe0QVfKAdWImVGbmRQePtuJpXdULs0AnulNNJ3v+8qy2+h6zl9shT
 YLE82uV1+P+3h9TffEafgqQtcti+oTaZFGvFhbf2Kd0gV2hmI+MRh8yvGTA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtuykc0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:18:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2ec948174so572535ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776381536; x=1776986336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYM1/6v7hesK5W+SWbDHmSUEZ56rMQ5zmbHRTFHT/uk=;
 b=aVNCoInhPqDuEJviyiOoFyGTbDtFT8Wx8fZc8TwQP9z043TlSmLF/rqL9mczf0coF5
 qgPoTUlA2p3hZ/F4wRpH5+OUE8S2NyxAo4/cwCz2NV327EO40onnBonUDolL5rNLJrbs
 C8GnWSp3K3DBlTdo1UJsytzft/Bs6MN2DpY6Vyj8sRS7I4te2hi7632bO0jDpsMVcWQE
 0+O/c8QuVDkdb8yEVFDiudqPJJExZLp50KKMmOrlpj36DV5u9U0RQbIUAJ3GD2tAdOBJ
 q5ECZy12aifqdrpRJ3GAuDFqiZFEQhKZSE7307lDM4QISrx8XZS1H3F86ph23C3OJ+OL
 uUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776381536; x=1776986336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pYM1/6v7hesK5W+SWbDHmSUEZ56rMQ5zmbHRTFHT/uk=;
 b=Fend2u7ASAsmSAMUzeOlFP+k9XJdx9cRilAzG4zQMcLg0nGatBocUjLoH8EGtMWOmT
 6sKCsJYQmxy+biKdWUrkztrN3fgYfSDSIwZ0otK1wxjE+wc8fubBzI4Z5xBLZNrFDPFp
 Z04g88BIKyZeU9bnV/lRRHrcihy6fogRg8l9PN7CRH3v/k7h4qAdHWy6RLPx2PzEJIXG
 ThLnrsNJe/mS9Dr4kRZ3X+0YRPNjteYNxwcsNqa5mhNr3z7dQHFhn77ZmddNwX2zCoc3
 OnOsYekPY0wtOz/uV0dWVIxfsr6lH3B4xlI0L8iXYAH9S+/K/ZJSmtwHTQXgmPP3VxrI
 jncg==
X-Gm-Message-State: AOJu0Yz3ELOUkOqYVK4FleaLh7fBraTzTrkIDT0RMGpcdGisANFAfEo1
 MnFHsmFkahbzTg0wfrZI2qBs2Y4GxScZSE+wwM3YbOL8OAhRrpMuUjH7tv3iFiK2vpxZyPe8kin
 m+PFiyRw3wrYVtY1ByxMnGoiI+lXngEsgCmGsOxk92VGY8ToMzcfgx9EwHeEApvsZCg==
X-Gm-Gg: AeBDiev3RCGjnEZKEqA6xmInAu2nnc8u1erw0ZbaRQc23sRuX4zhq1jCuVsmd4VTmjN
 CfM3Bwhe6Ia/a+AMQ6oxM6g+9JXLjTy8gn8799FTmNywoHxlodxzlVFjP+1rMGIuWls7SEcee5l
 GOulITlT0BG8ogp2gUC6s6MMS98G7DTSfXzGqVP82buw77IvpVE5Wfx2NVdTQcu0JcehC2N7NjO
 zUuxf1+s8W4qTajs7Orq6CduT/3r9tYiCWlrofcIPYalzyDAhvWnEOnVAb9UbhMR25S/UYAKlCJ
 RUf4m2wf6ez/fUaLGnaXHYSnzhfasC+Iz7Ne0FIOUN+dsKT9KekufFyDsVgHM9FRMP+6BlX03Tx
 9oVXfD3W0D7l2Uiy+X6F5Lipho1A55c0oL83CdeU/NM+evENC3xjTFjqYmjyo+JhyZx/IZpi3dA
 d3so7goQuBTAYKkiP4iA==
X-Received: by 2002:a17:903:1b30:b0:2b4:586d:2e5c with SMTP id
 d9443c01a7336-2b5f9ecbaa1mr3613165ad.2.1776381536506; 
 Thu, 16 Apr 2026 16:18:56 -0700 (PDT)
X-Received: by 2002:a17:903:1b30:b0:2b4:586d:2e5c with SMTP id
 d9443c01a7336-2b5f9ecbaa1mr3612885ad.2.1776381536054; 
 Thu, 16 Apr 2026 16:18:56 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa59dda1sm800485ad.58.2026.04.16.16.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 16:18:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/2] MAINTAINERS: add new reviewer for Hexagon target
Date: Thu, 16 Apr 2026 16:18:24 -0700
Message-ID: <20260416231824.349872-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416231824.349872-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260416231824.349872-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIyMSBTYWx0ZWRfXx6USWBcliK1T
 Tb8eNir3h8ZvKQJgSMd5rSxRUIAT6ltiUILGMaO0RCYWnjmx6MmoTrbdvssi61j2TI5kLb6ed5M
 2qhLnAoJq1T2KL3ltgSmW1KmqhvWr6VFXOQPFi3N8KH2DHN2wHcAtrMWtSVUxdsgA+CPGig0/Xz
 OT6WBVEpfU4ce9+4F4inVXEPLN72hEvPsielIFLBHYB3g5oBzr0uDzm+rrp+8Ji0WQGFSa6InbK
 37ETzMlrfYRPR3YzduMkN7o6WPN0UccsdoUewEDPY1Wt+DBN2J94IGOmZKZFRQROTQVyCbuIQ6w
 fjJiaVTs8P6goIDLdT4+ZhoCwr4mcAANdyLUfPZy66FwY3d3JvmC6HQm2XHprzGyp9u/bvHx3fl
 xP6sY6RdxddRK92rTtwnAfizgoUHFP/dHHcAQKC0MybWZDO0Us2B6JqqQh/Lo/F47pS2qPJKgK4
 AY7fKEt6R8fkUT8IAnw==
X-Proofpoint-ORIG-GUID: NLFHaw0pAVx0oBZalgLnaUC3YAFbOS1-
X-Authority-Analysis: v=2.4 cv=Ipgutr/g c=1 sm=1 tr=0 ts=69e16e61 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0UKPhwNxwtL2ElhdusUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: NLFHaw0pAVx0oBZalgLnaUC3YAFbOS1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160221
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260416231455.346504-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14bd822ddbe..0a90204ae93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -244,6 +244,7 @@ F: tests/functional/avr/
 
 Hexagon TCG CPUs
 M: Brian Cain <brian.cain@oss.qualcomm.com>
+R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Supported
 F: target/hexagon/
 X: target/hexagon/idef-parser/
-- 
2.47.3


