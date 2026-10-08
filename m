Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5350CCA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvQ5-00070m-8T; Thu, 08 Oct 2026 17:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvQ3-00070R-GL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:12:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvQ1-0001pd-UL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:12:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L040X3648612
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6KoMjdaB1IfUAuDeu2EXCUmwVtcw3SpiiGcoe6HsaGY=; b=FGCnYWQy+MszjoZn
 c/suMROui0zmNrc0ESJHvvWIJhcOZZpXA2kQYvUKppcod1MLguHWWJ7jKNrB7Gww
 Hx8AXdpsGxsG6dHa8H/JKiqLlZCUxt3bvqNN9U+TLfBS5c2x6n0864XQdBd3T/Qp
 p3j1DlJi/aIP71wimMWxHmjoq3wiScM+S2SFZ7y94DCZUlk/UzmV442o4oNE2UlI
 QViNYVqH8cSMtN872P6F/pTeLsiIsS9DxP9K+RLuuWP4kcD76JO2rRT3i5qjcgKa
 bDwc/Yy8vdsyRXvGujS7nwr7gRV81FX8+cNSZfTMJvtdseexA1B2sUkJUYYxKD4O
 n9L1vw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqrr2k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:12:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-149e8e8ad71so2134843c88.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493967; x=1792098767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6KoMjdaB1IfUAuDeu2EXCUmwVtcw3SpiiGcoe6HsaGY=;
 b=dcLhP4o2dD53c4i1owFR/bfYzRpBDu62zvBWCytHjEBwi107tBW+Y91J5epyA97JFt
 yhL9rAjjMT3ekcWEoUIcnG7TsVVG/B0y62kYHC2yuzJplT6foSCVb6/YJurVsxBiFmQF
 VTQcYVmFwcOouUqbY9uWlNm1PFbN29Z3614lQZqiN8/paG0RE/ATIZixhvByCtxxxFq2
 dCF9LpTOCDPf8RLrP7x1ssfWPOowtyi1iEv5aZWScq9OyZ+vbv8YEsI7Evl4Hnqxc+Ds
 /HyX1qgLxotrQ2rXqvE2gGg7BsNW4IekRJY9dHIrBPKCZSk5WEhHhTr4acmR4Ni5oHXz
 3QRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493967; x=1792098767;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6KoMjdaB1IfUAuDeu2EXCUmwVtcw3SpiiGcoe6HsaGY=;
 b=HjfemYy0ELJlkIIDbAD2zajXYDwTHxbiU2AkHjt3QjsEXimvOnnXPtPYrdEPEE6/Zp
 /k2CR3vbeKsQEUVBW520KCYZSktk6YPYN+il9l2pLn573i1WwZD8mC1DoDXqwN35f69L
 SS7iVCSn6joj8suwASgpKJAy7Y0JUFQs+zdfZIWvhidbYkSiNyOwfV2hSWseFAccw3nh
 VlGdqRL4kGvndAPabjAhQzEc8xvkV4LH1e/WyoarpQfDwhKm44NZy0QWv6dUqPfHeF8d
 /YZOH6u9+n8HN/rxzv1F2lr/OvriBy3NEACiSsPzQv0/aE61z4IsXPBfWtCC/7BXLEc+
 JSgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwU5Te1R0UMreawKulOsM7deWyC7NQHH4/kO2Lhws1dj3H3s92E8QCppUF5+BEgayLhAvK/el4gAPml@nongnu.org
X-Gm-Message-State: AFuF++l05JQ8QrTSEDTYJcrX0EGMd+nJeQzBzKgfWKF9bn3naNY5U8xF
 lSBc0tzxUGZOB4QYPp35D+rsTGtNejsaevUbqqHDkWSSIP+r7k1JLMB09AS2Hfro059kSAYFEXv
 ZG6iZUMfdlH2T/S2KHmYMBhNEiOxH0h/E6TE5+pljci5cNqDlbzEAlR17pg==
X-Gm-Gg: AYBFou0XA4d0hyBfRmAhbxKnIWPacUp4GsW9miGkoM3BrJk2rUf494Vh5IBCeQba+jw
 IQCL/GWCy7+qhn+dRwH4MeH8UrPr0EVL788c481xKaXiDc3pZaOxm6ZUOHlgihHikrbVtj5ULMH
 SaWSjlk2ImVcQzEZQ9sB5b8AUA1SzPVtZeaZFL5puGFmUimaE90+mk6xzuhXdEmYYojgOpmxSgu
 F6tDDUpeUAo0dDDpcKvvb6LYVzJfujb8RWGjayDCWANrksR9aIBEZ0mhMJNN5R0/RiJu7hqHPI5
 R8ni8IqEikqrx+ZuYgy3fxdBvSG3nI8zYEfUZiAcIhnt4mhyzC6pI+ZsomOPsCkFvoH6SKuzHVs
 yxlGO+nncy2amNA/qfi0irYYhh1xwkeE142Ia4wlGasreQiU+6ifIMMaAOwyS3e0rBfjehg==
X-Received: by 2002:a05:7022:288:b0:148:80d4:84ac with SMTP id
 a92af1059eb24-16206e0f37bmr7389034c88.29.1791493967094; 
 Thu, 08 Oct 2026 14:12:47 -0700 (PDT)
X-Received: by 2002:a05:7022:288:b0:148:80d4:84ac with SMTP id
 a92af1059eb24-16206e0f37bmr7389008c88.29.1791493966389; 
 Thu, 08 Oct 2026 14:12:46 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442ac67sm1422751c88.18.2026.10.08.14.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 14:12:45 -0700 (PDT)
Message-ID: <8c754bcf-1b57-45be-85e7-0766bf1d13c1@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:12:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/functional/hexagon: add bestwait systest
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
 <20261008211005.1853542-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008211005.1853542-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfXw/WaBUumLj4j
 oy8wmGdnjQT4zEW9X/n2IXunOs009GgB2Ppn/j7NZhewBYvDsnAvNUzrWebBU1ruuVWBfEDBdiA
 TimAf33cdLD9NiyUvnrcCuKwnD8/j5I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX1Chg4DOAcUjW
 BSIVRx79azgZN+d0x0Y+VNgGwd5cQ5xL0RJVaysgP+2Vc7AIG7Gqds0HeCwmGxEZqTCwVw+Qe9G
 TR4LGlu0gQSsKIIuNl3ovsNm0SNzM/j/Dnq7QpsvPhWJ0+/etCYmUscottA5+UtC+wRB7OBiOoD
 3TMUCbQXOXxK7r3Ia+dxXkb6Q39stpd9iLkt9DcsrlLgX9SuuTjHaTouA1XBO+f7ZrEdl0RO7Pb
 TFqz70XoL/yHHqekoXxlUUh1Q3l1FfnM9z10fE6XPFsFSvbYx3tomQ8GlkQlvLOlfMn+0KK+G5L
 noGWzD3oX5xw7sdUopnY70W8BCBNMJGzfJ/b818e9px3OiZfd5XqzZC4tRCrFJ8vI4x0WyE1eCn
 UE1T1Hi5iX+3JYvO/zAHZJy0pjTU/+MPbN7JppVP0X8Jf/HQa4JVJZjXZNXfNyUc1hVCC94oxnO
 7hBnMHVkQ4Ct+I2fPkw==
X-Proofpoint-GUID: 5KywC67YumPdH65wX94BNMH4Ah6ZT4t_
X-Proofpoint-ORIG-GUID: 5KywC67YumPdH65wX94BNMH4Ah6ZT4t_
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac80750 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aOsrUnblktjoKien2y0A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080084
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

On 10/8/2026 2:10 PM, Brian Cain wrote:
> Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_systests.py | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

