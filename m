Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692B0C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ndu-0007Co-N1; Wed, 02 Sep 2026 12:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1ndq-0007Bb-5G
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:16:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1ndo-0003fX-JP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:16:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FZUQ8770128
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 16:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z17DfiTuPOdKtRUZkNrKdlfUPUrgkrqMOtwxyQdQcTo=; b=ocW4YhPeoMO3XfAP
 9k4mIuVszEsWNAnZrfBkapRUBcqFO560vmhJBJsdP8/QiUwOHoOfUqexpmWvrFcI
 7vYfd/1PYN4vp+Hwp1cSNrzQulxm1dtkGPqs4xJvJ0gdHjMjQGSyD++a/th58auO
 m7Fc3ZZJyiA/GPdIKeVdadTwZ9OUDvh4mnKhxVfH1wkVhQVIHAhVNfDTuT6LaPCK
 L8pq6GpMH2HAwbSHNiZN3r3xlOuet8kkVe+7yRRGgWGPxPyzyDbAF4ZoykspXPqd
 q5y49WUFbPJliN16/EaJ+OfshDmS/KmTSZlpS9V75zv2eC3WO+Ps7YKs1S4Cu5Fv
 wy5Gnw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemja0pkv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 16:16:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39af92138f9so52896a91.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788365806; x=1788970606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z17DfiTuPOdKtRUZkNrKdlfUPUrgkrqMOtwxyQdQcTo=;
 b=RRru3TfCitQNCuL5axan/adu/6ul4KTCOJ+EvCk8IydXbOFVRLCpE0O4Gkee/HqckP
 O7KjobRAnumw+LYEKBzyLU057VC+e67zOXmJ01osxfKJR7jgM7S4sFqyaoc6OM2vMMLP
 ZWhwL6BR0wMh6Avx6NLInS6D1jMhXKZIuG22CTwCJf5/WYXoc4sYfzFQHM/3LTUkUyjk
 YpVNAdqH9bNPBawC5cCn5+4ok6OCSw1eIDsvyn6n/KYz7EgK3NFfspF5v5GBZfqI6BGO
 0rAwRSSP7byAXcMx63Q7CCxw6OqRxqBuOOfhbZOcErmCTyAC3MUVfy6iB0jL0IG4GUKX
 9kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788365806; x=1788970606;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z17DfiTuPOdKtRUZkNrKdlfUPUrgkrqMOtwxyQdQcTo=;
 b=YC0yAXL8qKB84btEYjkxJl7P1xR0cAaefkHUP38rdd6IV2DGlnUEPaj84V0bjdagzh
 yBD+Ycs84c5u0uYWi12uBgIq03mHzU0wljXj0c2YzCWU94HtpeCs1Ab9IPC/oVike7gK
 HwCdLK1lxc//C53cnUfaZUF6Rlhw/Z1Smjicp8zErvrkk/D6yl8COR9Toz/Xaq+CNEmu
 +0UyX3ZBWMHmgEpCdVgfk8SPXjmQZRXK68ak+0IaWgV7v9AyuvEgthwDu9Aj3i+zalWJ
 SZkfzFXvxA2hPHX4tFrBqfI9yHGuBdYDsewNf1K3ScN4hqxQDjgB/QziIH8lcSekb/bA
 pQag==
X-Forwarded-Encrypted: i=1;
 AKwUvByDrWSpZP07Ai5eUIXxJHreu1mT8jnJ+4Uny/IzA5OQ7N7dJeq/5Pe0eyxCGGQYPt2HG0bUk7SBSaIv@nongnu.org
X-Gm-Message-State: AFuF++lfbb/JdSSzkXcR/THz+bhvhwhWLKgmANVHT+ORHriH2jBOMRQN
 qH5wqeWBqjfuO6Xb2hUL1+6jpm93BGtcJdkyx/bnOsYdG/BUArjF74ExvLtN4o4fpZ0QndEtEFW
 aloLcLLXvdjnvIwjKQAh1TwN2RzQYtx1MDB5klOquzNAXEL+a1y1AxbqcEw==
X-Gm-Gg: AYBFou1Tecb46Nn7TXA4NQccyfT/xnZWN1yUV3FIF+T0e9A2nWoB1sb97ATDgPOYxlp
 z/aDJlJrOLseiiSG3lJDOeLM0N7WxWUNr2Im6DQ6D5NHOc2GI6FPLrwV5jM9zYMKMFUrh2Vqo1C
 p81qbbasbmDAZLj8oVvTKcz/QqesJM/K/QAWvCG8UHlB9K7dyxMXpgvH4DBWDX7J0Al1XVJ1y45
 ceadYb+5Ok0DhtTeCgh4JGnBKE0/Q6eUAkhkevZxLSKsM1Q/lybVI82MKpfgfHvKa37Jz81KeXD
 b3wZ6GlweFUwdkWQN7KemjJL36DP/NCOMUKNdFTvURyvB6viZtJvJ9YCgumk/SLAzHzMVOj3qVz
 W8b02oHwcMMTB+i5urjXxtlZcu0A2s/TlqXmHWpVe3VAwYnXtzT0Yua37xa8xZgl1k7SS
X-Received: by 2002:a17:90b:4c4e:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-39b07fe9dd8mr304257a91.8.1788365801524; 
 Wed, 02 Sep 2026 09:16:41 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4e:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-39b07fe9dd8mr304205a91.8.1788365800976; 
 Wed, 02 Sep 2026 09:16:40 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07b7a175sm8344492eec.17.2026.09.02.09.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 09:16:40 -0700 (PDT)
Message-ID: <4a989789-026b-4ec5-9c4f-4eacd8e510f2@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 09:16:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Stop reviewing meson-related patches
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260902155105.32165-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260902155105.32165-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UD9dfWF9-9sIoHtiF9uVfJkRw5v8TCGa
X-Authority-Analysis: v=2.4 cv=FeAHAp+6 c=1 sm=1 tr=0 ts=6a984bef cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8 a=2WPgOG2EWknFsmhYPfgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX9heVBEcOcPOD
 L1ftp1iBbKF89nAgP15M3cvKPsRdBG4A09UcjmEgEFP9Q5hpmmFc37QUIkRFxg7GHsrRyWexIYu
 kdkbHx3Z3rFcaPKbIiFDwIxIx4Tb05c=
X-Proofpoint-ORIG-GUID: UD9dfWF9-9sIoHtiF9uVfJkRw5v8TCGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfXz8F3aGkCjHm5
 ASGtCWhE+hFxSugWIToa4NYilHuElEB5X5iXPXoPXUOFSy4gmMsO3ncgPCmmP+BloPiz0sZAGkx
 ZnMpvGcoIDaAWsBk78+3l8/QRF1+o9mghQ6ThQ3va9JayqJBZkKh/SDrxPFLp2otgNGILWOI/Yv
 Q+41gVf4yPkARzqHWnBvDBYNh5KgQGzQrlgtR/C8M9FDelezpdTOzU1jN9+mcNALlwiY9scAi7i
 05T+ZyDUWNrr3nYoln21TYOg7VoGFrG9+WHDiaxoZBBf4IYqCAPmTn+4gi+PGG9VMNkH48zYAYz
 MqZ53TGs5TRvs2+YA0swLnrMsAt8+OK79onEjRA0J9f7CXmMrO0fBUKqst5rt7Srrj+BYdBqhMl
 npCmSnpbSVCCtVws0vgY4z4YRb/cOtiqlZNaaXLnuXyZCIZV8FNwdIql94gYlLPdE+jyUhVLqs8
 FgN3WMW/fvNvIZfdXKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020143
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

On 9/2/2026 8:51 AM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@mailo.com>
> 
> With retrospective to commit 48fad83ff49 ("MAINTAINERS: add
> entries for the key build bits") I think I only wanted to be
> listed in the "Top Level Makefile and configure", not the
> meson one (I'm not following meson changes closely enough).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@mailo.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

