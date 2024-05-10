Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60C4C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Ntc-0007uX-TK; Fri, 10 May 2024 06:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5NtX-0007u4-S8
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:54:34 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5NtW-0002WV-Cm
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:54:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41b2119da94so12299585e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338469; x=1715943269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b/gvCAi1zlCAYH14fL0c2cBEHtiLhWTS2B8PVHhwG3Y=;
 b=IxIH3ASVYyZ+garH+3rbkTZQ4miGAB5dglVsmRm5VeTqXTSEeOq8WcbPEDTjxWUbCL
 1yiBtOkWiRPflQbiHe6X2Ca1mF0vNNju/CbQcMfgdbynRBZjmsBDM5ge37PHvtEXPPaF
 5R+WqwXIsRkJs99R5XUG1p0DfDfHlqm6srj830mqhyJoPMsOPilwcPLp0oK/cRAGdJnp
 ukFMJBBsbvIvrGOJIHQn3FkCnLLwPJy1MB5JNPk6cY9k1CGrrRp9X+lz0clF4LPvrP1j
 if+fqOm2EIkWxfcsj7xdCOfSDqeerh3lpGUgCnjXPSSh/+ZEXnfvQipm/S5MFsBC2SAf
 GXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338469; x=1715943269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b/gvCAi1zlCAYH14fL0c2cBEHtiLhWTS2B8PVHhwG3Y=;
 b=m8BlQ1tIn/eZBMYu7k5akD8JZAMfs749TYLmGfHgt8st8f3T8v2PrbvNBkhDpp0mHd
 zAOiCntzNbYCTqg6ztkBE31bWgGaA8UMhkFCi4Y0cbB4lvwD2+nJEcfs5EbMKGWcnxLM
 pz+O0mCAHAJJsTKpxWKaeGpXZ7MuaQNYqEf9BHQoDRGsnB3ca0QBOl0bsCRtgW4nrQxi
 eJCJSVc2Z4ANamU4gccgfnzD3R01rV6HdQdntEyaBroMZ5GrUrXo3DoCFImW5owOFSJH
 jbBUAFmna1UMl8iPIFC8+m0MCuR32T2kTwqQmDNCEUtGEBbGYzbfER6Agej0G5kIh9Zt
 lDaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdSlPgp2KB2wFOayQFtCVzVa9KETf0qSjV/qMKTnKBHDP+hqv0KOl2vdN2WDzv0/L/hUJrj1TfkvdVO7ex0laB8AzZ9VA=
X-Gm-Message-State: AOJu0Yzg+bNCoP5K4z3p47/PKeR4lGygbFLT55CrEYnrxtGr1SJijCvk
 ydcqBHL67Os+mECKpqwpJDRmEZZu0uCbg5wP57d8Okf4G6K4FEgkWygcWn37DvE=
X-Google-Smtp-Source: AGHT+IETaFI4wzYDlQEewG6JVLqj8ozUGj33leaj71GTsbkcbp67ZKYf6Qt294GpXgmF7ds9Smu/xQ==
X-Received: by 2002:a05:600c:4f93:b0:418:c2af:ab83 with SMTP id
 5b1f17b1804b1-41fead6dc58mr19013245e9.36.1715338468879; 
 Fri, 10 May 2024 03:54:28 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f882085c5sm94888075e9.40.2024.05.10.03.54.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 03:54:28 -0700 (PDT)
Message-ID: <22d4a43c-f69e-4a69-b1ec-6d7414f1a123@linaro.org>
Date: Fri, 10 May 2024 12:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-12-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508074457.12367-12-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/24 09:44, Stefano Garzarella wrote:
> `memory-backend-memfd` is available only on Linux while the new
> `memory-backend-shm` can be used on any POSIX-compliant operating
> system. Let's use it so we can run the test in multiple environments.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   tests/qtest/vhost-user-blk-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(on macOS)

