Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3A0CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOCe-0004FD-LW; Thu, 30 Oct 2025 04:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEOCc-0004Ee-AJ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:40:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEOCS-0006Im-AS
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761813599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yytOsGfl40u3+ols5E7y94Z6zOexD5a0hGfff5rYMqc=;
 b=Jnr4mAgkJpc9FYjRbRYQLjih9EGRi3oj/8SuoJNAHgq/TpTe8yKiPiZUHkTyEDSkNbt+no
 ru09UR+G4fk8OxyfTbkc75l1xUSu65TeUerPsQ5oi5TLSZ/us4nAy5WqbsLV/s+OnwU+38
 zfZL03czaiLv3Cnwot0iD2EwWhDPjgY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-LIdnHfQ5M-CBt5m86-Caaw-1; Thu, 30 Oct 2025 04:39:57 -0400
X-MC-Unique: LIdnHfQ5M-CBt5m86-Caaw-1
X-Mimecast-MFC-AGG-ID: LIdnHfQ5M-CBt5m86-Caaw_1761813596
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-471201dc0e9so4357195e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 01:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761813596; x=1762418396;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yytOsGfl40u3+ols5E7y94Z6zOexD5a0hGfff5rYMqc=;
 b=DwODWdQSMd3dTkTjDHkbKiqC3CZJqMPwgtmgrWP8WIHmj0LLgYI619tp8XN4oLbH+a
 C7zLfoW8E0l9kohWsH98BvqJiLvlejh0PqFEB1P8T+zbwOqRrAlPD5MK/uIQWybYQCJ0
 BDqFBznLbM812hwuodOvDvFLRjwQXIOwO/Dis9832qWIpEoTWFtYFQR3BDB6U1rWeuwY
 r5sHBDqjjwK+CRmmceQIvaAsa7xvkPYXQ17MfS0vx4LGxDFWndtuwzZp0TdFfHtKrkrn
 afLEKD6ip2ErAmVdW/8LJmzCZnpTmmYgNpc0t87zjjovd4RPQ2V4QSSyPcri8TvMJ/bI
 Q6bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJTiIZoCxF2HUX7BHFPp46rTmBeZbCVjUeOWR8xggRA9PW6rzhOIa1b8VWjkT0FnvEjHZh8MHeOHlt@nongnu.org
X-Gm-Message-State: AOJu0YwTJelGslq6KBwnYDjpIQZOu6TkPgbnUTE7UdOsIR3pwujcuA5F
 +b2qNLlj8IpGJMx6NZJvYm7ktr9PdoJXhONkNuaBBmVNx0yJ2w5CzaeIIJSG6G5AAdqYAbV1kNE
 VFz8N40rfvoqQqdDEcZnD3Oh0dEuELbzsxtCPa+DKBYGaCu83FYDpMVLhTOie76z8
X-Gm-Gg: ASbGncuXWmJLm3FPibLiP3AVdzbMNQvp+pZXixHYJlxo7W7qvVQhc0H4rVuG3TtCJ2R
 UP/dNdChD1WdBMep595MykUvqCgMxUlhiMpcEPG6QdFrBE2Rw48IYtIN1dwKnY7gmVe5Cft2BSA
 VYkoAIqKBAPcMkUPcziEAVtBitlclDpd//ZY8l+H/WCip1UagEU/k6Fl4N2NUskGNn89s1h15Ao
 Yl+bxHfEZC3Kfq8bVsvMbS2qWxg43Hhb4RwZXcXPB4Rlz/y+Hi1FiFHmg8grcVF63BI+1assugx
 93bhVCfVqWfLRKgKcFtdiSr8QtBRRD6FwJ3z/Kr/0X+H/DwDO1xB8c1u/DL0wIH+ItZDIbY=
X-Received: by 2002:a05:600c:3548:b0:46e:46c7:b79a with SMTP id
 5b1f17b1804b1-4771e33045cmr62814265e9.2.1761813596537; 
 Thu, 30 Oct 2025 01:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGafIg4WjEeSFupIav2H5jxU3lbLh7iCCR79XVIED5KY0X7MzKMfKlvRnoDT5uSWViQR7dQgw==
X-Received: by 2002:a05:600c:3548:b0:46e:46c7:b79a with SMTP id
 5b1f17b1804b1-4771e33045cmr62813915e9.2.1761813596115; 
 Thu, 30 Oct 2025 01:39:56 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7badsm30213057f8f.7.2025.10.30.01.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:39:55 -0700 (PDT)
Message-ID: <652efa4c-8ee8-4fb0-bf89-09adfb53df2e@redhat.com>
Date: Thu, 30 Oct 2025 09:39:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/10] python/mkvenv: add "tests" dependency group
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-7-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028220342.1407883-7-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 28/10/2025 23.03, John Snow wrote:
> This group is intended for packages required to run "make check"
> successfully. Once qemu.qmp is fully divorced from the source tree, this
> will primarily mean the qemu.qmp package. It specifically excludes
> packages only needed to run the functional tests, which are not invoked
> by default for "make check".
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   pythondeps.toml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 3d6907af799..70e83320855 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -31,6 +31,9 @@ meson = { accepted = ">=1.9.0", installed = "1.9.0", canary = "meson" }
>   sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
>   sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>   
> +[tests]
> +qemu_qmp = { accepted = ">=0.0.5", installed = "0.0.5" }
> +
>   [functests]
>   qemu_qmp = { accepted = ">=0.0.5", installed = "0.0.5" }
>   pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }

Hmm, "tests" is a string that is very hard to grep for, since it's used all 
over the place. Could we maybe continue to call this section "testdeps" or 
something else that is more unique?

Also, could the qemu_qmp be removed from the [functests] section now? As 
long as the python/qemu/qmp folder has not been removed yet, it should not 
be necessary - and as soon as it has been removed, the generic venv from 
"[tests]" should be in place, shouldn't it?

So maybe you could merge this patch with the previous one, simplifying the 
change here to something like this:

diff --git a/pythondeps.toml b/pythondeps.toml
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -33,4 +33,6 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }

  [testdeps]
  qemu_qmp = { accepted = ">=0.0.5", installed = "0.0.5" }
+
+[functests]
  pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }

?

  Thomas


