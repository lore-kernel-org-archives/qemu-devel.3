Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F655C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjfa-0007T0-Vi; Mon, 06 Jul 2026 09:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjf9-00076J-VK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjf8-0006RK-CL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:07 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxTom387522
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6c7Bta3Iey9lpxW/WU4lYojkkssrvRUhxkbTpmvSrxM=; b=emW5DI0hhsUMUX6B
 AwoS/E7WCUM7QiisaejRtoqUzeGwNDbuwy2iPOg+Io39pByAvq/zwnDX+2NC6pPh
 YQKA7xZUfb9G9/y+drZsQH4++InbTnokrumjsfpSV1/m/aWlcqzZs9wtMxLT1Lvc
 4E4m31jfgvxaKl7aZPljrjdEAlxHombV2/o9YNdXvce4yMSaYvTSvCKWcK0mL71E
 Rgg9EhyQf8hjJdPPWX2U+D5mDhXPXYfeVLNTfSW0Vf8Wfnjszz40+1MWFcsG6xdO
 XOtlyGze5z/nzpW35+bAr8c1gffjLTPjAwO3713JhZnQVu7fFprOo09Qkuas4Tuo
 dkZFXA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r0w1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:47:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e55721a8cso312336285a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345625; x=1783950425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6c7Bta3Iey9lpxW/WU4lYojkkssrvRUhxkbTpmvSrxM=;
 b=YF3mJvypfS1bfzOjfBZumQ9Nnt9oQVsakdJcjw+FYPEOVZhaGGHMeOIZpxOQGOTHul
 +dbbqAmtdrZ4crVI9B4d9+7JOHKAl8qBrUfbU3vyzWo0+PRqsNoJ+ocja1nDYbp079pQ
 PdIT05EriqswEwzvA2CBg3Wg7Wf7G0YgRYi5CvYUnLK17vTqh+Zl268/s72kbjl+lTwT
 80clN+ZXKCQ6kCvrJ7ZgjurSiaaHANQAfkWWI72LBK3s++LijICfuaGKr/UvyrTmUSXx
 f9efJmmROLsqrImKgyn+jKVnneuPzhSDfPsr+iOPxJwvljLI9BfffdENs/r4KtmV1MW4
 gUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345625; x=1783950425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6c7Bta3Iey9lpxW/WU4lYojkkssrvRUhxkbTpmvSrxM=;
 b=foVaj/VLcRxbdeWF5tpCL1SosmVavz/82Zuq2wqEJnxz3tK02r6TBUblZup8XBAmX7
 fv+rTfzQTQpFqdEJmcfwPchXmZNUSM6NKL+xCrXHb0VfT3evP8ND+D99jQSKcLGZ/S3v
 +UpZvVsmRqLq8BekAyQW3TvcrZeklqITekO9Y4ry/YaQnGIJ9DZgPaST99175x+hoI57
 A6rgllzloYDMO+4VDdlvaJj6NDO/oiEHZquTYVGv+UMcj39njnnItZlvyHCCzaqn23K9
 PEc3QWK2kyHU2O/vucsdC1kcAxcZL4sVhIHMwryRtrz/1uLqBaH95or9vHVQwuRncmEB
 JXOg==
X-Gm-Message-State: AOJu0YxFEZmpv6mTgY4rrwVSy0E8eldUQ0V6yVJlR4cmrv3uYlnt2o57
 aqYCtsv6cw97YoZlYjSNd2r3fuzejsPQve27AqDs8IO4LsRdjCBL4PhG7pU9RcYLbj2JOdjJnwJ
 Pewzi827lw8ajNHSTPXNvOdq6JcoxRI4i2JhEH97AwU7iupBbY//sEU4g/T+exkm7KA==
X-Gm-Gg: AfdE7ckFn9n4VtSj22b69qTBasyhmVAHjbAZvDnxqIc2lvPtGsNAg2kI/WoICTuglLK
 sIF/W4viCn/Sjwy+1kC5TOonXElQorlh764uwroeIXD6H38U9ryLXjuyLfiYdJOEpF2+FqjF7Sj
 4c68l1sTiDmw+I/F9Vrtu8PQ4GUk0NAgyIlkkL8NpdMuYt3Khmxmu+QMoyaojbljGWLDc+UZ8C0
 GDMXIcSGDBbxTpUDCRe98kuiiq6Zh9bDDvY1/w0km2U25oduALB2IjnFomtuvuOKggb/1+oO3XS
 4yoS8UhcW0yGIq+S9ZalbQvyB2Yn3QjFBy1Hl2Nlp3sPr/p1Z4h4vlKDbm3/jx1UaIowxS7HuOB
 5OJSHxffL7dqrfyxcDrsmxp3auwSzSULzUbuBgY1VpWRCuDN5zIEPxf1aCg==
X-Received: by 2002:a05:620a:28d3:b0:915:75ba:1797 with SMTP id
 af79cd13be357-92ebb50ee23mr86724085a.29.1783345624699; 
 Mon, 06 Jul 2026 06:47:04 -0700 (PDT)
X-Received: by 2002:a05:620a:28d3:b0:915:75ba:1797 with SMTP id
 af79cd13be357-92ebb50ee23mr86716985a.29.1783345624066; 
 Mon, 06 Jul 2026 06:47:04 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63bfba1sm425339425e9.15.2026.07.06.06.47.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:47:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/32] accel/kvm: Always define
 AccelOpsClass::supports_guest_debug
Date: Mon,  6 Jul 2026 15:45:05 +0200
Message-ID: <20260706134527.84808-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfXwWKU3uTHHXRs
 q1mBKsISda0+OC6GJW6NahNcmzAUc3Rxl/sh7JwHZZJ3A5gNSrQ6BcIVhfbsPtpPrDwyioginaE
 t8yVVOvPa3G5J0QQfTV6/lh0/f8V2n6uCtdXlLJby6FRtpiWGIVkPEngHgoaY5gi0jEgDYaFtE6
 hUBqKhaNe56dNYI1MIFrUSmMcS4EzhtfHWPnTa8wop380nf9VPCCQzR4c8v5abDsuO58NqvBgYo
 2Ywl0ukPO2TmiN9rg0Iw1tKpdTE/oS/7DIQqALhntE3AS0N3whS+xiRysXPqLtQYSvJc0v1sxdW
 0qzOiGZoUxe6cSbmInKCn1JjiNmwRWLivZHdcYNBnsVbsCkHyFIdlXm9pXCIKYCXzHeEb7mlW7S
 AAzjsw0TOS7cby9ORSAVI+E457zN3OnTxesPXATSglhLYeMXhfFbCHgt9WVbqfRVvZcrVyju7d0
 HHaEgLQEajv2U1GgJ5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX0dSH2QGVR0JB
 9QweE1oHHodWHHik4fhfDty7LblLa3MAmL81XkpgWraEh9Bgi0dHu2PchV5wP0pCIXzlHLafl6n
 rgqi3xgKude/Eoq2gZjZB/Zchk/7KFk=
X-Proofpoint-GUID: nnsd17f3PdgD7wKDML8F8M7tQ3nLwOYT
X-Proofpoint-ORIG-GUID: nnsd17f3PdgD7wKDML8F8M7tQ3nLwOYT
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4bb1d9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=j4hjfWolugK9Oy_fDxEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060140
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Whether TARGET_KVM_HAVE_GUEST_DEBUG is defined or not,
kvm_supports_guest_debug() still exists and can be called.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-10-philmd@oss.qualcomm.com>
---
 accel/kvm/kvm-accel-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6d9140e549f..d7967bc922f 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -105,9 +105,9 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
     ops->handle_interrupt = generic_handle_interrupt;
 
+    ops->supports_guest_debug = kvm_supports_guest_debug;
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
-    ops->supports_guest_debug = kvm_supports_guest_debug;
     ops->insert_breakpoint = kvm_insert_breakpoint;
     ops->remove_breakpoint = kvm_remove_breakpoint;
     ops->remove_all_breakpoints = kvm_remove_all_breakpoints;
-- 
2.53.0


