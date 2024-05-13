Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC455C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SiG-00016l-DB; Mon, 13 May 2024 06:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6SiC-00013q-Lc
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6Si9-0006ix-B0
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715595311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ELwBvZjHAXIh0ulfKYUXGkbNlTNqIVRkEXcTM5WJgyo=;
 b=dwg+NKf6c6Xs+Hyru7kSNJtXp7FSHOpF4K2b7wLRJbX3fk1LLVXmdQmBTt8scjVQP+WL7q
 otlihzGNAh7TKCsoj4FugzvKa1gK2gWq3oeAp5KZ1Q8/rhQMK+LgFQLUCVKIUjkxca6PYp
 iWXGzRfK++mgx80S12D0znKXsb8EpN0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-_kYKwjEIPuO9BpYw-VcdcA-1; Mon, 13 May 2024 06:10:09 -0400
X-MC-Unique: _kYKwjEIPuO9BpYw-VcdcA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-61be621bd84so63856337b3.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 03:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715595009; x=1716199809;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ELwBvZjHAXIh0ulfKYUXGkbNlTNqIVRkEXcTM5WJgyo=;
 b=OrSFkaiD/UuC25kJliBs3e+nlOxZ45bnyH4FCuqYprR31MlZcLQH2qYXK5nH4OCv1v
 jJE0XprPPDQInRn6E+xjhle5pislsQZOnDg48JZg0qJxH3sUsIBmdNfH4dGCt/Xb43O5
 azjj5wdYzTwEhSesd7cldKv3cTbK2iWE52SZCgslk2uz84O/yPPTHsgs76EfqowJXr7L
 FTz7BvFseV0iUE5fPU+ikmqkAx1shw79bYl+pXHMsdG00NrTRFiHwmvaYzl2u2ySgM5H
 YbtTVLiimRvvX3iRnnR12hzEmmhfYcaLHESRbHQoUL2kuC0+rn7wB7lpSwER/H8VYDyL
 x3rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIziFkYNLWwim0ciEBm+hnbFMb/YwSu2iavAxG5KYOCCJwFKaLVeQLaEKp6wKTkvvpJWoPJ/u4WTJS2//1aCwEqSmrv9U=
X-Gm-Message-State: AOJu0YzIJUEHS3MwoxOY7xyU56Y55z/o+F8zvwtVoMNepuq8T3ONQAb1
 KuSLjcHfSG96Y+uedRlIIEK0dUrH2Lb5VYHMdafmj9chPTHY3DIcosdEIJ8xjcqcYgJ731IkSqY
 58p4DUEiFz+Hhp79r1TNqVlsbFZ8nKeooxnS7eas4RWZBsKde4VU+
X-Received: by 2002:a81:9251:0:b0:61a:ae79:816a with SMTP id
 00721157ae682-622afff7051mr73347357b3.31.1715595008969; 
 Mon, 13 May 2024 03:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs86pnyOrIHB4yIx5950DqNdMk4xbdii2tVQNzKjlBilyXbkewWzGcjTB8gYyzNhIXjQBXVw==
X-Received: by 2002:a81:9251:0:b0:61a:ae79:816a with SMTP id
 00721157ae682-622afff7051mr73347137b3.31.1715595008645; 
 Mon, 13 May 2024 03:10:08 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-109.web.vodafone.de.
 [109.40.241.109]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e17a8315csm12891411cf.32.2024.05.13.03.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 03:10:08 -0700 (PDT)
Message-ID: <db3f98d9-43cd-4dd6-ae86-a052e92d4b55@redhat.com>
Date: Mon, 13 May 2024 12:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tests/fp/meson: don't build fp-bench test if fenv.h
 is missing
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 michael@amarulasolutions.com, linux-amarula@amarulasolutions.com
References: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
 <63094227-235e-4274-b308-2d7c27e50b81@linaro.org>
 <CABGWkvrCNoWDB=V5f_7qwCd97dAfOC3XT2ukXYt-FsxuUKK-KQ@mail.gmail.com>
 <4ad368ae-74d0-4a38-b4d9-d907c1b8dc7c@linaro.org>
 <CABGWkvo_eaDFC15JQF8+Pu14M75CKWvVr8JWQ7XJuHc8fCc7LA@mail.gmail.com>
 <CABGWkvqXdJtiiO2gWC2VTcLvYD33KHe5Rb49Q=VDrtkEiODxOw@mail.gmail.com>
 <8b84b9ae-fda6-49c2-90dd-40d8660561c5@linaro.org>
 <CABGWkvom8s3KEV=9wKxp1=UK+r1jaOns9MqK9OhuMUyxVskznA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CABGWkvom8s3KEV=9wKxp1=UK+r1jaOns9MqK9OhuMUyxVskznA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/05/2024 13.09, Dario Binacchi wrote:
> On Sat, May 11, 2024 at 12:25 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/11/24 12:11, Dario Binacchi wrote:
>>> Gentle ping.
>>
>> Gentle reminder that I strongly suspect that your buildroot is corrupt.
>> There *should* be a <fenv.h> present.
> 
> I don't think so. In fact, the patch has already been merged into Buildroot:
> https://patchwork.ozlabs.org/project/buildroot/patch/20240502072327.741463-1-dario.binacchi@amarulasolutions.com/
> 
> As mentioned earlier:
> "The fenv support is not enabled in our default uClibc configurations"
> https://lists.buildroot.org/pipermail/buildroot/2013-May/072440.html

So the missing information from that page is: It's apparently possible to 
build uClibc without fenv support, it's only optional there!

So IMHO this patch is fine and should be included.

  Thomas


