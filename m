Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3206AC88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HM3-0004Zw-W2; Mon, 14 Sep 2026 20:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLk-0004Ok-5e
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLZ-0004Bj-BW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:32 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EMxlvK2826256
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=66fr/AyD+sY
 Z/HNyQC3BvqmbrjLog4n6WQKFRGNY/pA=; b=KCo3QoYXAK/89EqxiSpPHD8vJcp
 Wd44g3p7myUYPy0bqDZqpv/6M1No4SmtAR8ljHAaETTPSt5Ju+bWUYZi4N29zt16
 buWKBp1YRWypYV3BaTU3/ltW5w+QhpyOF/phZvh15zpYc+M2K9XVSRf09cv/DZpg
 1+BAtv57kj0FXqX2WVbAwSrvh0dofG2Ark/EB1xexJvDE20XV8IWLATmvTEuJZo6
 sFBUaj0QfP5wJbAD1Qu2zB8hfLS7c8T+CciPaOKtklPLPYFjuUMACO7DwJjv6q8L
 QB9LMJhKdudbwdwmM2mqmDpK/xhlcOFzryu01yIdnJavQafq78Qr66cntjg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpn41sdtq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1bbd7d6e6so3032252a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433297; x=1790038097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=66fr/AyD+sYZ/HNyQC3BvqmbrjLog4n6WQKFRGNY/pA=;
 b=Mdac3uqgAcJlvPi5uGhkWbu2cB231rZ6ngBom4gTL4vnozp/pyzF36Xm0lh+3cT3wR
 W3IaZPryHEdIuf19G6ff7D9Lgg+1/bUK+93RvC021nfLbIXFXfbXnrcWzpLCJ6yGhC+k
 55TaqcHOZI45zcC1FBcv/vN6r4Z1LGma5e6F3E7U3sablohkrQFljyq1NjeYM7sLZkVQ
 4W1l4S1z674Qqep7X9XK/9vFrNbezsViMfQNnzApxm5rmLKm4szRnPv4bqsWacUVM7On
 yRclUKyKU7QIaCo7sqIHp2UTDISWskIqpsJ9TTVdERT0tUJRkVhJgLDN9lfG4KfkrTDZ
 KPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433297; x=1790038097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=66fr/AyD+sYZ/HNyQC3BvqmbrjLog4n6WQKFRGNY/pA=;
 b=FwoZFjsRwsPEXfNW4rtx/KC4VzeomtKu/uVsN2g0YQtBikCW3vWq57lOosWYx6yEjY
 uNGZv4vomG0z0o6ZWTyNAa7NDV5uRemD5LXplZm5yli8dhXu3LITh69KHgvgJGiZlJhq
 Mdb1KegHwFyG9rvYf+aEuL/giBFemic1ncL2iPfyZp+/vQkDZDwnkAWvMNuLBfp/rOxy
 3zg6zg0TUTh2lZ46lKD7yRoldzSAYLcjnZ/fWVe69h07/KG6DGlvq3H24po2fZ5pIUxi
 0Rbji6ewjqLbv4QwqjHcN1EuxnA4TWr1iOP6BPxloINpBIiCORCn68Re0CxMGuRdkNoR
 FSxg==
X-Gm-Message-State: AFuF++mdU5BagVVL5AUfrbAVP1HOeQV8nIgmsGXxW5AE5Oe2Ig6Fg1Gv
 nne8msLCnFsLswH9gwlD2atlTdmvvVeQ8HVuLLit9cz+7vx19HohbZmnNAw33GxKdTb8zk50CJU
 fQAIDOnDch5Vs7yCyNrtRyTnLS+UvUosiYAHe2qDVBjNDb60GSlgsxqcQ7Fqi0Pt2MQ==
X-Gm-Gg: AYBFou0HjpoyGy1B2owTpnD02gsHKzV6dpbyhLqKxR+vHXFGv85c7HLmd5tRyterNxd
 J7xrjAnhGtTyrajNIKTT1SlbfH2gT+89X5naZBnWE6SzaQFn/3NcBD9864e62bcy7jP0CrQin1I
 yaDRh0fOxM0B4i9xQ74pJ3vp7Oc6+A0waVbmTqG3I0Kwdaw2rbZvPrLWD3p4Dv47SXuBTczUvnu
 iZfxysDrFPmAmsVmjrgA2mgFHo8pWpcNjpWNCscUIHKzIWZuoGuvp9rUfH1yFGYNnZR6AcIG5uf
 9Zg0wZ/m9m7OihysowLt21Ry21qOkaEQmLaws+vZJlE+3VrDjok/jLgZvCG8EmVXLnnPwF/g0yo
 TQm91AxCoutL7/IIagIHyIblicvjoe1iHKEGgdQ6NScnYO4ybDRtTRfbx0lg=
X-Received: by 2002:a17:903:1b46:b0:2d9:26b3:547 with SMTP id
 d9443c01a7336-2dd6c74b2c8mr100184775ad.20.1789433296976; 
 Mon, 14 Sep 2026 17:48:16 -0700 (PDT)
X-Received: by 2002:a17:903:1b46:b0:2d9:26b3:547 with SMTP id
 d9443c01a7336-2dd6c74b2c8mr100184075ad.20.1789433296449; 
 Mon, 14 Sep 2026 17:48:16 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf015csm31978309eec.4.2026.09.14.17.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:48:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-ppc@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 5/6] roms: move s390-ccw from pc-bios
Date: Tue, 15 Sep 2026 00:48:01 +0000
Message-ID: <20260915004802.5749-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfXw+rWRi4H2QnM
 kortaP7ehRK+3D9/MB21tuM4zRbFSpwrhyV/DPWEgRKPnxYQviGZlhfof0Tgna2yVTdN8ZfQUEn
 vHWqYGEfHoP7djs1LKTZ8uvecsTT7eFUzuvuMDFBhmahIF3lLG5wuGpGQ4Hi68zyF3jDhaV4tbx
 sT3wU8FVmXmR80Pc3ScLmcexRCftliiqsmsYLah5aKTXiHNX8+KPIQheVmHJLpiKsFDwcMjvTgH
 N7O0zHsNJSvwTDhgq/M/nRdRfIQifpZedzWNUr9zkRaK2j28TqlUste4mWvNgCyJCo6+K45z51j
 o/1brN6HD3kV875X264dSXjzgBH+5ppXZNak/ABdFAtsGrXEj4uw8i5c7wbeOEMwtntiuXANmX/
 LAwjUcNeAeCavcsuHXzNCInj+VrCIfMWf6veiSPtCf6OZ30lvOloKAoBOEKKePIUnqDpoIO71Fz
 8SxToMmPMW0Aq8efy/w==
X-Proofpoint-GUID: 72m0V9QMwvyzgtx8Tpd0KnpRJEOYXgnJ
X-Authority-Analysis: v=2.4 cv=cqQOAF4i c=1 sm=1 tr=0 ts=6aa895d1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=kDBHy33qXil3-RicLqoA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 72m0V9QMwvyzgtx8Tpd0KnpRJEOYXgnJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfXws69TRHcze+j
 h4C7x1H/HsiIGAeJQioOBBHhG8poRfJgUyBpOQ+LoSzedSL4ETqMyLvJhXeBVkx3WDAAbzKn4wb
 VmyFcU171I7ny95k2l5SLWR7kwo5nKs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150006
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Update include from tests/tcg/s390x accordingly.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS                                | 2 +-
 {pc-bios => roms}/s390-ccw/Makefile        | 0
 {pc-bios => roms}/s390-ccw/bootmap.c       | 0
 {pc-bios => roms}/s390-ccw/bootmap.h       | 0
 {pc-bios => roms}/s390-ccw/bswap.h         | 0
 {pc-bios => roms}/s390-ccw/cio.c           | 0
 {pc-bios => roms}/s390-ccw/cio.h           | 0
 {pc-bios => roms}/s390-ccw/clp.c           | 0
 {pc-bios => roms}/s390-ccw/clp.h           | 0
 {pc-bios => roms}/s390-ccw/dasd-ipl.c      | 0
 {pc-bios => roms}/s390-ccw/dasd-ipl.h      | 0
 {pc-bios => roms}/s390-ccw/helper.h        | 0
 {pc-bios => roms}/s390-ccw/iplb.h          | 0
 {pc-bios => roms}/s390-ccw/jump2ipl.c      | 0
 {pc-bios => roms}/s390-ccw/main.c          | 0
 {pc-bios => roms}/s390-ccw/menu.c          | 0
 {pc-bios => roms}/s390-ccw/netmain.c       | 0
 {pc-bios => roms}/s390-ccw/pci.c           | 0
 {pc-bios => roms}/s390-ccw/pci.h           | 0
 {pc-bios => roms}/s390-ccw/s390-arch.h     | 0
 {pc-bios => roms}/s390-ccw/s390-ccw.h      | 0
 {pc-bios => roms}/s390-ccw/s390-time.h     | 0
 {pc-bios => roms}/s390-ccw/sclp.c          | 0
 {pc-bios => roms}/s390-ccw/sclp.h          | 0
 {pc-bios => roms}/s390-ccw/scsi.h          | 0
 {pc-bios => roms}/s390-ccw/secure-ipl.c    | 0
 {pc-bios => roms}/s390-ccw/secure-ipl.h    | 0
 {pc-bios => roms}/s390-ccw/start.S         | 0
 {pc-bios => roms}/s390-ccw/virtio-blkdev.c | 0
 {pc-bios => roms}/s390-ccw/virtio-ccw.c    | 0
 {pc-bios => roms}/s390-ccw/virtio-ccw.h    | 0
 {pc-bios => roms}/s390-ccw/virtio-net.c    | 0
 {pc-bios => roms}/s390-ccw/virtio-pci.c    | 0
 {pc-bios => roms}/s390-ccw/virtio-pci.h    | 0
 {pc-bios => roms}/s390-ccw/virtio-scsi.c   | 0
 {pc-bios => roms}/s390-ccw/virtio-scsi.h   | 0
 {pc-bios => roms}/s390-ccw/virtio.c        | 0
 {pc-bios => roms}/s390-ccw/virtio.h        | 0
 tests/tcg/s390x/console.c                  | 4 ++--
 tests/tcg/s390x/head64.S                   | 4 ++--
 40 files changed, 5 insertions(+), 5 deletions(-)
 rename {pc-bios => roms}/s390-ccw/Makefile (100%)
 rename {pc-bios => roms}/s390-ccw/bootmap.c (100%)
 rename {pc-bios => roms}/s390-ccw/bootmap.h (100%)
 rename {pc-bios => roms}/s390-ccw/bswap.h (100%)
 rename {pc-bios => roms}/s390-ccw/cio.c (100%)
 rename {pc-bios => roms}/s390-ccw/cio.h (100%)
 rename {pc-bios => roms}/s390-ccw/clp.c (100%)
 rename {pc-bios => roms}/s390-ccw/clp.h (100%)
 rename {pc-bios => roms}/s390-ccw/dasd-ipl.c (100%)
 rename {pc-bios => roms}/s390-ccw/dasd-ipl.h (100%)
 rename {pc-bios => roms}/s390-ccw/helper.h (100%)
 rename {pc-bios => roms}/s390-ccw/iplb.h (100%)
 rename {pc-bios => roms}/s390-ccw/jump2ipl.c (100%)
 rename {pc-bios => roms}/s390-ccw/main.c (100%)
 rename {pc-bios => roms}/s390-ccw/menu.c (100%)
 rename {pc-bios => roms}/s390-ccw/netmain.c (100%)
 rename {pc-bios => roms}/s390-ccw/pci.c (100%)
 rename {pc-bios => roms}/s390-ccw/pci.h (100%)
 rename {pc-bios => roms}/s390-ccw/s390-arch.h (100%)
 rename {pc-bios => roms}/s390-ccw/s390-ccw.h (100%)
 rename {pc-bios => roms}/s390-ccw/s390-time.h (100%)
 rename {pc-bios => roms}/s390-ccw/sclp.c (100%)
 rename {pc-bios => roms}/s390-ccw/sclp.h (100%)
 rename {pc-bios => roms}/s390-ccw/scsi.h (100%)
 rename {pc-bios => roms}/s390-ccw/secure-ipl.c (100%)
 rename {pc-bios => roms}/s390-ccw/secure-ipl.h (100%)
 rename {pc-bios => roms}/s390-ccw/start.S (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-blkdev.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-ccw.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-ccw.h (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-net.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-pci.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-pci.h (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-scsi.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-scsi.h (100%)
 rename {pc-bios => roms}/s390-ccw/virtio.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index da1f960651f..08d9d5319fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1962,7 +1962,7 @@ S: Supported
 F: hw/s390x/ipl.*
 F: hw/s390x/cert-store.[ch]
 F: include/hw/s390x/ipl/
-F: pc-bios/s390-ccw/
+F: roms/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: docs/devel/s390-dasd-ipl.rst
 F: docs/specs/s390x-secure-ipl.rst
diff --git a/pc-bios/s390-ccw/Makefile b/roms/s390-ccw/Makefile
similarity index 100%
rename from pc-bios/s390-ccw/Makefile
rename to roms/s390-ccw/Makefile
diff --git a/pc-bios/s390-ccw/bootmap.c b/roms/s390-ccw/bootmap.c
similarity index 100%
rename from pc-bios/s390-ccw/bootmap.c
rename to roms/s390-ccw/bootmap.c
diff --git a/pc-bios/s390-ccw/bootmap.h b/roms/s390-ccw/bootmap.h
similarity index 100%
rename from pc-bios/s390-ccw/bootmap.h
rename to roms/s390-ccw/bootmap.h
diff --git a/pc-bios/s390-ccw/bswap.h b/roms/s390-ccw/bswap.h
similarity index 100%
rename from pc-bios/s390-ccw/bswap.h
rename to roms/s390-ccw/bswap.h
diff --git a/pc-bios/s390-ccw/cio.c b/roms/s390-ccw/cio.c
similarity index 100%
rename from pc-bios/s390-ccw/cio.c
rename to roms/s390-ccw/cio.c
diff --git a/pc-bios/s390-ccw/cio.h b/roms/s390-ccw/cio.h
similarity index 100%
rename from pc-bios/s390-ccw/cio.h
rename to roms/s390-ccw/cio.h
diff --git a/pc-bios/s390-ccw/clp.c b/roms/s390-ccw/clp.c
similarity index 100%
rename from pc-bios/s390-ccw/clp.c
rename to roms/s390-ccw/clp.c
diff --git a/pc-bios/s390-ccw/clp.h b/roms/s390-ccw/clp.h
similarity index 100%
rename from pc-bios/s390-ccw/clp.h
rename to roms/s390-ccw/clp.h
diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/roms/s390-ccw/dasd-ipl.c
similarity index 100%
rename from pc-bios/s390-ccw/dasd-ipl.c
rename to roms/s390-ccw/dasd-ipl.c
diff --git a/pc-bios/s390-ccw/dasd-ipl.h b/roms/s390-ccw/dasd-ipl.h
similarity index 100%
rename from pc-bios/s390-ccw/dasd-ipl.h
rename to roms/s390-ccw/dasd-ipl.h
diff --git a/pc-bios/s390-ccw/helper.h b/roms/s390-ccw/helper.h
similarity index 100%
rename from pc-bios/s390-ccw/helper.h
rename to roms/s390-ccw/helper.h
diff --git a/pc-bios/s390-ccw/iplb.h b/roms/s390-ccw/iplb.h
similarity index 100%
rename from pc-bios/s390-ccw/iplb.h
rename to roms/s390-ccw/iplb.h
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/roms/s390-ccw/jump2ipl.c
similarity index 100%
rename from pc-bios/s390-ccw/jump2ipl.c
rename to roms/s390-ccw/jump2ipl.c
diff --git a/pc-bios/s390-ccw/main.c b/roms/s390-ccw/main.c
similarity index 100%
rename from pc-bios/s390-ccw/main.c
rename to roms/s390-ccw/main.c
diff --git a/pc-bios/s390-ccw/menu.c b/roms/s390-ccw/menu.c
similarity index 100%
rename from pc-bios/s390-ccw/menu.c
rename to roms/s390-ccw/menu.c
diff --git a/pc-bios/s390-ccw/netmain.c b/roms/s390-ccw/netmain.c
similarity index 100%
rename from pc-bios/s390-ccw/netmain.c
rename to roms/s390-ccw/netmain.c
diff --git a/pc-bios/s390-ccw/pci.c b/roms/s390-ccw/pci.c
similarity index 100%
rename from pc-bios/s390-ccw/pci.c
rename to roms/s390-ccw/pci.c
diff --git a/pc-bios/s390-ccw/pci.h b/roms/s390-ccw/pci.h
similarity index 100%
rename from pc-bios/s390-ccw/pci.h
rename to roms/s390-ccw/pci.h
diff --git a/pc-bios/s390-ccw/s390-arch.h b/roms/s390-ccw/s390-arch.h
similarity index 100%
rename from pc-bios/s390-ccw/s390-arch.h
rename to roms/s390-ccw/s390-arch.h
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/roms/s390-ccw/s390-ccw.h
similarity index 100%
rename from pc-bios/s390-ccw/s390-ccw.h
rename to roms/s390-ccw/s390-ccw.h
diff --git a/pc-bios/s390-ccw/s390-time.h b/roms/s390-ccw/s390-time.h
similarity index 100%
rename from pc-bios/s390-ccw/s390-time.h
rename to roms/s390-ccw/s390-time.h
diff --git a/pc-bios/s390-ccw/sclp.c b/roms/s390-ccw/sclp.c
similarity index 100%
rename from pc-bios/s390-ccw/sclp.c
rename to roms/s390-ccw/sclp.c
diff --git a/pc-bios/s390-ccw/sclp.h b/roms/s390-ccw/sclp.h
similarity index 100%
rename from pc-bios/s390-ccw/sclp.h
rename to roms/s390-ccw/sclp.h
diff --git a/pc-bios/s390-ccw/scsi.h b/roms/s390-ccw/scsi.h
similarity index 100%
rename from pc-bios/s390-ccw/scsi.h
rename to roms/s390-ccw/scsi.h
diff --git a/pc-bios/s390-ccw/secure-ipl.c b/roms/s390-ccw/secure-ipl.c
similarity index 100%
rename from pc-bios/s390-ccw/secure-ipl.c
rename to roms/s390-ccw/secure-ipl.c
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/roms/s390-ccw/secure-ipl.h
similarity index 100%
rename from pc-bios/s390-ccw/secure-ipl.h
rename to roms/s390-ccw/secure-ipl.h
diff --git a/pc-bios/s390-ccw/start.S b/roms/s390-ccw/start.S
similarity index 100%
rename from pc-bios/s390-ccw/start.S
rename to roms/s390-ccw/start.S
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/roms/s390-ccw/virtio-blkdev.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio-blkdev.c
rename to roms/s390-ccw/virtio-blkdev.c
diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/roms/s390-ccw/virtio-ccw.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio-ccw.c
rename to roms/s390-ccw/virtio-ccw.c
diff --git a/pc-bios/s390-ccw/virtio-ccw.h b/roms/s390-ccw/virtio-ccw.h
similarity index 100%
rename from pc-bios/s390-ccw/virtio-ccw.h
rename to roms/s390-ccw/virtio-ccw.h
diff --git a/pc-bios/s390-ccw/virtio-net.c b/roms/s390-ccw/virtio-net.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio-net.c
rename to roms/s390-ccw/virtio-net.c
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/roms/s390-ccw/virtio-pci.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio-pci.c
rename to roms/s390-ccw/virtio-pci.c
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/roms/s390-ccw/virtio-pci.h
similarity index 100%
rename from pc-bios/s390-ccw/virtio-pci.h
rename to roms/s390-ccw/virtio-pci.h
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/roms/s390-ccw/virtio-scsi.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio-scsi.c
rename to roms/s390-ccw/virtio-scsi.c
diff --git a/pc-bios/s390-ccw/virtio-scsi.h b/roms/s390-ccw/virtio-scsi.h
similarity index 100%
rename from pc-bios/s390-ccw/virtio-scsi.h
rename to roms/s390-ccw/virtio-scsi.h
diff --git a/pc-bios/s390-ccw/virtio.c b/roms/s390-ccw/virtio.c
similarity index 100%
rename from pc-bios/s390-ccw/virtio.c
rename to roms/s390-ccw/virtio.c
diff --git a/pc-bios/s390-ccw/virtio.h b/roms/s390-ccw/virtio.h
similarity index 100%
rename from pc-bios/s390-ccw/virtio.h
rename to roms/s390-ccw/virtio.h
diff --git a/tests/tcg/s390x/console.c b/tests/tcg/s390x/console.c
index 061b9437d98..34b9c7f86ea 100644
--- a/tests/tcg/s390x/console.c
+++ b/tests/tcg/s390x/console.c
@@ -1,11 +1,11 @@
 /*
  * Console code for multiarch tests.
- * Reuses the pc-bios/s390-ccw implementation.
+ * Reuses the roms/s390-ccw implementation.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include "../../../pc-bios/s390-ccw/sclp.c"
+#include "../../../roms/s390-ccw/sclp.c"
 #include "string.h"
 
 
diff --git a/tests/tcg/s390x/head64.S b/tests/tcg/s390x/head64.S
index 0523fcacb33..23b15ea1a72 100644
--- a/tests/tcg/s390x/head64.S
+++ b/tests/tcg/s390x/head64.S
@@ -1,11 +1,11 @@
 /*
  * Startup code for multiarch tests.
- * Reuses the pc-bios/s390-ccw implementation.
+ * Reuses the roms/s390-ccw implementation.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #define main main_pre
-#include "../../../pc-bios/s390-ccw/start.S"
+#include "../../../roms/s390-ccw/start.S"
 #undef main
 
 .text
-- 
2.43.0


