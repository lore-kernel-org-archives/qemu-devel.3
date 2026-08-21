Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7855C5DF9A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 18:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxTp2-0000ho-JJ; Fri, 21 Aug 2026 14:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wxTow-0000g9-PQ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 14:18:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wxTot-00078b-Ml
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 14:18:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LIADpu3057682
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 18:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lnE0VzDrN3g
 NmwXFcCQttlz+l+u+DgiXcJorIGAaOis=; b=lJP7tVX65cbJk8IITQcNx4KF+m4
 mOv5b9IqIC3GU1hEhIECdNM3sNe3OYN/DnF/cofQxP+0nFxWc3/hKxzksecMGVig
 UEPZQni5wIu67kYwS8D2Yz9JuWUNIsH1th4kV7mpCasaljJyOPW8Jpw0Ka5zmeZs
 9KQoO9BmaIeHFq12nAH118abLCcQciSgIz5URVZtMbRBwljdYDEaniZYM+mMOwCl
 7cryuW1+eM1yczUQp/neLuA+UGLZ95fO5UL7sMiBPxTl3ocovHdw1dCZ135Ewx5A
 ddUsbGXZFgaCCR9g4/nzDq3aXS8a8nxDGklr+7gOvKBmNCP88mlEB5MqXug==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdnb1mp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 18:18:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d5d00fd19bso24803315ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787336301; x=1787941101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lnE0VzDrN3gNmwXFcCQttlz+l+u+DgiXcJorIGAaOis=;
 b=jXTBSr3upbsJ+SKQam+RusPf33fhcPYwUNTypPGRmdf7Ofd9tlb6S9O/zMHERIHlrf
 LYZf17tpEoH2j9mI/Mx+NLw3DaaLzBw+Hf8SZIYHDxx385Ct/I6G7y3uqA39x9vsZ54T
 dpQ0+MLDOCSH1glYXCM8odbzimD9KRHso3scvz8O3pUWznpw30MeZXWYWDubCCyhbhwz
 zJ267fdAeBwl4GAUh2EnzD5VXhVaSppLnNAas6qUD1+gE/CaCrwcg+U3bS9TebIBaXpq
 5hYZkn3LC8vsD/o+k+eqw4seieuu+ms9QdWEy1RvT8eK1AmUasXn/00Tdy04v8BBSmou
 VonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787336301; x=1787941101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lnE0VzDrN3gNmwXFcCQttlz+l+u+DgiXcJorIGAaOis=;
 b=UzTDzNzlWPQIiVKx1WQpeFagK8p4SeYPSknSlFJZRTe+sdgEhy6YAHa1JOeKj2KDv+
 4n/DCLUiqYg+eEnQ7+i0uWOQmssz29taCAxRo3PgVlB6rmc5chSS7w7TwyT/gX7zPBKf
 OkvE1qulDh8W1B/2PL5MtssV5GpJVqFxTxanj9ALmTaMRBYqHk8/cK+rPXoCz8jMMs6I
 K/8X+ouAlNj+eWi1ycPhtgLVpC9ApzbzVEUH1rWYfS4/OktXXWdAvyxAdIYuYuDSOhee
 diyf0kejV/bI08wZ7c1Kkl31+MRhSiH0HjBFKB7Jz57QsTJG2Nb6YubqvV+pj/gle/IS
 B+HA==
X-Gm-Message-State: AFuF++k0zt6Yowrvowf5jwIHs5WsRPuPuWQyMD/PFzJS7fLDZLZizRv0
 Kluk3/FfO5DcGnhV/e6WksHEU85DO7YSS12QjTf4AHkFhNdXL6QrKa+FjQK+QQceswHeHOmtbn+
 lHVbKCwWttnnknMcxJuCximFeLqBsiKaEMjP+2/oDRStMbPPAk1wwvBN2Kg==
X-Gm-Gg: AR+sD12fJuUv6WOxOuKKZYpv2/V7ze1T5+PW32hJpx7oFzeG9JmjGkSFsdHJr0StlPV
 cQYVxUDJ673CFZgaWOXLfQu/94Vr9IKuofrCqCfvAHvtmdCLOUUnlJ3t1nI49+wWTGG7N3mbAyY
 4EzwqS4F+J+65eNQlqNs6aifcO9OACkR/Lr/VxCBcCedYTHYe6jecvhjYwU1l78il7t2DxqhpzL
 gxkv/V9NTnEBh9xJvLuvaPQnFJh6yFP+FwLpfQgCYfsHw/6lwn7M/IAkhVpaCoWaTxXih5AiEAC
 2268kN7VLL2L7iSTIIVyv0zWp7kh6QUswAyL7ZGaXJzMz443eTx2Q/SizIdeTQ2piIVCJaqdRQy
 PugsiOpyUUvxL04S3s+oNUS7JHpu+Yt3Rof/Tx5lD8qV0YLhsk9y7PzKhl9JT+4M=
X-Received: by 2002:a17:90b:180d:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-395c3733e65mr14515941a91.12.1787336301431; 
 Fri, 21 Aug 2026 11:18:21 -0700 (PDT)
X-Received: by 2002:a17:90b:180d:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-395c3733e65mr14515864a91.12.1787336300994; 
 Fri, 21 Aug 2026 11:18:20 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1418600535csm48666c88.0.2026.08.21.11.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 11:18:20 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v2 4/5] target/hexagon: fix HVX predicate save size for
 histogram ops
Date: Fri, 21 Aug 2026 11:18:18 -0700
Message-Id: <20260821181818.401807-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260820215117.1788954-5-brian.cain@oss.qualcomm.com>
References: <20260820215117.1788954-5-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE0NSBTYWx0ZWRfXzzmFdEACMsuq
 wp8bg2IknD0tVQfXRybcCnKPCGMWWP121tII9s9kpYN4K2ZzSEy/8g3gf0tXCIi+ul8yxChOFdY
 u+wNVjm/5cmXaXPTmdLc0eVKrNy+5gRfSUpND6gRyynqLhesfEcKDMUz2arekkfBAQYxV/58Ws1
 Bfmm1V+hcXr5Dww2RH03bpvvCi38tJwxsfZ47PCJ4E8k6RXQhZLrjsJmONzefQaejxwY4zEPMTQ
 MGgEdlyUo2yZ+T4X9SMBq2BjCc0m41jeZAa6NXnTAvWSoR7tfmdZcX16B69atixSrHzSlnJm+I+
 fRcNjqwHdSFe+p67mS0HkDWIa2gYmMoH2mJPP3G2WJEFYAXFbZ/Q338pY9RhQ+A3+sRPZYdEryr
 ZmFHMJIXxRXQZdzswu+bKGP2lFexKWHYyIiHrcbGsIpy7vC/JvAmFSwmNuziGjRdNSfSnGDDrVJ
 6aVbgoULI8wOIXv8tjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE0NSBTYWx0ZWRfX9NYKQJEmr5W+
 pan+ZyOYL0Cqp8WTOqJLuvUjpcveGuJWieTOM2Ck0b2pEZ8F0V/5rJKQn6UCBhieEsQRXxCuKch
 RmyYqHDcs77D+z0sFmzAAYPLMUWw4HU=
X-Proofpoint-ORIG-GUID: Uy6Y_O9byLUOQCMODmZ9nFTRctuS2qZO
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=6a88966e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=xh_KQXLCpmTyd-OG1SYA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Uy6Y_O9byLUOQCMODmZ9nFTRctuS2qZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210145
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On Thu, 20 Aug 2026 14:51:16 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> The masked histogram instructions save the predicate operand to the qtmp
> temporary with a gvec move sized sizeof(MMVector). Both source and
> destination are MMQReg, which is eight times smaller, so the move read
> 112 bytes past the predicate register and wrote them over the fields
> following qtmp in CPUHexagonState, that is vstore[0]. Use the size of
> the registers actually being copied.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hvx.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

