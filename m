Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D46606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=no8MP4XU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ow8cl40s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nO-0001l4-7i; Thu, 22 Oct 2026 17:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nL-0001je-Dg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nJ-0000FY-13
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKWnH53413285
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CW/quX5P9GR6LzLZTAaMRIxrUWntK5WX5NPjgv0izAE=; b=no8MP4XUyeG1YyOP
 /surN1VtR0i+yPC6/EFqBSQPoxYFVGg1ja8Ft/AdvdzRdTBY1hl3PJJgKPw+cAMn
 nQKaRdASEmqMErgJMY1nn9rgI1vwTCcvqmk1cu/BEa5thkyIT4yyTj1nXqAKEaD8
 6IHiyXEUx3PPLMKo27UvZzMcJ/OUO8ARlIz57rwGyqE48bbBSgKpu3xwvu0VHiPm
 CnIo2hi6Rkldr76M6+Y32GMrriE5TmJCV9Zoyz23H8jGXhQhJzjaOphgQn6POzdi
 p8aNK/Wkac69zSkTjwKqp93fSjOSiYsxmdKsN/NlGaKGhzpUew+FzWN/fhyk5UdA
 B/sZ/Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmar8cs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab67ff8ec3so190816a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706271; x=1793311071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CW/quX5P9GR6LzLZTAaMRIxrUWntK5WX5NPjgv0izAE=;
 b=Ow8cl40sAetNWMAZx1iQgnFmSRI0cMxT5JDODEJhh9k/Hpl1wguIYXZIMudSibehEi
 8WE8HPziS/3TvOtFAzXdpoPLnPJtsh88xiWNAbNsCMPJndTaX4alVgibOMLd+IzN5KIX
 Cnlqlercrs5nWot3Of3NUAQ99L5YGrRT3obUshn+9dZTIA7/+NANzwrTEji3cvdtCobB
 0njz3MgZtR0IGfSCOGmF6Cy1WpEY1SoqrzdgcoD3KC24ZMfIdaVWCPxErYOsZ/ee52cK
 yGMTKh0o6IoTfpJ72OCNpIIPoKrTTXDvC9hUPARBQZJCFIN0EI3+d4XxSvMezqU+QmTS
 evLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706271; x=1793311071;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CW/quX5P9GR6LzLZTAaMRIxrUWntK5WX5NPjgv0izAE=;
 b=HMxYHzyO8S1FMT+fDK2jC+3hux0lx+4Fq54QVVzHwrp93v4RMcCkOSoS+l4NWGqK0V
 ZDJIzxIv3XjAZC4lcO4OzzghaZTz517SWLvxkqM50t0y5pzkibqWWt98hVFGZmFjLH0b
 5JMRsxSg3eWLjbsP7vZkIyWeTg5c2Tm+ZAlR4umfbZjPKpgNOVnZPP8GYy58LLnfk/Mk
 hzzLaCsp8wLhyHoBDzywtQSbk4zAv5JP2Hp7JQFkgCIBwFa0JQtMpKd9fJ1CFgDX6Pzv
 V8Uk9K5jVUOtskUoCNcZbsZi8yqb4DAirGNTOgIvpT8+Y9QXi27wIlTWmEGBYf8QdqKe
 RRgg==
X-Gm-Message-State: AFq9FYLHptPCJkTjEb50F+99JtjypqRkY1HATHs4rysZ2b4kCjvfyy1V
 KJ9puhJutyn8rXi73Y2OViF6VbxPhoysZ9pT4XH9uoNHi96Fbv+l3qRyDrDysymNiydLsEHqwix
 k1En17hgNLquuoXTSNzc0vu5KRdfC89vkkHFJqSqobyrQu9Uo6nS7Xdqk6cCZIGgP+A==
X-Gm-Gg: AYBFou0+QkcrXxjeE5wDXOdReUV6Ol/U8bi3/xZQVb1NMugvPjmTp8Z/RHmDINblT/A
 jmN2o5rIuLGgM9aFeV3O5Q+4fUOONLN4LRa6WqkcsHJaDQsMTucnm745X3TCsyMcxUy/VoyrfAO
 bdJ5iHQZOmwQHnApm+lSz18CTWI+fLVtMNDebKxFmi/kMlcx0psG2uMj9GeR7T40fY69G1h0aam
 +9/JRsydJ75exdbWfh2R0AtvvpGRNHRo9Vjlr3GWCMab+UvDgW26ajSkMwskf2bo5sGalnnTCpF
 n5I1igszlNO03vdceFumF6Mdqzp7lvQ90DF71TuJrLgp+CImQTBfpHMmrcNfXwthBLuvRwNQcNR
 JxOChQgXL4OE9JW1CxzmHu7a3yG4evQqPwMzC5rVi1fQSykPy0b1Gne1BmqO21hk=
X-Received: by 2002:a17:90b:3810:b0:3ac:80dc:f40a with SMTP id
 98e67ed59e1d1-3adce5ebc38mr132859a91.16.1792706270906; 
 Thu, 22 Oct 2026 14:57:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3810:b0:3ac:80dc:f40a with SMTP id
 98e67ed59e1d1-3adce5ebc38mr132847a91.16.1792706270413; 
 Thu, 22 Oct 2026 14:57:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 02/27] dump/dump: do not dump machine if doing heterogeneous
 emulation
Date: Thu, 22 Oct 2026 14:57:21 -0700
Message-ID: <20261022215747.2479440-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6ada86df cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=3q1FPIo8JGfx5WVhvewA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX4+Rv02AJ9jvE
 dGGzX2eDHuf3DBJL2sXDZrgU9VlpYOOuEaBRu+DmtMJZKiMbzkFxJGf9mGVL1kLJedB1ulAZbR9
 qPH0suPG82JdlPolE1I6xc/XXYQDtPc=
X-Proofpoint-GUID: ayFSVX_Xd__CAvrLsVKRZJJ4Lry4fQDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX/2Rwx9rIj7E4
 MfOnqLT3ZMDrn5ForUmA/W4O6MMnWGgFcl4G8wMUo9p/IzCquTooUb7+suIyeYoR3Dyz+pgLgyG
 /8rJK8t6zu1DFgNNJy3vZiNQ8S3muFvhWLf0JF7GtB2isSIvEL4ynCXJ/cxzHCqnVBYVZs83XuT
 6c1nkMxNd6zaFsGE1ZLq1LP5HJKUKrSQpOw2v7on00W9acIuUBzzCfsQMMGvogNhLTyZP8Rh8xu
 pMZPM1WWeXZve6tPN+R69DE65DO0CE0q4xlwhDgxbzgRQyH/26F9LODi7sSc0+b+BMZvc0lzfe7
 tAMr7yFkG8Ly9aOKl1vftQsgBBZgCyxZ/S5pqCnyRYs/lL2YWHmmiFZNsAcZ4OA1C+DYKYh2Dof
 AiErpt8E9vogjdoem+1aqB0y/eR8CyK2JMYhjVc7EfufB88DO0laJO/jRjnyxHDIGKjQ5/5CWG8
 BPx9oY6LdEHk3d88Ruw==
X-Proofpoint-ORIG-GUID: ayFSVX_Xd__CAvrLsVKRZJJ4Lry4fQDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This would need some refactoring to do it correctly over all targets
involved. For now, simply prevent this from happening.

We do the check at beginning of function, so no need to call cleanup
routine.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dump/dump.c b/dump/dump.c
index 52be7258a5d..0ecff682dd4 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1795,6 +1795,12 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     int nr_cpus;
     int ret;
 
+    if (target_heterogeneous()) {
+        error_setg(errp,
+                   "dumping guest memory is not supported for heterogeneous emulation");
+        return;
+    }
+
     s->has_format = has_format;
     s->format = format;
     s->written_size = 0;
-- 
2.47.3


