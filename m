Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C80CC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eI-0003WB-Im; Tue, 07 Jul 2026 09:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dz-0003IA-8m
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dx-0000ep-3Y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9LcB3740882
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MO9yyG4iDSvkdyCCx+FcktxLSnSn72irxZUl2WAdbCI=; b=BgRwz7+RSZKWQbIT
 N46grnt380qG9aGK6VawNyB31JJkT2Hc5wLHnti8cEYcG4KXX4pHWZvWSW6ulnRB
 gXARWz5ROGn9ndr0eiLASVINDoqw4Zj0d2+1FQphrG3+pGSiJYm/ZeGv2Fe6j4Zt
 HciZOVaWWjoNsJYO+Y6Met/Dfs5QkoyYTh44auZ+PyqP83RuRQKdvZb7UwMnc6Gd
 BazWaEsmYOB0h8SxIiwTE4gjnLdrYQocTQ4aPoxJ7Gwci7H4/LDxCFp6pNnUhxDZ
 3wle9Zl9xuvJkj1yQwRSLyuwGw+iXBb3WTfRT3UguY9yNKV3ORKfk6LRed7+pXM8
 pz3+dg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9a9m0v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:15:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso87248661cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430119; x=1784034919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MO9yyG4iDSvkdyCCx+FcktxLSnSn72irxZUl2WAdbCI=;
 b=hTJouJ3ByfTN8fyVQsKILtHa2PMKotKxJz7DZLsaPeV+LMv1yPBqT/0gMAnunQfEm3
 kWOohYk8xdJk604zZh166vadg9iZOa+1/B0XzgzMw3xeZgAOzdU8kfd0gL8Wrqzx9lHb
 hX2kVLevSKe6q0C65LU7ldaDFReQ/0Jd2JGsWSVAqccmlv65McBzNVQqCUMh0e4/btWM
 XXJcZAb45fhrygmg4MtUa/xxAaVf3TNQtoXTX2S9I3ESc5d6At9VGd6gTwfY0vjn/B7y
 1f1+lwt8W+hEd7250kFupjZWOr6gWjFbNXeS+RhZ5H0mzwuwRDa4wMjBUTGZt+TTzagD
 H1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430119; x=1784034919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MO9yyG4iDSvkdyCCx+FcktxLSnSn72irxZUl2WAdbCI=;
 b=j2rmxzqsxxvLanzKQ7lWaN0EOW9UcG7Jmb2S3S2vOyZq9IEJ+LPR2egYao8RZWw/uZ
 sy9zvLoiwbVibPP1EqE9a4vykHqVAqNi/NuDByhAq3h4FBe5H4OZwjrWw7o8QcXdPjI2
 ikGrDrkOYngqLHN9Ypv4KNzlm+maAwHuTisXeB9BEL1rFeW+XN/tvMthFSCjzK+/HQ3c
 0ZcRaoDIVdPpA/3gWiNq+/tttQXjpNAciVRP7AJLYMg5CSVq+LTyREzluuake7yAAKfs
 vMQ88UGOIFmly6ih6rUYPeiZIKVgszfEThbAyBcKTR6T0gQAPAekXC0dbAvF53Diiigo
 yW9g==
X-Gm-Message-State: AOJu0YzkiUG19BFhyv/7T243FyQlHhAbmRrwAPV35PI+722SMGEtNgVc
 3oBWuCgEI8aGRv1DztqNwo0E/66bxid39zwW6GvsAskbQONpX4HDNlpW7xnqs5fdYkORtZp9TU/
 4qgnnAPDwBqQ2n9sBP3Ka97xPvEo0E2LhNN0s1IveceVnotWT7leUVp24G1EaP39/LA==
X-Gm-Gg: AfdE7cl+2Ulcuj0GJpQh5a7MkWjrr9dC5jOpKA38chcQrOsLZMOkES5RHOkQiiX4Fe7
 5App32q6BeEOh5f8T1hqKtt/cFGPCib71b/N3ATjquMcQDDvT0zLP5p9DHGMEEKnKoVPzJ2vCNW
 P8uazbi1iRYgib3B24KKsGqlFJYX3+up11g1L0k+fvlQNmAp7m6ApCXys9u5e5mOVl08y0qXtnc
 XsG4RE+/bdFn8PZqneYMDXZ36GJODxcdvGyrrVZAFBktwxfE9Qtca/JikkEz3JG2+Gyv5HxQo69
 oGQeyZ0x7MyAhMxq5+sFo0YGZAbegtcsYV3gZc0+dLN5zxJFzK0iaroMkVrlLOLDfz0JDJtP6YT
 yTC2OtS+/mRqr1kXVPB1saBUC3WsScmUhM+N944lxVCUJSkvR6Q21i9HaqIqIHqwSQ0xf
X-Received: by 2002:a05:622a:110f:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-51c747d0552mr54606241cf.24.1783430119285; 
 Tue, 07 Jul 2026 06:15:19 -0700 (PDT)
X-Received: by 2002:a05:622a:110f:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-51c747d0552mr54603761cf.24.1783430117513; 
 Tue, 07 Jul 2026 06:15:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19ce4ad4sm5832193a12.12.2026.07.07.06.15.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:15:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/32] backends/iommufd: Fix dev_id and type order in viommu
 trace
Date: Tue,  7 Jul 2026 15:12:14 +0200
Message-ID: <20260707131223.51505-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5MbIdNdGvLG7D-_7Ayrpn-vaptx4t4u-
X-Proofpoint-ORIG-GUID: 5MbIdNdGvLG7D-_7Ayrpn-vaptx4t4u-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX9Z/bflVhQ7/U
 zGiCqsc2KDEl+m+V82oZhlg6ZqkcLl1LbF1R5JjjPLmmuhgQS2htC6CoRcZLaaK4hdlizQdTIRY
 iVgHys9NnrS6IdbBDdkK7uGOOE3IckA=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4cfbe7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=UBPzl3ekHYB5lC0V6e0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXxzE1oFHN+xpf
 v3G9hYsstpwSy49fQAIHfuNuEF66dTu/63Kl0t00lTxgK6zYlyiOCqeJl0/flpMJ6A5I9dxztn+
 zkqwjMVYAN7iEIIh3ZSsjnVug8j8Q8Mny+2mMHklczx2zzzv0iiEcxMrCmb70Llx6AZ9ITeyKDz
 0MIV6GNLZWNpa1RfgH4/eClY2HdYyWahhViP8T1oW5plAx2C220HChICdqR5ycoyhrT6X1JDTmY
 8PUhDaVVIkWr/XE6S6DUVXd9LGqW3uHJYGHla9YaxZXukE3BjXyvA9qGIabEZphgtd/b/+Bime5
 IdiHxgnxsMcMEblfsw/ChhPW5/26bXnldhItQaM/k+5qdQTGl2ZMv6+kAPJLXx5t6hlwGuHWz7G
 3kOwQGKtYv90z1+ahJd/O3fnNPah6nBO2kaVZo8bygKtwNgq5sUYJu8GJ/uHQgyWEauNj8fAn8+
 JFvPKHa7cSjX9RwmI3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

The trace event receives dev_id before type, but its format string prints
them in the wrong order. Correct the order.

Fixes: f2d31df0d925 ("backends/iommufd: Introduce iommufd_backend_alloc_viommu")
Reported-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260706103653.84243-1-skolothumtho@nvidia.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 backends/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/trace-events b/backends/trace-events
index b63420b73ee..009a25b0be9 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,7 +21,7 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
-iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint64_t data_ptr, uint32_t data_len, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u data_ptr=0x%"PRIx64" data_len=0x%x viommu_id=%u (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint64_t data_ptr, uint32_t data_len, uint32_t viommu_id, int ret) " iommufd=%d dev_id=%u type=%u hwpt_id=%u data_ptr=0x%"PRIx64" data_len=0x%x viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t queue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t queue_id, int ret) " iommufd=%d viommu_id=%u queue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" queue_id=%u (%d)"
-- 
2.53.0


