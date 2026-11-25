Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0C606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0o2njmJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW24u-0002nK-Sn; Tue, 24 Nov 2026 20:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xW24T-0002ii-FF
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 20:45:19 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xW24R-0002PF-Tv
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 20:45:17 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2f04bea9a93so45295145ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 17:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795571114; x=1796175914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a+CjcA9LHt1rChjzFV7aDevXDbMhNMFD4uetVrt2D0E=;
 b=C0o2njmJPzUvqtMpSY/FTGGa+B7UKLVyZxmXnpHLtSCRMa2oQQq19cjr/Bg4jsHAA0
 3ojup50LVmHxAPS729ueBQCX/0ZIx+LmU9Gk3d+zEyy16IA09f7FxBwII28SY77/UZGi
 8Lvb9FuD/0szHph2k+n9zo2bREul09DIVA6C+GFJ2UkQLVbFzwd2KPx8w91lw8uli0AO
 TdQTg0hUtSq0esgMhQU5HRVQ/lT7YHih0ahTRDgIHCMTr8rr6cPlhpruC+uWBwbJGg0B
 yAOifCoCy8yQcqf8hokv6HAWoPphWY1Oh9psq0kXfFygXzC/UKRKOsmihBo+EBg2vHun
 rBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795571114; x=1796175914;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a+CjcA9LHt1rChjzFV7aDevXDbMhNMFD4uetVrt2D0E=;
 b=kminYuIo0G9bSngL8UX10s8n0jzI3AcXQ6x80UFrFMy6/oac+4fOZD8rWgwMtAFAlA
 oshv7O8oGLqmU0m++JH/FNB7oN4c3T6VogmL/LyHdGdq4s3PcFcm/wepbCZgxXCj0Gfn
 dUukFX1WFW8C2kxXHZ7yDez4vKPHm1NY7qrXwkvm7AdVxZwWsInXklXjzTG3KGxNj1Cs
 0F15NepAA1Yuyvt4EykKECLsri0jDUrjOJn64Zgc/Bv3rlBoHexeVmo5Tv/Q3Qurx2RR
 Y+WN4A6piZVCs+TCN3MzlCHPtQ8pTMZs1fGVQGgH9LidRoyQfcRW65yzq4gi+w0GB9Hv
 SCWA==
X-Forwarded-Encrypted: i=1;
 AL+hErHmU5bXqDr3xsDSpjRnUMYxljPxY8wMR7PM5WGDhJD/GmrZ4zqy75FC9DrI85tJO8UviOLzJwPXISdj@nongnu.org
X-Gm-Message-State: APuU4Z/w3C4Oq6tMwbBsWCc5NRWAfUEoFFGSW6Y7I6edThTa/Kbu6M/Q
 jDAWeBRJ4pm2uBpQ+4OdSXmN6I0sgZdj9Q2yExcvnirNW8jXENiGMx0E
X-Gm-Gg: AZFdTZew4akKIhtGUPPxyE6ZQnUIH5/+goASC914+YolKDQjg2v2iV/r87tagsiCioe
 NVv5LtcxpEX8hgnFjd5hXffjMLrEraKD7p0KL9lIUdrcG2OqTbQ4hhif7+hN7gsGZcGrL7sLOWR
 b8qtRNW6k6+r4juFZh8icj5Gcbzpojz6jyjUec429F1gPn1e/IGkDrp8q5YovK6iFDwKToqCjrS
 DmVfVU3axGEwNwTqDQwGvFU0h3Z1jTG3W3+xRRsButjC+P8jazFbZZaDHsn3qjAuTkJkWd0sLoO
 3MWNOpzA8RuIxWle8DfF4PxEqqOd7YnaebV6WLjjz3YsVXKula85VRWccZTImOluU2M3PhMF1BR
 ItEn8B/UC0jEpFddA38Ntn6aYlUvdTta+ASKalg1/rYnMcPLHIndpGC42JWpja7qKWf9Lg2fnnd
 5iOYgxiYRbG6TVLrXPhjo3pVeGXyvjZsIQ9ZEBkmkgoGZEg5FtE56JGYfn9c63Cc8r9kyfnYG/t
 smlUeHAQ62aUvOFtUFNU/zwgIBpjEj239jEYqM7vA+Sp9nMDln6pgL2m+sEkWkvlfAA7UoItcjQ
 SDxmZk+51a5ojDpNlGMX2tJLNMt5axZgfg==
X-Received: by 2002:a17:902:c402:b0:2e9:5507:b52c with SMTP id
 d9443c01a7336-2f03f211b8emr177516035ad.34.1795571113961; 
 Tue, 24 Nov 2026 17:45:13 -0800 (PST)
Received: from [192.168.200.201] ([14.19.17.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f0c2091sm75748745ad.20.2026.11.24.17.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 17:45:13 -0800 (PST)
Message-ID: <afc4d908-cf75-447a-a551-4de1205d4aed@gmail.com>
Date: Wed, 25 Nov 2026 09:45:09 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Provide weaker memory ordering for RISC-V guest FENCE
 instructions.
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Tao Tang <tangtao1634@phytium.com.cn>
References: <20261120-fix-riscv-fence-20261119-v1-1-aeb9ba142598@gmail.com>
 <098d1da6-b17d-40f3-9917-eace9774c216@oss.qualcomm.com>
Content-Language: en-US
From: WX Chen <wxchen0913@gmail.com>
In-Reply-To: <098d1da6-b17d-40f3-9917-eace9774c216@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=wxchen0913@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

     Thanks for the comment!

> We add the submodule we're changing in it.  For this patch it could be:
>
> "target/riscv: weaker memory ordering for guest FENCE instructions" 
Yes I missed it, will do it on v2.

> For our current code style, unless we're in a ifcond branch or switch, 
> var declarations
> are always in the beginning of functions.

Got it. Will fix it on v2.

Thanks,
Chen

>
> Thanks,
> Daniel
>
>> +    if ((a->pred & 0xa) && (a->succ & 0xa)) {
>> +        ordering |= TCG_MO_LD_LD;
>> +    }
>> +    if ((a->pred & 0xa) && (a->succ & 0x5)) {
>> +        ordering |= TCG_MO_LD_ST;
>> +    }
>> +    if ((a->pred & 0x5) && (a->succ & 0xa)) {
>> +        ordering |= TCG_MO_ST_LD;
>> +    }
>> +    if ((a->pred & 0x5) && (a->succ & 0x5)) {
>> +        ordering |= TCG_MO_ST_ST;
>> +    }
>> +    if (ordering) {
>> +        tcg_gen_mb(ordering | TCG_BAR_SC);
>> +    }
>>       return true;
>>   }
>>
>> ---
>> base-commit: 08ed97c33c3818ef51a7c852347a28e9f66807b5
>> change-id: 20261120-fix-riscv-fence-20261119-10a425b78673
>>
>> Best regards,
>

