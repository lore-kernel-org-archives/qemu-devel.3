Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392E606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eSrFC285;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ivBUODWg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOx2c-0001Dc-5J; Thu, 05 Nov 2026 07:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwze-0005EL-P0
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:55:04 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwzd-00060Q-4K
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:55:02 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tDaF444466
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VMMFN1+pLoUGNoBqmjhjA8Ezrd5KH/WaeThj9lHw1qg=; b=eSrFC2851qN8qhMQ
 GfIkvvAxje8D5cBvJxeIh3E8SqSkVR9fhOLaqVqmoAewAlddH45eD3Cg0cLKLxX8
 5Ze/AgdZSFwwe8OIwZtxclKWUjpPUViVZnjqhaltGOqHFlPeaf75z65XOH90AE+k
 XlNCOrBwPaKVAsgHrT6IwNI2bJP8rdJxeUARRgHgKCaq+k9b4d0j8jAMPY6RVsDf
 mmbYPRvG7JRvL53dLLoYmn0w+E8Tj4pJ3qvMmwzz1c6ZZ2yEM8KPuPCiPr1KBa1u
 5bQzvwjOsByE+WIryVyPZ4LJ7550W14FiYJQSTy9Ds6dBksFiz6aTKZbDNnrEgam
 S+25XQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaah2tv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:54:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf6c528aso321981785a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883290; x=1794488090; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VMMFN1+pLoUGNoBqmjhjA8Ezrd5KH/WaeThj9lHw1qg=;
 b=ivBUODWg81z5OoBvsI8MNu9l/trwPVSMHlozCrqNq6TR+SLEXG8nYf1kbiCxGi3Z5h
 9pb5Pb720UqT0zLWQBd5uX4nKwQmh3NdiHd8sXST3XrT5wMxWQ9xREGrjXxiEFGPNLav
 1F6GeKxDG3jfrwj1AJrgjOAwtn05vkfKUNUmm+LkAMmMRDlZI4eZQaNhqrB0B7KUm4b1
 Fui3oSFwlqCPDM6clFFGjw8k58i8pVao/teOAB3GZSYCYDLCfqQz/dodmgKqLNV+AAIP
 nIhzvwQF3IeHM3Hr3fp7c/gfgiw/Ws8lQLS+TlTuny6gyE7X+y+OAUo5DXKkeDlCLM3g
 B3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883290; x=1794488090;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VMMFN1+pLoUGNoBqmjhjA8Ezrd5KH/WaeThj9lHw1qg=;
 b=AlkRfaQYYL2qMMTnfRsiEQZKXxicnbQh9xfJnXNXJaYWv0NJ9gGpxWfj+FYXsj9Eih
 WwxYWHq+R85w+glANzUeIYGq3RJ1XEhVdCX2Ngrm3KrWaBSKXuSaRcPP3nXvHCwntRoi
 eNxN0U3ZZ469s2GH2CAh6lSb2fpAQnzbzfuDrQcv++RfsZWPTA7IvcTQ0ruruUShrP0P
 mgsbz+x49FKHAJVZXnm2ZCEN7JZrbtsIw4WkSFVCP5yWRGiCgo/LGf+IVrQPQwzDkFE5
 8WCSeJ5t6ZEs8wIBzLnQzXUiS+JsuVxK0jv8oE8jEi9tTfmet9ePKfo/0Dqwliilw64B
 7+WA==
X-Gm-Message-State: APuU4Z/AWy9JuW9F/Q3Fw8f+9Cw7N/M1bCVqikm9a4i4XzPllQMA4jE5
 pVTDoa3IeisU9Yzu8LtcrDJjs1H72wwhBNeFkY6Zj0hrEFl8+iFhkK4U/LHUmEt9ZPwvPF+J4ps
 fAv0Gsm8Mef04mOvn3Al1TNuwAFQNRGVcne/50h6TaqvAuNFwaal7L+fTGXF3PCZn3w==
X-Gm-Gg: AYBFou3/g3mmzlZ6VYjNh5x6JFYkG7Jb+PDnvweLKLX+36cZe5kYeZJd/YFaRrBavXw
 PowF+ykt9uDsfSVVlf3/knDGKL0HqDmk8Ub1B6naBq/YPP+mGYPGMjf1M376yKW5Y9vg5ExUjp/
 DpYlvic4edpLD/NXwy6UugH01U8tD0wBU5SOHxazkUOPZUugPFKuwroLnvXKYL5pjYDqLhy/dMf
 wjQDMjptbxEYRaKmvObHoxSbDzY2dls0r+yvrTAfkvlNaW9QHEH2h01XaF2RxYCyCJ/gISjptMH
 6p6Dq/VAXcozdmbsaFZT5lOJXsd6nTU61/M4N2W6IcegIluY7ZDiVzun5xNqEyaGVhH8u6MwCMk
 aUMT0np6Vv16FqyatqA/M7QJDtZjPn9v9AbaHLmJN7USE3sRXthMF5sRR77Pc0hwSIVoD3ug/Ij
 O70E1mBfqs3VVSXQH4Oes1CbX6
X-Received: by 2002:a05:620a:1720:b0:940:f224:5a57 with SMTP id
 af79cd13be357-94421729da4mr3271589685a.62.1793883289643; 
 Thu, 05 Nov 2026 04:54:49 -0800 (PST)
X-Received: by 2002:a05:620a:1720:b0:940:f224:5a57 with SMTP id
 af79cd13be357-94421729da4mr3271586285a.62.1793883289202; 
 Thu, 05 Nov 2026 04:54:49 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e48b93dsm171033666b.64.2026.11.05.04.54.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:54:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 17/17] qga/vss-win32: Replace deprecated sprintf() by
 StrCatBuffA()
Date: Thu,  5 Nov 2026 13:52:02 +0100
Message-ID: <20261105125203.40320-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX9Z9Oqu60kL0a
 QU5iFjUFxt2Wcih6sWKBVic8/sBs7OsccSBhhMZgnzSWKXl+ShJvVmJK7zt2yFtCe/GqnTACSx/
 nHSZil1BndHrG5cAH+4Or1uu8DajRqSdxnRP0f1julENGLYHV207NoUAwyqZhgtW/VtxRA/UE6e
 isyxYzQ2i0ruXM6Efz0ifkYDRS1y5PcXr8CKY46ysWnxM/wa1N2xFzlCUntRpJlgjkP+Rpo42O8
 MR1OOfnS944YuqGYbNTQFxeRhWpErDdFljI6xzMKDqqFd7MSMQM6BSkjDRKPMVvRfL41phJckjP
 HIqeQCTdrlFYURq1fSDUXcGHK1JaaZVLEDO1RGYhDNmO85aD0M4uA/H5A0p1XzrB0kzV26MMJAr
 9u1N5vV8oNacQ3f9EDvgw1habNxO5ahjSa/Vstv9o8vpCpx4SvFZi5V8Xq5VmYrqMpEIUaDqcV8
 cXiXqsRvu+XnTC8W9Jw==
X-Proofpoint-GUID: BwDJIFvec-wZkoLWrRmhpThSOO-xdUZ4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX3CKPZvJ6WvvG
 YYduIWZjHQuoaroCc6F99keO+N8hnaixk+YW+J6GwSjqgapd0yyhsrlXb8n6KyB6pCpwOGZEUNT
 ndo3mOkeoMxOqPcSzavSSx3QL/IKlt8=
X-Proofpoint-ORIG-GUID: BwDJIFvec-wZkoLWrRmhpThSOO-xdUZ4
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aec7c9a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=iCt0esSg6Z1Y5TalJfgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050051
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

Formatting is not necessary, replace the deprecated
sprintf() by StrCpyNA() and StrCatBuffA() calls.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 qga/vss-win32/install.cpp | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index df00588c923a..1a3d5cbf75d5 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -562,7 +562,8 @@ STDAPI DllRegisterServer(void)
 
     /* Add this module to registry */
 
-    sprintf(key, "CLSID\\%s", g_szClsid);
+    StrCpyNA(key, "CLSID\\", sizeof(key));
+    StrCatBuffA(key, g_szClsid, sizeof(key));
     if (!CreateRegistryKey(key, NULL, g_szClsid)) {
         goto out;
     }
@@ -572,7 +573,9 @@ STDAPI DllRegisterServer(void)
         goto out;
     }
 
-    sprintf(key, "CLSID\\%s\\InprocServer32", g_szClsid);
+    StrCpyNA(key, "CLSID\\", sizeof(key));
+    StrCatBuffA(key, g_szClsid, sizeof(key));
+    StrCatBuffA(key, "\\InprocServer32", sizeof(key));
     if (!CreateRegistryKey(key, NULL, dllPath)) {
         goto out;
     }
@@ -581,7 +584,9 @@ STDAPI DllRegisterServer(void)
         goto out;
     }
 
-    sprintf(key, "CLSID\\%s\\ProgID", g_szClsid);
+    StrCpyNA(key, "CLSID\\", sizeof(key));
+    StrCatBuffA(key, g_szClsid, sizeof(key));
+    StrCatBuffA(key, "\\ProgID", sizeof(key));
     if (!CreateRegistryKey(key, NULL, g_szProgid)) {
         goto out;
     }
@@ -590,7 +595,8 @@ STDAPI DllRegisterServer(void)
         goto out;
     }
 
-    sprintf(key, "%s\\CLSID", g_szProgid);
+    StrCpyNA(key, g_szProgid, sizeof(key));
+    StrCatBuffA(key, "\\CLSID", sizeof(key));
     if (!CreateRegistryKey(key, NULL, g_szClsid)) {
         goto out;
     }
@@ -651,7 +657,8 @@ STDAPI DllUnregisterServer(void)
         errmsg(hr, "CoCreateInstance(VSSCoordinator) failed");
     }
 
-    sprintf(key, "CLSID\\%s", g_szClsid);
+    StrCpyNA(key, "CLSID\\", sizeof(key));
+    StrCatBuffA(key, g_szClsid, sizeof(key));
     SHDeleteKey(HKEY_CLASSES_ROOT, key);
     SHDeleteKey(HKEY_CLASSES_ROOT, g_szProgid);
 
-- 
2.55.0


