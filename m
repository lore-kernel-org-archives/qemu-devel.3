Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF0AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2K7-0004q8-ID; Thu, 08 Aug 2024 08:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc2K4-0004dE-7b
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:32:52 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc2K2-0006Zy-AI
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:32:51 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a3b866ebc9so1034288a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723120368; x=1723725168; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wTSiyKPnaw/uInE49CupWtIjg5aq/0PxxTnUINiiYQg=;
 b=l+JNK16MrOCPTqtz6zNWk1HtKa0JCJNAyBon493s+MQl9XlwUllPKoAhKM3koL2Qse
 vS3V+DWiDEO9M+PEYZHCSqA2YNt34LH6KzMVjVtxL4WveFaHVPKm+NJ3X0btmZWdYG1c
 xdjoUYkIB1fHU7cI/XjholvIKok/QqBNbhrkwfD5uLrrYoCbBcRMb2a3Yixx6kBu7Kmy
 TAGElr1CxDrskVT4GXPBYvnTYqE4seasR1I5hycygbVW5UN77CEHsSduYy6bSA2mHJYP
 J0xzr+VOVm0agEBT06RadC+/lTsPcegQ9bKjPkjkVLfcZ6F3njQXTWB/JVvyKEwPsSWr
 O2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723120368; x=1723725168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wTSiyKPnaw/uInE49CupWtIjg5aq/0PxxTnUINiiYQg=;
 b=JnsbVn5GC+mtxyQizH0VPem+XFPQ3pYbe0nrH1Lf8ixEQmKBsqmsQ6pczoey3zVrLT
 XZHiVeAOAT3FG+OusubwQRNP0fIlIi86CXpWqhYVGjl1j5hsvADM5dgbN2IwbGy76SI7
 ujRZGvEU4QCWC4p85qRmGVYblSEHcKgO1pJmUbxHxy0/y9WEfHRv5g7BtNmsFAzUHmwL
 vJXeTWQsw4+eSNTwCwyD0SVXFYN+t+bp0xkoo1N+LCoFrF/ulSqG4kDWqal1+c8UVDRq
 xSLPRcpAbDPlXhpN7rqT9uwnDXLBHAHaeBQSl/j6V0VmlA6Cfx06Vor8qHqnItOJKmp+
 uMMw==
X-Gm-Message-State: AOJu0YxgfgZmaRVUGRYZorDI8dTOR8rMz63wLN5KPANShCbQ6yVAMCca
 csW2dXKyU133cR3lFcBPKCmXIrJvOZlvkffwZqD8vC935iVxVvIJI6T+GE2CDQBmY4mh7LIq21M
 VZznPMPuV2GG/64JZP7etUohfGHSIQ+evtNXVCQ==
X-Google-Smtp-Source: AGHT+IHLNlVof4v5/TRlM4HRco1HYJox+7uhIy8FPmxWgo1GE75oLEKqdZ9sewJgHe1cHK8G95jaCD2y0pmfEZ1Rcmg=
X-Received: by 2002:a05:6402:448f:b0:5a1:c7d1:ec5f with SMTP id
 4fb4d7f45d1cf-5bbb243592cmr1026781a12.35.1723120368110; Thu, 08 Aug 2024
 05:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-2-jmarcin@redhat.com>
In-Reply-To: <20240806160756.182524-2-jmarcin@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 13:32:37 +0100
Message-ID: <CAFEAcA8tjPr+6ZQKLGb0i7Moj151RDgvRPYmKnMRo0=gknqUaw@mail.gmail.com>
Subject: Re: [PATCH 1/4] reset: Use ResetType for qemu_devices_reset() and
 MachineClass->reset()
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 6 Aug 2024 at 17:08, Juraj Marcin <jmarcin@redhat.com> wrote:
>
> Currently, both qemu_devices_reset() and MachineClass->reset() use
> ShutdownCause for the reason of the reset. However, the Resettable
> interface uses ResetState, so ShutdownCause needs to be translated to
> ResetType somewhere. Translating it qemu_devices_reset() makes adding
> new reset types harder, as they cannot always be matched to a single
> ShutdownCause here, and devices may need to check the ResetType to
> determine what to reset and if to reset at all.
>
> This patch moves this translation up in the call stack to
> qemu_system_reset() and updates all MachineClass children to use the
> ResetType instead.

I have a work-in-progress refactoring which makes
TYPE_MACHINE be a subclass of TYPE_DEVICE, with the aim of
converting all the MachineClass::reset functions into
proper Resettable reset functions. If we did that then all
these reset functions would take a ResetType anyway.
But I might not get round to having another go at that
refactoring for a while, and this is a good cleanup in the
meantime.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

