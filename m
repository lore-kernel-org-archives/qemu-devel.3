Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2DACD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvbY-00055l-QP; Fri, 15 May 2026 12:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wNvbP-000557-7J
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wNvbM-0006Zq-RN
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778863287;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjBZPMHg7/xD5odH5O5oe5BuoaLaAXni0yjS+VAtUvM=;
 b=VEqgwTLnpfO2m6dVD5OsJdKVB+u/y4iEob85U39H98N45dW/HNmbHneM+oKJVfO0lLURhT
 oqoiW0Ay9ead3MtC5su/lFKomdqpYeqxRzlQPq28Z8K8haN5UHGG2ViVITIPOCPJXYXGxG
 e/0k8ZcEpoeDnK5SXXvWgKtBtuEYPrU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-jLX_-uPWPdeE1ROwgG8fEg-1; Fri, 15 May 2026 12:41:26 -0400
X-MC-Unique: jLX_-uPWPdeE1ROwgG8fEg-1
X-Mimecast-MFC-AGG-ID: jLX_-uPWPdeE1ROwgG8fEg_1778863285
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45aeac88af4so3581977f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778863285; x=1779468085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjBZPMHg7/xD5odH5O5oe5BuoaLaAXni0yjS+VAtUvM=;
 b=ZVdr242sG0AYGhL2JUxZi/neJq85thOBrSwMqk24XEDLh7VJUh7HsFIlCFkonXT/uC
 /LBU1EAAMG/0NQaFY9390a5u4DLzcoXSjkucIyV4+UIP8UjVKZFsZynEmjn00yeJvEk/
 8lT3OPSVLSD0M6AI4VD58UYgA3hBey7ZRx9Se1v7QnlEv9WmqUJ6rtpGSbdQliMgK2QD
 p/59FFkDKsCa8uqvJsFoXqg5DCMawrBF5PlDsfQbqYH4hGA1hi8li5/RnZcJIKO0kPTo
 w7zFYdTee5tbSDag+Ug5yed/K4GYeJ4cp0MgYa0vSk14sCTRNSvM0THmkfSBkrdcnxrI
 anAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vr/8nGzct7uA5SieuYLqwgi8zO2PD5J81bjI6XIiPHMCUcT2jeEOWGGBh5hbcCBPVQWeLFiBkK1js@nongnu.org
X-Gm-Message-State: AOJu0Yzl4FFIGlAHchN23Swbgo34zxCUXmGgmyKEWpUDkBMLMRMfZM9P
 uDt/vG5YRKCqekKvYg5Fx8jLJ0f302HzBruj4yBCWEY5CvO9nq8tefWzKG0+UyWoQ/XnV/kigV8
 HC7zIFIiQKWtGhmj41emdomEq6U40mdFv1wVUEX7dGNuBBfi77E8DylAY
X-Gm-Gg: Acq92OHZExzW6XfSQyGtJ5lpIo9wcXE20WvflcNSWLMEBKEDXtiIwba/Jc1+Ka1qhol
 eChGPokLPoLTuWLeAk3KPcS/EQGxYq9MM9xjXdhfmvj0LKSB4GcnSxttfTaushLEBOC2Yr8T1z/
 Lkaq7qSu2RtudwQzZfaL3v30oyH6jgKBhNywxO5qDWmSaN/7YlzM/3Yv9y1HqkKI8Irp887Ha8h
 bk9dFjnCEsk3nkQbj+686csSaiEo3gwGOXZB15hml5mYMMi/Jorf/3ynWtnIkZm8ega8TCOFvgm
 dUutbk7M2mT5Qiwbn/9wPcB1LwmgAbWddJJDa8lJe9aa3BZL21HTfGwizL/U6kUH6nH5+fk3yk9
 6kD6KY9JcRuKbCm77QtB09MGCxnmChpl+K0Px5HZVBIgU2XYYmjdEfPw18iKUYnngMXyYYQ==
X-Received: by 2002:a5d:5f42:0:b0:44a:fa76:5193 with SMTP id
 ffacd0b85a97d-45e5c5af4f8mr7076725f8f.12.1778863284346; 
 Fri, 15 May 2026 09:41:24 -0700 (PDT)
X-Received: by 2002:a5d:5f42:0:b0:44a:fa76:5193 with SMTP id
 ffacd0b85a97d-45e5c5af4f8mr7076636f8f.12.1778863283546; 
 Fri, 15 May 2026 09:41:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm15815025f8f.21.2026.05.15.09.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 09:41:22 -0700 (PDT)
Message-ID: <ee91fb33-1a9f-46f7-985d-b84ba15ad0cc@redhat.com>
Date: Fri, 15 May 2026 18:41:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/17] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, richard.henderson@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@linaro.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
References: <20260503073541.790215-1-eric.auger@redhat.com>
 <CAFEAcA-TE-8cj6fGOYJaChRVB5GE7E8ys87cxPP4Yw1kgjh9Dg@mail.gmail.com>
 <87pl2x9h7g.wl-maz@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87pl2x9h7g.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter, Marc,

On 5/15/26 11:04 AM, Marc Zyngier wrote:
> On Fri, 15 May 2026 09:31:19 +0100,
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> So if the user asks to set ID registers to an architecturally
>> invalid combination (e.g. one that reports FEAT_X but not
>> FEAT_Y even though FEAT_X is supposed to imply FEAT_Y, or
>> one where one ID register says we have FEAT_X but a different
>> ID register says we don't have FEAT_X), what happens ?
>> Do we catch and reject that? Does the kernel reject that?
>> Or do we just report to the guest what the user asked for,
>> and if they asked for something broken they can keep both
>> pieces ?
> I fully expect the latter. Neither the kernel nor QEMU can enforce
> this short of encoding all the various dependencies, which have the
> horrible habit of changing over time. The only thing we can
> realistically reason about is a single idreg at a time.

Effectively at the moment the series does not implement any consistency
check at qemu level (neither on the individual value nor any cross check
with other ID reg field values). For individual setting we fully rely on
KVM check.  

Thanks

Eric
>
> Thanks,
>
> 	M.
>


