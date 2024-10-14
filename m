Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B72CCFC528
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 09:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0HH4-0000gB-VQ; Mon, 14 Oct 2024 05:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t0HH3-0000fx-0B
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t0HH0-0004Xh-S2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728897713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J57jAHOOxFWU0D9tMzNjcYM0Ii4ta6G+D41ke15HesQ=;
 b=LIR4NG/dB7Hb5dmO7ZvNzdntCx+Azz2jLKxB36UuqVn08DcTboqqRlTBN/kQ5WJNsmxjPG
 AYQhee22yhqY6mQ7CNlK3aFjaiSkdnIzMN+ObupP4Asjamm2KnCRCx05Almt8ExmDFp2bf
 l9e+8wrF/petFjjVeb+i0hpsufIguyA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-4fSvkiFrMSeLrbff6VGhFA-1; Mon, 14 Oct 2024 05:21:50 -0400
X-MC-Unique: 4fSvkiFrMSeLrbff6VGhFA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cc10cd78e4so15647426d6.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 02:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728897710; x=1729502510;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J57jAHOOxFWU0D9tMzNjcYM0Ii4ta6G+D41ke15HesQ=;
 b=tMcXBN+U2ssKmdLfqlfvTw6mn3mfs60Mm6PYVMJQr0PbwRHb1idvilbQ/ZZepc504D
 SmHfF1fsiDhf64U5pxSqm3gicrYEcta2xAdE75ojSYc+hKKPIcKUWu/DPmgqhEw7HTm/
 +47aOyzUqoOgF8zt2bR7OyTmeidtfbGccREWVH2D19B+rO840l8ecozWrk3irGb74pwF
 ZYQJH/YDwn7ZJ8kLVqeOGa9AjWdtEh/wUnjpwekxtCDvaLbf9lwUSNf7+hmcnGhAUiVB
 B+v2jEVFYFfpKw4qvNjUH2vdn6OjSGefIh2E0AybMAl1ns7icPZZmWl8y1XsZTxk2mSB
 jX+A==
X-Gm-Message-State: AOJu0YwclG6wjXh5hvanYiZ+J+LnA52SC6rxLSzlLwXciEKWA7YZnY7O
 Wjwhj1EsHJp5FESKE4CtbdevhSpMI19xqzA8hCS034lodXvKThrZuvF/xduMYP4++Es52bJ/z1A
 jwTWUPyytq5EEg9FOkDHnBlK18c+O+Gz5KP2keRcnFvg18Pcb/3Lx
X-Received: by 2002:a05:6214:5c07:b0:6cb:ee08:c1e8 with SMTP id
 6a1803df08f44-6cbeff61ed6mr181498236d6.23.1728897709932; 
 Mon, 14 Oct 2024 02:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIAm7xT0TWbaw4BWVCh1siqeLNh/itGVPqpT+80WC1y9iOCNY6WElBue+HRtDTpojf2fH8iw==
X-Received: by 2002:a05:6214:5c07:b0:6cb:ee08:c1e8 with SMTP id
 6a1803df08f44-6cbeff61ed6mr181497996d6.23.1728897709560; 
 Mon, 14 Oct 2024 02:21:49 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-26.web.vodafone.de. [109.42.51.26])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe8608d5dsm43351536d6.92.2024.10.14.02.21.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 02:21:49 -0700 (PDT)
Message-ID: <c6c9ddd2-49bb-4c15-bc58-e72063be3a21@redhat.com>
Date: Mon, 14 Oct 2024 11:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ALSA support in qemu-user?
To: Peter Maydell <peter.maydell@linaro.org>,
 Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>
References: <CA+rFky6nRpHj8xKa7Wnw_coe_gbJoSXn61fc87-w0Z_7V-aBPw@mail.gmail.com>
 <CAFEAcA_-ncUdRTO+CpFCf44OY6toTBWw8-5y5zbnr3PSfn2sGA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_-ncUdRTO+CpFCf44OY6toTBWw8-5y5zbnr3PSfn2sGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 14/10/2024 11.06, Peter Maydell wrote:
> On Mon, 14 Oct 2024 at 02:13, Andrew Randrianasulu
> <randrianasulu@gmail.com> wrote:
>>
>> some 8 years ago this patch was sent  to qemu-devel:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05333.html
>> "[Qemu-devel] [PATCH 7/7] Add ALSA ioctls"
>>
>> I wonder why it was rejected, may be as part of series?
> 
> Hard to say from this distance, but looking at the patch
> I think it probably was just that it was on the end of
> a series that did a bunch of other things and the earlier
> patches in the series had issues.

Yes, looks like there were review comments on the series that were not 
addressed:

  https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05557.html
  https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05364.html

But mainly one of the problems were that the patches haven't been send in a 
proper threaded way, so it was hard to follow the series:

  https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05546.html

Anyway, looking at the other patches, it seems most of them were not related 
to ALSA, so you might be fine in just picking that patch, get it to work 
with the latest version of QEMU again and send just that single updated 
patch to this mailing list again. YMMV of course.

  Thomas


