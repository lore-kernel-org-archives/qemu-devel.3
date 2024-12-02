Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D1DD3B7F7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 10:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI3IP-0001Zs-C9; Mon, 02 Dec 2024 05:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI3Hw-0001YT-MQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:04:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI3Hu-0003wr-4A
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733133856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9SIp1QJLIOTJEIry0LnV3/NUd5iSDXOzV6cPlYtpTsA=;
 b=bz5bG1MMX+j2DASsRq2sbN6/x595tKJ6BSt6H1JV2wJcAg3R1SKjnGValGVEV3JsRToPdi
 bdY+EDdwDb4cTRKlqWhskat2lNcWTJ1+PX5UUVT7aTznCYso4PTuQuKbvrU0kxTzK6HZuy
 N+d3Mk08nGSGfv0sQW1oTfx6NSzenJM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-GUz_7XfIOnSwRpxApx9Fbw-1; Mon, 02 Dec 2024 05:04:14 -0500
X-MC-Unique: GUz_7XfIOnSwRpxApx9Fbw-1
X-Mimecast-MFC-AGG-ID: GUz_7XfIOnSwRpxApx9Fbw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4349c5e58a3so32910845e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 02:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733133853; x=1733738653;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SIp1QJLIOTJEIry0LnV3/NUd5iSDXOzV6cPlYtpTsA=;
 b=HDes5o9+/ErEQYtMRryWSgUxDmVaZhVEV4FPW+4w4IPojO5Uvn+B8ZwCp85WGYXcYd
 i+4ywA3+dUjLOzCalgkOP5VcrWhZ4iHGxk5SZOGOKzuD8ubJllGG/MX0n/eDwnjCRFAX
 cjzFLzjoGZ+UDBkNaazwLGh+j32T2gjnqZBsC+FHhG0VDJyKPfOE8bhTpBiOAUrAQ5b/
 mLpSsRyWFEOgVYykPmwPhnIWAOHSTiPN1laIWJEvntD31+uTnG4KRrWYJjwbInDbdO/4
 g4+7XeWmVZfeQH/g5ga2c7nMxX4pdStz951wXUd0nn+rZkMIEFh+YfO18esmGT3m6NZq
 MRlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtNnT2zNsnIT1IUVWWGHfc/sfeD3JjLGVt8l7C6cCkr7rIOyuWxopdU7LviuSEOX/y3CZWxCboNu7w@nongnu.org
X-Gm-Message-State: AOJu0YxEC1ayz/DtKuAJNOZP+d/upXIiCwJe63dnD3SPpJUTU8B0+U6l
 bA8GWdLGN/HA6BBRTmRaz9kRUKOWZd5cJouc/SjHBlYMQgAexR/HK/gFH3vjBx25QEhli5VMUPd
 u3L4UsGAp/Zw6in/O5i3/4lqDMeTwH2JweGchiiS7TKUE12INF3pE
X-Gm-Gg: ASbGncuoeHSm53bPPt8PuqcwYDeT976DNVJa9DPKkliFy/09gsLhf+AF2QGttubqCz4
 lu7MM5qdHRE+9kzvKAhTQ8Fcw02/MXlGmwobO8GmAwg5OT++NJXZwXNd7zSz6QqLQSBbcyB2puQ
 fhjGT1NCKyisw9S2c6StecizMBt+h3EnlOc4sxmj9AjK4U32MmmcAO2DuDT0zRu6IR9xotg9GPS
 CEJLzJMvfHV74xH/8/G195ajudo75IiSEWW176xRe4KqiR4pR8gitj6BJw/YF4v0s5+Khk1J4w=
X-Received: by 2002:a05:600c:4f85:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-434a9df22c0mr224901375e9.30.1733133853657; 
 Mon, 02 Dec 2024 02:04:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXOdT3sBEVmBPqI0Tag94Z7Vwu7ci1YM89kjRpZzdGEG34AAJSvfRnwQW2Pk1ZESiRkfgHsA==
X-Received: by 2002:a05:600c:4f85:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-434a9df22c0mr224901105e9.30.1733133853350; 
 Mon, 02 Dec 2024 02:04:13 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7804fbsm181535935e9.21.2024.12.02.02.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 02:04:12 -0800 (PST)
Message-ID: <068fdd45-924f-4dd5-8bb4-447402f1c5e4@redhat.com>
Date: Mon, 2 Dec 2024 11:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/22] tests/functional: add common zip_extract helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-16-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-16-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> This mirrors the existing archive_extract and cpio_extract helpers
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/utils.py | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
> index 1bf1c410d5..41bd1df666 100644
> --- a/tests/functional/qemu_test/utils.py
> +++ b/tests/functional/qemu_test/utils.py
> @@ -46,6 +46,13 @@ def archive_extract(archive, dest_dir, member=None):
>           else:
>               tf.extractall(path=dest_dir)
>   
> +def zip_extract(archive, dest_dir, member=None):
> +    with zipfile.ZipFile(archive, 'r') as zf:
> +        if member:
> +            zf.extract(member=member, path=dest_dir)
> +        else:
> +            zf.extractall(path=dest_dir)

Don't you need to "import zipfile" here now, too?

  Thomas


