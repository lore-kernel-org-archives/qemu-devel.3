Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA71CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ3Ni-0001oJ-0T; Mon, 15 Jun 2026 05:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ3Nc-0001lq-9O
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:13:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ3NZ-0000HT-Qm
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:13:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F99HTQ035918
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5eKOXCv/vInmR0M9o8Av3s
 sy5kZO4+VBTWH0JYfq89M=; b=kmM52Fj6rboWFjPMnZAS/lb6TCgpsnkguiwo2f
 qRR+x+bCQWx8nWuXsS0l+8+snCT1FFvIYaIvSAyMMowHgiWnewnEhwBGWIKFrGHF
 1e/pGqDJe0GYx7+l293XniWdtWdC2M6z9w/prBVp0IsBBuyezs5YtBECnV7xvHs8
 0NSwskGCrwyTQXmicWPUS6M4ktd+xjCsmaCnXwjX2VUmqiJ/KID7aMtH5gzY6jXx
 s+7uAMsYYrglqcWjItTBL++eBHwVHdpd1pAz/kB03rJqpsTRma3dKZtXRBYwF2lu
 Dq53xyVJff3djQOKfwo9BhLoceHMibHmJuzoUDbE1TGLIrOA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etegur0ka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:13:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91579011fd1so498380985a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781514791; x=1782119591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5eKOXCv/vInmR0M9o8Av3ssy5kZO4+VBTWH0JYfq89M=;
 b=F+SG6jx2r9L1eEarPwgWZFq8K14XiA938t/phYudx2YFqY7zoyodj9iAwWns4+rti/
 DmxxDrewdklHyiaVtg+01H3U9UEW0HeJfJs812QQAvgQh38obAxaEDV0pySTzrtAlvXo
 f30jprkYwm5yg4gCyPOQK9LEQ0XHYZH60cGeW9M2AcozOJ1kO94fEo4vdXC6qqb9iYdY
 dX7IlUk6n0l06n5suCEy0eEGzYA7woXU8nxRVbLuulikiIuJSTLM5kE6DzEdWxDOJnTz
 eRrmIHQpz5p9TPcqHIfRgj+uB37HgEcVyBo5kUep9IvY/YZHLwFGhWkfP576ARB3FSV/
 liTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781514791; x=1782119591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eKOXCv/vInmR0M9o8Av3ssy5kZO4+VBTWH0JYfq89M=;
 b=l+II6icVssbVRC9uO+HiX2cd4/MuJtROUNJjLlW7+VcqCVKBI5P1pwU4QYq5ylXCiO
 vl/sVJgCWU8JPXwfk+iMwpxLSIoE3CLhEvQLCvt+13sHKU8XJztFYLQYjHKIQCqbBH/o
 HS7w5R5nL7XHyhBQ3GguwLqmBqH9/Px09VZBGwLJVULFt4ChPYzrIQ79ScxtEuJHR4vI
 AcuQsNuj8U+NQiy2RCIzdxlS9OjCV/+FxIdc0yDSVuQs+dnISBCApvel7jzuN8EZOyHz
 HNuLiLc/nykq8AuX7iiqlomaxGIPAmTHlw5QRR2FEUJsmsMlgtyvRvxNys9c0WZwUhnr
 RW6g==
X-Gm-Message-State: AOJu0Yz/Dd+jUWbsSQCF2G5blnEIAUJ2K8U9XQiaaV0LcdL3+5FTKLNY
 PSmfibUHo9kiopX4C5JlmTiOsLRfOenxVQ8x6nLwnEuHEAn7fcp8ujo1xnHY5T49Ia0Z40a/suq
 CsCJjVylDOlLSLBStqU5IGBB1XcwhjoM+i/LZWCfKzKCgmVuWbI34Hmd1w2OmqXX9+Q==
X-Gm-Gg: Acq92OHgBeh6H7slaDFOrKOdAlP+jnZxCeZmyqjp+LqJ9uVw3uz/i4n66XzVTF+Tj9h
 i8nJk4/Z1EuvvJHRkqmu/9h3E0S8f7os1pavn0sJYs7dm0usrjUEQgicANgUUcNheTBeoRcYd1Q
 dNpkXgQ0L8s3LmDol1zF6RREFb+616+STGDIRZsaSyY0WZeIZT44zk+fZt0WLbxu4NQWf38DTp/
 26j20vgS3FIdHG99oD5jbzi70IBseDRM7DPXWjlJYrQev06uFvHT97CQSz3nRkOxvgxkxkGpggx
 h3EvCwGO06JBNsl8upGksLNpNE54FkdkQ8GPNfsbb7+E0ZWb+y4eC8iSrGiMNQ1i1y07qhOcYjK
 YxAK0YGSvBM20kIPzzPxSua2Rsp7TAWJGsySttenM9sgXZvgCU/3pm5ZSt++eUu5Y9fAAfx8VKc
 /eHRU=
X-Received: by 2002:a05:620a:272a:b0:914:b65f:6b00 with SMTP id
 af79cd13be357-9161bac4e82mr2152720885a.6.1781514791189; 
 Mon, 15 Jun 2026 02:13:11 -0700 (PDT)
X-Received: by 2002:a05:620a:272a:b0:914:b65f:6b00 with SMTP id
 af79cd13be357-9161bac4e82mr2152717285a.6.1781514790771; 
 Mon, 15 Jun 2026 02:13:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm35375932f8f.24.2026.06.15.02.13.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 02:13:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 0/2] misc: Remove pre-C99/C11 checks
Date: Mon, 15 Jun 2026 11:13:06 +0200
Message-ID: <20260615091308.4458-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5NiBTYWx0ZWRfX37UW+CqdRiIJ
 bmUv6jGpHsUU15xG0eAe8DiRcEJVn+inW2c75iZZ+KHLblNIctrbtfDvlmB76YhmtPzGUMP+nfb
 hSH0Hrp44CTtfVZfwhkQvcOsfQxj4Lt+RtV3GxguB+v9X8ewWtfYthxOhdHhKesIxB+GZ8ieegP
 Ju6Z/FqxJv77bQkirk1weJcQvRAR4wllAdWOiVWiVS6bL/jYyAZUY5mXyHSahiEZUMGeWiwEMQt
 nmDnPno+joNgJ6rpkE9E8s95zq/q/tcUtWlspc1OSehK2IoD93St7GI2zEUoLvCurkFWDAEDv5X
 EyCrgvavrXpuDQFZkygHzTUwimiExjktOJhE8xGo/OHOP0NinGfU06QHNGa3kHojo/8JujvoSdj
 btAn8VGskjz37AL5AI9OSEWhgjsGspaxtJ8Rp5u/8UAW02hc58Pw2IswJHd5gW2REdklAFORPeQ
 kJJK7RykSQNiXZCJq0g==
X-Proofpoint-ORIG-GUID: qPOct7vv6dGzUmf2svMDqkinI3K-Az6e
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a2fc227 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=2Kr2Ceio6qlyrOmMFMIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5NiBTYWx0ZWRfX5Y/XgYZAPwrQ
 laTKTY/1n3Pe8rOExdpQMjBqLOoiCa/0FVKG2UsVZUb/MoVUYbBKV8W2mcJnzKgQixZhxamM6a2
 bZmHcuxPIn4zntUZMrWxBUIlWjHaSDE=
X-Proofpoint-GUID: qPOct7vv6dGzUmf2svMDqkinI3K-Az6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150096
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

We uses C11 since 5 years now, time to
remove few obsolete __STDC_VERSION__ checks.

v2:
- Correctly use flexible array member (Bastian)

Philippe Mathieu-Daudé (2):
  hw/xen/interface: Remove pre-C99 checks
  qom/object: Remove pre-C11 check

 include/hw/xen/interface/physdev.h    |  2 +-
 include/hw/xen/interface/version.h    |  5 ++---
 include/hw/xen/interface/xen-compat.h |  2 --
 include/hw/xen/interface/xen.h        | 14 --------------
 qom/object.c                          | 14 +-------------
 5 files changed, 4 insertions(+), 33 deletions(-)

-- 
2.53.0


