Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4EC606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KpAWegbF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eRMwUB0O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJtPK-0000RM-N4; Thu, 22 Oct 2026 10:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJtOr-0000OH-Sh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 10:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJtOq-0007f8-3x
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 10:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792677846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Te9/+mTzMJtO3zMi+HZSwVvJuMI3yHodGaZCpSdi2xM=;
 b=KpAWegbF+SZTOlP+BdFwAZnH1XHLbLqhXfeNviA19QXJ2DWJP3Ki9pgq9ovpRi7/bD/Vsi
 /sjmjVZc69lOsgWphYF6IzOjGH7JGe1pRUkcLXl7Sey94PMxr10BVK4bWksyCHuY0S3jT3
 szVfqVtNK1o2GK/1YzC3Up7tTkW1BT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-TTE_dDpINxGF0raHKA6sIA-1; Thu, 22 Oct 2026 14:04:05 +0000
X-MC-Unique: TTE_dDpINxGF0raHKA6sIA-1
X-Mimecast-MFC-AGG-ID: TTE_dDpINxGF0raHKA6sIA_1792677844
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1e6ae710bso14017355e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792677844; x=1793282644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Te9/+mTzMJtO3zMi+HZSwVvJuMI3yHodGaZCpSdi2xM=;
 b=eRMwUB0OPb1fCFlp1BHwvU17pS5OPYGJ4z4k57fKjGVW9rwxYYyyH43vj8SX0TxEPr
 a6M6J6Ws7dqteclG92Xk5lS6UYU7XxuX7iW4kgmeyG1gd0lbzzAzXyz7bJd97+eyT70R
 K75x5jk7iwVg1W1cLuScdFlHvnoPKDGo5ks/76oxfLfb4QkXrijc48m1gRVWotXJEs9m
 5d+uJ1LtDe0hePRPcuTCmQTkq6q4c2wQu5XoEh+Rd3lYpC23B3GVhg4wiXZJHQZ2/iM1
 mrUlunaCuwNl0frjX2eNibIQm1WwJQFmcZixEmcJtK74cHfy6mUlDpSdptnOB4LY9sya
 P0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792677844; x=1793282644;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Te9/+mTzMJtO3zMi+HZSwVvJuMI3yHodGaZCpSdi2xM=;
 b=C29HMTaDGe4dET14Y7mdDMlQFEkBzO0i6QJV/1jTMKo7Wh18BAoyD0NLvk+QZp745m
 CU+fBicNU4OXrTSEYYmpluT37HI4HJVAOLAaJs4CgFKUffbHwx1P8v8c2tBqgsxAkicH
 SBpPgawR2rg8a6B2mlO1foyJ5zkGDaH2zKfNiimtVZ/y2A5S+315uCjQ0yb2ysbRkuBT
 XTNO+xyriExgwM9FZLfvxpNzrhGNLWZYFS9TAO/jnpESWHaU7obdlw4u9MjkDz/tRFxz
 GjIVM/rcUE2PmGnnEWIJzPI7Y5BU4RnnwzfLqYIyhIamYes/XF/85BuVt3L1ei+CaYaK
 jn9g==
X-Forwarded-Encrypted: i=1;
 AKwUvByMGAgTVUSxhw3jlUdTdSI0ZHC8mHpFjBg0ROtg+CzXqmJ+nfMCndECM5mv2dSKRh/CKOmfjykeCD/A@nongnu.org
X-Gm-Message-State: AFq9FYK5vjvPtOdvFxnR4DhQSenhu4zNoaed5aZOTRB0VKJaNIeH7zGq
 LDsmQEY27rXfDzcWdPt7whxpsBBPtkfkou4wV37frX1z6n+1CiYdpT1NPLzk1oCZw1XQLPvt11K
 iXpOMR+Unl+51Ef5r4V3FT7sLFQwNbPoZ0wU87dp2UjtaHW/+kIheMEAT
X-Gm-Gg: AYBFou2+vCN9mDjdgQqq/LlMWBFWtNoZg7R2VGahYGJZ8JaFC/vyCpUEekqW7dzsaS2
 m4eK5YGexEiePPsoyHX35f5Qz9d02oFGCS2ahMWwtEJ44zStSoV3Z7QZNN5cdKLrzElNVUw3ipu
 7K/yKQcQcIj8/jNZsp/m+/Ce6kkq7UjCos7OlEkPKSr3IorR0G+PwNWH/t4KCXAZuYhzzCoelAx
 R+HjuNKA4J+BMkrh2H9NizH3lGja5MCkEBM/MmCuxL4EvgN2R3pHwx9cyj2mkoqPn9CPhQkBtHb
 9ZqyUKE+tQfBHUUw8UZlv5Mn5Nt1wwuqJFzsSXIAaDg+OzCeoYqVYMhfP5SWKM4RV4Pxdbw=
X-Received: by 2002:a05:600c:b86:b0:4a1:90d7:88a8 with SMTP id
 5b1f17b1804b1-4a1fdd32c79mr108013155e9.25.1792677843704; 
 Thu, 22 Oct 2026 07:04:03 -0700 (PDT)
X-Received: by 2002:a05:600c:b86:b0:4a1:90d7:88a8 with SMTP id
 5b1f17b1804b1-4a1fdd32c79mr108012535e9.25.1792677843223; 
 Thu, 22 Oct 2026 07:04:03 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.93]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e2esm12311795f8f.30.2026.10.22.07.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 07:04:02 -0700 (PDT)
Message-ID: <5799c2c1-e589-415d-96fb-5eae4700202d@redhat.com>
Date: Thu, 22 Oct 2026 16:04:01 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to start with QEMU
To: Ankush Mondal <ankushmondal1y2t@gmail.com>, qemu-devel@nongnu.org
References: <CAEw80_3juSguzQARd0jLxrvRXi09-9A9pYYv-dm8Z0bc7LBDwA@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAEw80_3juSguzQARd0jLxrvRXi09-9A9pYYv-dm8Z0bc7LBDwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/2026 15.03, Ankush Mondal wrote:
> Hi QEMU Developers,
> My name is Ankush, and I'm interested in getting started with QEMU 
> development. I'm not sure if this is the right place to introduce myself, 
> but I wanted to reach out to the community.
> 
> I've cloned the QEMU repository and successfully built it. I'd now like to 
> start contributing and am looking for issues.
> 
> If you have any recommendations for issues or advice on where I should 
> start, I'd really appreciate your guidance.
  Hi Ankush,

we've got a bunch of smaller tasks in the issue tracker, look for the "Bite 
Sized" label:

  https://gitlab.com/qemu-project/qemu/-/work_items?label_name%5B%5D=Bite+Sized

If there is no assignee yet for a ticket, feel free to drop a comment in 
there, then it can be assigned to you!

  HTH,
   Thomas


