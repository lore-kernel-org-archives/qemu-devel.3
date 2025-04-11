Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BFFC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3ERE-0006Js-9r; Fri, 11 Apr 2025 09:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3ERC-0006JG-Pa
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3ERA-0000YM-Td
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744378131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GT/OihVQ5Diu+SIXVM4zzOGgB4bdg8ARgOXVNeDgOhY=;
 b=XBXQkOWYyvAofGen+EGtnpNhU71EPsLzru1ZUGyS+8whMUx1AVcvp4ESGucKTYfxVxlNc4
 +bYh4ZjMNAdNeKO5pUK1PkbcJ0BGG6YjpjeM314Sn1yNaah4wt8SNEB5jiIuRQtCwx+YO1
 ihqgPMc7lTs9bfJf43Mzx8dgE98SBjA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-6ZKhsAnvN26fupy0AUFl9g-1; Fri, 11 Apr 2025 09:28:48 -0400
X-MC-Unique: 6ZKhsAnvN26fupy0AUFl9g-1
X-Mimecast-MFC-AGG-ID: 6ZKhsAnvN26fupy0AUFl9g_1744378128
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d51bd9b45so12862185e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 06:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744378128; x=1744982928;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GT/OihVQ5Diu+SIXVM4zzOGgB4bdg8ARgOXVNeDgOhY=;
 b=N6TO53cTqwq35S8/GCmTE3JBW9p+gIFSdTgFQA36XN2nZyejopywr6fknt8yDlKaKw
 sJnOgrwAFrQ42t4jMQeIUAnfLMmbqPfnY7nFQ52l01lKmSTsclo9lebsawEU7YwosQcW
 vu3SU/uSQPZRfHwJMRJRbuml2t3zqY5gxjWPeUFh/GYkqyrq0fmGuulmtpshIR0Dp2BQ
 jBuzkBQPqDRYMv6uafA9ckh+b8t8EszusJOvRSg9fwE685MhP3dtEGrQSVYd9twLZyUx
 HsuSPUeljBJt1DWI4Z06nCPP+qXfntnu763rHaNYE723TSie22hcvFlCx1rufEHTX0LY
 KAnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx0g4ZfQrLnXKUhkQBkc5TSv2hthdDm63llJIF8jVJlLN29GVRnJtYOyKMKe7jyGY2JijOzrXbHddw@nongnu.org
X-Gm-Message-State: AOJu0YxRvar1bA32GTNfP8R5/WZGWKornZPYU0ejo/o6FN/f5HOsAVGt
 KJBHnsqIfTEP/vELomOh5cacZ3MS4mk1dyHr1msGyGkHo7TtYTVJKnwq6f6WHyiI+x7ZQg6Q703
 FUkvrEzSypFKwbGL3njEqCtesQzdOuqoiunq3V1FaZPpLaeR/Q1U+
X-Gm-Gg: ASbGncsPHvNEgg561FgcXxT0KT1Pr8V2cFoNSbmcVphzZmndOMXp1/7c5Ir1BYCs15y
 HrB7VRaZPCycWcCbLGmz1IDXIeHTOi5ZMsnw+z5pckBRFeE8VXf7wH85h2XEs4aUHR3tK+DsSRz
 SgviAxa633ZV7J/u7FB5kuta0soWYqs5sU4ge7Wo67jlHqAgGfHvBFJRaPUma520bW6JxE7EGAy
 LDBUxn9LiI07ZRIS9qelG0r/0jp+aoF/1Ri+0DSH5Nwrrw8xTLdWWxmC29PVjIqfTUQx8z3LsVK
 qylEn8h9TWQeDsy4Z13fBCBetg87y2XG544ex+UERec=
X-Received: by 2002:a05:6000:2511:b0:390:ed04:a676 with SMTP id
 ffacd0b85a97d-39ea5216977mr2327145f8f.22.1744378127677; 
 Fri, 11 Apr 2025 06:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXlYPOjvzrqiKgPLtU6yYUfnJi65Rp6ZDlwChLj1cOjbtPiRkwnZD2cB4Su19bWrnsSQhQJg==
X-Received: by 2002:a05:6000:2511:b0:390:ed04:a676 with SMTP id
 ffacd0b85a97d-39ea5216977mr2327118f8f.22.1744378127252; 
 Fri, 11 Apr 2025 06:28:47 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977fc8sm1983480f8f.48.2025.04.11.06.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 06:28:46 -0700 (PDT)
Message-ID: <1ea0eeb4-796d-4970-84d9-e46dda888aa2@redhat.com>
Date: Fri, 11 Apr 2025 15:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/24] s390x: Guest support for Certificate Store
 Facility (CS)
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-4-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20250408155527.123341-4-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/04/2025 17.55, Zhuoying Cai wrote:
> DIAG 320 is supported when the certificate-store (CS) facility
> is installed.
> 
> Availability of CS facility is determined by byte 134 bit 5 of the
> SCLP Read Info block.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 4b5be6798e..99089ab3f5 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -147,6 +147,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>           break;
>       case S390_FEAT_TYPE_SCLP_FAC134:
>           clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
> +        clear_be_bit(s390_feat_def(S390_FEAT_DIAG_320)->bit, data);
>           break;
>       default:
>           return;
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index e23e603a79..65d38f546d 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -138,6 +138,7 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
>   
>   /* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
>   DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
> +DEF_FEAT(DIAG_320, "diag320", SCLP_FAC134, 5, "Provide Certificate Store functions")
>   
>   /* Features exposed via SCLP CPU info. */
>   DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 93a05e43d7..7d65c40bd1 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -248,6 +248,7 @@ bool s390_has_feat(S390Feat feat)
>       if (s390_is_pv()) {
>           switch (feat) {
>           case S390_FEAT_DIAG_318:
> +        case S390_FEAT_DIAG_320:

So secure IPL is not available with secure execution? That's surprising. 
Could you add a comment to the patch description why this is the case?

>           case S390_FEAT_HPMA2:
>           case S390_FEAT_SIE_F2:
>           case S390_FEAT_SIE_SKEY:
> @@ -505,6 +506,7 @@ static void check_consistency(const S390CPUModel *model)
>           { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
>           { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
>           { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
> +        { S390_FEAT_DIAG_320, S390_FEAT_EXTENDED_LENGTH_SCCB },

Please also add a comment to the patch description why this feature needs 
S390_FEAT_EXTENDED_LENGTH_SCCB.

>           { S390_FEAT_NNPA, S390_FEAT_VECTOR },
>           { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
>           { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 41840677ce..52c649adcd 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -696,6 +696,7 @@ static uint16_t full_GEN14_GA1[] = {
>       S390_FEAT_HPMA2,
>       S390_FEAT_SIE_KSS,
>       S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
> +    S390_FEAT_DIAG_320,

Is it available with the z14 already? 
https://www.ibm.com/docs/en/linux-on-systems?topic=linux-secure-boot seems 
to indicate a z15 instead??

>   };
>   
>   #define full_GEN14_GA2 EmptyFeat
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 4d56e653dd..d07ca879a3 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -2487,6 +2487,8 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>           set_bit(S390_FEAT_DIAG_318, model->features);
>       }
>   
> +    set_bit(S390_FEAT_DIAG_320, model->features);
> +
>       /* Test for Ultravisor features that influence secure guest behavior */
>       query_uv_feat_guest(model->features);

  Thomas


