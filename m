Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB7CCC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGi2x-00089r-CP; Tue, 13 Oct 2026 15:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGi2t-00089X-6f
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:20:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGi2r-0007S2-Fr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:20:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHRCLq3017705
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 19:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=oMPQHWYTmyey5QxFa04gGr
 91vLMAV6pTtwXD9jxv1KY=; b=B6pQ+elcJjqUS0UzdA53ughzWs97LDsq2+AvKX
 r/9f9RwMDg5eW8FKaCdaQ6HVNxfNxxvEvRnLQYKf3PFPqYWhPk6bMl9MGpi0o+ri
 8tQN+CFZ0ImpZpH9DjcN4bnyyTKX6NOYDgfs9gPO1Yd/M92orjL5H3XdsGt2yxCd
 TjbZGw2xJcElQxlQcfdsqh5GT6ynJO1ufmMxPVO3YCLlIkgx82pm1JURpVcXaLPn
 4HQ8+dGkgOKPDYAAR0tjtfDij2HqZwYbhRLQtroHcn4u3ZaGK56WzknYuDjfTJhr
 Cl3h3Bd3yCCZ7/fYXztl77Q3Fgida3Z8+22PJ385E/CV4mLw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b0k2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 19:20:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso5629212eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791919214; x=1792524014; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oMPQHWYTmyey5QxFa04gGr91vLMAV6pTtwXD9jxv1KY=;
 b=RO0r2M7svIgFmagvoFC4z8B6hSbS6QmtyzA18PGSJkA4TXoYtn8EJgdtiyGK20qkAB
 VW9gy1hop3NnLTBUvzla6kzQo/zhOc3C/AogjHLtQSoqIQ+D5s7HxU0yQcnx1x+BeiGn
 f9IdOVu0JVvS0LcY5f4oCkgMNlbjnKtMp+J3ovYLHlFimIQSFjgXM89KDRK3k6QUbjLl
 qTnQS/VXN2hKZGjOAfDTVA8ON8QqyxkUZcoWtxUXbw/1q/30g4ttKftD18DdIu/RYgwS
 GuJu+EZDNnp6HS76ZDCJ40tpLQsEjWPHjYweb1MYM+SB3kiDQhuvYA4+EmQsVm7zGQeM
 jxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791919214; x=1792524014;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oMPQHWYTmyey5QxFa04gGr91vLMAV6pTtwXD9jxv1KY=;
 b=RRYg4Mm8Hd+wsNtMN1YCJK4GdHbClneCkyuINjVVg0D5QjboSePQBaprBh17wi9Jc9
 TjDrhbQHGmK4QPFKJq6g+Wlzf1f4OwEl/Jn1kbzdbkJKhz6O1iGdLfWcDjPovusSDRph
 MaNzzOsu9L96CG7uhMhrE/w2kkfn5WBr9wiQsnR4hRW9w7/cUJ6OPFTU6QHkA3QYQRwe
 ezM7oARTSfn4hPy5MjvjlKldIj3pmYyQ0jl+iL/xfrJvWMgdu8uiys/vpVAecmwoC+eF
 4H0zSFnvkCFO1aQ1u4krr3VrrGcUz2gLJjzK3UGPDaiumoeW2dR75+btDIvYxL5Fwjwk
 ZooQ==
X-Gm-Message-State: AFq9FYIWJXC+NEMVwRGRXPSLFEXBleazkzFieFMAuFd4Mh15aytNLwy5
 NvnSi0mzU46grv/SseDsMUsrTGKgLQ6WVodo4NMXD95B6arEmbOwOYEyiN0gD0pNXUGVxgS49aq
 TtoZaFRS9LR1HBQZoR5VYRBHWpSSMp4v+JKQYae23DoZkvMBRLdOb05RUrSrztSxCuA==
X-Gm-Gg: AYBFou1qYZCW+Q4UQPl+B19YOxEvSxN+GkfDInSPE/nRvX2eQ146XpFbg3EZ6gH9q09
 c3xKhM2UzlSuQjibp2TGHdDuK2A74e8d1UlbBaCPbM/r7WYLhKO5taFLIS7G8JsyiFO8Z0TP21B
 LwBMqUvuiIMmOmqJ4ESsIMidvP0ggc4JVtuy3QQpfIHeUvbuo/M+kmkfKl48ligHJ8WhG3fkFDB
 cxyHEwKhPvuspoJ5y1qwkgQpi+ALQ0rnbHpfyhhcCooMgRF/0KCmWmxMIyA5V1J0cLpHbKQSl66
 fgvtUZJAzVBEBGIkl+RoFvJJXL+nLHqxyCkIFB/dAXeInwiPix5NvJnl66+JSvW6/cb7j0BJ0I7
 48jhKuUq2bOTlQ7DURofttzsKzNMfL3ciYsZSnX/CpztqdS67krw6BbJjMjXM
X-Received: by 2002:a05:7300:f58b:b0:351:2a16:84b6 with SMTP id
 5a478bee46e88-3537dfff2fbmr16868718eec.30.1791919214172; 
 Tue, 13 Oct 2026 12:20:14 -0700 (PDT)
X-Received: by 2002:a05:7300:f58b:b0:351:2a16:84b6 with SMTP id
 5a478bee46e88-3537dfff2fbmr16868681eec.30.1791919213392; 
 Tue, 13 Oct 2026 12:20:13 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b690af3easm16100075eec.1.2026.10.13.12.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 12:20:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] tcg tests 20261013
Date: Tue, 13 Oct 2026 19:19:47 +0000
Message-ID: <20261013191948.3546-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6ace846e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WChDSCk1uXydYMBaiEkA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 8yf-Z4RkvQYlrYoDjROjZOntvL4wCX80
X-Proofpoint-ORIG-GUID: 8yf-Z4RkvQYlrYoDjROjZOntvL4wCX80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NyBTYWx0ZWRfXy34NmbyoFMMK
 3ZVxMy09ukio0+8MvEn0icMokgdaYyNlGTL2t8EtN3WZLaJoYwM7FGxPFPVUyo6UdUk0xF5JWIr
 NPkmL+rimp6/MSPrZR+UfhsVpJzS2R2p7wQQAODHWJFNsw3wciuHyvMuRQ2uPEXFIY+k5jZWXpo
 vMHigvn9ztcW2c+nEaPIsczXhYyzBC2Q826MhCtbOudUmGBlHYh9LtahTNONX9hFqDttbmG06uJ
 EPfKIDnAMQPpml5ldmQIj4N+44rCO7CpD1aUanGuvMKh/CPuRRztNOHAtpGbY8fFzgvp4YSt6UH
 1CVG95t4u+ytwxW//VB/PX9ED9FJYKEpV0k6HU+J42p2t4u0cZTLqWNkCiEW68BM+zHrOIb0PRZ
 wP8F+nT39WDse4T1mp/S4hZdUshZ1g3fkR3a4Ew88VBkvSBFrscrJbxYiJ5V0MEH6Bp/MYieDtx
 EY52kXRsunkYL5paoaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NyBTYWx0ZWRfX2IMm4eA0jCs9
 sOJHTcvNH3bVHGN/5NrzZpcr+7Hx0LYo29tnzwnyKQ5VsHGmJeVRxVusIVFHVSM5cQxylXP3Du/
 9QwrqYvoi+VOybzXXK7gNa9n+y/iO54=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130077
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20261013

for you to fetch changes up to 850c46a5fb2187edd741b3b1ae18e6a8ef7571df:

  tests/tcg/riscv64: remove forgotten Makefile.softmmu-target (2026-10-13 19:19:24 +0000)

----------------------------------------------------------------
Changes:
- [PATCH] tests/tcg/riscv64: remove forgotten Makefile.softmmu-target (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261010225351.79098-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (1):
      tests/tcg/riscv64: remove forgotten Makefile.softmmu-target

 tests/tcg/riscv64/Makefile.softmmu-target | 89 -------------------------------
 1 file changed, 89 deletions(-)
 delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target

