Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BA8CD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjl3-0003uv-0l; Thu, 11 Jun 2026 14:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjl1-0003ub-DU
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:03:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjkz-00079r-O4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:03:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BErdbZ900494
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LsIM8i35ilkpjPZbZh+AR3urQ563c1AEKPyf/v2iHQU=; b=A8vWALgZegRoPBh6
 aLFuU9Jxav5uMFa5aqjRTeq+2GfONMqm/gCbgsGWzRNEFFPzzLCk5O5NNLWU9haK
 wcbnIJNE+DoyGWBc+n4urm93/AvmHQAVOVUnMnx1aGOdqE+O/SCKR+lY4zfeSWhg
 j/WBzpWwxtAedrkQCNdkJ+mRMrDnf13Bi8kc5bmgpRIeH2p6DxtYTpgTKmsVQVM/
 5zkMu+XpTIhqyYlPy9rtuKGH9fsUzla5Tl7E6E10I+OTL6h38WDTDOTWz+EqPou6
 +jR1MzMHlFhMjMwm70PUnGhREfhKbgOrvqI3dxX89RLMFINzeSwKWJMFjClW1qen
 kzn6QA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe704x8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:03:56 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e713779405so329225a34.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781201035; x=1781805835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsIM8i35ilkpjPZbZh+AR3urQ563c1AEKPyf/v2iHQU=;
 b=G9D8N5ZidZKR7qMYNjX6IOosTo6kDOCIjT92F+fKcXuzFrUy4JBoHKeVHrqd3jKT5S
 Ujd04zWN+bDWRgspAEepc4SDEO1D8O7V5jdKbRdhCma3E8XxMjN7FV0R8SWN9+Xbc4sW
 ghYXs48qvZzTXKLB80SgtcDIpeXF2aHut3bokSdLZIc1BYtVtHPRYqyGleVg+AhWdFGJ
 fyBoNPuafN3+nnCCz/AqFIsE/0Kg1Xw9Ou/aIxikJsb7HocsYgNp5/1IcDRDlXVfDEBZ
 3k9y6l62MB16tt0AQksl+wk9Ba9lEDB9G0pB9zmA3dmWyqxoZmslMDz1T80D4G41G2YG
 vv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201035; x=1781805835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LsIM8i35ilkpjPZbZh+AR3urQ563c1AEKPyf/v2iHQU=;
 b=KvVgDZPII7pg6yE9ZKPGYNgtySIUK8b+LZ1FhEp0hfKZjnekMcy/gz6Jj9C13m4z/x
 WMNYB5jFNuPNXhU2sC7s/wFtoyzTq6JQO8XRtobPH7emX2GMxuk6D1v0KSTH0MaJD3Uj
 hNT7mcjKFEnNqk5I9vYBqryNPA7Bx6uatzqCnYUxflRUEocymnDK8yY4G94U1OQSFqjS
 2axyORb+u8ndV4NZIncggVhMXDsmaLaAdr5rayNeE7Y5/S210FeAQHVBosTLx5WXjB5Q
 8TPsPFlt4aYoUyI9pwtbRfX8y8XrGb8eb2YzU3jikuxXkLct1ZWCnwbmvPnDImHy4bBk
 j1Tw==
X-Gm-Message-State: AOJu0Yx7tTTrJWsmXbhZuaqwEavTa+G/PmhMkx4ztZCPHKhiPDSuLj6E
 yvSwECItvWa2hcD3bwznfJoIFZuvn/jtFNTwQD4+Jr0bQOmqBTBiSqNa/rDZ+oYH3/YJtPj7X14
 8T8HXcKStBwNxBcHReGhT5niilakYAB3jq4JgUIKufR559unvjZ8h66eN7ngkcx+JstNA
X-Gm-Gg: Acq92OFFVRoDCtNSBBZGjchyvx+99yb7jb0FreynSSMtqsTVhU3MuSOif5ry3yfFZGI
 oiSdAcNBNoe0YkG7MEN2hhC80ualwgTFDj8x97WXP16oWI5/jtqvxjWwM05nPXm++53HM4duNda
 YFlS1RRlnfrMwZppbKnZ1rCWK40e0/WErLAVoZlgmx58rAp7FV5Qtdcsm6jzBNwf+8E1IVjb+Ux
 Qn1EwV4jb7laXpGzitK0qNMyRD1gNvgAaQJ6FoA9fkzNrVtftQmtiP9lzrawK3c+mfpOYKyGHdP
 HxULIEelACQxQkkCI3KubUa13rVXzALgrqg6noJiaME448je0nDuplu5c1ow8SuhyR9G3uauPuD
 Ug7ziJfcCkhGU8MWdqtazTzJx6q8uP2TdVqlSaSAJBZlTWLC7rs0Jj+ZPAkooq1uNtVZ/wAZGFr
 3v3MIwGicD
X-Received: by 2002:a05:6830:6885:b0:7e3:6b8f:1e97 with SMTP id
 46e09a7af769-7e773361fbamr3312158a34.5.1781201035460; 
 Thu, 11 Jun 2026 11:03:55 -0700 (PDT)
X-Received: by 2002:a05:6830:6885:b0:7e3:6b8f:1e97 with SMTP id
 46e09a7af769-7e773361fbamr3312089a34.5.1781201034751; 
 Thu, 11 Jun 2026 11:03:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c0c2038sm665736f8f.8.2026.06.11.11.03.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jun 2026 11:03:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 4/6] target/s390x: Factor common s390_ipl_read/write() helpers
Date: Thu, 11 Jun 2026 20:03:18 +0200
Message-ID: <20260611180320.30320-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611180320.30320-1-philmd@oss.qualcomm.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX31/xSMehlw1m
 MMsD3JQnoro2MkyIFVkHoPwYzsqcZMk7U+wrrEUgTZfmcjjviszS+xGMQvaKzkDG1S66EV962m9
 NXu6zFbTcdrAc7xXsdduXcmmYGuW2yXoBDLb1Sef/0gSJ7BIhu2PUlic5iexu9UmrYMbnkSFpAz
 Ykfb5ch1Pg1KHPqXSdgLRjGIUnM+1gtFR0nGReCNB7fOYFBBYitLrcnxj1q64UvDFSAbuawtC99
 ucVn8VkTedcVu47Xt/f2uahbnuxbv6SGIUCiUY0vBM1Vs+hiCUXRixJShxdenU7RJU5gQQ5EVju
 KG7NRGTIUARxLBSoJKu6k6bxJI8fmy18bOQYDr9L3hmaICmtnUyzsug5butxf/nM5nGK30lbN9Z
 pF0iFiCeeSrBQ90agEbhlMjxV+WvL93b3Pd7YgEsjNu6lJd4qtfIVH96nwh3gXauuDTQnt8acvN
 Fqcs/mxEM/eVhlwT47w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX5Y/RoqzrqwDK
 mdCMfbGORSPN+SdlbREjRVUTZq4RuDRSOc/Z6qi1CuKnmStz4FRLVeKVmYRCSVlAyOc6xSAiN2l
 sMG1fchta4bij4cAE+qLgkDHEf2keHo=
X-Proofpoint-GUID: WsZAjvYGgqKGUg3SjCFMiF-3818jGQ3b
X-Proofpoint-ORIG-GUID: WsZAjvYGgqKGUg3SjCFMiF-3818jGQ3b
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2af88c cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=69wJf7TsAAAA:8 a=5U_tvQ_toz4j2hBgumwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=cvBusfyB2V15izCimMoJ:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Prevent duplication factoring common helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: qemu-s390x@nongnu.org
---
 target/s390x/diag.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index da44b0133ed..bc1791067d8 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -73,11 +73,30 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
     return 0;
 }
 
+static void s390_ipl_read(CPUS390XState *env, uint64_t addr,
+                          IplParameterBlock *iplb, size_t size)
+{
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(env_archcpu(env), 0, iplb, size);
+    } else {
+        cpu_physical_memory_read(addr, iplb, size);
+    }
+}
+
+static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
+                           IplParameterBlock *iplb, size_t size)
+{
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_write(env_archcpu(env), 0, iplb, size);
+    } else {
+        cpu_physical_memory_write(addr, iplb, size);
+    }
+}
+
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     bool valid;
     CPUState *cs = env_cpu(env);
-    S390CPU *cpu = env_archcpu(env);
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
@@ -114,22 +133,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
             return;
         }
         iplb = g_new0(IplParameterBlock, 1);
-        if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
-        } else {
-            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
-        }
-
+        s390_ipl_read(env, addr, iplb, sizeof(iplb->len));
         if (!iplb_valid_len(iplb)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
-
-        if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
-        } else {
-            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
-        }
+        s390_ipl_read(env, addr, iplb, be32_to_cpu(iplb->len));
 
         valid = subcode == DIAG308_PV_SET ? iplb_valid_pv(iplb) : iplb_valid(iplb);
         if (!valid) {
@@ -164,11 +173,7 @@ out:
             return;
         }
 
-        if (!s390_is_pv()) {
-            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
-        } else {
-            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len));
-        }
+        s390_ipl_write(env, addr, iplb, be32_to_cpu(iplb->len));
         env->regs[r1 + 1] = DIAG_308_RC_OK;
         return;
     case DIAG308_PV_START:
-- 
2.53.0


