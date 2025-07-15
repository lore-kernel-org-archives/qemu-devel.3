Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F87BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhTa-0006q6-OR; Tue, 15 Jul 2025 11:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubgzi-0004sF-7M
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubgze-0003yh-W1
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752591051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7N4xmbg6p3srq6FDQ/U4iBTd4b56Af3mAvWlJioQKWM=;
 b=YA+I5hxfv5mkEqE4Ja5WVRK69XarTyCq4YLqhSus9CKTKeyQlJG8Ra79xOvQl5xBRn1Ein
 hCU4IOZ4jGCU2zc1SIENca8KkFQuo5pAKuXvULgDpLdTHG1wnNa/bB2I6MwVSL4DKcnBdZ
 +1ju3ERxUw3x6O/ViRWLdK29zxxyfQY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-w2_LETniMXGDAlC1IUDEXQ-1; Tue, 15 Jul 2025 10:50:50 -0400
X-MC-Unique: w2_LETniMXGDAlC1IUDEXQ-1
X-Mimecast-MFC-AGG-ID: w2_LETniMXGDAlC1IUDEXQ_1752591049
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a6d90929d6so2510052f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752591049; x=1753195849;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7N4xmbg6p3srq6FDQ/U4iBTd4b56Af3mAvWlJioQKWM=;
 b=nesDhHwKE6wkH5GBEeO3awSbTeFqJHckynBDWPviQdgaqf0OBDJEG/SIWPCw4USjNd
 2sjZyOhp3VfrY7LLbff9wfcWd4IYJpSGFmiATwkUt8XHv7sNR3FfqJbeFc4itDCNvpHm
 YcDvwh7RQaxsR6A0oOZNzCT4TCEaOLK4/2YkQjjcuQmmzjFryjm3lDmJKOApOWFuoE9S
 yR/a7aMu2ZqTVTVbzYA2FTGvGuAmB3lYtRAppqksqkSlDgNm6sKOAMtL3sijzttcNnC5
 OeTlNB0m7v0hQx0AwdjT+rO8Ml9IiN0/zzzK+M8PjJFPji3VKv3F2nIfSXEFO8KmgRpe
 C3Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBmraMyrZD+jjoyjRG8UGu1mnX7BBSULZk3u78b62lFwJlNodeq+CZNPW3Fi2H55Ofagry5b8SIfNk@nongnu.org
X-Gm-Message-State: AOJu0YwLbyjkiAJd3ywY1vUgduF2yc5mMpFY+1SvYyEGzMUP4mUGlNUI
 fuHrTfvG5aMiH9fEjGVeGdoi0cF5SEDjKK/6nWz0hEOIqjOWwhS35HFeZ7w9TlSanZASvzW4akq
 qrRpl7lXg/W/jZKbGVLcbr24rF3UDZuEIal9Kymh9F7PZGGD84WqTq9rAGBkpi00t
X-Gm-Gg: ASbGnctlbWsgvQt9REO6XCG/LPTuT3S9R/N5rIMEQO0SI9q1UyAqK3nAEw7hPzTgh48
 llHaOAHzVNlIq5vY/3DVb0AaZjgRB/UOMkQrop8gfINhsQYWpmZbl/L6u5vzYL+Xc20ittnODFF
 L9f76S/T46+pHsbs7LrZwyZdf45QpxToOWIfoPn5oJYNVERlj6ukfSSYelOqtvNsR6QMjqMUWA6
 q5S4AwgfXs1w11WptllCVt2O0jzRvq/ERhppdBNYSwjxe4r+PXIWX4n8A3UuT3wnPatXtze08eO
 qxv+oXfdEbj8Sc8VxSGmPcJwIIKwVZ7iqMcB9W3Y43T278csYhrBAHEujB+vbJiFvn80VcheqOx
 jgTkc
X-Received: by 2002:adf:9cce:0:b0:3a4:eae1:a79f with SMTP id
 ffacd0b85a97d-3b5f2dfc56cmr11300449f8f.33.1752591048892; 
 Tue, 15 Jul 2025 07:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3xm9YV263MIDIvMIYO5uuwLOjZ7XX/cVR/tgk05V2qhhAwXr9fM+3J5NpZNAil5A8uJE9sw==
X-Received: by 2002:adf:9cce:0:b0:3a4:eae1:a79f with SMTP id
 ffacd0b85a97d-3b5f2dfc56cmr11300417f8f.33.1752591048429; 
 Tue, 15 Jul 2025 07:50:48 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-130.pools.arcor-ip.net.
 [47.64.115.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14d12sm15478734f8f.70.2025.07.15.07.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 07:50:48 -0700 (PDT)
Message-ID: <769262a2-4c4c-45cd-a223-2e849a39aeb9@redhat.com>
Date: Tue, 15 Jul 2025 16:50:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] functional: ensure log handlers are closed
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Jagannathan Raman
 <jag.raman@oracle.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-9-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250715143023.1851000-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 15/07/2025 16.30, Daniel P. Berrangé wrote:
> This avoids a resource leak warning from python when the
> log handler is garbage collected.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 2082c6fce4..71c7160adc 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -232,6 +232,7 @@ def tearDown(self):
>               self.socketdir = None
>           self.machinelog.removeHandler(self._log_fh)
>           self.log.removeHandler(self._log_fh)
> +        self._log_fh.close()
>   
>       def main():
>           path = os.path.basename(sys.argv[0])[:-3]
> @@ -399,4 +400,5 @@ def tearDown(self):
>           for vm in self._vms.values():
>               vm.shutdown()
>           logging.getLogger('console').removeHandler(self._console_log_fh)
> +        self._console_log_fh.close()
>           super().tearDown()

Reviewed-by: Thomas Huth <thuth@redhat.com>


