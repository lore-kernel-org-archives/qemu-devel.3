Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4D9C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0px-0000P6-6O; Wed, 17 Jul 2024 05:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sU0pv-0000HM-7x
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sU0ps-0004UH-SO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721208027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LRd7uCMg/RUJTa07ZmClJ2/xZu/wAcCV4+C9kLTULy0=;
 b=MrjOnZhFqHbpa6IIw1iwc1l6OT2g97Jr9adCwLLxA/XWxqcDCAXzTVxNzYCwt1l6x3CUMl
 rmdd3HkzdYp0ywR1ClvEhewuMl0nkjJKYDWL8+Fc+C727hk1ThGybEc2+rb0BHQGfJtBDd
 e0sy7ZPD1wG0brM/y/9qkbQlua/8960=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-Z41DDm2vOSqdlfsWLEo9Tg-1; Wed, 17 Jul 2024 05:20:25 -0400
X-MC-Unique: Z41DDm2vOSqdlfsWLEo9Tg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ee9f58c858so63333821fa.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 02:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721208023; x=1721812823;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRd7uCMg/RUJTa07ZmClJ2/xZu/wAcCV4+C9kLTULy0=;
 b=cmfhecJ0HpidXbHOyfGRxBrXd1xSwiq4ec7Iavs8+TKkxifKapeZqHncmItbwv35d2
 aQTL7CZ7ezQsFM6rdTZvXOjkGICS4n+rxjX6fQohh8mf6iU+oOTYa6SrHpmFmBzCYUus
 3WILocb0T6z0T9YJzGHOlEedRbmHLdlbP0efW7+bDOwXLlOtf8dip8lAjplMUyuavNl+
 ph/j/1zEWBfU5soI99dj0KIAp66u8NqitLcJwpOvZRTQpXES/3JAgy7JHbq39zZnF9ap
 Kw4QgUDTf8ENjMNEI+ROWTpaAiFodcx6FbPQkr3pUUm5+PzeM+5yt518LXndjL9igHo+
 DGiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnagkQna5qePYcZ2PYarRqSDoUPLx1j+jMG9vMEpHvwdggr3Vr0fzY2Wa/BSBayxbgeeSwcWt+phQTPyTs387MGa52YQo=
X-Gm-Message-State: AOJu0Yy5yl+uTzZmmMu9vuFSPwQ+OCGLchdUTv7yem/1CEr/aQWLdbZ4
 uOZCPGGHvqGGMbmsZ6C3zMZw6SD5sHifunORpVl4Z0+RRErE3J1VkDzm5SSKLRyQALzkiiICoyj
 XN4aXgq2VMQRRAx1KvFS3cAu5EqtiXObzqeCYgUN3s+Rb0gRshZ8+
X-Received: by 2002:a2e:3614:0:b0:2ee:7a92:610 with SMTP id
 38308e7fff4ca-2eefd1521bamr7484601fa.39.1721208023226; 
 Wed, 17 Jul 2024 02:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuLzh+eyWuCcNJf1XAyrGJ8f89N5RdYt7EOndJUfjY4DXtD9YfDpZtQWrwQjxaxTSabxX2PQ==
X-Received: by 2002:a2e:3614:0:b0:2ee:7a92:610 with SMTP id
 38308e7fff4ca-2eefd1521bamr7484101fa.39.1721208021284; 
 Wed, 17 Jul 2024 02:20:21 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-101.web.vodafone.de.
 [109.43.177.101]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f23984fsm198883295e9.7.2024.07.17.02.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 02:20:20 -0700 (PDT)
Message-ID: <0da0a686-1331-4411-b19b-bc337f8f33a9@redhat.com>
Date: Wed, 17 Jul 2024 11:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] tests/functional: Add python-based tests to the
 meson build system
To: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240716112614.1755692-1-thuth@redhat.com>
 <20240716112614.1755692-5-thuth@redhat.com> <87o76xcqrl.fsf@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87o76xcqrl.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/07/2024 17.15, Fabiano Rosas wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> Integrate the new python-based test framework with the meson build
>> system. Since these tests now require the pycotap module, make
>> sure that it gets installed in the venv.
>>
>> The changes to the meson.build files are partly based on an earlier
>> patch by Ani Sinha (but heavily modified by Thomas Huth e.g. to use
>> pycotap for running the tests instead).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Just one touch-up below.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
>> ---
>>   pythondeps.toml              |  3 +-
>>   tests/Makefile.include       | 18 ++++++++-
>>   tests/functional/meson.build | 75 ++++++++++++++++++++++++++++++++++++
>>   tests/meson.build            |  1 +
>>   4 files changed, 95 insertions(+), 2 deletions(-)
>>   create mode 100644 tests/functional/meson.build
>>
>> diff --git a/pythondeps.toml b/pythondeps.toml
>> index f6e590fdd8..c018b4d74a 100644
>> --- a/pythondeps.toml
>> +++ b/pythondeps.toml
>> @@ -26,9 +26,10 @@ meson = { accepted = ">=1.1.0", installed = "1.2.3", canary = "meson" }
>>   sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
>>   sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
>>   
>> -[avocado]
>> +[tests]
>>   # Note that qemu.git/python/ is always implicitly installed.
>>   # Prefer an LTS version when updating the accepted versions of
>>   # avocado-framework, for example right now the limit is 92.x.
>>   avocado-framework = { accepted = "(>=88.1, <93.0)", installed = "88.1", canary = "avocado" }
>>   pycdlib = { accepted = ">=1.11.0" }
>> +pycotap = { accepted = ">=1.1.0" }
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index d39d5dd6a4..2bdf607977 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -9,6 +9,8 @@ check-help:
>>   	@echo "Individual test suites:"
>>   	@echo " $(MAKE) check-qtest-TARGET     Run qtest tests for given target"
>>   	@echo " $(MAKE) check-qtest            Run qtest tests"
>> +	@echo " $(MAKE) check-functional       Run python-based functional tests"
>> +	@echo " $(MAKE) check-functional-TARG  Run functional tests for
>> a given target"
>>   	@echo " $(MAKE) check-unit             Run qobject tests"
>>   	@echo " $(MAKE) check-qapi-schema      Run QAPI schema tests"
>>   	@echo " $(MAKE) check-block            Run block tests"
>> @@ -111,7 +113,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
>>   
>>   $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
>>   	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
>> -	$(MKVENV_ENSUREGROUP) $< avocado
>> +	$(MKVENV_ENSUREGROUP) $< tests
>>   	$(call quiet-command, touch $@)
>>   
>>   $(TESTS_RESULTS_DIR):
>> @@ -152,6 +154,20 @@ check-acceptance-deprecated-warning:
>>   
>>   check-acceptance: check-acceptance-deprecated-warning | check-avocado
>>   
>> +# Make sure that pycotap is installed before running any functional tests:
>> +ifneq ($(filter check-func%,$(MAKECMDGOALS))$(filter check,$(MAKECMDGOALS)),)
>> +do-meson-check: check-venv
>> +endif
>> +
>> +FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$(TARGETS)))
>> +.PHONY: $(FUNCTIONAL_TARGETS)
>> +$(FUNCTIONAL_TARGETS):
>> +	@make SPEED=thorough $(subst -functional,-func,$@)
>> +
>> +.PHONY: check-functional
>> +check-functional:
>> +	@make SPEED=thorough check-func check-func-quick
> 
> I think these^ two should use $(MAKE) instead:
> 
> make[1]: warning: jobserver unavailable: using -j1.  Add '+' to parent
> make rule.

Right, thanks! I'll change it in the next version.

  Thomas


