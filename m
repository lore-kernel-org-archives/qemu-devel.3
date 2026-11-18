Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93BD606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPH08TJn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GW0Xwe8q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThW5-0002TC-Vv; Wed, 18 Nov 2026 10:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xThVx-0002So-3i
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:24:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xThVv-0007Sr-Df
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:24:00 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIDQarU2227024
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 15:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XSEe1Ld4Nkrv9GsOsCmqAYN8nrndhfr4pGMHAJlzmgs=; b=LPH08TJnVTGNXD+Q
 6xYU7jSHQ+OYofliu9Ev6SBcRpzr1qWkPa1fJgX0tZaMLWNzdiDeFjdfAormH3uF
 j0bdhI43qgZqn2VdYnPmTl0nYLqo4SQxCUiD1RLLiQQgAMSTD7YAPAiOv8i52fAR
 1+klBRfY68+AhVu4Hhgc5F8gZqYAjp1Lhxg/Cgm0kWSAFtjjfLyH/Sd4xma3eEp2
 xZs6dzz8bnzDl5Zf+udVy2+det9ic8hrasILaasmL3g4/dS3TBb+EccRuwq5EajY
 XwpvvishIe3LeXLL4yuVPmURQUxEXPsroydaUFEgK/rVvFtLK4rlbZU50Ka4t83f
 HkBYmw==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvbbndf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 15:23:56 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67935d0ddcdso1612165d50.3
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795015436; x=1795620236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XSEe1Ld4Nkrv9GsOsCmqAYN8nrndhfr4pGMHAJlzmgs=;
 b=GW0Xwe8qtBkjGOPP06bePSFALDCGICJUwEAZLybEAKCKv9DJieML42P5Go2rPviutq
 +9GBCqEInpkh4okOESJP15L5if6gM3OMjMTIabgHLUd3GMql8NiVNkCEhJwy3RLl5N/k
 XK7gbvy7dgg+utizqqMgkiqx+Bw38LREwpJ3TWSLDB5KE/YDxsnw9MuwOXCuVVRXrUvr
 WSLW/8JmRl2F22FntwmnwmH1SO3BtrWPnEismHAGpc8nU85jToOT4ojOK/TXRaymndGB
 4ajtthROT+YIPJBiHOcmQRB4UdOLFsHkRflpdwNPIO6YPMg7BQqRW5oMNMLavtg/mtnr
 xHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015436; x=1795620236;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XSEe1Ld4Nkrv9GsOsCmqAYN8nrndhfr4pGMHAJlzmgs=;
 b=xqbpOurEsP2v36vtlVN2EESdK9uTo0uIipUIElM19srAnTX+uyNXy/kCcRa/8+r6hY
 9eIqrLTPvgcdz33QZZnRACVHrnOkJQVxYwndJZJWW3FmGxoJU+LAGVneOjlW7lGninJp
 LBNgUATuW2LnRNjQgcd7hCyIKnd2UD9TCb31YzOQw+8Av0QCwo5ZyISz/lOWyCpSFgLv
 TsA32J5B0GmH48UVsP2LgbJ/Vja1gmAm0RCKwLisbqb0PPHujy61pEiKn1UxkwKrp8jE
 i7tgdQ/2485M0BDKzvunCG7IWOrZMyHJhVNQm1+Q0CaDaN/tAWJWQJPcU+HJwP5Akw1c
 DOCQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHd8yTXeqAMHNJNry5akpFAoYxhcwJwmr6MqV7QptTWnf5622aI5EctxMGV0eVbnyvqUN5OSdvkffK5@nongnu.org
X-Gm-Message-State: APuU4Z+FMYP4KB4D4cUQTOYuM8Y9YlaoeBYXqe1BlBA3W00zYKxrgDh0
 U3CT/tVfluQRN0TD6djVwfHsNTouFR7J9e3RcEhh9m0sJOPUnB0q3HcKhVm+4usaMKnQudJ8MdC
 FU/Zmf6TKiC48BQTEPAsjCpoLaEaAAToj1A0WmXbMk1SCguO0lOEtnU0HwQ==
X-Gm-Gg: AZFdTZcnUVOMHS56hhCoP4xV1YSAy49I4vgyH3cOLtx5iuC1wtrmXaxFbNVGbyNY4Os
 5onC7sVCR2Cst+ohU6vQqarbYC/GOzbvqqILcDCsWTbtGOwLgO5p776N0TvDMN+mIDayx/ZQBqF
 WstwYZqgmsD7bm6yPRAeE26OsPKvy6HzMpNgF8vYjHQxQrQhXS8y2T38QUOsN54NKT2+5+QMajs
 pmMLFvzNyaOEywWiUuJ0OijrqCBWEIwNRtvKNDATxRRjvp9pOJ2tydFWNlwPjr7t/T/dv1onoT0
 9xQrZX5eOlLz7N5X9RehyZzbf3LRgGwV/RLPw1kJ6HS3IAFyBAl5EvTa1EUhsF/r1HcuRQAWY/O
 EYci3ugpwuiuN8zHt6h8AgpB/oQ4WCh/H8TvHxdN1dBZgymXIPHJvU6SchdXSRzIqfERPdKuYlU
 nxE/04cbj4tImEEdh9AMyXahaPoRylkDamQXSBJhuVlA69haN2LQh8
X-Received: by 2002:a05:690e:1919:b0:67d:b425:fb83 with SMTP id
 956f58d0204a3-67dd3f19605mr1650549d50.33.1795015435671; 
 Wed, 18 Nov 2026 07:23:55 -0800 (PST)
X-Received: by 2002:a05:690e:1919:b0:67d:b425:fb83 with SMTP id
 956f58d0204a3-67dd3f19605mr1650538d50.33.1795015435147; 
 Wed, 18 Nov 2026 07:23:55 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67dd58d34ddsm1722813d50.23.2026.11.18.07.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 07:23:54 -0800 (PST)
Message-ID: <c07e26e3-59eb-4d6c-afec-7a9e88ef2a26@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 09:23:52 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: Explicitly pass GP to helpers
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, marco.liebel@oss.qualcomm.com
References: <20261118144441.27680-1-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261118144441.27680-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MswpU3S0aeu64YJ3r-D5ZbF7Um--yFL9
X-Proofpoint-ORIG-GUID: MswpU3S0aeu64YJ3r-D5ZbF7Um--yFL9
X-Authority-Analysis: v=2.4 cv=YfgodARf c=1 sm=1 tr=0 ts=6afdc30c cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=GOa7KxdIESDIDE5jI4gA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX2JFK9aYXU9Ie
 Jnl7bOmvdux3VtYMlpHjjxyueTu83XOFlPXaZ1P+7Q8bDP5C4IyLE0EvT37hhLv235nhk7lhIvK
 Yeyago70xE8znD/UedOujn7C0YdeWVk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX5+CCJdLX5+UF
 gA5GXkTXG27Oiur9bg/7BYJy9u9+D/9DPbdK8i7yUADJqZ70269aUW3I6FEbyto3yTOqfrm7NC7
 f/1DqoY/kD0zeTzB6bFjSNygyrWJevCjZ24bfzX1lXAd/QHtrSEePzbpbs1OGr40vvup9jm1eHV
 Sx4Ai3Utb3n1J0FIH2F//3J285UllotLSon9KnI4vWthpIuZBJ9CMEh1v+LqHrZF+QKUNTwmtcv
 dJDFN9WpX4Jw89HElxo0jHC6ea46160RXSQTiQfFEbRPqObgywG+mFIACUz0tYTPiM3Z4saNyTC
 eIBNGriYZkS0OPDNS01VnEnivEec63sqQoGmDtX1w0UlAS3B4WOhxf4z53IOp7TO+Q3pfimIhpJ
 IVRLKeH+MNuWa7n7xp8LNzgE2bvcsOjJtUlz7vH9KjuQC9kc0FYMU0qPyxGUHi+hMaSzq/CQJ9I
 kqoLd4In4i8Nl1jq9mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180061
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/18/2026 8:44 AM, Anton Johansson wrote:
> helpers using fREAD_GP() are broken and do not account for the presence
> of extenders which change the addressing mode from GP-relative to
> absolute.  Explicitly pass GP to helpers and check for expanders at the
> call-site.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hexagon/macros.h          |  8 +-------
>   target/hexagon/attribs_def.h.inc |  1 +
>   target/hexagon/hex_common.py     | 11 +++++++++++
>   3 files changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



