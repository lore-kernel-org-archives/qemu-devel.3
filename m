Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6D7C61DE8
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0v1v-0001Eu-7Y; Mon, 31 Aug 2026 01:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0v1u-0001Eh-AZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:58:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0v1s-0003Jm-RV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:58:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52QXA3260449
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MoqxbOQCfjEwpg/ycetY0CAnxspLVzZb/EnIYQW1QlM=; b=ec+n5sV21RN/cHn0
 +QqF0o2Du18YNYDBBDUc7iuVABAOFouj54JvdecDUj8ruvPopKlGfQn0MO0djugI
 BTsXyV9nYNBQwO6fbpZ3bY5D4KDcCYOT15ICcPEsugWObNg2wri9OwtE7kGBHCEH
 qoKRKLxZhBlHbdl72RrBSwT4kgPjcGilQQRC7SkGP3hCN0sicIoY0PVVNZbTiBPY
 ntjYvbPFG0v8aVveVg45yXj/ASAJj7bP9N+QDp8Wgi4aQuSnmJYGwLQbsQoBgEs4
 2PnSDCMQFtGYOTIiCkRwP1jraZqou7lPmeQeNf+mV5uHpW3T35g3jxZbGbKyOnCO
 0Ruxow==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqdfmskh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:57:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9382f9430deso487432685a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788155878; x=1788760678; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MoqxbOQCfjEwpg/ycetY0CAnxspLVzZb/EnIYQW1QlM=;
 b=C9QqtK3uHtbjncaDXtpcy2I3Ux9nGLTtpYyVcUh0fAzmp7DmPrTtNnOQcdpvNtCbKN
 VnBhtpLBX76+73fny9Am6FWTPtjbX2T0emJqjukpcKzwWSWZcUe9a0m/tvxdgofP+vOw
 UNNvXC1YH5h1ORZA7f8WKCH1/BWbCtL1B1cRQGsQqhyN2oQcM8+tkzv807zu1eKzpEtq
 AiaxfdCTuTuZuEwykbyjTZquTkz0haUjh6exy1R5/w91FjgLoIpdi1P5hNmf4Ci/3+4I
 Uo1Pk/tTgttJ6LKDmPRRKOEO+c6N2ISxz3fB0we5p2Ul0nc14WyhdqHW5Jmi/I953RxI
 UvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788155878; x=1788760678;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MoqxbOQCfjEwpg/ycetY0CAnxspLVzZb/EnIYQW1QlM=;
 b=L/skjMhQAvAA7QwB+3PKL9G5c7e2J4cY+vQQdMbKB0bqa5HNERybblJusE2oKtlVRi
 Kuqy+casUsclXYQZHqNMTent8tuGzt1gk+Gf9RZF5tOOGVcfIJo+PwZ5l8gOHbx2j/JL
 Pi3KkfkzDCxBKjSDzb1yA0KqVUtDpWXqLFTBWIiQRe01IS6gx3oV2K4FAu1YvdbZ/3MM
 4aK11dL8lVdR2asg53s7BzE8PqSuYQ6QgIKNWIQajvxii4b6heohhrMb+JE/qed7APss
 qbiFTTF+46774dg9DTksx/yc+K6azTBYzvI9YyDo9Wavwmu981pABmUhnI3YomKsOIBN
 c8Pg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2Ka7HLPP3eyrG7+4zR9xqvkyfo+5RN7Ah3ltYIGC8tI5uFrbJmkHkAz61CAWRvNyl4zSE4CItJ0cA@nongnu.org
X-Gm-Message-State: AFuF++kwBbkCgTBylWEkN2/18tXT3dHYDvJbpqYKI41PZ6OcBURcm4yU
 uzvObT22Hb8hxAGOjmlJUn3qirnmo0E+hwsftg1KwgJR6bcacsWcKOghJgW5o3ML/EfjFKEqOTo
 pzKXelR1AnatJM5gTxq7nEtm7yMrYxJn9+e3mYsbJqUWA+rr5zfy/F39UeA==
X-Gm-Gg: AR+sD11J8hsvDdk7gMnFWrQU0RCDgIOqflXaEBGbyJM6wjdvFwh8RDPnURYf+aYB0xs
 adWphNvZphHdz6/gxJZDseQnKmp++ruOWhBd17xO7FHw9NOiXgRcdFPtkLRcNUVw1K6EsLs2vq+
 jXAcuTPyWEBq8bFo7sL5h/HJ7e06PxbB014zY6XMMxr7483djJGAN9KudiBBUlt7Nf0fFBJEa9/
 2RB0+VXS+IhpB+his8OlS6ygXxjSii5teB7awDBoGY0B7LSWfNiXHdpeYthNHyiDXwIqObRXop/
 LUXSbcZ/2KJy/rl97ZsmR9oK5NcCeej5qDEV7F95lTD9De7J2e5qdBDJ6F7IEcLbQw6JKIwQqwm
 Rty0gsRwXM1lJOnDBnJ1eDYOZ61UeJvzKIw==
X-Received: by 2002:a05:620a:4005:b0:939:1483:55c with SMTP id
 af79cd13be357-939148316ebmr2404209885a.19.1788155877802; 
 Sun, 30 Aug 2026 22:57:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4005:b0:939:1483:55c with SMTP id
 af79cd13be357-939148316ebmr2404207385a.19.1788155877372; 
 Sun, 30 Aug 2026 22:57:57 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4843adf1377sm5363843f8f.18.2026.08.30.22.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 22:57:56 -0700 (PDT)
Message-ID: <c8e259b7-3b42-4dc3-963d-2ce8ee680500@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 07:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] hw/arm/aspeed_ast10x0: Remove obsolete
 unimplemented SBC mapping
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
 <20260831034153.192916-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831034153.192916-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0OSBTYWx0ZWRfXxioxwow/Qouj
 MMvAyCVz+btjT9Aco4ZsffPkNjfuGaCT0Ezxb3ELOegfvUPq7vV4VCgH3hTnt/ZmEifULQ4vzPx
 cRK0Z7/DSWKALJqisCf4VEDTzxLSahtRHTnlz0Nk5LHsnHSVrTWTGsgBlOro8wfR2eapEZcl7PX
 au0PVBlXb5Q0K507N6+4DosKTEdd8XTpYpDbUIfl95x4yZ8/4DUoOUxVQXU2LN5DRHAEaYxE9Xh
 RF4BLZ8dscvNnwpCsD415hz8+YCdQCF6sTneWLxOfXmajSAv0FuInIkfVGirvJyF+p4XMJPNjoF
 0HIwYBYyqVCATb3tIiUhP9RVafVdEB7hl3iZuX6wPtTt9YMVn7TGT2dsKuWrX1a0Mj+keSChJBh
 5BzqM5oRuwU+eOkJyIAI8KGpUkHfw/FIyMphHx9wS65t/LwswOBJHh/tyRBRu4wZ54XK3OkFk8r
 YHP20/4j9td93VU4Mjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0OSBTYWx0ZWRfX3wwSJZsPnkv3
 13lKQkA/TNq1e15UNQAcw3cHDQb50XFRkuUawQFb+KoMXYtWPGWmWvHubUmoMMaSSgLqzBvt+FK
 wbCUghgI2sLKUCgf8RAiZduXMwbL6Mg=
X-Authority-Analysis: v=2.4 cv=B7eJFutM c=1 sm=1 tr=0 ts=6a9517e6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-GUID: qns-ehmQvjb7Jcp6yUe8qgP26T8lOaGY
X-Proofpoint-ORIG-GUID: qns-ehmQvjb7Jcp6yUe8qgP26T8lOaGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310049
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 31/8/26 05:41, Jamin Lin wrote:
> The AST10x0 SoC now implements the SBC device model. However, the
> old unimplemented SBC mapping was left in place.

Since the introduction in commit 356b230ed13 ("aspeed/soc : Add AST1030
support") indeed.

> 
> Remove the obsolete mapping now that the SBC device is implemented.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast10x0.c | 7 -------
>   1 file changed, 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

