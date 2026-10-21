Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B26076B5F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UMvH1mVI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JnopNSdV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMmh-0002ch-9Z; Tue, 20 Oct 2026 23:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMmY-0002ZP-7N
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:14:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMmT-0002O5-2p
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:14:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F4TA2898164
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fTP5GdPijMVLrRP0iA6yBEFGepVL/U+WJ+mrzKQRXGY=; b=UMvH1mVInE7egOyp
 LnidU6vMzxuSCrLx1xTZBuHUvFBw/MK6VGbnvnWTRJb+Coz1wbH2w6NzssU1AVwV
 nNld6lr+s9mjLHdg66ovZURCaMFUNnv02CrvhF8ITUyJivz/uLJcOy/KwZEJD7Vd
 L5r2+w/imY+JM7fuBUnBNl9YZINZU6VKubMqpS/T+KYo54UK7naux3bf9iNhrcpV
 OfgfRaIG34rvCFcBAxINtCYZASd4PU+gfjZnavkDNLct28z+X+tc2YXFkfF9Vq+Z
 t/ymlnRP5mR4ojr3PCwMvZR2G26YgAvSzTWS0IHQT9JcjrpVPXunWINr9HC3QqJe
 npq6OA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0hq4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:14:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ca9b53afaso102620385a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552458; x=1793157258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fTP5GdPijMVLrRP0iA6yBEFGepVL/U+WJ+mrzKQRXGY=;
 b=JnopNSdVoD6Jye76AggEfuGYN3ooxl8YQzDTsrY+exi82aCjCf5TSOcwxwN0EY2gj4
 Eq6Cw+QgaScday9QVv1EFn4+uQvysJlrrTEonaR8Cy4joZhA8Wotf4plX8JC/N2IvL4g
 gJCg93hCGHd8gpVyhNl8XnOl48l4QmXA4SV8MSWnNubxifzOSrGAO3u1Niu/bxJsMhC6
 H5Y0tfnxeC331AVAFE/ZCOEXKj5vMTIDUMLVIycYGoPSCub4tCi18wAySIbwASvkZUue
 wwGFBhQRri1hrACUmCLA+/00MKx6L47OMZSWlKsSkgjyI65Rq+YWsi5/AeKoF/BgPl6L
 D2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552458; x=1793157258;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fTP5GdPijMVLrRP0iA6yBEFGepVL/U+WJ+mrzKQRXGY=;
 b=qQubWEPfQJKAmyRDyS8deb95B92hYb4UfQ8kxn4cXi+FZ7xe/dq+hebaSTBX6FBLXJ
 8tOBQCc+Q5KS67cidMyPSzxQWxgfP4yalCDRyPR0NPSJzSHtfPQrRUMJtPUui2lsnTPn
 6oUmFf0XgXak5FmhIH0TNnC6ECSMhSbHrhLqlFw9ewLxSapSkvXWD6QlqsQ+Dd+wkFIO
 P6/laiIwmv5D/Sjr+DXtFxiDFxxCdRorouBVv2RRsnBW9hPpECywqGYPcqzthQdsH6hs
 mXoV8RnPqEc8hwxBOYQfuuOD181yVx1ordvTYJ1VIOQZzRx4xnxGHGUALyEhzt+dGna6
 APrw==
X-Gm-Message-State: AFq9FYIoGI/bl4yaZ+5G+hEL5Jgs6e0NwDA5KhDYqIzomZwKHsFJMbJN
 IMoQXzCD9gNcqElTyNw02bkGIRqPSae9fV88JSFTg+Ux/XjwbMUl4QMNoxrl6N+dxDT4P6uo/bx
 vM2z4/Lp8nejppNgtG4D6r7M7BYbsVf3iboHXPaEoY/Dbu1jPd5o0UC1Q2bJsM1Mbh/PX
X-Gm-Gg: AYBFou3UvNsHUAfdEXFvN+lJZcn8tLe/xsT2CdXXddNE9mi6dS2G1yrR6ngKSD/dc9g
 yPXMkWLDF6tbd9dV1G30YeU4KMzthMI9sYWUwTKwSBsD3QAmU5YaZ8JRT6i7trWbdXdn1Q5Hjrf
 8iFPSmCw4fDRXG2o/KEY3ocDuRSflodx9nC/vAk5SCEjaxlte1xN+R/iQ84P9qr3kaBwgaysLHx
 Ciz5xjPEXm7tQtemNLFXyGemOh8d33WozWGW7ZiTu4eKGOmBKuMpRhNoyJV6zVA6ukU7U7Bc1fR
 A3rjjb0W9Vgi+SBt/ca5IGMOGD+Fk7Xx9R4gY7YBUQeakuJL6NyYeVMEA3aMwNTZ/stIu55A77U
 qsXl/M5LtOWcnE/wNwWrFzn0G4VEySVop/jNY3TrR
X-Received: by 2002:a05:620a:4503:b0:93e:dcb4:c73e with SMTP id
 af79cd13be357-93f57e3ff66mr224713485a.5.1792552458407; 
 Tue, 20 Oct 2026 20:14:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4503:b0:93e:dcb4:c73e with SMTP id
 af79cd13be357-93f57e3ff66mr224710685a.5.1792552457898; 
 Tue, 20 Oct 2026 20:14:17 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb864dacsm40861235e9.12.2026.10.20.20.14.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:14:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 01/33] qemu/osdep: Add ARRAY_ELEM_OR_NULL() macro
Date: Wed, 21 Oct 2026 05:13:34 +0200
Message-ID: <20261021031407.24862-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX1usPNEav3cOR
 +9KboBGaoNPL/gZj8g+c9ErniHe77V1BAo6rb271dGpaP8U+3uGgcOzY8ECBidMKmUzqowy1fGx
 /jHpvnKEgLQJgkfMen99ahQKEqeRyBBHie8quaheqq3M94NrOv5TZUqPoR0vlY5uA6AOJkLK5gf
 B3+sBmjSforDDN+qKdb/0NntoiCQt3IDdD0VcVzX7RgUvmz3tlw1lYvwPXVGNxsRt8PevhKAw3L
 keT+2tZBIJqpp2GeVOg71SsboZrJ8XBfjIlmj/RMbbN3/LQ36pELuAdNeWgZAluYdrzC2T3pO4E
 VsBmvmsdQK/jnIKQGmDJVSQiMgC7YtCTskY9PQoJo/lmBRHtNOA55gOUl9e0uguWvIOL6Pzu49x
 n4ojlvowS5dvSrtsiEsjd6OYbtkwnBGG5XTdHIj85pk5uFQskhS7FED6Guty+Ta5H5eolfXoj+9
 yp2HvflV83Kmp92R0/g==
X-Proofpoint-ORIG-GUID: b5yX698-fOxHbA4czYktAopZA20_tamJ
X-Proofpoint-GUID: b5yX698-fOxHbA4czYktAopZA20_tamJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX77gNEJyrTwpk
 bLQwb55EDPJi8O75GxXP47xkYuV317CF+0Qr/vNwL1IvPaFUjc1P5YsJrmf6w1GNBrLnltL1Y3t
 kpxXgfHQiiZxEstyot2jWVF+sFNLE/8=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad82e0b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=_sJYpoIm5FXuGNwjPgMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Add a macro returning array[index] or NULL when the index is out
of bounds, useful to convert switch statements over enums into
static string lookup tables.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/qemu/osdep.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1ec5b42230b..993c8ffde0c 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -533,6 +533,18 @@ void QEMU_ERROR("code path is reachable")
                        QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
 #endif
 
+/**
+ * ARRAY_ELEM_OR_NULL() - Return an array element, or NULL if out of bounds
+ * @array: array to index
+ * @index: index of the element to return
+ *
+ * Return @array[@index] if @index is a valid index (negative indices
+ * also yield NULL), otherwise return NULL. Useful to look up entries
+ * in enum-indexed tables without a prior bounds check.
+ */
+#define ARRAY_ELEM_OR_NULL(array, index) \
+    ((index) < 0 || (index) >= ARRAY_SIZE(array) ? NULL : (array)[index])
+
 int qemu_daemon(int nochdir, int noclose);
 void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared,
                           bool noreserve);
-- 
2.55.0


