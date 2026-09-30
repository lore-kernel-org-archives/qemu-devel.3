Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F19CA5FA5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBje7-0007gN-7B; Tue, 29 Sep 2026 22:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBje4-0007dx-NB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBje2-00037J-Vg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNPoSb1352929
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ciBoyHatj5P
 /ZoD7X5pantn3jd7c+Uyyj7YJoBE4kyI=; b=nhn6pj2jJ38mwm84AEasfm72mAH
 gX+IVc9ZC4qwNDqIRrRjpAHkekuDqd2l26EaclnFja1cz9ZVUOEyNDjxv7UhJZAD
 OD/dS9iY5crX6UbTAVim+jf03zMxZJfTHVx94F+vVnKRfgY7uPHvh1PKi3cgO+94
 +3z09aq1y1eQpNpdh8YtREESSE3M8h9uhZ/pLU29WMiocuAgbBViW6bocwxnqOfb
 wR8I3xUCM9GW8CMsw0YIOx7KL14MUVR5cUi4fNt+fj7Fae9uMP098cZfU2fYsjqB
 IHjZE+nBeLzuFNSBe2kmzHaKS0z/l/fiOJbfEA/mN2ZgU5i6ht4+sVIQtHg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0eswjs1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34316295d86so8418568eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733725; x=1791338525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ciBoyHatj5P/ZoD7X5pantn3jd7c+Uyyj7YJoBE4kyI=;
 b=XwlQbDsaR01pgmz7etzjHU22kp4U7GiyEk/QCsZH6vE97x3EqFQrryKNRL56NR4ho/
 r/2hd4wFedgmFuUqU58db2BJsdklmKkjxiyW7i52fAirGgfwfQ7wMAKxKAwV8IoceaEP
 sIijLc19T4B2bxjhb39tGCtKaokjdC+ChaXKLxVT8OxAdXXBCNhsQfjznnuKVKO2sRDF
 HaSlR2jDluUklJcwZNWdGC68BeOItDeQ/NYFF2F2xGoNO5xszrZLVqgXxQutSbVK+DJu
 DKUo26nMQndM3jvkoleCUeG0NIu/D6P6IkzH7UwxEOLw+bx9Joj9gb3AXV+HmaN04jcM
 fs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733725; x=1791338525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ciBoyHatj5P/ZoD7X5pantn3jd7c+Uyyj7YJoBE4kyI=;
 b=pOQsd68rrEArjY0Ck7GBU7soP6U9nJxvlzd+WFaLnFyJ+cVrB5GzUemjCy7lYCPqqK
 0uB/PfVkHeWD0wSM07bFa411JZz5c1XCAmtxLYGOBacMToSnHV/RbzI7kXnaMvsc5iQe
 sP4yiu+diUWbUfk8iUDVku7hMC8a//sss3gWvlbIcZV5ifFLG0sPFF7bBwK9TN8iRxIR
 Ib3bMb9Bu8rukG8KLPAir01tnrIH718QzB88Sfgmldix2Qy9raDWIBxqXz4oQmJqG7Ej
 XnLDXezVF0b6pJsqCO6Myj3LhGe+EbA5Ro56ATKBvfpHrEBzK5yi7hOvOAy4fff4FVVD
 yFsQ==
X-Gm-Message-State: AFq9FYKY1j0F5hw20JbMMpXSJQe2Db+Li3bPJYhaGWXFo3LXACMls96w
 gMuapFan/CzYDiE9dXfYcyHSJjESfyVYjg2ddwYvQZRhslSkjOW0P/TjaExOFTYfTGTFgZN3yK5
 Aa7iT9bc332ombrpCNOMK2pPibk8JdA3wlp2gWKMI5NZ63DgaD+kXVHO2fYhza1OVTA==
X-Gm-Gg: AYBFou2yQHtJmeT92Ov6oBXSYoipXgc5LGZwrbjD3cNexvLS/JnN92h7ysKXzos5kOM
 wDPM3h3894c7WRu1b4TXuxUX7OTBLaFCY4TO3QnVRi606N3nbe/RBX10sM1ZHlj95GAySYwxt/C
 tU50c/biyOMCs1M1oIShNofsvxshjDMGazgi5Rfev/tOcaA4eK10o6ydXRqsqFPK+Hr7LtINW2G
 qNHTlokuSb+1+Ez67b/LuqZMlJoafdH+WtvDooUQgNLWyLH0nG5FYDtaH98rOtAmXvpAXwvOwLp
 iGHNuNhW1J6Rrnzx91p7A1bfcQNnVoHjp6717ALwoELGb06xxpE4Zohy7bJr40hSXSZxM7i2YDt
 ME/Kb1BwMOWGZOCO1fdcKPOMlwJyRX1FqbHzTqUoSc6v7io1D6heuZ3zOiyAy
X-Received: by 2002:a05:7301:fc12:b0:34c:2850:abaa with SMTP id
 5a478bee46e88-34cdcbb321amr93444eec.26.1790733724591; 
 Tue, 29 Sep 2026 19:02:04 -0700 (PDT)
X-Received: by 2002:a05:7301:fc12:b0:34c:2850:abaa with SMTP id
 5a478bee46e88-34cdcbb321amr93413eec.26.1790733723996; 
 Tue, 29 Sep 2026 19:02:03 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:02:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 17/21] meson.build: add tricore-softmmu to multi-target
Date: Wed, 30 Sep 2026 02:01:04 +0000
Message-ID: <20260930020108.217892-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXzndmpWaziUuo
 mABRTAF1hA6xq9kxIy+/x82cngsgUgs2EfKMFZ+fMO7FXkA3ub/qQ5JkNUijh0uLik0kP5dv/s+
 2Whrskil9CdK9NxBAfkFolEjob0Z/ulXf3oUKdVeJ3rf2cYzx391eeJCIwHdxtslI9fG5urwfWV
 dm+9FxHHW8mY6EIE++SCU5YTM+BibGam2gyZo0GklbLq35d78jI0lCqpkEWTHkOZNWwBjOfTCme
 ovclPfiKX/cesr6/ejq0SWNp2DTYm0E/b9Tt9z9ZdQD0fgTOdPaB0RjB7o4fS2Tfv0lvbKCWo0a
 ABBuW/5OylHdFUnuMi9mLVABhuEKQfzaW6fOTyb6EqK6lhn6nKD+3zymjNkK4MEChWHEWuqy7Nz
 76UMXP4bPU6nCQYfxYDHlygF+KYxVgreOxfGxg35S37hqOlw37+giMlN1G2LXNxOeKO8jszVDGg
 XjKn9NhNY2sB34D2VuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX44efHdGUKuqB
 gbkwhu9BYomD9NqrsLhJ8x8ixqiDfg5BUBNuAq0qEV4yBNE7nk5V0D8/F/c1zO2eQRWR4zvUNaP
 o0Rer4d6MbRaO8orV95pXDfPiG3p6Jo=
X-Authority-Analysis: v=2.4 cv=LaWpeTfi c=1 sm=1 tr=0 ts=6abc6d9d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ub3xvMRmCuOUiND65fcA:9 a=CwyZ7zhn97IA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: uXJSBNqFH1pZjmJRGV6ygoL3GFT_d-MQ
X-Proofpoint-ORIG-GUID: uXJSBNqFH1pZjmJRGV6ygoL3GFT_d-MQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 487a5d6f7be..335d3dcf772 100644
--- a/meson.build
+++ b/meson.build
@@ -4270,6 +4270,7 @@ multi_target_supported_targets = [
   'm68k-softmmu',
   'microblaze-softmmu',
   'rx-softmmu',
+  'tricore-softmmu',
 ]
 
 emulators = {}
-- 
2.43.0


