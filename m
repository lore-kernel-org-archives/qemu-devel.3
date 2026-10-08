Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B55ECA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEt9r-0008PT-3f; Thu, 08 Oct 2026 14:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEt9i-0008NF-5i
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:47:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEt9g-0005Ny-Kn
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:47:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HpDkC3559855
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 18:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jmNdlDytNt/UhnBnOqTRT6D+CaQ39cayIHHJ+rTXFWI=; b=aVnYr+OKQGXmbfT9
 Son6ozOKkwyNmyR6GXxfX4UQhFUKrdEOHgcSfpSj8islz/YF3Tciu660EE4UuXJW
 4/mqzOpCFFOpKJvxzMwdjKdoMgjYWFwS2pwjpb93iTIwD+FmbFzP+qefVUbSdoLI
 LLCX8TZ5Q+yyCC51dcJx1qjlTYOmE20zjKW9bV9ffe0EVnUMQbpOG4MLH4xqEOs+
 bf8JFyRQ/ubCSznHp5sELFu7U99m0GHFNv8+v2pDrnQ6WRdcSAlNGD+zJEPToQf9
 lYQrwCBoCCQpvVuZiJdsd9o9Zl6STCSCoxDQGBTjAlqeXMl2LyZ9nMV0QZl0hUUr
 4wmKhg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk86me-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 18:47:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3aaee1fc104so1847688a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791485266; x=1792090066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jmNdlDytNt/UhnBnOqTRT6D+CaQ39cayIHHJ+rTXFWI=;
 b=a8WWUFsq6HqnlnsVpF3fPJurwGGbWEv39hrfH9kopNRDYnFnCPbQfTN2ceZtgOYIdp
 f26kznSy54Si7HnzlDa3lyo/D18cbdr63hFIlfzucH1hK6WKgDb715a483vrK0TvVu6X
 xPtkZMGYS6L3sB5/v3XfUM5ZzCZcCTPJ/jQttc85dIudnK8EDyzdYOGRLztVmG14rl5m
 wNd3JaGKsIPJEfQhK6lOfD+eBxcFLBUpsbIsRXhkq6X4Mu1kndEVWu/4M6PVaHT3aQyO
 G1iY+evS2IFEbdEvVsvlQBKYQTjwX3HGLRfrplAvmx1OXO+843Xdxr+TCugnV5+EITa5
 3kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791485266; x=1792090066;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jmNdlDytNt/UhnBnOqTRT6D+CaQ39cayIHHJ+rTXFWI=;
 b=Gqwa3p+l9AAWarH9h45wOO2kf09PiRLFP7uJT1bbMMYKj9Ay3f4GjoyCiVI2pzulB4
 iV3Uvi/ycyUsMBfe6wZCsXqUp8zeSL8XAOfK60PsXlBnyG3Bvh+1SK4VPLc9TridCQEn
 wRrOdNmVUNEvcEWpco0J9uRSY5w0uAQi5JzKg5Ng63pXG8YSasf7ySZDewGlIhLTb9xc
 71u28NHUAqIwkyLWWKVzmIVcD8biLzb0ECt43m1QwDFQbeSqfjWjaOCQQCRl6hfgBxnG
 PELkR5Q6cLlRxDTpJufeOlSsVCPMNNsjkn10qz/3Mk9dMzkOmksUkEAlKoDL7lKKMY5w
 i2fA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYLbhMOqTMmSbLZhXRoOqg7/yL4MrVNol1nIm+AEap98J23FaI3o7wOH+IijniBPCgVrHJUYVNc7Wx@nongnu.org
X-Gm-Message-State: AFq9FYL/3aMUQMolK2qGWA7G/ArErX/ZTtOJRDVvWEJwBDMLyN6HZm48
 MtyJXgS0pGeElfrBIeV1oQhvSb8aaTaJ7h/0eR+n+CLUUrr7BIiWjpgcP61pXJy8TG9Z1h1VmcK
 kqnqCnItDAfSXu606Q7WUbaom1OxBRUbYho/7/WoPCNBR2/TmPoC8zFmlZA==
X-Gm-Gg: AYBFou0j2VzfYJo4J5I1sYzTzUsRF7rJybHrc9oqdpm4oadPAJJYU8hz8IhQ6R2PexG
 qKcVchrFYzJWHCCpqpLiZKqy0Y7BGLejBTw4ek4x5HMsBLAM9gtTevhWptI9D1Rx/EN+6ka8lD5
 /Kk9s1vwH6oKHPJJSET6G2DMsEwMBdDmSB4RYkyTP7zGXlRxa9wP/x9KCEq6O7AdQO28r1aUiPi
 PM+akCPj8xsc9qO8jBpe0+6HQfxa9xTif9EARFhkJgQ6fZQD0GN/J7nvR+p91oBLVbk9Thf97hS
 75N9peOvhEK2RFpjzbbgY7ahAO3f0Kj0UqYPkYiPI56MzP5i5SZd3u2IO/BeY2F6w4ZstgNMyIG
 C6EFrYFivQKwasreC27FN7tvSzngmNGvqo7vpqyFM4wZE2nN7renYnC0lf8RypOUUTfaoBA==
X-Received: by 2002:a17:90b:4fc1:b0:3a0:a781:2c39 with SMTP id
 98e67ed59e1d1-3a89f649e0fmr5933644a91.7.1791485265595; 
 Thu, 08 Oct 2026 11:47:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc1:b0:3a0:a781:2c39 with SMTP id
 98e67ed59e1d1-3a89f649e0fmr5933631a91.7.1791485265119; 
 Thu, 08 Oct 2026 11:47:45 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab36900087sm27637a91.0.2026.10.08.11.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 11:47:44 -0700 (PDT)
Message-ID: <54989b88-48bf-4107-b090-6e489c1a27e5@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:47:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/qtest: fix PXE test build on MinGW
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20261008184119.142-1-luoyonggang@gmail.com>
 <20261008184119.142-2-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008184119.142-2-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lRWdMph1Rb7AVGMCvEBLf1dU7k--3_Iv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfXzwcC9/xajJRF
 6sUW2Tgq0EKJYF1+H/NB4nPzNIz9q+FiWkaCbo5KiHwoAYppYFxIdjl6l+5yrv+IpBzjZqUFN2s
 D4b1aRQM8I3SrgKbF7G2K03kzeb6K+U=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac7e552 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=cTrbg54ipO0WN4xYSJsA:9 a=QEXdDO2ut3YA:10
 a=0lgtpPvCYYIA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfX5SlOQhEaIWy7
 Z7nyjWZSK/J8QjL5VljuE2n9Kgl6zV7a6woxpdP34pfcyTROIuagch4H9gbKXomoX69ziGmBR+I
 3CphNaPfetWhgZgDM3fjxe13piih4kUvPij0qJXMX/WXY7z2KotePkw+lIP/G+WhZRdKS9ADV9e
 aclvwEh1zWZ3YNYpOF63QU1SEfK6u19RUbxI6ClbnpGD1igwFriJWQ8OROVYVAEHjVWqh23v6dW
 oRov0Z24B6D3DzoXJhkvDzwnps5yHZlBYKJUqAckksWLtpbD0nN3bzCJEWI9N7ieAPu6xAtwLxa
 Mblz7CZIoqJ3ied0jkLNmfPvci8zYenP4tGbJ9eT3HFYy/kIBuB+gMOpXqotpgdTBZUg6+PelYg
 YEuKu6DfcfAlb8eAji7dLjhF4INnADMObr1pR6KCSJ7BeoGmLyWr89sJnETvXl1P8Y3bHXvgluD
 2Rh7gAArOgmWe5RYeww==
X-Proofpoint-ORIG-GUID: lRWdMph1Rb7AVGMCvEBLf1dU7k--3_Iv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080074
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

On 10/8/2026 11:41 AM, Yonggang Luo wrote:
> Replace the GNU-specific memmem() call with a bounded memcmp()
> search. Preserve binary BIOS scanning across embedded NUL bytes
> without relying on a function unavailable on MinGW.
>

It is available in MinGW, but unavailable in UCRT (Microsoft C library).
That's why the build fails only on msys2 for ucrt/clang64/clangarm64 env
but still compiles on mingw env.

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/qtest/pxe-test.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Implementation and fix are correct.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

