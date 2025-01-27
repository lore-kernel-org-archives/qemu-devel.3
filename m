Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891E6C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 18:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcTWD-0006oz-Ub; Mon, 27 Jan 2025 13:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcTW6-0006oD-5p
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 13:07:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcTW4-0002i3-LT
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 13:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738001235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6S1XEQ7Hvz0clFy9W2EjoNLBv5AxebswTMQ0Ceu3bQk=;
 b=So7OgpDpYeuF1OJUkGhllL1o9Rj95TLTE21nYYrXSsei+CwNIcfjXlwbmTmahkfZuTthAF
 /tUzfN6jBdGzlmNFB8kNLadkY62x2kbuRT0JjJtnNq+FM24qF6jrNixYredd0Sor681Iz8
 Nn7BaGZKj4AxcKkNrb/Rw6gokkjHlpo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-lmFmmBLYP6u00W4U7RtY4w-1; Mon, 27 Jan 2025 13:07:14 -0500
X-MC-Unique: lmFmmBLYP6u00W4U7RtY4w-1
X-Mimecast-MFC-AGG-ID: lmFmmBLYP6u00W4U7RtY4w
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab6936cd142so149406466b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 10:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738001233; x=1738606033;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6S1XEQ7Hvz0clFy9W2EjoNLBv5AxebswTMQ0Ceu3bQk=;
 b=GBgSjmLIiUBksi5Wp/sVhXezN9GMDlv3GhizmyrEUJ3XkERt0q5fIu3ysv8eOactP0
 w2ox/de/JhpEZ42b0wlASiNvQRXk1bZjDBzrSKqAWicgDb639iLs2i42sRx0yikzsSj+
 YwzZB8h34nAZWePUfxoYq0LlvkQg9IUw62e4zqpXN4Wn2qq2In5UJxDJdIAxa1rJqlA9
 lEctQDaMpCzlCJ6rYu62cHE2m1bijadBXOZnckULoAxZW9vMl7MveTZoGmYwiiGjPAgw
 hUz8HlyVynm+HuwFauVCb/i3izZ/aYXeBtxfcBAfEt8jPI51zEgoPNUfOK43qzuQQWsG
 mSrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMiF+JRilEvyEnScyG/FzVU9V8IN0x0f2v29W+cDKRGp1FjaLy7/Y/33SAKbeX9HrIiotbHvRDw33c@nongnu.org
X-Gm-Message-State: AOJu0YxsnphI5egSQXp0B+X+KEJy1Lvi5U7Xv8bjDFmzvxfvUFDiwC9b
 uf7pZ0ktDlwNx68bquQmvVrsL3pAKZnxQTkCAJm9YSS6Z5pKjfhQM7lXsxVUAnfIoP4Smw95cYg
 PvhzxIey9dGGFWCFQZPWRWmwSLxgGK8Xkw0zJmwYyzLf8pSlPz7TL
X-Gm-Gg: ASbGncsuB2J9v3WhhsUlUPDphR8K4agHBOFuex6qcvvP8baXEjWi+1a/qtPq7XDaC0B
 ZX3ESFUkRLsU7kNJZMv0QD4WotQ/J0p/VPm7Jcw032HK0k0B/KnuGqSfLix2ASBCacxcGxesqJp
 fLQNFIcL7y/rOQmQipWbv99ZLtCDY+lbBGcipjA6AxNbSPqEOYbZrGAJgC0efuY0NYCIElfK8nD
 aa1JNVUY+2FVTVidk96t7c5YEHwPzjVHH7uuAUkBIXJDJarq2VaJGAyVG350LQfcLXbPa9rZh2b
 dfU8j+IXQKnzHU4eM7CaNjJEw/PImUnsPAeC
X-Received: by 2002:a17:907:746:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-ab38b4aa1c6mr3845943766b.49.1738001232835; 
 Mon, 27 Jan 2025 10:07:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGeS0oP+htg5YxkLIRFHXYps3Mppc+LaVEb78vsg/cYcVvXr9z7gE9IPXxif2JSiVOAdEbGQ==
X-Received: by 2002:a17:907:746:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-ab38b4aa1c6mr3845940966b.49.1738001232466; 
 Mon, 27 Jan 2025 10:07:12 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-134.web.vodafone.de.
 [109.42.48.134]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6760b6f4bsm629148966b.90.2025.01.27.10.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 10:07:12 -0800 (PST)
Message-ID: <28641399-021d-428a-a7b8-489d3059e79c@redhat.com>
Date: Mon, 27 Jan 2025 19:07:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] tests/functional/test_mipsel_malta: Convert the
 mipsel replay tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250124141529.1626877-1-thuth@redhat.com>
 <20250124141529.1626877-4-thuth@redhat.com> <Z5OzZrq7CRBICDyG@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z5OzZrq7CRBICDyG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/01/2025 16.36, Daniel P. Berrangé wrote:
> On Fri, Jan 24, 2025 at 03:15:27PM +0100, Thomas Huth wrote:
>> Move the mipsel replay tests from tests/avocado/replay_kernel.py to
>> the functional framework. Since the functional tests should be run per
>> target, we cannot stick all replay tests in one file. Thus let's add
>> these tests to the file where we already use the same asset already.
> 
> Are the replay tests liable to impact running time much ?
> 
> The test timeouts are per-file, which could motivate
> a separate test_mipsel_malta_replay.py file ?

The mipsel tests take almost 2 minutes on my fast laptop already, so yes, on 
CI and slow systems this will need a higher timeout setting.

> Guess that answers my own question. I'd think a separate
> file for replay tests per target is nicer, so we leave the
> default executed malta tests with short timeout in meson.

Thinking about this twice, it's also nicer for the MAINTAINERS file if we 
have the replay related tests in separate files, so yes, let's go with 
separate files for the replay tests.

  Thomas


