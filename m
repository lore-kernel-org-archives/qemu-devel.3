Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568B8C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwwHv-0007lV-Ve; Thu, 20 Aug 2026 02:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwwHt-0007kY-SJ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:30:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwwHs-0005Ph-5x
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:30:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K5ojN3938950
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C+iNJL3J7hXMzEquVa/kCQrf6tygzppehNfrUE5Cd1E=; b=YyqRDkAEnNNjAq0l
 UW2VYGJnnf5RDbm1TPaUjlXHlBvas5tLMCSF9EVZEN+3VFPLBBlfYQ6GfWQBeeB/
 bsYgblSAWH/teKzE884GbbCfjOAmFdUD41/NZJrFeKcJUkLelxnEneoKwBLt5y+q
 R2NRe0V53wSHKxYzb4qtYr6Mxev+X3easMEe3SlqVXrI8cw6XPTlE1BmQKJPaIlP
 gOgYJWcoOHBIBFAmEp8hhzWDnv7BdYCHq3i2Anc9ijy5IFkivl6lTQhNHtXhw2d7
 3cgSrQNHQSpeqp2eh3qc9/dO+JYZ02jqDwdo8HVrT9N6CQczN6PyLkla8CZ91a2O
 6zFZRA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e5d3pes-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:30:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so194379785a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 23:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787207401; x=1787812201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C+iNJL3J7hXMzEquVa/kCQrf6tygzppehNfrUE5Cd1E=;
 b=LSoa/iMToewqqzvCZoPlb8F4jX9kBaXuqNzcGsjIHtrrn2wC3Fzc2cSMImvedrVc87
 +vIygK0K8N/SDGXWuLAnzfSNWZY3waFGj9w7ZI4EmhLyfIl9QNm5SsSzN6+PhMLWTlHw
 mqmYrBYXrP8IBH6ncVFPAFaCrV/nj0N5qJExjlVPalKkNHk+Nry81ksIEFwD4V1GvQp+
 j8tNedKqtdoH5n1Z6eC8rFQ4ZW2vhB0Ax4ChHJwo6EQZIstDaBwFf2DXKTBReXIpQuYu
 3db5Ma4MSpfVNpUSzvrqI9k+kw9vlQqm6NKmy/bGQmHddPfy7DTG6rQ/VEFMgqp1u0NJ
 0i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787207401; x=1787812201;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C+iNJL3J7hXMzEquVa/kCQrf6tygzppehNfrUE5Cd1E=;
 b=dDUPog60cpVMKizTBGZjZRZj9IbpJqmn9lA1+g2e+couphjc+z8GqzRlqQxo66ZZ8k
 zW+4TaNK3w8pzFKYs6XpWB8fAV4yH1RNMynQMSaPDzxJWpQ0TBcg9FB+j6eeHah5jiEn
 X8eS8VcMOVmvzOjL24vLJTwVZHFX29r0NqCPktyEDyZLFAjQWQGvQS4mi0omsWAmbbTb
 VshU+Dt5CfkLgltoso0d9tys8wjEgfkHjGSB/dSYLLxVlXns4TGUM3kUfXOP/FoFmElV
 tiKYv7JqhKqLQT6AcJZprLBHLfNLXxDtc54xkO8FR6Uev7ykUsQLVRZ0/O9kSbD5KM8p
 zZAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq22s3jSLisGzFa+mmNV57CyGfFQX6CUWvcyyduLgXqaoXXV9ntB7MdRHS6lzEZaDqg8FQF4hOoqGGR@nongnu.org
X-Gm-Message-State: AOJu0Yy/YA/FNRm0zaYpaZHbnYu858BJImxeflP8sd/b4BnYqdMOOx8y
 ReoSkN6UzAGQbmA8lyvNMlcFPSAbCih8CevQ3Ke7U7bqi6QVBrAK1TPE3FXbHdEA5ks6NEaB8jn
 rZwKLndIDXstZIcieroZpi8zqjmgwVkZi/fvdVBfMk9Q3vuQkxrPpSOx9Dg==
X-Gm-Gg: AR+sD12iBuUn5MfUtqYOBDUEwqKE2SdtRa5b4AoaYDgqn72Sb6eF7ID2/9UlXp2vFRy
 G95kACgX1zCesBoRPha0zPIbUUB2lmQWhuvd+rjwZtNrA8w82ik8jXUxCZFxcEw7uMvwIZOYk8S
 Y0fvOd5FvqKfKy3rH+j46qrVBSCRkBLijLVh0iBSUToAsHTo/7+C/3IW74vqPhxASmuMyAL39SF
 r+0lhUDyma8KWRAiKC+zKiSSc4euKH04ZWP/k5HkISKKX+ZycBEB4V9cm5EcQKI+COQBdLBMGuD
 rmpMym5fHHEWzFgwjed3Z04KAaYNu6DVOLnyEsgxcLz5GQC440upugnltXslT7KbOTY4noYcGGb
 aUQ4vnQ0tJ+6GFvu2q27SOwJ7CYlmE0lW5/p4UkvO
X-Received: by 2002:a05:620a:438f:b0:936:826e:5ab7 with SMTP id
 af79cd13be357-9371e67741fmr993901085a.45.1787207400854; 
 Wed, 19 Aug 2026 23:30:00 -0700 (PDT)
X-Received: by 2002:a05:620a:438f:b0:936:826e:5ab7 with SMTP id
 af79cd13be357-9371e67741fmr993898385a.45.1787207400477; 
 Wed, 19 Aug 2026 23:30:00 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450fb9sm10525263f8f.14.2026.08.19.23.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 23:29:59 -0700 (PDT)
Message-ID: <a4adc2fb-22c7-4d94-83d7-09c44843e8d0@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 08:29:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] machine: Remove 32bit limitation on ram size
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-10-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818172012.3052821-10-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0NSBTYWx0ZWRfX7BR03xCyB7f3
 jJA5ik6J/29gieeV5wwCFfPO1dEoVmMeZjfqu2fH2a+BWncOnty7+7taLE5yJgY3b5T4MKG2YiL
 sQbaVKA8zQpvBxdGsmsmr/4XO01PYmx2L4GL89GUYexmUJU0pLyahOevielOA02PAAz2BfrOylD
 KCTmGe95fao0bqraUAO1eVjdiziOj9h5lG4AaLp8VgHeMzRh2GM8AGFw4TT6Pia4/mES8UKsVfT
 PSVvOJSnQc7y+y2Na2rR2zWebzFmJnk7SO/z+T3jfFvGtYUV7w9ylnEPYEVlIG6/02WWifayDCD
 HH5YKElrKUwshnZv//j8hiHAUMMOehTt0gJ7ww7MSbBwoFro8Q4ngGgkQK3ZIczwgscC+f7iZPn
 FTRkykxo9GbvT4xjFRYDlNJIgzunnA9jLTh4otWHZ7H3s9BDAcHkB4A5T2SkMkAJ8DH17Orx4pV
 zsQxFXcOJai8kDKuS0A==
X-Authority-Analysis: v=2.4 cv=cuOrVV4i c=1 sm=1 tr=0 ts=6a869ee9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vcWMPyHOcWkA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: VO5pgETmOtazDeivhHL1FYDhwuJMvITZ
X-Proofpoint-GUID: VO5pgETmOtazDeivhHL1FYDhwuJMvITZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0NSBTYWx0ZWRfX5c4shK7uVAhL
 7I/MTkIsn4ha83UFv6Q/8cUfQdvNt0BzA7q2SvWz4mHW0vhMt7dvWuX+dxaHLF3RrZmBfPm7Q4/
 eR5xUUNt09seemkJKpl2rhph+jXldIk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200045
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

On 18/8/26 19:20, Peter Xu wrote:
> QEMU has switched to 64bit-only hosts for all system/user emulations.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/core/machine.c | 8 --------
>   1 file changed, 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

