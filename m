Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A6606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ljhsZ/Sh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gG14k0hn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzev-00018S-FS; Tue, 24 Nov 2026 18:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzed-0000WF-HR
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzeb-0005Aw-Il
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:27 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMakjw886258
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MOCwru7CgqW2hjAC218zoh9Pr76di4Dt2cJj+nqiAZI=; b=ljhsZ/ShdJfrWMj0
 tj7UXyXabQrlH9QdvdPvqTT+VaIwDDoAtsKwmv1XCGzp4eHd4Oa4xNtXD4pk8sYi
 suHD1lqbjO4fibKOjcd++ugJ0FJt1YpcDtDGJW4N8NsrMo/tIth9g9vrFoJDqgU1
 gj7isESriMqzxctJSbAPPKgcYPz3VRHqs991Udrg7kjZkbMdWd0UyrUXKUnOUj/k
 ZXQDzAuTQwNTN6hs6k4JQOVvUnY3R8Yu3NMr3lm58VH1h7Z5zhW5dCdvspLQNEjj
 oz5Tgm+x3RxrtaYGB81y0TKWM33uUUPmU8+xnum1p7HTFivML1UM8h2qoQf5Xwl1
 URWYfA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rhca2j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55c16eb248eso85429261cf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561823; x=1796166623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOCwru7CgqW2hjAC218zoh9Pr76di4Dt2cJj+nqiAZI=;
 b=gG14k0hnFSPGeZWqu/gyDAiUEnPtYGTdi1zwXP0uYrV0i0ropVi+V+jXNqZon7ak65
 zCJOKvTJnJv9U5NpgvARi7ok6FCA0E1xonpzHpKwcgIjFfB9g3zJI5iohjcQ5SV0KudP
 Xig8e3yuiK+bP0flA7iPhS3MuKKZPACoZAS3QtPj3jIXV1bHXgXNzO5YMF/6+bt9bc3F
 NGGFnrrEj0PRbyySHFfAuWAi1GXHeiWLz7QzXrEVBnjOFirWz14SXZj2ih5e05kkwXXs
 w1aEqcmFABpttn+ZGadCS1sbs+5oV41oc7k2u7otMh8bhP29sL0IrfrIhucVu6EYeikQ
 zi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561823; x=1796166623;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MOCwru7CgqW2hjAC218zoh9Pr76di4Dt2cJj+nqiAZI=;
 b=MjvAoZ3LIxSB5IpHW9326/k5gi70dwbc6oMorcwt680XCett3Glws4+XbckngXI6Wn
 bmj7KzmS8I7YNm97VngR747i4TX1IytBHpjMWcAS9r7FSGHFW/kGNhPdM0tEqXNMVAz1
 LYH8VEN8E66izLsAru11l0JTCNdtts5jpzgZLks/xA/WDQE0ZeWhC2UEInvDX3y3Ns68
 ldi5KkkKLiZRSDaLZ4Ofmwzq6VCH6yhUJPKjl7IFuYUWL2xGtB9KSG9y41fcn3EsPfLa
 8VcZTzsfdgWgzbtzk/c4j0NEzL/UpHSgEVA+8uobT7QXNUBIS4JwSx7v8kJV5ionQUmh
 o/LQ==
X-Gm-Message-State: APuU4Z+8XJycheg4e+lcvpKOI/2xeCIV9VQvyAX80usTzCYumuvr7TVe
 Yr1HejEK8gAvKSnn1ymq5I7eCEvT3SRG598jX+Tv7YVuLobjYb5nDFgCtSH1BJUZtFukKc1rF9P
 WWeqDEiJZb1YGttdkfZpYMN8DaTvaOmHTJ2tYGTVE6Ypstp0pp//8i828DXBe6gGrCuAm
X-Gm-Gg: AZFdTZcjI7846dq9rVVxI/wYyUoiv2u72oxfL5f13uu03Cm5fw/igB3TzEcyIQNqc/B
 9eVNyt2FB2KqyCqLepIGXVJvaLpgOl7o5sWtXXAkRiORJh/zk+SKoJCgCPtU8rGev4VNlT03vOW
 xiEM4NBmfEmnK7GLe655I7ZQdTkLdnNRUZAOquw9IvHmGSlWNVv5d54iuUBLTElEYRXcmkf7flk
 2ldr8NCw+s2iUbn5WZXXSfbqKo06eMA8JbZK4fEq54P3OnzNUOTiu9A2/LA5kWTnZAJupCtJKKr
 GWDLTSHuFUjl3pnwBRg5XhZ6fpXOTCsokTohiv6m+2TVUbcZCBrSaLMgA8fow2vGSF0e7LRprty
 p3kJBC/dSwui/INVuFd2U0JqRgPEX0B9+HZwTVjoJDdBKRvQkuGSW84Y+2wV/h/ojmsUvS1skvb
 mrfmqRFRDTct53lA==
X-Received: by 2002:a05:620a:2a10:b0:93e:d364:c9fc with SMTP id
 af79cd13be357-949ba7cb3e5mr2964377085a.5.1795561822868; 
 Tue, 24 Nov 2026 15:10:22 -0800 (PST)
X-Received: by 2002:a05:620a:2a10:b0:93e:d364:c9fc with SMTP id
 af79cd13be357-949ba7cb3e5mr2964373485a.5.1795561822392; 
 Tue, 24 Nov 2026 15:10:22 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm29020463f8f.18.2026.11.24.15.10.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:10:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/17] hw/display/vmware_vga: Check for bogus FIFO_STOP and
 FIFO_NEXT values
Date: Wed, 25 Nov 2026 00:09:09 +0100
Message-ID: <20261124230917.88704-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b06195f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=iWET08XV46NplaeOuFIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX0tcVtUSJN0UA
 QRzIKuQA+hc5aQUsmBZrraJi0wvL1GbzufLntIcWakMuNirl/oxfi/vMfLxNpz9DPQaW+9F3SX6
 Ai8r+Sh00VPFZGm4iLTA0kygHN8sl1Y=
X-Proofpoint-GUID: _cQ_A70DVvwF-TGV9Fj1lOHE8ZVZTOvh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX7UxeLNKzHBg4
 1d2CTwTq0YV+2FYCi5cg7N6FZoqIGRNq4NUbKvK/68uqa3x2X0i/r5a3VLh8Z+PLFNyUl23hsCe
 b23TaPwN4SJD8vElyY/SwPAMNObvzkO8OqLaMIdsga2DcQ/22gGouTKxXP4WCnvxhQ16hJQHy/T
 hLlmSM1SNkdK5myKZpevSEqBOylQZdL2OyDizM8pEq9sWIo3hW+x6SJ9cvrcIW1jzWv3iEwYDVf
 XERO2FhFbDGxUnQr7SekyXsxpbJcA9WZm9RaBxK/RsEz45uhigBFuuNyoN5lDQufahP91gac3je
 42PBFj5K6rzLoW7vGewSHHTmWzkKgWoiejDbFwu90NuIZ2nUDWs5NEoc5XmGhu12iAYi3N29S/w
 Z171k4z2LslLJrc4P+zbXFFFUXWyd56AYgw//84txmX/JkR5p1Or79N5egLUS7fXp2ylMIiTxtf
 WuonKFIpKaA2p8/jBKg==
X-Proofpoint-ORIG-GUID: _cQ_A70DVvwF-TGV9Fj1lOHE8ZVZTOvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
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

From: Peter Maydell <peter.maydell@linaro.org>

The guest should never program the FIFO head and tail offsets (in the
FIFO_NEXT and FIFO_STOP registers) to something outside the bounds of
the memory area it has defined as for the FIFO via the FIFO_MIN and
FIFO_MAX registers. If it does that, return a zero fifo length as
we do for various other bad values.

Bad values here won't cause any serious problems as we were rejecting
offsets that would cause us to index outside the s->fifo[] array; but
they're better rejected. For safety's sake we add an assertion on
the fifo cursor before we read it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261124095719.4126146-3-peter.maydell@linaro.org>
[PMD: Cover whole range in assert()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/vmware_vga.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f72896873196..353cef408d23 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -581,8 +581,10 @@ static inline int vmsvga_fifo_length(struct vmsvga_state_s *s)
     }
     if (s->fifo_max > SVGA_FIFO_SIZE ||
         s->fifo_min >= SVGA_FIFO_SIZE ||
-        s->fifo_stop >= SVGA_FIFO_SIZE ||
-        s->fifo_next >= SVGA_FIFO_SIZE) {
+        s->fifo_stop < s->fifo_min ||
+        s->fifo_stop >= s->fifo_max ||
+        s->fifo_next < s->fifo_min ||
+        s->fifo_next >= s->fifo_max) {
         return 0;
     }
     if (s->fifo_max < s->fifo_min + 10 * KiB) {
@@ -598,7 +600,10 @@ static inline int vmsvga_fifo_length(struct vmsvga_state_s *s)
 
 static inline uint32_t vmsvga_fifo_read_raw(struct vmsvga_state_s *s)
 {
-    uint32_t cmd = s->fifo[s->fifo_stop >> 2];
+    uint32_t cmd;
+
+    assert(s->fifo_stop < SVGA_FIFO_SIZE);
+    cmd = s->fifo[s->fifo_stop >> 2];
 
     s->fifo_stop += 4;
     if (s->fifo_stop >= s->fifo_max) {
-- 
2.55.0


