Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E595C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZUm-0001qi-Oj; Wed, 22 Jul 2026 12:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZUj-0001qY-9o
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:08:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZUf-0001pv-UT
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:08:28 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFXoCT1441278
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6SjjFzmcbWzpABPeDFl0K/
 hAKm6z7dd4m+Zi5ZSFihg=; b=DEfglYL5dmPR/5IaFsLEykQxorPjvJQru/YYMI
 Y6kolgao5RkwbC/P0RAPaxEBj+QWpV72AJ+bxdLA/os+7naCsNYmGMWQ+EiEQa14
 yNu0MtJy7B8CX4y9bneLKjMTbMH08vxXqyMcgK8YDxNXhxmS1IyaVkM6K5aL57My
 pni4PdfNpZpOYLXdrWM/zZXvadugaPjeQGYRkhkCe24vZnHl2Q7oXz3z48GC7/51
 RlADKnaensTtE9SjF1ZKVS82SQLwC1aadZMfEsVwW5K/JPWRHcRBORbp6+Ks3qCO
 W3DudGG1a3unHn3QlVMP5cxtr5z7mt/7Z6ctZDHMOU/+Gbeg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt2cgx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:08:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c19493ac2so35933351cf.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784736496; x=1785341296; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6SjjFzmcbWzpABPeDFl0K/hAKm6z7dd4m+Zi5ZSFihg=;
 b=MXzgD/H0spI+NaJM0jDKx+zfmiZR0hSF7kQHQuJxZWNF377gbaUFuxAafg+fqKFz/l
 HeC/F2IN5ir4ZhRgvflypgoHnrF3ROt2LWF/JUyRcXUQQ/EYqGPYMdJhZC+hdqOPi+Fu
 gdxoMP7VsEhWi1/HsNIMfDXacqC8p1yqNu9bt8sujgO8K2r1DCr5ex6RPqUDw52z2dey
 I+tIyJ6FBuv6+8mwRLFhlLldQEgV4G3B0cjP6AuhQAOhbMfyu3eiZ/gnOVCMNYl10+Ip
 CrMNyl/5/dyWbJwkOa619OuOeagIVahupjfhWEPLPjNd/w0OTnOA7xdQvWXa8VEv9HF7
 /33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736496; x=1785341296;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6SjjFzmcbWzpABPeDFl0K/hAKm6z7dd4m+Zi5ZSFihg=;
 b=JJF14G6ZQ51WWy1OE4omFBzLEbbCEcb77bOg6JGfq9KgWmTZWk63VK7q8Wn/Tevowe
 fy7sQd9F1d6d3kvb4CH2JjQWbFutTOzh7dAzaIzGTFlBN+Q0nWnDJIlHcW270v/cv126
 +yRCX6605PxIXLmVSA8slsYm4UERYz3+XJBCJi8FY1TY2+y334CvZea2Ocya3OsTc2XI
 2ykZIyOdQmfeRO7Rw9+0RwoB5m73CBtY9Sg86D3my+4DOxpkz2NqoLX4Sk3i14NLTPqd
 W1ohxXxVabfL7u9RLSxF5ScvkLBhBNqC9dwGH6XRAL5gQ1d03gWXUR2UVPA1hPQfJd3t
 9l0w==
X-Gm-Message-State: AOJu0YyLgtSUX+/Rsvtaqs2rrD44poBbodUTm00hLOQL/AyQBufxXtr9
 pVXIghqhwnUj9IRP/ewe0gQeZyG6+QiQtVCTaEHTWqtiGQyyUwtG0jncoc8fi+ECAgUDWqBkKQA
 XJ8su0K1n4sOwX3Bj44wFpLCskBO0xQ4RvFTmDhwZmMh8MlCsNW/PrOtBltY/KDkinA==
X-Gm-Gg: AR+sD10wspktWN97ONXXSTrH1CHoDQLn7DtkZbNcYEm+CPefsf65LmcLkrMqJKbVO4t
 6PJ+dmSmWbQQL4YvOU9DdDeXgczO/cJP56vTkJrSKpQuqL4jXl3bN2QrQ9bcHfahVl4D7khsPI3
 NLX57QQJaT2atzkoQjvDPIMr3996o3zxU1krmjIWsNGsfR9nQA41gF2qKV3L8UPjE6QLLSImwES
 t3uPIwR728YDr0YK1qPlWMFgQx8egNUC1NEDJc+xk7kkGYLEMoHb7KQrfMoYP9cZuoROY/TCi7D
 53hu8AjMVpi8Q2LjSmZ9QrTAnM+kCd2jYG1l9OHSKHp5LpgqPk2HIVtxKovWfo+G7LNHbnMM8p5
 JdF4px5oQ+w1ESjdTI7qOXswnKS0w5Jrn84MuQ9EsbRfHstlVYdE4Nvg=
X-Received: by 2002:a05:622a:aa8c:10b0:528:3471:937f with SMTP id
 d75a77b69052e-528347195cdmr14793641cf.29.1784736496416; 
 Wed, 22 Jul 2026 09:08:16 -0700 (PDT)
X-Received: by 2002:a05:622a:aa8c:10b0:528:3471:937f with SMTP id
 d75a77b69052e-528347195cdmr14789801cf.29.1784736491131; 
 Wed, 22 Jul 2026 09:08:11 -0700 (PDT)
Received: from localhost.localdomain (92.171.88.92.rev.sfr.net. [92.88.171.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b5c2108sm116316845e9.2.2026.07.22.09.08.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jul 2026 09:08:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 0/7] target/microblaze/translate: fix reversed load/store
 translation
Date: Wed, 22 Jul 2026 18:08:00 +0200
Message-ID: <20260722160807.24031-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pm7_jkdtZxUx0xL_EuF8znlaJzZ704WZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX+F0PmbkO3dIB
 LofrPBL4oxNJa1EbRh9TllGqfuqb+mDgOwaHlyBV0X1JkbSEj691dZr2LwT+HRI43mTstiy1PH5
 HbGR1duGCyiFdrVD81vlakDZBD81WeDkI4k3mnPRiI1Pz5vVVZ2tjXy3pH1wHzoG9HokWB7Ic4k
 O3GE/pa15onzNAw3uM6FC+okAVBaMAss67wssIXqRbhZOo4l5LPlGmy07o+WYqlKsYGtpz9SPK2
 mGQPDRB17mLs7XtauQ+T/j9ZeW5r1+HAARgi7rxbTK9TcH9ahTZqbiZ5fMU6463aHoEpTEnChdB
 TimrmlKpy88k1gn8iSaDe+4uznz+dT3zmstamVezOepdLaJ6o124sBIRyDEFmXzjTbqiUHmlocU
 k+8BhsheES5dh8zlWXzRbXER2A1yN0yLEt+bCDfZH1k82+0+smkY9EcHD4JHt3v45/E5coPlomk
 BzD+qR05LmJX7bsvi4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX0ticgAYs0lYd
 SO5b1B7XP8uVw/wh8TiM8p20SzE+zcX7yBRhUkTVmgJYfeZIGyeS26+T2+GlvDgki5J8ActdJOA
 B5TQ6+wsy78AoAbcgplGHiOPb5Zo4Cg=
X-Proofpoint-GUID: pm7_jkdtZxUx0xL_EuF8znlaJzZ704WZ
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a60eaf6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=8SOIyxyylBkeE3ShledptA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=zd2uoN0lAAAA:8 a=JJm8l4eiZTNsBH-aOPsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220159
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

Verbose respin of Luc's v1, but refactoring common code
with TRANS() macro during review process.

Good diff-stat.

v1: <20260710072348.3575-1-luc.michel@amd.com>

Luc Michel (1):
  target/microblaze/translate: fix reversed load/store translation

Philippe Mathieu-Daudé (6):
  target/microblaze: Set MO_BSWAP in do_load/do_store callers
  target/microblaze: Use TRANS() macro for typeB load/store opcodes
  target/microblaze: Use TRANS() macro for typeA load/store opcodes
  target/microblaze: Set MO_ENDIAN in do_load/do_store callers
  target/microblaze: Introduce local MemOp variable in LWX/SWX opcodes
  target/microblaze: Factor reverse_ldst_addr() helper out

 target/microblaze/translate.c | 224 ++++++++++++----------------------
 1 file changed, 79 insertions(+), 145 deletions(-)

-- 
2.53.0


