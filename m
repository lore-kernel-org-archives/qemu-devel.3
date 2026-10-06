Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A428CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEM3e-0001mN-H0; Wed, 07 Oct 2026 03:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEGVi-0004GS-G8
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:32:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEGVb-0007Gj-5g
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:31:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6969Qu8K1447296
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 09:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YnBHsl9ClOZu1t9lxykOhji637b1mEFnyAQgzWHkn+M=; b=FRYvZh8S0Zejn+JK
 k7NiW90V776D90+DArAoWBFFFNd4cqMlKIfbav6SAaHDY7aZ5jzZkMKbs6VvogT3
 QGNOILrjJbRgn2R5+0teHKQgl5jMLydteyCvW3ml2w8LCeuAbRL5lbUADl5HLiQH
 vZpb1gpR/z8HIKVQqBxpTlnY1sXZs2cOKQZMwwoO+K21p0sCidflQXs62rrA916f
 xUAHg/3n94o1TvkFAl7HQ6240pCeiax06ZHIDpy6tNXX02J2KTvRyqaj9KA4X3ud
 ZNf4k4NiT5CeOjxheE4sqS/bFfozQmvWynO6LulQcKgkQ+erj4bnCadYqO1+KthN
 M/uUTw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc500be-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 09:29:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf6c528aso412248585a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791278983; x=1791883783; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YnBHsl9ClOZu1t9lxykOhji637b1mEFnyAQgzWHkn+M=;
 b=ZGuwT0n0TYOA45IgW3BopGyWGKcSBret+zSb6QxH/0444AoQFuJNVPjgc2RTonLfGI
 Y4ehVmGbioa+8OkD+tKUYBwtrq6hR3TNkEUNpXlrKClQtG870TOgWxhLnUhxbxRI7exy
 6nQofa5aUC6/GIRqSoKX00elkDTICeyP0QZ1Ao9ofkjEFVjwHQERPjNPnf+Q+eT687nT
 9gZxN65fj/5UsLvgMpKEFbsHXmlNscLfL2iASfsXRA2sKF/DEeeL8etjLdgkliNIFVDF
 Qc0otZsfZszt5TsA7CEL8DLGZm8eq6IjF/8WsH3fvd6RBisMSIpF6weu3IHqlN3v7fec
 HM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791278983; x=1791883783;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YnBHsl9ClOZu1t9lxykOhji637b1mEFnyAQgzWHkn+M=;
 b=R5/mIYlc3GMA1hQY81X7hPuWZeRm55+GrRJgcksULT5iAFSeisFl6hKJpAyTN0Vs6I
 b/4pepsULoKfmujpC3Kd6T2wmA4VtNP345S9WyMGU5frBHrwd2qLz2lrpfaIBDtpqFx8
 6Bx6j4S6womrMjnshHRiwGxWLHAFUuo8EB6E5CCSVTqHHp8wLrE6J6TEZ73M3ry7WgeX
 6bkanctrUBZYoblvwu1gyZaJVIleiQ1g+2ZUHj3kPYV/jqaqMztKBdFnrx1jWvuNqTCU
 Csv0APPUuVHrLJ15s2LPwl5mqeWS360nK7g2SJOFmecVmCaWpytAoncGZuwaesNBZZIf
 on/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdn3eEa13COd883FQO7p0K9A4koUoBbk3l40KSEz5Zvt1ohh8w+NA6o1bd2/sSDXqNUd/Mc8dcXhK8@nongnu.org
X-Gm-Message-State: AFuF++nWAzVWsFWHgTGja9zNOGe06iPzVJjEu611phhg/WPlgK9qsgeM
 akgJtY/OFYxMgO/9n+H4Vy1MbLW2ySHVhwXBdzr3LNMqtJCA7kMKkkjs5Qz+uGhDITHSKf9AhkL
 KSeXV1QWuqo9dJKBgiFOm/fRPTYZjjxv6i/5R/WBlxL9pQUd5meKxNmHJKg==
X-Gm-Gg: AYBFou0kg7pI7uW6rdA5vQVD4JAY1hbi/IAd0tI9kAfG1nsXxbBTLKkyOIJyYz/Ls5y
 7mihm/nCtNq9RQJCTG6PhtbP2AMRxqVqtd6WbqyAOd9q/5IkLvNPzCDu7aoCSS+lDg7h2MfCguX
 eCDbPp09j9BM3JSiP7GfPi3f0XePS5xCv8r/jo+5bjF/jF3hpOp/Xo3hmxuyN36qcBwjHOIPAqs
 d7JImc5nD8NcKvA3Ewhx/nZPH2fFDk2WknEfhojWxzIHPAoqKELJfslI7iGX8Cx8cxGLprjbpFt
 j93Ca/Npy7JCjhXLC7DkzpoYZsrFaHAP189xeXl5rnCE9gcJALBRuYrW/arWHPKBwxwa79zk09t
 QWV/c74i0RDjDFHs576BOXOEQP96/lB8YKw==
X-Received: by 2002:a05:620a:2547:b0:93e:63fd:40a4 with SMTP id
 af79cd13be357-93e8f513006mr126592185a.55.1791278983080; 
 Tue, 06 Oct 2026 02:29:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2547:b0:93e:63fd:40a4 with SMTP id
 af79cd13be357-93e8f513006mr126588685a.55.1791278982618; 
 Tue, 06 Oct 2026 02:29:42 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c53997sm89834595e9.12.2026.10.06.02.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 02:29:42 -0700 (PDT)
Message-ID: <9461d647-1bac-4014-8010-1ee1f3599fe6@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 11:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/31] Kconfig: Extract config IMX_SPI from config IMX
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-29-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006083445.30362-29-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X5THu2Te c=1 sm=1 tr=0 ts=6ac4bf88 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=FRSEYCzRAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=WqDpfZ53LCkmLu67dcAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX47e8w7L2JT/P
 BwDAcBzFj8kzcyQENjlLplgZsA1GxdnwzwZW40Y2+zna+3w5Cf74qNT96pcn9y+0W3Tu0TCI+2x
 0wo+IVZUFzqMKWBIWUxBqYxnQ5bVa2U=
X-Proofpoint-GUID: o12apHkuCvOFPMFUoQvJIv6fOPjqMs5A
X-Proofpoint-ORIG-GUID: o12apHkuCvOFPMFUoQvJIv6fOPjqMs5A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfXwZCAtUP9nq2J
 T945mqIh69u9CLIZRCG56qH4vXw5w+Klvz+sZQ+hwJpFxNTJ3Z1ktZZSlMx4CartKoWOhY7PwPj
 +CCYtNmq0DFzMHJAGVS+dNvOie6CcOjLf2lNtxlOeC+f1+s9XiTVQO8b1oKqMaXHFKGTyF8CKeR
 054NdhXzqNIJFY6pw1CxmMSs6UdZm85Wf03F6S1WVBnbOVOp1qmgsP81PKstw/r9xHi+whKV+VJ
 PmraSuXFXGZvFmewzA3or6VVZsPcomb3vjBjx+JY48qXCDiDTiFW7BWF1NoZ/N3vPx5VdCRIZvl
 52Cyv3Q5O1BkCdg4MFVEv5v5TuaqBcXr3k8MlMehuJ+lwOnTUc3S0hqJhffG6/C0Bo1jNb/dDtq
 R7ukqh+i6H+CdPDC/jPhnA4dofF46Ib2dZK6qYtwkC2G5ItZb/F3I45BaHl8I4JQZ3fRChpl0KF
 xJf9Z5qc67biS993InA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060037
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

On 6/10/26 10:34, Bernhard Beschow wrote:
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config IMX_SPI to eventually eliminate config IMX.
> 
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/Kconfig     | 5 +++++
>   hw/misc/Kconfig    | 1 -
>   hw/ssi/Kconfig     | 4 ++++
>   hw/ssi/meson.build | 2 +-
>   4 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

