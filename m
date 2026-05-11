Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3202CCD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTwd-0006vl-Qf; Mon, 11 May 2026 12:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMTwc-0006rn-1q
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:57:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMTwa-00050Y-HU
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:57:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BD3PhW774991
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 16:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7zXJfCFj5vHcY74v9eQI2PbBe3SNfendqrqzMpF7ljg=; b=kuWvWbIZfBFZDI9E
 FvxU7w1NZgPGv+uOFG61h31CtlnSelj97DG1o/DxaVqw9oLMZjkekEsfxhi00XNX
 p2w2XUdhbkrbPyt7NlaQxO+2Qw2MawPIKYRggOaIvGz+MAc3ot8JsvJCBQEqpbzh
 mUfSWfXFmW5SoNsi4cQqlGL+u6cUjbjbL2hVtLJ2AcPGAACYlj/AP4NiVNagSEkA
 y5rkd1vk/scMTiSjG9CTE1l2DCokDwGmxrzqwPxyQAHb3jThE1OeFakZ0s2wWcs1
 L5jgTazaTburoUJTCiNDG3612cTkomscnm0t3hjj1paHWejswiCqhF+W1msInvVn
 NL2+Jw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3a32jctp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 16:57:23 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-132a8f93432so4341060c88.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778518642; x=1779123442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7zXJfCFj5vHcY74v9eQI2PbBe3SNfendqrqzMpF7ljg=;
 b=XhM1IrxR9Kb0rwhQLzY6uA+upnkjBpiB8G8JLmakGkM7MQBXDEBF9mvfTrFL/fDtl2
 PWtXI9pohXCg5FqpUQApfYeerhSOHRUTU3/sK6MDW0uMb9kT6r2lQ1lzmZNrNnUkC5ZA
 V7jQS5QhLTr36b5pXvlPdzPMyyV7bEJh34mVLgH9kDL4+iRrDQno6N4D+xiDY1Is7+dR
 j3TAw/lQ8FuGEuJu+8b08/2fY7vRk71I+kFQrGrssNfVYaoMXixKLjacW61T4bHx/C6G
 Zfv+LSiEveD1rlspXXWbNnx1kYk400tJ5q7s9Jcj7dTjf9x8VD7TJCO7SVKH/93akmXH
 aDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778518642; x=1779123442;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7zXJfCFj5vHcY74v9eQI2PbBe3SNfendqrqzMpF7ljg=;
 b=UqFxWQ5eS5AMsi45eT6Od8I7Na7NfpLbTEgPTebbSc613yY0bXEIzbHHlX73NwLlbO
 d8vuim3lYmFWpg/lJO0X/KFpcUJ4CD06n7bl6hYQhHsm/bvcJo/aa4xcvfV5+OUPR9wv
 feOm/jbm28yM5BamtSwmSZKw7hWmQKRj3AOFX0rdrYH5gUnKBUy7T7vcKmJgdfsCZJxL
 HokEf7VpP0+TKtE8vP9qbqyYk0q+WjpdkgNaMaMQYpKVDxE7m1L/1XN9ekrcwdr7mRvR
 2A/bSw7XgJdlZtiTSNkNioQ4EznMqchjvT+//kWnbDTNRVD2r57wdB6ix97N+5gsjR93
 npPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8C3BWuktX+BGL1U3hHlCe8pPwbzilrmxLhLJSiUq4QVGL+uGBmJ0PPuQOQ/a0+ojdGb5yZlkThTGed@nongnu.org
X-Gm-Message-State: AOJu0Yy6qaBwGHrFkK0RWk83rf53jmRrRn6oHOcoVxV2JInafLIpFHOI
 8pk1tlkUJ1MnUCyorNBk4SMIluzYX98R8zSJiDmDJQjXey/6WoAbo68VHeWkI2jDCxvD/NpBJvG
 KcWDepYq5crSTZNgVL3uLWB8U7ED/us0VlKevBE7E01HCTOSO6i7/fI9gMg==
X-Gm-Gg: Acq92OGvOUVm7/h9pBSF5M12mRXTFak7Jc01j5AhvB6yIxJNOLu3T51jE4lxI3GvilR
 N2A6Ij7avQxhRQXhz1vQpy5x3/6BHIpLXnFB7DJsEtz0g9vgHPZZA0w5vd/zaOkOCQnPM2rLeWX
 NMgg11Xy5CliWSEPDCPQJGy+SljkwOnu3EbtJCxMDWtCeWY/julmt4Ws77zmcsR9rpIOUtj8H47
 BvBEzrbAtPX+eR14DEGCYhZ4xWr/WL1yPPceK3YPLBQlXChZeCaoeq8M33PBa3RrvYsPRO5FFkc
 4UmI6WAc1zni+aRE/T10I/7aao+KhuUPJhsi/d0dJ7FrlsbAv1fZmQxC74/11OQ830sxOIIdBH7
 ortP9ay+5sNWrPyQfglYSRlQL0c8gjjmuIrzEaqBMvxYaLHHr31IM/2s4225djEkT0mdF2GS1V9
 g7D1PpXCHtZKWPag==
X-Received: by 2002:a05:7022:2511:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-1319cd2660fmr12013617c88.21.1778518642440; 
 Mon, 11 May 2026 09:57:22 -0700 (PDT)
X-Received: by 2002:a05:7022:2511:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-1319cd2660fmr12013594c88.21.1778518641809; 
 Mon, 11 May 2026 09:57:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132781103e7sm18236342c88.1.2026.05.11.09.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 09:57:20 -0700 (PDT)
Message-ID: <b601aa7e-e26b-42b4-908e-f5e5df3c61cb@oss.qualcomm.com>
Date: Mon, 11 May 2026 09:57:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: drop sphix-build < 1.7 compatiblity check
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260511104629.2634357-1-marcandre.lureau@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511104629.2634357-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nT8niIEZ7Tgdy3fyV-4X_hR_enVN7886
X-Proofpoint-GUID: nT8niIEZ7Tgdy3fyV-4X_hR_enVN7886
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE4MCBTYWx0ZWRfX7ugo+ombYQlP
 bgOb4Q35wWv00bX2dIZNfI+Rw9+uG+m9V79szFpLIpQHwks9D8RwJ14PKsNzdaf4cuP/+lj0wv7
 FYP0fQ68TtAGzSLz4BwW2Csul7eMuO0Q1gtziU2hn5CXGUDJO+LuF0nK/bOhY/3LNEqV82xhSZn
 vZbkFduXnPRxjZ1UUq49oX9hFm1b3T96ecSg8LLQq3xYdpvOeYqDRZBbZRAit69OA+W+HeaR//H
 JigPei82+7D0WuA2yKMxg/V5Ta5An95l41IkTouxvdSe8LmtkNHWjabPEpJSkgojW/UXnoA+/Tb
 vHW4ElGuUF+S1KRimW7gjrCtlxoJFdxEAcu8Pj7tc3nNhzqC6o+e+0kWz/TxP6RBaSDMEuyIOBK
 svotd0KXRUHD7YX24IYL+jPPDQbSon+nk0a341KVinbMY1aYMHrR31yn76KZkNaiH5Ex4NBiCKR
 T+kd9xnPPfOZP5x05kg==
X-Authority-Analysis: v=2.4 cv=SLVykuvH c=1 sm=1 tr=0 ts=6a020a73 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=knIHz0dcQFE184SfQxEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110180
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

On 5/11/2026 3:46 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Since commit fe791b7fcc ("Python: bump minimum sphinx version to
> 3.4.3"), we no longer support building with sphinx-build < 3.4.3
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/meson.build | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

