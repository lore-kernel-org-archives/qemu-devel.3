Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE0AC624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LCe-0003KK-Q9; Tue, 01 Sep 2026 05:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LCb-0003H0-47
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LCZ-0007kT-Ll
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179MIU1892621
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iDP7SSBBed9OilMDhZqOv3xXCrS8V81wrx791E5ihCQ=; b=Tpg3zzEantPz9Alr
 9UInhxO6I8SQTbAmp14U+0DlvaLqRGq+zzFhzZ7U/F9U4ey9qdgfciKfc/tU02J0
 /rzu+SuZ9DoqoSmUPQb+fO4oXtDUI7tEXXJXDCMDxoRTenUwfvITw8wF0xtUULr3
 b2O2mCj7We/ls6YeKSl5OEPgERnPi0sadgUVdut+JND8Ue0h95pdaxMVFyVqzA6V
 TUzMUD1HbzN9pSWYZx8FZkxWZhlSOPasu2A4Vtts/CKhjZo6WFuRkb7I8GeDBTyF
 jWxZicio7rk40HFG+8gXyJszPLLSkxnThk9F4inUiXbypGBE9h/M1iBwO3hVTnD8
 Eof3Lw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7c9r04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:54:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e820609d9so900993585a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256485; x=1788861285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iDP7SSBBed9OilMDhZqOv3xXCrS8V81wrx791E5ihCQ=;
 b=GlaZkz+UhXCI8B3MMaTXXo/iziOIPNVGNMpNvlX3P/6aNjeJXRNiMIcHQcVKybwVdw
 YpKled3IBL7MpYfqM+WyJhJqpihLnlf+nFOHk0a+19ponWIN6CHjZc3Ks1vBDbRzX/XE
 0auVcvHLLbLfaDU4fO2mSfmmNXjrXf6j8Yt/WWl4CCvHfoBGc3FqCBufHI94GdJWMuQF
 q/gpbOZaZPhfAJXyDaHFkoXMp7BPjKxj+DJIugy+8C2ZVEkJzIb7UA+/RaPvaTksjoI4
 7WPEpkm15ewYzy4yr/WuhbFdebRHZkpVH9AcsahCbP1+YmUXsdfn+sE+BZOOHCfwm2Qg
 bvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256485; x=1788861285;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iDP7SSBBed9OilMDhZqOv3xXCrS8V81wrx791E5ihCQ=;
 b=WLG8RfThtk17zvM4ytEVRgxb+jeIxwffXvxWQvB1q9DRM5sN3RS5nkiZZv+tgmmq9Q
 fmYLlSoMMXT3KTjpLwYgV3213fJ9Vuw10TzNNx/4Q46O88wH+rBGdYDPGHU4DYaqAf9f
 kDiDsTn0zcPR9NI4usqWj8u7IFLR8lG+d24xZmF8l0ubY6YHNwksm2wBKhfPc/oaIkbm
 zYnwsuVME4FBgWQBJtQkIbbDvrqDivN65z/JqNYZD0Sdls62msDuNSdtfhhilCKzWnIJ
 UpWlANX0/6Rtc3eIwUmNuJE/iAOByulMAz5JHRxesflw20YrYr7xspCsxDn/mXgQ+RXe
 vApw==
X-Gm-Message-State: AFuF++ndsELFU67+7zhFQHuwFlXnW+GZMCDKIwNky/A32lwVZXGajTDW
 U52YCYxtLDHMQnLUfDdDyABho3Vp7qmLS8dBiski6PVlNxPWrSWl5FlSWtJN4anzaM/zfflsOFA
 c+0d0V300E5rMuX+fakrAB8SVR6sqZDs6B6wD2WmdKEgUVnYSDWGzcnNAMKNzrFJ5pQ==
X-Gm-Gg: AR+sD13iNs2R7oym/lUbb2XOT7tdX7laUt82I5DtWq6oO0WI+Z/YxSUq8pK6qSr2ARV
 xsll9DcvBjzIRXzoYvBmZvMM056eu6FufHEfqXyymHW51Qr10aT5W+m+A1xvMHz2IBzVeMrWsh9
 VKdNg9ijmyUTcbMWPJw1hp6ptByJ/qcEPJmn2xXsRkbxdAPJplOdbLNL8LOe7uv5pGYNLG2w0xD
 nowfYAga4s8hV/Q05gujVjqNOfcsUd/pt/rWT8FBI19WPub7UOiTHRJHuGfjbzrarfuPkGq8PdH
 r0s4PfmIXl/keCN6vWummUxE07xZxwTuikHCLL0+UBdG95D7Mwl7SuijzwmlUZFaiIi0TjGWGNJ
 eKUnEstWZOhaNfRQj8VBfzz1nro4Zd96LXwNG3aaP
X-Received: by 2002:a05:620a:43a3:b0:939:31b5:4e08 with SMTP id
 af79cd13be357-93947d40bf7mr1071039885a.0.1788256484836; 
 Tue, 01 Sep 2026 02:54:44 -0700 (PDT)
X-Received: by 2002:a05:620a:43a3:b0:939:31b5:4e08 with SMTP id
 af79cd13be357-93947d40bf7mr1071035985a.0.1788256484235; 
 Tue, 01 Sep 2026 02:54:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce08b8esm51007345e9.3.2026.09.01.02.54.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:54:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v5 18/21] target/tricore: Document architectural interrupts as
 not implemented
Date: Tue,  1 Sep 2026 11:52:24 +0200
Message-ID: <20260901095229.72018-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OcyoyBTY c=1 sm=1 tr=0 ts=6a96a0e5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: odMQbNLBLBeKLMphXPLtq18qQnAQXJtO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX4ftYA2eMnVmh
 ZLL/7pfyp2hkte5XJIlcCudHfsMoYUwJP96I5vY8b+HVNVkG/1zPx1UyV+5agis/TiZWxybAjzZ
 gvAeZOS2efChcmmpROAVg9n7qBklWCI=
X-Proofpoint-GUID: odMQbNLBLBeKLMphXPLtq18qQnAQXJtO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXwXhii+QcpGui
 FBhVQqZ4Um6n1v6Pqe6MIZxe9jL3koEAS0Nwi4fXx9znsw/NmD4LB8YFFyyegWAA8r+wqxwqiGB
 jcSKf6BcxlPLeyffvDnTUKhgHMttG3czEUAX6PZsa4r7cTy9B7T/Yi3wYdoy1Fvc253Vg9B/eBy
 JhQJOjYuFNH46PQkBPLNdkQzMYmfAMvapZR8qTZLIbk/9uWt/O+OPZhAJD6mRwWo4HKJF5Oqk4K
 pAk6Ry5e93lLHJ1tfev+MUifIb8UHV/zTLEVEL9bUpbBC3l1W4pIwnWuaGxSHYpXPo88M8tfBIu
 RlwfOiJ7H76HUlpNChe7VdevtAT6MsuQeg1WerIU04JVb60XEfv1p5CJKIx0WfT1BTygYDPAA1n
 hKddDsIL/OBlgFJQUDEher62MFDU2sE84SiPs/3MQ/HysKs9/BamQdYrROhegXPB41cfIDkhL3m
 jHFC5pYhTPhkYylpfCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
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

As mentioned in commit de680286b52 ("accel/tcg: Make
cpu_exec_interrupt hook mandatory"):

 > Tricore doesn't currently implement the architectural
 > interrupt handling.

Add a comment to help understanding why this SysemuCPUOps
has_work() handler is simply always returning %true.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


