Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B0606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bsmqbbso;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KFl4I06W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzdt-00005W-A1; Tue, 24 Nov 2026 18:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzdk-0008U6-Pv
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:09:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzdi-0004sX-O6
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:09:32 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMbU3D032069
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XIDWb5XpJkolMC533DpW0SMuXMtUW5FOk2fYmtu3p1o=; b=bsmqbbsoDJVC0IQy
 N0SvYuwYaA7B21OVKQ2yd79ltyABgPTbH/DmkJMQofLNhWt5MylTyiXp5l22lGLV
 38N7AXcY4ndT3+qie0bG0pgUxHnq6wuGmunyUu85GwWUO5YaQZFr5IjSApp3LBu7
 JZRQAI8dx9Vgy2Xm0dQtwZGHtWdLFllYB6V6eoVpp/I0Ut1dIHga+K83GwLFClWH
 V8nHn2s+fzvn5bF5GuTZr63TgsW+c6gIFNJnHQoMv77A0hcnz5OICYe8CsUY9YCH
 9moE5Zy10V2K71xulg7hVLuZYkV5k+HN6MfLkZeUrGtF4/kPYWEI1Xcn8Z/Wq7E6
 rNp3kw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5ad7tpfn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f20addba1so800011385a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561768; x=1796166568; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XIDWb5XpJkolMC533DpW0SMuXMtUW5FOk2fYmtu3p1o=;
 b=KFl4I06WBG4CBEt1IXKLUA8ccPcPC9I9edRuJzczJtCw6W4ptZSFVXBm3Ep6qck59P
 Ki7GNJqOKSd7q+fvloXf6vnnQlBgsAKZ/SgdnlwJLLe62hoSQ5XhUxVKPr0TY0M+Jru6
 Z9rjzwKc5fPkoMJ9OhKNu9qi5k+yZ36K5LiFyj/0w/H2Tc1+rsDSjsg72Z/WjET6Agio
 HlXA4ipAfRSxoJeHMfTw/I+ZTQ22/66CD0KZZQwYYuaVSmU2H2mi+I3PDa1GZzOn9nEx
 ayHEAIdQeQi1uE3XNUoOZNigB3CHFc0mk/CYb6Qi7B15B8k7YhMR0gYCXKEtG11O/4Hc
 d92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561768; x=1796166568;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XIDWb5XpJkolMC533DpW0SMuXMtUW5FOk2fYmtu3p1o=;
 b=zU+WYOMlcqRw05P8jxH4r9jperIeyy0T7LimBG1do+fqJivIoqQKthMRNWPktkq4jo
 +BeARZKcyDrrTANlAFTf/Rv+TOvwOv85xxPwhO2kTrqcbzl50WzQFX6X8u1xPRjJOtPB
 yZDqXxYAh0P0A/1/bZEs3F6t+/JJ3x91cvNmFifLyF7ivV7tGnlbrLwGqIwv9ZXt2Xd/
 N+KcPmqvo8IBwwbXu0imE+AvavWLOLU7HbDE8I3VoS7+Rl50qjMw+KXeg/+da2MqLHLK
 onW0or6ygaknQQ1RjnXom8pk4RJi2T7HUCKat4XsW4XBPs7skP+xLzfFsfJ4En0GAXl0
 BVcQ==
X-Gm-Message-State: APuU4Z8MaE+v3vINyEW6OuykbzQSKveVZ5jlkfgD3bJd2oIcBATKdGaq
 JWQT8xp9IGw46sZXMUmONl0yTGUHleijcZUNZ5Fn55RU9z1IV0w7GKvXlALP0Z/qTOYoFijn7VP
 u/41TPoKNKAyfGwbYmUx5pQgKPcAlUWG+LAzDjvG8fSJmKpkTy9/+DCN651I91fcvZYTf
X-Gm-Gg: AZFdTZeLVB0Y2jCEvwz6p+7Vi6PtSBHPh971KtNW//nhgeun4Jvy3Yk4Ud4mgdaWWn1
 KYK0uW2YV19NMi6jtCQcPaAHEH8GCsPOrrUnKl0p8ELSC747ELcIFG59tevkweuPy5zvQgGwUll
 bH+SIRO1UXihJadX7wa6kM5t6M9r1Cq5DJgMO/EtmS72+X5n8PBKhClzp4QYVct2LzCn6l9Iulp
 rj8A0pEvlMncZrlIBMqPkn6vtureC+MOZawgP5Yo7sRl1EW9NjuXMqmxnx9DXfHlrB6sg8mLmOC
 aCPYVNxwARVpNCMstwqjRDaxnpAo20agky3QZUPDX+W7tE6X+RpHuQujGrTn8f8pMWvAF3+Q4Pq
 wCi91LHStQHAUb4yv6w+CBrf3o5q5z0uwKPyfpsEq7i1qp7zlNGpnUbsX/6xd+F/Anwv80g7PvR
 EzOg5ONYYzqHmISw==
X-Received: by 2002:a05:620a:40c1:b0:949:5708:3cb1 with SMTP id
 af79cd13be357-949ba67d397mr2825702985a.0.1795561767753; 
 Tue, 24 Nov 2026 15:09:27 -0800 (PST)
X-Received: by 2002:a05:620a:40c1:b0:949:5708:3cb1 with SMTP id
 af79cd13be357-949ba67d397mr2825699885a.0.1795561767275; 
 Tue, 24 Nov 2026 15:09:27 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8533579csm412849455e9.2.2026.11.24.15.09.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:09:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] hw/sd/sdcard: Do not abort when writing DAT lines on
 invalid cmd state
Date: Wed, 25 Nov 2026 00:09:01 +0100
Message-ID: <20261124230917.88704-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX2tQ3UWr6AUiu
 EJaM+p92fo2AjKduFiLzgXv6XjP3F4KhnPd/sXnrA2Ba7NmEweurAZOnBxyqOWlO8lc2h4bFv0D
 RDipOresfi5VwYjjtSvKnSVQoZddufo=
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6b061928 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ti5tf6mvKQuLTk511McA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX23tnEgo0k6zv
 0garjmYMR4/WW3Uii/xAys1FQti27cjiLGOeZSywx7qA3rMfJPEr2qvSxH6H5f3TNKUW6BizXl8
 FpLDDX/8lls6U7grgYc/PD7uP7ewS2BWYLrOvCXFvI7PzeWbI/rZn9WoDx3SDCkT1G2Ug23Mgxc
 UXu6mjTD2zyLXUUr6G1ybXHsqzXDiJOM23dCITE7tw2GFdxI7lNlYRyIuqt6Jpwsa5WDVrIv+HJ
 fHss+FngHnsbBC1SXmjpYG6sPKAv/3igqxft6rN3AICNjH+A58EQ8FoZq1kkzd6+PoPJ50sZ6Ox
 bPL01eQ/jVR+Y9qjyJT8vICxUht5gso3Z76gEOqQeT6AIEk5XDKg5Y0NNRyuTMijVpn4jlag+86
 sK5//sTnd6qPlzRVXJwC1zP0oxtpmQtYW0bnuvv+yskPzZYLzViJPP6IB/arhdhErFRKSbp6ZsK
 wZZhm6Rlikiqed3Lqaw==
X-Proofpoint-ORIG-GUID: TuKF5VzsQQBl9R525XMvuWS_PWdrxSJP
X-Proofpoint-GUID: TuKF5VzsQQBl9R525XMvuWS_PWdrxSJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240091
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

Since commit e2dec2eab04d, an illegal command resets
SDState::current_cmd to 0 but leaves the card in the receiving-data
state. Data written afterwards reaches the g_assert_not_reached()
in sd_write_data():

  CMD24 (WRITE_SINGLE_BLOCK)   -> receiving-data state
  CMD2  (illegal in SPI mode)  -> current_cmd = 0
  data token + data            -> sd_write_data(): abort

  ERROR:../hw/sd/sd.c:<line>:sd_write_data: code should not be reached

Commit bd6207903eb8 already fixed the read side. Fix the write side
the same way: log the guest error and ignore the data.

Cc: qemu-stable@nongnu.org
Fixes: e2dec2eab04d ("hw/sd/sdcard: Remove default case in read/write on DAT lines")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261123225349.54981-4-philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0083b8e064e9..f1b5dbe011ae 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2806,7 +2806,9 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: DAT write illegal for command %s\n",
+                      __func__, sd->last_cmd_name);
+        break;
     }
 
     return length;
-- 
2.55.0


