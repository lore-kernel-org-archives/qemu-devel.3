Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2110AC71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 17:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRDCA-0005jD-FY; Mon, 16 Jun 2025 13:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRDC1-0005if-1U
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRDBu-0006yb-Jn
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750093212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yUjb4zOZIqWgEk7vWsJd0mEGJNp6MLav+IBGf8TSGnY=;
 b=YkkEnT+k8yFdb9QXOtjRA99Mnn6OfTk+2nhGen4kG9Jp8tNxwyLorTyxAvcD/5gAz7rc96
 BLlOL2WHJAthzj+7CEuuSzVzsIXJO0w5TMrHn3VyqJJBM+b66a61+lNwPnkDvZM1ZhKwG0
 xva0ezY2M4yH5otn4gh4cqJ6OzAThmo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-zCBV55WJOGqfHGMBlBdqng-1; Mon, 16 Jun 2025 13:00:10 -0400
X-MC-Unique: zCBV55WJOGqfHGMBlBdqng-1
X-Mimecast-MFC-AGG-ID: zCBV55WJOGqfHGMBlBdqng_1750093209
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d290d542so29623405e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 10:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750093209; x=1750698009;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yUjb4zOZIqWgEk7vWsJd0mEGJNp6MLav+IBGf8TSGnY=;
 b=LUuO98quKpP2mQIwqMG0cILAZkM9icbMTe7916ODvXAHSRT3ORY9TXjfQb1bIwVkHc
 w7cLYy8F+/SfpRVcwlnO/rTzEXFF9Db3Dtd/kUbo8crTMnSuYQ8E61UhaFecZjUStJy6
 81h4+Y2tGrDm7QuU74P2JrzX1C33+1Y8y/U+t6wHIHA+ZV2Ul8WbTArUvl0+NTbRlK7j
 0RasPJT8yS8y5Xs3RlSLNWCP9U7X1oPb/uvK+ss9U2cF5RYAzHLd4k5k36ovrJHBdRIp
 ee2arrBDAUx+agzcHaqiTkt+HcpIckIn1RnBIH/U/84M/nDsLm6HZhyIYKGRRcZ99tQ3
 LBRQ==
X-Gm-Message-State: AOJu0YzYoPSp0/cGA/3+27R06bN18WJlHK19tWLriThl9MUhWBuqfCWt
 YiK1818SiV/0c4GLxWCGxQgAxn/Mt+4VJlfPkSdmEJrGAaR1NGFi5AlO6mYLXEMDw4S6L9IoICw
 +JAGJicbUNJ7DhooFgQOlN+CVMhYkueAwjg4c5fnStekIGhHX7a8+Tdam
X-Gm-Gg: ASbGncs3L/dUtEqq+2dGQF09W8W4/C3qe9c8dVBKY4cEb9urpvs60fQhzxYLUaH6anc
 0WvIhJeUz0WadfWOcvo0lJbEUKsEbsLhNpeVAS8TleRjNzv8jSau+thpEtVCpXRIRTbZ0V42L9M
 zpfXoNQRAmmY03U0hmA0TQ0sa4DT1SIyLrCd46wME7Md4Aq2yljxyyqS/pM1E87tmKp8faDOhaM
 o/pLdtu/oMP8GZw/iw6zvDTKM7Yasby5Q7KV/GWy4Jv3aDEieS+fKs221s07zp2hUi1MV2mn2Xj
 1nwI3HUOP41RNDHYJ0mXf1+bVLs=
X-Received: by 2002:a05:600c:6097:b0:442:f482:c432 with SMTP id
 5b1f17b1804b1-4533caa11ecmr103062915e9.18.1750093209378; 
 Mon, 16 Jun 2025 10:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRGC4r6vdVA/SpzrcF5gPlc+B3PdTBMI2/TqewzHCqQ8QY76PSfRKXEZx+YAZMeIgheovTxQ==
X-Received: by 2002:a05:600c:6097:b0:442:f482:c432 with SMTP id
 5b1f17b1804b1-4533caa11ecmr103062585e9.18.1750093209015; 
 Mon, 16 Jun 2025 10:00:09 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.88.147])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a568a72cd3sm11651673f8f.32.2025.06.16.10.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 10:00:08 -0700 (PDT)
Message-ID: <b23712cc-1291-4b3e-b6c9-2d5c9abc4622@redhat.com>
Date: Mon, 16 Jun 2025 19:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New CI error due to mismatched lifetime in hpet device
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
References: <CAJSP0QW-3ibYSCL0jYyvm1eADp7fKvLgorGWEk8WXW4SMGfaJw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QW-3ibYSCL0jYyvm1eADp7fKvLgorGWEk8WXW4SMGfaJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

On 6/16/25 18:46, Stefan Hajnoczi wrote:
> Hi Paolo,
> The CI is hitting the following new issue in rust/hw/hpet/device.rs:

Thanks!  I just saw it as well.

As you've noticed, this job is allowed to fail, because it's just making 
sure that we find these issues before they hit the "real" CI targets.

I'll send a patch as soon as it passes CI.  Let me know if you want to 
apply it right away; otherwise I'll send my next pull request later this 
week and in the meanwhile you can ignore the failure.

Paolo

> error: lifetime flowing from input to output with different syntax can
> be confusing
> --> ../rust/hw/timer/hpet/src/device.rs:770:15
> |
> 770 | fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
> | ^^^^^ -------------- the lifetime gets resolved as `'_`
> | |
> | this lifetime flows to the output
> |
> = note: `-D mismatched-lifetime-syntaxes` implied by `-D warnings`
> = help: to override `-D warnings` add `#[allow(mismatched_lifetime_syntaxes)]`
> help: one option is to remove the lifetime for references and use the
> anonymous lifetime for paths
> |
> 770 | fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
> | ++++
> error: aborting due to 1 previous error
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/10338038013#L5165
> 
> Stefan
> 
> 


