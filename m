Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0093C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUrA-0004qU-HJ; Sun, 05 Jul 2026 17:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUr8-0004kM-H6
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUr5-0008TV-Ox
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:30 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665Hhav82324471
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zlzfQXqCfD0fOdphKFvmR4aYcVqlSHJCNldgrmBSnBc=; b=bNGT7SSs6inJsAt4
 DjvYFWKeh4YwR7k7ibc0KQZmxHuuXkJVnlzJ1xr8o7awZbDrkJat9N1oAeaiANOB
 zc1yN2l9iUJcUozQgX5SMDh/L/iHoOrKSgR5n8OicdQN1m5f8HePi+Nv/boUVY5J
 V4TpJ6psEY3oWqCqjJtHvDRpIQV6KcaENI84I4RPF03uTzRpD1OORsqB0viLaFRv
 Pq6XXjvY+XDERICAUU2fETXexguHElpI440lw1y7HYWSMG5I56jtSEnySV/AbfxH
 US/i+q1SRn0l/eM65ZHyej2SVGcr12L204AOQeuoXAYfvil7+rjL+RRVf5PSKQc4
 dGPBSQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgutqn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:58:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so249828185a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288705; x=1783893505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlzfQXqCfD0fOdphKFvmR4aYcVqlSHJCNldgrmBSnBc=;
 b=d8OMYyViQOmY7QeNk5pyL7hXJO18S4HQ9J0+EbkNFUYrWYt/D5WX9xCpiGaoTBZm/s
 C24BIgjxx2/Y/HBhC0j6P062x6j+14Mn0VBhFv1YJM85VUa2Ijz+sLVSgbPaEaQMtRoI
 s772jApPXFcestOY+gvPWUpsTxobHCkTD3b54TiS0ZpyjMfSro2F3VWCIGxA7aG3jHAR
 dumwjq2D/X4Ex0zr4E6Po7ipehC18YvK1TPvyUXHA5nyeFd+z1beG4ppzFY5ONUSROoz
 T5bGBPoi3N0AaIQMo9LxiUpopIFHbaSwxL3LiJX9j3gKkTIoANJg8IJCAdR1zAFVKY7c
 SUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288705; x=1783893505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zlzfQXqCfD0fOdphKFvmR4aYcVqlSHJCNldgrmBSnBc=;
 b=Feq/KzQTYsR3sCWIpTN27mrBO/7n47f0TYLpHGpU8aS0e1XPa3V3tp59WedIWGs/nU
 l2gabL24fBSPD+d26cRkxztTJh35AgKFxAwL1olO03BnIjdCtXaPdolagWxMtvMm1MVf
 QsefsNm5TaHpyLwQ6TUStiw3EGqWZVu0asGbjW+kYnBLfUuzDPbPIJh7gnG8t47WuJfl
 AZiqqGYkLkypdGDMRkHnDSrAAAnsNfIfjNcHAYzMR2mLSfRRR0VKCGPhAgP2VHjpfDuE
 JHm5UJOZ40oCH8Hmj1a8DQnPnnc3Ip1A9j+mqRX1if9vTz2DLjgBCkWOQts0Pmt3Vvq3
 wDyg==
X-Gm-Message-State: AOJu0YzoAq68l6JOg/3RG537Fl8aScK36gCcM9VWiFJjIkgD2KKRRTx/
 7IbBSe6WyPBJ2ZILz+j2HhjYJj1tgJnKzDHbv1A83FTproNsBLiZXHvXIcsj8oQpdAnNgHWBHOO
 FZpX7ypTUjW/b5xyc154P+2qvqwzBsUdrXF+Ev/rsim98fP/GavhRYUgCJK6dIw06xQ==
X-Gm-Gg: AfdE7clLmOb1VFG14vnJihSORHdO29V6N+yv1BLd6ygMsrh3x2NKoo8NtNmfFDzZ4Ww
 vm8OC2V0WjMnXtfSoB5t+V3nxO5caN7KECojgNmYgwy6OPBANiyihecX+P3N7CLt5mnag//XyZp
 2eJVJ6ae0kP/Kfcq149RUgm0RMkj1rDsy87VUh1AMhbhYm2G1cCkT48E9u8cTXW2tFg7dpWLADB
 aaxUq1uHxzKbOEknFxj70FL/VwQbmq1mpR2Tres2vtTKsFixY7cRXMyFIlrKsBAW+iBYDpZt3Uh
 mAtZzTQPgWNb/g2+jzx4Mli10B3eeRZl2rPQsFv8hGwywWmPwSnNOu3XsF7OGuDKfBGBJnOm4jO
 oKYKWWu23kD68YKvlwZJjEVgtM40QPTL2cI5HBNo+pxT+ykUYezDp3w==
X-Received: by 2002:a05:620a:468f:b0:92e:5232:91f8 with SMTP id
 af79cd13be357-92e8b5d2342mr1471778785a.43.1783288705347; 
 Sun, 05 Jul 2026 14:58:25 -0700 (PDT)
X-Received: by 2002:a05:620a:468f:b0:92e:5232:91f8 with SMTP id
 af79cd13be357-92e8b5d2342mr1471777485a.43.1783288704899; 
 Sun, 05 Jul 2026 14:58:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d910sm18646363f8f.6.2026.07.05.14.58.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:58:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 07/32] gdbstub: Only return E22 when reverse GDB is not
 supported
Date: Sun,  5 Jul 2026 23:57:03 +0200
Message-ID: <20260705215729.62196-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4ad382 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=0n23ylXGgdPVI_k3iFEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WaKtnMAuGHsGkRZRVZHFdx_d9DqAGUMn
X-Proofpoint-GUID: WaKtnMAuGHsGkRZRVZHFdx_d9DqAGUMn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX0Br998YPj5OV
 eyyvonUQkvQ4VU8uOvlwOozkRWb9MEHojxpcgZ+K7pY9T8YcnpfqyAsPuLiqX5L7Oa/TFpPU3dP
 kWWKX7Klm4eqy8qbyP13esNYwHneF1Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX2sPrPhi3DAut
 eDo0EqjS/LiXEIl/t5+NmchKN9Pao3j4bSfsG6nU7xbSwCl8hk6xc2HNwVb+tiVWplzLxPD+TPz
 n4JTB9swv0lV1/a5+3Ipqp8qTYiXQ4MmQGHPpCdlfTaeOx2Zd2meRY3kDoObOwRmcuFOlNyfZ4V
 Lp/j6P2jAvgRqFUxYe1QPjL3dTHshgxx2Ecw7mIunaUuyZa1WJKBph1ouOMuH09KX5bUUlyguwa
 3sJmZyTlPWNspnPsn0Nb4jtfOSZUM2hYuS33HzwOANgpQwUJVL2UKG4DIXP6AhJgXSidZH3NXFl
 gDVDCG67K2Hu9eP2szzyHWI9e2Acoj2GGZ1248Cyx8umJ8Af40gEfi1d4GZP1cj+WlLzDQvNHk6
 lnDGR/p7DSpki2Xx0NFBtwFKy+62TeRB6dQ+OGRgZfmUxa03QyyFgt0KmenmJyDN/EWmZvV5c8Y
 CVHdE9lMpyNtzUguhJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050237
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

No need to keep processing the arguments when we know
reverse debugging is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 246e7746300..f54415a9db7 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1378,6 +1378,7 @@ static void handle_backward(GArray *params, void *user_ctx)
 {
     if (!gdb_can_reverse()) {
         gdb_put_packet("E22");
+        return;
     }
     if (params->len == 1) {
         switch (gdb_get_cmd_param(params, 0)->opcode) {
-- 
2.53.0


