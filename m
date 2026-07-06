Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B18C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjf1-0006qb-OK; Mon, 06 Jul 2026 09:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjeZ-0006aX-Hp
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjeX-0006LC-QE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:31 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxMHx316792
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VgjHWAw6InKlS+1lEYDJ+TpMs8mphoE9ISbtQeMuI8A=; b=kX/0r9CvPi0SC/h/
 QAwoVyILqXEzricP2XmQZWorBknPb1jH6jrAxqyI7tVX1xJcggip96Yb02/rUf2v
 ehq512zy8wmAH4UTlRQRFvJ15eoNQImh2nBeqiRL0+RRAWKyfX+oyqhftVsah4mH
 MfJpUSewINyhQBRujGH9+oOdHMj5uV3wcfI7bPHJULuOGkj2PmDsFkCH1TZlVsjm
 +pI1tv4sBOjl7M8ozJEmaqkeXqVpqlZRAOSbcr3qLwhpVN2yyZ63hgIA7Rc2C4Vu
 BS0N83T6CYm9vgAF34DNjUnGw8295SYGJiZxkygOZRhAi6/zNW17e16ZZMz1um0J
 bNQyjQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7hhwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:46:28 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ab02fb3054so1438689e0c.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345588; x=1783950388; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VgjHWAw6InKlS+1lEYDJ+TpMs8mphoE9ISbtQeMuI8A=;
 b=cz4ipw/3bsmt0CX9Zq4MqeGykK0rBp0B/27JzvUi/Ql//keeOxTappXNyIxLIZ1Q6L
 KiKM+bFBpQ4M0JBo8sBuJ8HEaQ4i/LQe59OStBSWE8Ls6sYpMCmy+7ntVo/fpIhTClWT
 dPobxEnVfqINnbP/IGNgdxVhMvyQNXyeoULwlweGgbMEERW/4Bo8j8OWQh3axxdhq4Pp
 GLv7w1UBw41TEv3WT2BdRPxCs0s0Djv2tSw4lBU+gyUtSCCkZVGD4Mmw1Lmae1HJR/yt
 5jb+/bk1PpgPCc/POVTzRDlvUJfX+5GoiZW8ydouDC7PcYFkGhcQEKs8qyk4moNjmV47
 VhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345588; x=1783950388;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VgjHWAw6InKlS+1lEYDJ+TpMs8mphoE9ISbtQeMuI8A=;
 b=AD8ge9c8Jlyj8FSSNrcB79sE5UEph58iHxRRJGzvGgB8Mvpx/XeGUt7FFF4GJhPZQR
 xG0OhsWO7VOD2Wodcm41sxiZqnY5XJKwXgC8qH68WsPzwYCPlriJnph6jMwMWbm2nE3B
 NXWLQu18+L46SR2hVT3GnO/MAx0gdkycn3Zv6GpeY18yN2/KkDB32sbIyeprGthwSGSy
 CVf/i8C5ab3OIZweg3xGXMIGgHVeVTOszg3lUKsc1+DvCN21p9AYbZTVbr4QdlB20vfc
 UFK1cN9+nzi3O1pB4BE87bjBA8zp6wAqhYITmQs+0HPBxlOPhan7hmSXy+i5is2uALrB
 a69w==
X-Gm-Message-State: AOJu0YzP/kP7PI8ivm+EY/ClV4N5SZ3PUalZlOzsm1CWf1/r3GnSzJr5
 B1yR4q1FzAJyRoxNHtndysiKp9jEnFZJfxOBe0f30wj6MhV9GbZstA6pZ/StfC+64zojoW5NWSy
 FY11qxoBi1rJHOIxnjf78vLIWenY54vEaF1AYOs9Y5t1PiLFS1yS6rlwxDauX88Dvzw==
X-Gm-Gg: AfdE7cnzOULNoq2gvCY6m5Om+Z6wLYDle2hLlgHTksUPP45Yd1u9TpXD9+C7j9GwVe4
 nocfzy1m1ZVHVWFlF9wa0JdH1SW6heywHZzA/nI4YPtt5sIaqca3e8rF5oVW7RwrNip4VqGj/0L
 Wmvyt/6g4KB6M+4gFH1TcdY/lhfjoWFNt+EvggepHul0xVpD1bZ7CP8j9RzXEbsS2BuNBlKtPZU
 pz4hX6q5facuprSaPoo1D5GdcoY+fubd494bPGrdWAdmdZzzRNOCKqGV+4CR1CVthUvguYIoulI
 iisUu+EKoKErc7byLaaeJaRhJt1HXeHoXUMCshM/PnSy6cQrpiQC2Uraje7uEWAby2G+6xwjmVi
 IXA50YofVMYWuwfS3Rl7cy9lX4Xe86QYQA7zvhE1Xz6eWAsqnpH5BWoOsmw==
X-Received: by 2002:a05:6122:e183:b0:5bd:ac45:5b04 with SMTP id
 71dfb90a1353d-5be9085f27fmr299530e0c.9.1783345587950; 
 Mon, 06 Jul 2026 06:46:27 -0700 (PDT)
X-Received: by 2002:a05:6122:e183:b0:5bd:ac45:5b04 with SMTP id
 71dfb90a1353d-5be9085f27fmr299511e0c.9.1783345587493; 
 Mon, 06 Jul 2026 06:46:27 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d7801sm25533406f8f.16.2026.07.06.06.46.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:46:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/32] accel/mshv: Fix pointer to proc feature bitfield
Date: Mon,  6 Jul 2026 15:45:01 +0200
Message-ID: <20260706134527.84808-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX8UWlJkIZUcl4
 oZNEuPLZSdOfk1py17rOSGerbL4oR2oZyrNrjC4Yaxnq3JT99KqPLWK5Dl7zJivuZU7Xxi2PlSe
 CCUkaeGCSjuFHqYe9xAozlooJtTsD38hvYyDbozNf8UAjS3FTFaPHYbWBv8eBg0a69OkXDpKW6Z
 yf6CLfopiJL+zYSCTtOuXR1AMFXJtLCfLgmNaoVu7MmA1f2F19u84gdk7jKB++p0JT4FvHg+b0t
 6NLh1Kkvn+8wASfPI+EyT5P1gzO5S15QAoJEqfmZovJgimH6xOdmq04c41ZYLtO+gtfAKDcaCUY
 GaIzArrcVN6/eTf9o3Nhvutv8m+f1ysXdOJsCQi46uAPfrL1hbKmU3qDtIEfY66C/Iu7BRhjnnf
 09Bwl+VlqyhTx85wDJGW1zaHzqk3Pa1uJUXPGVahpXQqSQ2+H1/Uc2QertCUrgVKRP///ayUFYT
 1m+qmlYgWL7/Os0Xm1g==
X-Proofpoint-ORIG-GUID: 7XrRev4UXDUZ3m5nFDLkAv-G82aleLrG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX/HvJPgOw0+px
 5Cov+ZgP84N5Mh9rH36Dmr0XeI19uXk+slMarUGGekz9wwlAshpvHMXYdjOoU19WAyRZR6ui0PA
 uWAAD2V/sZrue4E7BdWRPFJwHeUH+wU=
X-Proofpoint-GUID: 7XrRev4UXDUZ3m5nFDLkAv-G82aleLrG
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4bb1b4 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=yMhMjlubAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=E3Kq4i6MJonbbSQa9EIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060140
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Processor features are stored in a union containing two "banks":

union hv_partition_processor_features {
    uint64_t as_uint[2];
    struct {
        uint64_t sse3_support:1;
        ...
    }
}

get_proc_features() to retrieve the 2nd bank was passing a pointer that
steps over the whole union (+16B) instead of picking the 2nd bank _in_
the union. This manifests in mismatching feature bits for the 2nd bank
and possibly other side-effects caused by writing beyond the union.

We need to step over the first bank (+8B) by using as_uint64[0/1] to
correct this behaviour.

Resolves: Coverity CID 1660876
Fixes: 2f6da91e8a ("accel/mshv: store partition proc features")
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260701130335.418156-1-magnuskulke@linux.microsoft.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/mshv/mshv-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 1959baf6672..72721d0f0de 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -167,7 +167,7 @@ static int get_proc_features(int vm_fd,
 
     ret = get_partition_property(vm_fd,
                                  HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0,
-                                 features[0].as_uint64);
+                                 &features->as_uint64[0]);
     if (ret < 0) {
         error_report("Failed to get processor features bank 0");
         return -1;
@@ -175,7 +175,7 @@ static int get_proc_features(int vm_fd,
 
     ret = get_partition_property(vm_fd,
                                  HV_PARTITION_PROPERTY_PROCESSOR_FEATURES1,
-                                 features[1].as_uint64);
+                                 &features->as_uint64[1]);
     if (ret < 0) {
         error_report("Failed to get processor features bank 1");
         return -1;
-- 
2.53.0


