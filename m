Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FED606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AOAnEglF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HJGk8cqA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLev-0001Sb-94; Fri, 06 Nov 2026 10:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPLes-0001S0-L6
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:15:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPLeq-00055x-TN
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793978110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OHm+dNT8mruluGT3x40fIItcWY33YpBcw4hJkZ0mw3I=;
 b=AOAnEglFaa+OokmqqEu9EjZ18QxYkKJt6dFllS2HV4bDXVIgRtimkh7CW133Eu0u+8ObjI
 n7vFTPRGu6jBx2zI9Ob/gtzb4R+WUCWosblBm6vqf6lqB9TQMIc0e5J3nveJKohTsF/o3c
 Uxc+JJj9VyQGAI1TVwq8TuYONtGdZas=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-ZNr9LrHpPy2BwvxkjFn2-g-1; Fri, 06 Nov 2026 10:15:09 -0500
X-MC-Unique: ZNr9LrHpPy2BwvxkjFn2-g-1
X-Mimecast-MFC-AGG-ID: ZNr9LrHpPy2BwvxkjFn2-g_1793978108
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-49090fde23aso776058f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793978108; x=1794582908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OHm+dNT8mruluGT3x40fIItcWY33YpBcw4hJkZ0mw3I=;
 b=HJGk8cqAB9uyDWpgbRac5w6qFllHg+wnwTetfyX5rMudxmkOTRSX5t6a/3bR9JYAB4
 DsXPSaRa1Fkqnpv0JQL5HCd9gmiryZ0B7nhvhIt2q0sBKfKtWIQHkMHlbk5a+QFBD8Fh
 FGKoMd2y7O4gaahdQ6fU0TythyGKwApt/xkOlxDKv4H3omRMHKqgAxmAPMoCQNQu058+
 HN/aNcN97sVEBEjuchU4J+y9EyPdIUUZIdktzBc5uyUE11pq00DkbJ2IXlKZZi6Wtpyz
 JIwY6McDICemdtHkrTrVpiuKYul9ZAA2voUBclxJjToqsQBelDbdq/Tv7ndYwoUIY7Iq
 eokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793978108; x=1794582908;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OHm+dNT8mruluGT3x40fIItcWY33YpBcw4hJkZ0mw3I=;
 b=Y1Yho3XL2XcjzBGtcN8dCuHH3imv0Po8gYBcJd9SI0aLWpuWNziN3w8nQm+sxejImM
 8ZW2//lN5Jb2uIXgawmnQ1W0qN2D5NBjne6b7lThXQXbGJaANhWFHE43+P2hNEOuc9LI
 eUqqAchxqNwimGsk/jZGD3ml3DLkb1ddWY6TOVzHmyJh/6SNafKhhno6H84+NbmCM/I+
 R+1IrK66+6MBYZSH1cO/IkZb8Yw8PkncG/tj2fNjL18tNJTOWdCo+ivpixgMhhaYoduH
 vHlYS7vffyg+r88qnejL/e5kmMYK5ZWhRNslM4RrWPZRWyoGdUEo24/7beC75oV7QHpU
 jTXA==
X-Gm-Message-State: APuU4Z/o0atHbr87bcoqGYedml1mH1CMF8q1+4pMUdE55N43HNqmHRIS
 1HVA9pWHQHYSZTFuMy+imbu1Z/sWfq/JJ5uZ7zhBYeH9gIOdafcIysEBaU5opROa5xOzXlUoBE6
 0b7XNjz5aFPEOd71Sqab7f05nhnPaLoW5Gdw+HNxIv9u3Jet6TSxnjZAi
X-Gm-Gg: AYBFou3SCPH3YQTqA0+MPkd74q7N7u0mMcJgqfpzoX23ec1SVwt9+q+M6sIIUD03oui
 FK+nH3w5UYTm3Rjy3zJ2aJJX+1/yieARqpKTT+RdXrlpDXHpSfj2GYt1UUGZjkO7YqI9yLjRhkM
 bqYU1vZpGB4ZndmiGcCestdf3NWXVUrb+kXlTEIHqigoRV1E1RHv0AgMqk0DSKww5tLl89iUXjN
 rFCfd88zz7pO7CLhKBXEHJrPwYvIfbK1ehQX6WjoNl1JurMk9dj/dC8gIMkRQsT7q673/MiSsOs
 drsZj2ucfrnlo6RDaOf1h5SOflqQROTqM+YjmOW3dYke4ycCTt1kUg3VUL4NbdnEQlb528YCy1d
 jgyibwhWR/0Su8nRCyltc+BNyb9OcS9GnZstCbF/Dgva8JoI069fxBkkJQHNQZO9VlTpeHGC9Vf
 uasdnCvwUFfPkx
X-Received: by 2002:a05:6000:1862:b0:492:46e:d4ce with SMTP id
 ffacd0b85a97d-492760da7admr5918041f8f.13.1793978108351; 
 Fri, 06 Nov 2026 07:15:08 -0800 (PST)
X-Received: by 2002:a05:6000:1862:b0:492:46e:d4ce with SMTP id
 ffacd0b85a97d-492760da7admr5917986f8f.13.1793978107934; 
 Fri, 06 Nov 2026 07:15:07 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:8701:5790:1ced:5166?
 ([2a01:599:b03:7322:8701:5790:1ced:5166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d3d60e78sm4153587f8f.1.2026.11.06.07.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 07:15:07 -0800 (PST)
Message-ID: <2dda56a1-fb13-48fd-9384-80276e711738@redhat.com>
Date: Fri, 6 Nov 2026 16:15:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Acknowledgements for AI-assisted trivial bug reports
To: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org,
 alex.bennee@linaro.org, pbonzini@redhat.com, berrange@redhat.com
References: <20261023130023.539252-1-thuth@redhat.com>
 <au3pKF4zORf4_98U@redhat.com>
 <CAFEAcA8Ysc5R2N7HX=uMAUEHi34xzgjU7QP7bcndnbbZ_3rr0Q@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8Ysc5R2N7HX=uMAUEHi34xzgjU7QP7bcndnbbZ_3rr0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06/11/2026 15.58, Peter Maydell wrote:
> On Fri, 6 Nov 2026 at 14:50, Kevin Wolf <kwolf@redhat.com> wrote:
>>
>> Am 23.10.2026 um 15:00 hat Thomas Huth geschrieben:
>>> Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3762
>>> Reported-by: Daniel Wade <danjwade95@gmail.com>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4470
>>> Reported-by: Mayank Jangid (OpenSec)
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4487
>>> Reported-by: Ken Hsu, Royce Lu, and Bo Qu of Palo Alto Networks
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4638
>>> Reported-by: Thai Duong (Calif.io)
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4733
>>> Reported-by: Xiang Chen
>>
>> So if I understand correctly, this issue is trivial enough that it was
>> found by five people('s AI agents) independently, can be fixed in five
>> lines of code, and not a single one of the reporters could be bothered
>> to send an actual patch or at least attach one to their report?
> 
> To be fair here, I am pretty sure that if any of these reporters were
> going to produce a patch it would be an AI generated one, and our
> current policy says we decline those.
> 
> Plus in my experience the hard part is not the code change but
> doing the work to figure out if that is actually the right way
> to fix the problem, what the consequences are, what any relevant
> specs say, and so on. All of which we'd have to do in code review
> if the patch came from somebody who doesn't already have enough
> community trust about their ability to have done that.
> 
>> All these reports seems to include two kilometers of AI output and
>> somewhere in it they typically hide a section on suggested fixes, but
>> always either in English or as a code snippet that you have to manually
>> insert in the right place instead of a patch that can actually be
>> applied.
>>
>> I wonder if we're setting the wrong incentives if we reward such
>> laziness with Reported-by lines for each reporter. I'm inclined to drop
>> all of them and only leave the Resolves lines in place.
> 
> I have tended to collapse them all down where there are duplicates
> and only give a reported-by to the one that reported first.
> I don't think we need Resolves: tags for 5 identical bug
> reports either -- we should mark all but one duplicate (which you
> can do in gitlab with "/duplicate #1234" which will auto close
> and link to that other bug) and only have the Resolves tag for
> the one remaining open bug.
Fine for me, let's give the credits to the first person who found it and 
mark all other tickets as duplicates.

  Thomas


