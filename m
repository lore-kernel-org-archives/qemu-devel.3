Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E94606A33E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OOQ4olDs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aZGL8/4O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgfQ-0006qn-Gr; Wed, 04 Nov 2026 14:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xOgfN-0006qV-33
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:29:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xOgfL-0000qu-5w
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:29:00 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FjFNA1692637
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 19:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k2xR7BVQQR8B9MdRCaBeyxEzPiNyT4h2IzGqRN+Fgjc=; b=OOQ4olDsm5lQurMo
 rAbmlP4rs8e8TVDVszP7EDP0pY1n0HTBxIbxJw50e7aNFmcZCyO9cn6ccjLsHY7l
 DUe/NlTnHrqo4X76znPX9UK/qklVcmK6c7zLpJ0Y9PewNCt6nqUZiQnHXq6EvoNf
 aWR2XNUVWRKFTdDMYe5HqVHwjzNj3arKszp3fvNHhFUU+Fu1SExOtylwtsy5uQIO
 VKv5BNm/O7c0PrN1SgyfMzBYVeZeFUNLblPBtLIzKkZzjLf1EAQDZ7msZTzKOCSJ
 ULZ+GMSN4Z07m+JuY7JN8oMKxx3rA7Q+hU6v8pniY0kAQU5gDx84YiYydmpXPHsQ
 KzmuKA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6br1are-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 19:28:57 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4fb73e868aaso1805470b6e.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793820536; cv=none;
 d=google.com; s=arc-20260327;
 b=jK0ryv0WgwLzutwIYrr1VcxuX8gq3P90Q6Lcwg7piU3CWKjf7u2mUk1g4kJCEBJT1z
 uGgjutXdbdKK1dEg1+bA+ZF3zaNS00zKxzPTLjJOCi04ntT2cB5DDsUuf/GMlPoJNZ7w
 2yFO2vEuJJOx3AJNNOjc8rIG2dGqgl+cjEdUa7vzn/20xjNh6CoHzKzw45M6pkpTVpzm
 vjpgebOZQGf7ZWDb/BAl1AjLyEPb/tR6jd3H+AsQWIFyOLerEJjrMb3SlD0MmW9wqh7k
 Ll6lLggsyIANyo2BxpKfCzYu3qj64qz6GHDnHt/JaWvdAMkS6P1cIkKABVblnWHDqU9X
 fLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k2xR7BVQQR8B9MdRCaBeyxEzPiNyT4h2IzGqRN+Fgjc=;
 fh=/1lq0lfR1GnA6ZK1FUVPbYmtvfdWCEexdPZ27kjzpc8=;
 b=keI0EEXeSJiME2HJYct7F7cXwO1MGKrYTYnhLKdNbh6Vi13+cfe4z33XwZO2pT5gTh
 uHQHaAB9EJvWCWYhsEU5vtQUkOEPar4xShQFCW0UNtf66gJX+/MlHGce+r0063WDSlWh
 sl7Yg+kfo0INnfBUiAr6hI4myoRmhJ8Lzkf9OpM4EeDdRl/UcjYqqKDrPz8i763lp/fo
 BDloyH4LZjWWyxYIkm15dE7lIbEjmwfbqitGj6BgOPMG3vWlrzNSSEWWfUXfxSIbwybD
 Yf1TIvztHCSJItAnrxes+R2B/ahlVl13QCWj/4qI4CF81tpPeQDU6CVCd/NsxfNj7lH3
 UjOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793820536; x=1794425336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k2xR7BVQQR8B9MdRCaBeyxEzPiNyT4h2IzGqRN+Fgjc=;
 b=aZGL8/4Ofs8v/45GnBiDAnqMdHBaYwbTVXISc6Y75TWju2hcCIZrG4ZPzS0n7A/iwd
 +D+olavMPqjNbdOlH8ouLqymIgw6R47knq85GyWCcbtI4unFyUDFzOwHrjF+ab0lRiXj
 8gx9Y/CIbA+OTdjChsgVRk/Ynfx/InZHGwA8ylCO0lS21jkDgfH+UdNBvbHHXdDmAVbN
 yLORGi9Pj01hd9aBPAtFuJwiP2DTJ0o/h2Utnc54YOEq/I2NCrg/DJZlexah+y+ZvXvD
 rSDqtGp5V98yCEopxhOTMw5jGpuJAsgH0w48CcobylENIxcL6aaLxOlwfFsNPhVyPylT
 S/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793820536; x=1794425336;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k2xR7BVQQR8B9MdRCaBeyxEzPiNyT4h2IzGqRN+Fgjc=;
 b=DrAKK+c6cSE29pTFJK2mbAzrfooAmtdXSX1fAwS5Srs/D6aUpoZHgtwfz27oH5/59C
 RMNnGz+buBDksgP+eBWRGI8c9QvKZDXa2Y5LgqwfeUUK2JZaKK6vRHe8yQ/Q4lzh0M+R
 ReKpXiv2qPUwEjkyYSZJc4EH6yy+YapiMz6NWXJy6qD+XCZzu1P5ormFWcjogR8TfeBk
 L7ZUcCc9A+MhdL1Ns//2s21n3NmB2JyqfK1OWZhzdiEGwbJrHNkU1hWl1lVEYbb6dnVp
 sQWv/pZU4pj4k67YQHvpDA/0NAOHwoBLQGsJFWHy8YB2KuutquMC0u4V1wZB+9GqhqC7
 2tmg==
X-Gm-Message-State: APuU4Z9ug5gRPbkm10wlWgVVpZ5hPzl7Bo0TMjojP7Hh1Tvhg8VSRtqD
 g2vdP/ufpJS3p38DVEWTUg36XWrwmU9g0qdV5xw+zYfslMYWA+/oELg3g/AS4wWdqrz8CBbGSN8
 tRNqz2M2blHYkwqYDCihpWCfKozRbVaJuekSnAxMjqlD5wEvujYsT5jd44N7CtCHH3vG85GJx55
 ZR2gBbPuPzFroQVHcU1SfVz49sDlCpoaA+
X-Gm-Gg: AYBFou2C7BIhw5C8JgLHh16ZjOx3H8vFxv7pzOgKHshAS6k3CDW3OJNZq7iu9w6I3FF
 diLgP6sVCL4zzbSQLznC+pechq1A4Nfsq7fafWLqwEw8q/VgytnH1NqaIOIjWOyKsNnyXAqjFPm
 kTlP/IW2z4BL3q83Vr1/BSioYhenW3zZGty83MQe16CJ37rqBCfjfrhanSm3DlIxBzBygib43W3
 DMAwehwN3YqG5Seyg==
X-Received: by 2002:a05:6808:c2c7:b0:4f5:d873:aaaf with SMTP id
 5614622812f47-5640dcecafemr12029153b6e.14.1793820536159; 
 Wed, 04 Nov 2026 11:28:56 -0800 (PST)
X-Received: by 2002:a05:6808:c2c7:b0:4f5:d873:aaaf with SMTP id
 5614622812f47-5640dcecafemr12029132b6e.14.1793820535628; Wed, 04 Nov 2026
 11:28:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103192358.28589-1-anjo@rev.ng>
 <20261103192358.28589-2-anjo@rev.ng>
In-Reply-To: <20261103192358.28589-2-anjo@rev.ng>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 13:28:44 -0600
X-Gm-Features: AclHuK-eMuBL_d9KoKBMTWLCIbfcFTeYSvbcynTg3zuPqSlRrXni5xRqmkmkFQE
Message-ID: <CAJ+KCYMnrCU+y7e-RoHmT1R-=jsdE+6885Sv8NXxNZMxXGNJDw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] target/hexagon: HLX,
 preserve scalar :mem_noshuf ordering
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, brian.cain@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3NyBTYWx0ZWRfXwcI0fZTD7axc
 x0E6726L1HJOlXstIbfGvVsOXcOfhJOM8YRrVBOYiu9MjPjPXbt73atxles/7YvjRE9pCmSTUfX
 5NxAMNiX48MJL7nXpEkj23cCuE1uvj9U1Ifq+uZ0tRgJR788namDH/95YXUrjLxmWLkjr0t2Xed
 F6S1d3b1vBito3yd90vcSLjE2PTI/uN+mS45JyBmUiBzLmAiKgTzKKGKBghg8if7HinkHf4WYEq
 TcEB0tsNfxmzx0cpiC1CRFDOY1aWh3apSyIljppiTfdIKPIGxcInCG5bvMq0vadgfYhhWN3PGn8
 vT5yGdu+wuXsAyZY/Ge4586VGpDEi6b52TYxtLrPdsMxadkwxsqQn5Xh+4AAamWJy6e/rDn4gKt
 Ul+BaoDXTshTHQXLaFgQJ1faPwP+UeheJ5T7xX2Jk8sm6WVkQ07rVvHWuOIlGcCViCeHqgoljQY
 efcIn+zD1frKIgLr+JQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3NyBTYWx0ZWRfX/53+YcYyB1oI
 RwYOMuGcgNP4Tt2EJT+4ZAe3rkTMipRW+vLIWp64abAb5jE5B3ap18CBTEhwQbkQVptI0rT1hfO
 Z6aiAo/JkB8xNP5rEgcmF32A2AQefT0=
X-Proofpoint-GUID: 0NFYcblZT-zAlcQXJ2DbRRcmmYgtqC6z
X-Proofpoint-ORIG-GUID: 0NFYcblZT-zAlcQXJ2DbRRcmmYgtqC6z
X-Authority-Analysis: v=2.4 cv=futJ914f c=1 sm=1 tr=0 ts=6aeb8779 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=jYwdBdnoqkFvpO92Ef0A:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 1:18=E2=80=AFPM Anton Johansson <anjo@rev.ng> wrote:
>
> A packet containing HLX instructions currently defers all stores to the
> end of the packet, this breaks scalar :mem_noshuf ordering.  Only
> reorder HLX stores.
>
> Fixes: a6fae6da070d66b9 ("target/hexagon: translate packets with HLX inst=
ructions")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/translate.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

