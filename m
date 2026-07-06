Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C1BC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjhi-0006CL-9R; Mon, 06 Jul 2026 09:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjhg-00069Y-IH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjhf-0007E8-1E
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxIHx387415
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 95uP1MDX1SArng5LXH/Zib9HBpw+pSTQCshJHngSnZI=; b=dqhS88I7umOEhT/+
 T1SXeb+aWd0UJq9tzfPCVgNULgbMS2WGVyg6PjEq6n8DUScIswvtV1h05rFaCcbM
 /ItXvMcVX+jno60+7k4VgYArnOibBaNYPUZ/nJ3L1xUYDVXsY+jXHuQEdtLZKma2
 l+OgQZNgZ0kgDWvMGl6s5ei2lcdQLG9aUa9T7Ztz0+5gtXHlNcjCKa4hJchq/AMz
 Cqspo2ekR6U0Dt10EHSPEBwwEayfo08LkjIDxtG6dgthc/B7HoY3jLF303BdG8ez
 iiiBRp3hLZCKLKWFt9RDjNwATWf/MNA0O1743JkG2T1LKbw0yVNj4MsLX3nDwIep
 08GEVg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r0wd7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:49:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ac0a54110so342924485a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345781; x=1783950581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=95uP1MDX1SArng5LXH/Zib9HBpw+pSTQCshJHngSnZI=;
 b=av7OOBXaaLOaw+4HVsv3+Bq++cgK2p6sfEknJSo8UCJxtZXHQaWexQuUZO7NmQDOE/
 XFX8RbbmFqa6VbEFhekTDrd1FGizlV0F0/r5DZ4B2/ZxuYy//uYhc3yIi4aNSCiWdJnI
 mwRL9dCnA81P5jkaw5ch3dyTCz+vKtglyuarezAsqtTjDo1v+tEQYcD/XZ27+7rPPdNT
 nH9gz444/O4vtCKLwGCAa+LSUO4TJbBkfO5Bscil0K6BtxByu9cDJSEjVJcxTkF70f1S
 Cf8I/9xqx4RdsFPM4rumYo5ZfPHFlljr8LS3bvZhV0C0tDiMV4TKfemp3Rl3Lpc+ymJA
 X9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345781; x=1783950581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=95uP1MDX1SArng5LXH/Zib9HBpw+pSTQCshJHngSnZI=;
 b=ZVjlMl5wOVDfCMZ/hH8sRpsYJDAtMDdVy4YLwAtmVVmfcNmmfa91EK6Iy/aw9HKt9s
 1ZKo9eCxmt8ob26m5VCdkJ1pm3FYg0iW9HlnZ7oz/6uFGs6ZJTlwxdV3w6ccJ+A955nj
 uUOuomsUdoJ+awjdvHMxCc4brOeJPZO8eKpSzqMnfMBLDLyR/o3/N6QzjQik08ZyaH3J
 QJT3VKS+HappzvxBsASwAiOgPF+bsOzl9kOoC8kl2o2oWvZTZO3fVazkjUJAR4zU0cgI
 jgd8K4hqCkjJ4Zk5y0yV6Kb46O7KecUoj8FexYJUF1w4kHRsMtWKBVb2E6X789Q1XKBe
 h+qw==
X-Gm-Message-State: AOJu0YyoeHNmOCruI3XGsLuPYOulbzMoyJtuU9L/i1zsuBxNy7sRXXez
 GjML+7LFoAsTLqRGYrJJeg5fiR4IbYQRdbvM9a16uWV5Clx7a3E2+gtkCGMQOP2+6Blz93o6zz8
 TAd6qJzJLeGufdImfJ7HqrlEduWH9s8A6sx5HfCXE8mUvv4OaZpYHR7CDiatmgpxhww==
X-Gm-Gg: AfdE7cm+2Ko3UVVdJNgjBN8YM1CP7uZ12vIsT61SR1seZY2FsxEoyCZWD8ZCsYMfdyG
 CdXLpCeQCJbHHxKWn5aPkewuW4fGr5232nlME0IWeyzYjorb6jgEQsBY+8AAfG6tecHVbkKSMfH
 VxqlpnKNmhOW0yg7nSZapx9nYyGDYY98lNHlQj0e52MNVE1C9X+bcbGZkIsGW9GnbtoX9jzZSpN
 hk+9wY5tQTyZLrsFr46tWfzPGutkSiY5jPnN+FqrFvs4jM5jm/QmnFLbRqfT8MufDT8jLlKvN0W
 sLZK9wt8uYIvCKnH1e7y1Mtg0bEi3Kg1QbRxiY+EXw3b5h9RifUq1FU4Pth8qGpPih5qA4nQuaa
 2/4DH/gAz9yZyP1dAzAFKOfFa1KH36zW8wgEDR67AzNEmmq2H71Ay9ycy+g==
X-Received: by 2002:a05:620a:2913:b0:92e:5610:e479 with SMTP id
 af79cd13be357-92ebb5ef0cdmr94035885a.52.1783345780988; 
 Mon, 06 Jul 2026 06:49:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2913:b0:92e:5610:e479 with SMTP id
 af79cd13be357-92ebb5ef0cdmr94031585a.52.1783345780448; 
 Mon, 06 Jul 2026 06:49:40 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d905sm25147271f8f.2.2026.07.06.06.49.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:49:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/32] target/ppc: Ensure TCG is used in ppc_update_daw()
Date: Mon,  6 Jul 2026 15:45:22 +0200
Message-ID: <20260706134527.84808-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX8ePfC5/wburJ
 A9CNQBoZHEFK0I4Bjp/nzn5uKbA4/N82iYAj88+MBFwhK+gpwNKY3LHkm12w1hOxh3q24oC1Rkv
 nt16QtgkHSLc5nwnp3OClvI6n0bqERiUbIQjXCgCl8phqsQ/pDg+5Uk2vgWquoN4K//BsEuosqq
 vrGlwf+FPsORZcY3Jmn84x6fl1E19fwo4dEIaZLbq3U1z857Y3ePsOnYlkJujjb6myI0PP1yK4/
 Rn+m233kOexne6UmvUVXJC582QOIkb9z2WCDQKhO5uV39mKD7JrX92MRXim9oEFgMb6cbmfA+qc
 /lYrg3hc10usMPJeRXqhNmOJyrdxIsSsVg9K+wLZ0Os5zK+XgJyWXN1AnKUjuek57BBn+U0vjfv
 7vmANDC/bqJglib+OdNiEHmqB2cSMFk/dbOyPxOrKyfwerBukr2gkUxeYUS6Rdas9nNRE0VSBhX
 82TCkqQf3//0sKVVVyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXybL8TIOxsmYH
 HKI/8SR1wTF59IApKSSOM8mi9KN2zaA/O06Dtde7un8PMKHGYpcwy+F658ID/XhhCSwyemuk4W/
 6ypEqEmlRoAew0grT/bJ4+xSC+kweuA=
X-Proofpoint-GUID: jBH258jzUsVrVhoJzJV3mjZikQfIXyqY
X-Proofpoint-ORIG-GUID: jBH258jzUsVrVhoJzJV3mjZikQfIXyqY
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4bb275 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=nS8E-dRYisaDM6zJQEoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
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

Per commit d5ee641cfc5 ("target/ppc: Implement watchpoint debug
facility for v2.07S"), only TCG is implemented:

    ISA v2.07S introduced the watchpoint facility based on the DAWR0
    and DAWRX0 SPRs. Implement this in TCG.
                     ^^^^^^^^^^^^^^^^^^^^^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260705215729.62196-28-philmd@oss.qualcomm.com>
---
 target/ppc/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 41edb18643d..47467ee1635 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -147,6 +147,8 @@ void ppc_update_daw(CPUPPCState *env, int rid)
     vaddr len;
     int flags;
 
+    assert(tcg_enabled());
+
     if (env->dawr_watchpoint[rid]) {
         cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
         env->dawr_watchpoint[rid] = NULL;
-- 
2.53.0


