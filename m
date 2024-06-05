Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172CBC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEro2-0007OC-Sz; Wed, 05 Jun 2024 10:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEro1-0007Kk-Bd
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:40:01 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sErnz-0003j9-Hx
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:40:01 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-681bc7f50d0so720032a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717598396; x=1718203196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nSwtMvE5rK81eQRa7ausSIFHp4S37nbALpZccK1YHg8=;
 b=i+a0rpHZ8AIKMN1Y81sp9EtooQjQv8mbNqKcLe+3sKQlo2dEEYNHDgM29FL6HuGqJa
 EiKDWWo1IlXUiZBMuxwVPlmdK9D0jLi/UnKRHNly20XJJW2uF8blcoJrehwH7uzaEeTw
 FzNQKvkQR0SS7Gca+tJQW7XM2FHtGJwlslXopfC1LTBOe8PqDVDtfaOrO46Wbo6HOkX3
 ydFwGYr30UqxrbCkwVuFAcDCzurb0++LJHtLShdxDShfwZK8cWcxmQvPJsaXwQ07HlIX
 pDTzTztnLzSHSrf8EnwiN5bL6gB4fS1m1Tz5iEEqTGwJL+ycwVQBEAAtjM6ZpADVQHVO
 rl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717598396; x=1718203196;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nSwtMvE5rK81eQRa7ausSIFHp4S37nbALpZccK1YHg8=;
 b=JInSJwOaZ2mrE4u+EVWrUrAXt8zqIXmJ9j3B6fH3fY1cyuclZWc1fM3PpyvMqYSLr6
 LIxYOo09JhUkBCcWICYWG8S/84V5EsFs8+FBKc6qF9P+YtimvJGmGq4ccFNE4c+9klcf
 4pRGHpZrIznEi3gL4BLCHJ1QlxCEePEDRnqegcnBMJTFBnrmUuM6XICkffySlkM5YSzL
 uU95ByGzrItDAqMZpJJfT6ehlt6ds/VbvFO1EuWku80wjkdhfY9SbU+OER54M5FQ+wOG
 pKaQfD4FRR75W6kHs5m5ZvpFSNkv6vB3wz6emFvFTBMqMp9HYhvosJLxk8UYj4gRdAQD
 ZHEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV44sCPRDYZb4+gFRKhFuk2QeYzd/hH0KOPVUiqPsVRAo1vkNgwK0zPeOUHm8whknKvfDsG00Cnrb+CIuTwHQqpmRHjVB4=
X-Gm-Message-State: AOJu0YxHsw1KWCPGWYcMogdmU3/2uwtegKqMtgsUlxIVVCwmEE+y7iuf
 JxcHfPw6gw0ELwvCYwG9BUDZril0GeFF2wmHSNVZLTLclyo6j6syANzEzEOK1+o=
X-Google-Smtp-Source: AGHT+IHXiA2lHdbfMHYiE+6G5vzlV/jvpMWSfoWahI665nBPSHkz7FA1Fh7Vjfz61Nr1CCjaGZ+p0g==
X-Received: by 2002:a17:90a:b785:b0:2c1:ad50:5e1b with SMTP id
 98e67ed59e1d1-2c27cbd170dmr4309670a91.8.1717598396532; 
 Wed, 05 Jun 2024 07:39:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2806bd8adsm1533763a91.39.2024.06.05.07.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 07:39:56 -0700 (PDT)
Message-ID: <2eefcbdb-ad41-465a-9c14-1dc15bfff94a@linaro.org>
Date: Wed, 5 Jun 2024 07:39:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 36/46] bios-tables-test: Add data for complex numa test
 (GI, GP etc)
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
 <61cbf56ef1c5dd9dbe6bd6625f6c8d2a82c5697f.1717527933.git.mst@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <61cbf56ef1c5dd9dbe6bd6625f6c8d2a82c5697f.1717527933.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 6/4/24 14:08, Michael S. Tsirkin wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Given this is a new configuration, there are affects on APIC, CEDT
> and DSDT, but the key elements are in SRAT (plus related data in
> HMAT).  The configuration has node to exercise many different combinations.
> 
> 0) CPUs + Memory
> 1) GI only
> 2) GP only
> 3) CPUS only
> 4) Memory only
> 5) CPUs + HP memory
> 
> GI node, GP Node, Memory only node, hotplug memory
> only node, latency and bandwidth such that in Linux Access0
> (any initiator) and Access1 (CPU initiators only) given different
> answers.  Following cropped to remove details of each entry.


This fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7021105504

acpi-test: Warning! SRAT binary file mismatch. Actual [aml:/tmp/aml-GHR6O2], Expected 
[aml:tests/data/acpi/q35/SRAT.acpihmat-generic-x].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected 
files.
to see ASL diff between mismatched files install IASL, rebuild QEMU from scratch and 
re-run tests with V=1 environment variable set**
ERROR:../alt/tests/qtest/bios-tables-test.c:550:test_acpi_asl: assertion failed: 
(all_tables_match)
Bail out! ERROR:../alt/tests/qtest/bios-tables-test.c:550:test_acpi_asl: assertion failed: 
(all_tables_match)
Aborted (core dumped)


r~

