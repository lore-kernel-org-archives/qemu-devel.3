Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D832606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ICurqe9M;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H+Cx3NCR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nX-0001pG-O0; Thu, 22 Oct 2026 17:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nV-0001oW-U8
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nU-0000J2-7G
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIGYlT3579041
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aSMc0AMiM+u1xnNSxgniV0+w7ohgGUbap8lXlu1SS2M=; b=ICurqe9MhW+aiBP2
 QuYHn9UVGi//Ur0cFdITCJUIl/bzVM7cumcFj0KqmWXPeH+Yeg2uGsRcuBkQHHUD
 gtV/rgnsWzRACio7sdxZgvT5Dn37hImYOIATkVBV15fX839wyExGEGbGBDVfqxKT
 DfMd3sXcagktnfXsgiOjrptOlr/wRT2Cx/RipWvVPzeQbKAbAfBcPOvcWsIByc+U
 9F7B9ggXrt6L2zKu5BD7OBXrC5C5OVH/NwwcQYhsKUaUUMuQLQDuu79Rh8orM767
 zWtVNywWZ6UrjjUYpO6AvVFm0cipnIFDOMz5bOXaBBs0+Tq4/mo04qMnYk0GG07t
 m0T5mg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbgqys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd60a365440so135937a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706282; x=1793311082; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aSMc0AMiM+u1xnNSxgniV0+w7ohgGUbap8lXlu1SS2M=;
 b=H+Cx3NCRMgRAlk14Qg1zLWYMPCR+l3hxn6HDodZLHpTv3VRyfoy5k3d9T2rRorBAxx
 mbcJPhYUZhWyRx3nk0r8pMOIJfeDsrhSxRubgTwE3bsNQiLCXARqXVen6MMQVCz/VdD8
 UIFuGYKCoynpSmqvYgoKiDfZEIxFKEWB1M2d9qtX4bJwRlI9d620bggu6GcecRr3MgYy
 PzIhZ4z/ezz3GOmVII2DcyZPEFlSnPZ4TfV6qDeTTC47GwATPqtYWBe2mY4mOvtJHs0E
 7YPMPI75x99BYRdCj4s2j2QsrZYph5aA8kK6r+OMG3SCuvBENv0d0FEp61ZSZ5vnwXOi
 dfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706282; x=1793311082;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aSMc0AMiM+u1xnNSxgniV0+w7ohgGUbap8lXlu1SS2M=;
 b=rbAEUjJj1x3QYAzxEySIByPI/jmj8K94fQAZO29uWCYuT91U/e7Y51LkN5IW/ePwAD
 pIBsKaQ6LbqfvjM1b+JegAdHQNRlWuOGBYOH6z01xM5dSoPBVosuZHgeLHgRNhLW5C4g
 /zS0TZhic24lzqh1gSYbc4hLOMzl9XfTF+mOEaT2HT8PvtZ1P+2gbIF9xZ9KBA88+HLB
 nLUU5Gr0f4VCqY/KirL7n+RmQjj13n3fS+dbeTtssSZ03onNezjHOdOFqBdrm8lIWYH0
 i5mAjfDKaQkrDiIy4Nx7FfJ90sf4xqwkdyBUkdSWEFPb2j41Tkd7ARveqOfBUM62B6hf
 +b9A==
X-Gm-Message-State: AFq9FYIpuNqQyIE8bMep2LldPKtTg7x2bcHtMFovjriktFwMv1peuCyR
 RLiQogzY8xmlSg6sF7vnRJAwRtLskYo6BshrNbxB+/52NnfKMq0zpu8KwLOvssHwQArJRCXQKXH
 HtJT9QwZbXW+NTEvopFYe2klM06JEBDWMGjQEOi0GlltgKoJws4eG6H146p3zDpmF7g==
X-Gm-Gg: AYBFou1FhcFFiWOYtLKCvWr3yFIu8l0JZ3adRMz6Qg+HW5VHgOj+QNpQzsYjvYG43PU
 t0RqqcDqTlyUSyTj0J6HDeDmV5jI5H5NgRRkv7f89u900GXMCDRUu2lsz6HHZRkaUBOeRAJWn4x
 NiPJoKuUg6gmSXNTbBI3X/lVGXG2zJYdNalUS07Aze6L5w8zthAxjjx2/nHLe3qPQzkaGhrYUo7
 1lPEC1QbwJat4rLrAxnx0v2l5N5a8G8q748BxDKAzhM96ll1/76U0R0NZklPH8Hw/LMkkLpfxgA
 o/Hnbd5MAAHb73kz5zcaixv8dxyty9uNSVUCAjhX0rysMnXmBx9Ccx2b0D2IVK8BxQ+7+c6Gshq
 6wsrbGnZoQeHeZdy8RDxcDI0hmp0yxA9+tjBkjAFMBvjrvEPSHhIjZa9A+sTcN88=
X-Received: by 2002:a17:90b:4490:b0:3ac:1c76:61c3 with SMTP id
 98e67ed59e1d1-3adce629c4bmr146251a91.27.1792706282147; 
 Thu, 22 Oct 2026 14:58:02 -0700 (PDT)
X-Received: by 2002:a17:90b:4490:b0:3ac:1c76:61c3 with SMTP id
 98e67ed59e1d1-3adce629c4bmr146243a91.27.1792706281703; 
 Thu, 22 Oct 2026 14:58:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 14/27] hw/core/sysemu-cpu-ops: add get_note_size
Date: Thu, 22 Oct 2026 14:57:33 -0700
Message-ID: <20261022215747.2479440-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXxg9NHDoUO+Ib
 ZqBexGKDS2D7YhmsqknDiRUGXh1dLGwEp7WRU1moZvFsHRsEzzDkeoYKfeXuAWIF8lw5g28N8Pn
 yop+dPBfwx+2jdkg5xrFwYiAYCo7Tf8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5MT2ajaCS2fV
 7n5zZnYIhQBevvVGHbf1EMxVC5Ntecp8ajA9sy4TVSprcUry200DvtlDDwYBKhGkbnn4shpXo5d
 ORhXUN85dYmvpPVtwICZTlru0BiirceMz+v1B76mk4cnr++xvYI7v2stotqJan3pqojvNAcT+2p
 3MHCUFkOWuP9AYOZSAYNqiQMrUAC98P19Dd8yhW98/VIyc5uQMsu0Y+yeCNhDAWtTOcH10ZT9I0
 mKg4icA7iwdkDZDhjZ/4ALNCTXOXkj+Xy+M55PKFLQImXtxwY/b26+UGfgH7v6ILj2SWpXpLCmV
 ET/nmxCSttUYKkjTPie6Ns7xab/tjzcWYxWECOGwapafyEygmSONkn+3XS64F99B3yvoF87CEjw
 UEM8AmjWvUzPkNseP8v0SDesYv8G35BVXmJlJIjK0wo9wzs2yM4NtbI5zyLX6S3N+PDFxIkREUD
 TNbBzrra2syEx+ghleA==
X-Proofpoint-ORIG-GUID: FjU8CbsHs3Lhx61jtZ4eSbeTDhgtz4L0
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6ada86eb cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=s0xbLSvG6KTaNPbiVawA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: FjU8CbsHs3Lhx61jtZ4eSbeTDhgtz4L0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This allows a specific cpu to report the size of the ELF notes it needs
to dump its state, alongside get_dump_info.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-15-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 1d4a04ff361..4654a2a43d2 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -99,6 +99,13 @@ typedef struct SysemuCPUOps {
      */
     void (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
                           const GuestPhysBlockList *guest_phys_blocks);
+    /**
+     * @get_note_size: returns the size of the ELF notes needed to dump
+     * @nr_cpus cpus, for the ELF @class and @machine reported by
+     * @get_dump_info. Must be set if @get_dump_info is set.
+     */
+    size_t (*get_note_size)(const CPUState *cpu, int class, int machine,
+                            int nr_cpus);
     /**
      * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
-- 
2.47.3


