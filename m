Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63536606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dEy/7ERx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R4A7C60v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaCh-0005hc-Hw; Wed, 21 Oct 2026 13:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaCf-0005hH-Ov
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 13:34:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaCd-0004Tu-Tu
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 13:34:17 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU2rB682320
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 17:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EsMwVXdtnl3cNhjq00zZa3hP64+IGmPdNL+v2S5WA1M=; b=dEy/7ERxiK8wQ7N2
 gBBbLrSvPJu/ihbZEy1WEqRzl+SguOzDS89iQJbPq/f0yCwXjqETWROuX+avZG5O
 WunGsKgll+srjPpDpRFk+5j8e1CuwwID/IWpoF9+FPRpx65tbb6kmTpo85LBwRvd
 ttcUUyI145GQ4vVpVqOYVZX931D5axfYY114fSGXfW3vJkDXp3wG3aAuxsh7XqGE
 iBnLObgWutMgSYVqkWr3n33s5nY1pDYJyjZwUXGaFOqLP1II/P++t3s/RLfeeMYb
 e8UJzBslhVLQdK8Q7A2syOA9CZRn7vJj91GadHUGsqdMPKt+eMvopYwxF034hoCU
 v8f4QA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vs50d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 17:34:14 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-151ba226e1bso1700283c88.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792604053; x=1793208853; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EsMwVXdtnl3cNhjq00zZa3hP64+IGmPdNL+v2S5WA1M=;
 b=R4A7C60vAXDM4jQuR0TFRAItNaJuKSHhfozmtCQx+n6aX3LHVQZ3Y1agMpAvCFrINJ
 V8a/fPUcy+zZ7sfpjXz2QBpP1vwZRut0NSyVByQKLD7cLaF9pvmK+FB0f4kLFEQbXoN3
 P5xt/KdXgM3Ik2h/90aqqQU2E22mcYm4c9uhkZWvDrND/taKt8c/28VFl6kUSH8H4dsi
 JjF5XWhKna7A6flsdkbfdtQUvIt+8QC/YF1oPyPp2JaJYIpVeS2Pd1A4netRNDDVMryZ
 0LPEq/LGATswBNIbXBfCt2RcF33jpehYXd24bYwjYZH5KbCC4XbTH5gQJ9D9lBA31zwp
 SeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604053; x=1793208853;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EsMwVXdtnl3cNhjq00zZa3hP64+IGmPdNL+v2S5WA1M=;
 b=vMicq7UIyqjDLtysV+VzU46WEP76c8Os7l7mNXm1MQh0SsKUg1v+oulLLeOXbLksFg
 0KA7Kagcc0FCdv+ap7Z0rVuXxIRc0SJRnRyd6pK+cjKddV8jfXJVu+sq6SjDclOOCbnS
 gp/jMDYQNbpBKp542ekzG9svGu7MQDMBY+AjEXCHeJJMXV33xn/n9sUDKva7ndV/A9Sp
 Iv1eclJh83g0+txRx0Ul9LiQQBwrHyErM9GyJeq73V6NbWfvceIh8P1o+Ow3xRIM8O1N
 9gLeYg4LIhU4h/2z6QGWtdqyDFiQ8dPa7+gVT2L85YfXAQflJFufgMmsOTdaniO/X0me
 VibA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2DJb29cxGcDe06F0SfdI9iTulMxvVUZ9jG8KgfzUcl/JbzymUkl69j5cwQp26YGK63s36ddFYtLJj@nongnu.org
X-Gm-Message-State: AFq9FYJqv4NuVz7B9j9saCxZwrRxvq2xupNHJPSdJpjx9I2tMBnM+sP9
 h7YixHtYa6v759hgmRNaHGCbSAt8Z++aVYyOoS/ucIdCTUSEUVWEt70p6m8eEZ8bgF5WWojeHef
 I92foDO+RVWISS9/A7i8vnjkHcZ57fbJCaKvLRPtvdxANu9iRVRmIIrUheg==
X-Gm-Gg: AYBFou1rkIFNlA4u64IoldybRlhM8RQ10hVlC8zXxTHxd6M8/oPCKLVEyisKKrH2mYj
 FH/MxUNHdjqbw1al2KbKYiG/gkWMI/X2iBCDmmtFx/Pr46TECtZHPw25EKhUG9SkuXIFmMUz5Ta
 hsf06X+fe12Xpf85Sb0dStOvNE3NaWQbg38trfo+i5CTvvUUFXnP2CIzDzcHIj/sNEyaQHPJiGd
 2fxd8WQpkX+RQpzbWLzj4x8WIDo4D1m5YnK8mD84I3MsMwHcZ96oQvlDDf+0ZdSse8DCucSeoUo
 4LuszKhrZ2lbRxD6dN0j73mL12E+TQC72kNJSdza2udK/FInRPjSP7F0ii9wn9Z9+F0BKlZ1UQD
 Fl5X2Oh3JJKXobIaSVzzF05bwYt9Uup3miqVjjnshz0hgr0EN6+9UhmC/mBniXCGnLl9pKQ==
X-Received: by 2002:a05:701b:465b:b0:15a:4155:3d9a with SMTP id
 a92af1059eb24-190a7c21ad5mr3112767c88.47.1792604052974; 
 Wed, 21 Oct 2026 10:34:12 -0700 (PDT)
X-Received: by 2002:a05:701b:465b:b0:15a:4155:3d9a with SMTP id
 a92af1059eb24-190a7c21ad5mr3112733c88.47.1792604052326; 
 Wed, 21 Oct 2026 10:34:12 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19035926fe9sm6246605c88.2.2026.10.21.10.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 10:34:11 -0700 (PDT)
Message-ID: <3c9702f8-ae1e-471a-b7a2-3bf8d8af82c3@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:34:10 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/21] include/qemu/typedefs: add GuestPhysBlockList
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-5-pierrick.bouvier@oss.qualcomm.com>
 <d4498e40-47fa-437a-ba51-b97ebe23c3cf@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d4498e40-47fa-437a-ba51-b97ebe23c3cf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wdphjGHhT_2izHV8sIpW9TAmr99Y8md6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2OSBTYWx0ZWRfX32K1iO3yVV3Z
 dDhtzx79egb98JcFiMWMiGsBf6ozusP9EoEFYqkN55sxCoLjRvBib14bBf05WcK2BntoAuYOxYE
 oQp/jPemftfo5WRKudHs4DfOZmkW7rI=
X-Proofpoint-GUID: wdphjGHhT_2izHV8sIpW9TAmr99Y8md6
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad8f796 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=3u6rH6H1untE1TR9I_cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2OSBTYWx0ZWRfXz6eLWINpbJpD
 T4n9UhOONiN3z9vh9GPhm9hJdYSDWHvoaU7wU/QNlXhH+0eF3gy1SGz8N4qiQZ8NNLEHwVRmbfV
 MQjB/6tclf80sSAnlhNgaoV3NdMRVpsx/RBU72Zb+utfUcIAVGy9gn9KhLO5dLE0FJoRRcEeysD
 CB85+DHZXdvvV7L0rM3FISKUHPMk2u+8NCjDKGFhBFmAxyL5pGeq8BIw3ah6y0QK5WnJ0HWIX4w
 /AAMAhlgj/8jEuTMnOadpRSZ7kiJSDNhXU6F7eXvQfGDKnjcD5P4xsTsFruvVqkAy4Z452yWNvu
 gkSYLcE1NVfK0CprGW1pB7oopnkQ5wupl9cUkO44ZoNn2gnHhVk4L9gUaH5Zc2oHZ8kPLdAfO3X
 GoEolp53ru02qhqPAzT+Otpg/hVg6uE6fWQ8K8I71Bkbr0IumAalimNvcaxGoHnlz83x6fIECoU
 DNuuzAwnVM8bGmcx7Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210069
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

On 10/20/2026 6:38 PM, Philippe Mathieu-Daudé wrote:
> On 19/10/26 23:26, Pierrick Bouvier wrote:
>> This allows to use a forward declaration instead of including
>> system/memory_mapping.h.
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/typedefs.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>> index 8fa7f752dac..488d2556670 100644
>> --- a/include/qemu/typedefs.h
>> +++ b/include/qemu/typedefs.h
>> @@ -53,6 +53,7 @@ typedef struct Error Error;
>>   typedef struct EventNotifier EventNotifier;
>>   typedef struct FlatView FlatView;
>>   typedef struct FWCfgState FWCfgState;
>> +typedef struct GuestPhysBlockList GuestPhysBlockList;
>>   typedef struct HostMemoryBackend HostMemoryBackend;
>>   typedef struct I2CBus I2CBus;
>>   typedef struct I2SCodec I2SCodec;
> 
> Remove it of "system/memory_mapping.h":
> 
> -- >8 --
> diff --git a/include/system/memory_mapping.h b/include/system/
> memory_mapping.h
> index 4c770bf0b83..3bdf9badb5c 100644
> --- a/include/system/memory_mapping.h
> +++ b/include/system/memory_mapping.h
> @@ -36,10 +36,10 @@ typedef struct GuestPhysBlock {
>  } GuestPhysBlock;
> 
>  /* point-in-time snapshot of guest-visible physical mappings */
> -typedef struct GuestPhysBlockList {
> +struct GuestPhysBlockList {
>      unsigned num;
>      QTAILQ_HEAD(, GuestPhysBlock) head;
> -} GuestPhysBlockList;
> +};
>

done

>  /* The physical and virtual address in the memory mapping are
> contiguous. */
>  typedef struct MemoryMapping {
> ---
> 
> With that:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 


