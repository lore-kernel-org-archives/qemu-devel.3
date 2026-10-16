Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D86CCCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmTG-0008CY-Oy; Fri, 16 Oct 2026 14:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmSG-0007G7-IP
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmSB-0000b4-KM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:55 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5i8l1910949
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uQDe13YUXK4
 YusvjpfWgjXR/f6CikfAsxadvLUPo9pc=; b=cYODfx8xAqbvVxfJoFhvApx/Zi7
 w34D9l2/phTJ1sUBX41xV33E2usXVVg2UCCgNMdB8VgmxqeTK9UDMhCraKZplfhB
 gDIOeDq2VvVWBYsC9j6h0bopOWxMouBH6yKh8vydaw/p2L1NkNXF3CWn69N7vJj+
 rXwS/pXZhku/WAzEB8txrfR03V0Fwj5hHYRcUthDYGrjsK/zEgRfUZRzVplNoVtw
 KRbpF4x1g2EuzTK8HINjHVdsXgUVfciQ1q6kjZBplXSn+2w8zl5kp+JNC68bPVYN
 GUpsaWIGCxwrwzQI4BoacDwVjwkiDZlXtq44wnUUleZI1m5hZ4yROrOnT1Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmf9mxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab926c236aso209436a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174487; x=1792779287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uQDe13YUXK4YusvjpfWgjXR/f6CikfAsxadvLUPo9pc=;
 b=J+u39599uGcP38ynpL1gatshd70VDeZennTSfo3aHX2lhkhc2wf6xjZUyfU2+qfk7p
 AckEXNzxwGgbCUTLcEqrrd3nJDv8DIbBmhyiFsBDI7nKz9s9MBUnIcEJk0onZeTNE+E2
 ihneayXgWk7ZuKuNslzg7Ge/aECpdWMK9thXJcqREaGyiBXPRWwCaUbQwWzPuBvWhFfe
 5PB8KWxMGPiFB5gxTOOor20oAjgPZEykMP2puFhtZFnJ278khErZtqRZE+kbtAQseX80
 gimSZ5i0kFJLvKhsbcKBZoWk+hSCOOrpIYOhTgo3lNPrtPlPR7i/U93c+nAxg+Pnq8p1
 V/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174487; x=1792779287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uQDe13YUXK4YusvjpfWgjXR/f6CikfAsxadvLUPo9pc=;
 b=Wy3w6eXNxwO4DX5uPehxORLeaSdp5VNxfMt3CJufYffl/NHM0h96UVFdyy6UNBhCiV
 6hgwmspUxa9fdUZBNiXq5OwvVpNF2r5FlcjvpnLyRYiKNkxIqzUsY3nwTHnUnFPTIPkR
 +JOqGtCnktMo7nc5YHEvO3KYbnm8LVex2pQ1jrrulg1SGjqbLhH1E4kGTbFQR/mCt6cz
 d+blluf31r31R10aE1igHCwejNEo02+9jlXu7UmwCZq/4XJlA8P5JOeJ8+8obIMxyXk1
 ziugly7w8imQ2G9SeQmjeUBuFAfibjLdfIQWt16K96WWYG/9cW838d1wKcBP2HvmW3Wf
 vJDA==
X-Gm-Message-State: AFq9FYLh50uZPUiL5U125agkpYMSdSjQ41gs3E4Ul+egsa7svijQhqEy
 0M/SabwUEYVRWMB7VvGmKF7DyIp0AfyRFZ8zJPe0ToTYRHwtsueM17OkxbYcEU+NPqbsicVhdKK
 4Fj9QXojfcSB8hztP5ESvl/22JCdCZBbVzF8PHWdXfzFOfe01z/WjDqyyKV9jYX7Gwg==
X-Gm-Gg: AYBFou2HBvDXk1jzH8a+95XZlK94f8poUkhNfB6KX3lj9tP4hUkOp1fICtNaobaZwEr
 CXa4h6foxr8XSvs0NDO0REsRlMxNbn4924DNQLgeHigZmhoy3S4RUPKpNbDLVIfQVEx9aPoyJ1/
 BQHAGDTxPjjlGpT89Rpf8w6m3CAVaAa+/qhPyZ7XfSvqqOP65O2u8z3MyZuE4K2CmrS8090dmDk
 xwebNj1b9ZVmPxKKwg/I3fopGQnmqaus7ECXATPRbrMdxWP/7y9Hv6+H3ewh43qUnehrccK+qp1
 HO1NFI1vNG3SLaSrkwojqnOgj91BeMx1cT73LVqM8m/XsEBsU0+DtnD56zkwwtBtVMePCGDt8Ii
 zmlYM6PQTjoImtAFv2JvlazK+k20YT3lau7sYUdS2ersDp6Rg3lsvQIaRNFGQNz8=
X-Received: by 2002:a17:90b:55c6:b0:3ac:80dc:f419 with SMTP id
 98e67ed59e1d1-3acef144e49mr490627a91.25.1792174487165; 
 Fri, 16 Oct 2026 11:14:47 -0700 (PDT)
X-Received: by 2002:a17:90b:55c6:b0:3ac:80dc:f419 with SMTP id
 98e67ed59e1d1-3acef144e49mr490607a91.25.1792174486678; 
 Fri, 16 Oct 2026 11:14:46 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 22/23] dump: use get_note_size sysemu op
Date: Fri, 16 Oct 2026 11:14:09 -0700
Message-ID: <20261016181410.191743-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0BrucET2Y4vgC2Q3z8gYmPeNUd7hJzAF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfXyYcSwoRpE/0H
 O37GsS6AqeNxdEmSvM9tHU5w6eRYR+9EMpiIIBUISbC0a4dB8zc8arGPQKySmTrotyO4YUN0Xsh
 2ZwOzEwrU4CjO3afX1l8W8ARYrrZXgA=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad26998 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=4q89r5wyS8jGYcIIz-oA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 0BrucET2Y4vgC2Q3z8gYmPeNUd7hJzAF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfXwk7/7JuEOGmf
 GxoLdZwRIgNjnIIUu+3ldVXPYw1aSShOqRww7Z1VLP2vN1QwkwpxgVoXYoaohIL++92ZxI9VoyV
 QnLVmWoL8ZGO9u7j6MBlXKRA/3TVyMeLpU07hkUzYaX2xJ0OU8iSJslWnpp8pd2JF3vsQ1Lb47c
 Ab6lY8F+18ZhRVlx8t0sBPAgF5INwF1dtif1MxS4MKHssiSpv8nNL8BzSf1G4E0CF7ttIScYDA2
 e0pTrX26zGgEoUaCjuu7Np0CHrKUEkWdRBKTUbLQWYv9jVtM41hCcSMjHlNdeFvE9HGLSuZg/Fr
 DH9NJ2pBtF/XXskEj95e0ubRll3VgV6IHLl5de043RQVIxNKhNUNDtW7siaD+N9dmRjyqT7RwUy
 miXH0Ue+fpwdgI8aJ400U/8DUx3d7gwiDZ9787MFz9nVhT3KGrM2xU+SMmTRSFR6skqRf76KnwA
 IzUUYCjRa9h1Trh2pvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Now that all targets implement this interface, we can replace the
cpu_get_note_size() call with the new interface. We still pick the
first_cpu, which will have to be adapted when we introduce heterogeneous
emulation.

A target implementing get_dump_info is expected to implement
get_note_size as well, so we include this check before calling
get_dump_info.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index e0a7dfd5878..06c37110fa2 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1866,6 +1866,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     const SysemuCPUOps *sysemu_ops =
         first_cpu ? CPU_GET_CLASS(first_cpu)->sysemu_ops : NULL;
     if (!sysemu_ops || !sysemu_ops->get_dump_info ||
+        !sysemu_ops->get_note_size ||
         sysemu_ops->get_dump_info(first_cpu, &s->dump_info,
                                   &s->guest_phys_blocks) < 0) {
         error_setg(errp,
@@ -1877,8 +1878,8 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         s->dump_info.page_size = qemu_target_page_size();
     }
 
-    s->note_size = cpu_get_note_size(s->dump_info.d_class,
-                                     s->dump_info.d_machine, nr_cpus);
+    s->note_size = sysemu_ops->get_note_size(first_cpu, s->dump_info.d_class,
+                                             s->dump_info.d_machine, nr_cpus);
     assert(s->note_size >= 0);
 
     /*
-- 
2.47.3


