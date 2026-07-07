Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EA5C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAOA-0008Gf-U9; Tue, 07 Jul 2026 14:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whANJ-0007eO-Tg
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:18:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAN9-0006gU-8v
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:18:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FSwHJ045466
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rNdzhmMd3pzAiLNXaTNayxj0g21OJfaad1a7HKl1sDs=; b=obBwqBA29FxijbCs
 bQHk0khpfZf9R0zrhIGdt2WHaj7enk0YIF4ZnYBQxqvzWAv4/cHat4th3aMMNYl3
 m5UeIF9WrSrzcEXF9PBVFn1U7jGe9dnihyOyrq4hzN/NeR+SneMTvbs1zqx91zDi
 jopz7K91znAEYzuykW0YAdLHwzaeiqwAhv0iztVggYrW60ZHkX9hbh5JwH980OMB
 /1nrq/Na9Ir6HS2K+5mSE1ob4jvaEj05ORB65cNegw4f383/vAe/1Jf+1OKFvmbT
 b/brT2idn+90jNoB6i/2c+LvzzqBfBTu3r1vFEgoVKp3kzjhHd0cuNwuLaDfWNo8
 9NSqkQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w11trf4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:18:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-517e054fe07so83291971cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448297; x=1784053097; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rNdzhmMd3pzAiLNXaTNayxj0g21OJfaad1a7HKl1sDs=;
 b=aSdOvXm4a1IbovdguNo+jaz458PBTlqQTTbDS7UzjgCI/x/wIGC+L8Qdo4TIZAp7y/
 dAqFPeB2H9wXbLzqjZ3Mhf+dfd2RHU9CYiFrs9/Jc+MZWLPI1hukVU//uI0h0G9BpONh
 8OezAkivuzD/S28GjOySPJbaPjm15wV+vQENPImVqj1N172Eu5QcgBnC3NwP8NPUuNaQ
 I9EF+B2GEy987jTIJKvANCsEggRkoX+GMokd3dWy9hFW2V3R/mLls85wMXFJ1gS3zl0j
 6aZgOmBHTxI2qj5faHoKjPb+WRnETUSzjJCharrlbnwRVnDGc4TCUmeOmsonFDiZGvGL
 WXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448297; x=1784053097;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rNdzhmMd3pzAiLNXaTNayxj0g21OJfaad1a7HKl1sDs=;
 b=CCKEslFJ0WO7YcdAwoYsxdiNF5ChoapTufYkYkiV7fOuB6UblBuZ5Xi7p0+71AGjck
 dF5Ga4PAKi9p/FLrK9HkVAoFhKCE18N+BbI4tSUHL6jvuVzA93e+KnbMs4cYCp04dMXn
 NPLfRfZn5/E9cyDglCbYxOiZ89PAMWanx1yP0Imi71eKv1FduAHyGmTjPuUED7tOYWiK
 Cg9POxlnj0j5//7515gt3c46v4XRYhby3k0j4XXdZm8T2j6v2pgjgx2duvFrp/8WvOuV
 rRGcjqlbOxGzUdGPQTO/k4M65HHlcVLSXvGuYLMwuMPhOLQBvez00Bry819HcsJOfcio
 zCWQ==
X-Gm-Message-State: AOJu0YxaUXsSskqtI5QoAiUdepN26uTCpCRi/fbrqwbGQA6+H7pYba4J
 PITkVW+MCrLAcfIyBZIgwv51pgOj/XkIIWWNWEu7vAq1MflkjQIEykbm1ovwVrvDi/wvS5mcWY1
 4AetJ1XD9nCp/wofWiW7GksolvEa/PD2YaJtNZq4VlJrq1fOe3ZupRJJrY6VlUsKyKQ==
X-Gm-Gg: AfdE7cmKqvQinONLvA6D8Dilsc+KxzhCD8fAeI5WReTXQ0nzpEnEAOPmZaKiFBBauCH
 dMvtPn5MSFiGtRYvfd5bztIgweGh1eUfflz1s4reO+r78gh+scn4+wz6Wfa3kWq5DnnAuoHXsZ0
 2a+uO/a28JcN+7e3TrlyHdRyc4KAxDkadqIcupgKVDCrVjGHcDAWTQvxf8XgkzOoQrz/NdM2pQ8
 yTJCez1tetSMrjH6lteFfY60wKD93kn3ymdFo4fQ6qtX4sCpX6OIn67jLcoQpwcdYL5gyqwS5Ly
 MZVMYvsEDk06dJLfyq18Nwv38DSzCdZllXM1f5kYC40GxxsJn0MJ6w8KfA0BkLL1ubHfB0Z/YIw
 a2xGUc/OT5AWegrgLj+jPzej9VpTasZoVKDTNxJJvSolTWufqmMZg+pcurRggoW81qMPS
X-Received: by 2002:a05:622a:1a91:b0:51c:f4f:b3ab with SMTP id
 d75a77b69052e-51c747d5315mr69714271cf.20.1783448296291; 
 Tue, 07 Jul 2026 11:18:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1a91:b0:51c:f4f:b3ab with SMTP id
 d75a77b69052e-51c747d5315mr69711321cf.20.1783448292488; 
 Tue, 07 Jul 2026 11:18:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f40d50sm81809285e9.5.2026.07.07.11.18.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:18:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/23] qemu-options: Do not list -enable-kvm on MIPS binaries
Date: Tue,  7 Jul 2026 20:15:28 +0200
Message-ID: <20260707181529.60191-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DMe/JSNb c=1 sm=1 tr=0 ts=6a4d42e9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=lxiqw3fu-qJSzJVeTUcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 99KvFYYtVimwVg7tgS6VhQ-wfIDIbELK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfX+Ww3/sOw9YCF
 mZU1joBj7aySCwgHUg28Ek4zi+/H4dxy5P+IyaKYYPZc3ifMnMRYj2OjXilJK91K5lBWpAFx79b
 8V4SlaDMTaMbpXOnelfbfDqzQ6HAw4M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfX3qS0SwLuc8Kf
 cSccnjmVg9OCgQoofzg2iC/qc9rEEmCB6rrIkwVxSX+Zddzzwu7trf1xRBGaL+SzWKXa6T1jBnp
 kSBpm5ivyNxC8rqI74SoI1CP3b9XH6g9XTqXXZ+GGdIRzi6lfcdyc3jKCnj0IQNlP+Otbu/FGCP
 dX50EnidIAe5/IPp3qCx2hKXnN4gNdjddHoD/jzfrGNz9FOA0VFDCHmqOykzUekP9nEQwXzMgUg
 VtTQV1KOAJ/ags1X1ZaKY7i7RGg6fZzCSKtO4vjfv4EFmZyI/HU5ls5lDX9ANQzVkyncrF7UWLv
 zf20XI6TpXRRN351JxsCifBHbV51O1jmUfCrZoVlHIgHB0kC10ME6AKj5xCmh8t6hNFBaE7K8U5
 j7bycGeUj+riOw6bFSeLIrrdII1a2Jscs9rHaOrD2OydhFTXUjL434hiP9DHQAeNUs33itKfT3L
 NgMoRA2CGyxGfiQCLcQ==
X-Proofpoint-ORIG-GUID: 99KvFYYtVimwVg7tgS6VhQ-wfIDIbELK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070180
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

When removing KVM support in commit 630decdfccd we forgot
to remove MIPS of the '-enable-kvm' option help. Do it now.

Fixes: 630decdfccd ("buildsys: Remove MIPS KVM")
Inspired-by: Miao Wang <shankerwangmiao@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260707095723.36591-1-philmd@oss.qualcomm.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index e44b47de681..ccb71743ee3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5163,7 +5163,7 @@ ERST
 
 DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
     "-enable-kvm     enable KVM full virtualization support\n",
-    QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_MIPS | QEMU_ARCH_PPC |
+    QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_PPC |
     QEMU_ARCH_RISCV | QEMU_ARCH_S390X)
 SRST
 ``-enable-kvm``
-- 
2.53.0


