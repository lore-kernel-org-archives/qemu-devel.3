Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD45FC44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjivh-0001ra-4z; Tue, 14 Jul 2026 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjive-0001pR-RH
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivd-0005AB-9m
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIwMGw1243440
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KY9N22nTwGAp9VjVSi/nRimYdl1jJpJ47aiu1YZqlxI=; b=f6q68Kzd5Gca7LcU
 CICn4xlK2fVcUPooxHbl2ZCK9K3VnAMRCqjCyd575V4PDw/vTUrZOi1OeFVs0B3C
 uId/VFJXKeZcDT/VCX5D002INUKDaRqWpTPb2c91ifyFGAUyhiiTeNsfJPn75SKh
 9QG2hWf0e+0G46MgJ8KqgrfuXd+BerIvtKO1/bndNca4lMk2DBgEvlIUCTqJdRcj
 ltVhHUNCF7aKUp6hsz3JYoy+/5oJvWP1Aq2thjo5SEl92tvqBcJQk+oRHv3I2inB
 wN0HCsLPdt+oKrgEPtJuErBTzPOeWGp7PaelgU24f92aJpJ+6bgFT6op5pRBujkv
 qlYdfw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmkk1vdk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51e4ba1cfabso6774481cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057781; x=1784662581; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KY9N22nTwGAp9VjVSi/nRimYdl1jJpJ47aiu1YZqlxI=;
 b=gq5oxOLJvxbZptW/FyjsEbSuu4jvyCo841UZQT7vIRvgtvpGBlVTPI5UHoW6+wOO/Q
 8Q4rw61J4x/1eQMUjuict6qYRxOr6SDmVJUzKLmqXozSEwYsW48TsrzKQl8s33buo4gx
 SdY4fTD4zCCtwptbFPEX2jTvcMgsPOvXl8/E7xtO6A6v+Xb2ORFseoKVGkKnbQF3c4a0
 QhGYfAUd+MI9uSpAjkoE1lfCgnUWhK94Ud/HwrYiiA+JMfjOKpTOY/J5uD9XS4HohGKW
 Zo2bE+NUuqLIrdnOUFoWf6W9lj9ziqncQ9/UauvM8hC2UfzHazf+agiQ06UsQ0OhRp81
 JJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057781; x=1784662581;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KY9N22nTwGAp9VjVSi/nRimYdl1jJpJ47aiu1YZqlxI=;
 b=g9Za2vlOI+n+wdKyK2GUMagJIw40nC79OlhkaGmtAhb67QJoJCr6DSDzndu0pav3Uj
 0PbEYh3THOKHTDTE+2b7eq6c90Ffs9t6Zsjk/pUqvfbZ1mSy742k+hJ+hAj0wpt/dR+F
 wgv2u+LE5piC/FGIfZTKKskl1bKtc43h7L78HISk1DznJ7pe6TiX5CReS05GYZH9QGRO
 SQGuaxcKHykYmPmwx3tSwgbcKoKseKFEsnMSz3pReHzFLK6ZqY2Cvn7eua/IALY+ogMY
 ASo0lTJUvzzvx22tgY/VoSZdS34R4SBccsd8+KjC4WawCwKvHG73zeQKhvdMoR/doELo
 5k1g==
X-Gm-Message-State: AOJu0YzZqQatBPvxT/iOUPNRaZuVFgkZ0TbbDPRiwj+aHLR4Pat6pheV
 lxCuTGrVs6+rNBQ3+8LOup8TPQNIWMwxB8UlhW0bNMRJ9xLuIDwMCJJOU2NsT7GehU6d7IQlgbR
 DZHmNxZcxhlB9mlZNDOfVh07B8CE0q7ux6RsAQYo+UVv6g52P7kmG3nz/3Tpn0QHUhg==
X-Gm-Gg: AfdE7cmJXiTezi8XIuuAUNsGE/EkjOyUA11k3JoPcq2B3J45EgXmWCMKi9S1A0TxrhZ
 MkLBIWfDsiepLILUJXczFj8DB3g/bDPSEImH/KeX+sYYK2swJkk+HtOJw1+5+KRBr/dzhUGJYur
 vpsWUaObSAPRwq4e4+sJQXq8icW/Pe1orDOhzbYo3XM65cApGpuVv3qLI+u8WiBiUydYQAT68Bh
 9JN2YuSPkPQ5sNWtek6zaOzHuo+3xptKQ+w/vi2jNIbZtGyATrl67daIzYC+UkIg7cQdF4uvFrH
 SKK5kqLSsRsJTmDFgi8GsPRpSYkFuAMvOxt6Fjjvw+VMUg1tbjWc+pv8f58zlqigfwCjOV1F4d+
 I/oP+z+oQ2/TkiaMH7pd5Y5lDAmhTtrpxrmkVvwUj1dd2WG/skP99mZOZPMBOiSkrEGad
X-Received: by 2002:a05:622a:4184:b0:51a:8c97:9389 with SMTP id
 d75a77b69052e-51e4f101598mr248011cf.64.1784057780815; 
 Tue, 14 Jul 2026 12:36:20 -0700 (PDT)
X-Received: by 2002:a05:622a:4184:b0:51a:8c97:9389 with SMTP id
 d75a77b69052e-51e4f101598mr247711cf.64.1784057780283; 
 Tue, 14 Jul 2026 12:36:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c30a9sm9968758f8f.31.2026.07.14.12.36.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:36:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/13] hw/display/virtio-gpu: fix dmabuf_fd leak on remap
 failure
Date: Tue, 14 Jul 2026 21:35:12 +0200
Message-ID: <20260714193517.60708-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZBDGveaqUSgA3pLY-3Yn8C0MXXPCLvBm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfXwiizZS9NDdHB
 /OK6x1/KAIMn86r6SgZS0YQ7o6T/eb8bzjvBTMyDiT/2gSU/pDzvOEIDOiuAxlAFPGxHHk64QkB
 84XKQv7FszrWT90wdPN0PKkFLAhltWxWGE1CfjW3+xDUcKrYCXFvkleY9wnA8bjKI95pfkO/M9d
 P0JxomTWjulHHsIXUeDW/kVeA6YU3+l39p4avQXyNmrFOzlyMnpyHo4h3Tk7E/nhkAGwyfxLTpr
 eS0em7vBNPj/towSE0c4lXZ/X7eA5yVac4QGSWr0kGJW/cT41zYfT841CKZzkDOlEEKZryBVJaC
 VE8s8pv71yMNKR/0cXSRiNsVRfWa3JrrRqNPOTpx5jRmgRK0Fa6ysb+hBWFM36D/MG6qkBWu+lH
 nO5fjbJiNuK4TN/hTt/snBRvuInAuCx8obSPAH8noakib3SQd4WnDsUrWcGqOM1LajNZErnFLtC
 YjI+DaQ8yXueonLvoAA==
X-Authority-Analysis: v=2.4 cv=NszhtcdJ c=1 sm=1 tr=0 ts=6a568fbb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=8qntHiuRVmbTxgTVLOIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: ZBDGveaqUSgA3pLY-3Yn8C0MXXPCLvBm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX7RDFG1o4x9ls
 K+utQOpxk8+sNUMYIs1Vt5zspHLXFDFZosc9Dp8oJt8/pd0cHdkuFozKptTLgV69jmUtiuIAWnY
 NjKnMiyjl0ArT3AcmZF/7db+342D2cU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140202
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When virtio_gpu_create_udmabuf() succeeds but virtio_gpu_remap_udmabuf()
fails (mmap returns MAP_FAILED), virtio_gpu_init_udmabuf() returns early
without closing the dmabuf fd. Since res->blob is never set in this
path, later cleanup via virtio_gpu_cleanup_mapping() skips
virtio_gpu_fini_udmabuf() entirely, leaking the file descriptor.

Call virtio_gpu_destroy_udmabuf() before the early return to close
the fd. This function already handles partial state correctly: it
skips the munmap when res->remapped is NULL and closes the fd when
res->dmabuf_fd >= 0.

Fixes: 9b60cdf98723 ("virtio-gpu: Add udmabuf helpers")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260713125622.111513-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/virtio-gpu-udmabuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d5ac1cfca0e..5f08c855dde 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -143,6 +143,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
         }
         virtio_gpu_remap_udmabuf(res);
         if (!res->remapped) {
+            virtio_gpu_destroy_udmabuf(res);
             return;
         }
         pdata = res->remapped;
-- 
2.53.0


