Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFD5C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24aB-0006Me-U3; Thu, 03 Sep 2026 06:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24a9-0006MB-Iy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:22:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24a8-00028V-63
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:22:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH76j3203906
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 szUu56Jo1e5Z1AaFwfPIOVHeXSa4ld531Spw9WUM3Vc=; b=B/QAv5upi/fEHUvZ
 IZjAJfWSWTHJSqQKqnl54RiRvbnK/NuWM0I2KwvvtShB0uo32we9iztOOkUPEynM
 BQu+hVXgB8RxB89KFJDJW6taR4A6lvlna/BcwDIoWJ9YYU3W9JeEEBFybNSMz8VY
 ApfBIW9ZkfZYTZax5RHwxUUO3wZQh5ibIUb7HyI+zp7PimkgnUc5Y9bPJdIeRQY4
 LZAMHEnueutWr/Dr1l+6i2LG8uizIZyPAfR0Dm/8eymt7Ts0saWJ7do/RgjSUHQ6
 ok3XjutNOYGWLQVb3+gmyytmpAALoIMZAXlTyi/1wk25dPy9wlec7b9Hq2pHkJnG
 Ksq6mg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d10fb6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:22:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9382f9430deso408213885a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788430925; x=1789035725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=szUu56Jo1e5Z1AaFwfPIOVHeXSa4ld531Spw9WUM3Vc=;
 b=BQU5bhrHItdB2LrYk7X4ZDyAaZriynUPcB4yk/7kQQcyvpG4Z/HMu5Rq4vMXw8KG49
 +KfWCyls9AM46b84nbkUMLID8uszlIk6k0TYXAU2+Po27U+x1HFlMFBdWpAiMij8kFjl
 TQpb8wKqcPw3nnEgM39RqteJS50D6AYtlQAKvZGZQTns21KBwfWpnJHvWipv4F0n88t0
 KxZY3W2w2FKayrHJRlKEe4wgdaJ6SYlG4l6ECmfdbt8Gnb4zmdfF0Q0CMdthKD5jxvgH
 J8W+yGdSehh1w9KsDEu47TgRUAkQMRpZs9s5EGoOE+W9DVx0Ug5S2Qp5w4W84HE1eJw+
 Ra/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788430925; x=1789035725;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=szUu56Jo1e5Z1AaFwfPIOVHeXSa4ld531Spw9WUM3Vc=;
 b=tAMnydfk9MSDkGPLIGQIPHBncz/jUJ+HycyTeEdlrtQueuRt8ufC99FW9GREFXcXCX
 mpjXEP42Vni1FELAZ8hvJCvkBTFsG8LSONYfzY/aDzSX9RqEGnS0r8HmPEbfz2dk/VCz
 /Ugm01xiF8lcDS9M/m+JMUfSp2hoCO8IjOytObbpAhROY2Uiv/K9oR4nsXfIlA7EJYKM
 JaEaig7DliDrnBLcKL9i9ET+EtdFvDYVnj4EpTRbBPxuZOi6S/DFm2bnCJWve07zR4aF
 h0Z4KgWJb4CjtW18+ZXIn4D2e9gO/Upkn/JoKzemDlK4syXEHr0qgTgCPmqCZeKZM1Z2
 cckg==
X-Gm-Message-State: AFuF++ndVNK3npJhejkQmtFPyNKpwf4zvRmQy2Kwk1Y/81fVy5dRHG3V
 WxZnO5/lj0M+BX5FqHzPehAkVpMDwD5C9I+Ghfr/unSmH688aygrRiZFlXnQsUlEMtEbahl6Nmz
 xdx5iy6rogoodLuS0lfzr9xDMZy59kji09G9Rd+7X5jdiN++2b4lCBBzJek4iA1AYiQ==
X-Gm-Gg: AYBFou2wwBkakZuowdu0OM1VMmrECQj8HyjTK/zeoH8Ix0AmbpbaSYxCbu12cSlGBnd
 /AC5TdOdkX3i9UySs+fznIzrevYvIfdbMz6oYswsG73x+06uqzryOaXZIEaFFrTd4P19aCoLw53
 ZuLYtNwlJ6u5ExrbZUM1M4CVh9gq9ZwV4EgwblLjp821HH0+5uEkVpUbj68yLAC/1vg5Nflu52h
 g2DK9yTRiiaxTppv19h3g1d1+QFYnBYP3C7x0FAw90Oc23Tic8EpfmCZbgiFX9o6HJVpQsJoYsf
 aAxfJ65Lp4dv5hjMudFt0m00RDDh4cIPbiTmY3ozu8/nrJoXcjJYjxd62rQJEp4709PR0PhEfyY
 BhrOVRVnP5KqMnemPwzP7EpLZFJ2mGWCqKg==
X-Received: by 2002:a05:620a:5eca:b0:938:e95e:9377 with SMTP id
 af79cd13be357-9396e07bbfemr472983085a.30.1788430924869; 
 Thu, 03 Sep 2026 03:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:5eca:b0:938:e95e:9377 with SMTP id
 af79cd13be357-9396e07bbfemr472980285a.30.1788430924444; 
 Thu, 03 Sep 2026 03:22:04 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5e6115sm61830245e9.14.2026.09.03.03.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:22:03 -0700 (PDT)
Message-ID: <21c368df-8ae4-4cb9-b462-8999b425d7f2@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update PhilMD's email address
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260902155211.32399-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260902155211.32399-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX06Sh5NimVXrU
 276ZnoHpPzw+atn2c++O8CvH26lf6F+AglOcELqlAa2XkrjpxUxEKtpGlM0q2T01Tn710RgynWa
 8kuljvbGxBvwokbE4bCHT0Mz3khzFJ6YkN2TCztVb/ZaUHpxglnDvI4Zva52bEOUNQdHM4pE2Ea
 EfzmpUgfWq4ywEA6Ek9PATAo0vIOfnQDcaHO/2v/5RXURTncDOAHsWwIowg2tSHKLERv8gsKv1r
 22XtiRVWDvWcZeAPrndjEwsssEFfcQHJUOymXXpg5O+S+Xi+faKbrtpXpPu26RtXEojB9OQrZMj
 IC7sIbCnk+ldcLMT/bMlWfxRP4XJsuGqBE6BWZdRZneCzKVw6kLMGYYruiChRrfX+ePdNTG0iYN
 tQeoyQ0QF55t0fPnF9KLXAkgknEefYsqVocJ475KV1qySdBIRkQUWo5MXwNpq/aZ4fo5n/KI04J
 zOiDVo6vPj3hllojqSQ==
X-Proofpoint-ORIG-GUID: wZUcI6ukVxdDG-je1LNwIAl3lEXrJoYW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX9xRSmTdBv+xm
 xx/XAfJWc9oNqBQhRfWlRbDIZ3XyG6jodLi+st7QFGhcQlLv+PmdxvYxfLPa7N4TRn3J8FN//Bj
 P+ynTQC8ojbauB9cGZVbVPV7xtBcQTA=
X-Proofpoint-GUID: wZUcI6ukVxdDG-je1LNwIAl3lEXrJoYW
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a994a4d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8 a=hJOeRMHqKWms1flwJc0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030089
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

On 2/9/26 17:52, Philippe Mathieu-DaudÃ© wrote:
> From: Philippe Mathieu-Daudé <philmd@mailo.com>
> 
> My personal email free service doesn't scale with qemu-devel@
> mailing list traffic, returning distinct STMP errors. Dispatch
> to work email instead. Update mailmap accordingly.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@mailo.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   MAINTAINERS | 58 ++++++++++++++++++++++++++---------------------------
>   .mailmap    |  9 +++++----
>   2 files changed, 34 insertions(+), 33 deletions(-)

Patch queued, thanks.

