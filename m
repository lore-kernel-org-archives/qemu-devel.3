Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B772CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMcoJ-0008BM-9N; Mon, 11 May 2026 22:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMcoI-0008Am-JI
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:25:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMcoH-0007UU-0R
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:25:26 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6paL2803821
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cg1rpkPgWL/FK+4tprc5BwYAFA8yfpBkWXZf6wZ5Q3A=; b=SiW1jRaa4T+fq7+x
 7aiIEAQHljqkemuEZyyisVNGGW7kyPJJpw1xs2+Gi8NFpBQyVvgiPZrLV1UnbL6N
 TMkZkS9XUMC3fPKH+F+0ezlAJ30n6c5IdeVC7GdCUAMnkG1ejTvpBOhVhT4KauDB
 KHcKdzp+pUW0PWGXP/U4yQ/695bZaIHt1BJppYa18yE0edRYjHe9My5XMbxN7Auj
 XblpQdAuAo6kkjHGd8ZQAZTJZZbAYKkumaCBgVLwYisP52/eX4fibGuD7axvljg0
 5XHmXMRn4PilBgiCNlIJdsvyABMFpdHJju5HadFAvjT0/ZTc8//7p47MNYPBG6hZ
 1tQvng==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv393qq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:25:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so8064113eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778552723; x=1779157523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cg1rpkPgWL/FK+4tprc5BwYAFA8yfpBkWXZf6wZ5Q3A=;
 b=PyAHZygpjv5jcJxWEWZeeS6D92WVID89cmbEUyPC+ELBH3BYDLx6OQFHCEWPBpoBmz
 aa57e1ko21MjVtxMzVWRETXhN297CiT0aiyBe7MC3U8fpD4/gyYtqr/iaHEit8uJ3OjI
 ew4D8aGjEXYh9rh4iOKoMOzM1V8ApZ5rcAwmDU9WhOIl6rg8WZ5cu53vWgdYM2ch+3YJ
 G0LfcWZZy7RFTj4r8couMLonjvbZMrZNu1J+X3iUaaFNwFWoeVm84vNwiKlbuvMqJKmp
 PwM1abWW06YszQoA/e1qsGdgHoppV7VhWnX+I+u3suSNxo+ulUjSVSrsYNcoTvbNzH0o
 hRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778552723; x=1779157523;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cg1rpkPgWL/FK+4tprc5BwYAFA8yfpBkWXZf6wZ5Q3A=;
 b=Bhpal52lDJqpXVRDql3tt5N9xVDl4LPYiamHj22nbaWkfiPb1elfyy97F4ZykEUWnf
 tAN25q6stffpPGhm48KUcnFa1KYPrNWeTo52TK9r4c4cY4RE8ODrGecXUy3wf8zvFFmt
 H97T9FiySK0Mjq8/Ryo2W9o9fYaLjAsriY4CrOjc3TQYmgu1bKkugX/z5zO0JgbBhzWa
 1QX/B0XS/eUdH/0y0jyP3iKCufaxyeNqwSl+5S61Q5BbD41aEWKmpIuxYt8h4v1sP4x4
 StwSP3YNYXdR+rT8HoOW1uFajy+otoMS+k+hWh37CUwBWiErQEowPkxKHcsX4Q5gFATk
 LXPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ryfYeooRgQkBhyj9xI0HFFD/5gXwiyMvNNbpUzS/Q/LUP/DuX6RHfRw/fCUic869ZqNmqM2BmFjIC@nongnu.org
X-Gm-Message-State: AOJu0Yzz/0BMJNcLQDlmafuR6smuq4nwOdpsYWKUFXk066jGYbODn6YI
 9JY4Vpuyc1B4ewqM7KmcDqkOZClKtrzt1N3mZqBxBBdvxdo/gH1UvK13rYtBm86R2nesqY6g+U3
 ZTcD9aUffbnry46K1nEyNdxii7ujTurZImg5yRlRqivcjZWjXz4aCECxD0A==
X-Gm-Gg: Acq92OE6/2JVWyTRvG+qP8//urjXvdqAsmQb2ShHuNgcdRq/iq5+55oWbWmNRwW+kMu
 sSJvLOe38aywyrRp1d4jkZv0Fot7Goe05exQbn3Meru8USG64Hl22hEYWvUt8qZ8S20ghC8bSVx
 +Qxg+Ns5WmgXuaULfQvTapiZ2ajIqm88zvrYfcT0ZjbxwYjtGpXs12q5BDva1jcHTrfBYWT/1wl
 dA3BiV+BKKotSy709mO11WWEnFbNK/F2Ts568Tq/dx4uHUHMEutPL5NTXLOGubpLK075e3e5/xA
 CQzYD4y6D5GSqUMzQij1YsoFblRECUec/p34l/iDjaoK/OvG6311oR18Kmmcr5aX5rStOJq/UeK
 XCPb7TwF4g/peqoIYppXOxR50f4X8HM3VaM8zul6tZxwxapmuZAsvBKvydAitLQevwQlB8zVvsC
 WCIl1WlBO17PPjvQ==
X-Received: by 2002:a05:693c:820a:b0:2f5:5907:3a48 with SMTP id
 5a478bee46e88-2f55916c8a4mr8630812eec.1.1778552722566; 
 Mon, 11 May 2026 19:25:22 -0700 (PDT)
X-Received: by 2002:a05:693c:820a:b0:2f5:5907:3a48 with SMTP id
 5a478bee46e88-2f55916c8a4mr8630802eec.1.1778552721978; 
 Mon, 11 May 2026 19:25:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafc2sm20303102eec.4.2026.05.11.19.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 19:25:21 -0700 (PDT)
Message-ID: <9a9c761d-e8e3-469f-bcdb-a5afc8981829@oss.qualcomm.com>
Date: Mon, 11 May 2026 19:25:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target-info: Merge target-info-impl.h into
 target-info.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20260511190634.472174-1-richard.henderson@linaro.org>
 <20260511190634.472174-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511190634.472174-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyMCBTYWx0ZWRfX1mnHAqUc+N23
 Tcj5sAWbMnBcqW4aeuaeu+qcREiCp1eHA9PWrQWDf9kD9k72NUgLZRq8DJjVyetGp57IxT2VQR0
 T/+tOYL3cgZ+2jBhQKMj7//4Bipg+fwb6ynTLfwrUDRhisU/5Kh9ZWptHc3C3OAjaNYcc0T8HMQ
 2tn4pTVkeNL9aTOdZ95y47fB1rhQJMJ8D82md68VCAAz7gNdaQTs1WOKUK6K1frAaGyMETLjy6w
 aXsuKVQc/Gaq8EiE0vdJB2+1bZzgY7UZrQJLA0E4lgeF9KepZ4kdem/LaV0MX3mvKrQPOWIFera
 /of6qoPDBp+QPZZYFyqJSwWylLoBAFDs4KTwtLm8CAwlF6+J9zM/MJt7VMnP4vAbVnxmxcYcOAg
 f98mnAqibIL/PQtkUgcWp08FD2UJo8bESdbB3For2EvH3PDWaOoXbASC2gS6GhR0YKXivXs6rTJ
 C9Hp1caEYh0EbjM56zA==
X-Authority-Analysis: v=2.4 cv=Kvp9H2WN c=1 sm=1 tr=0 ts=6a028f93 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=V82x7OlPaLxPN6-WJesA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NBnHxn6bK2FUavxioZ82ZNsxCEAbtH9u
X-Proofpoint-GUID: NBnHxn6bK2FUavxioZ82ZNsxCEAbtH9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120020
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

On 5/11/2026 12:06 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/target-info-impl.h   | 43 -------------------------------
>  include/qemu/target-info-qom.h    |  2 +-
>  include/qemu/target-info.h        | 31 ++++++++++++++++++++++
>  configs/targets/aarch64-softmmu.c |  2 +-
>  configs/targets/arm-softmmu.c     |  2 +-
>  page-vary-common.c                |  2 +-
>  page-vary-system.c                |  2 +-
>  target-info-qom.c                 |  2 +-
>  target-info-stub.c                |  1 -
>  target-info.c                     |  1 -
>  10 files changed, 37 insertions(+), 51 deletions(-)
>  delete mode 100644 include/qemu/target-info-impl.h
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

