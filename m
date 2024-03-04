Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF05C54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 11:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh6DE-0003Mk-5m; Mon, 04 Mar 2024 06:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh6D9-0003Lr-BU
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 06:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh6Cz-0000ca-Li
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 06:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709550611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nbAToRDe7i2qN1aoVi9Drm9xIzzI4VjjSD5ynLxwRT0=;
 b=BRLNL4KMesGZKNlZBVWJNExiQAl2HduUQGuV5TPsWhJkRsqqrYLvCgclIiDIFAj+PuCDet
 NaAXO2so0kJaCoWHCrWx8Eo52njHApMJQaVjTtVcJk7qEGfhw5RFsaIWzcY8LRQ453yRbW
 8GY7JNAdaJZqvP9/j1X3uytHbNqo3ts=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-QAxJbL0BOOeqUd8Ylc99Dg-1; Mon, 04 Mar 2024 06:10:08 -0500
X-MC-Unique: QAxJbL0BOOeqUd8Ylc99Dg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69080d37c3cso359976d6.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 03:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709550607; x=1710155407;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nbAToRDe7i2qN1aoVi9Drm9xIzzI4VjjSD5ynLxwRT0=;
 b=jk/Gio3904CcNH/xXN6WYXV+DNS3oEyQsOJBwJQU4yBfE/LQTo2ry/XLObZvwVSHEY
 5qaVxW+uuOzyScgx6FbneixGD7XDmHN4m/7RlJQTdfGESKR4ZpCf6TrraKuWp61d2lAz
 3z8qJsLoJKlPo39J8/aZFH6Lua68HHw5N+LflR9bBu+7Kt4RmT5exvlHo8QCFaNSP/35
 CfPL4M1ESa8a9bLA7MvKjP3+4x+xAX4PGcn7QtNQUtP5mKqMlIQRyqGkos0xOb9a7oT8
 weHgw7BFcgxR4iO9EFrg+Ov80h2/VAMh3MGlu6bHbYq+z37fAUwurXTXdfGvR5+xOItl
 LLow==
X-Gm-Message-State: AOJu0YzCPSfUQKo21o7Rp623GfFuL/EwRo/JZ5O+wpkKYTEPU7EBq2cA
 XK6GSengkK+sL8kuYkA7vaGaDolZHD6VVJj+7fqeydu8YLzxlV4UUZE5D6PbpG5/RmbYLG+qVxm
 N6kZvjOuEhgQ9lxBrdz0H//5TIe2SYbjYNI877qF9HdbWKpWxxCqk
X-Received: by 2002:ad4:598e:0:b0:690:561c:c075 with SMTP id
 ek14-20020ad4598e000000b00690561cc075mr14512047qvb.22.1709550607575; 
 Mon, 04 Mar 2024 03:10:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCz68Vge1PKiYFf8KtkdPfsFiC3Qaqeid8URIEh28qrxSE6+wABrPTCPK2UlTu+8k1soogSQ==
X-Received: by 2002:ad4:598e:0:b0:690:561c:c075 with SMTP id
 ek14-20020ad4598e000000b00690561cc075mr14512016qvb.22.1709550607178; 
 Mon, 04 Mar 2024 03:10:07 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 lu19-20020a0562145a1300b0068fc83bb48fsm4895996qvb.105.2024.03.04.03.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 03:10:06 -0800 (PST)
Message-ID: <08136aee-2f2a-4d19-a19f-b461c14c5c93@redhat.com>
Date: Mon, 4 Mar 2024 12:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/conf.py: Remove usage of distutils
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240304093618.24131-1-thuth@redhat.com>
 <CAFEAcA83XhUSTDL9QL40ek4vDt-PMxRM10XeTXMPPZLwiibFxA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA83XhUSTDL9QL40ek4vDt-PMxRM10XeTXMPPZLwiibFxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 04/03/2024 11.56, Peter Maydell wrote:
> On Mon, 4 Mar 2024 at 09:36, Thomas Huth <thuth@redhat.com> wrote:
>>
>> The macOS jobs in our CI recently started failing, complaining that
>> the distutils module is not available anymore. And indeed, according to
>> https://peps.python.org/pep-0632/ it's been deprecated since a while
>> and now likely got removed in recent Python versions.
>>
>> Fortunately, we only use it for a version check via LooseVersion here
>> which we don't really need anymore: All distros ship newer versions of
>> Sphinx now (see https://repology.org/project/python:sphinx/versions -
>> the oldest one is 0.6.6 on CentOS 6!), so we can simply drop the version
>> check now.
> 
> This code isn't checking the Sphinx version (we do that via the
> setting of needs_sphinx, current minimum 1.6), but the
> sphinx-rtd-theme version, which is independent of Sphinx's
> version numbering scheme.

Oops, sorry for mixing that up!

> I get timeouts trying to connect to repology.org, so can't check:
> do distros all ship new enough versions of sphinx-rtd-theme yet?

Using my shell script to query repology, I get:

centos_stream_8: 0.3.1
centos_stream_9: 0.5.1
fedora_37: 1.0.0
fedora_38: 1.1.1
fedora_39: 1.2.2
fedora_rawhide: 2.0.0
freebsd: 1.0.0
haikuports_master: 1.2.1
openbsd: 1.2.2
opensuse_leap_15_5: 0.5.1
pkgsrc_current: 2.0.0

debian_11: 0.5.1
debian_12: 1.2.0
debian_13: 2.0.0
ubuntu_20_04: 0.4.3
ubuntu_22_04: 1.0.0
ubuntu_23_04: 1.2.0
ubuntu_23_10: 1.3.0
ubuntu_24_04: 2.0.0

So CentOS Stream 8 is too old ... but didn't we stop supporting the distro 
Sphinx there anyway since we switched to the python venv stuff last year?

  Thomas


