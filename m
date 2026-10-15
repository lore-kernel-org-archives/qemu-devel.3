Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE87BCCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5K-0005Wi-Kv; Thu, 15 Oct 2026 17:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4f-0005De-Qi
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4c-0002Sn-6m
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FKW95O3462792
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TIR3fO0hLFg
 7fsLO9DezdUDRH3V5oT18JogvbWYievI=; b=Vi9HPYaArYiHhc3rQgolqccj7JZ
 nv4axEnLh3AraDM3x4TM2OLWI04AyOld6Idf4YFdYEKvn1e4d7gBZRxtW/WgXWoU
 I9XneelT3dsEmyACs1Tdycn5IcfEIIFCDER6N4Pavr1Viffdl3WW7I9frVyNKH7T
 3CKUPVT0nWsh/KryaE0yXsTLb7LBFMTLBUK4FSyFt5BC6bm6vlL/YsqY5jwK43n3
 HR4hTLJZAVEzPPHs8BQAI9UFKvVd5C8DRWn9x1ua8UTF/JRx19FpO3h1PiDDQQDC
 nd+gtEN3rgVIKBhUiMkDXDieGPVDHWnwwvsEwOZrHXOs7WtBsurZHozj1gA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69v5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:33:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso2984399a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099982; x=1792704782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TIR3fO0hLFg7fsLO9DezdUDRH3V5oT18JogvbWYievI=;
 b=Vpg1DPlOI7FxO11cUung8NzLRvV9FI8LbWtbQ6veSW2GwoD3EM/4zuy76svcj7M5ol
 FWsaaECzUcKCdZhoha9sgFfs8UpNoVodkD+lbPbXqvpPQMekSJg/jH8B4QvIFqqer2QI
 fRh7/OdkaG9uHumc1TiIILL1WIbaaNl0Zvyf8i6/PbeQ3VKcuFE4cquG8XoLEcTh8Jzj
 jFSD5m0UjxFRAHfqt5WD05gSDCLfwXOGixchx/UeaHUGCOnwCmL4cAuUGQ1Xm4JZQZNX
 T9O1Hv7CPWSW4KxErw5pDskZ3G/rQAK6CdDM7YfS8qNxEJyZXpwODH92w4FmWtvO2YbM
 idyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099982; x=1792704782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TIR3fO0hLFg7fsLO9DezdUDRH3V5oT18JogvbWYievI=;
 b=RH4btk+MchnRR+4HLLUcBWqYqMtpv7bM38d4cSf1AKeiUMzTED1XkbPG0DEyWWuzYl
 //20AtFMIxFPOP5L2cE0jhtabB6xvXU/prn5SxKtBFFLYszdht83k7pszWS219HMUzyW
 G4GSju1xq9iS8JOpO2S2KrDD+vQefWLQYU69isKFyzZ3S1FUCd6Kd++E0SANCY27TnVm
 N54QXZhzIb6Pxp4XyM74Dv6CRw7v/CgblRN7Y1xFXCkfeV2RFnl+4L3p8ctuW5UDegfI
 D8UFoHYEkIDTbSk/po97LetXiy7RpC9RSzVlmGcQ38kzzmlzK7JOgFvAd9a4TYI7j9Ab
 pN8g==
X-Gm-Message-State: AFq9FYILALXDueFgAVHDVmD4+NdfVsOFXH9gb+gapd3O7mgMfewdHmgB
 gts079J1i6N3n3yq2lkEQ6Ore5GApoaMxBu0YcBBb5UdADbSOrQXcZroCVYaiEDrRlbEuKckof/
 2ZH+husdA6pY8FHAMQLewm7G069QpFOEFpxJ1UP50ujQLJlRdnX9T86jWVvBH4B/k/g==
X-Gm-Gg: AYBFou3USJNv63d2Jcn0yRGVr5wtJK3wcZ1ihxW8IZHhEk1CcQWnJHbMIwutqj2bk5d
 pogoo7dSCeSEemW6x+fK4a87N/h7AdXYcMKCzFNYVxo+/WoPGpMPOBtbr1Pp72E+Q6tnSpUiEsj
 FshxJ9nJN13i/z+KJyq99cmnFsFT9zHgzXXC68xuXKMEPH9TQ6/bCfBKbCm7QexCudX/bNRCZrc
 r0kKdMTXzNiam2mady7sgEkEG7K1KflhZnaJEJzelUtVxZ0nkRamAUSW6U9I+WTAZ01txtQzJ5n
 +QNNsFhEXY7WSjR+Dyfoaa/5iw5Ccmak3PRoaNqvbGutlW7ua3AmxyZ+q/Fktpu9+h8XT1ZBMWJ
 Yv3TyS8Td7pIPABO01zmWhkS4VANikZTCu6bp6lUkzITZZhsRG2idQzVB3ZbcNv4=
X-Received: by 2002:a17:90b:2889:b0:3ac:eeb:e0ed with SMTP id
 98e67ed59e1d1-3ac0eebecf5mr10687195a91.36.1792099981908; 
 Thu, 15 Oct 2026 14:33:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2889:b0:3ac:eeb:e0ed with SMTP id
 98e67ed59e1d1-3ac0eebecf5mr10687179a91.36.1792099981457; 
 Thu, 15 Oct 2026 14:33:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:33:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 18/19] dump: use get_note_size sysemu op
Date: Thu, 15 Oct 2026 21:32:35 +0000
Message-ID: <20261015213236.157767-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FErL0aiNMRvByoR7JPm2HkAwT1wv0yxw
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad1468e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=4q89r5wyS8jGYcIIz-oA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: FErL0aiNMRvByoR7JPm2HkAwT1wv0yxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXysgKTjJtXqx7
 tmSo5hLOnjxYevQhxCKWqHQKlqWCbeUkk6sYwLbwttI1xUfchTFnTyTYDZICw211nNTCojoRRcH
 FpB6Vh+HatbebPAVlRw5WaR3GEBwJXJ+hJ3MHwgwjUJFGY06dff7ffzUXAoEJNsEAdwUc/sEq+9
 yzLVyGQ59GujtO3sst3I02oOkJJSk/yDnzjFEVgC5cB8TUmViTPbC2fP9maJnUODHd0KP+8WVjV
 F80x10BSR5UhGIKHBi1W34NdANIl0qln7cerN7+j22rg4w90ykILUtm0yCZE5VOc1Dc25G5h2aU
 jD22/25ij7IwjEHbbSFblTz9hOYB0ZlJlH/EZo5qbyE5aX5bI35EWVDdmxrxS+9Bvd/mn9XMbJ/
 kthThgrseJIfe9hotNVhYVaVIu0Q/BqkLIs8kr6jPtpSgot8Am/b86+g/XJFsSDXGk/KA2AjA/9
 oNprGC0tv1Km5cS64zA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXyIua0VY/VC2R
 OaQjPwzmhY19z1B4TaHrC+YrE13a7/iv1alx7WlG1MgMt0bzVBxsax02XyKiU5I3X+ne5SiJ1pX
 5aTbRnHKLofLsglQPkcHKORv4m+pKcU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
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

Now that all targets implement this interface, we can replace the
cpu_get_note_size() call with the new interface. We still pick the
first_cpu, which will have to be adapted when we introduce heterogeneous
emulation.

A target implementing get_dump_info is expected to implement
get_note_size as well, so we include this check before calling
get_dump_info.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index e43e41838fa..6c3bfe6bf5c 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1860,6 +1860,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     const SysemuCPUOps *sysemu_ops =
         first_cpu ? CPU_GET_CLASS(first_cpu)->sysemu_ops : NULL;
     if (!sysemu_ops || !sysemu_ops->get_dump_info ||
+        !sysemu_ops->get_note_size ||
         sysemu_ops->get_dump_info(first_cpu, &s->dump_info,
                                   &s->guest_phys_blocks) < 0) {
         error_setg(errp,
@@ -1871,8 +1872,8 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         s->dump_info.page_size = qemu_target_page_size();
     }
 
-    s->note_size = cpu_get_note_size(s->dump_info.d_class,
-                                     s->dump_info.d_machine, nr_cpus);
+    s->note_size = sysemu_ops->get_note_size(first_cpu, s->dump_info.d_class,
+                                             s->dump_info.d_machine, nr_cpus);
     assert(s->note_size >= 0);
 
     /*
-- 
2.43.0


