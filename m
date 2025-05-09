Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43CCC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 18:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDS1L-0004o7-5Q; Fri, 09 May 2025 14:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uDS1I-0004na-PY
 for qemu-devel@nongnu.org; Fri, 09 May 2025 14:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uDS1G-00020P-J2
 for qemu-devel@nongnu.org; Fri, 09 May 2025 14:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746813621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yB0lgen2eEEp6QGQCcIsuGy3+K7Ltn4+cQ9LZ/MAHV0=;
 b=SxIWtPmLwHJBS/iIzia44AJ5b+td0iQlwmdb3iT2IaI/snH/xSUGkccDXiSnb39nvkR4Qk
 9kdrPhXqvQg5ewmkRpZdMxRTcbVabLx116JN63o2kL2Ip/INdxRhlGHZpBAoidlRgo2pVM
 zI871fdac3TGUUBseZ1Thj+wD2b24Mo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-h2VZHz5YO9-aPzurdZNgvQ-1; Fri, 09 May 2025 14:00:19 -0400
X-MC-Unique: h2VZHz5YO9-aPzurdZNgvQ-1
X-Mimecast-MFC-AGG-ID: h2VZHz5YO9-aPzurdZNgvQ_1746813619
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5fcb3e44457so653169a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 11:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746813618; x=1747418418;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yB0lgen2eEEp6QGQCcIsuGy3+K7Ltn4+cQ9LZ/MAHV0=;
 b=LAmHGDRGohXeX6KNfU0zBJDEc8KjT53dzUXFZz2vwQaOUEZ5LO2E466tHNn5AahYMa
 RLGpAvF6Ce0GnX3+T9fuj61Hvgdf2Wx5OxHqOA0JVipIQkKOhZ0aJ+I9sTtZ3zYb2cM0
 0Wy1FBsKPK2qmPtEb3QEgPWMJc0TVMNytvM8rG89YSBhf9ijmsFG5K+rwz0uR8+o7jc2
 O6OdR3TJkf5NmiLE9GfpUay6G6jd01+MPtdOMDaCNDckzeDgBqqz4X6Exw3U04fzyFTj
 /A4OLZynQNQLIBwvC45CygVtSbVaMneZfzewqAsioWVE+CEN5z9vqYxThFYA/31WBCz0
 1P6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3XYY+qfoyeT3X8qn5eXzaygPBhfDNNWNC0CxyOuwfl+ADZlSZDgp1rvqc1i7WH4SBOCLDCrWUd1rU@nongnu.org
X-Gm-Message-State: AOJu0YxNfnMfDScExXxUBK8E2F8gRElhm3OS0/hZnNSTJrYQGg/uEbmW
 3+cay7Yblysv5aTQfShDPbS9SpdRnGm9H0QpZAlKoFDKnZ4TE5mySnwhN+3BFyfPfzMGgQ5WGLt
 HViIIuYwt+B3tFHfMRbRFLYBUl5bbECfFPcLWCb+hDFkW/ZAzBAHH
X-Gm-Gg: ASbGncuDEiSyjsLiDfZyJIT+u3GnZunFbDFwqVBryx39gE7iy3I4rWTM4g1MAGgQl8r
 P1HPURGkFlripar8LRu8XeMVlwFiy9EXplQ0gap9n2KyHNHgDPnKp+S6Xt84FC4/o72NWDd86tu
 alOw4pp1dfQRsh+bFPLz8VQ2sN1OT+ThNzi4krMWz50TXlLRFDsL00HpX8mJKsC1n2FoW0QR0lH
 thkUowS6xknIZ3Byr4u14L7agxQqdnPrKbGajRoP78L9AT82wMUOrIy39JesgBJBKQ3PTMWdwgk
 9Lj1BAjo94wg3ssfd2x6MpKU6HZbddEgVK13wMPhvSX3S2Wzj+8q
X-Received: by 2002:a05:6402:2695:b0:5e0:9959:83cd with SMTP id
 4fb4d7f45d1cf-5fca07eb64amr3347423a12.21.1746813618560; 
 Fri, 09 May 2025 11:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO0Hxo75CLD3jrwWYu+CS6BzfyIk0PtGgg0AGOsw94MOP5L0jCtiW5OoKSBfySvSWfiPWBDQ==
X-Received: by 2002:a05:6402:2695:b0:5e0:9959:83cd with SMTP id
 4fb4d7f45d1cf-5fca07eb64amr3347405a12.21.1746813618182; 
 Fri, 09 May 2025 11:00:18 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9d70d8casm1648309a12.66.2025.05.09.11.00.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 11:00:17 -0700 (PDT)
Message-ID: <01620b34-8a84-47b0-a4bf-b43532f5b397@redhat.com>
Date: Fri, 9 May 2025 20:00:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Fix leak in machine_set_loadparm
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250509174938.25935-1-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250509174938.25935-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

On 09/05/2025 19.49, Fabiano Rosas wrote:
> ASAN spotted a leaking string in machine_set_loadparm():
> 
> Direct leak of 9 byte(s) in 1 object(s) allocated from:
>      #0 0x560ffb5bb379 in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:69:3
>      #1 0x7f1aca926518 in g_malloc ../glib/gmem.c:106
>      #2 0x7f1aca94113e in g_strdup ../glib/gstrfuncs.c:364
>      #3 0x560ffc8afbf9 in qobject_input_type_str ../qapi/qobject-input-visitor.c:542:12
>      #4 0x560ffc8a80ff in visit_type_str ../qapi/qapi-visit-core.c:349:10
>      #5 0x560ffbe6053a in machine_set_loadparm ../hw/s390x/s390-virtio-ccw.c:802:10
>      #6 0x560ffc0c5e52 in object_property_set ../qom/object.c:1450:5
>      #7 0x560ffc0d4175 in object_property_set_qobject ../qom/qom-qobject.c:28:10
>      #8 0x560ffc0c6004 in object_property_set_str ../qom/object.c:1458:15
>      #9 0x560ffbe2ae60 in update_machine_ipl_properties ../hw/s390x/ipl.c:569:9
>      #10 0x560ffbe2aa65 in s390_ipl_update_diag308 ../hw/s390x/ipl.c:594:5
>      #11 0x560ffbdee132 in handle_diag_308 ../target/s390x/diag.c:147:9
>      #12 0x560ffbebb956 in helper_diag ../target/s390x/tcg/misc_helper.c:137:9
>      #13 0x7f1a3c51c730  (/memfd:tcg-jit (deleted)+0x39730)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   hw/s390x/s390-virtio-ccw.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d5658afed9..744e901db8 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -804,6 +804,7 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>       }
>   
>       s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
> +    g_free(val);
>   }
>   
>   static void ccw_machine_class_init(ObjectClass *oc, const void *data)

Reviewed-by: Thomas Huth <thuth@redhat.com>

and queued it!


