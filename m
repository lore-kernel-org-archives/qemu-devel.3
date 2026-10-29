Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34C606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mAsNuP+e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMViD-0002Lp-PG; Thu, 29 Oct 2026 15:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMViC-0002LS-43
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:22:56 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMViA-00068p-GM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:22:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1374581f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793301773; x=1793906573; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DdeaH5sdbARqzOfCM/WjGZQXc7n5RFXvCTy6trPqQKA=;
 b=mAsNuP+eFy+fMVWqUQIkKgC95MNXP8XjsjvtWXEN+2i3BZ1xyTpZI3Atjw+nAbNXxE
 ITwz7RWnzYg03ghCJ+axzPY8RCMlvfkFq7797BpK9dsSCpIHW04fyujiMxXCapA6Mqqw
 qPwkLaMla/N2uP6hGVrk+ikHstjKdHLrQp+oO88HggG97rh3ZHfYs2GtOCuGY0Qh1LE6
 5JtZJswN2I17EbKt3rcnfpr70D+R8aFaJd1XQ4HD8f3DYFQ6VGobVRwxjohhT12ndhFa
 wa2RdXjIcxjOmLsxepvw5br951VJQcY6vh3Yyn5jfIXfsQPjorby+TA10sUw6OWB9dYA
 zO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301773; x=1793906573;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DdeaH5sdbARqzOfCM/WjGZQXc7n5RFXvCTy6trPqQKA=;
 b=sDfBD6LUsPoLA4HHCxh7N8LCdbINxpM7x/XwopaaoN9Cji4ltdxZwiYvQbPaX0I5lt
 dZ5+W8czQOISYXNXpVyrmKzxZk2dNUO0cc2MsyxlgVgzldiAQbU84+MWwu4W9P3Bv2qs
 kwKLJBK5+frcdX+rLPz+kDrNBqZz2bVU0CGs6MfvshBMi0Hby6Mzu/sUwTuNIoJwVP+X
 ohz9Wnoya/dOOzkaLDfBhLX5jhJidImbTf3C72V3r4bNKQ3F/OqRNxLjWkbg/RMAJSS/
 JsNZyAx83Q7B8oUT45D3dhySX6GqxHEn4pjpvythnGZC2lvvCfzkVwNYj5fMjEyJLN6t
 tHCw==
X-Gm-Message-State: AFq9FYJWD+m1Tw270KI5SInrAFaetECgtrBWHJsO48r35WFMbh2ksn3t
 AwSNQhxBf+czDXU6GSK8LNFaiDVOvMxWeOvwGpajRsu7SvpnpymSsgvLOftsoKcwXdc=
X-Gm-Gg: AYBFou2UUEIrzhETHofiOo7NzMgPtkrRCn6Fnp9RtmumaSqeb/2eOljr5TzVmKgK6Rv
 zMVop23J2GiGtHpXQmmvv4SLsy3kfRlr/bOm+NmGAOQAKMmA9Wj90AFB7rQdIlgQQDieOrg5SYx
 Fd5aPS7q7FAfPvsx1nBOeryq2o9AaEJjHWf6XMzqaSxeK0kF6/Fz/RK/t47Tn6deXNl4/n/ks1s
 znY/6BilYhs3no03dM1XGZ0iPYV+9/3+YfLOlw1dMTz4dGomPI5X0l2Z5d7xcmLFXBLnfXjy3v4
 1LlQRz/yX8upYaB9nqzSO1C8xiM8vrb8PKbCo9lB6bi2cOduAe7gJCxrzlcmsKk+NLALmWy17BJ
 mSraIpikIimeUOX9wp3G9zy4DEZyBoaJ8RPlsCi8IAFpRnhyJxGfCEG9ydEk9uOoaH9Xzy9mAMU
 nS6f2mSH7TLk7sBgQ4IX72XHnYY061Xz1gA0pVwW2YK3CEZfDdXtS95A7szzqESE1JKxW1Ki6zh
 hQQjSZVPi49e8q/0cg7OCtAvGsc1dL8ypfIyP/a3SBo5yRGMTYCcQxRrKRpO8nDPSSL7knj45RC
 8UaNLa3rZsuibEGNgfy2rLfjo8p6
X-Received: by 2002:a05:6000:2885:b0:488:88ec:59c3 with SMTP id
 ffacd0b85a97d-48e6e2f2c14mr778348f8f.14.1793301772857; 
 Thu, 29 Oct 2026 12:22:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6eb95384sm301834f8f.43.2026.10.29.12.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:22:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3DE015F898;
 Thu, 29 Oct 2026 19:22:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Chao
 Liu <chao.liu@processmission.com>,  Tyrone Ting <kfting@nuvoton.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Hao Wu
 <wuhaotsh@google.com>,  Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/8] scripts/checkpatch: validate fixes against
 origin/master
In-Reply-To: <e19ba1b4-60c6-47b4-b0b7-71e1be096a92@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 29 Oct 2026 09:44:39 -0800")
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-2-alex.bennee@linaro.org>
 <c8bc6def-3c86-4fac-a84b-6664d40d5006@oss.qualcomm.com>
 <8733toa05f.fsf@draig.linaro.org>
 <e19ba1b4-60c6-47b4-b0b7-71e1be096a92@oss.qualcomm.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Thu, 29 Oct 2026 19:22:51 +0000
Message-ID: <87wlr08g6s.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 10/29/2026 9:26 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 10/29/2026 8:13 AM, Alex Benn=C3=A9e wrote:
>>>> The current check for a referenced fix commit relies on the developer
>>>> keeping their master branch up to date which is not always grunted. If
>>>> you create your branches directly from origin/master this will keep
>>>> failing.
>>>>
>>>> Given that origin/master should always be up to date (module the
>>>> developer eschewing convention) lets use that in the test instead.
>>>>
>>>> checkpatch complains about the line lengths but this seems to be
>>>> standard for the perl script so I didn't try and fix it.
>>>>
>>>
>>> Or... you can use something else as origin, with origin/master not being
>>> updated, and master as a tracking branch to upstream/master, and in this
>>> case, this patch doesn't work.
>>>
>>> Using master instead of origin/master has the advantage to not hardcode
>>> what your remotes should be.
>>=20
>> origin is the default when you clone a repo. We could get really complex
>> and query the tracking remote for the current branch. But if your deeply
>> forked then that obviates the test.
>>
>
> I am aware that origin is the default remote.
> In my case, I always use "upstream" to reference the original project,
> and "origin" for my personal fork. As a result, origin/master does not
> always track upstream/master.

So master in that case won't be correct either?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

