Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC96CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcD1-0004QG-5o; Thu, 14 May 2026 15:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNcCz-0004Pu-JU
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:59:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNcCx-0004Hc-Gy
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:59:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpJav4020774
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 959WTuDqfbqBRvaI23mV+vReDmV5/l4Ry2SOwpvN8wY=; b=X6nK7UgB1H6js6Lh
 b0fx5U0rHRf3jhi2Z3dQmLWoDeAHmKQRdMjv3ChJQppDLoCd5W6DP/k7eMw25mFT
 fQTuqfvUnrYMLRbJH7u1KUmja/CieSW+6REjwE8hq60MXsotNJN+YAbxuJ+Ba17x
 alILTr1rKT3jwzyPE3CPc6htzDnMEiqy0HjTVsPTpZUN3VPgDCkYmKlOYwYASm4a
 m58IOYZcN2jaxRrNaqFPlkPiNdTFDRZoA2IEzZXEM3o0wGVrEDHm7fWuZatJouCk
 Em8WpWaUTwx28Z6d2txoC+KB+Pw79+l4tchSyWKXGzr8lsQJnPYnjblzmjul8F7j
 Sf2HJQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1rr76a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:58:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2efc342ef15so11704903eec.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778788737; x=1779393537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=959WTuDqfbqBRvaI23mV+vReDmV5/l4Ry2SOwpvN8wY=;
 b=AEX+cLOI/WMJrUNLXqTZu4DCDAaMvwAJpz4zCrdtOUxDJ16Fl8ozxHyelrP0AB71Ut
 hteoJ/LBuzp6PbjNl6dEFCfeO8f8/SRzr5gdLzJ2ymahCn/7OQBg3Ar3IeD7a4VpizH6
 cG7nSAwtZtn4BQZ+Rec3gooFb2o5QyZ5E3+k8QgsVkpqBVSUy4NEAMnJOuV491QIYV7A
 A7iTLZJ1GiwCVMxqmgf/sX4vuiDn7jg8E+t54MDJfyiEmS3lxPwUKN0YhSi9FuioUSG9
 WSmAO3G3GTx/kXcY77HqdzKrbLD5LWIZZPB5R3uidVYLoviZR9izcn1k6f2+Oh5RYJMi
 m5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788737; x=1779393537;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=959WTuDqfbqBRvaI23mV+vReDmV5/l4Ry2SOwpvN8wY=;
 b=QFzAe0VewRa2atlVfkXOMSNgNchLSQH0eBf3T/EtKUzcID/q+bNcwzFneRVaNp55es
 W2fTd2ItMqwi3FFjYgZe0FhmvIouTtrXD01bClt6dVQTznlzVHaENoHfwVTBQ6bpft/a
 A6kAhfWsoX6x49suqjxM+tjW6iwSGtp9fodfyuHeA8aiT4Zr8GzOPwTPscDA0qcnaJkv
 iMvB02FWz9dxfVKfoOrq5Avg8HF8XhrtOYBtEmEzBwDUnAkvFkppIX+npm8YMzMmXe4K
 02zhOcGxKOoT38CjgHMYUP+Z4RRQjh6PLFxA/iingyvCxZOoAd2umIpoivTiPQ59Yggv
 Fdng==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EQycPfac17rQGv0VqSPdYIIw+5SwgeGhoB4El4vIQe49P7fQ1bFhUoHMB3723QgMclBuNlkGLL13x@nongnu.org
X-Gm-Message-State: AOJu0YwUsWoDZRyTlB5y6IjVwBeq8IqNHWwnMSY/6YHZcY2rCvmch29C
 BKwacoDZnhsmVdfnSbjH6K7lzq8LXLASusXQTOUmhnKpxy8io35DBkP3xGtK/a5A2Oldd4ieXPa
 8GHtN6PBZxClhtBEugASpPOJGbysbYnW4JhL4SexR2XVjjER0zjCz5z3byQ==
X-Gm-Gg: Acq92OGxCbezqwFXhQDx/rjv/C/ogWa8XjhqknaH402tfOwzAjgDoNHKAbb6wIeZCgw
 7hTe0eFPpR8OvLWf0w4e9vKWKYCFxAMbWPuc/zLYDimAVBIWdruDgi1jdtlh/eFH4/oHHRJJUfM
 LsngsD7ksAeYYLnEb2G7f+u8r8qvGut3mU6otI4ILm3DB/2jsAhrDIwRBm9KvoRkwfuvjkZ+0G2
 9jsDezQ1F7+dxo94C7VJkd0h0GMVOLNTdrnMV6tt34TTYU5JgEapCzT3CJw8MK08eneoli7puit
 SvYEDofwjN4vi2e4p3O25mj22bt4wW47G0AmhUrlgVszFd0MPYcr0MKIuC+st1LNRJnf/blk15L
 FvAmCFR7o2WK+NR+ma/tVtkECLOofel9loT/qVsabSC7mhPFZ2ZOMxhDvTie08suXnZQrvLubUf
 yIltLU4HgzJ7NV8w==
X-Received: by 2002:a05:7301:678d:b0:2f2:5726:db31 with SMTP id
 5a478bee46e88-303986c518fmr451207eec.35.1778788736684; 
 Thu, 14 May 2026 12:58:56 -0700 (PDT)
X-Received: by 2002:a05:7301:678d:b0:2f2:5726:db31 with SMTP id
 5a478bee46e88-303986c518fmr451188eec.35.1778788736099; 
 Thu, 14 May 2026 12:58:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30290c4a699sm4354061eec.0.2026.05.14.12.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 12:58:55 -0700 (PDT)
Message-ID: <786b3f79-f21e-4e64-9620-8f3ddf6f07cb@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:58:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Fix formatting of `Error **`
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260513-error-v1-1-49fa04bc5c22@9elements.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260513-error-v1-1-49fa04bc5c22@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XgY4Zb64oANwcCOLw8FGpsx2pbGJ7cDw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX8ww7zpGZBdbK
 f/M/pl1cTOIKb8hP2hD9GZ8NE/Hdd5zhXqrwXEBTC8DENyo9iwb1vYO3JD3lrYVl/VUspYBNPZn
 f7J+CR6qmUqU+V3sPBut2o15d70QH41Zi6FhHMSO0yz1jOtcd0ZJGzfWqLDahBj9UX1UygbdIpU
 SMsG8S1avv993bb3VatOxvUCqxKdPZzfvm+2quW5ANonooQSg9lK08Q/UUart+aJHlZx0mXZqcN
 pbDXRUlUU+SlrxMvo9o+TWqbdW71Y8Diwkn1el0QogF797V91Ek6j5sG1IEU8Jr3V068kM+7Tek
 G/akmhZag8rsbiMyxL9Jk7LyKG5K1VKK5PHIbW1oMyVk1fFBsbAXctfriZnEw7e6uCr+2Dvpz8O
 KqXjx8y0KxL6DXXfENDS732kpv7n89tSVO354TDnzxiLWKIEluoTgVwk5If2e2t2a7Uic2TewnL
 uWhkhi7Sx4EJPKNAcwQ==
X-Proofpoint-ORIG-GUID: XgY4Zb64oANwcCOLw8FGpsx2pbGJ7cDw
X-Authority-Analysis: v=2.4 cv=JPELdcKb c=1 sm=1 tr=0 ts=6a062981 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=PzGKxP3WAAAA:8 a=J7s-eodBJmQGiyBaidAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140197
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

On 5/13/2026 8:06 AM, J. Neuschäfer wrote:
> Since the ReST conversion, Error ** is expressed as Error ``*````*``, which is
> rendered in HTML as Error *````*. Fix it so the HTML output resembles the
> intended C syntax.
> 
> Fixes: 336a7451e8 ("docs: convert README, CODING_STYLE and HACKING to RST syntax")
> Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
> ---
>  docs/devel/style.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 12e509d10de0b8c044c8429aaaee8855bde1deb5..b8edcf9316f059fe15415543098118b28fcaf99c 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -784,10 +784,10 @@ error, non-negative / -errno, non-null / null, or Error objects.
>  Example: when a function returns a non-null pointer on success, and it
>  can fail only in one way (as far as the caller is concerned), returning
>  null on failure is just fine, and certainly simpler and a lot easier on
> -the eyes than propagating an Error object through an Error ``*````*`` parameter.
> +the eyes than propagating an Error object through an ``Error **`` parameter.
>  
>  Example: when a function's callers need to report details on failure
> -only the function really knows, use Error ``*````*``, and set suitable errors.
> +only the function really knows, use ``Error **``, and set suitable errors.
>  
>  Do not report an error to the user when you're also returning an error
>  for somebody else to handle.  Leave the reporting to the place that
> 
> ---
> base-commit: 45cad8beca3ad75ebe63a36fdc60c98395fd2df1
> change-id: 20260513-error-674f87f0d381
> 
> Best regards,

This was merged into master (edcc429e9e41a8e0e415dcdab6aa52ad17ef8889).
Thank you for your contribution!

Regards,
Pierrick

