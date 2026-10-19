Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC318606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=leErxx5U;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y265e0+r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIutZ-0002uD-Bo; Mon, 19 Oct 2026 17:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutE-0002kc-G0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIusw-0006JC-1i
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK2K04106511
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r3da0aJpL/HZar3WMcRkX3q3n18zzhn7na6LrCubg6E=; b=leErxx5U0po2krJ2
 gCfJQAea0e2zJXTUknplFdk6LxpLCKOgNf9EchhqcixjpYVL7vxxziQhE72bdyWJ
 cMRiNWJmyva7w6d/nzpOhVK6PHa7fBlkDg4s5z1+sCwmcOENaJax+UqFus00G2fj
 ZnU9N5ez5so81zu1l8LJYSvx6tRNPRsk4yhPCDvW5NNmDmtgG1iuM/c0wfQgfM7J
 zEv+zARRfmx6E8c7gciwcz6VU1UTXx0ZEPvQT6wt/3nOPLtqvq1gHZuffk8pNEg0
 w0E1QlO86KWOyFRziEdiEPl7EGTogldq+uSLbl09Amt616ISa40LJFz5W5GMqD7L
 Lku7ow==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr780pc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd68bf391e1so842917a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445228; x=1793050028; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r3da0aJpL/HZar3WMcRkX3q3n18zzhn7na6LrCubg6E=;
 b=Y265e0+r6lEDdW5ZpwfN+E6LtK0sq/YkbnTM77Q2t4eRchStTymxgaKTrVQFhzbocN
 Fnkid/oaZDfRtLg8GqAq5T0D1xNPFYZzjZccVKwodMRAIR0BKvP7yMQZTcF9D2jLa9x+
 g5q/sMaZAzMLmMtVz37OETmT67KKi/ZMQL5/X/yZYD+T+RRTKI1aO1x5iHWsR/4Uf6hL
 glR/aSquLaFquKllpn/KXE50k4K+Mh78eIDCuuwtnEchFTlDbk8Wn286KcrIdsAPnL7x
 w775Zfvej3T+mmgHNtch2F1zX2pnXro0QzjEvUOpHVHeaSVFIlzQ3D44hN8pAJykc8cx
 llZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445228; x=1793050028;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r3da0aJpL/HZar3WMcRkX3q3n18zzhn7na6LrCubg6E=;
 b=THNBOe1rZ2YiaFN3+7UjF/kUnC3JUyPexzcKgsbYnBquHlVB7o613NYv1S6yDTqNcG
 I5uLxof+uvXhBd2+d8dJXvEQeJqcP3pSGf1zJkYmDSs/5s/7f/L3JDecot2VZCcSNTG4
 yNRuFNrTBI+MldzV+rj7oyoSReB2/TxyESlEDLPux7A8TW3F7I5N1cbhXzKwGpnhz68d
 rH4Jo1/Iu0KfTkbh/inzMA4I4f+VKy8lwQQXSd21EOqjWUIf0nf4lbRkJ6mFFzXNNIkr
 zCMEjzYkiZC0nYHk0Mn1bqZy4tVdmxNMjAYS6jgb5rqApGKf4zetZOLtDxZhSDw8x5Lf
 cjGQ==
X-Gm-Message-State: AFq9FYJleZAvAc79SZ8HXZebVbx/7saD6XrG1WSymtV5Q0V/AuimJRpe
 TRCsOl7KmNv5QLujnI28jQaDVPAWKRTXOx3CK9AxtHDdEecgyeQR96CJobkMakYOkkovIlIVXWN
 HtFOSfIdSDrIJ11vaN3F54tAzrRJyin1Kpaa5KiGRRFFFMPNdGbQCbOGJj1pjHogAwA==
X-Gm-Gg: AYBFou3PD4GWifime+oudSIJMJ5BfmV4OH5N4/a/EQrNhiaGeCL7oBcRE016iM7K905
 +tEbG+YSK1qQArgGrzym9xt8lW4H/O12IVhtmgxZIW05mTKkSnQZpD6TWgqpltrhaIPdzQrwK0j
 +DfTNYo+760KmYK/V076C/a95gXz/e1r0yqeimyAYCFH3Cwx+XTPJ6X5+QOgIOtn8ZQxgtJoA95
 58/sbH1kj1MCZ0GwwWcGcB+TGNpc1o/fh00vy+4tzBgcF2DNBVRRdT0OavqOs2JNhtU26uH8RBh
 4bYzQWwPTnFM1w77JmG8knF+HDo1LEQid6P0E/yf6u8GBN9zNzcG27mu3Z/Kzas6UfkowAvQOla
 W0st7b0zJ9qiMx+sTj0IzJLrHQXA/eD8TebG9aibInjGD0p0mTJDBCFJ0KM4e4/4=
X-Received: by 2002:a17:90a:51c2:b0:3ad:1da4:2ddf with SMTP id
 98e67ed59e1d1-3ad1da42ee7mr2888451a91.51.1792445227961; 
 Mon, 19 Oct 2026 14:27:07 -0700 (PDT)
X-Received: by 2002:a17:90a:51c2:b0:3ad:1da4:2ddf with SMTP id
 98e67ed59e1d1-3ad1da42ee7mr2888443a91.51.1792445227490; 
 Mon, 19 Oct 2026 14:27:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 03/21] include/qemu/typedefs: add ArchDumpInfo
Date: Mon, 19 Oct 2026 21:26:30 +0000
Message-ID: <20261019212648.154493-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXxYYAPqYx5bNA
 rMb0FMZn7/LCV5ZEvu/sjmkvZv1dOjbEDU/94m1OIeE9UnqFwAHb7WkDFIXnl5WL5bfNh8XgBjQ
 CO7UiE0oEMvw5rteXc6nFGd3G4E51Y7Mtzl9B7tnNHSU6cYscDYrVUxt3RY9Fi6+3L/to57d/8w
 +nuXoQzBkqd8R74Z26EMQ1HQUsn8Zh1RL3MSE1WiDOIYkYjltOi+9QzffdBebfNh3GPn862txLz
 Q1GjsF1kz5eJroXD98W+nsEgGDJoWhU0ud4mC1SdmJdWO3vhBp28Fb5EnnZsUJTy4QjasvzWrSr
 JFbRwVJ+3WFH0KRZrYR+AMggk/15QgZW88m4I9M14/SHm8O+Cq4DTvH36yTYxRf8hqWotPjZhMz
 dlgQl1mBacmBbbhGVUuSMMDMAe1TL5IyTs6n/xPSYzpTv+h5evzUBl1mzgiopZhBul2pemMG3R1
 jsJD9JpRV96SQADIbUQ==
X-Proofpoint-GUID: gts6Cv93SBT2JPjrHclF4ojd1eFx8yza
X-Authority-Analysis: v=2.4 cv=LKnz05W9 c=1 sm=1 tr=0 ts=6ad68b2d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=W2Y1RR_n-FKK3RGtT3cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX7xpinW/Lw2Tx
 Qr+1PziS5DOwBIBatjAg0IisGm3QtE1N0CMRT5B0Ow1iGwjQvSJFckh6ayVNWir9n4oaSUBmYvp
 DjYTxIETSAmCS2MUYdZeSvALd0eCEd4=
X-Proofpoint-ORIG-GUID: gts6Cv93SBT2JPjrHclF4ojd1eFx8yza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

This allows to use a forward declaration instead of including
system/dump-arch.h.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/typedefs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 2344c92182e..8fa7f752dac 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -28,6 +28,7 @@ typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
 typedef struct Aml Aml;
 typedef struct ArchCPU ArchCPU;
+typedef struct ArchDumpInfo ArchDumpInfo;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
 typedef struct BlockBackend BlockBackend;
-- 
2.43.0


