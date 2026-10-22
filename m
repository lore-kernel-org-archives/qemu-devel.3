Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99639606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=amUutwLm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ax2JHsTu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nR-0001mL-7l; Thu, 22 Oct 2026 17:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nM-0001kI-1o
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nK-0000Fs-7r
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIH1m61509607
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iEX1My4bxuw6/vX8ei26ACBJhdMBPGHwQDnF9vQDaVs=; b=amUutwLmyXrTWCYf
 w/eOOQijhcXfnq4BxG3uQVexjSobY/tHlraet1pJobRyAky9ZHxTufepK+/uBLPT
 a63FAPGBJUmvKhT4cCWj5dsCugYSMhaaMkOLl2dnpOkr6WkZWsNUKzNde5Hf/DLu
 9JkB50PWw6kDDDx1e9d/feglwwGOWWuI7g8ObFelxxBZf7keNt0rVlXDRuDmpI1g
 aTWsknD02iNUjdOAvdZ6SKUQHvD/yz/b1hS5TF2r/oV50BCOV6Cgpt2HcuvIWYae
 /7T7SbxLmpn3w4VX8nbsxYX2DMhHoEtJRPxjbokqRQ5miuRqv4REEoroCBXNNoUf
 Db+gaQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp8r40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3abb4c24125so175700a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706272; x=1793311072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iEX1My4bxuw6/vX8ei26ACBJhdMBPGHwQDnF9vQDaVs=;
 b=Ax2JHsTu2DGbkbmywkjt2MyvVhGJV4ZV18+nTvvAlgJToI1LzdttIau24mOlqGVp9C
 om6+q8rQzN7Ma00e25vpO+3lVJ5T+Bwa5tDih5v3M7EsaXpNcRnVGZwKHHmAfkXkaS3G
 /VXumDL+56gwKiSMRXTQbFslS+j7oZw5t8FqgFHTENH+HUH7xeEoYwUdZSuipYNTl/mq
 SOgg/hxyiqJbIpOSjdlI8yUVOOGcLE7K50Gr+V6E7avezfWcyHjadSer7wgZcHUFvN54
 l7PE1jnLGYXKL60coyvHAWwiusrjga3oWborMDaX9WsKxwvojQyO/7Ci7qy4npjhBD86
 fvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706272; x=1793311072;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iEX1My4bxuw6/vX8ei26ACBJhdMBPGHwQDnF9vQDaVs=;
 b=QJnSbK1wXTTRpJhlQjZnV1bw+cazz9zHuj3Nk6Q8ILXIS5uxwaNT0R6LE9laiZAXgi
 mAoYEhp2bxH+5XfqdshzCC7J67NIoiJGKEbEIlgKA8bg67zo9xEGBqtheFQ6lnu0c3Gt
 wLZXpMa+Bsm7dRTshDWoXULBeG//lqkcrlphnq0ui0a1IxvpOLkQsNfRgzuK6RNSleYw
 D3pDS8pQ/GQCQKywD5la6TBSR3/nZnMQMNGjuB29mnOrjMuEQT8VTGgwj+p6qTpH6z+q
 YYcmvq59y8l55pJCOdaRXx94iudxDb6Fs7AVYlyiSeJPqHPEuTGT0GPn7su5JIUxfmm5
 o/Og==
X-Gm-Message-State: AFq9FYJhECFnO6OkD0p26KzjGrLoQcU6mygFtnzcBHsdiI8wR/GIyG6E
 iZLg5oSphjS7s3L5QmOfIyWSdF8Rgqaq07/jyI/zwldkF6/hQQV5YX/tjUVVueaIZQufUfvNDFm
 0vryvzSPX4BUhwxK79YkFqAQ4zFX5/eQ32u5CcX9NMyL416jFx4deIuWqlr9DSEMfFA==
X-Gm-Gg: AYBFou0kccnKyTpl4lBi8xc7XXmfKFuuEFohspv9o6Ds9Ob49B15bWTnwj1FEhD69s5
 /O40QfRVtW+XqUvg0FemG3hjBdeacNewfPVtCBE7z/AvLimQdbnv/+O/NlOmB9/G4nZnFc9CrEB
 3IU/dSX8YFLVgf+zm3USPmIGAH//bvN3XOAKInJZRRbXxI0Veu1FAmTNbD+5ridaAaYzcoCwNnE
 7LDo0MXS9J3AEWMrn43ZEM2gFv1aEWagZjMW4cwrFcQZa4gbNwso14mmJ6c5fXd4e9yqsMmwOml
 zPc2UzQ92hxM+7ljZ/zC+Eaazymmy+fBL7GE/B5wLz8pud/7/c2xRdY4GmRo+1R4O0FmsXDRDqK
 0qqYM2xVwx712EmyqtxTCVsdsv2ls/Y6zXMYnlmsksjAvhKLBCEwhsGq88Ru53YU=
X-Received: by 2002:a17:90b:1e46:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-3adce0ccf4amr158230a91.9.1792706272153; 
 Thu, 22 Oct 2026 14:57:52 -0700 (PDT)
X-Received: by 2002:a17:90b:1e46:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-3adce0ccf4amr158220a91.9.1792706271623; 
 Thu, 22 Oct 2026 14:57:51 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 04/27] include/qemu/typedefs: add GuestPhysBlockList
Date: Thu, 22 Oct 2026 14:57:23 -0700
Message-ID: <20261022215747.2479440-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXzvD/QLpJCMTy
 R+IgOtLLRyrTYVBPoivZwV1TaULq/C+ZMeeBPdPWNy53j1RxAowgNzrTd+tw+Jv/4oUWExUxy+g
 psWODRsHLe1AAqeXANPO/HatF4gSOuw=
X-Proofpoint-GUID: 0aqu3M4YlJc30hen7yVGGpPbr6Ea1xDz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX1uhRFqW67F0R
 MmGjS772e8Ko/t+sn8QfmNTfEzJNZTERaplynAcTLMy8Gyp9TJFGV49xCoF8Cz5xSmT8DsmtcM/
 O+oUXA1vTZCC/6jf0w+JQ1y0wcC9/swWurXsQS/WuBe5JNqQjpSNNWGtIEDw+eWHyqx66HxqTK0
 rnkPArOB97ivR7P1G1G1JF5bYvrs94nYTniTKRjItgojlx0knS4hCGBQJNVqdjguukefqiM/Rv0
 gdVjXK6AZS8F7gxiOaaF3eEjqIZpUhTtw3WyTfKFZhMPrsXkVrSJ2VwKNLaqh96UTZG0ArGIbmE
 5Q45KgbNEO9vLezF4fCLdCW9Nw5uL5x3M1WHfc4uy4zChFzvAMte27TYrQGeywllM4+jFp9JaMs
 L/sBOY4OcpLge3sYchJlunE+b1p6YxF4r42t7I7BEvhJ0KxMBU8OoNhGTgQ28verUXxjcSTlTca
 e1lJAG12I3CBjuQWR/w==
X-Proofpoint-ORIG-GUID: 0aqu3M4YlJc30hen7yVGGpPbr6Ea1xDz
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6ada86e0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=De2SjmbKK7625g2b_egA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This allows to use a forward declaration instead of including
system/memory_mapping.h.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-5-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/typedefs.h         | 1 +
 include/system/memory_mapping.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 8fa7f752dac..488d2556670 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -53,6 +53,7 @@ typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
 typedef struct FlatView FlatView;
 typedef struct FWCfgState FWCfgState;
+typedef struct GuestPhysBlockList GuestPhysBlockList;
 typedef struct HostMemoryBackend HostMemoryBackend;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
diff --git a/include/system/memory_mapping.h b/include/system/memory_mapping.h
index 4c770bf0b83..3bdf9badb5c 100644
--- a/include/system/memory_mapping.h
+++ b/include/system/memory_mapping.h
@@ -36,10 +36,10 @@ typedef struct GuestPhysBlock {
 } GuestPhysBlock;
 
 /* point-in-time snapshot of guest-visible physical mappings */
-typedef struct GuestPhysBlockList {
+struct GuestPhysBlockList {
     unsigned num;
     QTAILQ_HEAD(, GuestPhysBlock) head;
-} GuestPhysBlockList;
+};
 
 /* The physical and virtual address in the memory mapping are contiguous. */
 typedef struct MemoryMapping {
-- 
2.47.3


