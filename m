Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13C0C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu80L-0006gp-1V; Wed, 12 Aug 2026 08:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu808-0006Zg-PM
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu806-0001mI-GU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB48Is3319895
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pte7PXi9rfPSck3gExkYCTKXjVhMybGFWn5OGeUoYwo=; b=IAWuPGHbwbBjxA5l
 /m2vV8rmsVnc/RO5LmoyLSWVrL1tNQF0VSXWqCrJKReV/yO8DUvFf6Hg9Bm2OeiS
 krSCPtGzwjpSvI+UOa7JYszjuGZA+CF7DNsoilnXy3tctPbPq4NQS8WDQUkmj6YZ
 BNBxjFLjiGUFPikyeXl0batGS5jGwbEgwCJR/CRBLDvwHpsvyjE20vHqenSJgY7z
 Rs2OU8ZJDoKVpsEUmfT5P5xrVnzi414iARoj2JPHt/JW7WS5kCV2CMpF4Tmk/WNA
 XLiQB7FCxiArSE4PcHCwuDOQhS64xaf/gZrqCVEtUo93HqiBmWg+2Lx0O1MHUo+8
 DS8u3Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmyrgmc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5276aa86d00so10205711cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537444; x=1787142244; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pte7PXi9rfPSck3gExkYCTKXjVhMybGFWn5OGeUoYwo=;
 b=Z18WTaI2CG/qhsjnrQEqNr68IrpJfy3hhO7lUO3Xz2KT9SYhes9+GnTMrexwYtbIGc
 Tm6iIIIzMQ6ZedF/5woB7Iv82Pg9Al9HivQFO2YyBaVXRZODF85GwPH9kMVhMbXDMrbe
 seAMHItEO0ipX69C1qwfcy2M7vXACkl0IgG2RjpGWR/ud45SwIrPEtpAZN05aPLdVE50
 0D6Cb6UvtmoNIQaAZoQINtSLKi4mQDH1KhnHfhGUfikNK5mrGucrvbmI3E624KCfKi4z
 sJBiOhiIAaJFZCfIwp/OI8ue3dOfVTpy+PW47ScaaH7xitUh7vOeUPx5mlCbZuNaTDCn
 Ullw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537444; x=1787142244;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pte7PXi9rfPSck3gExkYCTKXjVhMybGFWn5OGeUoYwo=;
 b=NcvCWe6G9F6w0jv2mcZpWcWPbOLjoB3cNkqVLDiwSaqLTVdShy+TBI7gcReD0vUBBJ
 sMyisyzQYZhFi/Gx4m0jYiJbLkxy51Ylq1GAjrw4c6W5FipL7D2vQRr7yK067x0PKGMJ
 js8xLBaujCGfIcPGZ9GQmI8t5FF/HL1dK6q3FWiInAfmZk3IWuuX43CKxM4QhOZTpF16
 ZCRlMIT7vz8N6g8Ed7834OA9tdCB+GnpsdC9RYNjTDAj23j7sOnkeZBvo1oJzoj/EcS1
 x8BmMx5SVDhNvy6Nl+0jlQCF7e6ilLgQIdegWltBAlIfrEN7CKdKi4+041WYb356gNgq
 JDqQ==
X-Gm-Message-State: AOJu0Yx28KuLCNXEujA3IpoVq5tF+OvgzNr9EDnCIjDhRxwRLGWI5yAA
 hdOSi1VOy/9M8xR8tGyaAHvkRFEOLHmV2oEzgnvOVtyVZYYBtRi6494SN3AFXQTnAmBzaBt3UYE
 iDIHm4Fh5FUWdXCk+2biW8Z7EYA3mcqjREn+7P966cvXLMKvvRtIJ+4YL8E4YHfPh1g==
X-Gm-Gg: AR+sD12RlumB9Z6Diqsv4bFZsRUY4HIxwMYs7JLibpqqKQYXTCJ8SLTiLmm88FQ43tt
 YEo/wzxMmhbStykXle2pe4yx3eyXm8f22OAwS3D7dej5OiPai94SNcZyAJFvnO41bEl+Dh2L5Tz
 3enQXa/xGk21/6U93mj5yS4SZTcpFtU1lTzI80CVvLNgdhD7RXH7zsn3GNpEnx3Bqy8QRnyRYNV
 81WI7CvIMlwJku2b6zscQRouV6W2fuHBArmnLdbLez1djpW+DF1ppgLVrYg6bu12fUxVzBUqH5J
 OfOpbVgbY+OYEw6bzjhPVr48EOqUTvmI6uhIwF+VF2pv0Q5dbK31cfxI3oYnPQDu55K59YkmuuF
 niolMcMZyZ2earpGdLX6NDdMNc5U=
X-Received: by 2002:ac8:6f09:0:b0:51c:f8f:13d with SMTP id
 d75a77b69052e-52d648565d6mr38321451cf.37.1786537443609; 
 Wed, 12 Aug 2026 05:24:03 -0700 (PDT)
X-Received: by 2002:ac8:6f09:0:b0:51c:f8f:13d with SMTP id
 d75a77b69052e-52d648565d6mr38320991cf.37.1786537443216; 
 Wed, 12 Aug 2026 05:24:03 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf7774sm7381024f8f.2.2026.08.12.05.24.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:24:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 04/14] qapi/qmp-registry: Remove unnecessary
 'monitor/monitor.h' header
Date: Wed, 12 Aug 2026 14:23:21 +0200
Message-ID: <20260812122332.72975-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXxYKBxlNquND1
 DTEYJPSINIoOMPG5BSykaep5XsIS0uQJli/idPG8iKZnjXgceAGMANHcauX7HYudLklVLYsoQcb
 EzElxGSaE5E3AZwA0q1+JZxEkpTdqmQ=
X-Proofpoint-ORIG-GUID: NcXSiDT7a8zwbUlscb6aNGuYio9p5Bde
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c65e4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pyR_pgRpKyPxIfy4wdgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: NcXSiDT7a8zwbUlscb6aNGuYio9p5Bde
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX89AG7X87aroz
 rT4ISLWJGCF8KXJI694rwzEszV1L+W3O9yg2MwwkOYiFV300ECQUsgBMhv7qCz9ihOS2dWKawoQ
 fvXD7H7YYmHbt8OJ4E9EhsEnNuOhQ8CXCdkslHqT035pLQHxIO6joB69ZFesUDSgR9HYmIN/0xt
 Q8orx/WrgaI/FTBM2FpvdNKNTzlP487Wh5c6P2FeKWDwS6o0hss5Z/r71chqnog/0EL/DXC/wzN
 6nwinUvmyqxIbaISJeVY4v5r6iC+CYkvHKtqsqyzAWJxXRs8sbjYR/08I3CRL6iCHAbT7tEzQxr
 HlrohH0VT2EjGEVtrQZrfQDawNzRQW/DcPAwr3EKYxYiaaLyRj6GF+BRRJxP23xTJVFXtYxcylJ
 iAIj/qohPltj21IrdXoWtb1mH1xOPo/BNsOo4NvOVkJHAWVLWsrGAIC3m/wTSJ17oPNxwMyUSWH
 aczXYISATkjtJvcFscQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/qapi/qmp-registry.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qapi/qmp-registry.h b/include/qapi/qmp-registry.h
index e0ee1ad3ac6..6146306a3a1 100644
--- a/include/qapi/qmp-registry.h
+++ b/include/qapi/qmp-registry.h
@@ -14,7 +14,6 @@
 #ifndef QAPI_QMP_DISPATCH_H
 #define QAPI_QMP_DISPATCH_H
 
-#include "monitor/monitor.h"
 #include "qemu/queue.h"
 
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
-- 
2.53.0


