Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01F5C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 11:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbIvt-00052z-EL; Sat, 17 Feb 2024 06:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIvr-00052K-CD
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:32:35 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIvp-0005OO-Li
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:32:35 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e141a24ba1so797530b3a.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 03:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708169552; x=1708774352;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WTP5WYoW38VAJ2M4rCrKOAagIbZy5xjZ6LLGHfBB8io=;
 b=SM7rG1DcsG9c32SNvuUlChxjhdCge4NqBaO5CrxOV5Vvy4Dnnq7n0xUPsp9SlxwsPN
 I793/FvVs9Za/NDT/qVy7hm5oxLOtiYjXsZnkq6lt3Q21djKRDWqzs3HzFyegKmN85mN
 eR3LyPktZxHRTZiEXeroSIs4JSfWHFcys5gKh4197tFoGuE5z6sRG8QDgKAlWnpd3rj7
 Ng536IeuSK9JWzbkKMwwEKxtBRacZXsnU2tTORgs/O2wkEOROaY+70w+v+Ho5AOIEBvM
 F1QnopYG8jqEdYbp5HPVjqqWyCnCIRZ4lRuWylh5kTVHlK0uO0Ca7uEPcKil5TmhDDZd
 bRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708169552; x=1708774352;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTP5WYoW38VAJ2M4rCrKOAagIbZy5xjZ6LLGHfBB8io=;
 b=DhPzoCk6PNtgRJo+xGtNd7GAhgtLohXKqA/z6gZndYvd55NYRQPe0GhnYju6jwrsvq
 qPy9iDxr1OPyx7upBztEwGP7B+C8McFRjZw4Y5k9cPb17MlTZTB3DnDhivlCrkc8MePC
 8RxNEUn0Vd4W+ml8tOWPkCFkQdReVezq9IjVX+Fu2SW0L+SSPmPVnBydfBTTTViVzSj8
 H847xLWO5sJkF+Ds9Pphgk2YrwvZJkuQ+ebzoFUFqFKSgQGAGXRvCqKQlDdR9JfKxvQi
 BeWep4adQ1pOvfbqNp34yVEq34QiMetGKxp1VTFrncrya2TLnJcRBS6/vEnRbR+JFDuN
 oqfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIBt9WZdfIewPBZfZWN7kXuXVXqlwAqdzaKWHMrNHTQyfR2ggoe2DYPqMn19kTYSPB/LkVbRYsa2bqa7u3aIwHxp0DDJ4=
X-Gm-Message-State: AOJu0YyqEbZ1mH/oRD/jrHaHu1EC+X1jd6hk8LzkHaYkRwJ8vxLqwgjq
 elf1YROypNszmU2fxqZ+W6t4JfaoQ22NVwbwrtVz0+G4WeitT676bvKN33LUMn0=
X-Google-Smtp-Source: AGHT+IG07X4pF+sFVVdjTHPAQaWI2uTPLIJIWWV8KWddAZbeRZtxQ6sGqFpzZrYC6V986ZVsQLUyuw==
X-Received: by 2002:a05:6a21:150a:b0:19e:9885:1077 with SMTP id
 nq10-20020a056a21150a00b0019e98851077mr7634259pzb.43.1708169552292; 
 Sat, 17 Feb 2024 03:32:32 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 by41-20020a056a0205a900b005dc4ce8d2a4sm1203985pgb.58.2024.02.17.03.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 03:32:32 -0800 (PST)
Message-ID: <795247c3-f79b-4385-8bea-0de9c9a8d554@daynix.com>
Date: Sat, 17 Feb 2024 20:32:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] pcie_sriov: Validate NumVFs
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-5-89ad093a07f4@daynix.com>
 <bd6328d1-6568-4ac1-9be4-293bccc722e3@tls.msk.ru>
 <56e83476-f607-482e-a9f2-e473148de839@daynix.com>
 <0282c0e6-1e1b-4960-ad74-3e186062b4d7@tls.msk.ru>
 <20240214105534-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240214105534-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/15 0:55, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2024 at 06:53:43PM +0300, Michael Tokarev wrote:
>> Nope, I don't remember how to request a CVE ;)
> 
> https://www.qemu.org/contribute/security-process/

Thanks, I requested CVEs with the form.

QEMU doesn't have any list of features without security guarantee so I 
think it's "kind" to have CVEs for any features though I would certainly 
add igb and NVMe's SR-IOV feature to such a list if there is.

It should be harmless to have extra CVEs at least. Well, some may think 
all CVEs serious but that's not my fault.

