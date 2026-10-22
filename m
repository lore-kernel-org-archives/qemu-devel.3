Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A52F606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oY9pfi6Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PWMLgEK/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0jT-0002G0-0X; Thu, 22 Oct 2026 17:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jO-00027T-9w
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jM-0007fa-8d
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:49 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MILFhu115915
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gFa1j0FVTurSAr4GjRlslaauLrC+JTL+U4mF3CZYSHM=; b=oY9pfi6Q00fgij3Q
 rcA126rfTHvFnNpg+/mcYT2LebtxZbQwEcg8fVqQAbEPUHaERvAHtyOTn7PM8++Q
 YrFKxOSeLqXHAhy3q2BkD5JlwMXXQo/AQsbiTqAmvk06almIQ9nqkPQSJoDHdAkT
 D+NXQMJkG7rmCyPq5uAjMXuHmoUXG8YVPUGBFVoNnK/6k3bl8qYsYOx5S7h0MF4H
 UmNYqoVMXVJNbs7MCsG4p7y717FvrIrajf5GcHT2wqdMBlz4Jeq6l52gsNwiNLSL
 xbhFPyY7DyzpQI0pvkjgVR+qwkHUl0YNYoTwtL6z4nghyN6UOXsL9O5ZhbRCu1eq
 ycqiTg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahs43d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f6f4fe531so47114585a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706027; x=1793310827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gFa1j0FVTurSAr4GjRlslaauLrC+JTL+U4mF3CZYSHM=;
 b=PWMLgEK/y3xy7nKE6ClaPjdS914rByyVt3wxTz6wjFpaJxg75CzXEv2dZNq5wB/f7u
 p1AhxT5Nl0nq0bFDbolFKrileAJongSE+G3Tq70j6UDmXou72j0J3UD2eGt9GhVIyG4H
 TTaWMHzH5m7iKhyTQj8nEuSSssnxPh8iTpuCqMByIw//1q3F/dlJc8B4GMEUUJcMkNVs
 nepidae8Ax8Mj6RU6s/9RCKWmJ/c7SDFmGM4HqRPBizHQ7XbV6Pv1otx0kFYmAwOQPHM
 3fbdne5YVAGB4uJbptSW3LbFg6ZqJFk97rglE0V7vUdmALadWJy1iIAZUjEwMen6V9IW
 Y8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706027; x=1793310827;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gFa1j0FVTurSAr4GjRlslaauLrC+JTL+U4mF3CZYSHM=;
 b=uHa3kLcg5G3S9np8eIu7iXAbkhCmbQgK16McETq3++8HE5BhhbY38xNFKZ3ATXgK1n
 FFL4R+1mYynCGIP1/p+BdJlbo/MGRKWuuenXnLlqI+/it7uQf6QKTYYNI43dA9bksrtQ
 FymFGXHM/y4CWchgyizdMi/cDGu2ISpL+81lWsWtj8IsIXWrnabSJR6Vrv5xhSYL5neQ
 Q67d4vOTOWAvtlPnSCfHInrwpYYNCNdx/eqs1g3JEPLtmwrZVQeFmE9JbpvjIBNoIZOc
 guif3XR15twk5mTlbtvbzaFTO0d8qeXiExK12e76lNwlwxUf9Of7mXyDQeJ4Yhsbg2Lh
 3slg==
X-Gm-Message-State: AFq9FYJuTI/Lpx9Hnt0UJTA0Dxcvzo88f1sOqWGEUGEgx7XV9HU00pOz
 yy1uq7BPjHaLbaOfncugvdUN5+QTsEey7tjJFSz7WX0qGVuAscM+RrxOfTFtaImMRmZgUYtfKgI
 djuEWI349lZ6H3N3ApDW8wb/6zeL6kR49ohrGralDaxQQ0oOWjufgYX09nmdHRH6jiw==
X-Gm-Gg: AYBFou2+r4gGcZhNW/89gfZD8iu08SRxkX5c2qgzWCpIAmmfefCaYl5OWfMVs4qWSAK
 DJqaR7alaTNqefdBr/LImOFRQjahD2jl0E+K+df+oX7/LHZ3O3XVlh72WC1voVcbLn8fHVdHyiP
 Ld/+kqnYi6vaVDMwYXXrGdRLsdUQVdrfVnLbphKFfxfxyp5Qoa7kLoH7se31fM3XAZN4S08Ut9T
 SPHXAZbV4Dmo8ECAB04nRGs8wTA6T23BQEvcdjS4b1qgFH7WUAFQPBrBPfbbdKRrcuJQHL+bHYy
 yNhvX7xutSC1o9M2XvX1oSEQqm4urTBxdrnv3kX8frV24NafbHuKKVtuIfN6oAeqAgRc4c0k0z8
 NIQPluSR01qSHPTWkNalgDSnno6Vq0hRsfHUkU9Wv
X-Received: by 2002:a05:620a:46a5:b0:93f:2e7e:c818 with SMTP id
 af79cd13be357-93f6f87a476mr131728285a.59.1792706026770; 
 Thu, 22 Oct 2026 14:53:46 -0700 (PDT)
X-Received: by 2002:a05:620a:46a5:b0:93f:2e7e:c818 with SMTP id
 af79cd13be357-93f6f87a476mr131723585a.59.1792706025870; 
 Thu, 22 Oct 2026 14:53:45 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edd26dsm794859f8f.2.2026.10.22.14.53.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:53:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 20/33] target/ppc: Name the EBB exceptions
Date: Thu, 22 Oct 2026 23:51:00 +0200
Message-ID: <20261022215115.19680-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX6WaI67tWfRuW
 bbWDN3wnpK7NqgZrNkBYBKslD8vJgPWGtU6+dH4PjL3E48F/H22Imv0QbnOWawdtoltDQGYKq1r
 Cm0iL4fa00IsBsfZHxKqrK5EA1Ykm0I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXzLsFwPkiAJEQ
 yPZ1OblwIiBPCfqC96ovmEczxVXvhc8x9ZfUlwCsJu79+3Z6AdkgYcyn7rBnQOtIB03M8vR3Y+F
 6rwNiyeg+yj11LIQERdi6Z6+ZJpjhoSVh6vmhZD1xcxGU5e/bq05Lj0rtXItaHmuTRGEk9ZHAwF
 vHACTBAca4ojeoNO7Ty+5WO5Oh39aVYRkvY4BC5smYR8oFk4BURxegkYjhFVdUUEroufhGIRlji
 VOhDvpDOa/TsjfhAICNP9dxGjAG5Zepscw4yNMLKF2fWghHc2FlmrGO2YqFnLzrLxiM6Gj4YZKW
 YO7sED8W8b8hadwGwcC6x1D+7eDruAbLN7oIP52RaDrWfSms66q9i/8EwLLygVA4vMOa4iyzrf0
 Rdzh52yvPvEwnNqGrGPmhjEtxU4WrB+Usx2oQ0o+/GysyI534BtmJhQds4fEb8qZsmK3ijFZTHs
 4TMjj5S+gDhRVWJmjRg==
X-Proofpoint-GUID: DpoWz_4mgjXjz5xxRAL60g4EBp2WjrpG
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6ada85eb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=Ni8MKOl5piV74ivutUIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: DpoWz_4mgjXjz5xxRAL60g4EBp2WjrpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

POWERPC_EXCP_PERFM_EBB and POWERPC_EXCP_EXTERNAL_EBB are raised on
POWER8+. With '-d int', powerpc_excp() logs them through
powerpc_excp_name(), which has no entry for them and reaches
g_assert_not_reached(), aborting QEMU. Add their names.

Cc: qemu-stable@nongnu.org
Fixes: cb76bbc43fda ("target/ppc: add PPC_INTERRUPT_EBB and EBB exceptions")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/excp_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 6d05b865058..895127fb2e6 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -100,6 +100,8 @@ static const char *powerpc_excp_name(int excp)
     case POWERPC_EXCP_SDOOR_HV: return "SDOOR_HV";
     case POWERPC_EXCP_HVIRT:    return "HVIRT";
     case POWERPC_EXCP_SYSCALL_VECTORED: return "SYSCALL_VECTORED";
+    case POWERPC_EXCP_PERFM_EBB: return "PERFM_EBB";
+    case POWERPC_EXCP_EXTERNAL_EBB: return "EXTERNAL_EBB";
     default:
         g_assert_not_reached();
     }
-- 
2.55.0


