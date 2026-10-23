Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36A606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZjLiR1IX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bGlNPs3E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI3f-00088V-BM; Fri, 23 Oct 2026 12:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI3L-0007w4-Rs
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:23:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI3J-0003BL-4Q
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:23:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG3ldF2931048
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9g2kSnPsen9wzmsMJTdNE2cj4Syh7+oSRmYGPn/T9tg=; b=ZjLiR1IXbKbGEhtc
 o70N50yH/SEdp7TniKk4le2XCox29dA3IJaEqOCrA3nqXxzBzXkWVIifo80yNTda
 TzDBTG7sKRDW0qzwg09Ck7CjJXPqN1S53ph5L7htn6khmiP0I84hWnba7DFYFJPE
 NgbGMerW1Yr5XEBfflP7wNM1TtOL7DjtgyrRyDpbf71MzkV+RquWjO+tvmA4kd0/
 KfeepTPZzCLJLPXcVrlGiNky8bqo+RXx9KPs/zIeOvaRNh/3LofRanW9Vnoctj3A
 Re4Cmu9NsqS7r96ZWogC6hPgA9GBhPu1+DLMqzJWtybtcY/z2YTIqdovDAN1NnDu
 2RzsNg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas6r2cu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:23:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5ab5c136so169162285a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772611; x=1793377411; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9g2kSnPsen9wzmsMJTdNE2cj4Syh7+oSRmYGPn/T9tg=;
 b=bGlNPs3ESeeT9hyd1qKOjj98nPUwGW+FQ2dYVNij7pS/rdXsVzgM9YcyvRw9wOoG+S
 Asn9HFGgoA6YGL6+hfzDu4zTCliooBs7iq/3mh7mZIY/E8sdUGLJZXUWK7zPsVkuRD3B
 TP3/H0EJS5k3UGk9U+0WVg7zGOkUWVoI2S3Nkenc24rsv35f77vNL9VFeTkgKkhXIrg3
 oyTfu1Sq4rbyf7ghiLWddJOW3OzoO7Wx7+AsImXAtcZxFcG08P0oKvGGFYa8FT5PiRhV
 sqjWGRrotH0o3LT7kblVBqGT59V+F9mGIfIShzaFdmLfofHfoPwfEaZbU+peFWy48cd5
 B0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772611; x=1793377411;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9g2kSnPsen9wzmsMJTdNE2cj4Syh7+oSRmYGPn/T9tg=;
 b=hsRpHbaLn6QoxKjrnByP2oBzS887HoWGgFtp/OlvYOMLKxxZ7cqyXC9xaZfyAUOhCJ
 VslU7dnQPuEQA9aNBvKyoej8Tp2QUv2UZ4Bf6MOJb8Kocl1vZdIc8waY6JyItQEP+T+Z
 uDsY0raBz8Ioa0FozrQu5yzdYXerujy5HnlqLybkqGVmVct6HySAJ1bKbMd/Mj+0eSzd
 Ijt1Kc2dtBOBZcUmAfCSTzQw2W4wRJiFliCdevI1HizWIm43vW5/jaOk+tvgZhMeMFJs
 L39iQS5QGeQD62CntfoO/lpK4KcbCwDNann7rOQ6S6XRp4z+DRLs+2h5TM9qZICDE016
 lsuQ==
X-Gm-Message-State: AFq9FYJQ/wRTEBIV8UQybeAGP1zeJLj7DwPyTuuPB6blAAGZ7uRtGFlN
 mkr47uvah5om8SnI3Pa7bx2EDg/H3PACCFIiNB2iEQ+cWiFWzNEENOuG3PFToooXsSwD+Si67Fk
 micwU33X0vFSoQgD6ptF0owiZHkveQyGcPoULYMxjwc3NTMBCLM8Om0AnkgbMziohB1kU
X-Gm-Gg: AYBFou33V3OIPpZWDmb9Cm+k8/IDNJWlTS4C+gQK5HkN2PCoFotId11lvdrF5iKe3R+
 OTP6DgJ9gElEpndsHlVUmPUzl2rUlPOs+63lHs4XkkgLPNaVv9KYPiIjd8UgDWC+H5KwzB1s4iC
 HDeT4oCa8rKPzM2P5hKMI0yPy9KOF6HVVoJ/kwc5JUkL0wZ5crD9/UyRlhfBlEWFs+KOeP76Dg8
 /b+vnRQtUXum90l6FvoX+WGDV+dESQG4nuTVc0ndbjlkvdVIZjkP6owPAlqAmSaEfz5dAY/Jg0r
 i3fGO+3SsGtqDyLYwjIm4dRFsLxWcCmY9RbwrTiRD0TqwgEFMH/wZcdoD7dA1rdllk4udWWr0wU
 FeBHXAE4CSxusZH/FiOvJ1bwfQ2GXYRwVvY2PmguS
X-Received: by 2002:a05:620a:1d09:b0:93c:a191:88fe with SMTP id
 af79cd13be357-93f6f55abedmr488077885a.8.1792772611382; 
 Fri, 23 Oct 2026 09:23:31 -0700 (PDT)
X-Received: by 2002:a05:620a:1d09:b0:93c:a191:88fe with SMTP id
 af79cd13be357-93f6f55abedmr488072785a.8.1792772610836; 
 Fri, 23 Oct 2026 09:23:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3eefacsm918144f8f.9.2026.10.23.09.23.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:23:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 82/83] MAINTAINERS: cover x86 GDB XML files
Date: Fri, 23 Oct 2026 18:13:30 +0200
Message-ID: <20261023161332.60153-83-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX7Rx/tdRJYOgD
 omnr3XmnF/FOXE4Jq7O6GPhzjt2t7FeSh8FxIVmtOXMJDYNHngrQ1T/4JbzRLFfDQoReRn0Df14
 d3CmOI3Dgl5fotViptZr+RLqraPvJltsJN2DDSZy12aYYS9yHviWbbXDTj7xbblNCgH2ifftqPW
 lNEAV+IgYM6WUdOKftH36tP6QGGoQCcuE53qJrAIuPEQEQ5/+4OK0EiwFY6NgehkByK9Z2IxJW7
 iQpdfykOaeHdZXVnaMKqOZTpaAP/vLiBpwyLQF8SVxQGng9B0tx5ki5rXVgNsPdIsvxUg9Y8P/K
 IHA/DhXNXsirUoHWyWNNdup8LvolSHiwWFPzfKIe/p3PGrcE+OpPgCl+WR7cO8K+zZDZCZFvbz+
 BIrjjb4BOghU3mxRZPICDaUkB1hBWKo0xLtEzljIsb9MWmRCM9jF7B3FJaQCsEsE0aJN+ejU7gU
 AqAUNl7ZHWbvDXYHnXw==
X-Authority-Analysis: v=2.4 cv=DK0acCNb c=1 sm=1 tr=0 ts=6adb8a04 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=AC0s2TdIQzFrwImDGQYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: GdxJ6LyV4m3rEho2rYLeIJaQjJBiA961
X-Proofpoint-ORIG-GUID: GdxJ6LyV4m3rEho2rYLeIJaQjJBiA961
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfXzqblcoIutfCB
 cNHCQ7gqCXSLqGHhImQijLrmerpo+2cQOOHbG30E4OWoVGqLWdH/LvE4KG1n/rh3kSic5dD1I1b
 53zFtQsqppRsOSiXC7skbO0UX8xZFwQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add entries so changes to these files are routed to the X86
maintainers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022-query-reg-v3-5-7ad902b9a7cf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b09c54f9ee0..de3cb9dcaf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -149,6 +149,7 @@ F: configs/targets/i386-softmmu.mak
 F: configs/targets/x86_64-softmmu.mak
 F: docs/system/i386/
 F: docs/system/target-i386*
+F: gdbstub/gdb-xml/i386-*.xml
 F: stubs/hmp-cmds-target-i386.c
 F: target/i386/*.[ch]
 F: target/i386/Kconfig
-- 
2.55.0


