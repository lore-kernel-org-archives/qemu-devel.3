Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA16CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnsv-0001nq-2x; Mon, 05 Oct 2026 14:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqp-0007iX-FX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqn-0005oh-NQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HKrKk1583384
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NxO1G5kMDaERq36fVAC40JOVAEsEYoJnFUcRe59SEOQ=; b=nFsVoNn67ZYmuMcs
 16+Tlaomps6s6xA96k7QSvd5dNPqLobZzgoeY5i0LgsnGrGZoLLpfHm0S0DmSSXE
 Lcbc0HfaXave1H4DoetoznjRDAN1H7JEzoIPMwvdCe4hWhvdJ7O/WtDfCtAhuqBC
 /lrRUqo+rs3dLJAxbamAqK93zy3fdjyQFXwIVvBbWNhZ8XmGxvZIyI0vck7bG2lt
 muH7Do70jvMcWGvVpC7Da0UXCHj/KiIJECVskneHxVCLdLk5Hc/WGbSAgIoattt9
 w3NzofvK9AxHOy2jhyNKWp0XB4xJENvb4Fo7ovt8yNPUis2RFA9xpgamTumTWSYH
 khujCA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4fkugh7b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:38 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1384427c3efso2866715c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226538; x=1791831338; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NxO1G5kMDaERq36fVAC40JOVAEsEYoJnFUcRe59SEOQ=;
 b=YhG08brixGVq8zPLA4g27Gk8Luan/O0LROI+CSCDG2NFkXT2jJkDmgQX6/p+hSpki8
 vA/tUxD0llWyjUFSvw7zNith3vCJhWpwHUPJYjcw47rXUP9rCsfvQeY8+8FfU9Om+mSa
 st2YDcyx++CaS10InHD7My3q8t/3dM/Y8D1qYhN8vX4pHLtjDOHTw76EOwlG6FeRKlCM
 kKQtBY5h9EW7joC0wXshU3OTvSyUioaXIyPZBGEqzS3qH5Qp6X53Urrv3anWGRnM36lH
 aGRfY9MtYyIcMil+nAHIE0MjotvhznnPhoOK9KC5K4zZYpWxFxPXRjcIe9cYKrfOlYqx
 7lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226538; x=1791831338;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NxO1G5kMDaERq36fVAC40JOVAEsEYoJnFUcRe59SEOQ=;
 b=DwnQg/p/ralrvRcji8FEmhpoSIzUGHWEJGdm8wpmvZe3i0qDc1qPTfIo3cJfd0kCDP
 J/7CTxXMEkyZXeKJ4hnLiEANOSLmy/fLQpbjeaNg+F3jgPs+ojDuico2WP9mwqf+yE+/
 czXq5S1AbTzwHp8sVIXCwxfDu3pkouthsFub1wE3Bfy+X0Zw6KCtLyeDwlA/m2Miafh4
 9UYY5dT6f3chLrQmz7JpKQHWNVbowJlFKe++ZyQXfJ6gSC8WkhKwSkQBxN3lQnANszK4
 l1OciQ4AVjpx7HNXUl8NuzwTNfJYRGpOiA38Yf4Y7JL0IQ12IaEoaa/3FCRWbwxpDE/5
 gmmg==
X-Gm-Message-State: AFuF++kONnWu2lYNbFRQxnwAwVyERX/kXP9/M4Vce3aXfr9nhus0UvBz
 F6xyXNeC+4Z50xA9oojsfaFfIl/d+xvPd4VSRAQLW6oer/HkVQJYbDSZ5mG16LCDJjMyF2VUvYr
 7Bu0YoaIduzoNylUEMBM8/LAp3+p5EoNeInJiJNGhsCRRaLx4JVJeK6RErPwwCP0eXQ==
X-Gm-Gg: AYBFou0qU6ckXM21wpwQT9S7TJSD1ckAENtfmFAMLuDdtCOXKHZKkEWd0Ys6FInbxn1
 nIWs09WW09UIlIGp1sDjs8plapt1AaY4GoX5CkQwZHOMaNF+xVKPuSYprIuy48DoJGl2ghdahqP
 iyUASLT94GMc3MimWNQfDV1mz9VTCgvzkBAUT9c6BkyqwSFEqVsn3F07LX3E3Kuzcto/jA87EUI
 /PCFhnrJ5RtW6X93l3t/7qvxKbo//z7Ug/aslRuSaP1IhSxr6E9tl1R1HEfnSkURs9ck7hecAXQ
 kKYDladdxO3oc9TbWpKDY6FqaGJ1egiiEeqFU969XYKK7Ffg4xmc4igggVsMEYo5b+nXYHIRFYy
 xm9hbkn6TmDfKu+CkOWXA/tFgU6atj0TtERDI4omjhXuUDDDo0M7elGCuyTvE
X-Received: by 2002:a05:7023:a8e:b0:144:c12d:c6a3 with SMTP id
 a92af1059eb24-14f5d1b778amr17018249c88.45.1791226537789; 
 Mon, 05 Oct 2026 11:55:37 -0700 (PDT)
X-Received: by 2002:a05:7023:a8e:b0:144:c12d:c6a3 with SMTP id
 a92af1059eb24-14f5d1b778amr17018201c88.45.1791226537154; 
 Mon, 05 Oct 2026 11:55:37 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 19/22] hw/or1k/virt: make virt machine available for or1k
 target only
Date: Mon,  5 Oct 2026 11:54:55 -0700
Message-ID: <20261005185458.405929-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6ac3f2aa cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=EUh9dpdD1nl5Ug-eZJgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: yLiNzCipIghnwZ_VWILL68OrpnQ6fbOl
X-Proofpoint-ORIG-GUID: yLiNzCipIghnwZ_VWILL68OrpnQ6fbOl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX7AeaZhPNN+9K
 AkwdHhS1TxCJzAHYkhC6LmYN01E4CFtqNhYcwllVs11gb0eraMCs0YYNgh8xP15Yfkd0XYLf2dX
 NNyMIitKjudXIz4OVyOW93ZuAlpX5bo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX8YphoNPf5fIV
 iPKY8cFb/DWGaztgNdDfxSKG27HeZionx/2ZLzM3wxosK/j64OPZKmvOHrbQgcYjTYpbX+WDQY1
 /8hmFn3gJs5DkcTjU03YqXfatKUFClbfQJGQOJ/v9EQJQMvXn8ncIvR3Oy8jEDh6CUr0MSEPN3h
 +E9gY6jPoHV+CNL0b3+XV5ou1qKgDivIqfJ45J4hKev2UQ9WyNDEJ/7bu/LCzjjYJUwsmGGYds3
 oOkjVZ5VYRW6p4gp8mO9pdkA+BCFbimx4gmJWwuwJKuQVofFXIKeXRWi5sJhe4oL5B9bWvzn4Kw
 1bfrod8vgLE9AAQmG54iQuDg9sYnjr56Wc5R4Ksr4+UraQF12WezFfPqxUc9k5yaLSwzjN8sOGZ
 dUN18u41buPNFGrbyqwJbYLj1CBa2XQlOqXoMDU72Y5oGNa+DjTmBXxN1r08SRwM9vhkST7+hln
 /Aa6RQdLC1+Cg4wbN3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-20-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/or1k/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 2ff5c084a2b..a3ff903839b 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -559,6 +559,7 @@ static const TypeInfo or1ksim_machine_typeinfo = {
     .parent     = TYPE_MACHINE,
     .class_init = openrisc_virt_machine_init,
     .instance_size = sizeof(OR1KVirtState),
+    .is_available = target_or1k,
 };
 
 static void or1ksim_machine_init_register_types(void)
-- 
2.47.3


