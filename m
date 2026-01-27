Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207BED2FEC4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 17:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkmv2-0003ie-I1; Tue, 27 Jan 2026 12:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkmuo-0003fC-Pu
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 12:31:48 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkmum-00010d-Le
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 12:31:45 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82361bcbd8fso884981b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 09:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769535103; x=1770139903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CphJVbFCjmbTm6Z+qDTIfXp1OhBGb7/8qHdZ59QdtWU=;
 b=hoWw4EO3Y1LFY5r/jGNzLuhniSi1pze9wJzMV/AutWqnXKgPKAhFk7iT8T5m8P6CAn
 FexoJg2LvBcj4k+jda20Oy2Hq0EKrlbYVZ+aH+Q6AfBfaAoHR8joFv6XXwqIX/oQL/Cz
 kzAMBukfkjslNnfR3AK3c91NxaZknyRh2WYe5tZNQauxAvVabkVauZxPsSji4ouPxFpy
 +By3hg7MWhvzocJ+133EcpeG595kzPl/WfRf0Iadk2x5UsTq9CNGBqSam5AWNnhviYkL
 KWhkE80TdVC01Llf70VoT+2DsuswSDObu8aPmwv5B20sOE2G8hkfCN5yS+z/1xoh6sCr
 hfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769535103; x=1770139903;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CphJVbFCjmbTm6Z+qDTIfXp1OhBGb7/8qHdZ59QdtWU=;
 b=RKBdngXpXwS0jowC21PUPcSE1l89t4seyvi9+q8BzrTs3rcW2tRdNHWpNR/n5LN+80
 0eMeJ/p2NIKudfmvgCwks+Sx/Lxr/ms5L+o8D8Yif5azeUamT2GCL/Twoo9xFcFykm99
 KFVwgG2mwS8AJQDjfW0L1mM2yinaH7O77BXxJ629cWwt3taY2sTCNXSg3Tx2AvDrucxS
 gNpYJUHeQwDhX8Ct6DbQWoeomndcmp7zf9MzDKZBV1SXvU8THC1mr6exJbGEd57rEieP
 8DHFDIOr/ywAK6o1mYow4cX2gnOKyaUe6Phsk3KEadJEmTofEIbgTKchNnGC9X6a9R9Z
 VYIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL7bknAXlQWaKtLnnLxCjMp5HCRaIvXuIviBkKm9g/xcBAUHnu4YG+PYN0LfWzgSwmzIKwRf+pI+vB@nongnu.org
X-Gm-Message-State: AOJu0YxJOuquky28LNG3izn/68DNClLzf+Bt2rRRUvWYLePbNz0AXoTY
 Gy5C6ZvAKcc5uJSRjCpitzJbXJH4eFVbOEteMSofkPuUHNC0Xjj5NafXvi77PL4TQO8=
X-Gm-Gg: AZuq6aJY6sM5u70PJU4yMa88OJ6pd/RKqI9dqRwovrFyRRvmXAcLg7eGT+IUM5FIK3o
 OWvsl5oKOkqj+Z7GJJjwpNWLON301NamAvRiNvrmaUra4OZiTsL/C7zGJLFMBhtpWqm1ZEBB5Ca
 vmnLbTeb/AXN8z2/shXflK37w5oo88ymQJsxzChYcSXlsJE56JaW25UmAw7CImAJam96OtqtypK
 psAs57JKT6bcrcN9i+P36AOuB9pv6JCgNfoOTRc8GJdyMSsLDRNHvIp8pssa10b5U9v0exl2iD6
 i6B1lCJXn+JcT5OXJgJYDNmXqTLTRpGvEHNkxog/qKicLTauGqXNflTzehQYKQuJggwST4mkYSv
 vssC3FSY7gO33+SQtQUWvXAnhQtqsu7SaTlYyrUPSDQ9F3B/d/oGSQNxm63QYyxKgKnurSZ1ksq
 ZY2U6p03Ei5JCNTdclvMko5/4elNKY2+agz6MCrytseUG+VzGjue9Fz635s6nYilEsEko=
X-Received: by 2002:a05:6a00:1da3:b0:81f:9b97:5e4f with SMTP id
 d2e1a72fcca58-823692bf8bdmr2209466b3a.47.1769535102481; 
 Tue, 27 Jan 2026 09:31:42 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b49fecsm152756b3a.15.2026.01.27.09.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 09:31:41 -0800 (PST)
Message-ID: <21bfd95b-c853-48f3-896d-2bb1faff30bc@linaro.org>
Date: Tue, 27 Jan 2026 09:31:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitlab docker registries
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
 <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
 <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org>
 <87ecncc4sg.fsf@draig.linaro.org>
 <90520ad2-8256-4bc7-94e3-010455659394@linaro.org>
 <878qdjcslb.fsf@draig.linaro.org>
 <7574812c-c200-49bf-8367-927c3cc7295b@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <7574812c-c200-49bf-8367-927c3cc7295b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/27/26 9:10 AM, Pierrick Bouvier wrote:
> On 1/27/26 1:28 AM, Alex Bennée wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> On 1/27/26 10:50, Alex Bennée wrote:
>>>> I think it was broken by 4203ea0247f (gitlab-ci: Add build tests for
>>>> wasm64) because we base the tests of the existence of dockerfiles and it
>>>> now generates multiple targets.
>>>> Do we actually use the wasm32 stuff anymore? Maybe we can just
>>>> rename it?
>>>
>>> All of the wasm32 stuff is supposed to be gone.
>>
>> I think 20260127092745.2978371-1-alex.bennee@linaro.org should fix it,
>> but I need to re-read how to trigger the weekly build on my test branch
>> to test it.
>>
>>>
>>> r~
>>
> 
> What if docker-verify was depending on building the container locally
> instead? It would allow to have a self-contained command, that works the
> same in local, or in CI, without any yaml dependencies.
> 
> With current approach, it's tricky to reproduce locally as it depends on
> global gitlab registry, while we are just trying to see if images is
> buildable from scratch or not.
> 
> The fact it's hard to guess how to test such a change exposes that there
> is a problem to reproduce this, even for the original author.

As well, docker or podman already have inspect command builtin, so I'm 
not sure what is the added value of skopeo here.

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 38467cca610..c280467aa8d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -50,11 +50,11 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
  		"BUILD", $*)

  # General rule for inspecting registry images.
-docker-verify-%: $(DOCKER_FILES_DIR)/%.docker
+docker-verify-%: docker-image-% $(DOCKER_FILES_DIR)/%.docker
  	  $(call quiet-command,			\
-		skopeo inspect 			\
+		$(RUNC) inspect			\
  			--format '{{.Created}}' \
-			docker://$(DOCKER_REGISTRY)/qemu/$*	\
+			qemu/$*	\
  		$(if $V,,> /dev/null),\
  		"VERIFY", $*)



