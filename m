Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFB7CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 09:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgEv-0003i2-Vl; Tue, 28 Oct 2025 05:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1vDgEs-0003eY-Er
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1vDgEh-00055d-PK
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761644604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vt6vZqmrlOlubNZccPKymZx5pO5hG9qanHZYn7cfvE=;
 b=Uud7e6fRBDbOjFlkiURz75NdSwqByzzPPdCesmDMq+oa3IATlzCsovduUt/1sB8bCF89fQ
 5vV5QFw45kj4thiElayZSxgasJuqIA2q1SdtfJp1V0XpJcFRU59tGXE+rajsduh5dqW1kI
 K/433yfcuH8hREB0ptKRCLzkiP1dI5Y=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-z1ADxPwOPUijaSPtkvYduQ-1; Tue, 28 Oct 2025 05:42:09 -0400
X-MC-Unique: z1ADxPwOPUijaSPtkvYduQ-1
X-Mimecast-MFC-AGG-ID: z1ADxPwOPUijaSPtkvYduQ_1761644529
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-54aa347b2e1so13344484e0c.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 02:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761644528; x=1762249328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vt6vZqmrlOlubNZccPKymZx5pO5hG9qanHZYn7cfvE=;
 b=UD9ggG7yrtWtjuZp3aGXj9+ckXcepFtUrWNwVoic9Cu3h/VT2a3JLwaIhTgWwdslk0
 0RblMdjANRew/6RncYCcJyObXJD9Hn6ibf+cwEHdZb6mY4EkKmqBB4FETPy9STGN1Djr
 uu/faHa/BXJZFwKF28BXcB+sSfR4BASItBjgevL14QSt7SvisBJFvYGzkvg3KYb89zix
 pRRCsNcUgupNXcz7h7014Fv2wztHb6P1r4vN5O4j+xL5fHsyYI2FKt910Pm0dL49jH4i
 ujrJIK6uORHHo1TDkDVwkE/kCZuOXxtutobXpuUFNHbLx7JJf4eAT9M3aaoYgUG/MJID
 PZ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXYcTmWZzhfUAL5EuthJbjderTtxhQzFrDuQWUOFe0iMHegsh6tnXedbQ9vwZVR03on+/H0EYbYQQB@nongnu.org
X-Gm-Message-State: AOJu0Yze1KLQXCm+PuRNKNuxtKPjvaxuJqfIczlpkiMc09QDg1MmslJa
 RpZE+3qsiWOBi9tPVATpYdCi7nFmKvpmo40jrnTzIpRB8qiAXGGniWRg57rAyG0REGlZWvQVAze
 Z2kcEu4UwAb0DzRIc8C3tKZv2Z6YU5i7k7JI6xJ9tts2sf2lm9e5omiiNYLJCNacG5YNy3OrRBY
 xBMEK6l1Mc1To1+GGEW6Az2AcWutJRWbA=
X-Gm-Gg: ASbGncvMOUuNL4aioRyppdoH/n6SbTC9sFI7PmlTu3lxD/ZarQ2iSW4qCEKTEC3cWLW
 myzssy+7LvJn8lRm0Ra7DwAm2Hcespq9UBGfTwm8Y27Lnp9nGtvyNYaWXU9y2Z/OXagcvBjUkW7
 6aGgKIOhL9rFMUndEs24j/kmEwYaaV5C9yJmT8K2vtgiyLXZ3V3j3jwfs=
X-Received: by 2002:a05:6122:1794:b0:54a:1ec7:ab0f with SMTP id
 71dfb90a1353d-55803519753mr935239e0c.16.1761644528711; 
 Tue, 28 Oct 2025 02:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+/R0/JQ2q0GQiFhxY/4UQxOID/OJymccVjZthmO9UAlidAZLWu/Sc/sknG0FDyFzXtSPra0TWfVZMd3ZioYg=
X-Received: by 2002:a05:6122:1794:b0:54a:1ec7:ab0f with SMTP id
 71dfb90a1353d-55803519753mr935236e0c.16.1761644528374; Tue, 28 Oct 2025
 02:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <d98deec4-c95a-434c-9ef4-d7a0fd41a42b@linaro.org>
 <CAJSP0QU9M1QEXjKBjHtq2NgHu0FUTC4rXMxB657BsdxGvcs1ew@mail.gmail.com>
In-Reply-To: <CAJSP0QU9M1QEXjKBjHtq2NgHu0FUTC4rXMxB657BsdxGvcs1ew@mail.gmail.com>
From: Camilla Conte <cconte@redhat.com>
Date: Tue, 28 Oct 2025 10:41:32 +0100
X-Gm-Features: AWmQ_bkSgmADoZLI_Q6eYcsr2XZWWkjHNo2Iind-1dP9wKSbt02FwadO-G7ZXIQ
Message-ID: <CACPOWh2o0q0usrKv9C3cR39p5OpwLzXnwzwJbqYRFs3n-w9bnA@mail.gmail.com>
Subject: Re: AWS CI Oddities
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cconte@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Stefan,

This can happen because the worker node is out of resources (likely
memory) for the running pods.
We can set a memory minimum for all pods, or we can set it per-job.

If there are some specific jobs that are memory-hungry, please set
KUBERNETES_MEMORY_REQUEST in the job variables.
https://docs.gitlab.com/runner/executors/kubernetes/#overwrite-container-re=
sources

Else, I can set a global default.

Camilla

On Thu, Oct 23, 2025 at 11:34=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> On Thu, Oct 23, 2025, 15:03 Richard Henderson <richard.henderson@linaro.o=
rg> wrote:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/11827686852#L1010
>>
>> ERROR: Job failed (system failure): pod
>> "gitlab-runner/runner-o82plkzob-project-11167699-concurrent-9-ther90lx" =
is disrupted:
>> reason "EvictionByEvictionAPI", message "Eviction API: evicting"
>>
>>
>> So.. if I'm guessing correctly, the job is doing fine, 28 minutes in to =
a 1 hour timeout,
>> when it gets kicked off the machine?
>>
>> This has happened a few times the the last week or two.  Is there any wa=
y to fix this?
>
>
> Hi Camilla,
> Any ideas?
>
> Stan


