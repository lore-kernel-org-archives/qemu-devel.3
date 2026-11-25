Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E35606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a7ZZQ//K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW9Gi-0006C1-6A; Wed, 25 Nov 2026 04:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xW9Gf-0006Bd-NO
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:26:22 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xW9Gd-0007FB-Uu
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:26:21 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4ac08f4a0b2so3884418f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795598777; x=1796203577; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Tk66ItGdxIeNkyUvod1fnD9kegyVU1Z4xwDjcRLdk2Y=;
 b=a7ZZQ//KOIUTzP7Em5cfhJZARiJ6qLLvL9RRlD6/AfMn9HVeWjmYqGbh4OyqUWWcPV
 IzzzjNspKqEx7J1BkVMqcin1K2NtDgCz56tTKMe1lGbxpUDqNF+akHvuXenozbxN72Vm
 hbv4Qofu9JdL7yDnO9mFuKXzk/oNYlIB4ag2Wq23JGDCNGZit8n6S4j5f4MzhVpw4Pfi
 9bvrqhzdSRweGbJxR8c5ehx/UYSULB3MLV/Tn/5q+iGpEGV913ZJOJ7vjGOsPVMjs6f5
 /OpcpOuWT3f6lFkS1fUqh4CORRZkWSwxS+UzCDjuqjY25hgrGtmo7/5sMnI0GjsmPQgP
 DWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795598777; x=1796203577;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tk66ItGdxIeNkyUvod1fnD9kegyVU1Z4xwDjcRLdk2Y=;
 b=X6hfJHA1dAgqIoESv3e07AuS0AouvOMfOR8aOg/xaqqccQzH9xT3F7gEh8dCkI+fhp
 0mCReWSCLg62+24mLG7g98dNqt4ReRYawO7aHIGoa5rbotYC/t6tidgkk7EM/SAqQmF0
 rRuU8MaxPOrpk+ExTnDSv90/leHQk2CZ00foYPRY5Wd7A0GK9rCzakqshppekHdCkio+
 NR/Zg1wnGhssiylQiyifCLJ6MYZI96drEdOOFfPnvJ4avyPnN1wF+sbqWNuRFyE37A0O
 S9bM+PBbGSm+TxvqCGcD8lZhh3EYgI4CWNayqiUQj8HrhW9cRaP3vEnYoX7cG4nZd2EV
 PnOw==
X-Forwarded-Encrypted: i=1;
 AL+hErEc1YdGURP23td2PAA1AZWt359pnippvToj/gTFh6KqYOgzhjDqWUpyAwr/HGzStY8v+ROvPiTBzUFH@nongnu.org
X-Gm-Message-State: APuU4Z/jpcI4B91boshet8RVS5zrKgYtRAwdImL4kyPNLd1rlCdFRrx2
 VUhC/FI7nxpwIQsbn3UQTcCEZJUCO0D27X9Sd3+3MGsGmixzyiHhmXvEjOWxiFRfq2k=
X-Gm-Gg: AZFdTZes5xQMHL4Rd8Y2qDFlcrTsK+J/BGK11RrTKHI0X9JZrSpNCwoafRxyqD2fPfV
 7vzH2LBtz5C7bohclSQxe56BWANnZzwyCI/rLFPOOSxvKgvswHRbzEfO9lowGBEaPs20xdM+Jzg
 uChTfkvsNo1vOMnn4NI1sJvocbtdxPA2C4P4fGqBL7iBNgt6PJz0dOMcwR3PlZ7y6fK75EzJ+zj
 uECY1eGzlmExOEvMlFopz3Nm8dWmcqNXZ+t1yTciuPqwBRvlWmR8mRUu7alGF9pmhmpCB80q9dg
 7Rg5b6aaNHwL1RyX6aW4+i7yx0b8ddn35CJBNYOsbcBuy4fVpEcnwZegfv0X1J6rVjy5OP+hiej
 Nd56D04DtYfYbOXOW5hq+cP9n75WJy5gZbnVC0dAS3vu5yAvMkuC1x53kCBR68CZYRccif4XUpY
 hY23y+a99gVOWiwb207RQlMu/USaiOud1iZ204Nq6LnLLGF2/SeDhsEJi1iTeFnsihB223K1S30
 3CykzxlC49Z7lDtdK0r7sNtYCUzGvOs5lCXYMtmCfdsS86y+d7iqJJ6r1bwtThbYScuUb5pJwZ1
 zO6C9WF3/gdU0hDE79CvzK5LwEoJR/yilWCj36X8akS2UHZvvQ==
X-Received: by 2002:a05:6000:2f89:b0:485:8cc8:1f5f with SMTP id
 ffacd0b85a97d-4ae0a0b0809mr27869273f8f.42.1795598777380; 
 Wed, 25 Nov 2026 01:26:17 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm24834495f8f.15.2026.11.25.01.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 01:26:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A96F5F857;
 Wed, 25 Nov 2026 09:26:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,  "balaton@eik.bme.hu"
 <balaton@eik.bme.hu>,  "mst@redhat.com" <mst@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,  "berrange@redhat.com"
 <berrange@redhat.com>,  "imp@bsdimp.com" <imp@bsdimp.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <6f8a8cb816482599f4644bba33ffcb08d1ce63c9.camel@wdc.com>
 (Alistair Francis's message of "Wed, 25 Nov 2026 05:33:31 +0000")
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <6f8a8cb816482599f4644bba33ffcb08d1ce63c9.camel@wdc.com>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Wed, 25 Nov 2026 09:26:15 +0000
Message-ID: <87h5h5uurs.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Alistair Francis <Alistair.Francis@wdc.com> writes:

> On Wed, 2026-09-30 at 10:54 +0200, Paolo Bonzini wrote:
<snip>
>> +
>> +An exception is made for defects detected by specialized tooling,
>> +including fuzzers and LLM-assisted defect detection. Such issues
>> must
>> +be reviewed by a human before creation, must be created by a human
>> and
>> +communication with maintainers must be done by a human, but
>> including
>> +the verbatim tool output in the issue description is explicitly
>> allowed.
>> +
>> +.. [1] Official project agents may be exempted from one or more of
>> these
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rules, at the discretion of the QE=
MU project maintainer(s).
>
> Where does this put LLM review tools (like Sashiko for example)?
>
> I have been using Sashiko a bit for catching issues in RISC-V patches
> and was planning on trying to see if we could get an official instance.
> What would it take to have that exempted as part of this?
>

We did talk a bit about this on the community call. I don't think there
is any problem with people running reviews locally but if we really want
to reduce the load for maintainers on first time contributions it would
be good to have automated review on the list. However it would need to
be funded and so far we don't have any company with deep pockets
offering to pay for project inference.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

