Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B9CD2D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdvL-0002n9-9m; Tue, 13 Jan 2026 07:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfdvC-0002kg-MI
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:54:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfdvB-0000A7-8q
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768308892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mZSW3/ZUk2ok+6+IBKVQ6VdtgLfxbWcsPvZz8Xf6Dgw=;
 b=N3f5TzA3nfTBSahX57AA5EXCt/Yp/m/ZrGwN7q13nhhoTIAPBEkedIpF0FIl2sMSGMFjpB
 P/DAypXz/aA1/YlR2ew19BnnT7JMmwqj1MTyhM2oNvemvwewxiaJM5uWHwbEJG/KD18Zms
 lCpWYhlk2uJwD5gaksThxNyR9zSwWpY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-EM1PL6WCMzKmPEbdR5mttA-1; Tue, 13 Jan 2026 07:54:51 -0500
X-MC-Unique: EM1PL6WCMzKmPEbdR5mttA-1
X-Mimecast-MFC-AGG-ID: EM1PL6WCMzKmPEbdR5mttA_1768308890
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d17fff653so33499195e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 04:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768308890; x=1768913690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mZSW3/ZUk2ok+6+IBKVQ6VdtgLfxbWcsPvZz8Xf6Dgw=;
 b=CLYOVR5A8hjO67Boro8e5ZtB6R+YKWMa5HUz8G2OetYHqhW+CmUC422xVAFaSivSQW
 J5+vU7Z6b+q1DfT01/9X2TE/YvyKl5TG6Pl5xdJjBFyjKXx5pzt/9K1xzBB8M+qMLL0m
 X0T53KiHqRVaAxsOM00EAI/GLrt4PB1HiTX1tnn9xzRjhj9QAThSG3WqXf0K3Kv4w8ci
 8xUZJGCruB2gl3KMfDsSYNjSq2R3pMzKXqbx09FWa9zNKin5ic74YT0qvliGqrhLIN2E
 MLUbbunvMbv79GkP49ePjUlLk/sH4pUpGshdb70iFbCyT70cJ7c20RFkle0RAzP3ZgRc
 dLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768308890; x=1768913690;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZSW3/ZUk2ok+6+IBKVQ6VdtgLfxbWcsPvZz8Xf6Dgw=;
 b=X+BEWVsEIc+/MMb5B6c7Ma/QS6Vf0uA3k9tjTv7e+c64QO9A8lxPjL1kIrH0yi+MHg
 a3+aZWGC9pgx+Wf02PwE54jpDbQ/lVvYOcOQJjz7or+KcHdx/I62/HDCw23GJSU2H1O5
 2WkmFp2xU+hYezap3MS92y5b+N/k/i72WjJ+mCNnwKU46irKGM1vJbDKC5KzcPEuR3jU
 /z5wbDrF7X8+uxdMF/XECSTHW+LNY4iOR6aBx5YoKAjRUuz7g1EnX/oOep7xSBuu9zBl
 xNL4aE3h2KjtBiOfjHxwFUv93vGg3LjmK54wCtSc7ycA2vV9kkcvn1G+5TZ/neYfOyRj
 adww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz2jHo6nJ4FzAaZKNjbqJ1Jxi5N0mhjH3UQ02nUGygSan1HKhfnxqR8+10Or9PqyvSdQ30FsnXW4QP@nongnu.org
X-Gm-Message-State: AOJu0YydoaLKqsluCHjffgS6Ysc1raN+zJaBJaF3fKzUzBe5zGL/5ahv
 SXYoau8JuHhHSX1de9KQ1mkKt7aPgLTgmeba9Jt9DgGpVu6uL4pw77u4U6M8Xw9LK8v56Ur89gs
 CCh3uy1o9dF8Js94YngC9hovtpfUS1qcj0dqcnJaubSDsTGsTIZF3KfT+
X-Gm-Gg: AY/fxX7SBmflLwCuC85CoXHUz8FPEj2gB3481G49f5XQgYWYMprDFf+IWRC4WZg0X/J
 GVORRIeAlvycSrYA9FRnPHHpMsLAq56CpJW6zVaCCk/IoeQ3YWxQFubuFeUHCZqxM2vdhG+/6el
 E5wRZ3bVikxtfPBIcbu73XtBl3ooC9qtY0j8P+gCVssAmheU8X3TEpJZ4lQKNiQtFex5Lvg14Tf
 11nR0xivTp8UAKk7Cwp4WL05IQ0HFUpMwfp9kBztM54turMisalMkq79IIdi76MJSDx/Fcz6q4O
 luRIMlYm82NETF54fNRki/jpDSvaHTaFXrJwM6JLSgUQ6+DCevpKMXo4dzL+yFyiyTl9ZxXn6Nc
 cGYASMYI=
X-Received: by 2002:a05:600c:190e:b0:479:3a88:de60 with SMTP id
 5b1f17b1804b1-47d84b3fa79mr221013475e9.37.1768308890081; 
 Tue, 13 Jan 2026 04:54:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpNAusdBmG6cjjk8OPK+qFIeyHFvbuQfHH1L2vOFqOjgzTl9qy6YZ2/7LptLEHKXwWpKjeig==
X-Received: by 2002:a05:600c:190e:b0:479:3a88:de60 with SMTP id
 5b1f17b1804b1-47d84b3fa79mr221013225e9.37.1768308889699; 
 Tue, 13 Jan 2026 04:54:49 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm45046971f8f.11.2026.01.13.04.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 04:54:49 -0800 (PST)
Message-ID: <8ae21890-6048-4a16-ad92-fb60f05685f4@redhat.com>
Date: Tue, 13 Jan 2026 13:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] tests: skip I/O test 128 on GitLab due to broken
 dmsetup
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-11-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112204026.710659-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/01/2026 21.40, Daniel P. Berrangé wrote:
> The I/O test 128 uses 'dmsetup create' to create a device, optionally
> using sudo to elevate privileges.
> 
> This works in GitLab CI, however, the resulting device never appears
> in /dev leading the test to fail:
> 
>    1..1
>    # running raw 128
>    not ok raw 128
>    ----------------------------------- stderr -----------------------------------
>    --- /builds/berrange/qemu/tests/qemu-iotests/128.out
>    +++ /builds/berrange/qemu/build/scratch/raw-file-128/128.out.bad
>    @@ -1,5 +1,5 @@
>     QA output created by 128
> 
>     == reading from error device ==
>    -read failed: Input/output error
>    +qemu-io: can't open device /dev/mapper/eiodev16546: Could not open '/dev/mapper/eiodev16546': No such file or directory
>     *** done
> 
>    (test program exited with status code 1)
> 
> Most likely the container environment the tests are being run under
> has a hand-populated /dev such that newly created devices from device
> mapper won't automatically appear.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qemu-iotests/128 | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
> index d0e00d24b1..b32e03beee 100755
> --- a/tests/qemu-iotests/128
> +++ b/tests/qemu-iotests/128
> @@ -73,6 +73,8 @@ _supported_fmt raw
>   _supported_proto file
>   _supported_os Linux
>   
> +test -n "$GITLAB_CI" && _notrun "dmsetup not functional on GitLab CI runners"
> +
>   _setup_eiodev
>   
>   TEST_IMG="/dev/mapper/$devname"

Could we maybe better check for the existance of $TEST_IMG for deciding 
whether to skip the test? ... so that this is also properly skipped in other 
container environments where /dev might not be populated right?

  Thomas


