Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FED7C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vdq-0003GF-NV; Mon, 31 Aug 2026 02:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vdo-0003Fz-PV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:37:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vdm-0003bS-VU
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:37:12 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52Qio3678801
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RGZzB+XpsgcKXJO4Qq2u7DreUMh8bYqddJzlCpq8tao=; b=hz9CUQe91MiB9HnG
 K9/5DfV9//gi4SPcHbxgwyOcDxGXwroInHuwNUJcw3SCwum2IN7nfdf8Ht/StDhy
 HjYskDw3sqyaH7NvqS4YfODnDMzqVuT1LPdj9rTSY3d0f7KYj7VEM0o92U8W2htz
 n48tHjalhvfBJz7JxrCGGRHQJqTOyMZxkDIOi768/3KeMeTCydAkJs3fNBlJxVbP
 +ThtJMfTnHFcBarQ9qYJ3Rn6cFGVx6lN1PL2ig4gzCAmqYNcJoi4cxIf42veaNiw
 ehjvcPTLT/T9rD4SI0wssBn6U17CARHKVY8ZkO962Fmi0rjHEXHlXWN8KRuok4dF
 PrSq4g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h18mk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:37:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939187562a1so758826085a.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788158227; x=1788763027; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RGZzB+XpsgcKXJO4Qq2u7DreUMh8bYqddJzlCpq8tao=;
 b=BEyp2AU/5LXc7V+mUnBzXReOrfrhAZV5BIyOGRWNSfBkp4zQm6qkAn/9aJnmAlwGgk
 OHPv1CwatgktehNaHDytl7RVCW8j8rT7L95zUqLSmDuU2v1F1RWbekbzG0dJOnsT1zlS
 E6FvFt+zjZHyZoHyqgVYAXkoG1W+5dlL3RyN7ar+kZ/Pi9gO43o1mbhhFKseg1m0vM+S
 s/88PuVoQqevi//oeRaPClWmewtsk33FXjscaxmUPx0dMm2FYJM2LosEIEkFqIm1HOm6
 b6uV8EP3sQI6s+ROcqgjgcoKGy+L0rpLo6LRUyNIrsypOjy+2JyVIj8+kPGc/Yj9eANF
 HzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788158227; x=1788763027;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RGZzB+XpsgcKXJO4Qq2u7DreUMh8bYqddJzlCpq8tao=;
 b=WqZLpMqdxE7wWmkkTM5WalrJgW8HzSk5mQBu5mktL09vgy2du2NPeQSTc8MxvKAEQ0
 7s+5vplPcbQwaRK7eMIOBXwYBmKitL94hV4G75apJaSrbDPhs3F9p/+ykMs7n4iQQO2L
 QwgA8OJZZwutk8i9/Je23DK1UlJGgqfQT/JqbZWfnGYMj853qf1KF1t9B9IRxoTidDjC
 8dOGxZ0YqQdeS2Y45mnBhIq+H68E/jMHD8aLMlJkln5Rv9npryQoq761aNkcLsc2Kkrs
 GbECzObGBD120rkiiSV3ygq2+9cc5oWVaCq5aTR86wl7xZSPbRvjwTdUZnqd80TDZ7k1
 0zBw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3TF8hzHjGhgFdhwVgSR6/rbRPEImS06dS9szNQjEqbmN9ZYvkcUgHsHAxVFg9Rhh9pcHvwQXWKjkF@nongnu.org
X-Gm-Message-State: AFuF++nsCRcSMHE2pIviGR5iIs0Z6aG0vzfGu0Kec1JAEG41KpKaq84g
 qUdTTvwp29dyGNG/BFeUCLv/KR6yJyk5QRaX2EKJkDzQDEGCs0TYJpZr5BlFoK20SRk0U8/mnXG
 WMIF99m5yjgUX57ESVsMapMVKhrx7Edh79x08L4jErYYzMKdy4MAlb2FPbQ==
X-Gm-Gg: AR+sD11e0doBG5TU1cQLA6hNcsW6GRrhv0SrEMdD1N/X31YED42MKTiNruGqcSUxErx
 gAziFsaUWkXjuJefjRjAPO0J+aKEjSf3BLwK0SEaAqYxe0lcKTzLWwq4aU2sXNsK4MKCS6V5xmQ
 UdFBC6ffIAXf9FvLvTn/3yfLUhPv+v2O6mnMxpqwy6lz9M9L3gHb0RDUOBDzYpx/81B2j/aG4tv
 MwVaW4uZYqlB1yvpkh8V/3RdzwSPhjJ1YaOzGkdPPPjfGYLhYoxLKNvro4bQcZ6mz4PLWplTJ3q
 kfr8aI1uzx15QIHtwpkozE7QLiC0/RaqzcmLvXXsXRZSWeltAK1ZpB9YVvYc4j5YqKMBocoJqel
 AecmF59WEMUJRXzkK9SI+t2q8l58RVe/Ieg==
X-Received: by 2002:a05:620a:2b8f:b0:92e:6122:130c with SMTP id
 af79cd13be357-93913925d75mr2850188685a.34.1788158227177; 
 Sun, 30 Aug 2026 23:37:07 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8f:b0:92e:6122:130c with SMTP id
 af79cd13be357-93913925d75mr2850171685a.34.1788158224470; 
 Sun, 30 Aug 2026 23:37:04 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20737sm18319140f8f.22.2026.08.30.23.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:37:03 -0700 (PDT)
Message-ID: <c714466e-d35f-4c6a-adff-863dbd06b0b6@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/47] qom/object: add is_available callback to TypeInfo
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-10-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-10-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a952114 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=CNXbwTOQ-xObiPyQiJIA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1NSBTYWx0ZWRfX8n9R8WSQdKcQ
 M+xw7p56xBbueyXOHBRnGWHsm+rIZfJpqvFzSRdPX2UvrWOkpesrBsmulVd3gFU85jTKRm5672D
 8WijIlIGxoaI789UxYSAP8XeZNlE60AeDvp/kFc47kGEqGKIly0S1PaKP24bEh+qoN6ze3yqczf
 AxTEbv2AVXvvtkn9Li1ZaLF83fP7EiNqPWgYiKvmu+hBj8Aonwrv2cppdPaafavOPMyRWrWTB40
 RgUyiRcbN737MBW1aXQteGRj1VyRHcPPhwzYRlntXWMubwDa183YrX96te4j0h4I8mahigEzC1o
 9jrjcbrfaQ+pIGfM+0iMPmla/XMFurXR3OBHQH23DZcVJdT4/3nxtoXI9XyVJvDoFMbQVe81ZBF
 MxEEf9ylwprTe3QMyvXzp2yroL42Si92/XDYrOJcPX6EMqZ07UssD9xgNBwB+DLgFHcy2MpcOQy
 qpo8O1KPdXid4CBpjsQ==
X-Proofpoint-ORIG-GUID: eATFp8wsKvkOZTSXgtzcMypwxDDrOlTM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1NSBTYWx0ZWRfX9ybl1uDB3aI4
 qIDK/YuQpaJ9uejVaYcMImFnsTEIRbdalXU+IPbyS/NboAdILAuIUr7ZejesFgXCu4xteHB/nIz
 o6eAObx2kXpV+BB+AoF+s7Uwb747dGs=
X-Proofpoint-GUID: eATFp8wsKvkOZTSXgtzcMypwxDDrOlTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310055
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

On 29/8/26 00:58, Pierrick Bouvier wrote:
> With the single-binary, we start mixing types for different targets,
> that may or may not be available for current one.
> 
> Previously, we implemented an approach based on interfaces, but it
> proved to be too limited. It requires duplication between
> machines/cpus/devices, and does not handle specific cases where a type
> should be available based on a target configuration (Kconfig).
> 
> To solve this, we add a new callback, is_available, to TypeInfo.

Back to 18 months ago:
https://lore.kernel.org/qemu-devel/62dcbd00-0bb6-43ff-998d-a07b85917c99@linaro.org/

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qom/object.h | 3 +++
>   qom/object.c         | 4 ++++
>   rust/qom/src/qom.rs  | 1 +
>   3 files changed, 8 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index e24f0a2b2d0..7ecd0f210fb 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -469,6 +469,8 @@ struct Object
>    * @class_data: Data to pass to the @class_init,
>    *   @class_base_init. This can be useful when building dynamic
>    *   classes.
> + * @is_available: callback invoked at registration time, to dynamically check if
> + *   this type should be available or not.
>    * @interfaces: The list of interfaces associated with this type.  This
>    *   should point to a static array that's terminated with a zero filled
>    *   element.
> @@ -491,6 +493,7 @@ struct TypeInfo
>       void (*class_base_init)(ObjectClass *klass, const void *data);
>       const void *class_data;
>   
> +    bool (*is_available)(void);
>       const InterfaceInfo *interfaces;
>   };
>   
> diff --git a/qom/object.c b/qom/object.c
> index 85bbd7f9fe1..b1834a57cc9 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -163,6 +163,10 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
>           abort();
>       }
>   
> +    if (info->is_available && !info->is_available()) {
> +        return NULL;
> +    }
> +
>       ti = type_new(info);
>   
>       type_table_add(ti);
> diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
> index cc00ddcfc98..bbb485e2cfd 100644
> --- a/rust/qom/src/qom.rs
> +++ b/rust/qom/src/qom.rs
> @@ -691,6 +691,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
>           class_init: Some(rust_class_init::<Self>),
>           class_base_init: Self::CLASS_BASE_INIT,
>           class_data: core::ptr::null(),
> +        is_available: None,
>           interfaces: core::ptr::null(),
>       };
>   


