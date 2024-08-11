Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3023FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 10:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd5fY-0006EH-8c; Sun, 11 Aug 2024 06:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sd5fS-0006D2-W7; Sun, 11 Aug 2024 06:19:19 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sd5fR-0001K4-7h; Sun, 11 Aug 2024 06:19:18 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d399da0b5so2831705b3a.3; 
 Sun, 11 Aug 2024 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723371555; x=1723976355; darn=nongnu.org;
 h=content-disposition:content-transfer-encoding:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPbl44RZis/YhUg22HzSAqCnVsj+ocd8hTYPKe7RUqA=;
 b=AloVQgPc5GQqgB3s8Y0rsBr0VH+3/1pNNsuBv4k97Tm2Jo/JLdY6Tj0hd6Qwt2uoj7
 LGvsz5009IEumCqh8dXWhTc2sZ9EAFiPc5AQButy7FO1n7KuWPLFK3C4N6WEOef+CfbX
 NGqG9qLyd6mfjxOSCjuc7J6CIHzJTp8oVAOGz5yWULVPELTdpKP6uBGIq7Ito5g6mYsg
 MPo5vXCvmaCfN3wetyRJAPfZOnzi46LypCLfDMaGOGuFwsPOACc6RNO6davAb2OMLhzh
 tFklv0TEv3Nws/v5IvIkizkWaSBNmDwNtICI9qzhkOfTBmKnisPwhulBZNccnA7SM8aL
 V8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723371555; x=1723976355;
 h=content-disposition:content-transfer-encoding:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jPbl44RZis/YhUg22HzSAqCnVsj+ocd8hTYPKe7RUqA=;
 b=nxPvJDaykvOcWaEVAbzgsFqflfe4v0YoiI87/QwSFQqlnnq45kHq0mHQXdyu7oQRhG
 eC6zrPsKgjLOvCAYalDshdStO23SAVPe1VrFDOtx93C/oUtRXlRHON+l+G3q8NgaKVqg
 rld2+l9cW7wf64PLX+HBCMgPn+aW2DYEOOr8D9iwlqgnagSxEqs+7tCjwI6r3qSGcmAN
 vygTl/06a4PyQIH1JbXHfZtznweA3VmQgOpNVyqZx/7anmHB46lvFUfdOHJq5w0in9eT
 4FCdBKUwJlYH/3/Dav/W5i9nSYwuT5xYQKVd7See98YucnKKD1BJNejaLAkdvZEdqSUs
 sHCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp91SQYdxHhFiurSNa1mp7Mblydj827B7GYb8YHa84WwefX5YI/DDJKkjuQrjI3RjQhmAkG5NEbYWUK3MiveCdaFGnfyMHLCxP8my0jTpMesfuuLVaV2carez7YPY=
X-Gm-Message-State: AOJu0YyvHzghBrNPPoXUXE2AuDrwHQ+TKE4B0tgWvotn555VfodCLGmm
 7SMqzcAvcwjYDULSO7hvj8Z0ANKVrdRrch4LUbam24HyeIVh3XjRYOf+R58OGoopdJ4W
X-Google-Smtp-Source: AGHT+IE0NNlb2PdUaXlikkONsiAm/wH9FaE0JIMaLLosoz0ZfJhyVmEksvKK1dui0ezAaYVlDpU44g==
X-Received: by 2002:a05:6a21:e8b:b0:1c0:f77e:2521 with SMTP id
 adf61e73a8af0-1c89fce034bmr9473675637.19.1723371554915; 
 Sun, 11 Aug 2024 03:19:14 -0700 (PDT)
Received: from amjad-pc ([192.228.221.130]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874ea0sm2233283b3a.36.2024.08.11.03.19.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Aug 2024 03:19:14 -0700 (PDT)
Date: Sun, 11 Aug 2024 18:19:11 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "=?utf-8?Q?qemu-devel=40nongnu.org?=" <qemu-devel@nongnu.org>, Hanna
 Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?Q?open_list=3Avvfat?= <qemu-block@nongnu.org>, qemu-stable
 <qemu-stable@nongnu.org>
Message-ID: <0647CFFD-4A2F-4B1E-89AD-1B1238342E44@getmailspring.com>
In-Reply-To: <9d121f27-8d58-4958-8159-5a8e2f5065a7@tls.msk.ru>
References: <9d121f27-8d58-4958-8159-5a8e2f5065a7@tls.msk.ru>
Subject: Re: [PATCH v5 0/5] vvfat: Fix write bugs for large files and
 add iotests
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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



On Aug 11 2024, at 6:09 pm, Michael Tokarev <mjt@tls.msk.ru> wrote:

> 11.08.2024 12:52, Amjad Alsharafi wrote:
> 
> Hi!
> 
>> This actually has been reviewed and approved (last version was v6
>> here: https://patchew.org/QEMU/cover.1721470238.git.amjadsharafi10@gmail.com/)
>> It has been merged into upstream here: https://gitlab.com/qemu-project/qemu/-/commit/6d00c6f982562222adbd0613966285792125abe5
> 
> Yes I know, this is how I spotted it - by checking which patches has been
> applied to qemu master branch.
> 
>> Or do you perhaps mean something else by `-stable`?
> 
> Please see: https://www.qemu.org/docs/master/devel/stable-process.html
> 
> Current active qemu stable series (branches) are 7.2.x (stable-7.2, staging-7.2)
> and 9.0.x (stable-9.0, staging-9.0).
> 
> Thanks,
> 
> /mjt
> 

Thanks for the info Michael.

It would be great to include this patch in `stable`. Thank you.

Best,
Amjad

