Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDD6CA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEux9-0005Z1-GG; Thu, 08 Oct 2026 16:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEux7-0005YY-Kb
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 16:42:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEux5-0007hj-Uf
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 16:42:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HVPp52080317
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 20:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cO0NZ5p/MiqyvnFy6K9moHbqSiBZwH7BTkxd3MUGUiU=; b=I/NKpD7cGBs+nVPz
 QwhCsKd354HGFY6i1naAoQ31+PrgBcuprc4odtkcW7jNo0SVXVhu43UiVjWzdjVO
 NV/sat75qVUyldGPe0CDelXqmLPyT772SAssdSzYM0aJqIHNLB7onhbq292FQzld
 O/Z5FFG3Jgq9CS6AAqpL1jeQDza/Y8b0Tj3OPC+HHhfz7CJalaTdl9+C7dGq27ki
 3Aykq+oJMw4G4IMmgPocJQ8/PQ3JkpIMBvZ6kKUdsq7jKMtnrtk5rUH+WV3zeKql
 F/TVl31Zopam//hIM9z4zQi2tiPyv7RRHDta3/5r/TDE+0ZJofYgD9B9GFgyY0cG
 7VfwaQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ev58vbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 20:42:53 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-917a7c17166so124943416d6.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791492172; x=1792096972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cO0NZ5p/MiqyvnFy6K9moHbqSiBZwH7BTkxd3MUGUiU=;
 b=AZ/XNlMDbZ2vR1AeIBpUBXYNc+p/KThga16hzThq/b87G1kAIcRZpGGaXljlqzBjKn
 Qs2HD9lbtfyzqJfXnYxc7A0Jf7z7HRoFYucAdRhcX3+5JMQtYYMYQH6z65YO4V2PSY93
 0/YPP7yGBkOJTbZl9xs6I2/0d8PL5KkYWqsTYvBvzWg7MuOoiAbcjuLI4dtyqYkqguyw
 YJMsXOGdZstkALM3+Dc1riFH+8nBFZCZnfcnXTjB7/AUatBdSAIW9hoMh1EWcwjnEqVh
 Umw7KcPUVvdlcZ/BVEI9N5Be3Iqb2ImKaEfXbG0oXJhGttLqCwLkAIkD0dz6MeKEeblN
 LWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791492172; x=1792096972;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cO0NZ5p/MiqyvnFy6K9moHbqSiBZwH7BTkxd3MUGUiU=;
 b=IkBqBxWYl7htnUcg5tpGyyL1qFD3KNbIfhglieUsdHRiLCKqHxfjW8tUIYP0cX2HWB
 vzmLzbOrEukzyx39IMXvMljkPgxbe5kZLFv3dg3Y+B3D46HyH+zqot72QQ7YXTfCGKgt
 puhA9SH/mFUOjjp4BppsowWcffYk5daO3m4zN/JrA8pnf6NF2UvNuZGNnpfeHTC93OD0
 UVplIcCBZLjHbr0bbaXnlScKkEh7iWIhkZCd1W1thwOgSmCWZ4XBuB3JFJyArxHbqqkW
 VkcVEDFBBNZpZCS8+W1etf+AMTEoDm+qoS55BGjFT3YnvELxiAzKWRFl5rmJbHbluhMf
 w+gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw64/UPoFq9/uejZqP9/nu5qZg7qpHCE7m+Ww4UkjzWo1FQBUWFWtCugkeEHUI5ieCId1x6XLvl+B9u@nongnu.org
X-Gm-Message-State: AFuF++kvBnXVsLJUkL0HZwJezSRC203wBjok7Il1kLmWX3IPFsJIQMQC
 unkbfeR2w7mbPNiKUSetahOG0SqOrpB5FixiuxaMLbdcdsx6KjNFRwBI71WtVJ0M02ISCkCru29
 cRLW/qvEI5cNo/7Pf2fJt4vc4pkMFqC+G+5kpY7Yib9y5rIsnJb9u114R3Q==
X-Gm-Gg: AYBFou3Kac1UqJyRrh1JurwKqEarYe43LMITfVGWR9ujltxEeUmLZhTCBTm0SFMyiWl
 MRiy0nbBPF/TzFbvp2yUccNU+A3wXEPXk+Rrb5lDOfPXBpUotjBYyj32Q3tsTb5j1wQHZYk9S/6
 8p58JA9Th+Q8pD1Tux4rCan8EwLeamVoCnJIIyNzFIWnOkK/MinYb6TMPcrm+BwzbLdj6NxoW5G
 1LgdzUlosZFQN/eICLXxTJn1Vt8MUuQn1uWk34/u8K/luM3Rwf36NFgvxwD4CxuxQwohGl21H5w
 Ytgz9Ll+NgEnz15Dc2EPfh55sVxJuJAxuVsSHeDZITFzUGtE9iXsR0dA00uEMSwHuASG64ZXHiE
 oeTXFvZgvKPkmfm4zQyXm90zyM4tisQCy4A==
X-Received: by 2002:a05:620a:439a:b0:93e:942f:b8b1 with SMTP id
 af79cd13be357-93eb96f7542mr51915885a.64.1791492172098; 
 Thu, 08 Oct 2026 13:42:52 -0700 (PDT)
X-Received: by 2002:a05:620a:439a:b0:93e:942f:b8b1 with SMTP id
 af79cd13be357-93eb96f7542mr51912185a.64.1791492171508; 
 Thu, 08 Oct 2026 13:42:51 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf214a1sm7945165e9.7.2026.10.08.13.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 13:42:50 -0700 (PDT)
Message-ID: <d3931ccb-bf0b-4ddf-9c9c-0df36bfbcf30@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 22:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gitlab-ci: enable slirp in the Windows cross-build
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20261008184119.142-1-luoyonggang@gmail.com>
 <20261008184119.142-3-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261008184119.142-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4MiBTYWx0ZWRfX9ufkiaNDe462
 duSI6dq4Uqp3ZLFHlimYUitsck8M3pe0OGdd1DuwFNrP2UJFZ3c2GAu7bq9WVnELogqSXDi0IM0
 i5FTKDDQT3tcwxrvl9/Zn7rDkw9+j/8=
X-Authority-Analysis: v=2.4 cv=MMT1C8Zl c=1 sm=1 tr=0 ts=6ac8004d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: pRIfXvIUjsgGLNmEwAQ7U8jGctcgDbU2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4MiBTYWx0ZWRfX69t8O9ZkrZFo
 bmy/kxh2C9jHxnzlRb0zvW0tUUJellFKXPzC3T0Ksb2iu5gw1SAWnPQZaopoa+mxdeNrkvsylMg
 dwMVuuO0ZYStQYS2+UPL/K0mWnXXsGiECE0xGT5GYzZ0+9WJMPlDAimgX5TlhjUt/rmzdU0TPIg
 tRLvFrmZAoSgqB+A40Nv4t2mncZYULeE6HNYwqwHXDl1OXR2n+XQmaXbOXOSxOCM3mwHA5+bDPc
 jl+gLUcE7nCu/5v70klxd435Xwwue6MYOGz2FFPqVuHF6kc9YjCehKo61Wmq3jICFV1eLNaBAbc
 2zphA5OWxjAOhQ+k34Iz3pAlJligt6KiNn5NdBObWozYVwd8JKo4J8D9hFymgU2G0GYGkK3E6l0
 N8qJgV8X6d52vip3NVv+UMeM5Kwz7cz4zo/Mi5iyGPNSwIsNfqDWky+u8u/vHsfFAYtjSTdLENr
 WB4hsuwhMFD0vDaTA/w==
X-Proofpoint-ORIG-GUID: pRIfXvIUjsgGLNmEwAQ7U8jGctcgDbU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080082
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

On 8/10/26 20:41, Yonggang Luo wrote:
> Require libslirp so check-build compiles the PXE test and catches
> MinGW portability failures instead of omitting the test.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   .gitlab-ci.d/crossbuilds.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

