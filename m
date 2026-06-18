Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEDECD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBvj-0000O0-Qa; Thu, 18 Jun 2026 08:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvi-0000MK-67
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvg-0001L2-J0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs23a981802
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tI76ZOFfGfMfuGkqeKd1jiLUAC2Yrw/29F+iU+dP5ko=; b=PnggpUEdT/aEV/Vh
 LKXP4az1x578rjbu+70vyn2GJGPNmrYHlslZWfzJrJSUCFZHpIX3m60QolzNdmJO
 NiHz4JhoYLo2BbaUOLUC2lC3LxqGVnPCd41DBwJFAwUOhE1Tq6LAjSZaACH8aWJD
 YauhPwl+edFEAPaEr11HTrMSgFY3A5pZRS1HT06hYduRjxRCb4IA96PE1A/NlkGw
 N7409cc51ENrzLzp86zUyvhygUZdsV0L7GA4MwOxDb8Rf2EcCyd3/0jCXYSGD5ub
 kh6K4rqOiPAHBfVBb2Cmy7/uTSYEK4hn+fIDBv1VuG6tYWTCihmPqhwqQ9s5+b3S
 K/q7Lw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn40p5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:07 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-963eeb6f2baso747866241.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785986; x=1782390786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tI76ZOFfGfMfuGkqeKd1jiLUAC2Yrw/29F+iU+dP5ko=;
 b=Ig2o/iqDwEZ7AU10i8CyNWXLvelAqXmfHS1dkxAqE2WLUNJguHDmPWpyk3pFyN0XJL
 UWU/pMWlzoh5NeAD/Cu0FdZM2uAKD0FhozLTsfDz+T86j9mJ4Qrl0dj4nB4shGuYlZe6
 uQwozOQJYvlCYe4hzUp2R8gyAROH7ldoKfk2BWgk/kKmpe04RmZobcSXYdTzDHGyoPeD
 wkrjYju2qvlGdYS8f9AbI4C/ORuYIIcEq8XSC9USeu6c/CSuy6VAb/JoY4zSKIMXQiQo
 xxeEfs/4cDYOaIT5tCXSjtGh41v+21T91waPrB8Ml+J52S0/hLsrz/WMUv+T2kV4usB1
 UCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785986; x=1782390786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tI76ZOFfGfMfuGkqeKd1jiLUAC2Yrw/29F+iU+dP5ko=;
 b=Aq+kEwYuEAjqXj1PcNjOORvaVupqTjrw4Y+RWYe2Olmhw/gby5GFYJNRgo9dWtIDWe
 vMZphMa377AIegMxFS3aogHVzDUdEJ3ATjdnJ+RCj75fx8HKKs7hH9207ySsAnO2I7uM
 A3hqq6cqhXZmgczAwQoOL5stqHynX/pjrp6JsAa514Lw65Rx6F2UOy3whslo/D8H5V9q
 Lonmi5dz5c+uwAvavKJzo+k8/iyjVUBFpl3MAvz/WIOjt5jDVjLHO//u6ZFt6X3KUXrZ
 kX/spgBhPBUlCyqGbuEx7CizE/2tVdd8gaYcgicGrsLizLqM2zUHGxvtiDzm3LRRBY65
 dgng==
X-Gm-Message-State: AOJu0Yy9TpzrLxuHceXvxInPBi6nv/aNWvVFARgQ3O0weyap8vNQab2G
 kn+oBpyPPOi1tY6P0PADPTrEBeS6X90OsuAMjruRfGDaDDhaveKaoXYUzEg57bu8r9gnTMS3k2+
 aUhtkFeR7FWs1DE6KRXIxjnFDHPKgcIUbcxiimr5GSuVXAiRiRpMFavOoNchcb2Y6rw==
X-Gm-Gg: AfdE7ckEQasxyOgP8vxa6c2didUjKgrWztfrZBkkLD+pohr/rwww1oGeH0OZY+kZzBw
 LnocBVmUmXgbr5gy3N2lXUOeljsQsPoAb5BCEwxjcdhlFkYSVMjRzl68aX+JJutiEq2Y94nYz3l
 JuA71IKRoAbBH4nCRwiqTpzzEedGf7UhbUBhrB7V0Ua0xeHV5JPLkqI28Dvy86Q/+VT2tqU7bXB
 Dl7RBjkRy02pipTxvN+f6WcVVAd52tjp8dXlGDJffPBxGyOOQvVr58TYXUvEpgpIR64W2qazENO
 4QZeZ95rqwg0tJy453yfcVVVaZTmmLXrpD0awllYJxflzfyxCjvl9xyCgw8osR5Xx736/yEMK7s
 IFPiGNFPx0I3Lrtf6Jt76qXQbESsq6yzx2ql8Ihn9RAOgOd8Mqqjlgk7kon2AEIOO31Vj
X-Received: by 2002:a05:6102:50a7:b0:728:89af:8edf with SMTP id
 ada2fe7eead31-72889af9af2mr1370635137.11.1781785985998; 
 Thu, 18 Jun 2026 05:33:05 -0700 (PDT)
X-Received: by 2002:a05:6102:50a7:b0:728:89af:8edf with SMTP id
 ada2fe7eead31-72889af9af2mr1370610137.11.1781785985624; 
 Thu, 18 Jun 2026 05:33:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619fb12edbsm26411723f8f.17.2026.06.18.05.33.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:33:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/48] system/memory: Remove unnecessary CONFIG_USER_ONLY guards
Date: Thu, 18 Jun 2026 14:28:15 +0200
Message-ID: <20260618122825.90331-39-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX8/iCoP0AyBhB
 CGNX2uJuS7uFMDs165VmtLMRnSsJ0gp7vJnq6AbDMoyCYl0TatOs7/8pmJX6NmKHpcJzX5RnqmL
 tCHnidDHt3ur4Oi+lkLz1E/+RRqQRgdSDbTJlbErr+JM+sE0JETpoMjKw9RAPe7TmQetk58q+nn
 JxV4dD2l0CiyEePKrHTuapn2jSvzKLJiZT65DR0/dvgAMlNFlSfu2c4Gh5GIPPCc7qIJdx55NzD
 egco5OAspwTUs4BwHK6mTIEIfHT6KqkVYDUxNrlM2XKpIGK4C3TCIbC2fMSL7/3K5DKtPPj9URI
 PexSDvwixAUbs9RW3eEjE6el1C35qJZEhE+KFSlnXXgJwqswb1BdclhNFbd68cf4WLSWuFs9DqW
 Yk4x5UYWi58eY1do3q5iv0Mg3noWcWusHskb/8GCRSipHimrVNg+/LfRsDXWpYYOFr3eL5WhIjN
 cR6uGQyHuucW/BS4NbQ==
X-Proofpoint-ORIG-GUID: MryfzSUJ4LHEUmQdcONZU-RoCgs1neqk
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a33e583 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: MryfzSUJ4LHEUmQdcONZU-RoCgs1neqk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXyIzH+5CA7+to
 Ufa7iQSAiLpIiYr22AKWtSNy7Wdyzcl6ZICqnaTg+veS1tw0+xRK7sO98q/eyo9+Tz/HPgSvUCs
 8MrMhYm9hhNfetUPNAZRu+Pp4DfPkmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

This header is only used when building system units,
checking for CONFIG_USER_ONLY is pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616153754.93545-2-philmd@oss.qualcomm.com>
---
 system/memory-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/system/memory-internal.h b/system/memory-internal.h
index 0066ffdffb6..c7573a68b5e 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -14,7 +14,6 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
-#ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
     return fv->dispatch;
@@ -57,4 +56,3 @@ static inline MemOp devend_memop(enum device_endian end)
 }
 
 #endif
-#endif
-- 
2.53.0


