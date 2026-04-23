Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06DAFDEE4E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1l8-0002fO-O0; Thu, 23 Apr 2026 17:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wG1l7-0002em-4t
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:38:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wG1l5-00023b-NV
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:38:52 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NFPgcW179253
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yAmoLgrjwHG
 btjIeEuDe7ayCtPhXidq++dY8RvNYCWU=; b=oJwg4PWc0MeRLXGEY4Ujn5M667H
 BAx9QL+AQwD537+N96k1QhnObFhW50D7JhUzzlcEYyO7a7lKxSyRxmOjxJL614F4
 A2/6bOKwajvt8xGwDNBpJBll7CvDHPndBWq202uT7momjiP2KjBvJXTd51DCmWeJ
 0zmgx8PyRvO/T8ZiR2CFLJZT5NScaRkLk+7G6a0sq1pu85UXhw62FULrBvrzaKTs
 MmlDCTaJ+y+7yrkuiwLPW3yeYDV3fLQ0zaV83+taGuWdvT4pIEAoYsI48aBzw4hI
 49swKcS21N/9jH7mgzU3hz752Nh+jyHFGdpYYclDBo5HhpM2rFigpABbjYg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqe62ks3n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:38:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bda35eab74so6412540eec.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776980329; x=1777585129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAmoLgrjwHGbtjIeEuDe7ayCtPhXidq++dY8RvNYCWU=;
 b=YKmhartth4cAdEwrUc5/cREp7LRcyzRfKsZll3mhnvWPmBctdYulcUkV0COLylj7Xx
 cYwkPmuieRwM9Z8xDqo1BRtRkmV5cu5e3WbVbCm2ggKQHoD5Fd3lFO7H327dv38m/tTY
 p54O01sCZVc/6SvmPDvwQA5HVREsX8iIAKMiyKuA/ohJJTgqkdT8JX1KtXBQJ81cJsdI
 BdTxURmuDx3QPlnQmg93Pdx/aIzMWUtOPduXqDSI/gW6mPrC03oRY7MW3xRpuTJlaO4N
 sRi/Mxj2YrYThlsk8w5VVJRSHJXPGW6TT5/AOtJdxugKLyQ8GYQo9SWLQctXcCaEoPL/
 LqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776980329; x=1777585129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yAmoLgrjwHGbtjIeEuDe7ayCtPhXidq++dY8RvNYCWU=;
 b=H25ZGS5YEhXYQMT/EznS8KXw2Yat5+AsW3hL6YDHXSZGcEurIl/qkFDGcq1EpjHff6
 Fp0SuetxK9cBL2HQ81MwhbkGuHdA5B+fYf/1qM3SC/h/1vOnNp3OPkFQEKgkraJYN+Sv
 /Pz877cVvNvEYR0XxsxNCxD4XRv6E1kLuPZIKOvzWR+NsBLPoF1z0BsaXig3nMJDMIQ+
 4PCfR/dj4HFie7zZaAL0td6p3cl3JcoIMvLNT3a6nOZKBqScC37yEChSQgiwiqGTo3qY
 4Fti2p598X96ya3jl+3jnKWoRd0FELyv3JyaytJroVP/Fx/vQnVqmv1cMZclcUbrOIaz
 29Gw==
X-Gm-Message-State: AOJu0Ywa7i2Qhs6a72WG3AwxfAHA4/rWLjYWHSQeK/PLsrTC36ERul1L
 MCKkFBfkyVEhSgPN9ow7YSGlydm9KuzXsquayZ0+a2TAeLii1zTn4mF3xymxKVvon47wImc7H3X
 FmLxKrABBdv+hfho89iaMWXjvVTzDSoZ4o6Y+0ESEU/id56Lqmn/Jh3GrkGpq2fBxVg==
X-Gm-Gg: AeBDievCdQ6BOPwNoKwG6BGm093/I8kFYZEg1+mN6N1jhlZWOtIYzP6Kv0u1ANx71++
 q5rnpHmUOhfpL6ToB2fohJYGPnFznVRI0RlnvUG87tF8CYWNTM31KnPep5DGSM5k/vPj/CQXRPc
 xXUwPE0MvJmjWbUYyvfxzJjfsUYSKk6Yp7tBKd6OCdSI4+1bRie5tgPBfzpsoI3yhS6UUuhP4pk
 Duxx+V7cDuo6Zl6y7JvrQa/QCC4h2Tq6gFC14j2FXDcCu29hbT6mDhD5r8sKHnG7CGPWFMFCEKh
 nMcXCl5Gyk5VRyWq/24satjpItpvvQqj7OceGvQMti6WG1k1sJLXbewA8Nq+P/eKPydeS/XY4Pg
 2l5YtwtU4U0Qd5b5peMocLbtqdT4FR5Hv4kfPhcn4C2uoN9dPcF5dXyRf07uOkmUCT2ID6CRT/8
 MCdnJjJhn7VmISqexdr3bURwpFetE=
X-Received: by 2002:a05:7300:2382:b0:2be:88f2:3c98 with SMTP id
 5a478bee46e88-2e42c253239mr13803947eec.1.1776980328964; 
 Thu, 23 Apr 2026 14:38:48 -0700 (PDT)
X-Received: by 2002:a05:7300:2382:b0:2be:88f2:3c98 with SMTP id
 5a478bee46e88-2e42c253239mr13803920eec.1.1776980328448; 
 Thu, 23 Apr 2026 14:38:48 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e79c2954f6sm30840209eec.30.2026.04.23.14.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 14:38:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PATCH 2/2] contrib/plugins/uftrace_symbols.py: handle missing source
 line from addr2line
Date: Thu, 23 Apr 2026 14:38:38 -0700
Message-ID: <20260423213838.780814-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UBSkjQEUw5HZBYFzfldeY-4-9Ca97ip_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDIxMCBTYWx0ZWRfX/vpoP1c1lEdb
 AnJigW/EFPgRuU9R3ROd8WNDMskjHelYzq8RVgTi6KMhZhgE56WmGTo+nW4aZUVo8VWTcALwMqc
 egROG1KfygIAbMoQn9/l+tjcI7fjefBkYKzz1a7Qr0g/8mfrOSwIh0ik9KpzZVlAWo6+WP0CeNZ
 Lu3xxYOXemNaSBlf3GPM5S6Cg33vK5GDZTkzOMkvOiuAJeBp9vk4347vlRXSd9N8WL3PUcaOm7Y
 SfxmSrfWx2HNb4Kaz0DQfWfapNGBttGED0T1oYsE6QOosZ1iG7+urCTcYUamhBAdmf+q6NyYczb
 ncpwyPF05JcWMOyTHfehPamfVMFnkHrZrtEh1Oa4axfcmiJWwo5bDUwhk6kKk/HbgUdMs5XU5vH
 XNj1Zp0ivGOU1D8q2uHPgknigfgKTaoDfd2a9BkLgKT1A96xJKRIcT5Uaz2zd85anST6/sKzTwa
 5YSE8ne8S6sLGSDRhng==
X-Proofpoint-ORIG-GUID: UBSkjQEUw5HZBYFzfldeY-4-9Ca97ip_
X-Authority-Analysis: v=2.4 cv=Nv7htcdJ c=1 sm=1 tr=0 ts=69ea916a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=hHQBpZYMLWUj37UEPHYA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230210
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

Some symbols have only a file information, and no line information. In
this case, addr2line reports '?'. Replace with 0 to guarantee consistent
data for consumers.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/uftrace_symbols.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 895fa1a6b7a..a71865805c5 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -70,7 +70,10 @@ def find_symbols_locations(elf_file, symbols):
         file, line = out[i].split(':')
         # addr2line may return 'line (discriminator [0-9]+)' sometimes,
         # remove this to keep only line number.
-        line = line.split(' ')[0]
+        if line == '?':
+            line = 0
+        else:
+            line = int(line.split(' ')[0])
         s.set_loc(file, line)
 
 class BinaryFile:
-- 
2.47.3


