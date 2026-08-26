Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF891C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzCtg-0000Cb-Oy; Wed, 26 Aug 2026 08:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzCtg-0000CM-0f
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:38:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzCte-0005k7-En
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:38:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCCE4X1223049
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DxpT3/RziTsWmx5KPtNxu8iLyrGR/T7iLtvoeINA7Zg=; b=H59FF6rlgZF2QHOP
 17RHGf+xISSqu7+ofR1J+hgQSyjwltTyCGxeUsltXnCXe4HPpe7dCnCHaaT0lSUs
 jUt04jzmiO4pPVY3jfW21bxHZt2Z8szhQQf4g63xQvU1aduz+9y7ozzIxvryg9yf
 aqjYg3HfULa3DDsbjVk+IjmZU0tglUnix9q/qDEInHVkHhYJrUcxrF0KmZyRGfIn
 zZew1YfTzlhS9qkR1CGGRqqxTr7D7YkUA2k8ElVysos0LwrpbJU99yR1URCBTMFg
 FDbJzY0iZ/jrnmTw3uFqLxPSTLQj8EoSnThSue8JUPtUcddISxZh9VRTB7gZ/EBS
 L7vN9Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r1gj27g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:38:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so9310611cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787747903; x=1788352703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DxpT3/RziTsWmx5KPtNxu8iLyrGR/T7iLtvoeINA7Zg=;
 b=N3szywhV1czPaSL3bLERXA3MG4ilBdkCCxuurKDBrUmZp48DYRkBB8Hex6GSaWmJHT
 g/aT4KtaDS2hFGLvVKsMNSkP2JxJ6DyWDnxw0RKE4/et4dJ51XQo7FAc5TQwYyHoWpcz
 UsDJUTIaTl5JLdFRggDLXE12JVk0OCkcm3a41lYe6fagE6fRB1Fzux0/6v+wN2Dry06A
 SyhilHf7lRDJkgmq/b4LaqrJ3UQWrJ6K2lCoNnQqlQKjjJ1BI7WbYGQYULHPj/VLul+R
 CYNVf8QAUvgwkPgB5sT/Jw4dBtpo7eZK66pZTmRP73U+hJapv2qxhPbyrcuakFkeUfn8
 wnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787747903; x=1788352703;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DxpT3/RziTsWmx5KPtNxu8iLyrGR/T7iLtvoeINA7Zg=;
 b=AywjYLHkU/uZvYk568tBHTltlSKo+ZWpqLobRJVet+K29hNFdpRTFj2zR37oKd5S3E
 zF7FshsAU7jRwHfihcuqdDMDOFqNgOb8RGFiw64dB/hGjCbsGKzIc+IdyHYR8G53Qi+0
 Bi7D1Xu6X3su6NVHRSpKCs25aC4CJ6TyYHBZdy2a8sxTQXBQXpaAMgsAlDfbKDIIEC+l
 J0hHneoDG/W/H89sadPHfv3S9mtbKbs4Yb+zHwivt1jZEngS5nQQE+n6K/ovjRnQLkGG
 VgJSOS7k145UUkpquNJvztOKT/Ya/81Xj2Js1TPObeFYQKlwwrO/ZfVtCizlCC+dcRVo
 AEaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHPNL839xAd4P1RO3imiAouw/eGWhznp8IMC47if/2iyMBCWh6jfmR6SEmPpDe19/8u/N/DR/gWUu5@nongnu.org
X-Gm-Message-State: AFuF++k6TOk/2BooRoxy51jx8RZRxLTXPYuc6f2/00D2SGx+OeVvwW6U
 mTkJAtJVeZHTNRHlO6PErW0ce2mfxuLAVrG9sKdxPFEtmO5FzLuwhRn8SVKz3mMnqRHMWOpKKuV
 MDd5NGHnCBFOSGmLRLibRc9YJ88Iv8EkVecDDT41Oo/380s6X8r4uLTY+zQ==
X-Gm-Gg: AR+sD12edzHHvA182AppK4mUix6zhdgZZ7sKGCfOBGejZV5yRm6I3VEwz29wVe7vIGQ
 wf9OaaJg8HQ2b9iy87OOJfwCE+rqwhVZSdKPsU8Y4dXQO2Q9THn/SI0rUpxBu47VNNKWffP+Af5
 MXeoBM3QNG/cSzwgQWgQrBridSrs6pB4LiV21ApWEqA/N6Wl57+LSCZlq3nX/CvaEq89cMtj3OM
 7uWABhZ6oohHE+VVvgbemVvn5T30NWN1xYGvQT7JSEZLAts/iuiT6t/6yMOdCQqhNgYV/SOTi9M
 IGhJ1UX/BKGOEuCnQ7tJyfp/nlA4RdBHshGyxVhaFEzyO6AsHR9rBhZEslIxivZSCcctfyMjmsX
 By3Bn1FVThjgvWSvwXCP9
X-Received: by 2002:a05:622a:1111:b0:528:32b1:c202 with SMTP id
 d75a77b69052e-52e42235670mr59764291cf.7.1787747903117; 
 Wed, 26 Aug 2026 05:38:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1111:b0:528:32b1:c202 with SMTP id
 d75a77b69052e-52e42235670mr59763391cf.7.1787747901912; 
 Wed, 26 Aug 2026 05:38:21 -0700 (PDT)
Received: from [10.254.188.74] ([185.104.138.96])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac5csm487676066b.40.2026.08.26.05.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 05:38:21 -0700 (PDT)
Message-ID: <619dd09d-e524-4bf6-ab14-fb8621e6fc9b@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 14:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/49] build-sys: introduce CONFIG_HMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-1-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-1-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fuumKS9VebJEM8I0_F7FURHlf6R9wQvY
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=6a8ede3f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=KRlTYBX1Q8J3JuxqD7zILw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=xJfQNL-qzqYeVQCd6loA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXw1qlMcOIaxST
 weJuBQpFYRSUqyuuSzeNo+kVrjuYrII2jtm6dnD1Kh99Zt9lQD2KMNaXXEiPJRmOPymq7suCm9c
 SsQy4Z4b2ARhq9BChgIAb+jvgFcIWU4=
X-Proofpoint-ORIG-GUID: fuumKS9VebJEM8I0_F7FURHlf6R9wQvY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX4Nohm/eeqEE1
 AUAYZ/MUc7jjQOHFxodokaMJkEhgtfBCbYlmI8soxZMgTobZHdWVUVNyceX7wjKR6PdbR5wzREB
 uBS+ibVxdxYfd6RQhJjeZpdEkaJ0NprYucCfg2HYUZ7NtO5NISKctCbzXopTNiKvsnSNr8K0Jfm
 NZPMAUegjUvzw+IRxhkdyZsMDq+/KcmxdIhsC2NxJoQhW43DhE1Q0rbMQjQD1dfmLoBYOTTsDiw
 uNXeXzYPxxTiLv48V/OTtn72uY9tuzEPWkDLgyR21d+uUslycHyvDAuec4yM0bbzMkcq9gpzziF
 2LkWc5e1Nl2VVLR+ZjJsROJXDTotpTszAF3PE3j+hsYvDCA4oci/GLEPFqAN8kCtn29ZfWha2Qw
 bvqmtMrl8KIShAFH/ewTf9ysMlR9yay9HfDryutzD5OcdLDEAOeqSB5XLuzDgeQ2w//d1Wv6bLp
 2UQKZlaN7gNNSP69wRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260104
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Introduce a config define to mark regions that should be compiled
> out or disabeld when CONFIG_HMP is off. The actual meson configuration
> option is introduced later, as for now, only "true" is supported.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   meson.build | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

