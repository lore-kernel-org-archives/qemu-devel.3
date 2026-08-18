Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E62C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPUM-0007Tg-8F; Tue, 18 Aug 2026 15:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUI-0007Lo-Sk
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUH-0007bg-7P
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:42 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGsJR2494368
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1kSVgPwgYYVQPuSCI92G+2x6kuFijBou3Qzs5paMs/U=; b=H4Q5p/pfirKNh/US
 xuzV9YNAx611TGAwDgua0VwB1CA6FpYCj4fPAVx8N4mpiJmPgC1qp2pHjBUyKcfh
 SPEK0kZGaory9gi54zVNa6KAFIhE+ZFynltWBjss6CmYnLnvwMkl8pWfvdSDX4DV
 SZ1ZhnllMvyiPS8/uwVa6P/p6XJgEMYzDRT6qNMuhLHw3samRALr4xivIspX4rEP
 9qVOwDzFXx2Utpioklr4iiJMrgAen/HNRpBhKzJFW3QmIvjLi5pfRVEADXkYP8vr
 X7oiG6a9d7mieuIezBocZzwDPAFYXcWXk4j5anDdbh3JDeLEo4A/LcHHgbMbHcCW
 rE9/FA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfnhaq3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dbe39ce62so94305a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081319; x=1787686119; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1kSVgPwgYYVQPuSCI92G+2x6kuFijBou3Qzs5paMs/U=;
 b=TKslQhNItKNPCERHO70v/L4yuiupMg8ww+nOCx0ISOjTkqt9mKJO8UGFDdfoPxslMk
 1LoiM7V09u0DgIHQvDlj1gYKtmOkBiEUZ+NNHdoT/nXQBaVr+29h11MbCu9VbzkMYOPr
 tdphTvkcx6j5kAmFllcbiBsDUitCtwURe77FBmXWNYbLNe2z2Kfx+YBZ/1ZMRt7EZbwJ
 NIi3MY2Vohqi9ZBatyKnIWg3fhLJy+8GxTEUxwBQ3U6E2dMTqDf9CVw2OllfL1JhV0Z7
 sNCrQmXLQaMr/NYmjAskALjfZk/Yo35zab1ghg1FRYaCZfTtvuOeuE6+k4+ZPkQykKQ8
 CbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081319; x=1787686119;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1kSVgPwgYYVQPuSCI92G+2x6kuFijBou3Qzs5paMs/U=;
 b=RukNlEWgaogv+quohn340w2+nxHq3L6lFj81q9dKG/ufJ4Xds5Wnp8hILIy7xHD9Cx
 MnCe3n4FiUebTTtiXDiXRyWtRg9GH+GO4FivfPlJtchcMPPRgJvU19ih2EePaOa5ef2K
 qG/UmwJm0/U3sSbYExEVYE8lVwmTXhMCn6yCWcGq2Svmmtxvp6/8Mh/V9g0I4U7PysKF
 OC6IIrlCsPAb28gjCijDRfUtiqibEKcu4evMOf+n9YMszGko5M218kAvEDAARqJ+wmcH
 ut1pxLNltf6E1q+Zg/ZSJuLbod41KMGpm6J2I7LCGMI/F0tPGrzkLW0EVo15YEeu3+DA
 wPkg==
X-Gm-Message-State: AOJu0YxbX/5MAEAvduwDCPhb9ppt8jiIw9TJH/vFuTVm/tb4jFcmS53s
 wPHMFitKXE04V5jBg1GqYN+9lm3pWbafcaRp4YlTcwe+LX/kqxzYrr+IOGZfP7RL7avUR8H/RYN
 AI1w/Rcv0HjQz0WMYSR0OOjgB9IZgHqiqxUqJmErPt15Y490OWNxPeYluE+qq2Md85w==
X-Gm-Gg: AR+sD11s4L/JrxRwitJjMWv1qpy8Akw0MHCbCst6eVxUXZUxW6b8tggA8CN8uCgOEid
 3Kv3wHtmD92FOLM3O2c7Ubm5Sks5t9B20pkf3PUCshP/gvUjvLCPEgGDn8c14U1baFiQMcVYEZA
 PtP2SUesk8Osyl//MOrFmYh2EcfWw9WXkquvrxF++r4pLgXnr0rmWLJwlGiCXGH2i7V8Q1VaUCY
 xav6me+V8/D9lLlptbmlQ5TMspOJiLnzjTVuH1DpJG/BNd6YkxDfC/E27hmyvwF3Db1APVEug5B
 t7eiOzLt5aU5kJk5FaNcNpcWUvNKuoCnU9oUDj900SPJfQnEIZt8gdiWK7WSo8/0WiraMX2eQGw
 HwYn4OGC6XsRgtX2Y480EztQpS5HyUCLBlAfy9gh97A6209zQyHJrJUKBpPE=
X-Received: by 2002:a17:90b:5404:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-3955f0c0364mr10130161a91.3.1787081319020; 
 Tue, 18 Aug 2026 12:28:39 -0700 (PDT)
X-Received: by 2002:a17:90b:5404:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-3955f0c0364mr10130108a91.3.1787081318559; 
 Tue, 18 Aug 2026 12:28:38 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 070/104] tests/tcg/or1k/test_muli.c: remove set but unused
 variable
Date: Tue, 18 Aug 2026 19:22:34 +0000
Message-ID: <20260818192309.22169-71-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX8I13AszWaZDA
 n5rTfiXkjXF6OKwNEg+BLyM8es+XJ6z+9U6plWIJPdQ23tjTocFPtUSkyU/5Xg+X8EhbseYLceJ
 aF2MzhOd2wZnKy9mWfQFK5augdbOwQE=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a84b267 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=Fbn9wURAhCV4_gqr_ywA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: CKZNmN25Ec0LQEqzlFFKeYJJQreU-SWu
X-Proofpoint-GUID: CKZNmN25Ec0LQEqzlFFKeYJJQreU-SWu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX8LRp2ljjCoYu
 Ue3+uifX/6lbVLEnCzYFhlwKc4ycquE95f4cKtizn2w+QKaXJU1mHfgLK7aFApsBLro/YhPMROR
 2gAKATwsviwSYFqQsNyNiowgvDhzP/lc9Qdnwt5aLi6DR9ZYTXdCr3xwvQVDbzXzC26BwKM9fWV
 d+ZRJ8vnh5wRMoTFFwh4OBjtMFbRBSeeK8boUO1WcpDLMAVej44VPSakqTrcOxRK6msUIxlpqyK
 nnTFL9Bjxi4EzWZo2VHh/7LLYbCxINJyZ/NPwMzwumBOALIaRJIHIxFCjR27boLX+NvtitJXCcI
 Xq+qDGBJrAjSuCqPYzbWfBfQWu6Qeb6c8lAfayNbCofIj8/Jd0Wmcnr1daoZ5/o047Ig4Ly5i/J
 KSGgJyRPkSuWd/DQl9cIlnzSyoNcCQMZdw8qmMfdAChJGBh2NdkVtqXc2snOYbL1Ty6UHD1Ph7B
 VEQU0rf2AHa/OiQL6Qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_muli.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/tcg/or1k/test_muli.c b/tests/tcg/or1k/test_muli.c
index f1042e98dec..cfb6b3df251 100644
--- a/tests/tcg/or1k/test_muli.c
+++ b/tests/tcg/or1k/test_muli.c
@@ -2,11 +2,10 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a, b;
     int result;
 
     b = 0x4;
-    c = 0x1;
     result = 0x4;
     __asm
     ("l.muli    %0, %1, 0x1\n\t"
@@ -19,7 +18,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0x0;
     result = 0x0;
     __asm
     ("l.muli    %0, %1, 0x0\n\t"
@@ -32,7 +30,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0xff;
     result = 0xff;
     __asm
     ("l.muli    %0, %1, 0xff\n\t"
-- 
2.43.0


