Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988B8C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfguo-0005kQ-WC; Fri, 03 Jul 2026 12:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgum-0005hk-OU
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgul-0007qn-8Z
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJ1HY493904
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zlzfQXqCfD0fOdphKFvmR4aYcVqlSHJCNldgrmBSnBc=; b=S/bI287rs3JJHLpG
 EHXawCVZGzMlPXPytVpYHLF3iyULJQqIMVgIvQDf3rWsD+qmrKkKd6dO+V2fC7qg
 cacEx9LyvV5bZoWF+7etKKEL0cPPGhx1qSW5YfopJuHStOyi+x9tPyTugUBSMFHz
 xxGRQ3OKQYUZoCsn6LV6CQcsKiuEwzQXLasrRiH3ySZ5AdQuw//auQSJcu5F8b5H
 6fis18ALiClJqJQBK8zHiW/9oa/M+n6q4J2Ntz4eE2VvVjy3rh8mn9wVn/cUqxxy
 wktD4UteeZjkWgY3BYzQG7Fa4VDVPbF+rvAHctPaoMu/Dqk3D97QorQ/J6Ck1RE8
 U4bZZg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u320a5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:38:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e4f946461so69665685a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096733; x=1783701533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlzfQXqCfD0fOdphKFvmR4aYcVqlSHJCNldgrmBSnBc=;
 b=eh/l1zJqVTGlPrKaF9Hsnq40d69JazMXb+K0CjWDK+oTzE2K/M0f5xDf6VZwyXejTD
 Fj6oUVdmyGdtzo3BKczih0Q7za7vOYkaZ6ad8k82LgtG/1HvzTkUeULbp1P3vjErCo7q
 phebgThBEsS1eB1UptPclkWDGbIZ0gvz+0MnfrmmgY/ZKiVdgXuxKB3I3GPJiFFBwZfw
 DBD3DXSxE9Rwv+pAnxrSjjV35h/cLwEJsRscvbCQEW+qWSPpktp7g6vIXvrROCTT2YAF
 XnmY90fOloyHWg8owOUgBYuwvaOz+SYkPP1vxqk8yJom0rVndLVzN6GIc6bTOp7BmUzn
 vc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096733; x=1783701533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zlzfQXqCfD0fOdphKFvmR4aYcVqlSHJCNldgrmBSnBc=;
 b=CmcernjWQmSl5S2dqwlFTMORu3igkrshAJp7sX4mVPkucG2KtTCMZ6nxpuWjNwIbrj
 mgtjOULAR4258j+iG/E1K81NyYk5sd3Hw8aSKbqo9c7i8NvVDBJagg5Z5T63u5xRCo7U
 wS4QvsKA5fFmykD1VnJ9pc57jSvJLSPdD/VIDVa2roOZaleW0tzLg0JA/0TecoEhb4BR
 IFwLzd1qkOlui5PkWvNS6pahssX7ogCD4n2f/0Kx70H9AIAnkNKzg55Fm0zG5tWqyKIO
 hPq1DJkrNoSEMMYWkW7eMheRjVbRoUHlyQrzR8hbb9G5SuqqLP1ELUPGiHagULKWCYUT
 5O4Q==
X-Gm-Message-State: AOJu0Yzo+dTM0TbHh9bNSmB9O6KPUzyvJZMljjlGSbDapAJ0jbu/IEpM
 8mEhLiKY//Y8tLZi9l+yG6fGLQliZFxmavR8JIppUx4T7ZimTwEQQGjSwK+4LQ93TFEl402do40
 ubpilNGTAsNS49Uo/DeFeT8sOxG2Q/j+2IyWXza+MK2kCN+x5gcqaLvPUBtcSsGO5vw==
X-Gm-Gg: AfdE7clafiL3KUasWWdS8nsD0lYxuSw0v2ileBVzYfBPtJGD+j6Ys8k9FqHmUDaFpVR
 AD7D6gIvqcZLwi03ej0IM4t+GSlaPIQqdd/bNqFW6q9jb842lnn8z9HEqV2kumZDC+6TQuox7hq
 WjyJaM/ufmvkl636aOOT/VXwSzYXm7IylXZiCKaOwBZv8DDAWnlCD8AE71UWTDOuw3CaX6RpdWp
 HgQgqNknH0SCSqQkV89eCfqbkrrFB1MdaVPUoqRIvP+IY4fLsOG3njDgfLEG1w8FKVicoGSvFeW
 qAAjxe3yWLAkvC9seSWGRpeNH5f9+nEcuN5TkCSeqBHApk2kDx4bRlLI30Oz6kc2n05NrANyJuM
 VPBThWufTBhEPDyVZcuOsxZjetnEUqVpLC1AtaCnSeqXP1Q9aAJjr7lo8OZJ16/2y2hqO
X-Received: by 2002:a05:620a:46a7:b0:915:9fba:8795 with SMTP id
 af79cd13be357-92e9a31392bmr30019685a.1.1783096732926; 
 Fri, 03 Jul 2026 09:38:52 -0700 (PDT)
X-Received: by 2002:a05:620a:46a7:b0:915:9fba:8795 with SMTP id
 af79cd13be357-92e9a31392bmr30016985a.1.1783096732484; 
 Fri, 03 Jul 2026 09:38:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c637568dsm157926725e9.4.2026.07.03.09.38.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:38:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 07/33] gdbstub: Only return E22 when reverse GDB is not
 supported
Date: Fri,  3 Jul 2026 18:37:30 +0200
Message-ID: <20260703163757.55500-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9ZbhIKR37dSloC6RD64wi0Ct9xNaARhe
X-Proofpoint-ORIG-GUID: 9ZbhIKR37dSloC6RD64wi0Ct9xNaARhe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXw2jnP+Jt7M5R
 IvC4TGNfURA5lgP5maeAjIaBRxU92tqVFlQtUvWVyVWyNfabQsrNkCvyBiJ3xN8aOmgFfiFPfTx
 cQB9VojD0gwCmZKVVa7cNfwNzm47dG4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX7wUMAekcZ4xG
 RikksC7KzvzY8GcoVHIC16byXA4wss15oD06ycwgd0IuQQfzd2l8jwWr+wTLsbgccr6T5U1iPa3
 dfWjJwSDyTmGv+diktK0AF+mG0qG3oRbUX5zr79UbYCXtWNF1o+Ubc1TGWi58cbdA8mOAhKHQEu
 jNNAwucgpt7r2uYDUt2x5EaZ6XX6oKkCn9Uu7Sgiy+5ffqN3zvInV09iWpebSw89eQYz3MMr+UU
 pbur2KUe4fZ7exLdrMUKVTNu2rb6w3EwjiYMnBeYeLk8uOAbYu8NPzVwRIG64XjxoCXR5XFXWZ/
 r21RC1CnLtfWGrbVGM5jhQvAu8M+Jg1mhCpKS/kTUOw6fmF0fyQgP12JNFcyl2MCx6aIypUSqAQ
 Ay4PaeaiAgiVwapWfhk6ZfcWu2TuJZ7ytbGrv3w5T27umpqWfH2kmeom8b1OGMtkLgM3H15lfZb
 5pEHvyyQ6RrL/nG3mzw==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a47e59d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=0n23ylXGgdPVI_k3iFEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

No need to keep processing the arguments when we know
reverse debugging is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 246e7746300..f54415a9db7 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1378,6 +1378,7 @@ static void handle_backward(GArray *params, void *user_ctx)
 {
     if (!gdb_can_reverse()) {
         gdb_put_packet("E22");
+        return;
     }
     if (params->len == 1) {
         switch (gdb_get_cmd_param(params, 0)->opcode) {
-- 
2.53.0


