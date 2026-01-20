Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CEFD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7Mx-0007mf-Ns; Tue, 20 Jan 2026 03:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi7Mv-0007m2-M6
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi7Mt-0006ay-8t
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768898742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QgG7q0W10tQuzNuStZ7E7irM03N/F15g4y90H4yCy84=;
 b=gCxiXUIYnnvT1flw8I0eLLY6S/aK1AZrVEB3OZqqBpQWDvDVo8hsgnH4UfXM18ZsAbVtEL
 t6RuKT4PuzSOhhdCVHjRw5qaBLO0nXDq6Sv7mIP0YvmitLtlOpcEjVmKfq9UqOlIykEi1w
 Ag/vPy/R5ZOlP34+vVp/TU33k73tnGE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-pLytiIihO5O0ieSXCCDJ4Q-1; Tue, 20 Jan 2026 03:45:40 -0500
X-MC-Unique: pLytiIihO5O0ieSXCCDJ4Q-1
X-Mimecast-MFC-AGG-ID: pLytiIihO5O0ieSXCCDJ4Q_1768898739
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4801ad6e51cso44790965e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768898739; x=1769503539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QgG7q0W10tQuzNuStZ7E7irM03N/F15g4y90H4yCy84=;
 b=nqIKaXW+CaCn8ynllbXJMwkkEaZ4PgbByNB71aeTE7s5RgyK2ghm6OaG1Oz7itWztz
 gRzY/xaScFN/60vLdfMuTTA53qMLS3LAtsF6mfgz3X3Q/UsNlh1bNbz1JLvxbCMJxmyg
 Pv0hhKsiDorG4BCDmBdSNma+kQeMKF8OvTmW5prorK4Q9ZTxa3GZvAiXgzwnyP4fjLA1
 SOGIuP0hU5lULZ0wexirxPuftBfxOb5PkjjCTopkUBAnBTqNupxCAkWxuggpZvKfGgmo
 7FvDR5fpMeQKPI8a3D9yvR6rofCpDHWCLjWZXfCXuQYCy6Y6f7wke74Rwm1AfLlmrsWo
 QV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768898739; x=1769503539;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgG7q0W10tQuzNuStZ7E7irM03N/F15g4y90H4yCy84=;
 b=mcCEQ5Gw5hZ66MdiSChXexSLc62aIC/N2+WXeBE7h82pk2ILoPBSZ79d1N/+3/BIFZ
 fceXFjOEFZ4SPBe9lVTQl2pPX9w9NUZXI8MUop7VxqATi5SIF+86Y0OlLGEy4poMjGDl
 jTPYqApmYbEFsB6NfGeHkchbOeGHpp6zU1L1BN5o77NF6GKs1B9uEIGrBVfT81ZSWfQR
 6WSsvB8VSzUqn1H2oL8AZMv4+4bO0/4X/wzLyrVsEsiknVGOyO+J0O6+4C9OH4qRQVl2
 MkqRokWVLUR7f3E3Y2hmGURsAzskhK6PebvZ8nnITzg4sZzMBhw9VFqzI5vjocN7FAkN
 W7mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoGMBAaDkv2zfyz0/ZBs1NkmCI5SvFD/v5oc17nFYERkNUhZ+1YaLd0bCQfvS1nbssb709fUtUYI5/@nongnu.org
X-Gm-Message-State: AOJu0Yw60ARNuJaCRrYXjZZg1T2w8zNE2Ldali5YxwVud2ZobXhBkduW
 LWNIe/9QqyLJ3ztOBJWjEjKAWNXJBbB1JRs+vC7HQSNdkbg1mgD2R0EnFtzn//u5XzEPkTj8hl5
 kYjzEOeoAF8rOaWV1p9lGM0rIG3LjMica8UAYSESZHva0SEcg0nddCNCa
X-Gm-Gg: AY/fxX6gI3Yzdc6J/fAT1XeVttaeEBuNk+NAkRDcPK9OMydl31adG8RR3fb9t4PopIF
 Li1dv1o34S05wumKsxjQzjn38QSkt64QEASU4B1paeUfJIEZKlEx9qd+l5CX/MRRzQ0L51VTD1d
 qTsW2wKWW51W2Sv2gezSXFj10MrI0nI7/c4k8iapLMVKoNvkrnYmGLqfjl8J03yGSueHv8jA49Y
 iuzYc8mgmJx9wcaOZI00WJJMJ/D9mCDcqwniPmvRrnRBidGiTfIgUxETZjqrZpKzXVpC8e0aXnc
 VvSh98SDfYHjGC2orkvqiohqzgVRXqa/OKd2iwgNVnmyAUqMFo3K/g6b80mvKamzZGGcPwiDxuy
 Gp7iSx0hCQMWOAnD9296tsNmI1I3i+6MGugw=
X-Received: by 2002:a05:600c:3b9c:b0:477:af07:dd1c with SMTP id
 5b1f17b1804b1-4801e3495c1mr192966465e9.35.1768898738796; 
 Tue, 20 Jan 2026 00:45:38 -0800 (PST)
X-Received: by 2002:a05:600c:3b9c:b0:477:af07:dd1c with SMTP id
 5b1f17b1804b1-4801e3495c1mr192966025e9.35.1768898738345; 
 Tue, 20 Jan 2026 00:45:38 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c0475sm279443035e9.10.2026.01.20.00.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 00:45:37 -0800 (PST)
Message-ID: <33cba14c-d518-4191-b1dd-eccc3f3edbf2@redhat.com>
Date: Tue, 20 Jan 2026 09:45:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/17] tests: Use configured python to run GitLab
 iotests
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Ed Maste <emaste@freebsd.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-7-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260119212744.1275455-7-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/01/2026 22.27, John Snow wrote:
> use the configured python (and the pyvenv) to run iotests instead of the
> system default python3 interpreter. Use the new "run" script in the
> build directory to execute the command inside the meson developer
> environment, templated in qemu.git/run.in.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index e9b5b05e6e8..4c280dd29bc 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -350,15 +350,15 @@ build-tcg-disabled:
>       - make -j"$JOBS"
>       - make check-unit
>       - make check-qapi-schema
> -    - cd tests/qemu-iotests/
> -    - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
> -            052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
> -            170 171 184 192 194 208 221 226 227 236 253 277 image-fleecing
> -    - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
> -            124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
> -            208 209 216 218 227 234 246 247 248 250 254 255 257 258
> -            260 261 262 263 264 270 272 273 277 279 image-fleecing
> -    - cd ../..
> +    - ./run tests/qemu-iotests/check -raw 001 002 003 004 005 008 009
> +            010 011 012 021 025 032 033 048 052 063 077 086 101 104 106
> +            113 148 150 151 152 157 159 160 163 170 171 184 192 194 208
> +            221 226 227 236 253 277 image-fleecing
> +    - ./run tests/qemu-iotests/check -qcow2 028 051 056 057 058 065 068
> +            082 085 091 095 096 102 122 124 132 139 142 144 145 151 152
> +            155 157 165 194 196 200 202 208 209 216 218 227 234 246 247
> +            248 250 254 255 257 258 260 261 262 263 264 270 272 273 277
> +            279 image-fleecing
>       - make distclean
>   
>   build-user:

Reviewed-by: Thomas Huth <thuth@redhat.com>


