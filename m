Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEB0FC593E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 12:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvaAQ-000747-0Y; Thu, 26 Feb 2026 07:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1vvaAO-00073n-FS
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 07:08:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1vvaAL-0006kg-SR
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 07:08:28 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61QAL7Di3987099
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 12:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=GMsfwmoh0tPOKHi6eJOyyzVhbdkh0/Dram4
 jrJrn3CM=; b=kQKBv9BELgwmfgqnpQLdReWt9E36MF1fL1+kRN1xQDF/9MXfz9U
 7bBwa+jMog56QSTbqw7FT19r+hr9bxhlu+Czp/UClUBqDB1RQG0347Gr2kyDLLk8
 njVmDvsaHyOB7LwNeYYL+vti42PRXnC+grqH/YXEVoT6JUF46p3Gliaw3urPHvyQ
 V5uZPCD7HM9DFixeeCgjkmbdsu28xYqByp60AHz9VVE1ErXzJTXPtq2EdPVIK5sU
 tkDAEirEYLdb/Aa6jrTUkyslJfEkDlLat9imDa1fa6eMzkpM9KPp5Tyz9FXCwKJu
 LIg149mygN7zoTx/o6J7IlStxS8FeR8PDQQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjdph1k13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 12:08:23 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-463905cb295so4125368b6e.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 04:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772107702; x=1772712502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GMsfwmoh0tPOKHi6eJOyyzVhbdkh0/Dram4jrJrn3CM=;
 b=WB41eInlXVzCaaG6UhgT8LE4+XLOXN29f+ulMFGYHzU2Ki+DtC7lvO2R5+9j1vJ/17
 pLNzgKAwsW+enNTAeluzB8wqRYmVIP1hIldRDFCXzYE82dXVEa9/TUMZgG5I84Debx5a
 qxsRKCazepAfpJvG/lkekk1fNaS7IsLs7yp8HqjlL+xWfUJCdH9GkenkzhfzMxXCGWb5
 Lz9xbFASOTtRgBE7pkpB7Tj7ZNwR7HCZ3yfPgcQ4KyYiO4+D966Fn3ha6YN4dQPAbmLF
 OkkIbjYK0XjC/PLP9IThLRmUyzpF1ti8E3jVQ5tZITZ0/dMDZ2SYZh+wSOWaRzSlUc6I
 4pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772107702; x=1772712502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMsfwmoh0tPOKHi6eJOyyzVhbdkh0/Dram4jrJrn3CM=;
 b=RHrQ2yqWfnHf25ovn2DrvnezRG/uzMTswwOGvu0ruBBrsvGi2wS1kHjwWE9O+7DiQA
 gqTzo1zfF+5+rQcIIf5QWq+x8YO3bEWVdKlGV3RsdPnD5onpWm2uNKXdD+5WRoxjXSrZ
 sk5G9IMnlC1Pl5liwjgvH3TQskla1dKLPe5C371WS3uvdP2yHbyKJ2hn7VJBg+a9wiMu
 vul01Ob76iTDh5c1rmZ4oBa5uIStcGl+o+o/QBeh2vVFHH4Dib7UXQbWAcO79dUsa1AW
 dUDgYGuUJzqS7pFCw8jV8qyaJoZS7krMz+Fmmk2gCt16r+C/iZaAjo7nszRPUZBlzq/V
 YFxg==
X-Gm-Message-State: AOJu0YycUej6xew01K20eX5BpH1zRhjxgWYq0vDoTXWwHifB0z0YGQty
 xfZZdSAnt3laqYexwwAY9Lji56WyPojDE00uwH4uCCT7Qjn80dwXWrWAk/OFLjO2bFBzFi0SXNG
 MddczJx3pqNhN1uypikuBbC4/X+QrWlWchIFvdYZyCDxqZbMRsI8iZuTaxwqYIOqEcw==
X-Gm-Gg: ATEYQzwYJVoEDXCLy3h4Bjl49qeHfv1oNJ9Ro/SeD8eBf1apSyJFgnBsjeyAWvMaO+M
 AXwTCCZI1L1eMPrg2OIFi9Yt5Op/FSbTV86NRX/byklsCFtQZSzsLcmbCAtCGbXW21pUB2xhDQg
 U9jGLePqTab8jlwEwEuiHQIDEJN1wDbuHwqabJkaM9ewr784M4gWme8sXscmRRCfFp9oL8crBiY
 iM0jujptoW8p1JmgPzb00XJVXP7mIMQOeka9jycUjKwcYcy1QuobQmsnE2Zt17IOQyuyiFvHcTf
 t9QNKZjeMql1NmGaK+eiP2V+j8nq0Hfjww2v5wyazUh3PPYPxdk7ApYbHFdKi/7hPwnaXd4ZZX7
 fD0DNqmP6HRP6An7IpO+aZJ4K1SPz3O8a2IISEYk1jeET6CZWpErgWYtKwmoFXNBw9rUDNmMUhr
 7oDbP2WL71
X-Received: by 2002:a05:6808:1a03:b0:45c:7b2c:10bb with SMTP id
 5614622812f47-4649f06a8cbmr1997904b6e.60.1772107702573; 
 Thu, 26 Feb 2026 04:08:22 -0800 (PST)
X-Received: by 2002:a05:6808:1a03:b0:45c:7b2c:10bb with SMTP id
 5614622812f47-4649f06a8cbmr1997896b6e.60.1772107702117; 
 Thu, 26 Feb 2026 04:08:22 -0800 (PST)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a013cddsm10857995b6e.8.2026.02.26.04.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 04:08:21 -0800 (PST)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu, brian.cain@oss.qualcomm.com
Subject: [PATCH] tests/tcg/multiarch/linux-test: use portable alternative for
 dirent64
Date: Thu, 26 Feb 2026 04:08:18 -0800
Message-Id: <af31d21c4d668cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OLrDO9aVIC8obca3fmLzLT8nPgULM1Zo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEwOSBTYWx0ZWRfX5XUQqof8RNV/
 5d/W0P5U6Ra9ndqkLqkYjv99G55xez0VfIbC7yQI+nLGt73480xsgYlmhjhu+egSNy+TlUk0ycz
 LGrSwfKKfrqxBM+vQBnHrI2sMXk5nWpaDMLKXjWFaRnZYCI3P11K8BEBB5Q57zm6Ozv0Yc/RnMX
 DMU08CMqeTpk02ZcHyrS0i9Nku2uJ6k+Yj6DUAJNv27w8NynmJiUce5X7nhbd23vh7e5DGVo7zm
 Nmq4SWywUlOeCs8h/E17ExucJLjlcIHbN2ah1D0l3FSS+vq2vj5mptkbD1F51ID77WtsW4xQBxQ
 u0JfZogiWnTSyRWe6yPNWOo/C62YobCmXfGF6r0wvHNGDyzs170H+/jcAuxKVOs88/MIKl5Azv9
 5IOf+m7TUHwDULN1L/nAUVxyXMyJuie6xrPfuoOghGsb/reL2yGDmAzrkpj3+7Z9dKGv6m3j20i
 JICUJHGsUx8SLaIZeVw==
X-Authority-Analysis: v=2.4 cv=NJLYOk6g c=1 sm=1 tr=0 ts=69a037b7 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=FsINSnvqluMxtPszMIUA:9 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: OLrDO9aVIC8obca3fmLzLT8nPgULM1Zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001,
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

dirent64 and readdir64 are glibc-specific and not portable to other
C libraries such as musl. Define _FILE_OFFSET_BITS=64 instead, which
portably instructs all libc implementations to use 64-bit file offsets,
making readdir() and struct dirent equivalent to their 64-bit variants.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/tcg/multiarch/linux/linux-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
index bf6e0fda26..0fa3165602 100644
--- a/tests/tcg/multiarch/linux/linux-test.c
+++ b/tests/tcg/multiarch/linux/linux-test.c
@@ -16,6 +16,7 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#define _FILE_OFFSET_BITS 64
 #define _GNU_SOURCE
 #include <stdarg.h>
 #include <stdlib.h>
@@ -83,7 +84,7 @@ static void test_file(void)
     struct utimbuf tbuf;
     struct iovec vecs[2];
     DIR *dir;
-    struct dirent64 *de;
+    struct dirent *de;
     /* TODO: make common tempdir creation for tcg tests */
     char template[] = "/tmp/linux-test-XXXXXX";
     char *tmpdir = mkdtemp(template);
@@ -191,7 +192,7 @@ static void test_file(void)
         error("opendir");
     len = 0;
     for(;;) {
-        de = readdir64(dir);
+        de = readdir(dir);
         if (!de)
             break;
         if (strcmp(de->d_name, ".") != 0 &&
-- 
2.37.2


