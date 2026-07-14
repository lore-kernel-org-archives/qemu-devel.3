Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644EAC4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjivx-0003VG-IW; Tue, 14 Jul 2026 15:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivt-00039P-IH
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivr-0005BU-I3
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:45 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIwHj31448620
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0vkruR0wh68o6mBwvymA7rEaJVjjdVzx0fOvLpWCPgM=; b=Va6byFCTSm1pYL4F
 xI5Zo50SwnC09ZZ3FELAFFAYxENSOxoUVPcn3fJsUaijcdyil1EueiuCJLUVsEc1
 iDmSYTaGGs/dyGdb3l7lN+FG9GC1zKSFnCNEfoCGH/WFZVfg8AKvZULXUg9egGPJ
 qBsgSNyCpKvHtUoTO1lW1nGDaII6vsIGrruVl/WGKdF3MC9EbBSasSAsvoDnTPPh
 RAumrv0Q8FELZ01SOKMWPYB8xyStMpUvEgE76Dn4qg+gK5t9lNK9VFIdxQNLzjyO
 9ZLpq0PGxV/1KCvAs+MSndP5c1FuncEa9+GJjq0gYKO4Scux5qDfjae5sdVNxMd0
 DOCD7w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9hrg0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso80254651cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057801; x=1784662601; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0vkruR0wh68o6mBwvymA7rEaJVjjdVzx0fOvLpWCPgM=;
 b=ARanl+tgUfJcvaWlz5+2MJ16kLIRLO+vharuuTajppfotkRWo6zvyi3bNydVuktpnA
 iIXldjIrviacyHofnFXx0p8AXen/bCQ+ON9wmnkgHCtw5CgbxEGbcTHITFViWN3CPP2c
 hCArj7Imko1wxZo+nVkHnaXvYmimZtucaaaRHxBCvuIKBf7wHd9MzvzXs7v+m5h9KQT1
 3wu0ogTfntQO5CekpJtrpHdkKRoXDl/QXYIwH/IzMRJSCkFJ1jPdPch6gI3/wmc/fYgl
 CQYXl/QlgUIaeOXO84ZVOnKps7NtLGQVEOPh1az0HL9Lu/fLZSc5w6y+Sc3fCE/Dr4Jx
 lmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057801; x=1784662601;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0vkruR0wh68o6mBwvymA7rEaJVjjdVzx0fOvLpWCPgM=;
 b=eJ2X7BulSvv7w7sVfDXyI84qYrTT2so00CiiKoJNNy9Y5KxbaZKyLNQotpAl3dKVbX
 aER6hwMNcq9AgzXqdXI5n4MT3yPC5zNnr2q7hULXvWXJ0Nhxq9hwCXpfMZXZdytkFn+p
 dgCUQkOQ9w/8K3n1H/T2iGm2yr0CO5iaUwY2R53uRQMid6y/GoZvNsU5xv3OwkS6N6fT
 WDSnUDwZdAU/jnB/O+2gAlsGir7dgJxxwRRf8XeQF4dQhbykrCVSTaIDcSMEmSVUqt8h
 lbNZnI9TZ3G33dssTEiezQE9fojTT22nB3ZcT/lBJJduAw6CRhVtgpbv7Ax2PLJ0ySnE
 6/Ig==
X-Gm-Message-State: AOJu0YzS5a/5duumibM0i6rhdokqqCdauA0u4JUAKNtnaPbgLFSAnXcY
 uNfenSoEY6JmGM2L68i/VIk3XdKlQhQMKgS+v5BqHdko8MLbu8pjouS1zeHAz5FOzHeEaU4RLYw
 K8ll9u0DR3P803VHWn7IKqYNbW/5TuH8roRsFoDrxAKFD9+e3cgujzmf2sn+5adCiew==
X-Gm-Gg: AfdE7ck2v/0faBBhyzO11ug2zGEgfooEejT9nm7rax3524p0eJnIGjhtYsRV6KSgYad
 oWR5S9fYbYmhHgLH4iI/gpE/H2apdytGEbPwk1+RDrMm4uMPyFRCi0EOq+VQgWWtJZBATiMoi1J
 JdpAB4fohgk+sBU6SaRpTrP3f2sR/yiMkfjmUubEAwV1NrufjJ3hjv/SvBsDNeMaG5j/vgMIsX/
 eU62YU9bnRSfyQdYbmCWJ3dH45wGdCP5MECA8bVD8mdAgXcvaOV3NT1qUOKCy96Bv+eHJ10r5no
 hro4zzEMKFQ5NGg2yRHVUlJW74RhRsoPfdaHifpXzYU0eDuHut+6QbOCLNSXLib16CdHRvtROxF
 TVpC/wE8mFatxrOkuP/UXA6UqrXpfO+tB1qq3vXr0gdUmfJ7U/oWQgPDQSuQQAGPTwDdL
X-Received: by 2002:a05:622a:2297:b0:51c:217f:518 with SMTP id
 d75a77b69052e-51e4eddcf56mr655631cf.6.1784057799580; 
 Tue, 14 Jul 2026 12:36:39 -0700 (PDT)
X-Received: by 2002:a05:622a:2297:b0:51c:217f:518 with SMTP id
 d75a77b69052e-51e4eddcf56mr653121cf.6.1784057795002; 
 Tue, 14 Jul 2026 12:36:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f476e9d02sm10519131f8f.19.2026.07.14.12.36.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:36:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/13] hw/usb/hcd-xhci: Turn guest-triggerable abort() into
 qemu_log_mask()
Date: Tue, 14 Jul 2026 21:35:14 +0200
Message-ID: <20260714193517.60708-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ib+3n2qa c=1 sm=1 tr=0 ts=6a568fca cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=IxmnRJhVVQ4GrP0OrP0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: eu_MYH2oJRgQRBOb_b9revrtGtjjUHaS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX5iGuht7eiOEc
 WRU6fvQqnFNsx+FKkL9wwA1N9tAFZIImr9SOoR/4K2BlIeCLvWAvbrjsyVSEDFpU6dADDxiq8Fv
 g57/5TOTmBrW54dP9IkXhMLfgDu3g+A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX9gnX7asNAymw
 wjQTVatfa7U7lt9tdGPzCZuGSalIAfneu3NZ5W3k9TnUi6S40SGFlA7WsDjqCY8lEQRqpJdCjLw
 T+ri/osU+ywdFcmZiQTkx74FPJHFfygiZRr0HFJrwYPxEgSFC3c4RvqvXd/sk1aHLtUUyNkIPtV
 wWpkxwmyvcRYkp3LW1LiWQVW4UTvYRWhRtm9so0Bt5WMGYwOASmx2TiLnbSpdI0JpNcvd/uJ57G
 VhYZ7oAEJaLqSPjuPXn6HrGxUcq0R+FWDM6WA5JivXpO/z4zy41SZAHTQAgHGLVrMAO13/uAlX9
 Olviy90uF/yKmCZeItOZzYj9eXsHowsEgTdLVUyIvAOdAP+I/dNuAny7lJ2mmid0Jof8uBPi34A
 zhmwRX3zQBWfdDPiDhU5cdd30LnnPevwI8Zi9bA7ZuQlAroPXOqR/YQw4XOEG2Lom9GhdurIRtF
 0kUAeOWQtkYhB/+EVFw==
X-Proofpoint-GUID: eu_MYH2oJRgQRBOb_b9revrtGtjjUHaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140202
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The FIXME macros in xhci_alloc_device_streams() can be triggered
by a (malicious) guest. Since the macro also contains an abort()
statement, this terminates QEMU. Turn the FIXME statements into
a qemu_log_mask() instead to avoid that a guest can shoot itself
this way.

Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3784
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260713161406.361197-2-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/hcd-xhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 2cdab3ba0e4..f5bb7d25600 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -965,11 +965,13 @@ static TRBCCode xhci_alloc_device_streams(XHCIState *xhci, unsigned int slotid,
          * together and make an usb_device_alloc_streams call per group.
          */
         if (epctxs[i]->nr_pstreams != req_nr_streams) {
-            FIXME("guest streams config not identical for all eps");
+            qemu_log_mask(LOG_UNIMP,
+                          "guest streams config not identical for all eps\n");
             return CC_RESOURCE_ERROR;
         }
         if (eps[i]->max_streams != dev_max_streams) {
-            FIXME("device streams config not identical for all eps");
+            qemu_log_mask(LOG_UNIMP,
+                          "device streams config not identical for all eps\n");
             return CC_RESOURCE_ERROR;
         }
     }
-- 
2.53.0


