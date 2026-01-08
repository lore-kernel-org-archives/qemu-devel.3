Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7B6D1D47C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrvI-0007LR-9p; Thu, 08 Jan 2026 10:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdrvE-0007K8-1Z
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdrvA-0006iW-57
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767886048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ePq4tqCv5wnelSQErCxUW66pWfq9H2DvYYBiVRngPck=;
 b=XCp2zkCGujEa72Bnfq7bDDSJIdGqVaQ9C8W1NLlDOtrB/K2ta3+rDMtEtDXQ3xUtPUx6wQ
 gMkwfH2iNDbunlESByHndWt3yzWCrmY9lffdFoB+0KwX9eimB5cDDnoHBrkzBJ5T21M43o
 aNDXK0NFGx4qJDR4ATDgDhKQN3rIGNQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-OhZvTw9eO3qRvLmKV1YCgg-1; Thu, 08 Jan 2026 10:27:26 -0500
X-MC-Unique: OhZvTw9eO3qRvLmKV1YCgg-1
X-Mimecast-MFC-AGG-ID: OhZvTw9eO3qRvLmKV1YCgg_1767886044
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso13191855e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767886044; x=1768490844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ePq4tqCv5wnelSQErCxUW66pWfq9H2DvYYBiVRngPck=;
 b=Ic7Lid1QqwCZ4PPXslxH6tdx12eaCCJpKch4OrH6eOCpnzm7GfIK/5SWqR/1BVWnnO
 Vc6qrakRMckFKSL7wh0/NmanWNyvAyly4lTjWbk3eP3aME9cPox0UP3na3dQDSSGErr+
 7Vij/puLvs23rDZD6MhUNYjjqxiLt74WXZyraISdkt1/H4lTnh7UhGQweg90vhY6o1ed
 JNAYdBlCLOIKmg164kkth4J7sOjNLIOJEHAlPXWaPOEwRw5StHkBAXjUvj77d1m450jY
 jesCD8rhFYROsnQsxtUzEL6QLaxQhJSDpAH8E44IuVbuhMq+gSPOBnIBsIm8ABqivlhR
 +w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767886044; x=1768490844;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePq4tqCv5wnelSQErCxUW66pWfq9H2DvYYBiVRngPck=;
 b=K5Ix5vMvP/j7bMMQNgWHYO66lTCFEhrfLIeEa80+EZzWRbCCU47KRWaV1OQNjCkSdn
 AoPfqdafCG9gBdnexiGfEyA1cvu30I2Y5u8txpUHpzAfCR8hwqCiStizI7N5h/P5Ta82
 NDFfBSKlWf7LDsh0sNOIk93NLTjt21g8p1zzGrRMIzqwFzdRngkaqASUSqRNF8OJBX00
 D7xv1foECBj79sp5wuUTN31AtetrRrdwwyqrT/Mk33/ug7Jv0vdJnHX5max7xyf+TQhC
 WuEiCDdyizc8HCTdseaBBUApNUZnfzbOdXVdenqi8c9/BU7IzIrkJBJpXHGUyA1Q05vG
 Lddw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzNusGinpI+vFIlKv3pxXubllDIMURfVmanUmLMAtg7p8upnXdTGJDTKi6Cczj6Yl2sgO9kNDlbo0x@nongnu.org
X-Gm-Message-State: AOJu0Yz49dUTcmetZTeIX9++UhTv3FKNH/zyHkiSWRIobOe6xaIEnYHH
 OMb2JYAkySxojq4FUJ7dIy0/RXXZTa9KQAnpOFhgFhZvxjsrDzg1oJCz5Vm3TDOrJQvjfnKI9UH
 QSgyUBp1Oh0dvV1ld2zt5KpFkdqNiNGJsR7D666h/H/9XSe4DsV0K6vgP
X-Gm-Gg: AY/fxX7ORZgpQWAP4/ePfKhdZA3ThUa1RmHFgG8DhrZriay8LgIBJPy82XJv1yHeCnG
 LSyjIkbeO1hI5LOr19Zr9HoD59auDUvdCpOCGQsgwN2GFtDXKBe/JezC9TurxG0er8l45R99z2U
 ahzCbMOogYzPpM/NiX9LaG3NfGoRElJYl9hOCxlCSGMSNjm7a19PQ2FCyzvuhIrFFmHNXk80c6P
 VDC0hOveZDcu4kg1MdxzT1VmKckPKwGwBY6nmS8NGofGFGDRFFyJ62Ay2WgYotiC3IE2tn+nm/g
 u3PFDJTDAMMEOS8hVd838+IL8QCLgE4teTkVi+HuuomuoKZa8wrz/1xtPftZIYlO/LDH5kwz2XW
 qqgv8ACQ=
X-Received: by 2002:a05:600c:c0c6:b0:47d:87ac:73ef with SMTP id
 5b1f17b1804b1-47d87ac77c3mr58878455e9.13.1767886043890; 
 Thu, 08 Jan 2026 07:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEYU+oLatCgv1tnhBrp7inDqeE3SQGd3zYyo2sf2RwKLVwv7rd4H49r6F9pkhFdZWAFKW6BA==
X-Received: by 2002:a05:600c:c0c6:b0:47d:87ac:73ef with SMTP id
 5b1f17b1804b1-47d87ac77c3mr58878055e9.13.1767886043504; 
 Thu, 08 Jan 2026 07:27:23 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d87018bbbsm44929775e9.1.2026.01.08.07.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 07:27:23 -0800 (PST)
Message-ID: <ef7b65ef-5d8a-4b86-b5d8-39807d76125b@redhat.com>
Date: Thu, 8 Jan 2026 16:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/29] s390x/diag: Introduce DIAG 320 for Certificate
 Store Facility
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-6-zycai@linux.ibm.com>
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
In-Reply-To: <20251208213247.702569-6-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> DIAGNOSE 320 is introduced to support Certificate Store (CS)
> Facility, which includes operations such as query certificate
> storage information and provide certificates in the certificate
> store.
> 
> Currently, only subcode 0 is supported with this patch, which is
> used to query the Installed Subcodes Mask (ISM).
> 
> This subcode is only supported when the CS facility is enabled.
> 
> Availability of CS facility is determined by byte 134 bit 5 of the
> SCLP Read Info block. Byte 134's facilities cannot be represented
> without the availability of the extended-length-SCCB, so add it as
> a check for consistency.
> 
> Note: secure IPL is not available for Secure Execution (SE) guests,
> as their images are already integrity protected, and an additional
> protection of the kernel by secure IPL is not necessary.
> 
> This feature is available starting with the gen16 CPU model.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
...
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index c017bffcdc..941a69e013 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -138,6 +138,7 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
>   
>   /* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
>   DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
> +DEF_FEAT(CERT_STORE, "cstore", SCLP_FAC134, 5, "Provide Certificate Store functions")

Please drop "Provide" from the description text. We don't use such a verb 
for any of the other features, so this would be inconsistent now.

  Thanks,
   Thomas


