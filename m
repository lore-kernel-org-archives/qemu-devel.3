Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090C606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W9cxHJCD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FGJuq3cC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOcNE-0006YH-Df; Wed, 04 Nov 2026 09:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcNC-0006VY-NI
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcNB-0003ic-5j
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:58 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4EHUsd2016634
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 14:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vNx0jZscZB8Ug/Xf1qxtPaJJhN0JMyd4yC5ugrqN8LY=; b=W9cxHJCDEBX+cKkL
 l4S61fDSN1kigf/opIo4ws5vKCoSKpuPmHv9URXisVWes51/khb2pu4gD+yQ4tzD
 wHejDdNK+7nKlYfca4Es9qVKXNMITepZljtKo8NOiodAecZypSWzRYWINudWHFAp
 i0X7yXzn6d+bSPwePXA3z+29WTJR3OOZxH9LyzcgBBuyHbKIaUOpeW4vKyja0CET
 gX23zsuUkdHT3IcTNzYzKF84skXaj5dKcPfMsIHZnaH3gJNQaT25+whWM7Q+XlQX
 BNpFd289kd1Ys2zhZfK1mzUTpaEXuXd2b2tdwFExvG9kYJU76IGi4aYbMArYgoYP
 c++CPg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bdr46v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:53:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf6c528aso137978285a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793804035; x=1794408835; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vNx0jZscZB8Ug/Xf1qxtPaJJhN0JMyd4yC5ugrqN8LY=;
 b=FGJuq3cCR10pBrXvaDT+TJ+FTHvRhx71rl18yQptgabfn70KTjNDqDsmtUc9ZQgVLX
 Wmp/ZE+fN0nbhgRQjp1+upyUJ4v8CN63W7mG0Cg8oiufi4M1DVNEN0SzhOUmveEdBuvY
 EkwH+NV7G6EMwuTIRWWH5KI3vfmV5iTSZFjqQAfHv7DO6uLMvCDsak8WFpJV4DwWY+Hp
 2/TMtVev6fbK8ic0G0LEqhjl2IJcJxNil9PlkougjCar18oE+81kNntFyWyD0etAI0ov
 tl38NkKU/GwKFeAZmGL2JNkV/B2FjKgMSY8yzj/5W3ewU+Tgpypa26JJTcG92HuTSHa4
 73nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804035; x=1794408835;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vNx0jZscZB8Ug/Xf1qxtPaJJhN0JMyd4yC5ugrqN8LY=;
 b=2D/CNhAJ2w5q6XhcPYoGsBw3ePErYMx7TOEMLb7PTdZUmzVMNxqL6tlAFx5zOWStbh
 Iask9yMcbECb4kti3prPcWbG7OjXAuOdoTYkqzqyse6Zw61g4mzjCB86TEpC2cUUeEZ2
 YjXeFJ+PBzk4e71hfY3Kl0aeynCs7r+4QUjAXRhG9KJxdH9zbz5age0zPA1GPbCt8Jtb
 Sksvlm0zZ0Plllx8M3VF5ltfa+tquuruO8jf/QqUH7mTzd6gJiINpP97480uG64xE8uk
 8ieE9nRKc+xSB0+M/yWXI8QPd4VI8ahu2oU4JJCc3oLTU3fFWvG8AJ/KN2Uc+pUPBalc
 1O8w==
X-Gm-Message-State: APuU4Z8KKIszSRkod+xjF/otW7ZM+lTZXUZ7/gTsBUO/uGHiJ5EDcQV2
 QBYN2lBAS2mQ4xI78b8dGctx40emSFEJusCStmhim+/c92c+3vTnVl7jcBHsu4l70opmkUblpN2
 UJdrjA81c8nSpPXVXmYxRPNIrBMw4Qet51pkIJORfY5nv8/s5qLZKoq3NIbieLK1t6Q==
X-Gm-Gg: AYBFou1XntxHgwKLCXFlFu/+C5iXIumCbekjGtHCc0UwA4ku6+cPmlk6DZ5g6NlYglB
 cpjzEdr5nBlddvM1JTaFOkUY4MsvdRrUsIATtiJ8qnuTTiCmSonPeHThJQGkmd1y8iTV0NVMl72
 UjcBn7TE4NSu0/CS8BmrnGVkG3BBiJiR90nAe+/pE0F6kHQeQ66PMtzUfFX5Nmo7FG+bkjxQMpJ
 67AEEYIFvkwIGBkMgKnyHfUF153ncO9UgijyZl1Kb5fidk5jxF/y9Pk7oNuRh+Y0pfY6JBKFRtZ
 YaFKcE9bb2MAoltrDIzaNNoWjIYEWpU92t8NC7GSFh5Do7pYrrM40Be/2mcHbUCFz2O0sGq+gbq
 YUFWY3AkYH9qc1tvtpHUZ93BRogrR5GSFR1s5yI+tPfPtQxkEuDTOZ6jg1UdqKPLqUe/EZ1rJd8
 3H0Ndb53k/eiEc8A==
X-Received: by 2002:a05:620a:a7e1:20b0:945:de54:9c48 with SMTP id
 af79cd13be357-945de549f6amr96319985a.27.1793804034744; 
 Wed, 04 Nov 2026 06:53:54 -0800 (PST)
X-Received: by 2002:a05:620a:a7e1:20b0:945:de54:9c48 with SMTP id
 af79cd13be357-945de549f6amr96314685a.27.1793804033992; 
 Wed, 04 Nov 2026 06:53:53 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ecdasm86259475e9.5.2026.11.04.06.53.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 06:53:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 5/5] hw/usb/hcd-ohci: Replace deprecated sprintf() with
 snprintf()
Date: Wed,  4 Nov 2026 15:53:16 +0100
Message-ID: <20261104145316.18841-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104145316.18841-1-philmd@oss.qualcomm.com>
References: <20261104145316.18841-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfX3ZTnHpPct4cx
 B2ZvGCU0gdAUxIVQkTNQJ2FB2XPIA4FYCPO5IC7+A7O/ogki1IihKp2QQ+lCkBah8gynwkgLcpw
 wS3kn11gCAyVci7HzmmYqVdlHh3YkJo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfX9ELtVU+KS7RM
 JvsB4eMLH+krunRUr3Vcaw43f2a5H32xhlP83h5c8jxgPG+24o3HAhcmktfmsnABtl3NyA0NViD
 vIBXi8KTU7etO/7Zx30FcNbpRU5Ox6ezEfDlEi/OUw5cJE5ZpM85MCq+K/yDwimbTwrOYUPvn7d
 V9xjBXM64GfMop3bUgu+vBobDzco/xV36AlVa9zALwtOevwpzzAndu/c4HOKljyt30VNgxUguWy
 iIxxoMAXP9iCLwQqdUbmNEPWsJxtqac7Y0qp21yMVjnAPSJ7ZPwR2Ne//0NO6GWhTbKVJoaxLgP
 1g4qCAyMFVVbpng/zz0xZ1lTp7wgpW7EKXDnsgmp8PB5y8aDJrtlrK1f8aOOblbeZUlBc0IQ7XV
 LSVnKZJsEZ7bCJeys57ZWZ3VLwOxLtEOlJ0A0WlMCcDVIQ7WUJtDjDPR/9Dpc95E0xKMVoUaV14
 sU/hlvwPIvtIGafLqSQ==
X-Proofpoint-ORIG-GUID: vz77-oKrUr9y6j1F1JlJjvE67sf49TQJ
X-Authority-Analysis: v=2.4 cv=D4XSufRj c=1 sm=1 tr=0 ts=6aeb4703 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=gRCD0AujNZxhkLCY9qcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: vz77-oKrUr9y6j1F1JlJjvE67sf49TQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to avoid when using
Apple clang 17.0.0 on macOS ARM64:

  ../hw/usb/hcd-ohci.c:875:14: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/hcd-ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 4d38150a8458..d9fcee6c0b4b 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -872,7 +872,7 @@ static void ohci_td_pkt(const char *msg, const uint8_t *buf, size_t len)
             break;
         }
 
-        p += sprintf(p, " %.2x", buf[i]);
+        p += snprintf(p, tmp + sizeof(tmp) - p, " %.2x", buf[i]);
     }
 }
 
-- 
2.55.0


