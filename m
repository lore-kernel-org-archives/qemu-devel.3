Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308F7C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDhh-0001Jx-J5; Tue, 21 Jul 2026 12:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmDhf-0001JR-8v
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:52:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmDhd-0004vB-JO
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:52:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDg5931842081
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 16:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=IbhAAHwn0oIaqwQg3yEIm7S1nK5phjpy1Mk
 SirnYmJ0=; b=LvPdylJOggu6n5N8DOlzehqFKK5t2xaw/ipYrcKIFjMz4RB5+hB
 Gz05qZXpb1CeK2YrKgiXLcDY5kRqGRwdRzc6Jz443eIOC/4WggwwLpQ7YLYL6vYz
 GwwqDuo4snfqiZpgnEM6I/4kCwehFz4Y9BRiKqGGJKrN7JeAgWGMHfQxCvCwjEdD
 T825x56rk2Iem7JogQP/138dONcqXPQ5SPEnBqlA3wYXrsdYEEwEA1HcgoTg4NEU
 8Germ0jgL05kdu3WZ+u9b8k+bQersb87VElRy2J0i97g3gGLvjMz3Tyo0Y3nfRpn
 8/cotMFgkpFzFplNg+YH/vInsN8CKs8L1Vw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se3fjg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 16:52:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so217903915ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784652739; x=1785257539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IbhAAHwn0oIaqwQg3yEIm7S1nK5phjpy1MkSirnYmJ0=;
 b=VEiV7YdE/sKfWEHytDpFZBQ+eCs3Rjcb/BBO+iUge4Nr+tn+Xgz0mTZgivkNN9ZwMY
 nAJLRdBUuzpRrhddztUOlWNEWuqGvrS8h2CgdyE42TG3pKHewu9RlQqKEN01802KHX0K
 +ZnVob57L+SBcUVN+e8jKtWh1iV8lD8mfiADht7Vd2VTvXjvPFnsExlEWe7ZwIJnaSLl
 79/2LN+SNAkQiTZCgayvN4l9fRAxxtsfiNCzqvHqOSa0bXiFYyZM3oE2jltGfXWSIDXs
 S/wbP4U1HpNLKOp6qytjdMh57YsKh1I1QIR92jHJLnaMfUNnMw7SQrH9A+mVOby+q8Bw
 IqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784652739; x=1785257539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IbhAAHwn0oIaqwQg3yEIm7S1nK5phjpy1MkSirnYmJ0=;
 b=XE3CLfUMZy/3lFLBJUd1StCYYgrqO6k9x5rIZIiFzpIZdmE6EC+dmxVc2JG/Q5i/Xu
 YG+02pp4N/hRYfHg5YeKqbw5g8ZwDWxsk0dnOjFEvdZ9942eo9kJjbX6Lc/4m+U48NJz
 ohRT1bwdDOp+ej7UxovrD1oKKWAIhRAatFsdSua0JBzZgxfQ/Q998kgJIYXxfhrZTkl2
 szTl3LBBWOQInNDo/T5/mZjpfmxAIyItrtypQx+lM3NlmnK8dpN82PDGSeYK1DKpSasw
 SrKqugKEihYlLmpDorRu1X7PxZwdZwpfVU4GT924/6JtUr2cniiQxIU2yfF0PVRvSzhO
 q7zg==
X-Gm-Message-State: AOJu0YwYqQ4G7llDop00PSXpHukgTY2KJVF1M90iPULYw8DldCwjViih
 c1kSnawHlm/PXoqbGIhx0ZcD+NI7hZXe6MLW+iA/Zgu/qgtpJ8Xea/zxsNLxbelBhk+h+quujFA
 daVnsjvKXzL31kU9WmWPTHiuuGKYiksQV16gp3i/Ra0HH/ojmV8SuBBPgTffCFnVcIg==
X-Gm-Gg: AR+sD13RFGgOCau+TGcDbySpwJWwRMK4eCxPNaCr2KBQ6gA5+aaPT1ppNXf+JvT/M7u
 8PJ5F+XS7526wHznvh4LQ//gjTg7CnBSwDtfpTkpdMrcxj4bThWdzP8ZXj31MULrfSH9sQTZcxu
 pdhNSd4df6VMYcak2AETJYOI3RrUoJyqZZFfQWVFOWH0oNsFmHLeURPgygrD40aiXi4pzkTD9SA
 4v0vsI8SNUvqj38hR41r9DXzzSwsR4eUc2DdVniNzBoittL0d2I7o7s/pNcrseh2P561HNOefsX
 PWEDqvc1bQtOHgNdx0IGdUYxk5sVJ7D3rdmOUjc1pw9dInPZER4BHez7M3/RQUQDFAZ9jt9yDEJ
 t3QQ7sNW+owp/1PIob9EL3/GOVI8P2HzC+xIRbvqvLbreQK/9WLVcVjz0MCCdADVqjJ43TxA=
X-Received: by 2002:a17:902:e88d:b0:2b7:975c:dacc with SMTP id
 d9443c01a7336-2cf34822becmr207507635ad.1.1784652738979; 
 Tue, 21 Jul 2026 09:52:18 -0700 (PDT)
X-Received: by 2002:a17:902:e88d:b0:2b7:975c:dacc with SMTP id
 d9443c01a7336-2cf34822becmr207507345ad.1.1784652738539; 
 Tue, 21 Jul 2026 09:52:18 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc1a6adsm644018eec.6.2026.07.21.09.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 09:52:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] docs: fix sphinx build failure
Date: Tue, 21 Jul 2026 16:52:10 +0000
Message-ID: <20260721165211.36903-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rb0J-mYB-4C8luAsA-gbWDkC81-1-w3k
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5fa3c4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=POKITLTWGxUB98k2zHMA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE3OCBTYWx0ZWRfX5ZqY/++EkMwz
 5JrY19bpu0pSsxgeNF7xwEcLjALPkOK7l1fnZksOx92He/YyBG/SCtfHkQcvItX868vk/HW4jp3
 gg1oSOiX/Qa2tbVkkwtB90nL1cWpazM=
X-Proofpoint-GUID: rb0J-mYB-4C8luAsA-gbWDkC81-1-w3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE3OCBTYWx0ZWRfXyTt8yEdOwnkk
 Pwz7v+nfGa7KQ6bEIFaZ7Dl4PD/jyhhr9bLIvQwvBhS+xMrfgSoTUk7D08/p1eG+xF2+sBoZWT3
 707prqyN55tfyTz7tc1guPJqOT6zyHG/1+YtDbQYtEzcDN7OYZrDqWL3GlrNToDCTtewsClrxCz
 nAdeuY8L8H3O9M1DespEMmZ0CaGH6OOkwwfo864RgUOroPtvnlnyt1BLtsgoZN6U/b/qiJTG+gv
 zXZ56rQKobKtIcpVNL5bUP1aS4coLtQ0nx6AiGFJhPMgq8OJjE+8g5fdTNalfKufZWBjlhfwHOI
 bd1Nbfhb+Tv+TmxEvmJGhpuAnozIGqR7v2W7WeSNUhkLM44y0yCq7BmTdwrOZG/nnRAiqwOt+2L
 a9VIDkLbyR8h7fuIwBr0+omSZz1Me5UKQ1nTMh9Z4DHLrf2iVjMTR//fZ1+zwtwZdYbajBpshdM
 29FLvw8oUES33xisCAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210178
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

The following changes since commit ad14439be5731e872d8448a04664a9c0e66624a8:

  gitlab: remove gdb from MacOS jobs (2026-07-21 10:09:47 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/docs-20260721

for you to fetch changes up to c3662589c4986fb7fcdda5ba6c71558e73ba759a:

  docs: fix sphinx build failure (2026-07-21 16:50:55 +0000)

----------------------------------------------------------------
Changes:
- [PATCH] docs: fix sphinx build failure (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260720222717.33078-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (1):
      docs: fix sphinx build failure

 docs/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

