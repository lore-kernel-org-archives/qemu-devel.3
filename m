Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3CAC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CY0-0003l0-Ge; Mon, 14 Sep 2026 15:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CXy-0003g0-Bb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:40:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CXw-0005oB-MS
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:40:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYekW262649
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gekX0pgBrFj4NJupdS28CW16HVt5MruRRAHg9V7FFvw=; b=ZQ0XgF+ylbCxpJhh
 YuQW9U/h2OPgXLUNsZKj4w4GnKxOycS+5j0T1fNBPB5IMnRiiWnLu/nk3loW4h4O
 96n97/XHoXCgLrT3FGhpmckMwYHxVikY+GqhcybruZjiVKK+RA7dRAs1pLe2vj3V
 m7yQTSf+D+rfDkuO2twirp0cOycX0hKawoQ0kC3WPOT5zeSeZrRU2bPJUU0I3xYE
 PAkDQ80EgW2IIWWls0my+U270wHETT0wJwEpnJyKTJ4ReSTtuaUsPhs8/2b+4ld5
 7wxDJKIW3wDs/p2B66nH9dPlqS0baXgSNoEscZQ5FnxCvRNkGAEGaRcCOFNJtqjm
 F0xdPw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpergab8d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:40:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-86a2639398cso5810585b3a.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789414854; x=1790019654; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gekX0pgBrFj4NJupdS28CW16HVt5MruRRAHg9V7FFvw=;
 b=K6FjRGyE7I4ls6iZM47dn3Jd5MKbNN9w2mHE52+y5sQcXsW9Y4grWc4ZSAs9QwLdup
 ztaQvBKjN4C89KJsWTWTIWLsP1BTwGU/25oHDxHiW7Z+vSoPgwavFSrqUKMm3ijWljjh
 VtIOg5aFowW0BDXzw9cJAP6Qzfunf8vv6SkTQWdx3+46uMWJR3CcV8BMS2sxwjyoO4PE
 kVfqlZFJwL9UxegWqO3qZ+YYGo1DuuPT+qntbGpTEc7L8NMfmyqq/6IZXkQmUdnSepZm
 yoYsbCMdCu7u4sKiVyBOkdSgAOJ4sUrYdWAwfADUit525uAoNoZrt/j01JS0aA3zW67n
 jiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789414854; x=1790019654;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gekX0pgBrFj4NJupdS28CW16HVt5MruRRAHg9V7FFvw=;
 b=oJfOImQG8lRflT20a24g4OE6wQePJIamJiBQ6DcMhD2BrBzjuvvmkpRPM/4g1g9T/6
 BUasYhsCgIPTvt/zcmo/6NdVASg05Ee4CmmCbwB+dU84O7fCvxngMwtMvS+US2BSvemP
 SF/zSOEjtLcL2EK2rxzs9jhU3+/a/P4sifbrLpBPNxfOygcw5sIECl+KtIZ9+meQ1uMW
 Z+sjsKPD2sEy0U7A+vsUZp+1y0nW5oxzP5fMj6v9gYMzacNAIjugKinQ2fxXUW5gW7Sc
 IAaUwypBcnWxqQy6MhvnphrhnWTnbDbVZBUjZ5EUl7TbxH4HOaWNCS4NhcUU3lK2017Q
 x0xw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxloRWzOp8TxGtasd4bpg5smSwojuIOsMDKBJ1mcQ3ehyqElhEBcXDr8CCdoPTYMs4nKyCzqczZdsww@nongnu.org
X-Gm-Message-State: AFuF++lY+G49UoeEp4gewpY1RqNYTee1Kp6HRXDxeOBcFC99EApF0nny
 lG9pzX3PCSAyasrFKQH1anAaAR2mhQZnMsVGUAEEVeHxaU5ldUlv5KLbKvRygZ897l/fwy+KtVT
 4urLcWiU7M/AAaWBy9mveolD8K4XQ0GhA8oAyiDoinbZXWSe5El+knFjPjA==
X-Gm-Gg: AYBFou2/CautxfP2VAVx4vZDP6qX1AfYNFLuTZx2GZLwgkpLJ3BQDn9OixZnA7dOiPm
 kWMkoLNGsA8/2JGMKAeeSkD4e1Yg6t7dkYwPrw6HFBdgdWD4k7Mt3C/48gyGS/g112zMTh2Nnwe
 Lnp+fa6SgEZ5mwXmgeZX4OZTNsShKsQ/0b/PHeKixGpRsss9wsQDdsXoWuk7V4Yp1NPGhs6Wetb
 7k7A1fkNnuwj/6kFPbXkeo6Ni71aWoi+ZcDY304oFQiHF5FJ6anGC7xDZTrgJ/Xy0SjG4ngdZLx
 RXdM4h6ZOPsphVJrY5ko85HfqogdfleBpcwSGTnhdpIxpszSwauke37d0Cn45iIqWJKwlvdMBcP
 BkcIQ5+JbzVxWP5do+hXVSCX1kTNu/6m2aiiv+1exyze7ETMUuYetFulzYa5QI5G4UX1F
X-Received: by 2002:a05:6a21:6012:b0:3d2:2011:d184 with SMTP id
 adf61e73a8af0-3db4061ed38mr10139099637.14.1789414854212; 
 Mon, 14 Sep 2026 12:40:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:6012:b0:3d2:2011:d184 with SMTP id
 adf61e73a8af0-3db4061ed38mr10139030637.14.1789414853811; 
 Mon, 14 Sep 2026 12:40:53 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ee07f2sm25364206eec.18.2026.09.14.12.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:40:53 -0700 (PDT)
Message-ID: <8cc632e7-a077-435b-8b0c-9452398b5ea7@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:40:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] tests/tcg/hexagon: check the two HVX predicate
 build paths agree
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260905195955.2001304-1-brian.cain@oss.qualcomm.com>
 <20260905195955.2001304-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905195955.2001304-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa84dc7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=9mi-9uxVX9xl3ZHO2CsA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: y3Isuu6GLFDc1IIukYl7y-vz-_pO7Iop
X-Proofpoint-ORIG-GUID: y3Isuu6GLFDc1IIukYl7y-vz-_pO7Iop
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI4MCBTYWx0ZWRfX18bEOq2Baf4r
 Rs4y4v/7RP0ElUiWnWupQjcAehRKKd+Pn34TKUJyTN7o3tYrn0+rVaLkf3I7EqEZvGFQ4TJI6KS
 Flc+mbbUovLfwZjb4ugzik1UCAdnit+7wX4BagdSoMXWEzrOEnwk1KlPSzI7h2UU6wKkg7kba5/
 ptV49DtutLGxhFFBWr4x7/iu7hvUhV+zfElDSX8SOQw2fA4+QrLfRGzacHEZS1HoOd9Qq4Hy0+y
 5ZcyqwkIkp0tkW3rCcoKn+SkmGBidqFcdvFSLvu5K6VHQem9QL7f6+lVE8TTcys+HmsXp/SA/Cn
 G6flbfRY8D7Rx9FguD6seSGaPqUJZOsrLAEm2cXYGrf5M0oEm0JAmQgleVFm6x/eDkYrcPsi8AN
 BkYlBpyq4X1Qccwa7gvAqaONScdsUl4ygGjfPE9ihI7SaNhWt/CT3FBhCoLB2COZOvPf8qKOb4G
 t0ar0sFRNvZoJjoFkTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI4MCBTYWx0ZWRfXzj7nj0NQVKmK
 6Wk8dnRXJvtSL4tZ3pDiQZO72m53I5xnu+QLBhEsU6rNskb7Fc76fJzkwJWDYFMxkEac/3nR1Qs
 aNlWIKEQK7vBZhDc8VD3gR7Qqu+d+Wo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140280
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

On 9/5/2026 12:59 PM, Brian Cain wrote:
> A Q reg can be built by a vector compare or by vand(Vu, Rt), and
> those reach the predicate register through independent code paths. Check
> that both select the same byte lanes, so a byte-order mistake in either
> one is caught.
> 
> The input alternates every eight lanes: a flatter pattern
> stays unchanged when predicate bytes are permuted and hides the bug.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hvx_misc.c | 45 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

