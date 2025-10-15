Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAC7CCD190
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 07:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8vfV-0002Zc-Ld; Wed, 15 Oct 2025 03:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8vfR-0002ZL-OD
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8vfO-0000KO-0g
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760512276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C+lt9ANCcGuFJBSXyUVA8gA+iQmsKRr/KNdFIEUlhcE=;
 b=NkSxHulEQpJgL/5+Ub7XnwH7fByTgMFKLX1Ax+WVXO7/ru2fJpIOcc8QjmNWnz7DhHC6zr
 rGg/65Hs6B1hVk9shk9f6olitd9octbNGcoCyTtG+yHOmzIH5LGuRPV0+wvZ8hTw1dfx40
 5tgO3C30fiAwmMcbVb9GvtvtTPZ5Pnc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-_IWUq-npPJOcJX5X3oNBTg-1; Wed, 15 Oct 2025 03:11:15 -0400
X-MC-Unique: _IWUq-npPJOcJX5X3oNBTg-1
X-Mimecast-MFC-AGG-ID: _IWUq-npPJOcJX5X3oNBTg_1760512274
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e44b9779eso35191325e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 00:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760512274; x=1761117074;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+lt9ANCcGuFJBSXyUVA8gA+iQmsKRr/KNdFIEUlhcE=;
 b=kRcu9JfudgloWSu5WCNtyk9c9esS19JpD85snltL8dT+z2XukCT4SeH33JjaAJYrZ0
 6XfI+ZpAC4GElLqBP5nLVVEIZpUx2vf82YZYQRGlbqTymZxD5ujBj8fxOLz5Zk75S47E
 AKLiIEefXxTms22gzIpTisHTDzC+yTwPdwT07bv390I0Q9EDBHPRh/GvIfO++nNUZ36z
 bdI+5JL9VI+/341B44WDieSCIex0WbZR+PnUD9Z1SVtxiFLzTg21dw3tZBLyRO4Z7Gna
 X0akVqC1QfrIVomgiSIr6sLrRt+aMX0rJ9LYmA0qwLZ0oPQHQtQb1NChjOBuenU8ZmIA
 Yn5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeY1mMJ3D077ShJ5RIce2mQnrL5STd9DPwV/s9uejkZwdY8lk6gMbVHgo3CD3HHajXFit1Zf/SkxVA@nongnu.org
X-Gm-Message-State: AOJu0Yw7SXuyxsc6snKz4cQ1OVmGzHqj0yDuStddCCU8gOaD8RhV7JU7
 Ay4GDRP6jc19wT4oI+VGiO2UyVZDqupour3/mkO/afbXrgsqIEiSX+nDqRRhSV7wu4qfqdNMk0y
 A1YUAuy5RaUyoI2YfdM7a7Xns9Z1fKa60e+lSg9SWYSTizLfq0H/UKPNR
X-Gm-Gg: ASbGncuUFXNN7oPMJ/y2V6rlHUDkwCI1r9Z+mNJglvU6pmfKb0IQ/TgHAQQMLjPoPEK
 Imrh+db2T+U0fyey95wUyH+ADGXNhnyDq8NhljEN0xMfNu/BXXIzNkJT8pEJQtvPRwBXFA4sDyt
 Rv7GclMt6rhDsiD1sgCnwqEkA0w2HvR30ET1ZdwcLi6zbSIOUdXyfhJN0ZAZ4M1thl7fQ8Pf5bc
 ki7gVw3ugk95He3ukpsy5MyGmw+7OMOHbvT23HDyCq0EuFb5sT1Ogkz7r8GymNjgc5uRAJ+BHsW
 5ZpdDC6AUzeoqRpdiR0t7bb8SfSvG7A3s6VJ39B4HISM1Cv4NejUyB9LdXYeOAoRNonxwW+Uasj
 ldP3FMg==
X-Received: by 2002:a05:600c:8593:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-46fab89b7a0mr127386585e9.22.1760512273930; 
 Wed, 15 Oct 2025 00:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ2huJUUE1HrUYazB5/yoiYPlU4Spcb+XitANjRpNXLcFbBFQ9nDh/Sf2lMt1xvKc4Y3Qn+g==
X-Received: by 2002:a05:600c:8593:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-46fab89b7a0mr127386355e9.22.1760512273560; 
 Wed, 15 Oct 2025 00:11:13 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47106fc96bbsm1368555e9.3.2025.10.15.00.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 00:11:13 -0700 (PDT)
Message-ID: <7be48ced-52c0-4526-bcaa-632165408396@redhat.com>
Date: Wed, 15 Oct 2025 09:11:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/19] python: backport 'protocol: adjust logging name when
 changing client name'
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250916162404.9195-1-jsnow@redhat.com>
 <20250916162404.9195-5-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250916162404.9195-5-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/09/2025 18.23, John Snow wrote:
> The client name is mutable, so the logging name should also change to
> reflect it when it changes.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> cherry picked from commit python-qemu-qmp@e10b73c633ce138ba30bc8beccd2ab31989eaf3d
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   python/qemu/qmp/protocol.py | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)

  Hi John,

there is a regression when running "scripts/device-crash-test -q": It now 
prints:

ERROR: Negotiation failed: EOFError
ERROR: Failed to establish session: EOFError

all the time. See also for example:

https://gitlab.com/qemu-project/qemu/-/jobs/11715477453#L145

Bisecting the issue pointed me to this patch here. Could you please have a look?

  Thanks,
   Thomas


> diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
> index 86e588881b7..ec4762c567b 100644
> --- a/python/qemu/qmp/protocol.py
> +++ b/python/qemu/qmp/protocol.py
> @@ -217,10 +217,8 @@ class AsyncProtocol(Generic[T]):
>       # -------------------------
>   
>       def __init__(self, name: Optional[str] = None) -> None:
> -        #: The nickname for this connection, if any.
> -        self.name: Optional[str] = name
> -        if self.name is not None:
> -            self.logger = self.logger.getChild(self.name)
> +        self._name: Optional[str]
> +        self.name = name
>   
>           # stream I/O
>           self._reader: Optional[StreamReader] = None
> @@ -257,6 +255,24 @@ def __repr__(self) -> str:
>           tokens.append(f"runstate={self.runstate.name}")
>           return f"<{cls_name} {' '.join(tokens)}>"
>   
> +    @property
> +    def name(self) -> Optional[str]:
> +        """
> +        The nickname for this connection, if any.
> +
> +        This name is used for differentiating instances in debug output.
> +        """
> +        return self._name
> +
> +    @name.setter
> +    def name(self, name: Optional[str]) -> None:
> +        logger = logging.getLogger(__name__)
> +        if name:
> +            self.logger = logger.getChild(name)
> +        else:
> +            self.logger = logger
> +        self._name = name
> +
>       @property  # @upper_half
>       def runstate(self) -> Runstate:
>           """The current `Runstate` of the connection."""


