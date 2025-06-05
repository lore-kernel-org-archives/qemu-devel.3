Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE9AC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 05:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN2n3-0001wS-TK; Thu, 05 Jun 2025 01:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uN2n1-0001uD-Nq
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:05:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uN2n0-0007GO-41
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:05:19 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a36efcadb8so416354f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 22:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749099916; x=1749704716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ky+9e+gWc04bcyNuHemdLzWttMt011MDaus1yaf2M8=;
 b=lgykpN/BvsZU3WWoy8UKxLWv1wdJuWl9gS4qqHbsaVbRtjbnOM7JZ6fSiSEdaQeE12
 8Co9NcrW1Gtoo6BaL/HOum9sGs/l2OOOWsjJKwaYfT0rOiijYCFvHoJyZeABNAJ5xWGZ
 gJZo1B/T73rTRZlPIhcM6FkuRsqU5TpvsqPm3suee7Q2GcZl4NICPxBQbZaHaCL4jLPR
 zu9LexP6rtnag7dfeRIvcz8buj1uNtsps4+3OjnpwjmmAzb7tISSQup4VLDSbBNikDRS
 1pQdaScq9Jd/dSjxPhK/iwOZIi4Wj5EblmZW1SjiN6z3Lyf7kSkvRpUD3BYrpXdbrDhb
 3nRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749099916; x=1749704716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ky+9e+gWc04bcyNuHemdLzWttMt011MDaus1yaf2M8=;
 b=h2ocPWxOb/i+BifufFsoWDWNy1udomGbx8Cykc2izhBdLxgpN8hwTSewomFInl2on7
 ZoeNL/vQSQV1BF80GhXVUvWh2eJcyA0GvttCIzgZcI7kBQCA5cHXVOo0JHQsV1yG/mc7
 /RFbqTMWbbFWpUTPX8iuqzDLSL2oPYVucZSmgG8ra5xcGSGqwTQa/JaqrznIE0A5iRF6
 lTwlO4T/Qh0xIt5zR0qB0YE7OpxLzBXFCyeApn+JeAAp+EgjcJRkhdEjFIvncR/4e5hK
 wi4tS70KYSWShOhP0yu4FyFpOz3MBvlvqOPkioZy7bVwfoXH9cY2JgRleYGxkVXJKzHS
 TTEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXemrz83SOzpoTpr82QYgazBweats4YHtiRSO2xjIRVfR8kDEeRDCekBrQMyDXfCYTDBRBx0hLMQWu@nongnu.org
X-Gm-Message-State: AOJu0YzZ7SajDKoncle/ZHRSjnN4sHQx7wUTtBFju7eyWkTn6gUidoy5
 92AtvpRt2LK5GpYPBzk7bDho/nxAiPrW7doA8atzdiz0wS8NiSC/6hhWRBZHqzmPsSA=
X-Gm-Gg: ASbGncuBms4NfsNfQ4eSDQkKIlRHS19oCqnvR0S6AIpxe9BpIhage1WtJ1Ygy0eBtiF
 ATNOU+f2Ujkvz9eaw44AL6mMFfZL/HR/hZfjKdsPKMngOCAZkh5P74nNrWiib624kzsT5L4PNoi
 0lu6RessyX1YUlKMxqGsUbKRM1jOaCq87tPX6zUvFbz6BiYxJsctfMkkjiK4+obk/tdsibz43pB
 JRHK/xI8CCftfvudakRrhDaIlP9u4bFy3abin8oifqk8bYyeJqmrRoR0ON4Hs1s0RGv6c4N4vsm
 CxEltZbwAtqzx1bcWFkNF3tBeiL8GVtpqZCT8/e2zKgvoN0U5zbopfGElVkTJzxjw6jVsoUn3D8
 Ml53KooqytC41SSHyry4=
X-Google-Smtp-Source: AGHT+IETOhSPYv4PYTVLK044YdEBHEtNaC/qw6MLdCmZjpKiU8htCZmPmTeByoHsZEmvCunZW2X8Jw==
X-Received: by 2002:a05:6000:1a87:b0:3a4:f7f3:2840 with SMTP id
 ffacd0b85a97d-3a51d8f60c3mr4608047f8f.1.1749099916328; 
 Wed, 04 Jun 2025 22:05:16 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb16943fsm5674515e9.6.2025.06.04.22.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 22:05:15 -0700 (PDT)
Message-ID: <717196e0-14c6-4cae-a852-7460c8fb8277@linaro.org>
Date: Thu, 5 Jun 2025 07:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ui: fix VNC endian regression & improve tracing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250604162243.452791-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250604162243.452791-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 4/6/25 18:22, Daniel P. Berrangé wrote:

> Daniel P. Berrangé (2):
>    ui: fix setting client_endian field defaults
>    ui: add trace events for all client messages

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


