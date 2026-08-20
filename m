Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6271BC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3NS-0001fQ-CL; Thu, 20 Aug 2026 10:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx3NI-0001XX-7g
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:04:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx3NG-0005zE-LJ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:04:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K9JGet2927196
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=a01+Hds8ob4eQ0yaHPUq2D
 LlMH5d50F/gNkUoi3bMMk=; b=EYQ5TxaNIYRg1gtcpioWhjHqtDI/SSLDKJWtSd
 csFBNMuyriPKYgwYBsjiKeW2ak5t+rQNdaMLzwOi4JHOihIiH/W8/h0tNRKjN76V
 PjGHWl94LmYKpiYYJ6kNimLUpx0UUFQ6Zsf+n5KUtsb/y7lxqM6qUVGi0+q3V/s9
 tEN5Nd/z49KQAK9KQzyg84fOWPhTQBQyPRGnjrXEVeux9p7Yd3HjWJzA/UEHdvT3
 uS3678+QxUC3a0RV4QxxHcY6F9/FgrtFCM2VajBt8CXJA39jhAEdTWNV7u4vOTVW
 R1RS5+5xDm6abR9bnhjsoh5U0FQ5hxhEEbF+ZRlMedrfSN0A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk13yj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:04:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e63df032bso110842285a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787234644; x=1787839444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a01+Hds8ob4eQ0yaHPUq2DLlMH5d50F/gNkUoi3bMMk=;
 b=CRAs3f1M3iHrIImMI9fvLKJ4B9kwbbqPqp8/obMMkIFONnyTQYVceuUwN1v+GUPrri
 +hjEKRBIjq7nL6UXeMT7f/9KDEZgN3n5DjIRXUORr22VAyfVfQHZWmvO019vXUTmxsdY
 7a63Osj5KB6frxdhsEaibJUHNc6lyQXZrwa49aYyrcs92HICyDnTvZqTtOjXRSWhxMMv
 MQCRcBJiK4hCbZnO4GdIUZDxUHHI9k0Q+XoMyd7qBkqNdjpLzpnJAE3lWHXEYdPA2ZQT
 8wS+QjMCD7vHwlbNzSoh80Ycx02riiBWyrFSDQpOJ6F+n4hXTkwgAvDQr/RfwZEaYDCG
 +6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787234644; x=1787839444;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a01+Hds8ob4eQ0yaHPUq2DLlMH5d50F/gNkUoi3bMMk=;
 b=e7DS9NM38YvUjBtlHX3gz8BkchkS5y62mz+ulf4WFrJkHrilr7hGym28vW7Z03Sa1m
 WhfaEj6XMtAWfjzjrXOXFqgPFakSJ0Z+fGzSlDCLwj4Va0lWDRNArGgj64RZmGE2i3Mc
 0mEhuROxOrnyODOm/D+wRVO7vULHREVl0qKkBQ1X4Ahw1tzZIATCp+boD+7U+urto7T2
 k8xDmNHnKGz80ytAPCYMvqoKX5ZAAH/pMYejf/lUfMsfWTP2ybtKVhgO6IRaXkWHgVSc
 9AUZ+NO28cSf+ak+7XxLyYJtVH5cJCpGbX1zUFtJYMXBpxAAkwPkW+aKwjqNECD8gg7w
 f7dg==
X-Gm-Message-State: AOJu0Yw3E5VBwR8QOtpEHKhP3jkxcVNQGryXx7YmDZFvDTliy6guH0TK
 vZPkBWeRoBj5yeY+JdjeIxb0wSK0u4CeIGfANZDHLUTacJK+zkFezzCGaUMiTykcWJoPE45H4xD
 62ikysDiy1Z+GIzfnavw55EuwrYhy7Kfe/l4FTvU9ZYrjMVArM1XP39LoqWGcK1dtPqc2
X-Gm-Gg: AR+sD12lCwui1RFBZBXqrJyB2syzG/4R2D/xiI81jXDafvYqeSEXzAybpxiH4YQjuTa
 H1kE96U0qUNOLi+7HsLSdu8VluWipeUsNy2ARRJe1sFy04KSsdNx+B4/BL8Jumsa10ygNj3WXfT
 NQh+2j64p4oizBmR8sfPMkEbNi5b/LtQ/862dMN9gu6cP1z+6/jouRPLzAxOFv4LOIW/fiNjuaG
 NB0nYsLNnXKCaM0rMk5UxwES09Qm6RruwvjetllCjKBKUIJu1j9bvP8fl2kVOobrbvF3MiuPl1Y
 8cccQWmAUmFlI/fTB5oQ9UpnDe0OcKbcD00GTPyihBXV7k5kDWlIOGMGrxLy6N8eZxJg92fjZoi
 PbtU0xzY3/f/b2RBMETLIGB/OggqwT9WbYCwX16+4FUtswO0=
X-Received: by 2002:a05:620a:7003:b0:936:ce17:7792 with SMTP id
 af79cd13be357-937283bd34cmr651754785a.8.1787234644221; 
 Thu, 20 Aug 2026 07:04:04 -0700 (PDT)
X-Received: by 2002:a05:620a:7003:b0:936:ce17:7792 with SMTP id
 af79cd13be357-937283bd34cmr651745185a.8.1787234643810; 
 Thu, 20 Aug 2026 07:04:03 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499ab2a8b34sm177240125e9.8.2026.08.20.07.04.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 07:04:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Parthiban Nallathambi <parthiban@linumiz.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/tricore: Document architectural interrupts as not
 implemented
Date: Thu, 20 Aug 2026 16:04:01 +0200
Message-ID: <20260820140401.26482-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gYO0oTbu31PK1sLHE7kR10CR0SK2itdd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX6CF5YSDubBva
 X2mja7+IgU4l0XZ28vQ54IM0UUC1GAMK9cyS/qw8gAaFPLRV4JLXJ52bTR4SGo22/veNN4ZyajF
 GQv1s/JYb7983jvUCUhvRfIAL/4YgRY=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a870955 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=upbChxJvKZbVNEh_z2QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX6/toFLvu0RbK
 Zbgl0PkW62+ss3MwSWZdUiAZ1F5OSZyMFSha9FD/5zGggZsuXSfF7nPU7KwELeMEVjIMlduGnJF
 kT5nRxI2FHqKbccAzYABKyOGyr5muEuqvJ5GR/i9Myj8vkl98LLxP8tnLFbyQfly90LFZjfHgIB
 yQuX8K2K/87+nK/y8zFgCilGfGSpEXKbNLG7cChoEnuB8+GsT+nIbwRdzdVGvGD4aCb8fSxkHdQ
 gozGdFRELVyBq5GE/HogHXLzAo9I1wiehAPGNN05SPQWfKrmycAx7bYbqzylmZFZFF9HPy/R/TQ
 Xf2oplGTsKtpZaP22+kcj7Sy0Fw9Etxt1g9eSYK+vRYbCrGazZ0ucrnjlaCCqZTfMuaDfHQF2EL
 WK6ABBNoWwqJ+tkEbQwXZSe1AAN7MmBx2xHYqL9+9oxB7E0RygzzmqFVHK656Lp5s4ZcaY63TJ5
 E9wiqinhTtBj7djYCpw==
X-Proofpoint-ORIG-GUID: gYO0oTbu31PK1sLHE7kR10CR0SK2itdd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

As mentioned in commit de680286b52 ("accel/tcg: Make
cpu_exec_interrupt hook mandatory"):

 > Tricore doesn't currently implement the architectural
 > interrupt handling.

Add a comment to help understanding why this SysemuCPUOps
has_work() handler is simply always returning %true.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/tricore/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 6d448727005..82b56c3cd56 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -113,6 +113,7 @@ static void tricore_cpu_reset_hold(Object *obj, ResetType type)
 
 static bool tricore_cpu_has_work(CPUState *cs)
 {
+    /* Interrupts are not implemented */
     return true;
 }
 
-- 
2.53.0


