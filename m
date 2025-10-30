Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FC2CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWDP-0007OW-VO; Thu, 30 Oct 2025 13:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEWDN-0007O8-3F
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEWDA-0007Gf-4h
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761844393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pxp0GDrxujX1f7L9fk6ABXcsntN8ED26xv8wcHnLuJw=;
 b=d5lE+xxBuDXvuG8E0mu3IyKkcyQ/Z9mGf0Q9LwZtFdHCzjQvS22RLFwebT7XSb0eInGuPx
 vGwLf0XqRYdjIn4Kl/NOtM6GsBbZOYpjH+9YHmnpo7WZggvdE1WZI387B5rRjUtcSHAb6q
 fgFuB013oq2DBEPKfrFNB1iRHpIiA2k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-jmIqUJtgMeOutVVwK5m7tA-1; Thu, 30 Oct 2025 13:13:11 -0400
X-MC-Unique: jmIqUJtgMeOutVVwK5m7tA-1
X-Mimecast-MFC-AGG-ID: jmIqUJtgMeOutVVwK5m7tA_1761844390
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b5a8827e692so91459366b.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 10:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761844389; x=1762449189;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxp0GDrxujX1f7L9fk6ABXcsntN8ED26xv8wcHnLuJw=;
 b=DgGfHkaxAKu21n4zlhQ2bMZoA4iwrBp08YhCqEIX/FsrBEutl2jX7H3tAKDsn89U90
 C0fokSdBYmSdrq0kMxmEOgyYQEtoUZ+SV8LkKLQJIn5y1kf6dIN/6Fq86wJdrSE5Qv1f
 xqsmEwAP++RcT1AjWt3A5CZZZbuT4NOk3QU/DfsZocMHWXTsozZdAJ/yPug2dWYseyFP
 xpV/qSaTUQQ3Ru+4QsHF1gCmBHempkMabQZIF6C7B7hDFUnZz0yLC2Fc+2nrNXJE8rm8
 EnNrXiWDywvxVIln12CfzeahhcRDg+psadSKlIaV8f6IQ8pOfh60CdmjvbJApEeQWJ9d
 7gnQ==
X-Gm-Message-State: AOJu0Yy1oRwUurMkSSZBK/upYJma1qXR6xjdJ73v/nX1sjRJ6JkD8Nve
 jupbGp7+SDJWu+RudDoKFMwJHhxtPrLqb4Q2LdVEFWqkS/UW39qCQ7cCUj/xnZb+2nFP6x2PK9g
 9dCqw6c5kvpdpD0zaY+YXdRFtBAkaU3bJ3sjcZqYst79rYI1K4Osqbutn+tU8JCjj0xOx2zj/OF
 8sCCLXwBx89LRhrDU2UBmm9Oz77JQek5jD59kOTFuG
X-Gm-Gg: ASbGncuTGpkJPCpFR+FOwuE/ziYnXUR7u2KoV67hDreZpV9qfa6F/XZv5Hj6jUUp/gm
 DYXdTlVFuPnf1q4Q5H5ZsotdTym8W0aA1IlQ+QHlxIhIjWuoKm2ZtWjXF9UJ66w+pR7c3681AYr
 x0IhFUnQQPHBjTz7zKElybQCi/VMKI2R9X8Rfg2f3SC9YteZ23KoNGtHlCkZEDGglopf8E6oy/K
 gJl2uWcRRDgOaBkjCiRgq+LmL5t7cKVoqNCbUDZfz9POiwPrcUSZ+VYeiP5EUQ/DbC+y+b8e80V
 RMvxAqTr+zm/9/uELRGVnQi4sTZvdZusnJmsW14n+t0fKi7RgqVQEcxM+BciQRTsFcCN9VdRcVS
 bD9hpgRh2brFLOYdjEh1wcvlypPXzYj/x1BLE9DX3VaTBjxHD8iwzAnH+RiGi5g5HErzBch+GjP
 dquFRP
X-Received: by 2002:a17:907:1c0f:b0:b4f:ee15:8ae8 with SMTP id
 a640c23a62f3a-b707085aef8mr25501766b.58.1761844389447; 
 Thu, 30 Oct 2025 10:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeCg3DMGcwzgoV4JArb+0WpZz4jQwCEHJsAUuEZlO1I4VwQiXdTzYd2vqCoxoTHL+HVJLK6g==
X-Received: by 2002:a17:907:1c0f:b0:b4f:ee15:8ae8 with SMTP id
 a640c23a62f3a-b707085aef8mr25496666b.58.1761844388897; 
 Thu, 30 Oct 2025 10:13:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b6d853c664asm1803842666b.42.2025.10.30.10.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 10:13:08 -0700 (PDT)
Message-ID: <f9259ce1-8026-4190-b69d-b899428306ca@redhat.com>
Date: Thu, 30 Oct 2025 18:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] rust: QObject and QAPI bindings
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
References: <20251010151006.791038-1-pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/10/25 17:09, Paolo Bonzini wrote:
> This adds two related parts of the Rust bindings:
> 
> - QAPI code generator that creates Rust structs from the JSON
>    description.  The structs are *not* ABI compatible with the
>    C ones, instead they use native Rust data types.
> 
> - QObject bindings and (de)serialization support, which can be used to
>    convert QObjects to and from QAPI structs.
> 
> Unfortunately Rust code is not able to use visitors, other than by
> creating an intermediate QObject.  This is because of the different
> architecture of serde vs. QAPI visitors, and because visitor's
> dual-purpose functions, where the same function is used by both input and
> output visitors, rely heavily on the structs using the same representation
> as the visitor arguments (for example NUL-terminated strings).
> 
> The serde format implementation was co-authored by me and Marc-André.
> Marc-André did all the bug fixing and integration testing.
> 
> As an example of how this would be used, the marshaling functions for
> QMP commands would look like this:
> 
> fn qmp_marshal_query_stats(args: *mut QDict,
>      retp: *mut *mut QObject, errp: *mut *mut Error)
> {
>      let qobj = unsafe { QObject::cloned_from_raw(args.cast()) };
> 
>      let result = from_qobject::<StatsFilter>(qobj)
>           .map_err(anyhow::Error::from)
>           .and_then(qmp_query_stats)
>           .and_then(|ret| to_qobject::<Vec<StatsResult>>(ret).map_err(anyhow::Error::from));
> 
>      match qmp_marshal_query_stats_rs(qobj) {
>          Ok(ret) => unsafe { *retp = ret.into_raw(); },
>          Err(e) => unsafe { crate::Error::from(e).propagate(errp) },
>      }
> }
> 
> As a small extra, patches 1 and 2 rework a bit the error implementation
> so that it is possible to convert any Rust error into a QEMU one.  This
> is because we noticed that we had to add several From<> implementations
> to convert e.g. NulError or serde errors into util::Error.
> 
> The price is that it's a bit harder to convert *strings* into errors;
> therefore, the first patch adds a macro wrapper for
> "if !cond { return Err(...) }", where the dots build an error from a
> formatted string.
Ping.

Paolo


