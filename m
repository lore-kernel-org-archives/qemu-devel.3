Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69551FC0342
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvh6-00026O-Qc; Thu, 23 Apr 2026 11:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFvh5-00026C-BB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:10:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFvgv-0002HK-JQ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:10:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-483487335c2so66797505e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776957007; x=1777561807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k/pJpG76VkUSN3CQatMLRrcrXzgH7z1W2IvgXoyPd7E=;
 b=GoB9qnHWCEBb+BXIqcVaSIqPFAEOLdABod4UFoHbgj06j7P1FNYEDHDhpSEKHlxEY1
 VZxTF+iP6L79DZlCJjfhsMHn3yJne9z7yYXz8nVcLMAe8sHfytL3oCyjWcYihVvXrXd7
 jEu8brV8i6czudKomFCqob6StPWwLMiIZPB0pk/v87rmif8qAcrFJEsTKBD8Y1duSLY9
 lpSQitx+uWkCka7qo5+Qd78Z08kySeztgBvdurPZKY31/UA2tdTdxLaGJGTmAhz3xJqv
 s3eRjXjfEnNSb7dAIKmgDwWOPxvuJzEWQI4ZrooFjTJcCrz+5/PgG83ZZnpi4jP+1JBc
 rjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776957007; x=1777561807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/pJpG76VkUSN3CQatMLRrcrXzgH7z1W2IvgXoyPd7E=;
 b=UOCPsIUN/tWsu/lbbhWg20wi7s72laNKv+IquOnQV4XVEGQoNellh/oB2eMJfjv9AK
 1QwEnBpZgVP8Cf//9g52SMSLAObE0sIxLeSZtRzLeUUCWEJJV09T528i51CWw8dZ4IhB
 er2wqKBo6GOcFpVjLphWUTebVYosBKoTga/r4eLLGD7P2Vhj1BIHvBo5S5IJoQgAc8pP
 cXa1jyJFLTi4KdvA47E5kId2iUiOOaRos4EpgnS+PJJHPeun3uuO8m+rEc7o96xl1RMj
 xJn1zOXkAJlCnelPTzqwRZ/YO1E4adEzunqqJd7qTQDJJs26tGcJM0oprgQ6jSHVhEdJ
 EheA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Se2cE5esn+oJIw5acPl0fcUgGJLott/eA+rXuSOVjiTVteMWx9Ee/9K1Umt9tvSOc+uwGMp169BOr@nongnu.org
X-Gm-Message-State: AOJu0Yw03TCIWorqUJtUXFuIpnxl4pxIX2jE3iYTza0zPQc9h6MEIwk8
 ec3yq/CUrLK+b5/4W/mKSQN6cnDy+C3SLFerdbmPvyFzp1BFRw/xDyM+jp8orCp3+rc=
X-Gm-Gg: AeBDievkEZNbU0jq0kHI9XRHWqKR+1N/Xpsp7mB9mN+Y5Q2upR6LapQ4SEcL0kNczdj
 24+vy5qUSqw9wdOChSh2E6Th5sP0UUmNCkqPH9A5Q9kBhgDkDKBCrXO6j/2QBUCaVMHpnX86tOM
 sSvOEpRBDYzB+4RdHYvLkM8GkU6f3EbQACUzbcp0IfDeI0azihZKUzWKzQksvjKl1kbC636jaJf
 27caP74VrDCXcV7U1BYnCDv2c4TK7cpYRYKFfnUXB0jt9HUapPRSHqyfGYxOyas19COdDOAaIvy
 2mYlqpas6cb5ABfi1ytPZV659NbamwHqfRAMHhQ3un723igcY/JjML261NynfaAIbckTkN9hJ0+
 aljbk2j6QL/qWpFgFhw8funxzSU2r00soIDiF9LiQBzw2meLbT72r762m9mgr+yq4CVgEFTh88x
 WfVZO4l3rroPfWGFrcmDCGiL1TLv/N+LvuKaswMVSDaKeCSme/p8Jhh3dXZipGPIhtPjfiWPQ2D
 P+q
X-Received: by 2002:a05:600c:8883:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-48a582167c7mr130117975e9.8.1776957007085; 
 Thu, 23 Apr 2026 08:10:07 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74c68asm165585585e9.3.2026.04.23.08.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 08:10:06 -0700 (PDT)
Message-ID: <f634c125-5b93-4c60-b14e-3fba3cd5bd69@linaro.org>
Date: Thu, 23 Apr 2026 17:10:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tests/functional: Make socat wait longer in migration
 exec test
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20260422230001.3168-1-farosas@suse.de>
 <624cf04d-6188-458d-bca6-dd5ffec877ab@redhat.com> <aeo0gHfFFDKC6KPR@x1.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aeo0gHfFFDKC6KPR@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 23/4/26 17:02, Peter Xu wrote:
> On Thu, Apr 23, 2026 at 06:52:19AM +0200, Thomas Huth wrote:
>> On 23/04/2026 01.00, Fabiano Rosas wrote:
>>> The migration_with_exec test is failing sporadically for all
>>> architectures due to a race when the destination socat process takes
>>> too long to start listening while the source process is already
>>> issuing connect().
>>>
>>> The race is inherent because the exec: migration spawns the
>>> to-be-exec'ed command asynchronously and returns from the
>>> migrate-incoming command. The localhost-only testcase is not
>>> representative of the majority of migrations. In a real scenario
>>> between two different hosts that race wouldn't happen.
>>>
>>> Fix the testcase by configuring the source socat command to wait
>>> indefinitely while trying to connect.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>    tests/functional/migration.py | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
>>> index 144f091ba8..3b7674af3b 100644
>>> --- a/tests/functional/migration.py
>>> +++ b/tests/functional/migration.py
>>> @@ -85,5 +85,5 @@ def migration_with_exec(self):
>>>            with Ports() as ports:
>>>                free_port = self._get_free_port(ports)
>>>                dst_uri = 'exec:socat TCP-LISTEN:%u -' % free_port
>>> -            src_uri = 'exec:socat - TCP:localhost:%u' % free_port
>>> +            src_uri = 'exec:socat - TCP:localhost:%u,forever' % free_port
>>
>> Maybe use "retry=90" instead? OTOH, we have the high level timeout from the
>> meson runner, so we should not hang here forever by accident anyway.
> 
> Yes, IMHO it'll be good to stick with one timeout mechanism rather than
> adding more magical timeouts.
> 
>>
>> Thus:
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


