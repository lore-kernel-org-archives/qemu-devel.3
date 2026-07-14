Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ED0C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiuz-0001YM-HQ; Tue, 14 Jul 2026 15:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiup-0001XL-Ic
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:35:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiun-00051f-Sv
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:35:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIwpCK1390406
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AAg4l5aVFWEwq3R0aucwet6adyc7RK054iMvcKAzyno=; b=d7wpkd5sJ/jMigG3
 H3jRhnWBzLrcSTlJqApdZB56gpkjTd+CuxEavwGafpDqq07YcUzQKjVqi0OO/SMw
 Zy7tIxJXHb21mg9f9ZbfnN6Rf0GJ2no3gBYrcC/vaFNZsNpzdHBvd6pCx9ZynSUE
 R2FDM1SwphqQLrDsy2XqXCWkqeNgFdiZW0/1KzxdL0ET2uOa/NE1/FQnUx5C9TLR
 6QBHMd92L6ZRn0QYdbquC+n9SG9OFptxQjiw1r8ifmvlFldvkCHhsarOCET/IrbN
 DeMn3EMze8jlaIKdgTvg6jkQHDY3k0tvRw3pStmgQ6HEM3pqbnZhmtFTRf6QQEY3
 ug6N8g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr1hyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:35:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1ada6c43so71683501cf.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057736; x=1784662536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AAg4l5aVFWEwq3R0aucwet6adyc7RK054iMvcKAzyno=;
 b=ceiADwbVUQPkci2x8uwsc99a0YlyTVNCQTzUmuvxIThLhLQSrX2sDpskJIzaO94S1d
 MwQJODS2q5hb87xCphvujEunqrxNbWvPBdjTQztnUj4LY4ajU0MMbiQLeawnTldZoGNB
 RC0NFTOky9NBy0jFfVPiB2PGewk07hVxbTFWMRQIY4WJloOo7tucOGQBqMyR5xh3TSeB
 V4v2FmjTWvan5y4ZG5+2NVdTOndZMis4Kj5Yzflmwd6CSejtXyGvfXuHqZ9A6MpQgEGW
 /kfg6c2Lvih1P2QB/pNc0BnWihLLK6mAs3fLoeuG73WeffQ6ihzn4pqt/hng/2Iz0KZF
 UFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057736; x=1784662536;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AAg4l5aVFWEwq3R0aucwet6adyc7RK054iMvcKAzyno=;
 b=cKH4ReNxK93PQEhGjd1ZbxxYyHF3vz+H+eJP2DLvZoi0qMoTAKh81Hf9ia6k5FeK0M
 ZHGGVv1jBfZffKoFw3RmxX3JC1U+GkEt599rcgpzqYlShDF3QegYaRJ0sMY7+hK/3dm2
 l3XvsfrRJDnZVEzlzn/X0ME48vBdv20zMRz8cUzn4UlDOi/vA5KzpoyzA+58cO+O+s0P
 fGlwhYqF+ZobKpb7cbOhM8EdQ7lbwENyWMrWvGHyG/XD0janoY2btz2k6j1dwuXXqtlQ
 ORW7GdJlXSG1RsoCx++xx27ifXccjOC1ED/QypId5uIjFboji21s/KcKMVPOIferv7ga
 19lg==
X-Gm-Message-State: AOJu0Yx7DgDMldTZ4sbbBEVWOppExOugxSO/EODl+ONT3flRq+Xycbmr
 DhLAbHIHG5KijO1mcrWTEDT/lPBYWXowUfyArZhYvZmqkW+vrWFOy+cElItP5Qu8nt3bc/lkNbe
 fYbP2SVmt6Xzm0MhbMH70BuC64Fxmh62mBqgHIAtsF78M2ynr1RQlHibcPTkXvft+AQ==
X-Gm-Gg: AfdE7clLsz0Hd0YtEADzGvyHpy5vvN+7SjbC/7Aksqr5aKqtqiPYrKxOgyAxWn9WdKz
 ehy6rbNPBGbe1S/r3F7Zr/pcTWkOzcNwna5RQ9i32pypTum4NFRqoGF4ZSF2F4DyB4RZsJ1lIFv
 OKWBBovHaCmOg1H1xOx1jhMUs+W6VpQrkn2DG1SdoWN2jbLxpH9mgsE1tPF/k/fZNEjJYej/miv
 ep2xxqLT0JKmnoyapbXEqV4XlmlBxXFcjAn3b22xizrCsnS01dKTzQhp2qbjQo3HXH0qZ+IdD9X
 6/36ks+q6Gm509Ol5gr4my1MIv+xDXjMEkLnA2D5bQlO4o2bIPGooQMVhK2uGspTI7D3THpTO4W
 BOMtVzc9XDZubjgYnJmqAcpwt+9Z9IwGZod9rHra/xc94LbXiUxmy9zNMc7qwmXGHHnhy
X-Received: by 2002:a05:622a:1310:b0:517:87df:d8ec with SMTP id
 d75a77b69052e-51e4edde22fmr623571cf.9.1784057736240; 
 Tue, 14 Jul 2026 12:35:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1310:b0:517:87df:d8ec with SMTP id
 d75a77b69052e-51e4edde22fmr623331cf.9.1784057735882; 
 Tue, 14 Jul 2026 12:35:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a33a926sm88673315e9.15.2026.07.14.12.35.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:35:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/13] hw/misc/ivshmem: clear chardev handlers before freeing
 peers
Date: Tue, 14 Jul 2026 21:35:06 +0200
Message-ID: <20260714193517.60708-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX4jDjYVg1CYFg
 Z+Gu9PiTte17xVtvVD0hdTTMeIdTkJIpAAXZfyDnXkqLaiMFcN1qSHs9L7pZ+3drJRJZklim+vd
 2r0NzrLRmOH9by7eR4DovjS+vyHpZIw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX7RCwqRNpk0xq
 wtaoyC5MkOWknV2c3JBL8a+UQO5Mb2rkF8YJBPs/7LIKlezcfpljJvRtxaT/9VrDELU7uUq+xNi
 N36Uazum7uDIS6uMgtth3cojEpK81JnFifE4H4aBDVCJtV6xY5zazKt3X7A+KTFsCrr1bw5ji+6
 jLHBAMYBWR9BVRsvaBenlskJwZZZFJdXNQ+BrATSYdwELWZyLfpiYdqWTjXtkEllm30oaIWbf/4
 FPPy9835mEiK0Of8LSa+UNGfgrBI08U9XCeqEgNM+l0//frHxi+VDYEgRUgVndIVUo7oYgNdgxm
 q1nI3z/WqwIfsRVkdhSYuKYWgTcx9LgOJW6Vp4dV7f0ecYhJo1J610kcjNoMGznjFvQOv1+c1NX
 rHKcroBrwnDVzoR69m7TFJFIr2pixYv8H78uQwZV0GqVrjKEjll/eH8iHjA4A319V46HLmyfvBI
 y/3oGs74zhIDOnTGVig==
X-Proofpoint-ORIG-GUID: 4IhaZNDl5syMvtgGRid5xP37mRgZ0ODJ
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a568f88 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=GvQkQWPkAAAA:8 a=69wJf7TsAAAA:8 a=dZbOZ2KzAAAA:8
 a=EUspDBNiAAAA:8 a=lzdz0VZZnxX6qFVvEIQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 4IhaZNDl5syMvtgGRid5xP37mRgZ0ODJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140202
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

From: Haotian Jiang <sundayjiang@tencent.com>

ivshmem_exit() frees s->peers and s->msi_vectors but does not clear
the chardev handlers registered in ivshmem_common_realize(). Those
handlers are only removed later in object_finalize() via release_chr,
which runs after ivshmem_exit().

Between exit and finalize, ivshmem_read() can fire on pending chardev
data and process_msg_connect() dereferences the freed s->peers.
Additionally, s->peers, s->nb_peers, and s->msi_vectors are not
zeroed after free, leaving dangling pointers that make the UAF code
paths reachable.

Fix by clearing chardev handlers at the beginning of ivshmem_exit(),
before any resources they access are freed, and nullifying freed
pointers.

Cc: qemu-stable@nongnu.org
Fixes: f64a078d45a ("ivshmem: fix pci_ivshmem_exit()")
Link: https://gitlab.com/qemu-project/qemu/-/work_items/3594
Reported-by: Haotian Jiang <sundayjiang@tencent.com>
Signed-off-by: Haotian Jiang <sundayjiang@tencent.com>
Message-ID: <tencent_3105EC28797360A155078F53@qq.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/misc/ivshmem-pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 536475e9de8..372e9dc58df 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -938,6 +938,9 @@ static void ivshmem_exit(PCIDevice *dev)
     IVShmemState *s = IVSHMEM_COMMON(dev);
     int i;
 
+    qemu_chr_fe_set_handlers(&s->server_chr,
+                             NULL, NULL, NULL, NULL, NULL, NULL, true);
+
     migrate_del_blocker(&s->migration_blocker);
 
     if (memory_region_is_mapped(s->ivshmem_bar2)) {
@@ -966,6 +969,8 @@ static void ivshmem_exit(PCIDevice *dev)
             close_peer_eventfds(s, i);
         }
         g_free(s->peers);
+        s->peers = NULL;
+        s->nb_peers = 0;
     }
 
     if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
@@ -973,6 +978,7 @@ static void ivshmem_exit(PCIDevice *dev)
     }
 
     g_free(s->msi_vectors);
+    s->msi_vectors = NULL;
 }
 
 static int ivshmem_pre_load(void *opaque)
-- 
2.53.0


