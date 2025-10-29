Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907BDCCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE0Gs-0005Cj-1V; Wed, 29 Oct 2025 03:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE0Go-0005CR-MV
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE0Gh-00053U-3b
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761721607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P+hBtwTnmYEwYpBYKrrVfy4QZP0aNmrBQvOEZ7NvP9M=;
 b=deC2n5XKHuD3KjgiD2jreYNztytWWOIAqFRMgbVqXlsW3+PEL7jPJ1PmBLHrLD7FmlpAM6
 dd0hpnUCw2QI8yvIXh2x3Cw9McVw2ordsTTfjj33MYcax3Dkj4vXOOmETvQegSun2T7+uR
 T03TZrSTSDvO0BKbB3iWsQJrNKTupc0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-wsfyayshOCycc_uX_TwRNQ-1; Wed, 29 Oct 2025 03:06:43 -0400
X-MC-Unique: wsfyayshOCycc_uX_TwRNQ-1
X-Mimecast-MFC-AGG-ID: wsfyayshOCycc_uX_TwRNQ_1761721602
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477124f7c00so11889185e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 00:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761721602; x=1762326402;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P+hBtwTnmYEwYpBYKrrVfy4QZP0aNmrBQvOEZ7NvP9M=;
 b=EryYDJUsn9Y+UozvnYd84K/7Vx48an+yEzWdgdChJ4lFFg74/MYNgvhY5iV4ouQK/W
 61nNV1duKnIPFsBcwUiEFu8wOO9eK1iOAHtZHtOLjPphzXKMWTjnaMGt67W47LAOz7IK
 5f0Pt99X13uwPui+svt2yN9xnPyRGdUFl9kO9vue0s9vAckDRJCTKYlbF6+ANBqI4Gcz
 X9NHw+7OSjpH3Vg4YDEkCbD2ISJOZWNxszwnLn4762A7cH0H3u3MlS/XkK0CZGZMKJm9
 1rutnljmr2CK44JwpiFJ8mqBFcL76j9nw6zSNrvwnCsq3VY+g+Kd4N8zN4PWgkrQbASe
 yk2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX21NC1qZfRxOfB0A16tu207jwIc7oWc3UZKNlmWOF+alv6jr/uDBTBZ/PDPnFGgvB877XCNgiGJ86G@nongnu.org
X-Gm-Message-State: AOJu0YwcSFks5OctqwX8BQUz3SeBSDM24Hl8xgMrjC+99I9EhXCY+lLD
 KKcJvKrW2BIHNxoV70WN0eNl+Eev92dCThLwaYyaM3TmsAMHSg4N6CIMd1884DabOLks1elJtL2
 ljPv/0Ac8lHH3whsF8W4kWBDTeahK0FriZ/6o4M5FfrnQjHq60x3UFTZb
X-Gm-Gg: ASbGncug2bjDEunqvM/IK2CbEVQ8AqepJAHoosE+BBhO8vCHM3z4czLRUVFOBFJt+R9
 RejtkCVgaz6gCldHKbAinwm46PKeyir24KaVISgQGDB9i9JtcjPpHdqv2tG+qdHnDrmivC0CVi+
 z5r5dCZUJw6L9wI9H0Tk+GCODnCVfCyeWXLWL9YU7qDGdZv5TeGEsjnpCpO34BYdSkRIHT9w2m+
 nIRB/5Lar89w+pHcGLUoWnpJ7EGPXvIVxZRFeItxW5BA6ZfWDmiOHmM7Lz322GLdWs0gqRjiYUt
 oflmOzXFm77umVSuCbZQXEMy8jEi0ZI+9qle5fQ2z6tugtfveHl8eR0XTNoXVColB8bi6rU=
X-Received: by 2002:a05:600c:a087:b0:46f:b42e:e367 with SMTP id
 5b1f17b1804b1-4771e2639eemr13965175e9.41.1761721601853; 
 Wed, 29 Oct 2025 00:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHP0API+j2IBjmz1UpXHcOBpbsLgcu0HPN4r28dAw4qlh2Zc3NhYrRGHHELjmqA5ZOUSgQjg==
X-Received: by 2002:a05:600c:a087:b0:46f:b42e:e367 with SMTP id
 5b1f17b1804b1-4771e2639eemr13964985e9.41.1761721601492; 
 Wed, 29 Oct 2025 00:06:41 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e387caasm31379235e9.1.2025.10.29.00.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 00:06:40 -0700 (PDT)
Message-ID: <4c03b66c-5e0c-46cb-80d3-e91a67d4e532@redhat.com>
Date: Wed, 29 Oct 2025 08:06:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: include logger name and function in
 messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251028182651.873256-1-berrange@redhat.com>
 <20251028182651.873256-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028182651.873256-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 28/10/2025 19.26, Daniel P. Berrangé wrote:
> As we collect debug logs from a wide range of code it becomes
> increasingly confusing to understand where each log messages comes
> from. Adding "%(name)s" gives us the logger name, which is usually
> based on the python __name__ symbol, aka the code module name.
> Then "%(funcName)s" completes the story by identifying the function.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 2c0abde395..6fc6e1ac0a 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -217,7 +217,7 @@ def setUp(self):
>           self._log_fh = logging.FileHandler(self.log_filename, mode='w')
>           self._log_fh.setLevel(logging.DEBUG)
>           fileFormatter = logging.Formatter(
> -            '%(asctime)s - %(levelname)s: %(message)s')
> +            '%(asctime)s - %(levelname)s: %(name)s.%(funcName)s %(message)s')
>           self._log_fh.setFormatter(fileFormatter)
>           self.log.addHandler(self._log_fh)
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


