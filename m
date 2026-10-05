Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12679CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnsm-0001OX-43; Mon, 05 Oct 2026 14:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqi-0007eo-E4
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqg-0005oA-87
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLw3o3044335
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EZcRAiK8CEAsWgEHfROnCiUykk6fvWfzwBFERRBgNkY=; b=GwpDAuwO6BFAuRT9
 tsY+C0ndcOcJh+qAp63lVlhj8uPAe3+6Qqiyzpm3sqR5oDGby1quotC3a8giTdcY
 XoGPqxNhmCbfqtmpyLGvBDoerBNKHjNxWh423oAWegXgDn08BatcPJJPehywpgPi
 5XsPb5ng/k/izSx13OqWrTV1l3Dnqm6O1AuR20T1a7d/uwaRxDYJs/SMf3d0M7uY
 XVarz4sNkUdvX4JvFp4JrmV4ffKZypFXFzORC03+I2XWDPy77GUcveDEYiREzeOB
 tPYJsmAUZaYAZRcUTdP9eBL8lIdMCrv7oRml02ZB/CtOKvq8Tb6Eda3AIaeM9tH3
 /qhaBQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvsxc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4100062eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226530; x=1791831330; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EZcRAiK8CEAsWgEHfROnCiUykk6fvWfzwBFERRBgNkY=;
 b=OAa/R3XEEX4pgXjSpqRTz6+8gPZ63MWBDqh/xeXHwaTxoFIdMtX66S2u5nV8hxMUTC
 JYXu/xvX0HTIs/r5ctloa5udTwUk5oDG9Ck8QU2YlTYily+9+GpEGkFyE1wMhgmzEfZn
 NW8ha4WNtxEM7o+3nE4m/c3jXykJDAMLG6idJNBj1nHSD5BHh5+W1rT+aGvDnZc6oPnR
 j/90nJX7LxZ2IgSDnqHUEE+toytfrR2vKuFL9gyZT3zLTK5ydzePX8/dWfp2/ULu0qbd
 F5st+XFuliPrrwEvaS90CgwbxY5y5hayxvNTZBiBGU7nJNfGNP9RbcBsWcVbmc9F8WF6
 Zu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226530; x=1791831330;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EZcRAiK8CEAsWgEHfROnCiUykk6fvWfzwBFERRBgNkY=;
 b=zd2lOVHuiG/6+KZCHeCgS5hPmV+mmA0tANhpC2c7TZD26tEsWPgwjIJW+5M2DkDqLZ
 WoMXXrzXr5MirkM0P5dQGvpFJkk74PdW9PRY10EU+sE3wK3v+k4sa5a59oIQoEZD6omv
 kj2KUejhd8X/soch2DCa5O3Pz+L+KrFFhULEq0gqXmBXoYImPMerxE3CpdL7J/nLHJ4U
 ZRODWkuOUte8l33m9RRVIx2BdKaLFien2DVcIz7wB3xq7Dfqu9LiRcHl4dU1FiiDghlI
 u2yAyGpg4FSoJHlMJHr9ilWtv48xdQUxkSr7yVRD8Oo2aEBFKIdY91MD+vKUyhbr34/S
 jkug==
X-Gm-Message-State: AFuF++nWCTbooBxV0aObMyjhb24L3t7Dag5PtiS0u8eh2vUXv5IH4ahl
 Dz8yND1w7ew3TFoGyJ9g2wdUybkav5hjcFbaNAttBzoZBdQbQYKDdaENRu2GPX2Gv22cuSrtzKo
 kSu8Vpw1j1Wt3IgIsDEJ07j81vgH8fluu7D/2vjVCELgGRr3K0aP0cnmG14UN1kE2rw==
X-Gm-Gg: AYBFou3FfINKv73Kygd+o0kqwPRYH3Q9c0EHvndwURoHJoMy161A7R0uR15IfZWclrs
 We6Gzmmm80Q/FJQsZGxsQVPAfP2o6X2LxZ5XAUziSoixaNLgXXrTRl1zwW1qzlwpgWUNU+6dbJx
 41e+uZyj1tI8IjMsLmJKB5UZt+NtC0rQk7KftPFiO3FK9JOlhv4hTIbguVqHX2C/I7f6IKJAQEM
 YgGdasfsVJ1ez0G1NqZ1Ga7ngFPfowB8XG0PFdSRKZFwazXrWAgewgCJKRmQ7Yvo+7osJIp0K5H
 FhrBfLJUTg3A1+99O52OTCsbstPxBdH0+CqT2Op5gjYXO44A4KGEPdDOdqhUHijsGXme4t2cZAg
 3gsisY485V4zpwz21DmGYuOkyYjPqjhef7JgBsTAJ0L7DyK4PG7NGWM1wqcqs
X-Received: by 2002:a05:7022:238f:b0:14c:96a4:b631 with SMTP id
 a92af1059eb24-14f5cbd53b1mr17554907c88.30.1791226530237; 
 Mon, 05 Oct 2026 11:55:30 -0700 (PDT)
X-Received: by 2002:a05:7022:238f:b0:14c:96a4:b631 with SMTP id
 a92af1059eb24-14f5cbd53b1mr17554861c88.30.1791226529663; 
 Mon, 05 Oct 2026 11:55:29 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 13/22] meson.build: add hppa-softmmu to multi-target
Date: Mon,  5 Oct 2026 11:54:49 -0700
Message-ID: <20261005185458.405929-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac3f2a3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=ORgI8T0eWTKedyQ7sHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: yRHbQRj93PREW84jfIGckWhW_r3VqymA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX6phl8/vheMjP
 RumA1i0PvEUuoGG+PMPnW7fiH2C0TpCP2FAsQmxFOk0TjF1tBof6uPjWcDU83aeGC0AD2ZqNpEe
 4/v0VqOROdHk7o7JPTW//reeWpiV4PLChSPJ5NWMpbBmBAWiaeQ84bmQggTjSx1OZt0mQqU8G1c
 0Bu2QIUvM1gtod4eovdhG2v0O58hFRm6MEPBUZmoJn4g60v6XfXBIGZ4A5wxoUesvFKLKnBME05
 6gG65yH/0I/ES+uhdjp2+wdn+UYYyI6g//1LYddXVjTu8WEYbZ8C84AM+BKWqkSQv1ex99gZbXC
 A/yWaeUAZkjEV/NXFN0DZy1yL33yGZhSNonWTfCSjzwHZsehYqzFf6rUQBr6nmP8+V0pJvNDaZF
 81lLMv3af5GpKArd3l80fOAxELt+5sL3iXDge2iiAZQLvkQtEnfftEQvxeEgsZYTl/cjm3/fReO
 JE1lnuf/vEA9RfQhbxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX0b9fg9yOBBHn
 fHJNYlvfZ1wi+1p428eThJBvhVhJQdC9JKe5hp8opP7/EE973Ah6ibgcMB42oWjTCFcs8Cawan4
 c2DAh7FrYfKAYrx/V1b1ne+OoHRC6tQ=
X-Proofpoint-ORIG-GUID: yRHbQRj93PREW84jfIGckWhW_r3VqymA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
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
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-14-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 58425a93a93..599466f922d 100644
--- a/meson.build
+++ b/meson.build
@@ -4266,6 +4266,7 @@ multi_target_supported_targets = [
   'alpha-softmmu',
   'arm-softmmu',
   'avr-softmmu',
+  'hppa-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
 ]
-- 
2.47.3


