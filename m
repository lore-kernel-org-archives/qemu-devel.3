Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2E8C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 10:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2TmO-0001JW-Vb; Thu, 02 May 2024 06:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s2TmJ-0001HU-1H
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s2TmG-0007hD-I5
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714646099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iiVd0G9i8ioNF7sCsNEbc65IpuyI4eDtrz4lbvFtKkU=;
 b=VqDeusXlOtx43K4KAf1ophDZqvUvsDOJOFxpgo5hh3lBa0rmUunM/MJLJFb/u4sHmvboQ7
 jZfVjOVY5urPT/P6eX0SidQyAJebz1HLpKWlQYnVeYrb3gMmhJ/YEDpTi4F/C5lQFOimIE
 B7/shoDy1wjR4DayusrDxf3b1Ahq1aE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-RE380PJQPq2OIa-j1NacWQ-1; Thu, 02 May 2024 06:34:58 -0400
X-MC-Unique: RE380PJQPq2OIa-j1NacWQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-790fbf62b6dso572378385a.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 03:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714646097; x=1715250897;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iiVd0G9i8ioNF7sCsNEbc65IpuyI4eDtrz4lbvFtKkU=;
 b=GsaoMqb+iuMJzJOSPhFAg3eUMdfId/9QZgOv5AtxgV1zp7T4bjkgHd/OftwmMCVwnU
 j5/jheAoA4osPEqxXVfhkqLIvVVWYMSLcPAQCoLaYnHurmUczaztsbzjdkzavJUaVPkB
 x2ydpCC6tM56oVc6s2VL2g7FSf3PJQEzUhdorLypHRFwuOsm4heVjvMm/cB1dyFKx0Ff
 Gs5LLx+obESgcYvNa09c+QKEFfsID22hcv+Iw48ikjniZF3xazaQUMz+fnOBzF8XwSsD
 ly9NsNRCxKhNBfk3PTb2zUvdHoQeKH7tQdUiJmCZNpsWgOK+Sw5i8JxfNJv+5yJY+SJp
 ZFTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhZcKHvdBBJydYkqz/y8DxFsXfnsv3kf9oL4khsBsdgoZf6w4h8gF5vm2SwgVqdH1ArO2zeuPueFbgpHIfFRst3/3qICg=
X-Gm-Message-State: AOJu0Ywvg8LoFvnofM2LjQ1bWoy79YxskyfM4lPH11XRE5ahUnnTrTng
 0ILcPX2bzycpAqGS3Z7Z4zrq03AG5/LyJKG463juzVYt0kwp18T+prOrKwfj+4BapRux0UVUIew
 agTzFb4iEc/UaXCL4RFTb8ErVsjttMUhGT6DX4DsE8LFt9Okn2tg7
X-Received: by 2002:a05:620a:244c:b0:790:c4e3:9aaf with SMTP id
 h12-20020a05620a244c00b00790c4e39aafmr6754707qkn.75.1714646097533; 
 Thu, 02 May 2024 03:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr3unwegbSXQGC04SAnbiL3L3ZxVtHYsXk6XfBU71NKyjD2cAGgFiXO4DpjOlDEelbLcjdxQ==
X-Received: by 2002:a05:620a:244c:b0:790:c4e3:9aaf with SMTP id
 h12-20020a05620a244c00b00790c4e39aafmr6754679qkn.75.1714646097140; 
 Thu, 02 May 2024 03:34:57 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 ay10-20020a05620a178a00b0078d677e72f3sm254433qkb.118.2024.05.02.03.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 03:34:56 -0700 (PDT)
Message-ID: <07cdc5df-781d-4833-9092-af3ef520dbed@redhat.com>
Date: Thu, 2 May 2024 12:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] include/hw: add helpers for defining versioned
 machine types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
References: <20240501182759.2934195-1-berrange@redhat.com>
 <20240501182759.2934195-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240501182759.2934195-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/05/2024 20.27, Daniel P. Berrangé wrote:
> The various targets which define versioned machine types have
> a bunch of obfuscated macro code for defining unique function
> and variable names using string concatenation.
> 
> This addes a couple of helpers to improve the clarity of such
> code macro.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/hw/boards.h | 166 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 166 insertions(+)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 2fa800f11a..47ca450fca 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -414,6 +414,172 @@ struct MachineState {
>       struct NumaState *numa_state;
>   };
>   
> +/*
> + * The macros which follow are intended to facilitate the
> + * definition of versioned machine types, using a somewhat
> + * similar pattern across targets:

I'd suggest to add a sentence at the end saying something like this: "For 
example, to create the macro for setting up a versioned "virt" machine could 
look like this:" (otherwise it's not immediately clear whether the example 
is about only the "macros which follow" or whether it's about how to set up 
a machine type)

> + *  #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
> + *      static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
> + *          ObjectClass *oc, \
> + *          void *data) \
> + *      { \
> + *          MachineClass *mc = MACHINE_CLASS(oc); \
> + *          MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
> + *          mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " Virtual Machine"; \
> + *          if (latest) { \
> + *              mc->alias = "virt"; \
> + *          } \
> + *      } \
> + *      static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = { \
> + *          .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
> + *          .parent = TYPE_VIRT_MACHINE, \
> + *          .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
> + *      }; \
> + *      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
> + *      { \
> + *          type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
> + *      } \
> + *      type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
> + *
> + * Following this, one (or more) helpers can be added for
> + * whichever scenarios need to be catered for with a machine:
> + *
> + *  // Normal 2 digit, marked as latest eg 'virt-9.0'
> + *  #define DEFINE_VIRT_MACHINE_LATEST(major, minor) \
> + *      DEFINE_VIRT_MACHINE_IMPL(true, major, minor)
> + *
> + *  // Normal 2 digit eg 'virt-9.0'
> + *  #define DEFINE_VIRT_MACHINE(major, minor) \
> + *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
> + *
> + *  // Bugfix 3 digit  eg 'virt-9.0.1'
> + *  #define DEFINE_VIRT_MACHINE_BUGFIX(major, minor, micro) \
> + *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro)
> + *
> + *  // Tagged 2 digit  eg 'virt-9.0-extra'
> + *  #define DEFINE_VIRT_MACHINE_TAGGED(major, minor, tag) \
> + *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, _, tag)
> + *
> + *  // Tagged bugffix 2 digit  eg 'virt-9.0.1-extra'

s/bugffix/bugfix/

> + *  #define DEFINE_VIRT_MACHINE_TAGGED(major, minor, micro, tag) \
> + *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro, _, tag)
> + */

I'd suggest to add a separate comment for the macro below, explaining that 
it is supposed to be used with __VA_ARGS__ to pick a certain other macro 
depending on the amount of entries in __VA_ARGS__.

> +#define _MACHINE_VER_PICK(x1, x2, x3, x4, x5, x6, ...) x6
> +
> +/*
> + * Construct a human targetted machine version string.

s/targetted/targeted/ according to my spell checker ?

Apart from the nits:
Reviewed-by: Thomas Huth <thuth@redhat.com>

  Thomas


