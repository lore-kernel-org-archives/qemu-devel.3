Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B331DC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZuG-0001pp-5X; Tue, 28 Jul 2026 00:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZuD-0001kP-DF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:59:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZuB-0003fW-Uw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:59:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S40w471594311
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +jSJ733Yz6/6B6IFs1j7vt3i5RuRvZNLh9JkN3PXBMM=; b=GPsK+zf9W5wZaEWz
 QiDqBp15hj5F8CKqPuWjcyYdA/+psOJaWAVvNVImdyoMdSsgm05Q6IvjOxdupB9R
 Y5VudwvwYff+N62c+ukseOdpZ4VTyXIW+qt7vG0Akz1qxnLO90RTA93z21/lAQfu
 k0sxb0ZvdcL9Y1bm0K2Fi2Am7ebYlU8nnzNMCoIkPv0d0W4vJ/UeM3LM1PMB45JQ
 kuuHGOqIb5sPP7TJOpRpRQrzD5EjHbZiG65dictbbTXdvMheWHy3iuKtsBrjrvUI
 04VQ+cMs9m+AxAPTcep3krL8qH9wg4/utgXKsEJ/V103RuEPair8kQcMFpm6j6ZT
 YXyEZg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19g5sd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:59:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb835525b10so3976906a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214741; x=1785819541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+jSJ733Yz6/6B6IFs1j7vt3i5RuRvZNLh9JkN3PXBMM=;
 b=ai7aBp6geMyLdoSowFtyX5WdhMqLpE7o5fUhbD5dAuqKWWBghQXWEFOrYwPPZOhx+P
 5J7eMNHGvdWT18qVYrS9ujqXyjyJ/kuYv6LCj69j+sbGk5146brvQNF9kn8+LZaIcpnZ
 0GLu1GtatpNMoW9zKIXarc7TIXKyPYCr0zi/zswqpgNkkRPH1LOOBkUOWbUHyKl0Fv5a
 7Llj6h6DN4KocsXpPlojf9WIaDW3mFJhhZYeQEYEU1B+pFeiahgI4cWighHYXXPoKw0H
 t3sdkxXhg0AiLDkIruXdGTgXMOTjWQOV69rM1HOmgnu0TVp19Ok5wneJCzzV6/AB8BJa
 bV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214741; x=1785819541;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+jSJ733Yz6/6B6IFs1j7vt3i5RuRvZNLh9JkN3PXBMM=;
 b=l8blFv1RC128yOgmIFD/sf6LZl2to1RszT5tCuPIo9s+3kA9kp2eUqAhvM1sZ9RDwq
 1bXBeeU4FjPP3p8TqvuzPi6gsXS2MKkPoriVEAN+pBCyPfA/fv5VPP4TOGTS/MTGEp4p
 h+z6yHDtQaPD6lV/xr6T/Frd7qUZL8hgI7vzd0icFtavVQQVFQnhk5c1ZV3l7qJAGooy
 /iRCvE4kmF7709+pA0NpoipFdT1cVv0EZUJKzZ530HNfTMQaj/sdAtU7AMtc71srQSaP
 2UP5rGuDwIqHg+LAAaw3/rahspmyn0nqkOVasZhrs7Zxd/g7TIOSWXAvSLlrLXsUNveK
 uD5g==
X-Gm-Message-State: AOJu0YwWME6OFj7ysoyadYodhLawDDcKtqfwJL7RgqfjlgVP0Ju0U8h9
 f/fRk6GVn6IjsNs0JLzsy6On0/38trjz4DFCYlSjtEedsP4o1RNW8IcxVFws4R0HPgK6crIMlex
 Jgfx7YJ8BthT0u/8Qi2xXYL2cD2U2UMvrfLF8oW8OPyhXGNcZU0w48Y0/LeunYvgrPQ==
X-Gm-Gg: AR+sD12UvrsM6gLpW3878TZFJn6IClsR7+9tNwh9hKJ27Fvok3dAaF0cmVfG08HSRO8
 SW0lmcm3FSb/Cyu9iQhjKU28l3SwdbKT0n7TWoC6UfIyE28k3cj2+2dftBr1BrYwc9k9sMNmW1i
 tbnKp5xncqZ/dZkdpDRlK3+p/xhSNwh4uiIjpgXbDHDMdShhQWyCA9NqYNlQ5WyN1+xu/y0NmCk
 2cTZay3eI9Hd+ovk+MITh0kNTwkhI6LQQSPSQ7+MqP1njs/BxI1FaI01AQ37UY6Dop3mwYYtCPx
 GCccOpgU63Zg6YPb3hWZydUYhCTWSJLtHpb1dYJCT3KvSg+tI6Oa+k/MXQwHBT+Lq/rRc88SlO+
 o/L0YoID7EYQnlh+y5n4Vw0prBhAoBlTPSZaUFHCKWmJs1dVYePUOFU68EONUzn09MUqb
X-Received: by 2002:a05:6a21:698:b0:3bf:6c08:fb88 with SMTP id
 adf61e73a8af0-3c8ba5ecb4bmr1176581637.56.1785214740768; 
 Mon, 27 Jul 2026 21:59:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:698:b0:3bf:6c08:fb88 with SMTP id
 adf61e73a8af0-3c8ba5ecb4bmr1176561637.56.1785214740386; 
 Mon, 27 Jul 2026 21:59:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc593b57sm56200275eec.25.2026.07.27.21.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 21:58:59 -0700 (PDT)
Message-ID: <02bde797-6c3c-4c3f-aa82-121e20360866@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:58:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 000/103] tests/tcg: run tests with meson
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a683715 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=MXFxoGB2ntcCvti3uHUA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MyBTYWx0ZWRfX8FP1ME7agtk+
 r7vvfljTSA7fdi6oi/9SNEwWpQ/FMmh0paLv/82Nfv/0FQDIDYz6Zc9I/C9KVAqmePVxAIdlYAm
 ix1srpAHznGYjbo7Xr6TZ5B7RGYcByF71Ee5oUstI54RJ5KhbdMRfSd8LL7ie2HCZS063FYCsoz
 SS3ArxkS18+nzAI0NqrrrTb42vhYaSfNuOvNG9dXbiSP8tEIu/ODot9n6Mg/5t+8zQVAUwvEy0b
 bo3ercWbBKLHUagRjU0YnnWQvQDNRIr89Opfu1xRg+/eHeVa/8hjYaPPfMVw/o0pzTTuX9n/M2c
 sFvxbOzX2Xr+dzW7fLrnJtf8KuH6Ymhcfiz/Oj4Odx2YhQg6EfHf+JrHm8a/QB0omUNRvqetL5y
 m4japy7dz2oEiq1XjNu8YgEwZsy7MdkMmbFXIteI9WQntf9fmbUKC+WoRnxuHYp/LCmu0drm72X
 2T5D8D3CKDor1gqTqNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MyBTYWx0ZWRfX01KALNeYQnjQ
 4+kgRCqyzZX6QaIpv+4m0ehRVnHFGsvCiOGfS9obuvbzjxbzR6XVax950RIPkzQbc2pU1d8wSwd
 Ur42n9a/5wNHa1XbbGH7zLlPk7GZr7M=
X-Proofpoint-GUID: jKWKqHzXG2NIhxTZaawibNcEvnuHoC6e
X-Proofpoint-ORIG-GUID: jKWKqHzXG2NIhxTZaawibNcEvnuHoC6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280043
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

On 7/27/2026 9:41 PM, Pierrick Bouvier wrote:
> This series replaces TCG tests makefiles with meson, with the
> goal of having something more readable and maintainable in the long term.
> Also it closes the gap that tcg tests had with the rest of tests, by integrating
> them with meson directly.
>

General patches still needing for review:
- 4
- 29
- 96-103 (new patches for configure + makefile removal)

Also, most of arch files still need review. If you maintain one of these
archs, you can take a look as the series is now almost ready and there
should not be any significant syntax changes, so it's safe to spend your
time on it.

Thanks,
Pierrick

