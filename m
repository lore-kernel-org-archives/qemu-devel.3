Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB146E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 12:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAgg-0006Tl-Ob; Thu, 05 Dec 2024 07:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1tJAgV-0006TD-RU; Thu, 05 Dec 2024 07:10:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1tJAgT-0007Xj-UB; Thu, 05 Dec 2024 07:10:19 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a10588f3so5716595e9.1; 
 Thu, 05 Dec 2024 04:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733400613; x=1734005413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wzOqahYN05AJxdvK3zEwaQAfgNzQFqxcSg9tqEAFraU=;
 b=Tr24QUgz3towzE39zeMVvy3pbjYi4uS2j59PeR8QOv0SUGdu3YigP4uGM3iy/ID1LL
 xrQmTEFZqHC3PTrTjlq41ZFsxD1Vjy9IIEEYnv+cozfqXeUhCp8V6M42ojjphnq/FASA
 cOhAddUCxQVBNcGlwppZ3OmOr1TdH2Xn3Gok/dMh3b70LzTi8FAACMF/Y0JTao2eG51B
 IDWq7bpjo0ZPTeyn0QNE6lJPOOre3yJIq49QTjY3sHUedXsaekDUUodoELHNQLekdkHa
 tNf4jQJmY7QN1lfTPX3g+tVVCpdajiVmv8GUXdIRmeUF8YVO0HcxSkVi5HXSW53AuVSM
 SsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733400613; x=1734005413;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzOqahYN05AJxdvK3zEwaQAfgNzQFqxcSg9tqEAFraU=;
 b=HZOWqpJD4LwDs9WIAu4DOYRdqeVXJoAdfoQ9Jv6igHQn9udT4sG6lFHqFhuUBlBV7a
 YRt+U/JCJf5q/ULnY+yL6jchoj1OHaiwqFVjmXZQiQCvTVmkVEmexnIdmLpAkreljluQ
 UFkBWf7Hs7QEM6JpO9PAlbcs8//GqRXr9DNGGkElZqID23xYohvLoH2NUp2pS9dAw+hs
 zV3rZ3Nt26CN6rqDW78e8mBVH5eft53RXRDfehhx7Ab8k9E9otCiwDFrBic3MuKWI+JI
 ivqyyCwtLWsZDLx/txVkevK/cTsRcwW4rh41466aZIk0JSKoq4TpoZ88tLkDyAYOmrMM
 7Hlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvUzEYm0dZveBf3NRLOfmRlUQCwC+nSlw28LZ+yl/1ynZqGt2gAR/0viyA5Xk2LWVvBuDyV+2Xvk2C@nongnu.org,
 AJvYcCWoni1DcFlf+V1npZco6OHWsDVk0ZYRJikqztSbrwRIFPkO8Qpv/BH9FoYr+m1kQIuN9pWT4ZIVZ/64@nongnu.org
X-Gm-Message-State: AOJu0YzYTIzvLu83eLcYVNVUhsSn7nv67sJAYOe38RxPLoKWmS8fvoIT
 8k5Nt4A59KjAIfLmyedJHGTj3ismfUYz5QUP1Kh/7ewcnhQSwr2U
X-Gm-Gg: ASbGncssawVbrX62bSMwagToc/2IejNV/nWuXL99I4F3CWEuHp78sXMW1QCiw+nUnqV
 3UTO/V2nPmIWK9TLM3h6OdbhNRd2vSwi/xlAkDsGSdW0v9IA0xr6uJ8cFZzoyumFxz+382jWd5N
 8dKTxBKYUvH7fTuyYHupnFAHRRAu0PiTe0kxJHMcGfijuJwIqaPVmoDXuprO2c/y5Rvf/SBTOn0
 p43QJEQZUpAycV0HO12IAE9t+H7TuwgdrCOwviSq5jTj4jQVofpHIXQHWZidD1gMt8efTKXmRFg
 OV7v2Q==
X-Google-Smtp-Source: AGHT+IG9tdvRwmyes0gZjCEdCw/TMyaknFY73tgIdnFFdvX525rWDB+NlguS8gp4Su4uIXIcp+Y4ZA==
X-Received: by 2002:a05:600c:3b8d:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-434d3fa051emr73646475e9.13.1733400612429; 
 Thu, 05 Dec 2024 04:10:12 -0800 (PST)
Received: from [192.168.2.208] (54-240-197-232.amazon.com. [54.240.197.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4395sm1778796f8f.10.2024.12.05.04.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 04:10:12 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <2f10ff1f-99a0-4359-92ca-9f648c1908a5@xen.org>
Date: Thu, 5 Dec 2024 12:10:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust in QEMU roadmap
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
References: <cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local>
 <CAJSP0QVGP9RQ57V-+2Lo2Se0x0O1KuENT24HzOn2X3A3vmn73A@mail.gmail.com>
 <Z0cOKGl-46wg5NTG@redhat.com>
 <CABgObfaZkCQMWH9oH5rLdqHB-B8t2n9uWSaYASsBzxiiMK1hRQ@mail.gmail.com>
 <Z1GV4kwvjPoEob6j@redhat.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <Z1GV4kwvjPoEob6j@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32e.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 05/12/2024 12:00, Daniel P. Berrangé wrote:
> On Wed, Nov 27, 2024 at 01:22:00PM +0100, Paolo Bonzini wrote:
>> On Wed, Nov 27, 2024 at 1:18 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>> I question the usefulness of the 'syslog' trace target. I can't see
>>> it being desirable as a option for 'production' builds, and it seems
>>> uneccessarily indirect for developers. What's its compelling USP ?
>>>
>>> WRT 'ftrace', IIUC, the Linux 'perf' command has built-in support
>>> for using USDT probes now:
>>>
>>>    https://www.brendangregg.com/perf.html#StaticUserTracing
>>
>> I also wonder if 'ftrace' is duplicating 'log' these days. Anyhow, if
>> we can deprecate 'syslog' and 'ftrace' that would be good to know
>> independent of Rust.
> 
> I looked back at the history of syslog and re-discovered that I raised
> the same question when it was first proposed. It was said that syslog
> was to be used by XenServer for some kind of logging they wanted:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg00336.html
> 
> I've CC'd Paul as it'd be useful to know if Xen did end up using this
> feature or not, as we don't want to rip the rug from under them.
> 

Pretty sure we did use it in XenServer. I've not been involved for more 
than 5 years now so maybe someone else who's still working on XenServer 
knows better... Not sure of the right contact though, unfortunately.

   Paul

