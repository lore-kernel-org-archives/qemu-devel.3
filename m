Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE47DC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 08:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCbDN-0001U3-7C; Thu, 30 May 2024 04:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCbDJ-0001SU-Sj; Thu, 30 May 2024 04:32:46 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCbDF-0003oX-3a; Thu, 30 May 2024 04:32:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f44b5d0c50so5423985ad.2; 
 Thu, 30 May 2024 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717057959; x=1717662759; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNoIougyFXeHrf4PDfXx6RJWj34/924phvj8XNYt5tE=;
 b=gEdeqlYPbxL9nw7wKChL64j/3z2pfETthEjHXdyOQ0oJahW3+HI7xVLbctPqlaqr+V
 +myuZetZYstWM6xr0zw88b+2qBBVj4eMJ414DHYW3jVJYF4xcgBqb3MBt47Z4cK6mt8O
 D9PhqMYCyN5YOwLbD84g3miAZR0EckLSPOUJ9s4eseFjXj/6KF6YfzFA60SwlWJQqryP
 VFv4cyxjC3naz72luvAos7GmiuB6njT4LZZs0AMDUbFfoBDlD2kD0CXNiZE+JwJOyABw
 uepAr6oXt++HMqGc3YWOKU0mh0ww7URztrC3ivyDfLRYiT6VFCGAaj+WZFUJC4W7rKQ1
 njPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717057959; x=1717662759;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hNoIougyFXeHrf4PDfXx6RJWj34/924phvj8XNYt5tE=;
 b=suoyam8AV9QKwWLfAouoXFvXqHZ+axb6UPCxbNDwntlg/Bz9ZczDEG7OF/QQUJkpb9
 1v5mpw0zA74gBq2Ch4ysmyMbM0XFWfPo1R6KJxzYXnI9YxiY2pZt08qul6dCzaAIZtMN
 Nd4Cpx5xbq3UDdceXPcdLRCHmjoJ6oWeYwBJ3U0SA/26xrKfQK9kaNbLlC60NISgtWg1
 SC3BCX4OxWwRpfIA5tAsvCZnQjmD62UFIFlyVYpa7cjwlshO88yknS2nxw87hGZfxtDi
 RFS3HkTAU2vXAA2IFCUU5JUYzfTFnOwP0brjDOAliCLFHggSIhrNfjUFjOu4wF7fXis3
 bkJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT+Qq6nXSKHlpqt3V+7/oCa6m25o7MkVoDPSuqn22tPBRK6IEXBUCDzAdhgggL5h7k58jel0LXwn58MORycQn4B+Qs6tZQPm9rFM1WST1auHZpYgg2fRk9ECM=
X-Gm-Message-State: AOJu0Yw3aSc652085a6hqr7O+BhG7k8enXQ9cIzfkrMmLTZjStwGwSVN
 pzxi60Sb7F4SK0G9Qek6g6xrkUy7Ljhao3NmcYZEMT8E9e0t58gJ
X-Google-Smtp-Source: AGHT+IF1F+OyHsdTELJZLyYAFPtz2VONPLp9UOQatbIkcRLeJsYn881G4WCDN/TY8thO8SQxHsfkGw==
X-Received: by 2002:a17:903:41c4:b0:1f3:dfe:3373 with SMTP id
 d9443c01a7336-1f6192f23e0mr15996235ad.7.1717057958511; 
 Thu, 30 May 2024 01:32:38 -0700 (PDT)
Received: from localhost ([1.146.118.54]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f4befa89dbsm52878425ad.275.2024.05.30.01.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 01:32:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 18:32:32 +1000
Message-Id: <D1MU8TS7UZ4U.2R3WBGRCIANZD@gmail.com>
Cc: <danielhb413@gmail.com>, <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] cpu-common.c: export cpu_get_free_index to be
 reused later
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240523072614.256172-1-harshpb@linux.ibm.com>
 <20240523072614.256172-3-harshpb@linux.ibm.com>
In-Reply-To: <20240523072614.256172-3-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu May 23, 2024 at 5:26 PM AEST, Harsh Prateek Bora wrote:
> This helper provides an easy way to identify the next available free cpu
> index which can be used for vcpu creation. Until now, this is being
> called at a very later stage and there is a need to be able to call it
> earlier (for now, with ppc64) hence the need to export.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/exec/cpu-common.h | 2 ++
>  cpu-common.c              | 7 ++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 6d5318895a..0386f1ab29 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -29,6 +29,8 @@ void cpu_list_lock(void);
>  void cpu_list_unlock(void);
>  unsigned int cpu_list_generation_id_get(void);
> =20
> +int cpu_get_free_index(void);
> +
>  void tcg_iommu_init_notifier_list(CPUState *cpu);
>  void tcg_iommu_free_notifier_list(CPUState *cpu);
> =20
> diff --git a/cpu-common.c b/cpu-common.c
> index ce78273af5..82bd1b432d 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -57,14 +57,12 @@ void cpu_list_unlock(void)
>      qemu_mutex_unlock(&qemu_cpu_list_lock);
>  }
> =20
> -static bool cpu_index_auto_assigned;
> =20
> -static int cpu_get_free_index(void)
> +int cpu_get_free_index(void)
>  {
>      CPUState *some_cpu;
>      int max_cpu_index =3D 0;
> =20
> -    cpu_index_auto_assigned =3D true;
>      CPU_FOREACH(some_cpu) {
>          if (some_cpu->cpu_index >=3D max_cpu_index) {
>              max_cpu_index =3D some_cpu->cpu_index + 1;
> @@ -83,8 +81,11 @@ unsigned int cpu_list_generation_id_get(void)
> =20
>  void cpu_list_add(CPUState *cpu)
>  {
> +    static bool cpu_index_auto_assigned;
> +
>      QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
>      if (cpu->cpu_index =3D=3D UNASSIGNED_CPU_INDEX) {
> +        cpu_index_auto_assigned =3D true;
>          cpu->cpu_index =3D cpu_get_free_index();
>          assert(cpu->cpu_index !=3D UNASSIGNED_CPU_INDEX);
>      } else {


