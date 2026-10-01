Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143E3CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxk-00084H-VF; Thu, 01 Oct 2026 13:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxh-00082q-3X
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxf-0001pi-Dd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsfiR3512258
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zsfr6Y2ElMPfKd2qlKJpI7SXl7Iyzpdam4HT9g91Y/Y=; b=aYb+33AEeWY9ztUS
 lOMZL0BsFXEc1mRdjEBNEjlqR3djZ6wLGbEtQyIN7vPFThXVm7+tctfbS8PU76Ag
 zX9CaOpFNSZtc+LEPLI6/bwxBVlGWrfgIeUcrMonZZUwKoLrUx3q5G9W0g2b4D3R
 jlQ6ulaU4D+dkCaYKucZZOTZjbDfDu2kCn9PPWQFrsDorD5rU1VNcsMHxFKVfS1l
 UE+hBWw/7ja3ecGNbF2VJ5srHpXHieCpA8yiWzG6EeevVJgLiBXluGTePZ29soaf
 38z1mb0DlcJZ/3I2R4pvQzQJK1XmikhCOd7VV0+f1Qk54R5+VRHAoH1gPXrObKGS
 PPq1mQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1quk9e1t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:40 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-144d4ba280aso688140c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877159; x=1791481959; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zsfr6Y2ElMPfKd2qlKJpI7SXl7Iyzpdam4HT9g91Y/Y=;
 b=A9+MBmOmCtUOkiVTtuOiLYjVZqLEtjGEJTh7KSBQToBNm/tspeKnJv2fp0ifsXe76G
 s9cK24WGHb+RV5QIZKh/lAtHu6Knga14opDJHT6Y5Jn5puknhaG5h9iEAY9KQNDxurTH
 f/4uXzFyBiYZzOxZbN2h/84a+AS3gcpqXGpaYhdHu3T7su5Xw5z2ZtzO5aZBcDrvZo1v
 mtnoTfuRueIF31N78T5f0mdVZqdGVLWpaQDHcSXwHS1vT7OPp3l7YVDVVjB6luJBELAy
 SiUsHXsfIk1pxTE3dEeyqPHn0uS+2DcNMg0ETZxmyivyqHZfWpmSqajnktZ04SPTIZPC
 /CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877159; x=1791481959;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zsfr6Y2ElMPfKd2qlKJpI7SXl7Iyzpdam4HT9g91Y/Y=;
 b=2VU+qI3qATzGrLBh4wR3fmIcE2ZKCYvDcRywBpg5kDx0F2hY5FH8O3Ld2juUvjioGW
 pXiv0WuLibnvS8NIjsA+krB52KLZWqeDtK9pMLw/nEJEIJEKpEgC8y1TA8enK2bbYceH
 HvGXZC9+fW/iBGv7DQ2BOaigjamkJvW7ycSlnTAmSMRSix0z6pfJ8iB+/07+BadvpV4U
 Vkqwg6ctg3EQFJnNbVZUA2Oh3agk6SQjSV0jo3wUAUuD74dIpruZ+Mc6zEslBhPVCivf
 66AfWi3BxQsqm+qTnjuR7+//ixAN+YkaFIvCb/rxgUw7hEnftHnCEuXWiCzZiRTidPc2
 ca4w==
X-Gm-Message-State: AFuF++kC+MSj+/AzgMW+qGyosaZaryh4RowoUmhTwIESPpResSQLYvjZ
 2BAhhOOF+xLWjA6a8p/CX6e1Ne8audB6rEgRal8rysO6aUqXal0075a7QnXIKP5XAgxDnsw7VbW
 O7L5U6qhKT4UcNcNSWJfA1ZfPXDJVomo3Sgt0xdn31xyXcTukdzJhKw04mGgAml437w==
X-Gm-Gg: AYBFou3aaehDCLb4ngkL2BQoX9ma6/Mh6WOCa2rxlXkY+xyRYJtEk6Ifelpsrnnn1YE
 /WDD1GtGtX2CsOHvSNKyTPSpWBfmr3VtzmmLkkXi9ty5L2ryNE8dUshDQ0n5s/410ya1WnU3Cuv
 BZABE/ki4m/J8tI3R1bJXyH2kL/JE1LxaQbvAwckFMy9/91QOCgNfo8nF6HmNXkMPOAI5kPoGgQ
 uvjibw3Md04dMV2Hnx1oR4YegzMahLbBFsWKd5Z6RLxW8YZfunq5P2TuPVfSht1IZAKVzcrNBpA
 j2oMiPe49ep5lMHTUOCzIsEJkBy3yu2c9xvyXk40tVfyIQRTHfx0Dnjkf1KcHA06j5ly3D/RbpN
 aKmDh/MIdbRBtgoDF2BeVj1h23yYEx5d5ojnq9SMRlvm/qo/NLHu19DG0Q1PA
X-Received: by 2002:a05:701b:2605:b0:14e:5e6b:e6e2 with SMTP id
 a92af1059eb24-14e5e6bee29mr2470963c88.18.1790877159239; 
 Thu, 01 Oct 2026 10:52:39 -0700 (PDT)
X-Received: by 2002:a05:701b:2605:b0:14e:5e6b:e6e2 with SMTP id
 a92af1059eb24-14e5e6bee29mr2470926c88.18.1790877158584; 
 Thu, 01 Oct 2026 10:52:38 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 17/27] target/mips: Sign-extend the SRAV operand
Date: Thu,  1 Oct 2026 17:51:53 +0000
Message-ID: <20261001175203.8673-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXzslb/fMIDk7j
 vgf7rbNd6oIE7J2Rl4KmsITNoV2hjCXzs5E21LpwgdhHk2PwioeF/PAfwlH38itqUGDmJBnXe0F
 JryP31KoufYVQ44LsBNBuYDIc2r434E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX1Z0KFMk/I3ir
 r7368yN74rxvBYEAPhdxgNf/X3RwEkmBxdxJXERddUgUvE8uaQ5pWWyJ5nczdmObGb4HFU0M7WI
 jQIw+/FjPgOopqJjdAKLu3IjF3Q0EjZGs740qxAabR8D9WAFeE6tT6X8YherTWAPv8uU/d+ws0B
 e6y9KQslKFf69i6jpNPfMQfVOmixJmbE14AMO4bhAzWfdky+NYXSClhczKauUTRxT+e6Zk8eJh6
 6jTKrRhOIy7sA89bM2Nt7Gu7m2oC7dPJeRKCuVKAbRMYuQP70fHGUhTGM7kQhcI0wl79QY1LodT
 fakfUQ95Nfvo4OV/3NyEO7Z4k2t/PfikG5iSGxA7WF2KUZp/qHCV6nxVpbUWsQ40OOZocQX/jO1
 XwBU8P0nvk4IE33WsKoAbvRVgV+XK3+JgXvL6EclCcJDth3tKGm4PsEBdKelgnV9pfaqE0sdQ7v
 KpRQqL6PExzcLh4QFDQ==
X-Proofpoint-GUID: zUu1QgIPHmoszC_6-s6MWC7-PUyxu55f
X-Authority-Analysis: v=2.4 cv=TdADJhQh c=1 sm=1 tr=0 ts=6abe9de8 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=W5-BjZYuLqWngTJxaqwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: zUu1QgIPHmoszC_6-s6MWC7-PUyxu55f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

SRAV operates on the low-order 32-bit word of its source and
sign-extends the shifted result. Sign-extend the source before
shifting to make results deterministic when the source register
is not already sign-extended.

Fixes: 48d38ca52b6 ("Switch most MIPS logical and arithmetic  instructions to TCG")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-18-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index e3467d15251..936f8c4eddc 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2853,6 +2853,7 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
         tcg_gen_ext32s_tl(cpu_gpr[rd], t0);
         break;
     case OPC_SRAV:
+        tcg_gen_ext32s_tl(t1, t1);
         tcg_gen_andi_tl(t0, t0, 0x1f);
         tcg_gen_sar_tl(cpu_gpr[rd], t1, t0);
         break;
-- 
2.43.0


