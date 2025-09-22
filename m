Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F238BCAC5AD
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0eRf-0006c1-AX; Mon, 22 Sep 2025 07:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v0eRd-0006bt-OT
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v0eRb-0004I6-HD
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758539451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hbkgTQP6g8DkmzniyXDBvYiQfHYG+bQWdxX3d6/8X2I=;
 b=NPDn1ccx8X4MG2hovx/4B62w48Fo9pgTEcvGEQRMPC21gEZkeUeTuzT/f75JlhEEP8buP2
 VmkKvAxxh/IZXJwlNz5gHLm6biJFgS/TB3L0KnpjRtHKVQkaDhrDPcu2UE4txL1v49pejK
 +CwCN/vIzWnT90ufW0iQofqDYtmA7jA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-9rqWoULePLyyyUJgEufYxA-1; Mon, 22 Sep 2025 07:10:49 -0400
X-MC-Unique: 9rqWoULePLyyyUJgEufYxA-1
X-Mimecast-MFC-AGG-ID: 9rqWoULePLyyyUJgEufYxA_1758539448
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3f42b54d159so1397012f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758539448; x=1759144248;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbkgTQP6g8DkmzniyXDBvYiQfHYG+bQWdxX3d6/8X2I=;
 b=rDXGDZzrxehH3Q/itDxadvA1L3De6cyNrlpaKhBP+6M2HJrzlvd5j31rs2D7INl47s
 rl4pttswzhJ2Ja92bEEmzvx/ILLclEyb7z6mu1kZjSkZvJ+6ahPt7fW0n4FE723oEre5
 SmCNgYda4RpdB/DZC79gfI7MFyaI6acvvzYGMIIfX10HsRFzQj/d0VN9VZhPR7H7vt8n
 oaFXfpQMtutc70ilPYi41+yUU08xYE22wpxMLYS2vEu5ozLdxhVsnLbpk1DIWpBGmAwX
 K9fQdBdLcBLDTLntqBsRrUJyH4mQPUrCoYOy7TqTtJdzftG+ysI7xvS2WJlC0c5iUGVM
 NiFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr9nj3PE9ab06rL3IBlv1CjALOWyzo09X7kiKs4MaWJrtV48/p5HC9DNX9rnxk6cXvI9mtf1iqzXw2@nongnu.org
X-Gm-Message-State: AOJu0Yx89sTQWVbSKZq6QaH3WksHyPtmZ4YOBwLTF4rkx9hWDAWQnWJT
 0zwJG7JMvifaW2ieO243D651ccFDDxYnaYPLoJUHFu7CuI8ha1XHu5mMYXIjD353mTxaNN2BnoW
 Oe1A5e1FWsluXhbRneL2zocCFlw9ZyuBZLOjC2bAEZpGbJmSC4rItJGAd
X-Gm-Gg: ASbGnct+fcPi2K+/9ymZasqIXxAofUVuwGeDORKAj6Ag5E34eyOj0MhhMun4bfsiN7j
 yyY6kFznExBUu+aSxWzi/Z3PWW58xL2Zl8DgYSCvbKJ6w/UEghdXWSvtdHuwd8WUAp+SKspZ/Ie
 rOBqGS6IHhT5yDdU2Zc5SFdheIWYRw5/x/V6gobWSW/L35C2xvnTNwOS+w6Oy282zBdsPS0Ol13
 Trxgv23PYgui2sFxF3JHX9a6EmAmnt47WgjvJme5wSwYMAPWJxUoJFkt4mn2PQ1b45RpZJIY8zR
 yG58bHrlvk9F9nfZ27BcwYbssvppmZeN67iPTedvgu7rxqRKUGOYg0bwULcmEnyITRG4I2sneV7
 l6fhwEA==
X-Received: by 2002:a05:6000:400c:b0:3e8:b4cb:c3dc with SMTP id
 ffacd0b85a97d-3ee7c925658mr11728845f8f.3.1758539448386; 
 Mon, 22 Sep 2025 04:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvTYE4BFviE7oEBk2NZxaP55bRbtLYgZdqkdONCZ0X0wc1BWl+e/QksnQS6NDvS/ZKkhQZ5g==
X-Received: by 2002:a05:6000:400c:b0:3e8:b4cb:c3dc with SMTP id
 ffacd0b85a97d-3ee7c925658mr11728818f8f.3.1758539447967; 
 Mon, 22 Sep 2025 04:10:47 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07412111sm19258582f8f.28.2025.09.22.04.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 04:10:47 -0700 (PDT)
Message-ID: <4c7934c4-4deb-461f-af4d-c089a5514d9d@redhat.com>
Date: Mon, 22 Sep 2025 13:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] python: Install pygdbmi in venv
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250922054351.14289-1-gustavo.romero@linaro.org>
 <20250922054351.14289-2-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250922054351.14289-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 22/09/2025 07.43, Gustavo Romero wrote:
> Install pygdbmi in Meson's venv. pygdbmi is required by functional tests
> that interact with GDB. pygdbmi size is only 21 kB.
> 
> The wheel file has been obtained with:
> 
> pyvenv/bin/pip3 download --only-binary :all: --dest . --no-cache pygdbmi
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   python/wheels/pygdbmi-0.11.0.0-py3-none-any.whl | Bin 0 -> 21258 bytes
>   pythondeps.toml                                 |   1 +
>   2 files changed, 1 insertion(+)
>   create mode 100644 python/wheels/pygdbmi-0.11.0.0-py3-none-any.whl

I think we should rather avoid to add python test dependencies as wheels 
(unless it's really necessary as it was with the pycotap module that is also 
required for the "quick" tests).

It's better if we finally re-activate the "check-venv" target for the 
functional tests (we used it in the past for the avocado-based tests, too).

Could you please try whether something like this does the job for you:

diff --git a/pythondeps.toml b/pythondeps.toml
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -33,3 +33,4 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }

  [testdeps]
  qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
+pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
diff --git a/tests/Makefile.include b/tests/Makefile.include
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -109,7 +109,7 @@ $(FUNCTIONAL_TARGETS):
         @$(MAKE) SPEED=thorough $(subst -functional,-func,$@)

  .PHONY: check-functional
-check-functional:
+check-functional: check-venv
         @$(NINJA) precache-functional
         @QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func 
check-func-quick


?

  Thanks,
   Thomas


