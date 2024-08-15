Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53F7C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 16:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1secw9-0007YH-7k; Thu, 15 Aug 2024 12:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1secw8-0007Ti-2z
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 12:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1secw4-0003Gh-9n
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 12:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723737766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d25gAAZTwx5HFLBSQIC4ypWKDudPB+ue+R/jvwM+ipU=;
 b=OpigzLF8KLaI3PY2KP+q2B4rwqO7x+C+1OR1OSSCMfTQzYGN0noGAYv2EcFDssw7mZE43x
 mbuk3XfRpAVDjpLLpK6d1y6ESFRESTtcE62EnPftAcRBOeLFOvNlmnlyz3Y7SG2zuKhHIa
 GLhSZf+vIPJhbaKss0dFpXdE3XlyjkI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Qdl-jvuBNrSkTVJz_U-6qQ-1; Thu, 15 Aug 2024 12:02:43 -0400
X-MC-Unique: Qdl-jvuBNrSkTVJz_U-6qQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a1f230ad32so107423985a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 09:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723737763; x=1724342563;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d25gAAZTwx5HFLBSQIC4ypWKDudPB+ue+R/jvwM+ipU=;
 b=Opp+wQv5m6fnAbB8suJe60x40jFJY/8u3zyvMmRCj6+88aCzjXp3c1AN9xLOXFOpgC
 NddiyR2S6jjdjwMsTJdYFhSh86okomPCu122X+RFQLiciJx/Sx2MOxhLyf9FWnEPyJm5
 fff+hTsKSMB1E2XRkmsqSGFS2sZuXrwNZGQBZI8ZAhYRN6pOup3ivrpPY0Na3LdfwkMS
 tHLLjxz1PPEfBCc3to7xDNf7NIeUwwHInyQK7L4ORRIV65I3hoLGAl6jkElNJviQ+hL7
 ybWxFvi8TtJX+TCir0kUAVxIdxHXic8imDvnNjwljNuNkCs6PecdmwyYaPe94PLNz4qk
 6ZUA==
X-Gm-Message-State: AOJu0YyD7gjGPHRpcEobpjnNl8M5sMVgVmaOA/0QNYIzX2FoAITUoWLQ
 i+kNCIcS6SthdRX/xsP9rNW1W2+eWFmbSY9kc5I5iziYGGf3EdBhela7S0rzWJe9tkOkFu8q8rl
 P+2rr6tgZyplaPoHaiE9fPLG/9pdRoETTtECOSPCsC5REnxyt1zL5
X-Received: by 2002:a05:6214:2f0b:b0:6bf:6da7:6113 with SMTP id
 6a1803df08f44-6bf6da76357mr54616496d6.12.1723737762705; 
 Thu, 15 Aug 2024 09:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRaChnq18AXxGPvYlMQ3a/QihvEFGSAAw5kOi02UnpTd7m+tjpnOmRpYOJiyLCTpOITxNrwA==
X-Received: by 2002:a05:6214:2f0b:b0:6bf:6da7:6113 with SMTP id
 6a1803df08f44-6bf6da76357mr54615636d6.12.1723737762070; 
 Thu, 15 Aug 2024 09:02:42 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fe10ddbsm7483086d6.49.2024.08.15.09.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 09:02:41 -0700 (PDT)
Message-ID: <6ecd8981-f5d5-42d0-9769-82fbde55df23@redhat.com>
Date: Thu, 15 Aug 2024 18:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] Avocado tests: allow for parallel execution of
 tests
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, Troy Lee <leetroy@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Beraldo Leal <bleal@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paul Durrant
 <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <20240806173119.582857-1-crosa@redhat.com>
 <20240806173119.582857-10-crosa@redhat.com>
 <1f645137-c621-4fa3-ace0-415087267a7b@redhat.com>
 <CA+bd_6LTqGbx2+GOyYHyJ4d5gpg4v8Ddx5apjghiB0vjt8Abhg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CA+bd_6LTqGbx2+GOyYHyJ4d5gpg4v8Ddx5apjghiB0vjt8Abhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 15/08/2024 16.08, Cleber Rosa wrote:
> On Mon, Aug 12, 2024 at 6:17 AM Thomas Huth <thuth@redhat.com> wrote:
>> ...
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index 537804d101..545b5155f9 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -94,6 +94,9 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
>>>    ifndef AVOCADO_TESTS
>>>        AVOCADO_TESTS=tests/avocado
>>>    endif
>>> +ifndef AVOCADO_PARALLEL
>>> +     AVOCADO_PARALLEL=1
>>> +endif
>>>    # Controls the output generated by Avocado when running tests.
>>>    # Any number of command separated loggers are accepted.  For more
>>>    # information please refer to "avocado --help".
>>> @@ -141,7 +144,8 @@ check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>>>                --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
>>>                $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
>>>                        --filter-by-tags-include-empty-key) \
>>> -            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=1 \
>>> +            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=$(AVOCADO_PARALLEL) \
>>> +                     -p timeout_factor=$(AVOCADO_PARALLEL) \
>>>                $(if $(GITLAB_CI),,--failfast) $(AVOCADO_TESTS), \
>>>                "AVOCADO", "tests/avocado")
>>
>> I think it was nicer in the previous attempt to bump the avocado version:
>>
>> https://gitlab.com/qemu-project/qemu/-/commit/ec5ffa0056389c3c10ea2de1e783
>>
>> This re-used the "-j" option from "make", so you could do "make -j$(nproc)
>> check-avocado" just like with the other "check" targets.
>>
> 
> Hi Thomas,
> 
> I can see why it looks better, but in practice, I'm not getting the
> best behavior with such a change.
> 
> First, the fact that it enables the parallelization by default, while
> there still seems to be issues with test timeout issues, and even
> existing races between tests (which this series tried to address as
> much as possible) will not result in the best experience IMO.  On my
> 12 core machine, and also on GitLab CI, having 4 tests running in
> parallel gets a nice speed up (as others have reported) while still
> being very stable.
> 
> I'd say making the number of parallel tests equal to `nproc` is best
> kept for a future round.
> 
> Let me know if this sounds reasonable to you.

  Hi Cleber,

that patch that I linked did not set the default number of parallel tests to 
$(nproc), it just used the value of the "-j" option of make. So if you just 
run "make check-avocado" there, you only get single threaded execution as 
before. You explicitely have to run "make -jX check-avocado" to get X 
parallel threads. IMHO using "-j" is more intuitive than using yet another 
environment variable.

  Thomas


