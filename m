Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D4FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAwN-0006uX-Jp; Tue, 23 Jul 2024 04:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWAwK-0006tC-Tu
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:32:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWAwJ-0002IV-4E
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:32:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70d138e06e3so2077985b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721723524; x=1722328324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KJI6LNdjtvgr2e+iR67OLl6kh+iH+Zs0QBBjycyQLyM=;
 b=za/PL4kUeKhpXGGLXRbf+3wf5cYW1Q7wsd9Zq9HxAYZ1tQFhaDRQt/lHJFOiwFmE8o
 sXdP88xUtv8B8sEgkcb8lFcJcM6ub4/5e6cyFgs36B8+0fLOwcyVnNxSOZ80QHKytzzq
 4NJWNQfWWFMTRvdHLaM6YYS9mqe0DjMGBD8Ua6+ttMaq9600zFPaGdkCcdu9rtoIPxHu
 Gp5oaVSsMjwx9Z6JM4e9YKIl0DPN4Qe9TJgFXUDEPWNdpoQaStdbwiGJPKSQaPzNYD4y
 BMH+rOtgE246w78w4MyJyp2ZkNkf4bnnGSlUpzCzWMRbthcXAb7RtyqSHzvo3H04Tvzz
 q/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721723524; x=1722328324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJI6LNdjtvgr2e+iR67OLl6kh+iH+Zs0QBBjycyQLyM=;
 b=g0jdqaeiElaP7C5StYP5qPDusfFlJ6DbSlz0RB3Ktfk6z6lZthSwUJSTf/Xdo8FZPl
 Yc9CGRCsr86j4MdCS5SUdFx3BEQMWPN76x7Ltpn8QkoAizUCiYSVbuYh4mgiqIgv3kpz
 kJlFPMmgjc/8kRBeT9TpkdUeQ1s6aBzrwHKZ4YgPbCwZqYh+PtlVxHf/xoYsYvh1Q8Vn
 0TaR0N+4PyB/911wtcDWLQ1w6EBvwlIAlHef4P6zLlj9ysNNJhSavwErZv2M5MazIFpx
 eowNoAbYKDyWIanWpv8MCTxXks2rdU3waGzoNXVX08N/DT+dPOgALtO1wAaqU1MmphtR
 bCaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiYdgBpDQHl4seYJCBHqESfSRwtoJ55iOpgb/LHqgkJ9j6VS5mDKwOtb43AwgRnSwZMT9afzmiiIz+Xmp5dBg1b16TGWc=
X-Gm-Message-State: AOJu0YxO5F/apaef0x7BjwPI0HAKsMhS7UJcipC/wtROC0AZ98sGY1Nn
 X7+5ggOtcg/AS7rZ8U9pDfB3ijDoiLkTD7uj3F3eGMxKZxUdZqKp6643VKmhr/7uhmfGMrwSiGZ
 2vgg=
X-Google-Smtp-Source: AGHT+IEypBjnlujltk7VEmOfDKlCU+SLR6+Zv9DfM5CSr0Ode4ZCDZ2gqez6oWri98Ekmzb3FcVSAQ==
X-Received: by 2002:a05:6a00:1950:b0:70d:2837:6089 with SMTP id
 d2e1a72fcca58-70d2837cb61mr8079219b3a.11.1721723524505; 
 Tue, 23 Jul 2024 01:32:04 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:3c7e:f232:ff2a:defe?
 (2403-580a-f89b-0-3c7e-f232-ff2a-defe.ip6.aussiebb.net.
 [2403:580a:f89b:0:3c7e:f232:ff2a:defe])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79f0a3ded2bsm5857726a12.19.2024.07.23.01.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:32:04 -0700 (PDT)
Message-ID: <3514d341-f41c-4723-8306-691734f7ff6f@linaro.org>
Date: Tue, 23 Jul 2024 18:31:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/8] build deps: update lcitool to include rust bits
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <49e451adf4a3203760fb671e7509b24a7e31976f.1721648163.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <49e451adf4a3203760fb671e7509b24a7e31976f.1721648163.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 7/22/24 21:43, Manos Pitsidianakis wrote:
> From: Alex Bennée<alex.bennee@linaro.org>
> 
> For rust development we need cargo, rustc and bindgen in our various
> development environments. Update the libvirt-ci project to (!495) and
> regenerate the containers and other dependency lists.

The cover letter for v5 says use of cargo eliminated.
Therefore no need to add to qemu.yml, correct?


r~

