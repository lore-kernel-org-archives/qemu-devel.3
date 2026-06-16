Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD356CD98D2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 00:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZdhB-00020O-CS; Tue, 16 Jun 2026 19:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZdhA-0001zc-DO
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:59:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZdh8-00082X-Tw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:59:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLVuIw1816039
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FINgkC03CpX
 HsjEzGruDQiIM72ZDqLif+q+uMuG+YvE=; b=g+ldN1E3iw6pCtQxYiNoBjhsfXq
 hEAsdnN1ZM49st4G+oatsxvx5CPbTYOJy0v97MxuBKKOLBTBaZ/0LOqUpCCup281
 tZFzVJyjtg4Iwejoh/ua95mUQx8MjSQvFDAfZ5WCkQ6rwXyjl3d8IT9iTz8qeko9
 G4WciuTe31fZ91TOcbGw9cTmkJRez5Iu77yhuFcNKSWh+8tCrd/lCiFtePd1MBqd
 PZ/6++TfS4tQgfEd45kPOEk+1iAnYYFL3xo5svXJ2aMC0Qk2rOauXCcPV0485Gzu
 2ulC5LVLaP10nLmSWGTewootOOw1Ou5DSs8h6zpG+xbdSeDzA2sVYvN8oEw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euefbre90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:59:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ce9e6cf3aeso95055566d6.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781654388; x=1782259188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FINgkC03CpXHsjEzGruDQiIM72ZDqLif+q+uMuG+YvE=;
 b=DoWel17vqZ/jt5VsoIFHFA9TIGsC5J6qQTqNv+8uX2tiCQXZpnf2Sg9MQykgqGrkLH
 ue8Kzjsrwejub2lUOicDJ8iYmgOPGibKks9pmPcbVqB1qGEqsSJi+iqu7NQK6qpLHtHi
 1l7Ta5NNx9zyveN3xAXf2P8d/VXjK1jouBBMjQQyModc+tDb7VIShntqwic99Os+YYAP
 9SIT4YAluMVDTPnZey08ETgYtHDUZOdKQTKcHOtpQ6SZP80/UGndgcYheBZqQF06KHj/
 EbDUX4oZn3HBadKsEyLCCXOr6N9onyUp4NwBHkK/lAr7FRPTwhZpITJ/zEQc8IxHSFNr
 96PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654388; x=1782259188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FINgkC03CpXHsjEzGruDQiIM72ZDqLif+q+uMuG+YvE=;
 b=tHuTwZZBeu2toLuRtmQ0q4ZU3rmlVDQr1idIrowXgRRLDkivU/NllISEBne57Ew9ow
 QuLCjj1nYR5G0LGRlP5pOxZU9etXXlw4xmkbTn1KMQM9GnNcd2l08pfLL+1xzoJkRAls
 dvCsm8ocyhHCm92K+mMJEd7VQ4ttNnpV7kPJECuWuC+SdiVMXG8n/R2WTLNhgrT05sO/
 u88QFxghuvddJAFYSWjFHLUzNfc9OF57Epbxo+vgGPAdcol/KeeZp7VbGxJoFnLKwQMv
 DqC9aMViI31MlIPLunl4P0Bg7QhCPlapF/2FC6+2WG14xgyR90YtyE8aU1k9UR22kAtt
 jbDQ==
X-Gm-Message-State: AOJu0Yy4aBEEoUUjgrH3mQ9/JnLsV6BaiQRQskeXEMq84MbDJqCxbupP
 TK3qz96PNVY2plBfbblCHOxVxqdwxE2j16c1iAONN/gzEgJuD0qm44UPh0pO8dkWQK9DDAGwWs0
 9jpokMRnGuL0XUbel68YzhyOrOjtrtQ6SWCFQcsTR2nXnOACmblvoY1gOa5rJrCimow==
X-Gm-Gg: AfdE7ckG3+g+KkgikHJxq0C84rsmTe4avf/eFK1xYovk82Y0Y8EX3DJMayO2vrgXhjE
 4kL1+Bs+vyW9TVTYQuNddOEKQNAVZ+6PmIJ8pcqGBhLV651G1m+SI8UqELtAKg5mT/muBs6vwEx
 bMQmH/Veicg+N+Tlw+x90560D9Ox3HljqZqQqGpU8Pa0lq2wNDQ6bntlRi5379LOXewJeKLTXbU
 agfS8nSpLESZ5mGCLxMJKg3gbxtijH06mQ8RLIAb7DtOB4LcO+yBTNMjv57PB6/gW1z87XW6KU6
 lEor3z2VNUWEQMTCp0PLvPc9ZIybMxp3UnqvxJqZxHACnK9CgjS5UXKsv3UxzvRQ2KLWe294pw+
 YabVCqxMz4R4q7qvUpM/Hdvu/8nF7RtCuFx9k31hFn0bVsoDhOAs56cdkupQ=
X-Received: by 2002:a05:6214:55c4:b0:8be:7779:d1b1 with SMTP id
 6a1803df08f44-8db5e14e78dmr31824336d6.30.1781654387539; 
 Tue, 16 Jun 2026 16:59:47 -0700 (PDT)
X-Received: by 2002:a05:6214:55c4:b0:8be:7779:d1b1 with SMTP id
 6a1803df08f44-8db5e14e78dmr31823906d6.30.1781654387133; 
 Tue, 16 Jun 2026 16:59:47 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f132178csm50191986d6.7.2026.06.16.16.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 16:59:46 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/5] hw/riscv/sifive_u.c: remove unneeded
 qemu_fdt_get_phandle() call
Date: Tue, 16 Jun 2026 20:59:35 -0300
Message-ID: <20260616235939.1358663-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5RY4Zrhqw1DDMaohbBRk_JN-bnDmfWLf
X-Authority-Analysis: v=2.4 cv=IeC3n2qa c=1 sm=1 tr=0 ts=6a31e374 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=fewmvhpFTRUHsk0HV0MA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDI0MiBTYWx0ZWRfX1EvStLcgYlPQ
 yAOCArvxFwxjbsfIY/YUWjcpIcCkMq/6RgBeFT52G8zqQXOwXoIdpfA+tHtZj7jELz4J6PY/zFz
 sQDj9ACZWcGjfkRJih5P04v6q5lnELg=
X-Proofpoint-ORIG-GUID: 5RY4Zrhqw1DDMaohbBRk_JN-bnDmfWLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDI0MiBTYWx0ZWRfX2rwc4CoICxsh
 kR5Zzl5kmV5ORno5VZtvDsK1neoD2Ed/a544UPJN6d8K/uNoRtbXzc8X8vtTG+Q/YpbzHPtLTyq
 51S+SHDQwoUk58cQZ0KIb8aWQ+fm+vRevbjy8P57bueKQwAGgOPD01jPaO4ZUq2wjGA94K+MYdB
 rwMLFT98fyKN2HccRzH4FWPM60IP+2bzbKbVAlCLnv3zdeFTtY4S+E1cRq8n9Tf79fVGCauSWct
 JfaJuda1Y/MkUWEa9YYcGPaQTMRG0ECKYl9l+SK7BDIe6oo5OtaEzUk3R6be6NTs9OclXsn3XaM
 Juv3LVk/jHUg1SdFPXHMwx1j5mNkM3xMWdK98PDrw4Wwe36SzAsiwGLfmgVZYx27ocqm1rXSljd
 w62CrNeqijFBUoZpUVxqwUwED+Ehg348OQvYaOWK0TZsY1A5uqWJdBwFu8NcI4O494KOuLXlKI2
 En8t4Hw41swAAlW1J+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606160242
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

create_fdt() has the following code sequence:

    plic_phandle = phandle++;
    (...)
    qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
    plic_phandle = qemu_fdt_get_phandle(fdt, nodename);

What this is doing is assigning a value to plic_phandle, then use that
as phandle of "nodename", and then fetching the phandle of "nodename"
again in the same variable that already had the right phandle val.

Here's how it looks like in gdb:

Thread 1 "qemu-system-ris" hit Breakpoint 1, create_fdt
     (s=0xaaaaac162a30, memmap=0xaaaaab8f70c8 <sifive_u_memmap>,
      is_32_bit=false) at ../hw/riscv/sifive_u.c:199
199         plic_phandle = phandle++;
(gdb) n
200         cells =  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
(gdb) p plic_phandle
$3 = 12
(gdb) c
Continuing.

Thread 1 "qemu-system-ris" hit Breakpoint 2, create_fdt
    (s=0xaaaaac162a30, memmap=0xaaaaab8f70c8 <sifive_u_memmap>,
     is_32_bit=false) at ../hw/riscv/sifive_u.c:232
232         plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
(gdb) n
233         g_free(cells);
(gdb) p plic_phandle
$4 = 12
(gdb)

Remove the extra qemu_fdt_get_phandle() call.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/sifive_u.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0c6e4204cb..fda9a09f06 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -229,7 +229,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev",
                           SIFIVE_U_PLIC_NUM_SOURCES - 1);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
-    plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(cells);
     g_free(nodename);
 
-- 
2.43.0


