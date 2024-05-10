Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C11C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 02:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5G8s-0001FW-HO; Thu, 09 May 2024 22:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1s5G8r-0001FE-3l
 for qemu-devel@nongnu.org; Thu, 09 May 2024 22:37:49 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1s5G8p-0000dn-07
 for qemu-devel@nongnu.org; Thu, 09 May 2024 22:37:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f4551f2725so1412060b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 19:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715308663; x=1715913463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ATsNZcDEu/d8bOr7MgG2WaxuNkDKPY9EO0q7o5pFbJA=;
 b=S9wbEJlTdw/8+PViKcIzo4qZZJBFo7gSNWtZUYcgoSbNwYXEhkdjKhmL5Wx3liMrrd
 AhZv9kN75AAexJlXcooM7UMTsG7EFBDfrxsL7ckLUqm1wTgb0VNgvgNETwjo9x18qBCn
 57NG+s52LPSM5h25B8UJITGCpq72J2/TutSdIvEU3L/cJixW4f/lWwfz3B52+yIJ7hVA
 erHWtQ2ynDBrjEQboSj25k8snd4GJZ9QyJcd5w7M0PV7g2gDRJyA28CJp9Y60tlMzkVT
 tWB20qh51RzhDw86PppTYhjA3f23NAKAvAsEwEWyuPmXYk1BYmpZtkp7+oVH6hNntTuT
 Rh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715308663; x=1715913463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ATsNZcDEu/d8bOr7MgG2WaxuNkDKPY9EO0q7o5pFbJA=;
 b=IWYQ/JlIPGMJfMNlnZVtoDM3W0Aqbzae25ZffDrA+0RRTfr7fEKLAmYoqwKrTT0aZM
 TJUQ344bFYm6KXvRqIuaeqj0gRH3bMtTcMSw2Ai1GA8od4y1s8XfongXyywcbaHnWMkZ
 q+E+llhwWPQJGGFDhZaFPxFitI5djUIO2dkk9zRrnVygzcajtigi0vr2vR06m/gxFETl
 Xuj3kjUgXtnEOZXmsQ4zibEWwj0nHERfbRc0F9DkZn30uvsfrLT+pYWdnoK6RH8L3Lwp
 POrgiv88WYIGXpeY04NFFJJWP+wYmODMa0UOyCbVOp+NqTyPF55rTYIUK4COipjORzYa
 vC5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNZdf2SQDA8JRGzMMqjGxBzEkL/q16ZqG+T0RGeimX10Unh6kWUTAKuHoyFCuBB0UvgmmikZNKm1dsc72d+i/TT7aBX0s=
X-Gm-Message-State: AOJu0Yy9xgxSXEkVRxngrWqZEVVSzuAIlpbnsEzw/ZodKXstohdFTskK
 4OLrQpqZhw3jpEM7lfvPN2hc9uL6WsL9oQHH0t9eOZaUPzb5BZWtgfWUSbYAFQjrfr/RPoFstyR
 9
X-Google-Smtp-Source: AGHT+IGL1uRXcrM7juwa0qSkzTpESXnNglXGDvObhZGvwZ24AW8E5EwkZouye4UznX+Wvyy1yZKzqA==
X-Received: by 2002:a05:6a00:1901:b0:6f3:ead3:c274 with SMTP id
 d2e1a72fcca58-6f4e026bc30mr1360383b3a.1.1715308663136; 
 Thu, 09 May 2024 19:37:43 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a84b6bsm1975641b3a.74.2024.05.09.19.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 19:37:42 -0700 (PDT)
Message-ID: <1d368bb6-a9ee-472d-aec0-b2e11589fee6@bytedance.com>
Date: Fri, 10 May 2024 10:37:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 1/9] block: add persistent reservation in/out api
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, philmd@linaro.org
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
 <20240508093629.441057-2-luchangqi.123@bytedance.com>
 <20240509182228.GC515246@fedora.redhat.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20240509182228.GC515246@fedora.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x42c.google.com
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



On 5/10/24 02:22, Stefan Hajnoczi wrote:
> On Wed, May 08, 2024 at 05:36:21PM +0800, Changqi Lu wrote:

[SNIP]

>> +
>> +    /**
>> +     * Persist Through Power Loss(PTPL) is considered as required in QEMU
>> +     * block layer, the block driver need always enable PTPL.
>> +     */
> 
> What is the reasoning behind this? Will applications that rely on PTPL=0
> work?
> 

Hi Stefan,

PTPL needs to be supported at QEMU block layer in theory, include 
reporting PTPL capability and PTPL flag in PR OUT command. However, in 
the real production environment, both SCSI driver and NVMe driver, even 
linux block layer always enable PTPL nnconditionally on a linux platform.

Ref the latest code:
1, SCSI:
https://github.com/torvalds/linux/blob/master/drivers/scsi/sd.c#L1978
static int sd_pr_register(struct block_device *bdev, u64 old_key, u64 
new_key,
		u32 flags)
{
	if (flags & ~PR_FL_IGNORE_KEY)
		return -EOPNOTSUPP;
	return sd_pr_out_command(bdev, (flags & PR_FL_IGNORE_KEY) ? 0x06 : 0x00,
			old_key, new_key, 0,
			(1 << 0) /* APTPL */);
}

2, NVMe:
https://github.com/torvalds/linux/blob/master/drivers/nvme/host/pr.c#L127
static int nvme_pr_register(struct block_device *bdev, u64 old,
		u64 new, unsigned flags)
{
	u32 cdw10;

	if (flags & ~PR_FL_IGNORE_KEY)
		return -EOPNOTSUPP;

	cdw10 = old ? 2 : 0;
	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0;
	cdw10 |= (1 << 30) | (1 << 31); /* PTPL=1 */
	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_register);
}

3, linux block layers also hides PTPL flag:
https://github.com/torvalds/linux/blob/master/block/ioctl.c#L283
static int blkdev_pr_register(struct block_device *bdev, blk_mode_t mode,
		struct pr_registration __user *arg)
{
	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
	struct pr_registration reg;

	if (!blkdev_pr_allowed(bdev, mode))
		return -EPERM;
	if (!ops || !ops->pr_register)
		return -EOPNOTSUPP;
	if (copy_from_user(&reg, arg, sizeof(reg)))
		return -EFAULT;

	if (reg.flags & ~PR_FL_IGNORE_KEY)
		return -EOPNOTSUPP;
	return ops->pr_register(bdev, reg.old_key, reg.new_key, reg.flags);
}


So we(Changqi and me) wanted to keep PR a bit simple in QEMU block layer:
- consider PTPL is required in QEMU block, then we don't need an extra flag
- the block backend driver always request PR OUT with PTPL flag

Then: Will applications that rely on PTPL=0 work?
Yes, a guest PR out without PTPL will work, but the backend uses PTPL=1 
instead.

Will this request succeed?
If the backend driver' supports PTPL capability, it will succeed. 
Otherwise it will fail.

-- 
zhenwei pi

