Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359E606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dM86rbka;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I/Sfg1rB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoE-0004Nm-ER; Wed, 21 Oct 2026 14:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao6-0004M2-W0
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao5-00082V-43
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:58 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpPqh2384281
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zw6uegqP/ztylxdIrZULX3L8ibvztzh02NBpo5o2/1Q=; b=dM86rbkaCmHn1pxb
 H3ePZ8C8v2Wlboz9BAe/Jm6NLrugzVe5jM/0mtwrCaaEwrn3m7JXZ6FoLnJOtjJY
 vVH9dzy9tldpCEB4HuZxKEFsd7naap9eAzi/8CJdQAmQ4z8mCFWT2rYZyWkMHr0Q
 VOaa2KEX5rmacS1UxZVDYU/JzO56/lIz260/M28Bm2Mbc+OuAWoSrJ0x4g44fzMQ
 3LwurYs0FI6psFmGQ9GribKNZmG3UzXwkyxVw9loHThqPBfXeWstMZaSk02ty6Or
 kkXeAU5CQE4TPN3lCaJbMkWKXaNchhoynZ0Qu1To8d3MiW/PgTHbJ76zhM84NVnl
 O3MNZg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke0jtq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a46f0f158dso138554a91.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606374; x=1793211174; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zw6uegqP/ztylxdIrZULX3L8ibvztzh02NBpo5o2/1Q=;
 b=I/Sfg1rBC/vmOh6dg8ihbJZoVYNlJZVEXY2IwCuE0r/6lysyokTayFcWOVg6XTF2Gb
 iZMw9PwDhnVB2A8moKJRyCLRQuX180KaLV51pUMWVXEWSw9ywo997y6OVLat+anD0gZX
 31lAFs8Lab/sFhUQU2zTCjTot/WmZBQEgZnrr9RsVzNsC5sBIFGPhXRXbFX2F3FXo4vY
 7vNYGhI7Z/OQPRe7IBTuoRBOjbdDMVOQF36qH/vndr4iB5YVOQvFLVMOQiOEzSNRQK35
 EMY7OUmbPWpdoccqMonjGBpgG3tg5HmJ4XYsuGl8zG5iVB55LNWr68qeR6qMf0FsPdrE
 6hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606374; x=1793211174;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zw6uegqP/ztylxdIrZULX3L8ibvztzh02NBpo5o2/1Q=;
 b=o1UU1Me6Uok6druqsOrqg3to28tT2esZeUygldQxXFyxD9B4aWmnOUkIUibsGxXfnQ
 5aGDvCy8xF8WRjkO5mex+UQR0oH3EZX9Pt7Eh0V5k4ZcYmQgRQ/q1GvmDhtz24wOdmFZ
 ac8sGmGgcsz6n+L2Dk1OPXSmigHtmNUeJszddmZVF4h1TxObBuQMHsk6Jt0n3VSTTuaP
 G1Tu+13wyaV7BmEDJ/K5eDD72OzxHxKZjXHuKyRoSw/vd0b4KCeGuc4haUeHV7dbFtPr
 uYisOC0LN7nTHP9VRGgNk0AtuWmEXPGwUUTqtgW/njzEKzAi54pd4geq+ltZp/BYKQ2e
 SOtg==
X-Gm-Message-State: AFq9FYJIZth7ebqSISO9UrBKU0idqawCW6IfC7OmDgGQpWsOPiH8sh+q
 AvEYHPcHV23K+SIz5WAn+WKiyjctYdLJgrHAcIl8o+WBfv+QXH8iRSX9NfNk/Kk61tScKWnRs2I
 OVTe5uWJzCtkpL7PPCznHne/lcEFYZPvdvmXny/gMEHb2PDCLi/1LBY3V6kz7r0/9Eg==
X-Gm-Gg: AYBFou2SGrN8rttTjIQq5stpI6u31L9WuuzGb1HYbuB8lsB9ST2Di+ORgxeC60VlDpP
 3H25uKNUNsQ4fHXNJLV2dc21vNFMfxcEByXs48tGe4AabVNhhM8ezDl6bMisoJLNgGQVEAtC9jW
 mDQtpFOki0J17k9nVIxUMstapKB7QvW9fMcl6ewTosNnGAagjY+DY99CaPxHWFDYVRW2tJiXoFI
 ZlJqWqLC3wwx5/8Etkna7mYbfLPKpvhPS7O/8mAJLfvng9+uyK+xvWEWvCIMN7PLneo/UqvmIl0
 LHgHle7p6zHy5jndqHGLHPkmhCgWZEf31DmOxkbemditedG5JZhcjS4fD6JHn18xjcGM906nCoB
 5BxY65qijkryfgAHWHtJ33bZSawkC0mIm9B6QwYOzEDJ28FFk+FlN461h175YeAU=
X-Received: by 2002:a17:90b:2c85:b0:3ac:b6eb:e0de with SMTP id
 98e67ed59e1d1-3ada6c56dcfmr58458a91.4.1792606373761; 
 Wed, 21 Oct 2026 11:12:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2c85:b0:3ac:b6eb:e0de with SMTP id
 98e67ed59e1d1-3ada6c56dcfmr58451a91.4.1792606373366; 
 Wed, 21 Oct 2026 11:12:53 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 05/21] hw/core/sysemu-cpu-ops: add get_dump_info
Date: Wed, 21 Oct 2026 11:12:28 -0700
Message-ID: <20261021181244.867840-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ztrYYAiE8oqsYZ4jeuzwv1761Tk456-q
X-Proofpoint-ORIG-GUID: ztrYYAiE8oqsYZ4jeuzwv1761Tk456-q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX1ekDZfftLOA/
 7QKOaI5UalukxNS8dXupp7/T0Y5mi8Obna2tyjeCgaSg+icoCHejxobiT4fz+CfyNUGujsQiPs4
 mvd8mTsjR5HfO9v+i7ARELVXuiSIsRc=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad900a6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=7Qd54_oI6N-egMT3aNcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX6BGjkY1z3dr+
 hh9oFsB/Ypwel1qZ56AYgL4np+fgQFRNse956hJY2MV8bPzGerDaz5wGo5/eEiGocMWliwyyH81
 6Jq+IRfull+ZE+qPLh9Im2eW5t13DiyRENqWChMHUpM3jQE+tlML81jzKKtsopfJKG4ljaBIoFV
 LpbIvWlhpwM5Ivwu9Tg3o3DBzKhI/SGTIIOyKZJ7/joxqgIzfo5rjLfdfl2sqCwUSXGxRDC2t9Y
 e7P1m9WDcfDqn0IkVbGkRf+dZVpNrvxnZYpyoH6l4SO1/SJrPm/FbKhV9gSZ3tonUj4LVPr7xWu
 6Vxny37ntL+6Krir7BevDhv8ON7t0Jz6WsWXdEhtmRVwps/2IuyXoRCxhXkprOhoH2jN0v7QIBz
 1ZByThUKvZe+ouNVkXMF21hj+cUrxq6QItl9E2I2E6FjkZtv6aT6vqDEMh44Qv8MFL7i4U5wXXP
 lEC63Jy1g94OHJgW8lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210072
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

This allows a specific cpu to declare its implementation of
get_dump_info, needed by dump.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index d125540262d..1d4a04ff361 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -94,6 +94,11 @@ typedef struct SysemuCPUOps {
      */
     int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
                                 DumpState *s);
+    /**
+     * @get_dump_info: fills @info with the endianness, class and architecture.
+     */
+    void (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
+                          const GuestPhysBlockList *guest_phys_blocks);
     /**
      * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
-- 
2.47.3


