Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3482606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PrWu5okd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jbxBrBI2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIv1k-0003Qv-7B; Mon, 19 Oct 2026 17:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv1g-0003PY-E4
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:36:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv1d-0007AT-Ht
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:36:10 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZg9r2457971
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ojzWTNzGcyBT0+o9cpzbvyEUSaNNWG+aV2dGwGOqWTI=; b=PrWu5okdC3LEqHrI
 mxlKiqIklStqq//gsJ7+JLB46NeAZcz+pngEoB1tujKdX6uHwgBQBHEk1p4pMCSY
 /f2HxK6uRReTwgrrnoqfox9DEaRha3/72iXlFHQ5IZ8lNYvU6Nb+tsWvfSnbKs7N
 5vK27YUvTL3QOsAhyBHJl4xW0XHFiZA3IG8bPbbfb6Xu178eL5WEMg6QLXnLW+j6
 qLPJtS7ly2tw6X7ipQe0VMSQy4cnfMimnnK0B47Epwnz+AWMtCnuPEyoujKkUlHa
 JdvHIlHNHpta3s57OMNRXpLWSskPXcgookN/DHpISEp8BRP1y9ZEa1bxQgOyEGxC
 FpUPSg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65kc3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:36:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3580c07911eso7431335eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445767; x=1793050567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ojzWTNzGcyBT0+o9cpzbvyEUSaNNWG+aV2dGwGOqWTI=;
 b=jbxBrBI2IJsNgJ6rTcGgm5oJJnGXMxn8N7IkAvIpmLHPdDc4S+lp+WFpwH7Il7CjZf
 6xvGlmcQJezPCWMud/eD8DPau5AXwY33p+NahUCRqlWX5tfr/w4LeWSrERj7w459tWhT
 ryp6F4xHiqrpA+L2FYcd8xXuO1ILhjd89DvKvVeyLqHS5FAMuXhDiqOeZJSAiIOS4lVr
 nRmyI8XFsoSl5556B4I3tXxPWIm8ZwIFQEqMHJITLkH5w1pA8xRYa92dqDhVDXB1d5ng
 2vGLssTjosExMvPD4tnPsbO7nRPTEU0VGZ9ZvY3RZSqjs7ayGdo34NalMHvS6UjwyrRa
 pkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445767; x=1793050567;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ojzWTNzGcyBT0+o9cpzbvyEUSaNNWG+aV2dGwGOqWTI=;
 b=ZjtcAjYh3JorEVgataeyoFOtvaq52BJYic5KlpjJepspy/yWE/8TBYvwyRWDiYLmPl
 csoS0E8l8VGbHV4SV9QTUDgX9WNi34rIDBxyZ6cMt9vu/l4J9KWfCvGM3c8B6r/hCf6h
 bs+IaDtbD+9iqb+txnoItjhEGfZTRFYbeU8l9DyjCa1moGxer/nR34ymUQlyUWGYE0yH
 0ib25WiymB9f5Dpc60qsrkaWfVkskKb4vWeclKRyKCAm2B/rhMEulfDWb3HbJGrtrNZy
 sllLCN5IWumIYLztwrE1y+XQrYx5hNa731pIkPgtS0ihElj7Bpla3ynpFQoW7DC/4Qi/
 4iUw==
X-Forwarded-Encrypted: i=1;
 AKwUvByKCjjMUa1DbeEvEgHYsuSLG7DWByjbL2fAekmYnCzbpzlFVcLZ4PhhRlYsv9Su8KA0RSPN1lv/GyW3@nongnu.org
X-Gm-Message-State: AFq9FYJ1oYX14ga05ygLxqmn9vMxX9TAVafASU5stjQEF+lBSuyugwoo
 6G0ZhUO+GwTIttwzW7ybYvnf7fR46A4NCR8RbHopDJM0co54HWIQlARWH6AEkzhSnTga2sBOtrN
 8GewJFh9KGvB+K7KZtioPMalLpNIo7kz5JyuQA6ZulUrYEugc6wxpbO+EgA==
X-Gm-Gg: AYBFou2lGdMf8me2WqZhn2TQo7kB011X1FtWCcPuqpKHAMxjW/eckVBg3zGHIguI8I5
 j5CM8ALYup/ti0kFXTSH0ZNdqrut2ziXIPJwXzQeNWD2E/+meCz3qY7ciXdLaMIttOEethbfjOB
 ixvxT0YauV+h2jpBkWGvy8tnZzuw1SzoMXMQOU+9WS8uyIJvnw2dJAtlC9anamlFHTwtLkNDI/u
 uPAk2MN58voYdFps5v81eLffYlhqMP60MlvWDGtcRjmHMI2NuTnA8fUqVQpJVG2zFiAAcibulHO
 pJPl9HNLCqbxG0EZBYynIcbtJ7vQZizd63GMg65duYFTjzZVUd6dSXqDQDFASb83onmHZbrASHI
 NTHS76rsA3PHTGgKaMsI2HdKEZQuzmQSX/3fLN4CVh9GzoL1SBQIhgPY6Ri9OH9x1/7aEyA==
X-Received: by 2002:a05:7300:8a9a:b0:35e:e454:da28 with SMTP id
 5a478bee46e88-361a1862ed3mr13864512eec.16.1792445767342; 
 Mon, 19 Oct 2026 14:36:07 -0700 (PDT)
X-Received: by 2002:a05:7300:8a9a:b0:35e:e454:da28 with SMTP id
 5a478bee46e88-361a1862ed3mr13864442eec.16.1792445766678; 
 Mon, 19 Oct 2026 14:36:06 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360826875b3sm36656157eec.21.2026.10.19.14.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:36:06 -0700 (PDT)
Message-ID: <5f985341-30fe-4ece-be8a-5a7490dcc8a9@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:36:05 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/hexagon: check exception_index in has_work
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
 <20261019060911.1479329-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019060911.1479329-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX7RK3hpTepR1O
 TvfqvbhlH0vclLaVobB8ViWAPPxVbRYCm6b/Zre5QSohXyRg5cAs+mwglGm0l4ujmGnEPK60Qnb
 9zNFC762j2AgEc8UY3n6fzwGE9n688w=
X-Proofpoint-ORIG-GUID: 3snzBzkh0TwsJRkWr67GlzqEOUhfUYLF
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad68d48 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=l4hZ_LkZzU3di9V1deEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX8jArcN18Iim6
 r0ZI0Ox2X0BmRiqkt66v6Nlk7KdlARrTjk4RHyr8R8R9KFKhV60rfGRg7uYjw8QeATx8cSCoA7w
 Ajf/xPU35vnrQA+bAJWkN0YE8Qwe9xmoEe3FV1ssPmwDHolQnPnHw2t5P9Q4aN7VI4ZJh4A1PnL
 yXrZEQGIF4jwDyrWBiuPzxspSklksZTLlIv6plvt2P4AT/peYRvIk8/D7oFDk9+PG4+z03cVNIw
 J1asGnV9pogEBoSwn+kjgjqIHbTvJRwe9/v261zQudR8yhZ94bYJN4k6azI1dpuHE1ueuW5GOjZ
 oT++E8mLH6j0WVO0FfEW+EesJWyYe0sU7953W2SUZB6HegR/XUkXtMs8zExOVJ2Ybf8Go8jxSdx
 5KXgPfWX7nD7LKLH5IN+L37dNKHRYUOHoHbH0H9um0s3HGlyXftOOH/TuZ8mFK1SO+CpYEjA2v1
 zSekVcP5AVfpOOuzhPw==
X-Proofpoint-GUID: 3snzBzkh0TwsJRkWr67GlzqEOUhfUYLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
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

On 10/18/2026 11:09 PM, Brian Cain wrote:
> Without this check, a halted thread that gets an NMI while
> its modectl E-bit is still set won't wake if no interrupt_request bits
> happen to be pending.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

