Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6D606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HzTjWeT5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IW4NXTPy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuv6-00047E-0X; Mon, 19 Oct 2026 17:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutX-0002ub-LS
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutT-0006Jp-OC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:46 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKMdn2158065
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OWoiPBB6D8MvQVM0fAQFiu+kEOSNUiCRREKlvCubkOU=; b=HzTjWeT5QG74YQ1Z
 mNfqA5gUJN71q8Uf1JMiEm45Wp5agt4wtdCRjUpWdJ6PiSiVQFqc4hK9nB8fH1k2
 ND/CLYLMKbAX+ZxSga+t5vGZbjOdjpf55yqLoz7dS3iBFPacExWmhbFRMAZtHgPh
 lSb/SgJfL0N0JdUrgr2XvIIwnWYdorMC5MDR/nYA5JSgGu0z4zoRYOEPMtAy0T2b
 9H6oGXo8HxGXuEYdDRn6V+PDOwOtrRT/GnOm/0rNHvll6CbDjlEsdZMJZOyFC92x
 zIo9w/gGlKTZi78i4tiUU1b03z7JrIS7XkrdvtAqji5M2BXYED4tZBfztU/5bOIX
 Sbmoag==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65kb4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so83875a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445232; x=1793050032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OWoiPBB6D8MvQVM0fAQFiu+kEOSNUiCRREKlvCubkOU=;
 b=IW4NXTPyBUWIo9IueA5DWwvjKZphjGWMPdWseP590O37+4QqG8/jKjpqDuZMIMyXnN
 fPRkqIxoxwibc2RZcXsAkMZCHlMo3wdMURgQzEM/4PPehySvr3Sda+iDvxKojysiH3MA
 KoXFa/U1VEnz7EQPmsYSRTKdu7cyY2lDlHLfFyQT1tgONiNgBX+8eEAEVw1lvYkPatil
 gnonDc7zbGskiwufhFrNNCFB0pCmLOkwAbfPCBC+XeGi400Xbga9qMqoeuPhiGIwzUNx
 juRkR4XqHkZbamI1uG+mSUgf50Vop0WkzqI9lvpgzyReTKtbgJ0xQKS9xjOoqkH0X2hX
 RC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445232; x=1793050032;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OWoiPBB6D8MvQVM0fAQFiu+kEOSNUiCRREKlvCubkOU=;
 b=hXWFQoJLkXEvyajTvSJ0KuSgEWEykSETy1IA65D2yfYKBN4wauJ05X9s1SIbSeUap8
 eS2nVhYRfMBxuwRpSUwvek3BITI21y/6m4tkoVDRXwXwc2FTF+DkU6A6SunkEWLyZAqi
 Xl85VwbynhJaaZyXbu7dDvr6hSvoHLGYb5FQrkKLSllinmy+DDiwMekAPjkqsAIySYzt
 QuNoQFyIXLgyaN89PUUYlcNjeV9sXmmqj7MhskV3bDz4Q8i/sR38ugeav7Lsft0O7HG7
 /84/kcGNNN5NxKMGFbW44i1pwtZgoSJRe/Mm1SlSgRVFn6iQoj6Z95RaY5ZH9c4FT8RQ
 RmmQ==
X-Gm-Message-State: AFq9FYKI/RmyiAS+TgeEVq36SiAHwwoX4Kuv2MCPB8S9vV2QXgaUQTe3
 06oTECZAK8AxJS/xHl4GM87o5GzwoSiitYooaswgVPYpfAX9rWENcWbodRosqAuzJoGZR5+a7+I
 UZ+SsX+ZUe+Hvo611JLUHhOFx4tlvIrApaot4pMZmpZCKT1laLKWSeciCi3wCgKMzUA==
X-Gm-Gg: AYBFou1RFlC3xWz73bHDQKcUrul7zrj9mBFvgPTfpl35kuCmXxj6mRKmH4mXBuwvFj3
 zF43J7IXAHz0Omk0/kDLkNWYcMSmHDRUHn6qrI+ukvfw0QlEX/EJvaQwcm8d0mh3Yrr8hYBrmZv
 rdbUiRzAyEYzKA2bLDjxjm6X8E9sbww/hmH03ru0rlk0Ju1TKPVOI7SgRQHsRKYEAegKnjfLsOw
 hVvr03qfC/b8RfFuklg3Jbr9PQdiwDRh5QbchgMYW4FwO+FgXVHZAOhvE02GBnb+8kSSDP1y6mm
 1JHZ6ngKEP/435Q+l4dcN5hLq99xOmDO5iKOYzi0xGAcQxmtp8Ng/1Z8rXR+/HDDpHuKc/J+vN+
 PHquJaYy4CJfakj5VtLAhhApJ8H6aGm+fTP/lUUkdyXMvr9UbU2vmf2PL+Gnc/zA=
X-Received: by 2002:a17:90b:57e6:b0:3a4:7195:ecba with SMTP id
 98e67ed59e1d1-3ad64bb55b6mr173055a91.20.1792445231659; 
 Mon, 19 Oct 2026 14:27:11 -0700 (PDT)
X-Received: by 2002:a17:90b:57e6:b0:3a4:7195:ecba with SMTP id
 98e67ed59e1d1-3ad64bb55b6mr173042a91.20.1792445231258; 
 Mon, 19 Oct 2026 14:27:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 08/21] target/ppc/cpu: constify cpu parameter for
 ppc_interrupts_little_endian
Date: Mon, 19 Oct 2026 21:26:35 +0000
Message-ID: <20261019212648.154493-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX1xtkRWsBLP7f
 5S1JIQ4Lqci2+BO4S1cON9LcTz76glBGvDd+HkDJ+GWFME6x0/eK5WTABBcPIaLwRiqhEVx6A5w
 Es5K4H20Zy+i9MuJtQ4wpxt10IIxYu4=
X-Proofpoint-ORIG-GUID: 3FGH5d-AFqVRyne-5hVd3nlMpavTI0cl
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad68b30 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KOFfYGMdUDr6h6J8HrYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX2HkLGcpbqeUA
 O1TkZinXnHJvwyh4/cQzS3wvZ+VKl67gnkkaIM86ulhyJYnjLpnELr/7gaiJuk1/UApooi5esfw
 4frdtZRpZZiMfRoGmqu0VG7uP4O78/xgleTGyOI9k6AGQ4MAsKtVPIZy9SzF+QAgc/VGqRk6Sj9
 gcC+X5OuG7sIzuscICrAQxMAStCiHadJlu/MGfMOkBqiCmSYOcOWT/cQR6yPLyDd9gSIZVYYMDt
 DFzCknu/H/nOh2dGJDkEu0tAUhCVTcHTQQnhkCMF1PJwGohqIpxSKYExMnwiSOyqH1uhFoMwM7u
 SAEHalDomAjH65te958tFZBGKJSle1o5DtT/NVMwPJw0vLvAPWYRJ8KFxY1+aeGpAjkoI1opuRJ
 4b2CeH67f5lZGiS4swJ4NBDX73hLxuU1/0h5RO0ie8c+FwyDEHEItzzAOz089A7Am35gboyqlYx
 NLAjJxLq+O0s/kA3Bsw==
X-Proofpoint-GUID: 3FGH5d-AFqVRyne-5hVd3nlMpavTI0cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb82..fbffc9b3005 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3048,10 +3048,10 @@ static inline bool ppc_has_spr(PowerPCCPU *cpu, int spr)
 
 #if !defined(CONFIG_USER_ONLY)
 /* Sort out endianness of interrupt. Depends on the CPU, HV mode, etc. */
-static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
+static inline bool ppc_interrupts_little_endian(const PowerPCCPU *cpu, bool hv)
 {
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env = &cpu->env;
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const CPUPPCState *env = &cpu->env;
     bool ile;
 
     if (hv && env->has_hv_mode) {
-- 
2.43.0


