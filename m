Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0450ACA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxPA-0007vD-EI; Wed, 30 Sep 2026 12:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxP8-0007uv-8a
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:43:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxP6-0002kL-P8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:43:37 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDxkX5703824
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3tU5OfCOl0aPs5b1fkzplf7fB8fsutj6lbLEQk6KZqU=; b=i8iOo+lgwUaQrXnR
 2sC0taa7VMMoa4T3qxazsBpR+/a7IQTxmotNmCFtlngHZysXp8FEY57SpjbCPyFq
 kG8PZtkpou5+TpRsIWR3iniAUNf3mWMlEE9hO5717LwApJdao3mcEQuQveKq5Cbh
 lTbZOP1qFGqSjFkOOYlLKeBxGxpiEeD+XDCQZRAbeckS+6JmqfulfwYlaLf8bEgT
 NK+suJh+34daP4NNbWBP03xmCywSQP1y0vrJQiLkHpn8u4G9axLtoHYzPqdYK4VV
 L8HYJA/IjJpyY/JcF1K6KKBzwsQ2g2uLKndsNwQP2LuH6Kczcx9gKr5huk20SQGM
 GMNivg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tgw2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:43:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf7856ffso111556385a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786613; x=1791391413; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3tU5OfCOl0aPs5b1fkzplf7fB8fsutj6lbLEQk6KZqU=;
 b=SWwcE7WZGC3oNTlTGZs06bhMaCNZr417JiDv3JxhesdwI308NJplCZcZoPstHYp1yz
 z+xCtdcYvOxJvflyOz2mjJtSahIk3i37P5LzC+jPhVA4INlbeacAHUqDZot+HncZarCm
 B4hb3D6fDI8MQnZPOA2ngObcGSkpSx5rkfq1i5z1D98y5Vs4AZ7b6EI5vvh0ukL6ghea
 DTfHff9i4Lf1yiCTAaQqiYhowtTLtC9iEHFj1Fl5o2QOkRug24PUUYh9YWqg6s+UNF8t
 UQXhFefg2p7Uyat1QT3qgEMaxqg0ebpoMPnnbsGInDA6b1UKHmLAJTMI20EG5+bAo1nb
 koCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786613; x=1791391413;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3tU5OfCOl0aPs5b1fkzplf7fB8fsutj6lbLEQk6KZqU=;
 b=HEcPtURLjrAh2Ks5FNFu2VHGM+G4y9ZflU+cHXKlK1B+W5lwXOtZANGFDG382GXw/v
 2yb/+WrZTNfrxH2SSn4iQR/eTXBAvfFR2fVM0Zlhpdl/WzKMW54fg2nBZqfM3XwnkWl7
 CurwJ0aNVqn/h8w2w+/ujIbO8tvtj0asfRfxliIIj7diJOzpRFfK6JUUkNpL7NDyzrT0
 3q4Pq0TVbH4SfU2VdqB+zR0rt5enq8wKeXrlrFqI2xFp7jIXN1m0jCAJr3YLr1xyrlCk
 bAqV82JuUeod5tMITk3hZkaaBi+agXhu69PXcJ23B4LETTeZR/+/6C0nwMY1o0w6XIOJ
 2B7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPWjtYGzaaQHLJRpkdYvRDSvQSFzbJ7aFH0TfREEkMcvdnQmDlERPNBfh8m5UgruAhxxMGiDnoLgD3@nongnu.org
X-Gm-Message-State: AFuF++lPjmlP/G21ExBn4D4IBqep2Fnk6SmGk7fXfK9052cL0BP0neWh
 p3zD2aUmNS0bNChGHMe79uls5g1G7q48droHeTWKnQvJDpotJFNdXjNGRu18okVB/urIacU2eBH
 GGoqAsC35px/BJT0Tst2/kTIE1jf9i8Uf1Md5SMhjgGU5mGVJNbIHn9E6ag==
X-Gm-Gg: AYBFou2QW32KddnbWdGH4gnLiUKYOOJXWRSr90+HqzmTP9h9vBcH3v3QvcKPgfqFbeX
 6AkIViYqjHUkmb3I/NBuq9SE8BxnJRCNzLNW3mpJSe4thVcnAcFGdcY1BHDWNDEXvukPycay38f
 36Ee2bIp/OtKD97HhXfsTqvPcQQeoamVOXp5RQG6DPWHmddRjvtx67xLraeWGiCsHNCauJHqBGN
 ItKkZDTpj10tlPCtrnwbTKRBdoVvq/XW5snzhUo6M0+c6rGAp8nVMn8XTVq4CtxhXt0TQHwP6GW
 yGsix1DcxQglQV7DIca0cA5jg6eMU0CHgDbWkkbTMZ+DJj7kcaOrsCquIyyppAxCjSxfgEcYkKu
 2ipnlCvJTRCFlaydnZLg=
X-Received: by 2002:a05:620a:319d:b0:939:f978:c1aa with SMTP id
 af79cd13be357-93ca977993amr341846285a.11.1790786612992; 
 Wed, 30 Sep 2026 09:43:32 -0700 (PDT)
X-Received: by 2002:a05:620a:319d:b0:939:f978:c1aa with SMTP id
 af79cd13be357-93ca977993amr341839685a.11.1790786612184; 
 Wed, 30 Sep 2026 09:43:32 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff6eesm234832f8f.11.2026.09.30.09.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:43:31 -0700 (PDT)
Message-ID: <8d45d711-431a-4849-8c9e-9a2ee8576da0@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/27] hw/usb/dev-smartcard-reader: derive queue counts
 from start/end indices
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <20260805-smartcard-fixes-v1-16-187ee9122441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805-smartcard-fixes-v1-16-187ee9122441@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfXx5ojsfiZBzb2
 RDNSPBjnrKP26QIOLJbwcko5SEG0f8CrLPFrw+VjrSkaqKyBdDBKSxKRh0twYM8nN/2A+9JmVRd
 Rx7zrMggS/AMerIxYzt0ZyndQ8LvZkM=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd3c36 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Gjn2l42msteVREqs9iyztXSiHBvQZxO0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX2LCBrzXd/T1Z
 RVAr3kclmDpa99kjMKynfzlh8XWvpTkZJKyYgSj1xDi9VS/okPgNsQfnbn+Hv7pfexg7JIt7Hgz
 uxFdETAf8F8Zss3rc43Ft+pXJTE9OXbWpZw3sbkFf1tzZDI6rB3xgQ5TM/tXL00NioowJgkVAHJ
 K1ApsJLlKW97Elgn6rS5qLwX3pQWKJg8pgTtQ1OIJGb2zGXJHQjqiJNYXQNfthiuRiRvgWx50vZ
 ptnfxv3FG+E8BeMAkIvleYh70OUBmaecOcunIkCZ/hehaR/T3tQJ0ML8p9T3rpHD2Mwif14BIJk
 pSOqSB6ZKRWVrR8aUSYV9e8icD9pxxEV4O8s1prUSkiTVrzDCO0Q380JFWfzS2lQKVWGwMLYPhU
 HWX3D03AQBkSuBYkws55idLvQ2bjVKbHj+qytkw0BIjmrUJg7s/KR686vRIAe1IbqdqBu/Uwi8q
 QpyoG7YSWON5Ldm7pTw==
X-Proofpoint-GUID: Gjn2l42msteVREqs9iyztXSiHBvQZxO0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300066
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

On 2026-08-05 13:51, Marc-AndrÃ© Lureau wrote:
> Replace the redundant bulk_in_pending_num and pending_answers_num shadow
> counters with helper functions that compute the count from (end - start).
> This removes redundant bookkeeping and potential issues.
> 
> pending_answers_num is kept for migration reasons, but since
> pending_answers_{start,end} are not migrated, we can just do a best
> effort for the following migration fix.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 47 +++++++++++++++++++++++++------------------
>   1 file changed, 27 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

