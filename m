Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC67C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 09:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvX29-0007zJ-LT; Sun, 16 Aug 2026 05:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvX23-0007yB-Ho
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:19:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvX22-0002Y8-5q
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:19:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67G72DiI2810821
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0WLiFdEY2G2U983r8gPuwMkxWRCW1NfILks5kWK0wUs=; b=pK5JedONye/tCjhZ
 I8ZNdlx91UPIirz7w0ywy7Ig9FaQoiDMaGkcfhmE1mKyke5WuGQrU0WfqHBL8cxZ
 MYSF2p3OzvwseFqyVn4ay+VXW2hX3sNKpm07B8ivEy2dUuwvIZr3nuNCl6pBmF2E
 1fAtEmYlWsuS8t00XTFmGReknCr+futP9yrLTrDN+/JYe3D7vikO1zGLvzk6CJdQ
 NoTtQpx2a/BwEqVepLeTa+GmHXUTwcxruW6B5lYORlPJzDmfrKichlPmB6940A8E
 ZTQNcGgUqpc6Y8XkdzlmTJPHhyNBX1Cj8DBhV6jN8qF59hMurSdRYrEWcXqoLjOu
 1g3QTw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghek799-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:19:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso30665831cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786871987; x=1787476787; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0WLiFdEY2G2U983r8gPuwMkxWRCW1NfILks5kWK0wUs=;
 b=MYQjRsP6meH1ixJkg6QYnFDUESnaj7mWVXEy65uKOnTKJbi4AEik3cifcxeVFNERUP
 fvChK6Q8s7emLnlrkFdVZrADHw/jeHfGVBCmV12bOGsP+kNhz3zJcZnQZLct1rEDPUSv
 HJOjjdj5dDH9Ax74/7SLUbIBrE7PUznXkEwt7BRqMBHn9llvDzaHd5vmxEkjLrp+3hnY
 5blwwQ7xcP8dNaJnHgZQK2udvESoAQeLHX+cPu+F7TKXjTELNNJ/3LMeUIINoInT1KFE
 fTWGZ3+K06suOgNlH4SR6L/a07SDyfTpmxGZgF06PCzbf4v+nwwN54uWsQuS8YRIKGrz
 wEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786871987; x=1787476787;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0WLiFdEY2G2U983r8gPuwMkxWRCW1NfILks5kWK0wUs=;
 b=Dc4ZGoKZ6t4cF3FN1DsAEmBz3Cjiq+Ja0SbKGXFc1/fHJsS1nAb8McBQKGMH8l8lLm
 yrjXZ9f9wGESYLzg9UXQDjMYs8v7CtSQaJM0glvoAEepGCgdciCzpW37Nt4eeofQdHnz
 AIjWy6UDIe6XO67gjqRD6POM8c3nGodq3HEw1wqb/f5SozMHHpEymxlaMfxHiKda4gRU
 02rWVLZTePLxCLTOK/PWwN8UFPO1/nSa96LcpthZKFxV54NpFwAj9MfUNtHmdA3NUIPG
 HFUoyJUmamm1FDp4cXlxM3NMy4d8WTRqZhxsvuMpIu8TjkCpU6eV9nKkTCv5L0SOOKgF
 C7/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXM6Wacwl0YVKSO/fUIyF4iYNNOa+OKN6UGiLkO4cUneVzOBRo7W+iBQOxRdXa+MGuKBHsUVsshaz5@nongnu.org
X-Gm-Message-State: AOJu0YyEuAJTSAUBYHmhZ9InQ21xpcX7csy/M/AUS27EjJGGm05Ke1fT
 TLCmIWIk7thiHi0zYvajVhHsgtzBPSmpRzo0eukQ/TOaFze9YX+rFxnep/YCByUDXsOt9okzlGq
 QCgddcXGwZM4lb7cHS546v9KR5j6u/Vz2u2klBxb3/i2sv+3UiUCOe5Pqbw==
X-Gm-Gg: AR+sD11I0Fj7jLL2wctgQBOw/9ngb3++ypFW8+vQWP++818ABfP2EMeGdzwyHeeTvkl
 CXEohoRMMcbTCQBbjVVyTA5G1jv0ff7UMUriVOEJiQ7LJjvF3rEA7abeZWmkP0uabfzOtB7FDNx
 mGwg6uRjeC50LR9Iyr7yTi6fxOYzHkOq3J4oTHaJZFJjVXe12X2kU6ySUC2Xn34nrFAJArprKw0
 JdmCtZe715P06LCeOL7xVzh+0MW7cUAyr1Ww/Ocd/7m4ujI61C4bB3ljVSWSMD2aQKVy3rykfYh
 ESsGIZpE4rt9ElaADG5ot6LhlEXG4NrqZFrbZPD7HBqJ0oBxQUuort8L0Z36YrZseK4YeYsEqdh
 s/qLJgZA4NTA3wCoF6HtuHTn2cSCn4+9DOUg=
X-Received: by 2002:ac8:59cc:0:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-52d85477a33mr185610471cf.29.1786871987414; 
 Sun, 16 Aug 2026 02:19:47 -0700 (PDT)
X-Received: by 2002:ac8:59cc:0:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-52d85477a33mr185610271cf.29.1786871986979; 
 Sun, 16 Aug 2026 02:19:46 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm163596095e9.3.2026.08.16.02.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 02:19:46 -0700 (PDT)
Message-ID: <591ca5d4-1c35-4f54-af97-2269907509df@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 11:19:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/18] accel/tcg: Replace size with first/last in
 probe_access_internal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260815203730.1468365-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a8180b8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA2OSBTYWx0ZWRfX6kReseYIo5PZ
 BE1UcyPHQXNSjV+WdGtScEYpu4iZCqMq/VJTMdNxk0R0Jrk4NU6K0qSzEAfSxlwX7JMOAdmTe0o
 eXIYyBixcbBV1m38JgLSp2DvtHPokT0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2OSBTYWx0ZWRfX8qjCCs9Gtj/d
 s2IYgjtBl2af4pQssq++YGR+6tEQ543XeDnKsIH0OEiZPkKlok61TBBUvDpS9TGLuTlpZf+mGcf
 KftCr/cH7HNusKAS7K3KN0jhl5fbYL0TpL07kn4pTll4Q0gpCRNKZOsIlhEgS3xG0mSvVaABWIO
 BZcGkplwBQZgOlDC2LeIxnHdIEP93IyXg3bsyRqnVOGIXjZEjhgxZC3Q7VlupSJ6a3P+hDlDhvw
 iPKqrOp2p/cNZVmtxrQzuO19lBz30h4S+H7SKf8Wh0JwWxF1QGICwlYUz8LKl1AhmQrNeqhQDb7
 8slH03AMJun/qrajaYTp6w9DwD2UagmE64aO/dVme2z/81ZF5tJnwiZ0LE3OkPRB6PgiNjEGfs8
 asqymsjaxNgp9cxSJ6B56DyqJpV91l3dDKSeC/XBg32izLxNJPnMZ4Pkd1XqJVoU919cmg/Dry0
 1u4l9RncPD1+7DH+4qA==
X-Proofpoint-GUID: t06KwP8W5FsNSf4CVlxbXr-7Xy1rWsSu
X-Proofpoint-ORIG-GUID: t06KwP8W5FsNSf4CVlxbXr-7Xy1rWsSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 15/8/26 22:37, Richard Henderson wrote:
> Propagate the API change down one step further within cputlb.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 37 ++++++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

