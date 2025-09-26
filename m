Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE4CCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Adb-00014y-Ek; Fri, 26 Sep 2025 11:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2AdK-0000xN-7X
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:45:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2Ad9-0001RK-Fy
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:45:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-269af38418aso28781455ad.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758901502; x=1759506302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+OniWzEPZLQcMk8WWvuZXUUv8R6h2tJYgLB8aY9W/24=;
 b=F1vtJLX0dmGJtKEfk4H6SM9ozczieIcpkjiRYKgAdPRwDpGgi+uidJfG3G0OuI2229
 Dgln5p1zTUdvV327/Acse0ciwcxHe1dJ47Xjh/uDXgJIZF58PWSmt/1HjfLLDQtlEW77
 px0+sbXzhZWb4MWWuDXNlGrYfRGWMccKOREs9izEX4nrhZ8c+qj9mEwBv3zAYBTfREjM
 xlUivKQcoqvlEyWOHQJS7f1e0DWIa3i0MSSSHkclkaehRdHi1AeElmLKk1r+m7vG1GjR
 8FjM6tMaXdro0fG3rHzHwAFsQInkdsmI9vA4tIHQqNoRm6RH4JZlqLnwe07qKpr/YtnH
 O29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758901502; x=1759506302;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+OniWzEPZLQcMk8WWvuZXUUv8R6h2tJYgLB8aY9W/24=;
 b=no+28lDsJpOAUkMv8PNt9lgV4GD4y2iXQGcsH8Vs2u707Gl7k4SHjFwfuGkVCFtym8
 oNRt4ad6rL382a/wJEFftQzwO93yPqzuK4gKDDlXXmHyX1sadDdtYnvUTKeb22cLIheO
 r8RI3GasJU78J6CL6BSqA3ag5yWQDifaziL+igsaORdqwaF64AA3hTf1pzm5mYdHvZpG
 9NPap7yKmty9tUotjcWyy1WiZJeVtiIuNPUXnNqQuCnNVUx8mKIZHmjkS2+fV6daKSQq
 yqrXhrlD52ZBtlAJr5v7FiqMDxmQ4mlQvDTkNQ9VABfnjwCFBsVX78Pq+lunjIIdTdBp
 TQMg==
X-Gm-Message-State: AOJu0YzhCeLwlNmWv3sGfoqOlALGjOvJ/Opk0Ub8Xy4xUK3LckMGfain
 mDAnY54gYupYb9pjKnBaqfeVinUVve+rhXNdHHmZI5nhlKvlRzVEsLWlkWb0EuLx2Pc=
X-Gm-Gg: ASbGncvRlGEAviyUWqU2RcR+0nZQO1iPcf3ZGb1cTKdYyzH7p9H/uhPsj2vMZtH/5GB
 XvgmseF1mMAmfwfvW7xNPfVodIjnLfoUlgCG9Z1DjY81/aCR5drLDyjzeMPkmlOnmGFUr9jT1DF
 /KQD+2UjZ1sXBvh6qGuIhfnBx2cfG2jSTlhCmzEfegfu8SMeILvVGLPZUeT6w3dQuCLoP7gk811
 2YTWYdxIASQBDFB5KdDZYcj1SVTYSNDpwm6viCBxpcui84nE6ZQbKzsqrFP9EDrUq1CvLOh0cZo
 D7lwmtWCKMOCkZurm64L8G5179M33PeidIA/j1o+9NZk7mgTc3Q9KUus4zT33hc2+4wIq5RKkLD
 UKms1kzE47ak5IV+38e7iPXgTmU/VCvfAqqvePtXsPfLPUVe2uT8L5nDy+ekU3Bb/aV9XkkiO+8
 0=
X-Google-Smtp-Source: AGHT+IGnhx9VjoQv0k78/oxmY9szp699xHYmnO5YSj6YA3NOA+bf39BBA+S8V+S7O0SSsYP7ahaSOQ==
X-Received: by 2002:a17:903:2b05:b0:274:746c:b09 with SMTP id
 d9443c01a7336-27ed4a89201mr80274315ad.55.1758901502278; 
 Fri, 26 Sep 2025 08:45:02 -0700 (PDT)
Received: from [192.168.0.102] (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed68821a0sm57248505ad.85.2025.09.26.08.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 08:45:01 -0700 (PDT)
Message-ID: <80c73d95-e8c0-4cb7-bf11-1c1e2f749c00@linaro.org>
Date: Fri, 26 Sep 2025 12:44:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] tests/functional: Re-activate the check-venv target
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, qemu-arm@nongnu.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-2-gustavo.romero@linaro.org>
 <5aefdfa3-4b8b-4512-a6a4-1a1684352d0f@redhat.com>
 <aNZQwnBW76LPUgeE@redhat.com>
 <1015000c-3f92-429f-84d2-bf496b5776d7@redhat.com>
 <aNZTx0Sxfo8QJMj_@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <aNZTx0Sxfo8QJMj_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

On 9/26/25 05:50, Daniel P. Berrangé wrote:
> On Fri, Sep 26, 2025 at 10:42:22AM +0200, Thomas Huth wrote:
>> On 26/09/2025 10.37, Daniel P. Berrangé wrote:
>>> On Fri, Sep 26, 2025 at 10:34:01AM +0200, Thomas Huth wrote:
>>>> On 26/09/2025 07.15, Gustavo Romero wrote:
>>>>> Add check-venv target as a dependency for the functional tests. This
>>>>> causes Python modules listed in pythondeps.toml, under the testdeps
>>>>> group, to be installed when 'make check-functional' is executed to
>>>>> prepare and run the functional tests.
>>>>>
>>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>> Suggested-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>     tests/Makefile.include | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>>> index 3538c0c740..d012a9b25d 100644
>>>>> --- a/tests/Makefile.include
>>>>> +++ b/tests/Makefile.include
>>>>> @@ -109,7 +109,7 @@ $(FUNCTIONAL_TARGETS):
>>>>>     	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
>>>>>     .PHONY: check-functional
>>>>> -check-functional:
>>>>> +check-functional: check-venv
>>>>
>>>> I just noticed that there's still a problem: If you run "make
>>>> check-functional-aarch64" immediately after configuring + compiling QEMU in
>>>> a fresh folder for the first time, the functional tests fail with:
>>>>
>>>> ModuleNotFoundError: No module named 'pygdbmi'
>>>>
>>>> We either need to add dependencies to the check-functional-<arch> targets,
>>>> too, or we have to make sure that tests still get properly skipped in the
>>>> case that pygdbmi has not been installed into the venv yet.
>>>
>>> We already have a decorator for skipping tests when modules are missing,
>>> so we should add usage of that.
>>
>> Ack ... and the "from .gdb import GDB" in qemu_test/__init__.py likely also
>> has to go away, to avoid that each and every test tries to pull in the gdb
>> code.
> 
> Or alternatively the gdb module can move the gdbmi import so that it is
> only referenced in method scope, so it becomes relevant only when
> executed.

I can´t follow what you meant here. Do mind expanding on it a bit?


Cheers,
Gustavo

