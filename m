Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4C3CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBsd-0001MH-0t; Thu, 18 Jun 2026 08:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsb-0001Gh-DC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsZ-0008NZ-U5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAtU2B1516066
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 folBNXbevySmXHtrond4cw+ToVzfXcMoQlHL48CLkxs=; b=YEPTPQXbmUTpWQ8d
 HZv74HowvKXH/HiaSNJTAOz7uuRAOJ2Thm23qG8WaIMj1QFAaBqbwrXslq2YnG6M
 ZAW+KUsF1LT1QubJbxyeS4sBuGr0N43xqYNkgFSKzeuxsDPX3E3N+x4W0Y0/G1Ws
 weYUyXxlq3EgH3YKoVpNYPVsw/CrM9EmnQEXHvGjkJvJHqHrEh6TAerybXxqxtpS
 3Rpxef0yqk56J+vctcuHtQxwvO5G0EDXv1fPqI7q6YKleBZjt0tf/418xVWo0E/9
 4F6uWnb+Jsxt30K6r+T0XPWlVBr5cK1c0devGB3k/rxFekpbbkjYohFWCFOLPOV+
 SzgoVQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev19a3afs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-918622c3c7bso254011685a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785794; x=1782390594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=folBNXbevySmXHtrond4cw+ToVzfXcMoQlHL48CLkxs=;
 b=Gg5m2UPxd4Bdn1+OMSmOTtpWmkrYkwqmmsC5HwiCYrtQ7+aZLFyLmRgl4ghHospPPq
 84N/omKCVH/st0fAssxVF63eJJ6Iz+/ZVeto3AnMPMsAZOk2AJiOmDnh5+3rpAHQxOyE
 ZiJKUf69jSPqfa2gfeHIU76Vd4wjL0r4eg+bD3E+BPRGWdUdpEa6zTpz9XX+BgjKaj5y
 +DFpKwjhqDlY7Q0ezYqn2Iwf/lH/XcltxJwj6glMPrapVqf7rP1jXh8Ltki4sd5nVKP5
 P6V7X8I0mwdqLi47iazrkOe+qMJaEn2Z/rxrphsHMzqrf1oNMFVjkYmTbmO0Q4PAqTac
 DHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785794; x=1782390594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=folBNXbevySmXHtrond4cw+ToVzfXcMoQlHL48CLkxs=;
 b=gZDhnxq24gAwbxWt9UD6OW3dezdOnvc6UHhxYfcCobH9vkRCruk5tfLSkkmD9RJ8IC
 7+6qFsdkbYRwLNEoGb5o/aKwjBT2x7VTnMnrSAXPQYChsC8ubxsWiNYb5Zvo4w1okZnX
 3pTU1HEFAuSJcXkVwe4ZKjAPMLbjI7VFAmM8X3iAxmDHVV4kFibAIzEv2t8P+g05hYaL
 33MeSMUC5lzKwmQNA92taVnUWrdW1I4i5OmbleqNkE1R/CTovRa6EnPzE8IPbIgGMbGj
 Dl070kAFBkYaGGJNzlyw6CnNSSfbVGJzDbjrHCqqcEhRiDrEyG6UIVfh7CAiBhqYXpul
 ecvQ==
X-Gm-Message-State: AOJu0YxtuyzWkXsMEZUbT6On29p8U3B22MShENph5qUyCv28elY6iydm
 Af3uV5tl8RqQQz80P86J91wB2gGqLIsfO/945UMUC7ktC8b/lNioROsmui+A2EWIaFuSXtP7/Wz
 ES5J7Nqikx58n8XDlcngC/6JK8LLS74FpJixgbxojI6jpsSvdpJPgkHkRqMifscp56g==
X-Gm-Gg: AfdE7cmOiInZ2xeR2luDNKgoBWK6UirUGRen/PpuAJJDrPuB5qLMnXnVohj4km60SO/
 /2+e27hK2Slqqm7/wZwKcUI9kqX89SWQfihCJ9Xncjh6MhIsMpUpRCB2GF9nen6rUngpdUcMlGF
 0BKv9/qjQaK2+YtQ6iCyqhdSiubhfEsoEQH2koWw8ykrUIkg0P1/ijPNLuSeXe4oMEDUfpNHYPW
 dTMjz4ESqZO7Sv+ff5rAMVtl6tQ7UPJ+sIg3EfaM4TInfci592R/mapZz8rGd4g1LNN5hqUv1uK
 7Ge1HG5mtFWMQe31OHeKYU3Gxhu6laVPz6k1NgnJbf7iVaAzBTgHL8v8UnjP8CLcNOaVd6WTQk9
 a2E7TftgsZBByMY2NISCIB6S5wBjy0nndJA1M3Ikb5lEyQotV3md2oLOOiHm6AS5BWeGk
X-Received: by 2002:a05:620a:4691:b0:915:8502:f7fe with SMTP id
 af79cd13be357-91f266601a7mr545418885a.15.1781785794248; 
 Thu, 18 Jun 2026 05:29:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4691:b0:915:8502:f7fe with SMTP id
 af79cd13be357-91f266601a7mr545413685a.15.1781785793756; 
 Thu, 18 Jun 2026 05:29:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2dbfb1sm66849662f8f.35.2026.06.18.05.29.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:29:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/48] target/s390x: Replace legacy
 cpu_physical_memory_read/write() calls
Date: Thu, 18 Jun 2026 14:27:49 +0200
Message-ID: <20260618122825.90331-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YbmNIQRf c=1 sm=1 tr=0 ts=6a33e4c2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=wtMswhJjl9DcAQxfHdQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX/mjM1xqYxjb+
 JHaCBPobqtcf5wHTkrMQ+eUcx0bmlL7icezq+5+PTROISN7OyhcHsHK4XXvEGz6i27JLvPyQTc0
 2Kz9DdAKWaquJZPpAkpgXQjWT2HqmSM=
X-Proofpoint-GUID: h1xBXxAis4eNfA0sTPcSnMEMtrRueWRd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXzR5SN5QrnNJ0
 S8c9VhpseHy8CL65uwV3MffRKvFO82f4hO0WDEiiEwApcE2Ond1Ex8euCp90iS3zZx8SFxxRsi+
 6gdlataoeQZbiJBQeQolPM4q8JcY5w9js14VIjIuuOplZx+kk2u0e6atCRCJOnayrq/Eyg90Ti+
 WhUjRDk0rnFQ9+m7jRk2llxdPrXqbATtpaHMAccNKffOvzv3O2uIpeKLZCc5GcELdd9k0lBbGJj
 PUloMnz7U8lkDQk/gpUh1byPUPTS627jAawsRInKfdCE2XE4p9Wdk3WeUyCYcbWi3WS+4i7Chim
 3xbeXoeSpG5i7OLN+bYcbDTL/emPmiFncWd14xzX+i/QQS58DnUXJehf7Rf4pNfXsGX3cNU6n9n
 4vry1l7LFTEg1vU5bhc3yh8oq/aVau/hzfrI9rDyV9/Dafz2DSizOLCQqpd38cHzJ3vj198YpLD
 Tp3emR6/s86KLRL0qjQ==
X-Proofpoint-ORIG-GUID: h1xBXxAis4eNfA0sTPcSnMEMtrRueWRd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace by address_space_read()
and address_space_write() respectively, accessing the per-vCPU
address space instead of the global &address_space_memory one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Message-Id: <20260616020839.19104-6-philmd@oss.qualcomm.com>
---
 target/s390x/diag.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index bc1791067d8..01cc802eaed 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -79,7 +79,8 @@ static void s390_ipl_read(CPUS390XState *env, uint64_t addr,
     if (s390_is_pv()) {
         s390_cpu_pv_mem_read(env_archcpu(env), 0, iplb, size);
     } else {
-        cpu_physical_memory_read(addr, iplb, size);
+        address_space_read(cpu_get_address_space(env_cpu(env), 0), addr,
+                           MEMTXATTRS_UNSPECIFIED, iplb, size);
     }
 }
 
@@ -89,7 +90,8 @@ static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
     if (s390_is_pv()) {
         s390_cpu_pv_mem_write(env_archcpu(env), 0, iplb, size);
     } else {
-        cpu_physical_memory_write(addr, iplb, size);
+        address_space_write(cpu_get_address_space(env_cpu(env), 0), addr,
+                            MEMTXATTRS_UNSPECIFIED, iplb, size);
     }
 }
 
-- 
2.53.0


