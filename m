Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9063AC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZp6-0007X3-9S; Tue, 28 Jul 2026 00:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo6-0006G6-Pi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo5-0002YE-9K
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:46 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3u04d1920151
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4+SiHtRBNrFz1LBCwuIViSBLrkRHrJcYuv2aqDvTqCI=; b=TWgSXMNnH9JAUJuP
 kOmUZbqv0ppTeOWZru6JIYJKFbwDKG0xV0RcgFKzu7tfhA2A8rsvdO+6PncPP6gN
 wP4J0HuCEuAUUf8n9UjZrSxVS4olxIj+StgLkO5wTha69/AeexiinUiY3hccV2JK
 hxrWJVjg2UB9LK3DR0D8XNs22LghHI2f03msfavZZZ6Qkfx5cgNkJ3j4a3ycY4ip
 iZMKCFmGo0MoXfWeGytBs0rlB3BgujVsrt2929+T6nOoWd8bv3PDv7ru2fNvXpIL
 v02fA1WbOhEtCu/w3k1SMM3rn9+SYAmuzXyAcf1HBogBOsvr1KmVZLy5G/OjuMvN
 LfF1XQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy105c9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso2658148a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214362; x=1785819162; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4+SiHtRBNrFz1LBCwuIViSBLrkRHrJcYuv2aqDvTqCI=;
 b=SxqPY4GfUI+MiFY/tdyFsT4L5ucPXqAJiazPirom55GETbw6mtWGzF8Pd+izXrvFJZ
 kPHTrStuRGTGsSIevaimWhfMsAGeDDzQ8C48+1wBU4TsQQyuELNKEoi5SkKZmEPZrpGu
 OCJU2+0T/EnM1qh85o2S3TtxaP0bgfr65c4KW789EIIohJBUSWXmkuXbD036Yh2DBZ4/
 9FDx9/LZ6u2sngMETmoZAwV91RJQIM+a3SJXkZQpToKH927k+okKQu5RCCfieMSLYCre
 qZvwwj1/GQ8nsOVy4FXJayOsGwo+x02W/9w74rR66X5ycfmd9e/qiPMXdv4ZfmG6BWpi
 podw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214362; x=1785819162;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4+SiHtRBNrFz1LBCwuIViSBLrkRHrJcYuv2aqDvTqCI=;
 b=cC6U/wHSr4eKeUsCe3NYBpemTUm1hFbBftUdPB2FjYE/crKgkyWVBV+fHNzyUWwKE9
 Usy7VUnijeestGp5BJ2P5ge2yOEPHfaDMAuan9MYGc6O/MExgfV7bODZQs6gW5MNyL+Z
 POK2o8d/14Ma87swmvT3JJsJ3/aPvIpLsb8MnY4g1d1VhYNYc1ckRXUbuAlOx8jBQKiS
 XNiLJDAEWuN8lHurhCZkqg7H5m/C0kZrS938gM5GcbpyCEpbNHbTTa0wnRXWDMJ0ASWs
 lvxMF1FvxlvLIRXT+yVzWf05chT8HzaWrdwMTJ7MNBmYUEI3W5zmn9PDkC9X9v8BRSKM
 h2bA==
X-Gm-Message-State: AOJu0YwAhy2LXt0VtUUaM5CqN+2YJ171CKd4NOetXTv4faeZj2jWzLa8
 vc0hAM76VMkF+DMSgdgsXi9Y/xEjVY51UPFgFYxoLgIhAA91cN5HuNu7hDucsqWGXvQSD/un4A+
 lqs1K+KUC6xFGsj/XStWZDWNaLu4bdgj7CGIDYbyqR1kuialqenNubMYPETI4DEwytQ==
X-Gm-Gg: AR+sD12jM1v+Br4gomv9FMD5/5DyAwYT+0nhXo0SIvQ210tV5wnCmRdONwXYFKsh/ME
 74bLinHJd7KXxpXMHIq2T+2D5od7dZRi/LFXjUFHca2DZ2Xbg0D8uvFt/ljNTLwfIlZjLGi0OST
 MrlHuBNHGyRwvVjhU2mMEVye/ToA0n2V78iCOqwR2AWDZCTulHVxPUNmiFsmx0D0ELf08s9DlqA
 dMFCWRhv/PT21URu1VKHc9inY07T1vAU7eWUxngTtKxcwbHXnPZYZSaWPzUSmSUHifUFJhrcgXe
 7cSfCAMAjM4Yur1AZN3m2j4u+ZEfevBM/7phq392WFRc5vwCol/DYpCYGLXqBWfIgHIZIjBhhwv
 59xNcbV9097nIn71Ny90L8pX4DqSAXqOJ1r2W67FqkIikTFUm4Y3eTObESK6ezN+FgYWYiPI=
X-Received: by 2002:a05:6a21:710e:b0:3c3:8fc3:5373 with SMTP id
 adf61e73a8af0-3c8ba5d9d06mr1101892637.35.1785214362452; 
 Mon, 27 Jul 2026 21:52:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:710e:b0:3c3:8fc3:5373 with SMTP id
 adf61e73a8af0-3c8ba5d9d06mr1101864637.35.1785214362037; 
 Mon, 27 Jul 2026 21:52:42 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v6 092/103] tests/tcg/xtensa/crt.S: align .text section
Date: Mon, 27 Jul 2026 21:42:36 -0700
Message-ID: <20260728044248.137626-93-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GEmZJSWbyVLFEl5JmIiK4QWSpNLg8nDB
X-Proofpoint-ORIG-GUID: GEmZJSWbyVLFEl5JmIiK4QWSpNLg8nDB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX8ECnho3+nFnW
 kxwK0d5pgrdDwOgHypdvKUWXSQ1ntc8AFXSY204Sk5T3HAMFFUfeHgaOR4sJNTfYK9zAzVW5Ea5
 IlzcjT4WmhYZlbrEaPVZMBINet7HsCWIKQN61SquxBW47ZZmhJXFO6zYT6uyt33dJ9vspWHB17W
 eSu4jUuovdpgb/nlnsP4DxKLmlXl45jxTNyd0140cPTqwrQ2ZY3FO403G6mkf65MaR8lTZ7SiXD
 i7ImtI9KvXf5b6TAE9zhevFnUB1xh3LuzUbWlRT+SHr+s75Hod5YavjS5KzB5Q8IGxGUGQNYm4a
 J/jUXolI6IFYAwiF8uFzOv/Do/NsiMbcUk6nP31MSlsrKQSpLoMJH11OC5kOw626A8nNe3Mmqrn
 Ww1/DeZSDLcyDy1JSQb93dLRv8dWQP3VtBjEj4lDYYX73r3lAUo6dAESo/a3tytB2QqMj7hV3XF
 85owhi72W8iXw2hUKNA==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a68359b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=5InQkvVgWux2XAX5AMsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX6+K+rtW9jSWq
 0IesYQcIz0y3F1mv/EnDfgVLoIZ853Sd/g+Ez+9lxVCqLEQwf1ycgrXtyxODACoISCVfGGO6v8u
 MMi/emAQaWk7QAJwNageRmbkqqb55Uo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
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

Needed, else we get this error:
dangerous relocation: l32r: misaligned literal target: .text

Previously, .S and .c were compiled in different steps, with different
options. Now, with meson, we have to provide a single compiler command
for all the files (no intermediate steps), which is a *hard* requirement
to save user from dealing with compilation details in arch files.

One consequence is that .c + .S combination gets
-mtext-section-literals, which triggers this. Easily fixed by adding the
.align section.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/xtensa/crt.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
index 909872cd385..de8fd8c1cd7 100644
--- a/tests/tcg/xtensa/crt.S
+++ b/tests/tcg/xtensa/crt.S
@@ -6,6 +6,7 @@
     jx      a2
 
 .text
+.align 4
 .global _start
 _start:
 #if XCHAL_HAVE_WINDOWED
-- 
2.47.3


