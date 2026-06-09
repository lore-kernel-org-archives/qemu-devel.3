Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE120CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyAs-0004sK-5M; Tue, 09 Jun 2026 11:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWyAp-0004qw-3E
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:15:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWyAj-0004qF-N2
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:15:25 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClJ0T2251616
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 15:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iTXfIzZREK3O8KR7vu3bchBKlP92SqVwNaz7Z9ISOeQ=; b=TwAfVpxaZfHHxF6M
 o0i9sLn73mSCdy33SdAUdZ/BT6LfxGkr+/NAPLg/C9XbiY0mdr04rx2Q1/FxjBZk
 MeSSY+XoFo1/EP55XMXp2H2ahjnBjHLrIq9Uk6Vzaezgc+lq7RS1p6phc/Jwd8nv
 D/dBO2euoa4uU2RKvzz6/u1oORcc1a3a3EJg0vY96XMFMQlTmKO2gA+djyuExa27
 tbeTmG0ZQkNPEGXX3PjzzZ79qbRF5hyL64TbvKDa+3vfF9xBuQnc5sR5CHlqS3ge
 uB+SecsN51W/2cD5E7oxaCNV9rwItnCiwZnCPzo94sSdbiA1NdrCGl7tanKnzFGu
 HdL8OA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgj3uk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 15:15:19 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-963aef8141bso1845722241.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781018118; x=1781622918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iTXfIzZREK3O8KR7vu3bchBKlP92SqVwNaz7Z9ISOeQ=;
 b=SkgV3ZKuahg447iGUac/TdQ1moQc0dZr0CNKCPVjtv51qqSNWPMSA5eKAZw98zz+lw
 Ehiiqwofh3RNpx2ti6T4HwQEsXayzsNRzIh5LqQY7gNiG5tY9zv0L0QbfzxNEWP8X8Nh
 xDJt/lzSbPJISH2nhc+VbVjuRZVjCy6yTm1oBCmvv4yDB22hvR0iN3OxCimEV1AXloIu
 2yBkvJshQGVot8poraZLZDgTu4j7wmG9rWCZtWKUxS5VEA1CE8642GJIFHI1jlZab9gH
 c3cfwuYgumVn8bc9T81AxM3KAii5LDIlQ3pMVuRUooWasmieLZQRYLWDHsgtE5Nyn4Pt
 M4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781018118; x=1781622918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iTXfIzZREK3O8KR7vu3bchBKlP92SqVwNaz7Z9ISOeQ=;
 b=l/usou3/b57MmVsu5HGAcJhhdh2mRUygaajvj8aXXSWBaNSuDK56NWruwgIEA+mdVV
 ZoJ3RCSY+F7tXjHOVC/Vn4nMYkUaBcqU7U0lqzJwa7E/AwP+6Tqxm+oU/f9Km9PmzeEz
 oNK3JbaVAEh4ZTCy5vJlGbkKb/9Xa7U4EQJpd4ft9N5QZuiM8P9rAItmjT3hnsaoZVAz
 kVomkuMQvSvLZXRkVSYAGshS5zL/B+5VY0PBVpn/a+jarLiihXcgzWL80/Sp4BR5Z0oT
 MRbFLXROZqtNuFUvsajQ0GqXwYWN9e4iwB8GEUmDirtd/GJ6UzoVyEphMiMD7VbI1Kuh
 1x3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8m+P3fe3vcnHPwSSERx/dx9ap0DLRHgOGrJviOKU6b12hm0iDyg8sluFZIt5HhENNPwZ9WeFAlXhLA@nongnu.org
X-Gm-Message-State: AOJu0YyIhivxzN7ZxpRLgGdF+mWPU7ueEl865qwnapqzYxCdMCEq0xFI
 XT2qQYsjip0Y1i8OQUVsgcnNQ0szyldjwG763EhEH2QmYNcPzzrf1HJxCBnMoedep4+ns+AMFel
 /h9k19x31fKPg00Y6Ro3i0v3WWRP7yX4kV+GwqU4CzTICBc2y2DlA7gWtRg==
X-Gm-Gg: Acq92OGbeUjKPh1kPQ19+oYjKthEYJ3Ivymmh5rUMH0JdRrSuX+w9XPholKY6MUBbOk
 tXPUFSjEv0qE6W4hZzKbckKeRVYESf84QDXE0ZKc/glTiK6xt/AX2+OK/Bzs0QJkik3UrrjNJd2
 lsXhvas0PlZD4AL2MVb6V/CVHdxga6avfFeqgTZ3Y/fXOFUhyVDDu9t4d4hHDU8YV4YNDIRD/jR
 iwzHX/nH9784VW+TFNkzbaCWLKXPuiFCC3zKC10NK6FUf8dMGgq06CHsKB4iflcEB/SwhRtyB31
 qOm4Ba/wnNu9gaBIKXPq8kxZxJV5Gr30Z2O2jlObmoGlBBOpEWGeylLY4IaxZ6juziErLbZCeQp
 9GiDSHAaf78JjeB8H5YRqypNgh8DonFow5k17sQqA/h0kbifztveUHasWvYGSUMinWrs=
X-Received: by 2002:a05:6102:1613:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-71936ae4a00mr1756960137.24.1781018117811; 
 Tue, 09 Jun 2026 08:15:17 -0700 (PDT)
X-Received: by 2002:a05:6102:1613:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-71936ae4a00mr1756893137.24.1781018117445; 
 Tue, 09 Jun 2026 08:15:17 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0522834dbsm1050162666b.27.2026.06.09.08.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 08:15:16 -0700 (PDT)
Message-ID: <ef1709c1-152e-419f-bdf2-17b19523f0ec@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 17:15:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] ui/input: remove dead declaration
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
 <20260609-ui-input-v1-8-42615deb818e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609-ui-input-v1-8-42615deb818e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NSBTYWx0ZWRfX/Zh0P/UF25Aa
 +RQZ3JnTvnNcrQ9+shMvdHE9F+MqjqN6ij0ZLwEyPy9jdqfB92hwszbTA+/Zhn9PjLTasKK5FVE
 lZ8QPvecyKGVypjWIbavAIpEmMSppCiAIl5GLI6YqH3Hmy6wk2GKLpnHXhWHOJlu2vYLuuNPWN3
 /iPJe+BT4Z9GGld95DS4QvF1QHoRlqFJGA8kUiIppNYYmAlpeZ/72Y4E4DfNnxYxHj1DnyVBi4k
 aIhTxSjK/TGRPbSoGil+yUqx4wYcmX0IDy3pSSKIDDIKULesRS4oIybFaccUbY/RBJS5rj6D8c9
 yip1ZMEClF/hr2vfKPqtF0KObeTKyCnaf6piUN4LD1rzIAfO/ax3QNkqOT6Ntm8kgARKM7B0Tph
 XXKuvmxu1gL7wF+A1P/+9tnv/bP4xqX4cqkIJ1z+xz+Y2vfC2msYjZhIEHv1mgV0I8U5aLgOSbZ
 bZWIWdGITWWlmUCWhkA==
X-Proofpoint-ORIG-GUID: swNk-hn_cs3fdLKBx671E548GD9YLpYs
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a282e07 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=rKCt7aLp-E7j29zOxpsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: swNk-hn_cs3fdLKBx671E548GD9YLpYs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090145
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

On 9/6/26 16:34, Marc-AndrÃ© Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/input.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/ui/input.h b/include/ui/input.h
> index ea2d944a7ed..6df8ae3a8a3 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -100,7 +100,6 @@ void qemu_input_touch_event(QemuConsole *con,
>                               InputMultiTouchType type,
>                               Error **errp);
>   
> -void qemu_input_check_mode_change(void);



