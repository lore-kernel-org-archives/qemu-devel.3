Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BFDC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCaW-0006C6-2m; Mon, 04 Mar 2024 12:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhCaU-0006BV-2w
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:58:54 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhCaS-0005Pz-HZ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:58:53 -0500
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7bb5fda069bso312663139f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709575131; x=1710179931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hq/FixD+nGs54fzNASOm6ZEXxaHKd6vqf1kVatDBhSA=;
 b=mWBlUAhQR0HBjTSxBx0eIcqA/uxe0A2YJRP+GY72BLLcwa+LYtffci2pjnUj6RT/qZ
 imoqz3TUFCL1B7edVEuGjsHEWAniCp4Fnqq1TRnJ2gT7R8eR1R+CikCdCZmtDx/KhnL8
 Y3b712SBUd7ID0uZBH+NWPcG6TQdSKI/1ggwfMnqJTiCPl0w80A+DEho0E2GHyBfvXwp
 sfpAoOhWF9UoCLJzOKHwytMTZDI6uiJd4PZ/HRrvyZIbAulzbhKMIkjlSD2/3/r7DEtK
 6zQSeXTyEtz87k5vqb1AmIW2LpHMcs3fxzkoD8Wh7HLQtc9mZRQNPs5BiI6OOhiTw9Dq
 wq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709575131; x=1710179931;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hq/FixD+nGs54fzNASOm6ZEXxaHKd6vqf1kVatDBhSA=;
 b=JCcVp3XjE1GQ/YUx1zhQo5l9UgmoC/DLXoRELVhb9ZqKcrVCAN6WRHFEELRSr3mCAF
 p0v4boAK+2dHOv/oCtlrWKvtJrtU4fJVDV6MNk7zAaH0D3vdTv94R0xEENrzV8mNbUps
 RgKo0CtpE8a8+eb2/REfeTaEoGbSWRdA3YTkWl+CQUuI3CSg0RYItMot+H1FJbaAmwx7
 KK7stxQuqXa+wS4QAnfS130436ZBUtEkfvdMXYQsXuzae0MW6vD0HhpDazyM8K7moO9L
 C6fDNz8tjw+6lKLfXFhFOf/yoItBUuZg0fOMWKZIYZl4j33D0DscIgwvdRfDRl3dk2A5
 iL+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW82bdTfkzz10kT1trVGT8V3MuTnE00bP96PxFiw/b91OS7lHsUtftPfNQZGS5TPTDsi/p+XtT1A1Zoa/9B5Rvx9dzsjWU=
X-Gm-Message-State: AOJu0YwFUS+1JVJvLgWum4g+zqqcXjCzLUOEncIWXqztZzXlZOt1FBx4
 vGegRZagoP+VlF+h6t6ZSKk3yeMXKSGB4sxhCG0oshZfqfujnFDshKePW1ICehY=
X-Google-Smtp-Source: AGHT+IFKApj1rbHnmoFz+vYQH65sZRigZRqA/Q3Npldy75A6MWfbBmeGAAYah0WVn2vGZsZuC26wEg==
X-Received: by 2002:a05:6e02:1c0b:b0:365:da4:ec9d with SMTP id
 l11-20020a056e021c0b00b003650da4ec9dmr12797802ilh.15.1709575131198; 
 Mon, 04 Mar 2024 09:58:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x10-20020a02970a000000b00474fbcf19f7sm204492jai.129.2024.03.04.09.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:58:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE66B5F89D;
 Mon,  4 Mar 2024 17:58:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sven Schnelle <svens@stackframe.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH v3 01/12] util/log: convert debug_regions to GList
In-Reply-To: <87bk7uue47.fsf@t14.stackframe.org> (Sven Schnelle's message of
 "Mon, 04 Mar 2024 17:59:52 +0100")
References: <20240301174609.1964379-1-svens@stackframe.org>
 <20240301174609.1964379-2-svens@stackframe.org>
 <87jzmiz3oa.fsf@draig.linaro.org> <87bk7uue47.fsf@t14.stackframe.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 04 Mar 2024 17:58:48 +0000
Message-ID: <87il21yj3b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=alex.bennee@linaro.org; helo=mail-io1-xd32.google.com
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

Sven Schnelle <svens@stackframe.org> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Sven Schnelle <svens@stackframe.org> writes:
>>
>>> In preparation of making the parsing part of qemu_set_dfilter_ranges()
>>> available to other users, convert it to return a GList, so the result
>>> can be used with other functions taking a GList of struct Range.
>>
>> Why do we need to convert it to a Glist? When I originally wrote the
>> dfilter code I deliberately chose GArray over GList to avoid bouncing
>> across cache lines during the tight loop that is checking ranges. It's
>> not like we can't pass GArray's to plugins as well?
>
> Looking at the code again, i remember that the reason for choosing GList
> was that the other range matching function all take GList's - having
> some functions take GArray's, and some not would be odd.

Ahh I see. There wasn't intended to be much of a relationship between
the dfilter code and the range code apart from the fact I re-used the
Range typedef to avoid duplication.

> So i wonder
> whether we should convert all of those functions to GArray? (if
> possible, i haven't checked)

I think that would depend on access patterns and flexibility. For the
dfilter there is no particular need for sorting and the principle
operation is a sequence of lookups. For the other use cases keeping a
sorted list and quick insertion might be more useful.

While its tempting to go on a wider re-factoring I would caution against
it so close to softfreeze.

> What do you think?

Lets stick to the dfilter case and worry about wider clean-ups later. As
Richard points out it might be the interval tree makes more sense for
some of these things.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

