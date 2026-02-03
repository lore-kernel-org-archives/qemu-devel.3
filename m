Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D9DE73165
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5iE-0008CP-MV; Mon, 02 Feb 2026 21:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vn5iA-0008Ba-0p
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:00:15 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vn5i7-0002yU-4c
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:00:13 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c718c5481so3254615a91.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 18:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770084009; x=1770688809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5fmg29hKLe2OowBieJnYUXEUIHi3qRUzZBhG4pHavXQ=;
 b=QlU6tbNqKeGnBSXmv+GZ5oeoGAcQeVgpWzmuecJUrIvgABdZZL8SbP4vY6uxHtGv46
 M8XR1FLkd5HmPtVTSLP6qg2jvK0gdigEwKQNsxIVjOQqMbCThqfmPA/mwCu/IW4MAxSV
 GdpelC5v31Dzo04nfefQEmg8G8/0axDXTiKUfe/5DaWDI8gfW6AAwayelu9ZEilRINr4
 Gsl+WPvur2lrfK0PdQpfmbPCuAI7prknSVpFvCndaD/loX0wtBF9cTDRL9MTIgfLVqF3
 XcQP40i2ey/tR4bJV2Jfqs+tUPFPfVrCnmXr7asf/bbTb5V2FvndRWhh6bHgyurzPJ/l
 PrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770084009; x=1770688809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fmg29hKLe2OowBieJnYUXEUIHi3qRUzZBhG4pHavXQ=;
 b=oZL5JEs8cgwgFDMhbrF4U6//YWEU3CK2f8h+LRrcy3A9plZ/TWfGUJk1L8HTZcv58c
 qnfA6Ea3HiE9ftnc3yMaZVIlq3w0tkqVaYZ+XXM2AAUYf0GyqTXvn2RdarJWese6Hbb7
 ePs/maQpi5g+VjVzLBNpQDCQhmy+b5Xse9oxt5qknmo1hgBegSGGKQwt4OKmyC4cwhI3
 dCR1bcz8bNVwjCn2xIaQtoLzILGsOLYNvNqheRlZSOg26VqKEDg9+/e2/tTJXrilPDlF
 2dnAsGxwPXlbRmUSUgShzhEQOWNh0JqLwH10fQadk6L0WO3a1CLScKh5Uap0EMMDsmbq
 n1TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn97dQLdS36fNawVBc1mgHcEPe/T+iBrBL0rJJ8hkEJVGnaqmFMMBND1vNXqVVMxcc4EZKe5xIHTll@nongnu.org
X-Gm-Message-State: AOJu0YwYNQDPUBrhgbOAr8QeT3231ok1GOVCVu4FMYJbqVOvy2+rIXeC
 ommkh/dr2uOSKD18WzJbGQUpDD2OVqlSAy+pIYr2q9PAOgwzVP+vmPIG
X-Gm-Gg: AZuq6aKAXV/Zuc+abzhWQwKU7xXLe2RzUXsmb1DW3guMovxpeYHxuRH/vXU58wqovX+
 OuU/O9rvQd1fyODELYpIHiRHTleS1aCiMiBG90Y/oprBRJ4/VtVerE73fNo70jJr8aQJ6T7V7Lv
 +Y3HGREF4B0NWwVsXoG6Fh3FFK5k6OKQPayAG1l5k372b9QdJKEXK56dKK5eosNlAGooR0qRRA5
 1WawksLZTFLXJUXntyLP2gfdSrfkIDgZ1TWM2Wc124Ihg9kQfcrwJyOUGJ8O+p2u2H3ZLTaF+xa
 Vtvb0h/J2uwhJm8nq/Eq+7ocIqERYo/9vVLnSSbmWaHWQJ5SJ0iyYOpOY8EyS6POqMdCOAg8KwB
 x8oDynjb3HSagSCmPyUbql/lvMbs3AkrRqfFQ552QqZ5HvaKV0gwpqKPsHIpoNOQkAS/STuuVpO
 szMwfohSttXoUSj4iKKtJWZEj7sWoH
X-Received: by 2002:a17:90b:3dcb:b0:340:b912:536 with SMTP id
 98e67ed59e1d1-3543b3ad361mr11995652a91.31.1770084009399; 
 Mon, 02 Feb 2026 18:00:09 -0800 (PST)
Received: from [192.168.0.22] ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3543bc01260sm5965491a91.1.2026.02.02.18.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 18:00:08 -0800 (PST)
Message-ID: <a72990ef-c2a0-4411-915f-9b39b1311fc2@gmail.com>
Date: Tue, 3 Feb 2026 11:00:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/4] ufs queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, jeuk20.kim@samsung.com,
 qemu-block@nongnu.org, j-young.choi@samsung.com,
 qemu-stable <qemu-stable@nongnu.org>
References: <cover.1770010668.git.jeuk20.kim@samsung.com>
 <b27938b7-9436-4bf1-a294-09a24ccd2de9@tls.msk.ru>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <b27938b7-9436-4bf1-a294-09a24ccd2de9@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 2/2/2026 10:22 PM, Michael Tokarev wrote:
> On 2/2/26 08:41, Jeuk Kim wrote:
>
>> UFS MCQ fixes and tests series.
>>
>> Changes in v2:
>> - Fix additional endianness-related bugs.
>>
>> ----------------------------------------------------------------
>> Ilia Levi (2):
>>        hw/ufs: Fix mcq completion queue wraparound
>>        tests/qtest/ufs-test: Add test for mcq completion queue 
>> wraparound
>>
>> Jeuk Kim (2):
>>        hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
>>        hw/ufs: fix CQE endianness and UPIU length
>
> Should these be picked up for the current qemu-stable releases too?
>
> I'm picking this patchset to 10.0, 10.1 and 10.2 series.
> Please let me know if I shouldn't.
>
> In the future, please don't forget about the qemu-stable series.
>
> Thanks,
>
> /mjt


Hi Michael,

Thanks for taking these into the 10.0, 10.1 and 10.2 stable series.

No objection from my side.

Apologies for not mentioning qemu-stable explicitly in the original
pull request.

I’ll be more careful in future submissions.

Thanks,
Jeuk



