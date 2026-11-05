Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79411606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dUiDkfUD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A6Y50l0H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOx1z-0008T3-Cl; Thu, 05 Nov 2026 07:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwzP-0004mL-22
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:48 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwzM-0005wF-95
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:46 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tPx21053280
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q1+PZ9TlhscobZjeFY3tiHwZEPcW3uLOVSsV7DZ4XJw=; b=dUiDkfUD4c2ZxmgK
 GZ4m150wadnsTEPZXOQh0XGW+nxDNwPWpaQlsBsfNNILyzfZEWBvHoH064ggUyie
 o5tMncjrFPc7/cFL0iW7KeFAzJUiOj3SVuQw878bWCFqvIb2p8jK/bGevQWo41b6
 f66XITEtga2XBT46AJ1agQh7u+/sX+GFP/qeqhuHDFq7Qzi+YCS0c2kJ8qT32kI+
 3g+lVRRHIAMtGfoQ78/sZ7yPjqLTgLmuQrNwvxsEs7Tweu83KwtzbbJfKmBDoRYD
 XpzTpwxCxEWVBMonDvLrfMpKQYPSTYiDX/yvYwjDmTVghEb3LUnwQxCvAl/nRy01
 DKAaAQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq9f8s79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:54:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb93c874bso127363985a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883272; x=1794488072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q1+PZ9TlhscobZjeFY3tiHwZEPcW3uLOVSsV7DZ4XJw=;
 b=A6Y50l0HIg6l9ORe0aZ0hCOLGb+kg/jfOVOXwg8JxrEree+XqnAoziLkX58L3I/cwk
 oLc3G+5F7Q6afpfZ5JieL7xuyLACAc7jY49VoI2rZXwi87KE/WoJGsd2yWRWlp139QrD
 lZ1kc2FbTec4Seu9qnHPbg8AMBnuk8HWVKna7RW8EvbBEtgkuP8sShGzYjDPU594Fn/m
 3B4hWR7WtzYLEUFI49Klm4ZVbiGX+sZv9eIeAbMyCFq/+LVmuNd3kCUyuoGC+hIYBeWa
 aIxanjaNiBZUQUe5noWMRKgFVvceKZUmAIGJeB6XOOQW83lTJBMEFYnHGSef283SS4Hi
 PJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883272; x=1794488072;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q1+PZ9TlhscobZjeFY3tiHwZEPcW3uLOVSsV7DZ4XJw=;
 b=UagSFryMtUornz5mkKCeeSryxD8melQFpnVy/6KXIcefC0wboK9tZjfMayshSY1sgr
 6L4aZON9k/wZp2D/AU3k5gW0+YsN+SGUWOyFEo5fH2SqNi5Afz/bVLGjr/aOL5Mad89J
 mgc+TQwPMaGpTRXXKeLSHX0ClKFsn06DyOh2P4LIIbNoWEd/0qfg54tB81NXQ/kycGWd
 G7GpAS7HYG9D9mC9BOThk4wCkZveFWnYYZUpzuP6H6QtKKXSJMFUlnH5j6BvH5tQQY87
 SfKzezK0onIVDZdTEeNVe9l9h5or0KHrIkFsWkcmrcwaSsE947IQkrGsoYoadvf52zbL
 oplg==
X-Gm-Message-State: APuU4Z/xyTOzYyPrQPgpqHlSTXzKytMcaQmYopcWwiNILkv7wdScvF7O
 YTmLNGOA+1ODkB447fVhvdMpA3vLQ/OA8RcIGJ4uHXdXfF7A/w8T6rxib53ouEKPO/iF0hK6pDb
 eXAAW2MIbTkLkLi/hWN5p4zX3WuDQC+pTtXuNBoq8D1FcUFDJgO1PUCgM28phrfVpXQ==
X-Gm-Gg: AYBFou2bdH02n7Ywkh9vOZmkpLJlCsNVo1ztQnFVL2jfvOqLKLvOOAor3aL8LsIpLD6
 zSF/5zoj1PZODP2v+CSukcfVDSTwRjagMQfstkRZha2krDezPe9lPFw9qtIO7m904TFVMTkVOTu
 96lmS/HgFPCoN26dlempLrsI+7F8GVRzHDAo4uBm1mNIfIxJbtLr7UKvIBthEy2qCoC0VF730ZN
 3XvGuI5cofbrBcLFAF0EPCiz1skGu2/cDY0RqDr/nXeusMoMLdJXpa098kYwln2yIxtIKzq5+8p
 yaZi83e2+88610SVLhOrv6yYigjzLL45JHxG5000AmZJPzrsfgiBi79xfckeYRNCAK1MjtLcR2H
 OoAlPGF80JcNs5kftyC7qOqkCZyLc5hS3ApGRyudldRoTFVMFN1cFzGVlc1gOoDRUjGbB8EAGZ0
 62cGm+zqZ7FdfvT5pecjL8BeWm/SA+vg==
X-Received: by 2002:a05:620a:6085:b0:93f:22af:ccdc with SMTP id
 af79cd13be357-945e159682fmr374300885a.4.1793883272150; 
 Thu, 05 Nov 2026 04:54:32 -0800 (PST)
X-Received: by 2002:a05:620a:6085:b0:93f:22af:ccdc with SMTP id
 af79cd13be357-945e159682fmr374297985a.4.1793883271704; 
 Thu, 05 Nov 2026 04:54:31 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b577ed823asm754033a12.21.2026.11.05.04.54.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:54:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v2 15/17] target/rx: Replace deprecated sprintf() with
 snprintf()
Date: Thu,  5 Nov 2026 13:52:00 +0100
Message-ID: <20261105125203.40320-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX/SGBhEIXXlSo
 L5JBegXAJJPdKNgAQWAGNcKJZeZxE/9PaFe8MCLeNe9D5NTym+/G9L/L1m6thXhLzz+5PQMDHxr
 YMdXr15ewnRlR/lbr0Utla70UIu+FqMRGTusiVGeJfXD7w/fWHLPFIQJNyw7FTIUOsfaggal+CZ
 VX0FAAriBwHDLDkdHrbp7pTogii9lHqECqomJ1+7LTwe8Gueo0r0FwrTrYoQnQ2q2/LfLDwOTdS
 gv5W0kw0GXXWVckOWTxyIG6u8F5Q5tD/Ju2+kRS95t8LdYrMs0a1ntDFgVEdUKJ/c/wv3ho597F
 96OZswxs7usYZZKssMMmCS873Vh5yOp07Up3WRZieHYYlgI4zb73oM9+tHheU+YualQU7SmHzo2
 tIkjnf6Qm5yu88yFHl5oOnWdozdBjyvleBuh0kyfFF4fhvBThhuMfG1z4DE53ZgEqCefejz39Sn
 z7AdmsEnDNfv46L+oew==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfXyfM5ISGOmEsK
 3Q0r3omNFjsAYvklsCcMnu+MvEdtkokTDAmvr9zy+OjbGXCYcEvIufNnZazqSR5ZK/yDdQ1nS60
 nuK2qr7beAkh817JwaZGAFz8AOFVlG8=
X-Authority-Analysis: v=2.4 cv=Vdhir1p9 c=1 sm=1 tr=0 ts=6aec7c88 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=emZr8bwPc9v7Of-wci8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: rweRe7URP7gtO7OClybKFXfCrVquUl-e
X-Proofpoint-GUID: rweRe7URP7gtO7OClybKFXfCrVquUl-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to format dissassembly
index, silencing -Wdeprecated-declarations produced by Apple
clang 17.0.0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/rx/disas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 0eb2ee6f4507..2a67ecfd2fa3 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -167,7 +167,7 @@ static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
         g_assert_not_reached();
     }
 
-    sprintf(out, "%u", dsp << (mi < 3 ? mi : 4 - mi));
+    snprintf(out, 8, "%u", dsp << (mi < 3 ? mi : 4 - mi));
 }
 
 static void prt_ldmi(DisasContext *ctx, const char *insn,
-- 
2.55.0


