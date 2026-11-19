Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539A60A260B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TSIMTACF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JOZB+Pj8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAJJ-0003J8-0x; Thu, 19 Nov 2026 17:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAJH-0003Iz-E5
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:08:52 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAJG-0006kA-0l
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:08:51 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJUXfD3367487
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h2dJqBGRYPcKr/OQB7HAxQOtBhZ6kiAZvlt7ANZAA3A=; b=TSIMTACFxMMDsSAz
 S4QiGmyJjclQL4oC41+uQJkihDYGP7ztsY+7Ul/vHUb0VA/Et2PnAY2pCwOXu0Ja
 TmMPdox74ju/by76ekZ1YE5tcn+iR6GU3OPBP1x0zX9X+XC8aRk8A9XfiygtTD3p
 kdQn1qaFLHIJk26K6GdFRbX6b3Uie6pIQx1CgORDeH4bWBY9Mrp1+ijVSi8AWb3S
 T6UxcVbX3j3Xkwm5Xwz/RB5pfeQcFvR01H8huVq0iP9uiwvtSKGL+PVFjkUz3reJ
 3QNRczj/RR4TqjIPNC/fBBqUiyeg2P6TMcuaB+UqzVHf9pYzCnmDxUvVohiuXMgq
 UpEYlg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5rph6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:08:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495dd0f07eso51244985a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795126128; x=1795730928; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h2dJqBGRYPcKr/OQB7HAxQOtBhZ6kiAZvlt7ANZAA3A=;
 b=JOZB+Pj8Bd5CsN9xWZbQAWPJngCBCGi8W1i8DOAqACthf6efl9k8DaqW6zzYlQrZf5
 cqb67UfhYvS+IN1kb8zz4nnQudp/nBmRTvU9jIFKThSExa53FbqYh2Y89xJOX4Y4sD6r
 0WeF7TY72Ut8BZ9fa4zotCQWiSFoeH5Ts9dR7uaPqzDT+HkZKbGmlrpDZTrr+fSlZcUL
 lvsVS+5IAM5pQ/LobMTZdQF0vpXvdAm/am28SRx6xR3Oi36oU+bYczreqm6FWfndcSUb
 4KwRuucldCumUtE59tlOuCrpLGbKSq7NJ1aRK01MaQVc/b9+8tyz/iFtMZNFOife9GyS
 fSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795126128; x=1795730928;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h2dJqBGRYPcKr/OQB7HAxQOtBhZ6kiAZvlt7ANZAA3A=;
 b=Fo6zPPYgWGx01TQiL8TY9UT6JC63yABLa58qN+/si7GT97KvM7dqujEq8wk9enROYI
 2kPOqxJ7Vc6Dc6H4T3nrbIFdokqEoGjp+rPI/vtZIT7g+eJGhm0cOUoS1+JTg+XCGvyE
 RAxpxhWdSJpZWu6orZgx9c/uYqkCVOKPaaJl3G1jWzj/5+/0L622ECbn2+Mu7MF204iY
 0T0ef5/SPyiiNvfVlPz0xkPYFJT1YJVqcVBAcKEQ+2jeI8yh7vBVS0vfJyNtCP6qH8rv
 rOuZX6l2vaLSOlcYv1gBKzfC2JU1QQGxRXIjcPwLddxcbwIGiqeWaQWKc60o5fEP9hVq
 1/iw==
X-Gm-Message-State: APuU4Z/+Q8w3Gl9CaQ7XQv0XetDCXQrVoLckcQF2czCaR5oV6nM1JZIa
 8CoMdHZqOKNt70GXcvlBBANc2ffeX08Q89eP6Vwpin3go3Pzv/70CbjuuIITuU7AtfziHmDIrg/
 npClDVfq1+d02GJ6UzdL3wM5z3sBUEcrKp9+/4yFF3pTnVN2F+FpwERIhvPSvoF0Kgegu
X-Gm-Gg: AYBFou0LbITfplnd2+NJRp/pKiJ8TFcJhXitrpXmUoMETpeenLeTsMDfeQI/jiipHhk
 U+e4otm9gxgD8eR0/+0ERGgA7qmn/Ewxu2X3anaic0Y0jZZ49c3ZJyQMFRio1P7eVbLbOFG+KMP
 pxvqtXwLP4vqfeElUcpjMGxS86wY5yf2osQw9fQRoNdPmeVxcIRGNmtUdT7XZPxBf01lyGF3tIm
 eQToxxSLCqDCiSYp1irToqaja3Z7vDqjPzsIek6DSDNy00oS+EokjAtkFpgQ5waHN/tEtBBlLcS
 h7It2iiVfJTpDG1xL7KNhoJ4GaHn+rt+GTEy3ie9Z3EptsSuOMlaiAYqcOzMmNBd/z7xVxbkikf
 4HXPtEAWXm3znFjpfN89ndJTDX3bmXHgeEqey8H+Jy4m8/WWoUH2U8YyRnSbC+CVW0ZZ8utkDUS
 nMDzasHDVSBiYBog==
X-Received: by 2002:a05:620a:2856:b0:949:ba09:c68 with SMTP id
 af79cd13be357-949bab5a3ddmr173227185a.76.1795126128343; 
 Thu, 19 Nov 2026 14:08:48 -0800 (PST)
X-Received: by 2002:a05:620a:2856:b0:949:ba09:c68 with SMTP id
 af79cd13be357-949bab5a3ddmr173223085a.76.1795126127917; 
 Thu, 19 Nov 2026 14:08:47 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8526cbd0sm82588425e9.0.2026.11.19.14.08.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 14:08:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/3] hw/dma/i8257: Read the mask from the RWAMB port
Date: Thu, 19 Nov 2026 23:08:35 +0100
Message-ID: <20261119220838.52034-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119220838.52034-1-philmd@oss.qualcomm.com>
References: <20261119220838.52034-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfXywGvZwG7H2od
 SV4a4pBV+4e5FsJ3JVhRtP3c5JVQEQModPASQQmO25rzQggtPpb9yNqYHSUA9IQhTGngJgUxbo+
 ZUYfNYyzNAYXsXlXZCzyd4GXEkVDVG0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX5kbCb7Hsn5mh
 jXljMV/sgJ4LbghRZ/kVaQmDQodvw3coiAe6jSY8ovVgIe3aR99BqdkpIlRqEEjwWxdPih3oPUI
 /zr9zjcqgTssc+qw5JwTyvmZgDjf5RHjk8uAznrjoL0fkZ2jF5z5xYzNaHcy1N+FxRnaxdSvlft
 KrpJANCx60VupVPv8Rwyiusj8BC3A7WsRs21OTexnHWNys9UNai6uzyvuIHZhRlNyz0H0x/zQPV
 1kS5XLiHEuR56mDQLTUzF+W4It+sdZskNmK5TLDF5vgLmTpjtqbY+01ANlwPlym/NG9HEUj8pKW
 qaMG1VZ9FKA56sBa73hj3eOBCUCBTZM/0exyNbCX4fwFB43YdJU9yWDCV4Kaos9+szT7Wvs+zO6
 YIi7ZHqa4WqI1uNIKWT1Ev0rfFfteLyxgKdRnn4wLVEyXLu3kJrC3pVkBkDkfXkoyo3cKNYoS4r
 /VrAEa1ddIg95V/GOKw==
X-Proofpoint-GUID: etOBHfsJYXmEfkvbHWoC9E9AzqMFONQu
X-Proofpoint-ORIG-GUID: etOBHfsJYXmEfkvbHWoC9E9AzqMFONQu
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6aff7371 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=9CvvSRwhk_vVGl7fKr8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190089
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

The 82C37-compatible register layout, as documented in the PIIX3
datasheet, has the write-only request register at I/O 0x09 and
the read/write-all-mask register at 0x0F.
Move the mask read to the latter.

Fixes: 9eb153f18f6 ("dma clean up - added missing read accesses")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/dma/i8257.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 577154988952..f44632de3db0 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -281,7 +281,7 @@ static uint64_t i8257_read_cont(void *opaque, hwaddr nport, unsigned size)
         val = d->status;
         d->status &= 0xf0;
         break;
-    case 0x01:                  /* mask */
+    case 0x07:                  /* read all mask bits (RWAMB) */
         val = d->mask;
         break;
     default:
-- 
2.55.0


