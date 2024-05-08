Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DB9C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 18:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4law-0007TP-OM; Wed, 08 May 2024 14:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4laO-00079E-5m
 for qemu-devel@nongnu.org; Wed, 08 May 2024 14:00:15 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4laH-00035r-P7
 for qemu-devel@nongnu.org; Wed, 08 May 2024 14:00:09 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a59ad344f7dso5588966b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715191203; x=1715796003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZJO32XRbS5gpW7VoJZLLKNMjRbTvTZBxoboBCyFSrg=;
 b=hY9ZGiYJ4ZKPRhsqY/z0qmgUqOOCIKahCKu1P8h7SyAm7MBW1Oo1Acl0KalX7E2UTI
 XZYL01eYMKb7z2TG2D/Cg0xK8Rlsw09kxOZrY2oA1KSpogRYNFh2uHxZ/gZj5GHnkG+3
 3uEdCCchvI1M/fYlwAmQmuKQvfMlPdt6+VhZWlJjUOh826+yUzaXF8SpKe4i1z5aFFvX
 1zLWWRjPE5b3KCD3fdmhPSOhdAsDQUW1qitA7uQ2t1nlE8Izq9/ni5gsoa/layaUNHDe
 PDRUdV+Di6et22qQpXIc3r0xVzIB6m7oWXR+FAJlOsfDdDXtilVGB8pt6lqgxLiG0nr8
 BuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715191203; x=1715796003;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ZJO32XRbS5gpW7VoJZLLKNMjRbTvTZBxoboBCyFSrg=;
 b=MWlvJmcxNmwOyUcwUJjoLdevatp3OC6nWfO8QZwrxV+ujboz5vdPWMQeaElmyaEAEM
 kCyT3BdG7A5xCd12njfMvkDrkQafcCdpCLjMTwoXju5/4keTlFuJwFRzSgNPsLAmHPWo
 GPzTE5YZsLvFk+QoAdkjUJlEkhEwkdkigM/j9iWxtrMDcu3+VVn/m4a5vUcmNk0ZAEc9
 byMpUXNQMj/64UIiJUV3MXxmagVJ4U5EKRvXnG7Lb7AoIxHbxQ6p70gJWwbMY3NJNa3n
 zooYNTv35qPwLqYzvYjlYbQAiUtu7Or0paoJItfCO3XEfoQvMp7nYathYlWjmLmJn9ik
 qlSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlSuVdQP2EVS9ztEi2CSvU7fsZYg8L2YsSLmNsCUCDbNueTp5GZPLWgTMM8CwUNWaHTW3i3fB8l4j1ehIkUMZQBjtNR1U=
X-Gm-Message-State: AOJu0Yyq4PTJGcK449pxV0epUYrewzIl9CFqA0s+DIMMOCjayd0oEEvb
 r1bnIswlXf+rYuOGS7dJot5Vq0+t6S6OfazzoOsj7GvatGKWMTQq
X-Google-Smtp-Source: AGHT+IHKsQIrAXYaLCuoVclvOpnutgB+N5EhYedplX4Zal4SUz1FXVZ6SQlGtb3lTqOHDwAvb9RNhg==
X-Received: by 2002:a17:906:c444:b0:a59:c28a:7ec2 with SMTP id
 a640c23a62f3a-a59fb95dc67mr194023166b.41.1715191203110; 
 Wed, 08 May 2024 11:00:03 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-167-103.77.13.pool.telefonica.de.
 [77.13.167.103]) by smtp.gmail.com with ESMTPSA id
 cf14-20020a170906b2ce00b00a59ef203579sm2135820ejb.138.2024.05.08.11.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 11:00:02 -0700 (PDT)
Date: Wed, 08 May 2024 18:00:01 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/6=5D_This_series_changes_the_=22isa?=
 =?US-ASCII?Q?-bios=22_MemoryRegion_to_be_an_alias_rather_than_a?=
In-Reply-To: <5bf68cc8-a602-4362-b1c7-0096a2df3f07@linaro.org>
References: <20240430150643.111976-1-shentey@gmail.com>
 <5bf68cc8-a602-4362-b1c7-0096a2df3f07@linaro.org>
Message-ID: <4CA13F27-AC09-461B-AEDC-44ABF3FE3400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 8=2E Mai 2024 14:53:49 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <philm=
d@linaro=2Eorg>:
>On 30/4/24 17:06, Bernhard Beschow wrote:
>
>> Bernhard Beschow (6):
>>    hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()
>>    hw/i386: Have x86_bios_rom_init() take X86MachineState rather than
>>      MachineState
>>    hw/i386/x86: Don't leak "isa-bios" memory regions
>
>Patches 1-3 queued=2E

Phil,

you requested comments on the bios attributes which clashes with patch 3=
=2E I've just sent a new iteration of my series with all your requests addr=
essed, including the comments=2E

Best regards,
Bernhard

