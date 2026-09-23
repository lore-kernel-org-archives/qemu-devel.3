Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEBFC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 04:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9EpO-0006xV-QG; Wed, 23 Sep 2026 00:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9EpJ-0006wx-75
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 00:43:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9EpG-0001An-QT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 00:43:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N3iXbC2728537
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 04:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kEHcUl76dF1lTTmJhKiOdL517Yb6hQ2fZZIn5DIduco=; b=LatTDJe9AtvizRFk
 9ixKGPAn4BUfCcnSLSXt5JOEGmgvUPt2RrNNJFOY9xZRkFzAn/aA8LcdM7OWDI7M
 9D6u2z7e6FIJCOe3jqN8Oa4+KzJQdTE6SWoNS+eLSX1YgYjYPwpI07ZZyxGNTBqp
 ZE1zqt6YfvbAlTHlXPwaGUl4s1HUPc7tDmGx4NyJnxFW4yhQ7gtJude+SZPlZvqY
 Jxa/Y58ZA+5IkKGHrC4Lm5Hl2ylmGNZuJQGJ5n9oUfrmvk9EpkdAPHRXcRqEa8V9
 YbNHVXAk5U69IiFvhEEN19D9tZQS7UOScaagsklfdsYuldaU5ZYHyOdciL4T5qqY
 /EJ9aw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux7xtgyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 04:43:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so123851485a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 21:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790138600; x=1790743400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kEHcUl76dF1lTTmJhKiOdL517Yb6hQ2fZZIn5DIduco=;
 b=NE58T9aS00Z1QVcubEFZi96WlbObgoDGrLj61Y/roQJMJkyFffInZxFv+mEkFY306t
 T5MflV4FInSz0DKjDNG/QHHzoY99x/d6fr1K1McXmOJDog3evvbms57Xmw3VIwv3PS+3
 B07Dl5cVz5TxZGe5AZZ9dpjN6BLXTMKCZg9pfRKuqy8rx1trzZ2kDBzw57o+ConW9cLC
 Pu1WiV0JGYyc8C3BIIVRB01WiDkG0JcMD8vjFSz65uL1oCfrftog88XIH3NHiN4pNgl7
 Xdd2ncPRvOehRr4vDn18ph9PD25xwHTik9xDIWcpbrk9i03pmnfCLNzYCnbKlOuoPiyh
 o9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790138600; x=1790743400;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kEHcUl76dF1lTTmJhKiOdL517Yb6hQ2fZZIn5DIduco=;
 b=qSLKsSmfblL05YnwjY6zp++xEQbzdMdHcoexk0lJ9teVUNJ8GB/0HIX6GqanwYtgpe
 8kXu3Ox42cLwrew0L2z7hhn8iXmrtPRXRPBjW9i6jPoO/fcN+RmA94CCJfPq4Wbub/Ki
 MLKazYmGIxvxwi1zcK/Syr/QexSo8/yWVUAZg+adZwbxaVGJiHUZ9M6h+644fnzpfT0Z
 UPAbWMeeh0z3pbLnQ7nihD5ASWyb4+4BTmmwuxfvFmQZkK77kXDMEJkCTjBG8Lga4gJI
 DbvdZ8AUkchQdovhIVjVsR62nSf97MG/xYmrtebNE1dJyf475zhQIUUYTgCjemf11g1F
 HmUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxK4bBK4aDTGTOE+z3Eh1hPjkQIwpOQ3Lm/2gl3RLMChT8tJRn9RBc6MToQb1jDRf/rQJetaQom5gOo@nongnu.org
X-Gm-Message-State: AFuF++nZPOkiAbcB2u3UTjSXkN6a8qOpclGqQZiJDcJIJrZ8duxORTo9
 39PFrKicdjAZLBm2g6ietqeuXMPROLB272sHQzy6K64TMSBi7Qe9rAjBNrYyjwQNL2jGI/PkBOc
 5SoHtv+OlPu9KZggL6rKJmojrLyNrgi7MtRUBmCdS1sfVr0t9/V7/eNAaAg==
X-Gm-Gg: AYBFou15DtzD7rOcHa3v3vY9SF4Xp8XMe848yXV1p8SLs4J8MB1eMvIBFpVRtPXRYPO
 Lgnv6hreh1VCeV2y83PYaesbG0cjR0Aet8roTeixXCoGKdL3MPhhgYWZSr706CzKvm2hkJe0CVU
 ZkNzGfQ9Hm2xM6hEWrLJ6xI9QaTrN3J7QGHkhkl1dLVDrqh51X5PchTS4yV3lXBizcIkbBmsaw3
 yAd2OFA2iQRzfxuiWQPE4BIj5yaO0GMb67j5wcxVNK7EElZ7vQmoZsNwuHuwXoWn4z9zinN/LmW
 k2KHKOh3/1obsZx6fY3+CBxG0H+D9fzz/uPkgtPbSEY/JGGbJ/SMuToUEYqB7nVYYxXHvZAls1w
 7nqvjuvYlcs+a8NHy7ntJ4e7B//yCzCm+mA==
X-Received: by 2002:a05:620a:a0c8:20b0:93c:2726:77ec with SMTP id
 af79cd13be357-93c27267851mr100388085a.5.1790138600091; 
 Tue, 22 Sep 2026 21:43:20 -0700 (PDT)
X-Received: by 2002:a05:620a:a0c8:20b0:93c:2726:77ec with SMTP id
 af79cd13be357-93c27267851mr100385685a.5.1790138599618; 
 Tue, 22 Sep 2026 21:43:19 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1da00bsm42184415e9.10.2026.09.22.21.43.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 21:43:18 -0700 (PDT)
Message-ID: <c2fa1537-310d-423b-8965-27b171d55b33@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 06:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker/dockerfiles/debian-loongarch-cross: update
 toolchain
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260923000510.218473-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923000510.218473-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -ilg0Sgs3R_xQMDwph_Q3bBBVFkdnM9g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxOCBTYWx0ZWRfX8USkIKXAcDQi
 z6MTjm63jf8kQacUYeiRHNpWQtxvz2/WNqa84OQehCkFj2xP9win21z2TShLsaPsJxWKtJE6Yp4
 lDvOdDkKMVdK7ong6SUKfCFlvG1Z7FzXomuvXmJeC6lOcdSwVi8r28U4a0h/8YiWh/78Otv951T
 5p4h+ZB1R+t6b6p5H3BjW3PMUqmmRH6s/eZiSSOUQLYnP7HAiuT1uCA8F6e1qCsyRajL4AaPPgU
 V23gsLE2ooP0D4QWu0Ayd2PCmhuNVThuQI0nwBPmLV+Xd54sqd8CmwMW2oiL+7XywWkELVYvqAN
 vhHy0SVDetsabRIxtLLEUhj597DKT7Jv+b+3e+s/GInVqKjRGFpPV5PraOy+dbCVdtcfTME7dvn
 ImDby8O/+fTiBntIHSsz0Ljhhu8JdDWOd5c1q+rKYZq4QeD27U6c4mFXcHolVseIshzLHO1JENq
 wOJJrqn4hHEWE3VcidQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxOCBTYWx0ZWRfXy+g//I/nwlvo
 /prB9AVtjCw87q/23YtEBI2ZMQxWlrJnfvSybGC37rTsbM6/Ilm3H22uIyBHifvZ9nIwKUrogKj
 EqAD6MLv3qFqH8OV8tQPlVAEioYTOzo=
X-Authority-Analysis: v=2.4 cv=QsDLTlyd c=1 sm=1 tr=0 ts=6ab358e8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=DTbva5pb6JUnWUDYprEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: -ilg0Sgs3R_xQMDwph_Q3bBBVFkdnM9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230018
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

On 23/9/26 02:05, Pierrick Bouvier wrote:
> The previous toolchain was embedding full libc when doing static linking
> for tcg-tests. As a result, each binary was 4MB is size.
> With updated toolchain, only needed functions are linked, thus reducing
> binary size.
> 
> As a result, we save ~140MB of disk space for tcg-tests.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/docker/dockerfiles/debian-loongarch-cross.docker | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

