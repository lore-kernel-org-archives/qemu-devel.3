Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF703D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7Yo-0001r5-Pe; Tue, 20 Jan 2026 03:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi7Yo-0001qd-2z
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi7Yl-0008Ue-HR
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768899478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H4HMpkCXcCJVBacEIR06QdRrHr96iJxVyCvWvPOu3Aw=;
 b=dNVPNoU0WJZ+yNl3BGIxx/MCekUOzwxPYsklhdKbNruIeaXZTEhPSEic4Klzp1EyX7+KY1
 sSl925X1TsWDUOfoFnG77YFj984KFS77W4XjSEkTQ/O/g1FPy9dQAnxyLeUPQxm4Nly3rA
 X+zSZ+cIoeKwIyP43ZeZ2lcvVGlG9bY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-eLq1EaRTNNuQfL48OGGzgA-1; Tue, 20 Jan 2026 03:57:56 -0500
X-MC-Unique: eLq1EaRTNNuQfL48OGGzgA-1
X-Mimecast-MFC-AGG-ID: eLq1EaRTNNuQfL48OGGzgA_1768899475
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee868f5adso38533965e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768899475; x=1769504275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=H4HMpkCXcCJVBacEIR06QdRrHr96iJxVyCvWvPOu3Aw=;
 b=rhy7/tgWJ76LTKIZ3nFV0Uoh/qzCH/yRCls4j1xfsZHjGHUrzvZbigT7RkgVZh/hc8
 LZCK6E+Ds3AA0nfsQbg36c6KVD+PcAWmUM4nxexV87R0VmAJzc5hSbFKuv/KL/coAe6p
 xh9mvczqFsQ21X+n3+HpMvqF3Fxhwppzw3klVyav959bmFjxG6iKJsI9lG2A7yb+waXH
 LcOyEkJPczXn3FcYrxmvFUJ0SirSoRtZAHKD/Qt2iuM7hUSYx6qKSNV2IFUpnzCgZAIE
 8Fls7EBNDC1l4gki7/ekyjqig4kUlgS0qqe6SdNOW2ZLgIsQ+ApgT+xN936Cs96IugvR
 l2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768899475; x=1769504275;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4HMpkCXcCJVBacEIR06QdRrHr96iJxVyCvWvPOu3Aw=;
 b=PcvVKTX+YsN+PGb5dPNgqQHAfsgv4bmbfnO32ngqHwfACheyUPgr59vOw/iIRPYqKy
 S4kLAM3seeG8GROnppOMWAcxBwBk4zFzuxUyJxoGFwNtvO3bGeRLDTFBRg2F57jq8Bm7
 LH+AyONB/RQ02Bv3KUCSS/VHwva09Ao6JkNoK0W2QTmzIHQgrJOk0FdCGsz9fGcLNVED
 RAIlVAwHCX3FhK7aGJbp3LHtCISopzsuBW5l5hATh03EkmApuKRpZ0/qfUMS99LKFQMh
 GCWgUqgwTnXZRmoOzUypJjxq5YOxH16cOvTH7WO9uvZdZpMGoZ5a5OFpX6oIO2OhWloZ
 PrtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5RuvFLY93E0B9qirlKCkMgJK4Al/tWjNrxKPml5yqmM/Z+eFPopuXemWKCelAqkkqRdaBKHJsrjiI@nongnu.org
X-Gm-Message-State: AOJu0YxVKnNRjc0HcQgyJ6MJIhfyhfh2/Kl1b3lufEQFrPvVt9rNBlzQ
 zUCtxFoOMqfkkpePZL4pof3PPl5nfk+jozIEj1WBQmANBwSZV/EIlTbrPEHSvzk9zRS3/6golbm
 5Vlz3wb8CaXvv73ZiX9oB9I+bpsWBc62ZCalfg8ER09a8Pr0NO13Y3sswniq8gKN070o=
X-Gm-Gg: AY/fxX4QcjZlXXrM7Vx4mtE1NCa+AmQQUD6pemZA+AGobIUeOXrkBjKXgek49o9BDpg
 1/CPZDegsI43dT587D05Ez7wY5OugnAwYU3ZBZ4yK1rImEirDcIwoRsGHAjwQXVmiZa4NuDyUP3
 gxdaUrDVCTKIj2EoDudPiFxU5ZS1kIB7pGyNy/in9xrmaGq8fSjM4zmqbD5dDWKLckD3mD7Bj2n
 3Bg5N7ZMZ8IoYGlj2Lcbu6pYUCMuMZ69MR/etFO+OLXWa60Y+ZBGLtw82TKevhS3wWcnbjL4P3z
 lwxAhs43XJLaWQwZf3Vk4GprzFAUapVy4t/g4v7WsfHEF8/H3Hb/fiUeeDxu1+VXQDVjmiHTTf2
 Q0HNJZ1K1NaRl4Kc64cCRBLLk6jWpqSfPNaY=
X-Received: by 2002:a05:600c:4e93:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-4801e30a606mr174802715e9.1.1768899475405; 
 Tue, 20 Jan 2026 00:57:55 -0800 (PST)
X-Received: by 2002:a05:600c:4e93:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-4801e30a606mr174802525e9.1.1768899475027; 
 Tue, 20 Jan 2026 00:57:55 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e664sm25699113f8f.30.2026.01.20.00.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 00:57:54 -0800 (PST)
Message-ID: <1d6926d3-78af-4975-a39d-6d8d540dbe42@redhat.com>
Date: Tue, 20 Jan 2026 09:57:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/17] meson, mkvenv: make functional tests depend on
 functests group
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
 <20260119212744.1275455-11-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260119212744.1275455-11-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
> Note that only the thorough group requires the extra testing
> dependencies; the quick group will run with just the "tooling" group,
> which we intend to install by default at configure time in a forthcoming
> commit.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/functional/meson.build | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


