Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C136ECA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByNN-0006PI-NS; Wed, 30 Sep 2026 13:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByNE-0006Ej-3k
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:45:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByNC-0000zw-KM
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:45:43 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfdkP3785234
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sAmDnVhA0i46kh20ES8xQX1cBL9fdB8dlxe4KkbGoaE=; b=RsHNSBcEI72GB19A
 WGtiDHs7/toLzvBQ8OZQc5UMJS7KTBhjOReSAMYKzhJumfLuu1hFMg3gzSuFKFSA
 oPLy+1ZzN8lxURzWTw9YcJGd+mpSQq+ty2KaF0Y17GBCfcuocQTfE2G+d3LWt5yO
 ZAStQXcpHy6yZx51fMTHo2QkO3bPWC85xuG3S6Yk4pKY35gfYv978c9Sev8SEqjH
 9k66E3wnnadHgVoq4ZI4ayG/hdGDTl0oQbIyA8wlY8cY6M53KvhqUBqT85YSlI5e
 azQJ5r9UxEkMU9JBTbttgkXnXj8sb9wwmyz6SMsV90Nyp8TCJ0BUaiukguyXBTx0
 /dgg+g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn3pq3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:45:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so4668385a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790340; x=1791395140; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sAmDnVhA0i46kh20ES8xQX1cBL9fdB8dlxe4KkbGoaE=;
 b=elG8WD2yODT4M4KSx7wXk0OE6FYa8mBECjq1+VYbFQS7pNopiZe0RGE4kaJQQOz7UV
 HXi6V+aZq7/+tJ9tNX3hYW4zqNNH6Ft9RTixtZpMXuZWER14HRngFmPyrDoMcC/8x4Os
 jvLLpi8B9uleyAsSGfPEg/pIPjPDl+Gr1ZF3sQ76GNJZdmvwWAZcxNBPuBSRB2OPAkuU
 ckeXjYnBNYISlgLyfhLmVmlGtyE44wfLBCk1+ao7DqhUAL5d20IRARyZ97ayihGzbapZ
 wAq4BlP8lQx5PsS3yahjf++O9NO4I1vSXdTolvrn/wtY69T7AX58G9kHJmlAJNsknu0E
 FUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790340; x=1791395140;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sAmDnVhA0i46kh20ES8xQX1cBL9fdB8dlxe4KkbGoaE=;
 b=v+XOCVS1g2utEt3/3Py7PO8t0N8d7yYiOCDcUgMixQSOpl7BuyZpWLaEcc2RnInHFq
 zPzYFDDDbQXX0aN1+EujFjmZQUDuWzKq2stZM7LidfoSBrfdgEj5q1WzP40NEhF47+mO
 R6TEtWQBZLZYTSg4TE+48CvpwRN0zixVVRwwTY2x57K1mVdsOOa+EnRnWLmShgD0X+Qi
 OourKx0pDT4qwm88eoC6SdIuVVHNwOFMgNbnCBsbjcQUIMpp5M7avVWjKNxbZ89z6c+F
 6mdeYdFrKs8pWbPK1Hh7GNaH2I/iiIVcaw3QMQFXPiz+70sQCAx8lN9XTCvo5ElRLBFS
 2eEg==
X-Gm-Message-State: AFuF++l55TWFbACEEeNC4OtBHHJYox14ugJFp95Mwoi58BQhvhS7lQ0V
 3JRnwx8ZFLP2DXt6IzqXzfJDz9xTzKn+Xe1SzrF6C4uiUBYEGUMxcV3igJHiqV56Y8EsKWWHDHx
 N4NXQkVRJUF3aT/tJWdfd9Zru0gkcWw4sZ8PrhcrlhXnLPLBnc47hwhbu8BEM9M3thA==
X-Gm-Gg: AYBFou3WOh1NeHoXlMaWA6L0UYVdCMMNCj1pftBjJO0G+eqYjJETBhhwiknZZp60tJr
 dPqM1ZJ+GGNZ1koGgqx2l4Wl3TKaf7xwbNv15hFggCfGVQPbIkGVsyBFQEcKi6RtYLbw44sAKls
 DryBUJOfTHay2Q09KIoB+4bwhXKDIj6fLJHpk9fk2f3NWUP4zNE+/OU/M11f15ymhGsHCk2Ihxl
 bG3cUEK1zhGRKwl14UAf/RJq4PFHfQ6odrxMr2nA10FkGa+8lNA0f0yVnHnBEKFX4RNxE/svp4p
 pC0BNmuE4fhUi84HONisy/fdwFSXpnV+hOJuxFaL7za+M2C++DIZpIM+o+VYK8bKbB+XG2RUpr1
 lEv+lL9e1c50J0WPwz0CVtQTF7p3LTTxKug1nwktq
X-Received: by 2002:a05:620a:458f:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93cb5c2654bmr70352085a.33.1790790339527; 
 Wed, 30 Sep 2026 10:45:39 -0700 (PDT)
X-Received: by 2002:a05:620a:458f:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93cb5c2654bmr70345085a.33.1790790339012; 
 Wed, 30 Sep 2026 10:45:39 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bc9b1sm700515f8f.4.2026.09.30.10.45.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:45:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 4/7] target/riscv: Have riscv_cpu_set_mode() call
 riscv_cpu_interrupt()
Date: Wed, 30 Sep 2026 19:45:04 +0200
Message-ID: <20260930174508.81497-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174508.81497-1-philmd@oss.qualcomm.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abd4ac4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EurB-bMe9Chw_IDMuCwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: IPjKQz9AmRzpOYxnXS9wrIojAJ_X7omt
X-Proofpoint-GUID: IPjKQz9AmRzpOYxnXS9wrIojAJ_X7omt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfXy06uxz7NNm+Q
 umbmBZngJSBtpl6XM4/2T/vXPH7xhoNUdpCJwD3rxXjMxgTxlk2+skG2SJeQRdUkWb9Al0e7wQc
 z7CWnZNN1HhWcNFyw30XUHTdkea3q2RliD082szdWyEP67wIyF1kIWz2H2b38zah0owOM1lVPKz
 m0ldGs2hmDzd36KQ5k0LQAxs64uHYx8f7CjXi+m08U81I08T6g7snAZA/NrBBQZ717UFrbanu73
 Ut7CkOZVUIdLJh5lPOqTStIqMlNWtPCZsovjX/+IFJxqdXj5kwlgVgXaD6NgJ6D80XhlMpqynmP
 X2CVknr/Q4o9gAzhsqp9cW4G2mH/5UowwBjYPllWHp0Q1sE3LPYVnAwRHClej0NCX+0bVRax86p
 TdNCewApBfmL9NldBEihJS1dF/HkVxEEyeaqETBwYzCJVKrFmieaj8dTTGMUxZtyTm+3CPtvGuc
 DmMqEXF+wuxT/1CN37g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX3XTtOuTLTwU1
 7GmSuq8kkirtAlYh/OkhdAzDOxUUYmaFyjjWodfnbDB2xAH/oHA9wP9vSLfei7Epr+oG99VHzlu
 8KRfDnKVHwzUqyW1uikbR02XE5Q9DMw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

riscv_cpu_set_mode() only want the interrupt re-poll: the mip update
with a zero mask is a no-op. Call riscv_cpu_interrupt() directly.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/tcg/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d92226527..91f5eb72930 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -886,7 +886,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
              *
              * To solve this, we check and inject interrupt after setting V=1.
              */
-            riscv_cpu_update_mip(env, 0, 0);
+            riscv_cpu_interrupt(env);
         }
     }
 }
-- 
2.55.0


