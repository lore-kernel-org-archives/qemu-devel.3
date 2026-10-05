Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75D2CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqa-0007av-1z; Mon, 05 Oct 2026 14:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqS-0007SA-66
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqQ-0005lt-Dx
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLEUh2567963
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MVlle2UyXu+RRe6j8TqfKQDt/FAL7qJOcWzVp2osrPY=; b=Q5Xnnl1VmLzzgGSc
 Yjz3ZHtgL5/WFwM92lj6jH3hHthi3eEPoH9JfhOfsmLPeKL3qFJJCiDhXD1TCHW8
 f5y6f4+eQejtPUYT+o/5uq4b8fO5DT/FfbddoUoywM1ziZersqCgGrG4zFwZO4fz
 taZ3Y7b9Eq4RbT5rQe8EldsvhsGUTS/uwuxm/ut0p3KeyGVGiO0h2dDS2V7GjLVb
 Sj6kuG3IVU1ee9WKp2SeddJFuF/IUSlfGMhZLAhmbIlZvgzrPCy0GwbTAZ4E35sQ
 e0T0ijImW9YLVus3j3odMGbmnzj2q5Hxezu3bjZLCgQyJBQolaOhWp+2Xp24B4gt
 N8qkQg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cj61ey5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33baaba6371so5520456eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226524; x=1791831324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MVlle2UyXu+RRe6j8TqfKQDt/FAL7qJOcWzVp2osrPY=;
 b=HxqmupCCt7hnC/YTZl1kZGpAYhbIm7dNMxQOOnPe2WIu6frRCAyM1mHfjTnlPQ3nWM
 rbTZp1RXk/YdTpPrEhE3RrKVbAZu5KkvBp/ZSzYzXJDLfb4xarE9gbVc5jUuIsB2PU7a
 IFu2N9aAOCfRRAKT5ERQNmhx3eS4E/OQLyGgTeRtILPlDqRCzCqF5pA8rJlnF6WUI7c6
 vEkUi+j8MagdJ/LhzoFeflxoywshm9RT2EQoAdcZzpA1nqBRHghbAX3v1/S9UmV3Y22g
 1ikO1nAVSlgqWM2Lg6nofthW3r5HUG/0PCyeaq+fumVyhbP0RUp958WZQo5lr/NV6FJf
 39ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226524; x=1791831324;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MVlle2UyXu+RRe6j8TqfKQDt/FAL7qJOcWzVp2osrPY=;
 b=pByaTYYxCTAfwqMtkRIZCwIWIclnSGvvuNiW0bFY9GpBbESNNTCIzPIwlkIcwnewhD
 OdzsEIH8SrA4DFZWSXYUZZ3bj6IYNi3cM+qPHQnpfAAqnxAsh7f9MbunC1XTyVogPXNQ
 pOVodcFCq1w5Ip2OefASOCJwqHxlpJG+B4icq+LPIOGIIGHf+tXjqCNFcUocIHARivxh
 HyCrEu1WMjuIYxMgaCKCCVYXc6D76VlvRsSEvJgWu3vOFbsx5vOocbQuvKoJWneFGcvH
 6K+tvjQKzWpQgdHGxKrxI7OdJvLLbhoIJQd9FC4hxAV3dfbpOw6RyfZJ8hE5Jq771SAB
 YtOw==
X-Gm-Message-State: AFuF++nkSuGO7AxqdhMVP3Q9Cb6+jJVOkKM4cfMhqCu3fxf6hQEPzw/A
 zIyNMEwbgYn5PazjkhZ1GV7Yzhm3TmucACTDsRLPHDgoft8LnKtNoQpRQ3v5YIxCQ4n+xcKvZKG
 YDhZyKk5JasMSGGo41mpnqkh7xLWhwoajkn5W7NWNyxyB5v8HULLDx4yg2NgXmFAi6Q==
X-Gm-Gg: AYBFou3KL6kjVx20x/qD69wBiZMx6pEvkMCeQbPfi3552nz9GvQi2KkOv+HfCHXTDfh
 fZbmW0iTPP+MI6LfhxkeUyYiYcNqN3maQbIBFu9pwOiey0E+Jfk6aJfyoL9Jmv7gJoqqCBECjMP
 6gunWeOlM0LHdN4SkdSsi2nEgz31hE0xTiBbIbvQYcvKPIAK7pDQpdg984KtvpfgB2jrIDnZJKT
 npVjwlqR2SXuqDErvHFvsmffBR2O04KFHeHMPmP1ZjftWh0JgUti0O4D1MwmJJCbJIDaCiw8exr
 D/fBBiG0p6/MmF/b+efN+Z8DZ2xhKuoUMeKWnwpHh17rMkXaJ+gOV1TWaW9H4UqsIC3Zbydv/Qr
 ckPC6AyQ8LM70rT/DMlq2qE9CcvXSEsYL9P4xy3d8UJwFIW9BJQhpfszVQZFS
X-Received: by 2002:a05:701b:450b:10b0:145:287:ce91 with SMTP id
 a92af1059eb24-14f5bbfa54cmr15425046c88.14.1791226524221; 
 Mon, 05 Oct 2026 11:55:24 -0700 (PDT)
X-Received: by 2002:a05:701b:450b:10b0:145:287:ce91 with SMTP id
 a92af1059eb24-14f5bbfa54cmr15425008c88.14.1791226523625; 
 Mon, 05 Oct 2026 11:55:23 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 10/22] meson.build: add alpha-softmmu to multi-target
Date: Mon,  5 Oct 2026 11:54:46 -0700
Message-ID: <20261005185458.405929-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXzGnlTihPC3LE
 cwdeu1pPBrt9bqFo2a3An5V2rCh7GQD+po2o6xjg3+fpBaRJX07mhU2B13I2TFQPRergnPVLHXV
 YBQNxr/Xo7wyeuWAGitdwh5JYJiXKcVrHzsdZ2Bx13GIsz68UA53hQ2wUD9w2fZL8fCkrCD2UVM
 5LZB3/rz/Gs374RI5T8SKWTyAkVMKupQxTKotZ3+/MaSGg82TFW1FZX40Y4vCTnaEG6bPm7IzBL
 jo5OGk9rLjr0zgp+L+yOSRYK1E2i0YAPJyugmIvv4palWbEP3EANkfVdQrP6e6Amk7ULp0nYSfu
 IpzVBKAP4hizH6yPAXqTCLrxNzBDqZ3fc0WBR+wKoFvVCs7gXnUIJFd23hmV/3iiTRs9avsHjDo
 9MeJtJZ2bKZ6h0A4ZVPxwUIdnLd6kZIYLiqfRCnzN35qAglCGLZjyqLbUv1q2GqhLDluMpjOVu5
 E7wQXCzIoS45qh+J/OA==
X-Proofpoint-GUID: isCLku1PX6OkWL66zLXOUshbD60Ea6W_
X-Proofpoint-ORIG-GUID: isCLku1PX6OkWL66zLXOUshbD60Ea6W_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX/R/SO9XLXyrW
 +lXgF233MN3R+3jipLWpeib4A4i8w3t3IBzK0TrXD44N0L3QvOHSABcbRsviBawC5H/Rt2M+hlx
 +VcaTXRrzpCgWUq/S1AxoKLRb8rUGqA=
X-Authority-Analysis: v=2.4 cv=bpTZl0ai c=1 sm=1 tr=0 ts=6ac3f29d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=ORgI8T0eWTKedyQ7sHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050074
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
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-11-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index bfff019c884..5515f731295 100644
--- a/meson.build
+++ b/meson.build
@@ -4263,6 +4263,7 @@ multi_target_deps = []
 multi_target_crates = []
 multi_target_supported_targets = [
   'aarch64-softmmu',
+  'alpha-softmmu',
   'arm-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
-- 
2.47.3


