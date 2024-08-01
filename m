Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3CCC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 00:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZJzR-0006wG-TU; Wed, 31 Jul 2024 20:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZJzO-0006tR-W3
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 20:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZJzL-000594-T9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 20:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722473290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFQclzW/vuWIgsBJAJ96++9Y/pmxYncNjR7KuXyfSF4=;
 b=eUNDpcTtfdwY8MTSrIy3vXW2Lczd2/chI99X2at6Fcg0G9aqaw1r/bqccg66dtk1+yMXMd
 XqyCoZONt13+btAqkeu4i4RHtkJVP9IfZPoMvprSTrkKW+pvP3sqWHxW2cJhUIVOp5dMIk
 n2G30RlgQpqrv/lvdyC1KQeIVEPoWFs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-C1SNWbV-O9-Pmo8JFO_VGw-1; Wed, 31 Jul 2024 20:48:09 -0400
X-MC-Unique: C1SNWbV-O9-Pmo8JFO_VGw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1d4238d65so732998485a.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 17:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722473289; x=1723078089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RFQclzW/vuWIgsBJAJ96++9Y/pmxYncNjR7KuXyfSF4=;
 b=AuT5g662pMGv47dfNA0SMR3anyUqI5MLwJWIp+nkc1pMKSr63NlwBp08oFVcknnZk5
 e1JpPzqyOFYcATHEoRwe92vELABUadSffhORZBLqy8IxweUYyE1sxkuGJ232qzZiKF+R
 kdXHPNvt7eToIa4+akXjXEnxjC6tUwJ1EW+bsB6rNVYPVD8LttpBZaY/sSlwOWCWzuE+
 z1jaPr0GfXuKQrkiKmv0SnVki/S7aq+MPumYcXatJDd4Dp9XEAaJBVkZoOAe0mng4ynR
 hKj4mMIUZJHVVsy3KJzXuKiaS6aPYsMYFHEXIYI852Kn1LjQntDFu1FGlnBJh1E3lhXY
 hasQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5qEHJ5Lg/Ycyg6CjxBsV9hDbq4F0JodvYDDTRX5XT/l0uavPSGtzuj2ZoGXIC8P11IFCHeDgwEKG9LPxt7QFH+qCfH88=
X-Gm-Message-State: AOJu0YyM3iAeacw5bMFvWohIhccwpRGFqVkBklMBd6zcPM6F0uOxfTK7
 X/l67Tb1ycpLutFj4UE/T8aeZ0iNPwJIxyQXv+z9qNzjhXjWBDXRBKKdfbFjC6kCuf5E3g2Bz4B
 JbXwaK+eLc9VirT6VJt7IR7QxMtMQdcaSeUosnojoH0/xYUw5dGgH
X-Received: by 2002:a05:620a:24c1:b0:79f:1e1:faa7 with SMTP id
 af79cd13be357-7a30c654a9emr124840285a.17.1722473288668; 
 Wed, 31 Jul 2024 17:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrkwsj+j0FIIhACoKbuelZI3ds0w5Xqfu2eQJH7G5c6HZxlsFtxr6D1099YDkyRiNMJSdm4g==
X-Received: by 2002:a05:620a:24c1:b0:79f:1e1:faa7 with SMTP id
 af79cd13be357-7a30c654a9emr124838585a.17.1722473288292; 
 Wed, 31 Jul 2024 17:48:08 -0700 (PDT)
Received: from [192.168.5.27] ([172.56.119.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1e4292ae6sm628776985a.74.2024.07.31.17.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 17:48:07 -0700 (PDT)
Message-ID: <2331dba4-4366-48fd-baaf-a5579df8ab59@redhat.com>
Date: Wed, 31 Jul 2024 20:48:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] Bump avocado to 103.0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-13-crosa@redhat.com>
 <2d85304c-ccec-43d1-8806-bdf7b861543d@linaro.org>
Content-Language: en-US
From: Cleber Rosa <crosa@redhat.com>
In-Reply-To: <2d85304c-ccec-43d1-8806-bdf7b861543d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 7/29/24 8:02 AM, Philippe Mathieu-Daudé wrote:
> Does that restore feature parity for macOS developers? Because this
> community has been left behind ignored for over 2 years and already
> looked at alternatives for functional testing.
>

Hi Phillipe,


As early as Avocado 102.0,  macOS support is pretty complete. The exact 
words on the release notes[1] are:


"User of macOS will have a better experience when using Avocado. The 
full set of Avocado’s selftests are now run under macOS on CI. Please be 
advised that macOS is not currently supported at the same level of 
Linux-based operating systems due to the lack of 
contributors/maintainers with access to the needed hardware. If you are 
a user/developer and are willing to contribute to this, please let the 
Avocado team know."


When it comes to the lack of updates, that is a longer discussion 
indeed.  When it comes to alternatives, I don't expect the QEMU project 
to do anything else than what it's in its best interest. As late as this 
can be, please take it for what it's worth.  If it does any good to 
QEMU, please consider it.


Best,

- Cleber.


[1] - https://avocado-framework.readthedocs.io/en/latest/releases/102_0.html


>> Reference: 
>> https://avocado-framework.readthedocs.io/en/103.0/releases/lts/103_0.html
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   pythondeps.toml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/pythondeps.toml b/pythondeps.toml
>> index f6e590fdd8..175cf99241 100644
>> --- a/pythondeps.toml
>> +++ b/pythondeps.toml
>> @@ -30,5 +30,5 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed 
>> = "1.1.1" }
>>   # Note that qemu.git/python/ is always implicitly installed.
>>   # Prefer an LTS version when updating the accepted versions of
>>   # avocado-framework, for example right now the limit is 92.x.
>> -avocado-framework = { accepted = "(>=88.1, <93.0)", installed = 
>> "88.1", canary = "avocado" }
>> +avocado-framework = { accepted = "(>=103.0, <104.0)", installed = 
>> "103.0", canary = "avocado" }
>>   pycdlib = { accepted = ">=1.11.0" }
>


