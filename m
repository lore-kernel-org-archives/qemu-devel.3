Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A2FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfpf-0004k7-66; Tue, 16 Jul 2024 06:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTfpe-0004jc-77
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:54:54 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTfpc-0004nP-9d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:54:53 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a79a7d1a0dbso424426366b.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721127290; x=1721732090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g//jswY5HmxZdb9u+T4RFD/62oVweaQnEh2WIohGP/I=;
 b=dAacX0sQ8ZfB3gpSSZ9DVL/rgFrYz7eMeo+KFKip1c0pxFZpsFvpj+AFK2bV725WJR
 RTD0rqUe12xiLDqMVpo1f8bwN9eJ7GebkuiJ2HYk5goFLFYIBbeWPuvfkwmJ0zhFM1O/
 8q5AEJYJ2LMlRkRfIar8rZki5ai5G78unQzAKXbxnFSynqXPNF6zUIPuMHNXc3QVr+H6
 c6A80vOrlSdwJGEyj60cIz7e9uBDHgQjcgVfSxzXGWJkpxWFB3Mf60yQb5IRZmxgtGzl
 1U+eI0WgRa7ZDmauKEMIwPYe8+rsUYsCoSNqSlSLC1QeZ+/Vl0j8jzy8uf0/shw3HoMF
 E7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721127290; x=1721732090;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g//jswY5HmxZdb9u+T4RFD/62oVweaQnEh2WIohGP/I=;
 b=HU2UBrDHd9gvWHXlpy322Xb+kvyG0nH5SyqXBZp2uEQmQnAe7UfVTOmai/RkKSsTTt
 PNRToh3JR4wYdq97GWtqYp3iE39MWknoAbampDQ6cVZukX1I29SRPg0X/+YQjJLU464s
 YFp4bYdnQO9bl6V5eJVd+YHd3dKaDXYGwnAvKYFFBMjrCMn9N7VoScwTeh/LqbN5pbln
 dsnf/IoQzeZNbKVymUKFoDgll4cGIvCg3tJcKYkIbJ0oRwzYObHVaecHJ620AswOicNy
 WawUTHy1HfTH3yDi2w2g+9JW+8uzN7/zCsqxNx9brFitCQ/nklXauAY1RQ+6AWRym6Fy
 JOzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFi6YyNf62FKnjYtrynSLdTi3UhLKvKn6dbunTK0iXkTmneuXkk7B+ma6UduMQULj/d4cYgJkj8Q8DVDLNjxyxHltRTe8=
X-Gm-Message-State: AOJu0YyY1Vt1jsyIYSO748YI1hjZ3nErYaX1aQZHMfppM+0otqRZ2Uut
 vlg1eq9zd6Espdf0eU3XCAoh+QN5+C+xo5Sfph3OyJIa9Yd0VFHjUPfDxtDNdif4//GYOI7dQCg
 J
X-Google-Smtp-Source: AGHT+IGnjOycpKj+mtr6vV9ILHL+45RhTDHSc6a7qSasJ5h64fQp7ddBe0wlEHoE7XsOwlhxX+wE3w==
X-Received: by 2002:a17:907:3381:b0:a77:c525:5c70 with SMTP id
 a640c23a62f3a-a79ea46d683mr127859866b.32.1721127289220; 
 Tue, 16 Jul 2024 03:54:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5d1a73sm298284566b.87.2024.07.16.03.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 03:54:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94C085F7A0;
 Tue, 16 Jul 2024 11:54:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] target/arm: Free GDB command data
In-Reply-To: <CAFEAcA9_x1BUnip+cB0kKqaUSrLY6hiubCjQ9D4-pSXM1ytVJA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 16 Jul 2024 11:41:31 +0100")
References: <20240714-arm-v1-1-c045bad45e48@daynix.com>
 <CAFEAcA9_x1BUnip+cB0kKqaUSrLY6hiubCjQ9D4-pSXM1ytVJA@mail.gmail.com>
Date: Tue, 16 Jul 2024 11:54:47 +0100
Message-ID: <87y161haiw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sun, 14 Jul 2024 at 11:43, Akihiko Odaki <akihiko.odaki@daynix.com> wr=
ote:
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>  target/arm/gdbstub.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
>> index c3a9b5eb1ed2..03f77362efc1 100644
>> --- a/target/arm/gdbstub.c
>> +++ b/target/arm/gdbstub.c
>> @@ -477,11 +477,11 @@ static GDBFeature *arm_gen_dynamic_m_secextreg_fea=
ture(CPUState *cs,
>>
>>  void arm_cpu_register_gdb_commands(ARMCPU *cpu)
>>  {
>> -    GArray *query_table =3D
>> +    g_autoptr(GArray) query_table =3D
>>          g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
>> -    GArray *set_table =3D
>> +    g_autoptr(GArray) set_table =3D
>>          g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
>> -    GString *qsupported_features =3D g_string_new(NULL);
>> +    g_autoptr(GString) qsupported_features =3D g_string_new(NULL);
>>
>>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>>      #ifdef TARGET_AARCH64
>> @@ -495,6 +495,7 @@ void arm_cpu_register_gdb_commands(ARMCPU *cpu)
>>          gdb_extend_query_table(&g_array_index(query_table,
>>                                                GdbCmdParseEntry, 0),
>>                                                query_table->len);
>> +        g_array_free(g_steal_pointer(&query_table), FALSE);
>>      }
>>
>>      /* Set arch-specific handlers for 'Q' commands. */
>> @@ -502,11 +503,13 @@ void arm_cpu_register_gdb_commands(ARMCPU *cpu)
>>          gdb_extend_set_table(&g_array_index(set_table,
>>                               GdbCmdParseEntry, 0),
>>                               set_table->len);
>> +        g_array_free(g_steal_pointer(&set_table), FALSE);
>>      }
>>
>>      /* Set arch-specific qSupported feature. */
>>      if (qsupported_features->len) {
>>          gdb_extend_qsupported_features(qsupported_features->str);
>> +        g_string_free(g_steal_pointer(&qsupported_features), FALSE);
>>      }
>>  }
>
> I don't think this is the right approach to this leak (which
> Coverity also complained about):
>
> https://lore.kernel.org/qemu-devel/CAFEAcA8YJwWtQxdOe2wmH7i0jvjU=3DUV92oe=
B6vUzT1GrQhRsTQ@mail.gmail.com/
>
> I think the underlying problem is that the gdb_extend_query_table
> and gdb_extend_set_table functions have a weird API where they
> retain pointers to a chunk of the contents of the GArray but
> they don't get passed the actual GArray. My take is that it
> would be better to make the API to those functions more natural
> (either "take the whole GArray and take ownership of it" or
> else "copy the info they need and the caller retains ownership
> of both the GArray and its contents").
>
> Also, there is a second leak here if you have more than one
> CPU -- when the second CPU calls gdb_extend_query_table() etc,
> the function will leak the first CPU's data. Having the function
> API be clearly either "always takes ownership" or "never takes
> ownership" would make it easier to fix this leak too.

I'm working on cleaning this API up to make it easier to use. I'll send
a patch once its tested.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

