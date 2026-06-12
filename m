Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA77CCD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXvEa-0002U5-Oz; Fri, 12 Jun 2026 02:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wXvEV-0002Se-SX
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 02:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wXvEU-0000ls-9H
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 02:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781245149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gSsozal9+kFdD14fq8gdPMbf7FDSKmLSD8CxoUqNCro=;
 b=PoFxq5o5oLGgP8fLB+nm1tc5CjJbE6j1rxQhehrn/zZOTFd2KPA6XZgU1F7xQIcsF5MpYk
 wT0CFAe1uh1yrjt5ISUO8mVRQizJTv4EJq48vDtHWoNYGPMgZ3Ch5g/FgdRrEIlJ3cqFks
 7Z2xSUDdezepFl6SbUZCvudwusNan1I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-FwisUeviPG20gWOYNi4lWA-1; Fri, 12 Jun 2026 02:19:07 -0400
X-MC-Unique: FwisUeviPG20gWOYNi4lWA-1
X-Mimecast-MFC-AGG-ID: FwisUeviPG20gWOYNi4lWA_1781245146
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45eee3f9f03so509980f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 23:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781245146; x=1781849946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gSsozal9+kFdD14fq8gdPMbf7FDSKmLSD8CxoUqNCro=;
 b=eHFpwzYH5fhzG+QN63kO4T1+M9fNivGnpz7xH7r5jE+I7hTW7xtcP927vRfRlhdFJX
 KMYp+F0/DrzI//Sda2lV3rEZyxQplzxTRv94FEZ4kC3ZxtsxSgvxpKdRC5JlSHsiEQ9u
 Ve6LU4ozRsBd3+pk5inKd+CGdDS8iAQLbOK/+P1RdqOzsLPX6+yWGKwOK9PgphcCLA4I
 yXmE5jmwtCeiC2gaX4H4l/sUh0JDs0o6i6+7FLSIedErw+X/NntvmJORybQz4w+ns/7a
 BdBUGi2/AFkb+vUnHIXz9cquAWLV76WaKXo1jUSglC6pC+6+af0EdMdzTL4/gJOrgZhT
 8egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781245146; x=1781849946;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSsozal9+kFdD14fq8gdPMbf7FDSKmLSD8CxoUqNCro=;
 b=BghUOlpM6jcqe+ZDrNMZfZYU0RGNB6sbG8guQMh0W1OSbpS2suOMxpek7fpLpFgkn5
 zoihDtjGCvOP0SGmvYrokSiw8CLwjpTUPbNr+BwSvl38ys2/eZSQAEIX9UYb5iU9VpfE
 cfzeV/nZgVjPrOQxPfv/GV48j92Y/odyEOxLk1UhUpd8wtoJGbmXP/Mh53tdeKvuNQeE
 pp5QdIwnTq5BOhuuZ9deR0PMpvn6vIGTBhXOSOtdZUs4hOtfuTLukoof5ZBrGBjjBsCU
 Mt/t3Hps+eUMOPVs5cvcH+wjoedEGZQTprTx+aOJ43U6wiyiVWKXrcWlnTc/P52/8DSK
 c8Aw==
X-Gm-Message-State: AOJu0Yy70uxRJF/oyrzcn+dmSX+FB1ln6tlDahfvOJFLOvYzozxVjFRc
 d18PEqYJ46bmooW0/dSusNXQT3whjYIJo0c93uaAeZLFdOE9/PxhWivcAcW/cKA/1BPfkcqhC4R
 yDTwQqYvAfUcthcUuxnEmW1UH1PaT94GE3BZlUgzV7hNXeFbrBWCXEIXc
X-Gm-Gg: Acq92OFEANfIkWBDHFGSiAl7f2YTuLHzGIIG2wHCuIYDDi5n/MWJSNKlv2VXoOiie0B
 nObVHErUpt/Vmx5XFr9R7V677r/pCRVfNGWuhE0azHL2LUmbkDk+dWKm1N6MRNaMiqap8aNYfg0
 tYpTHBgMSE1yaYoqc2u/zwcaRdkUzQ31pKVGg1RvfC1Q0yFcs7ppFwfRBnMObnFuLXK+dfuXMwl
 Ljv1DytNvUoL/9c007xwr5Q5ZOWo4eZcvQS0wwJ+kejbxgq62BjGedY7+F6U35ifKi+ryzYaVUV
 mZbWwG2+1I4MrT6roa4Plu0v5PnB84iTXuNsd8RIGw+3APQ271I/ZWifei2MXJtvl7MS4/MuYDz
 ci/OILyAVkRyoMAwVujE=
X-Received: by 2002:a05:6000:2798:b0:45e:f266:f4cb with SMTP id
 ffacd0b85a97d-4606db9ca0amr1109617f8f.22.1781245146450; 
 Thu, 11 Jun 2026 23:19:06 -0700 (PDT)
X-Received: by 2002:a05:6000:2798:b0:45e:f266:f4cb with SMTP id
 ffacd0b85a97d-4606db9ca0amr1109602f8f.22.1781245146139; 
 Thu, 11 Jun 2026 23:19:06 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.132])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm2737279f8f.34.2026.06.11.23.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 23:19:05 -0700 (PDT)
Message-ID: <96289f60-23a5-441d-aff8-831aaf95eca0@redhat.com>
Date: Fri, 12 Jun 2026 08:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: allow pylint to introspect cv2
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260611162536.2184620-1-alex.bennee@linaro.org>
 <544ac437-5dfd-4cf0-8332-16cf8bd56260@redhat.com>
 <874ij8ganu.fsf@draig.linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <874ij8ganu.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/06/2026 21.05, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 11/06/2026 18.25, Alex Bennée wrote:
>>> To fix:
>>>     qemu-test.test_pylint
>>> "/home/alex/lsrc/qemu.git/tests/functional/arm/test_integratorcp.py:83:
>>> I1101: Module 'cv2' has no 'imread' member, but source is
>>> unavailable. Consider adding this module to extension-pkg-allow-list
>>> if you want to perform analysis based on run-time introspection of
>>> living objects. (c-extension-no-member)"
>>
>> Which pylint version are you using? I don't get this with my pylint
>> here (version 4.0.4)...
> 
>    dpkg --status pylint
>    Package: pylint
>    Status: install ok installed
>    Priority: optional
>    Section: python
>    Installed-Size: 2073
>    Maintainer: Debian Python Team <team+python@tracker.debian.org>
>    Architecture: all
>    Version: 3.3.4-1

Ok ... thinking about it, I think it would be better to rather add 
"c-extension-no-member" to the "disable" list in our pylintrc instead, 
otherwise this will likely pop up in other spots as well and then we have to 
constantly extend the list each time which sounds cumbersome. Could you 
please try whether adding "c-extension-no-member" to the disable=... section 
silences the warning for you?

  Thanks,
   Thomas


