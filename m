Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAADDC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKML1-0005Qo-V5; Thu, 20 Jun 2024 14:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sKML1-0005QR-2w
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:16:47 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sKMKz-0000bx-C7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:16:46 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52cc129c78fso1142173e87.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718907403; x=1719512203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kh7Fq7G0vOno8gwCjWCBVesE6cLTRymiMkBSA5I/Dyc=;
 b=a2of1lJsGy1r0cdziNcMY2AzOuDk9s1F33+C+c6GP/sffaEA+1xfUHlVY2NT/mzD6/
 Scm6i+EgO0/8AWcxKzXJvHRz6fYX8n0F/d52AWuwf40aI2UxaG5PcFf3xHEZZcxmxdQ5
 uM6Cldl8jE2szVBzSWLIp6qfl2Rp1FaRcTpSwciCHOzPGHizB3f9C0aN+3JfrU2qB2KI
 KYQGfFixPVP4mGKJDNTvFHiGQc+GvCcCXaQCA5osB7KrZbgV//NPTJVWwAlPsoi59SiS
 GFnu5RTqzFNFtYXJNKifnhivYQ2fTbjBAwWNWyFM4+LJHJtdYSN9gRnbcscB/NuKInFt
 Xasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718907403; x=1719512203;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kh7Fq7G0vOno8gwCjWCBVesE6cLTRymiMkBSA5I/Dyc=;
 b=EqFyV2Y4HAzDipBAOzfXgSsEooEZoWtKk9a8hMUexY3/muQST+3Mwj6Baxq6VsOGuo
 Tsjna6cR8jedvjlWNmDDZ7GJh4V6VtqL5Mr1PhV0mK8sFkr7C8yNGw8+uGWOdIYe7rnp
 Quft1xUqkhRxdWbm5feD/STUuleOYzUUZs0z5h2XxAzGq4gjtxow7YE6Pt1BYPB8Alsf
 UGiGrMvhpGgFpNvHq+SZYv4XtAiYrqaZgT8xCGe2rpXUuYiI4AJRfxogVsHGSz69xEJE
 76CBngo7emFalelAwD7eJKxkFJtLGtZ0dsj9P55aT1b8zgCzKi1qsL8OqR21b2UTyW/F
 HgNw==
X-Gm-Message-State: AOJu0YwRSuic9yy61iqlDqbS0rseNUy9EJQoGUW2zmwdRR7e+bUlIbd/
 /2aFJoOgbBHhktTbj26VblaDLGb9jeiDTlUZgehLpujhMDmoi45tCBA/qBsGbsk=
X-Google-Smtp-Source: AGHT+IHptl4i634FdmFix5CbMeL+AbkDWWJZQfHPzRrOq6/ju+eaD/fAIuNfkmlbB+N/uAVvUpcrKQ==
X-Received: by 2002:a05:6512:1c8:b0:52c:39eb:40d2 with SMTP id
 2adb3069b0e04-52ccaa5e026mr3419656e87.20.1718907403403; 
 Thu, 20 Jun 2024 11:16:43 -0700 (PDT)
Received: from meli-email.org (adsl-103.37.6.162.tellas.gr. [37.6.162.103])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d1e38dcsm33151995e9.36.2024.06.20.11.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 11:16:43 -0700 (PDT)
Date: Thu, 20 Jun 2024 21:14:13 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 <87y16zbujq.fsf@draig.linaro.org>
In-Reply-To: <87y16zbujq.fsf@draig.linaro.org>
Message-ID: <fe5fs.dfmwsqwldfn@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 20 Jun 2024 16:41, Alex Bennée <alex.bennee@linaro.org> wrote:
>> +summary_info += {'Rust support':      with_rust}
>> +if with_rust and get_option('with_rust_target_triple') != ''
>> +  summary_info += {'Rust target':     get_option('with_rust_target_triple')}
>> +endif
><snip>
>
>I wonder if we should display the auto-probed triple here as well, not
>just when its been overridden?

I agree, once we straighten out host target / cross target detection 
logic the target summary info print should be unconditional.

