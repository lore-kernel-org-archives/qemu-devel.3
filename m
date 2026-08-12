Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D744AC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8on-0006yz-74; Wed, 12 Aug 2026 09:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8l9-0003jb-3C
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8kx-0006UM-Tt
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4R9x3320726
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tzSJvizIBg6YtfGtqY4W6z6sjd8EIOyQn4ckmYQI+Ss=; b=fq16mE+/WYVNy7cl
 N3Jmz1S2VlYO3FhvzevZJamZzlY84eAssjtLfp5cofj+khMpchs0CIH+cNAflI+P
 B7R2BWMtMCgXsquOhpglKoqWqldwBha4mXRn88X1aRo9/QEuYCo+PI0PidMis5sh
 ef8yiBd2TEgJAVC7b97QRJoLszzC4c5l1FUTvNxJ7Do3rkUKszHAHZcuFuQoHrul
 mr7YEAgteFYA8todH9qdWLkFz7S2aI/t6xCUpKgr3dm5n7odFNIwPMAf0J0VgDFq
 +EWZy7WLLXf0slL1GAqsWyZyxunfzrg19iFjAEYT+CPckxDUAa4sJo9frTi1zQjp
 ceimBA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmyrpmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5283df62d68so8113281cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540346; x=1787145146; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tzSJvizIBg6YtfGtqY4W6z6sjd8EIOyQn4ckmYQI+Ss=;
 b=Y5u2SWTvDguSsBbZCaliesDtUCtysD/iZDjHAnOhlGof09AunCOcb5lMusoI6TJKnp
 WMVm5IrxrJriUg6TOoEPHhM6vTaGjsNjKVen6VElp+PEnr/t1MNw/kMlKj8kPJZRyAlS
 Z5gu9gd6TWPuJWPXksFCALrTM2zHraKS1bbkSg8E8fgu/j80FmrMnZZAMBrvRiczUBja
 08INtEeH13Z8Q3Uh5FWXtG8TtOD8bWfLzjF104TFph9JbLbG/X6Cx/AH0DB8wSrOvZDr
 IQYfr7i0VtH1lmvo/dutKLvcE2LnuiptDcxNGJ9v/oVE46OQbwgrBB98JDx+BY7NzElI
 RnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540346; x=1787145146;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tzSJvizIBg6YtfGtqY4W6z6sjd8EIOyQn4ckmYQI+Ss=;
 b=cVr5YYMgM0TQbMCe0HV0VDgsDa6cPHwqYHS97bHHwCFoIX9liWOD1U4sD1VvnXcP/u
 jeewzvoHFwSI+m3SyVpSVB/7G9YmeXMl2rdxjSFSM/x7uckxKZ6Q63VndPBQ6Dvv2FjO
 0ZSYY+8aPBAyZ4z267riYeDp6sxeN6WV6+xjxMr1FQykXAdalmfbZdhl1heTTd6T4NX+
 7CE2fLjDERJ2ksAunApzLDOeXGXlIdXi6p/nTCDHDEoNLKGKo6sbU5Bqlunt0gGFDzUF
 BKfuGK306Fnwnh1Gat1qzyEi7xs3fJJic7wW/Xkjffunh4BmuIDDWnIGcpP+Bgr9Ua4h
 FauA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr10tZNKS+q+WA2vjSpjO8tH1GyT/pW6LThmTTo/oAeQWl2NNtF4B7TsE356Vi4uZkIT9++YLFpsk6K@nongnu.org
X-Gm-Message-State: AOJu0Yy0KWIYP/qLhdoCdRYv+6idnIR083CTbG/faROgQ+UQoL5rPSUH
 nfxVAyf6wkjtQv2HUfbIkWYqdxNvYJAswosovJZWXXl+6p/5niZ3Du+GgGU9yNAuV+BndzUF2AV
 eojiWm5pxZ52QTj4Pd2KB7voxCGYUIy7+IDHjG0kzNOWmyjjQIOA06ly9JQ==
X-Gm-Gg: AR+sD12xXzvR5GKPoIA6ckS0viOqahdp6MuWesXREiMdUvnrUBEvBw5BfPrmQh93D2k
 vn+SK/Kh9DQJSvpsiWt4jk+ZYqf7Xfco+i/pWreROCTZfNOnL9afQq74eZcItZdPYpkIfYzPGug
 er/3hLyr7WfYnMINA3agpV5MJhol0JrFZLRtGm6aSt6/ma9b4/dtP0cnoLc1DT6HHhI+vAIfnuE
 FA3fxwoGUXTc87deeuHE2PuUb7BVJW/VaP+oGCGyd78S/PLyWsn/vRdS4ddElkjRtKp+Ho0Wnhd
 FEGiJalto1Vt12EEsNu433xUWPnigseIKghWkBCJP1rdhpjKXG5WCM5TfGt8L/u4GHzfiQm4ZQ/
 mxAdYbzaOnA8JL99oMhfJEBapwtqfGYzPB1AAVhVvBA==
X-Received: by 2002:a05:622a:106:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-52d646a1e00mr35249361cf.7.1786540346120; 
 Wed, 12 Aug 2026 06:12:26 -0700 (PDT)
X-Received: by 2002:a05:622a:106:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-52d646a1e00mr35248671cf.7.1786540345631; 
 Wed, 12 Aug 2026 06:12:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c93955bsm48889805e9.2.2026.08.12.06.12.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:12:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 05/16] migration/hmp-cmds: Include
 'block/block-global-state.h' header
Date: Wed, 12 Aug 2026 15:11:36 +0200
Message-ID: <20260812131147.83188-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX/xj6TTMcAzUg
 vm3n/0KucXbeXtGACV/4GQXrPbGCCtGkNo+/fDNIDUtDA+SJOil0gPSa88UYleSp2IemTFxBpQj
 HLegoeJXQrv7mvV98QzSYUelHvA89wc=
X-Proofpoint-ORIG-GUID: IjRvkp1cnoMvQyB0uzTp1Qsgx_QDZdHE
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c713b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jqKsQrdABW1tU0UTsM0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: IjRvkp1cnoMvQyB0uzTp1Qsgx_QDZdHE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXxbbiqG5CMCJS
 pMla1diMqCj/ISs1mX1B/q85u/c3wKTdSaUzPOoGPheaW6segiyGy/7+SdyYM69gi0YaX4DvtWR
 Z0KbphWgWy2nBMF1++cWhH1Gcp/s3LKs2APVTMq04g+TMCaylUJbnoNZ9MDghKhOSUCuxtrnqIl
 q2pLP6qnzC+Df5qKOl0zij4IPDP+eoJpGMlS3EBEehzGEc27hRzY/aOc8IeIVxWukiR6Jd/8kCJ
 RVvNVK7+ZQjYNgSyjLO+o+0JsyKkmkpYNcCCTi/BO/YndDMVm43bFhbDbbpjS4+wLQECXvT/wKK
 nhQsLvaOLci3Pji0FOULL0xLpr9NfT/9MXtlq0AdNupLg8c2kFhSu+8Z6Q1f8BR/vZai5ULONgN
 49oacmy/EsNTULdPAXf98ioNrgFvanWn0S5cKjgoz7E+9tts+C0I/+KLzR6qFch6FtImfE11n6D
 j/HJ1XJgMvTjVaxsh7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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

migration-hmp-cmds.c uses types / methods declared in
"block/block-global-state.h".  Include the latter otherwise
we get when refactoring unrelated headers:

  ../migration/migration-hmp-cmds.c:911:5: error: use of undeclared identifier 'BdrvNextIterator'
    911 |     BdrvNextIterator it;
        |     ^
  ../migration/migration-hmp-cmds.c:918:15: error: call to undeclared function 'bdrv_first'
    918 |     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
        |               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 migration/migration-hmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index b04fc4489f4..351512942af 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "block/qapi.h"
+#include "block/block-global-state.h"
 #include "migration/snapshot.h"
 #include "monitor/hmp.h"
 #include "monitor/hmp-completion.h"
-- 
2.53.0


