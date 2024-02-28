Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D896CC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 22:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfS6o-0005rA-NW; Wed, 28 Feb 2024 17:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfS6h-0005px-RZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 17:08:56 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfS6f-000356-BT
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 17:08:54 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33de6da5565so166707f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 14:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709158129; x=1709762929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lvmy+rOcg9VVqsqPTj8iy9BHcyK5TGpuqT86Iuj6Lbk=;
 b=x6TESe4GZNAQwGD2r5BCoaqACcnJTGdga/2flu4ZcovTJPnxg2rHKZW5RDyILSahw9
 rtwP0g5aVmt8X/l/avrROZJOP95FqkHhSpceFo617YA9S0vuI4otqC1KSkE24wqRO2dM
 N3wNwIiCrRujDf02IX5d1Ezs6o0o9rRMf0irjcTpPF94iBdTGeHligF6mtI7/UsRP0Vm
 qSd1Qk2bm/zqtZPvr5CdXvIu/GOzpvARMxG3l8jEJK2c0byksKDBruVFAp6o+edLRLZL
 KGHs3bbllCRmm7PwtOSmt4BoMqVwcGt7w0tSLCDJZ2pCRsAHh7NaM0O1WZqQTwa/oR/H
 MIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709158129; x=1709762929;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lvmy+rOcg9VVqsqPTj8iy9BHcyK5TGpuqT86Iuj6Lbk=;
 b=QzEe/rprLfKfeCwfJ4MHqWhzeieh9V8YcshD28dm3abo43SuSUpI6nSYeYBSpkB8/z
 RSeupNPWJ7fYk1zxlMaHzWWemqnxRjX25Z0MESN0AVyIdm7/4V/ualKZ2uHLAGcru1Pf
 R7A6VMRDVFQvCvEUjvKSejE7njv9bqiZ8R4hoIUekCCL/Nroh2zSEKllkfBCysnncfCx
 R9Jba4ApXt0W8L/9fAMwNKtxKjd9EpHK4Bwx11NHXGXe3CjgzEL9uKNw/5xD4ODHXbNZ
 RTXzaBqcbYTu/pryH2I3Qh1wqSUVmxi3hI4AA2uKM4x9qdQCLWpYsK7BWViwKd5IE2TU
 SodQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZO6m3DkbQsLUaxbMszsJKihUvCKfG0anQpjGTFYpxwzxaV63xTnlbKEmn++h7VPYh63aXQyvMfCJR+1JeJ+WmGlpO0dQ=
X-Gm-Message-State: AOJu0YyUo+yH86GZbFc0I/UEaj2NH6lwuAkw24SZrImy2+qiGRh9W+A5
 csE7+51vDYGuyUOlwgL835f9pBQqko/352sgrggLEoY1PGIEecJFAmEo+GUag1k=
X-Google-Smtp-Source: AGHT+IFFMWGtboMHbBb1Do3OceH/7YJNHNV92OwJyONqkPhpHpPeo2gta6rrYM7x8L5KkL3DoLHswQ==
X-Received: by 2002:a5d:5246:0:b0:33d:50cd:4672 with SMTP id
 k6-20020a5d5246000000b0033d50cd4672mr115117wrc.21.1709158129591; 
 Wed, 28 Feb 2024 14:08:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bo14-20020a056000068e00b0033d6bc17d0esm16530092wrb.74.2024.02.28.14.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 14:08:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D25605F863;
 Wed, 28 Feb 2024 22:08:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Luc Michel <luc.michel@amd.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 <qemu-devel@nongnu.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 06/12] tests/plugin/mem: migrate to new per_vcpu API
In-Reply-To: <Zd2sxjxegajy7ZbF@luc-work-vm> (Luc Michel's message of "Tue, 27
 Feb 2024 10:35:02 +0100")
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-7-pierrick.bouvier@linaro.org>
 <Zd2sxjxegajy7ZbF@luc-work-vm>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Wed, 28 Feb 2024 22:08:47 +0000
Message-ID: <875xy8b5sg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Luc Michel <luc.michel@amd.com> writes:

> Hi Pierrick,
>
> On 13:14 Mon 26 Feb     , Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  tests/plugin/mem.c | 40 +++++++++++++++++++++++++---------------
>>  1 file changed, 25 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
>> index 44e91065ba7..d4729f5e015 100644
>> --- a/tests/plugin/mem.c
>> +++ b/tests/plugin/mem.c
>> @@ -16,9 +16,14 @@
>>=20
>>  QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>>=20
>> -static uint64_t inline_mem_count;
>> -static uint64_t cb_mem_count;
>> -static uint64_t io_count;
>> +typedef struct {
>> +    uint64_t mem_count;
>> +    uint64_t io_count;
>> +} CPUCount;
>> +
>> +static struct qemu_plugin_scoreboard *counts;
>> +static qemu_plugin_u64 mem_count;
>> +static qemu_plugin_u64 io_count;
>
> I see that you merged inline and callback counts into the same variable.
>
> I wonder... For this test don't you want to keep a plain uint64_t for
> callback counts? I have the feeling that this test was made so one can
> make sure inline and callback counts match.

Indeed the problem now is double counting:

  =E2=9E=9C  ./qemu-hppa -plugin ./tests/plugin/libmem.so,inline=3Dtrue -d =
plugin  ./tests/tcg/hppa-linux-user/sha512
  1..10
  ok 1 - do_test(&tests[i])
  ok 2 - do_test(&tests[i])
  ok 3 - do_test(&tests[i])
  ok 4 - do_test(&tests[i])
  ok 5 - do_test(&tests[i])
  ok 6 - do_test(&tests[i])
  ok 7 - do_test(&tests[i])
  ok 8 - do_test(&tests[i])
  ok 9 - do_test(&tests[i])
  ok 10 - do_test(&tests[i])
  mem accesses: 262917
  =F0=9F=95=9922:06:57 alex@draig:qemu.git/builds/all  on =EE=82=A0 plugins=
/next [$?]=20
  =E2=9E=9C  ./qemu-hppa -plugin ./tests/plugin/libmem.so,inline=3Dtrue,cal=
lback=3Dtrue -d plugin  ./tests/tcg/hppa-linux-user/sha512
  1..10
  ok 1 - do_test(&tests[i])
  ok 2 - do_test(&tests[i])
  ok 3 - do_test(&tests[i])
  ok 4 - do_test(&tests[i])
  ok 5 - do_test(&tests[i])
  ok 6 - do_test(&tests[i])
  ok 7 - do_test(&tests[i])
  ok 8 - do_test(&tests[i])
  ok 9 - do_test(&tests[i])
  ok 10 - do_test(&tests[i])
  mem accesses: 525834

although perhaps it would just be simpler for the plugin to only accept
one or the other method.

>
> Luc
>
>>  static bool do_inline, do_callback;
>>  static bool do_haddr;
>>  static enum qemu_plugin_mem_rw rw =3D QEMU_PLUGIN_MEM_RW;
>> @@ -27,16 +32,16 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>>  {
>>      g_autoptr(GString) out =3D g_string_new("");
>>=20
>> -    if (do_inline) {
>> -        g_string_printf(out, "inline mem accesses: %" PRIu64 "\n", inli=
ne_mem_count);
>> -    }
>> -    if (do_callback) {
>> -        g_string_append_printf(out, "callback mem accesses: %" PRIu64 "=
\n", cb_mem_count);
>> +    if (do_inline || do_callback) {
>> +        g_string_printf(out, "mem accesses: %" PRIu64 "\n",
>> +                        qemu_plugin_u64_sum(mem_count));
>>      }
>>      if (do_haddr) {
>> -        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_co=
unt);
>> +        g_string_append_printf(out, "io accesses: %" PRIu64 "\n",
>> +                               qemu_plugin_u64_sum(io_count));
>>      }
>>      qemu_plugin_outs(out->str);
>> +    qemu_plugin_scoreboard_free(counts);
>>  }
>>=20
>>  static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t memi=
nfo,
>> @@ -46,12 +51,12 @@ static void vcpu_mem(unsigned int cpu_index, qemu_pl=
ugin_meminfo_t meminfo,
>>          struct qemu_plugin_hwaddr *hwaddr;
>>          hwaddr =3D qemu_plugin_get_hwaddr(meminfo, vaddr);
>>          if (qemu_plugin_hwaddr_is_io(hwaddr)) {
>> -            io_count++;
>> +            qemu_plugin_u64_add(io_count, cpu_index, 1);
>>          } else {
>> -            cb_mem_count++;
>> +            qemu_plugin_u64_add(mem_count, cpu_index, 1);
>>          }
>>      } else {
>> -        cb_mem_count++;
>> +        qemu_plugin_u64_add(mem_count, cpu_index, 1);
>>      }
>>  }
>>=20
>> @@ -64,9 +69,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct=
 qemu_plugin_tb *tb)
>>          struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i=
);
>>=20
>>          if (do_inline) {
>> -            qemu_plugin_register_vcpu_mem_inline(insn, rw,
>> -                                                 QEMU_PLUGIN_INLINE_ADD=
_U64,
>> -                                                 &inline_mem_count, 1);
>> +            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
>> +                insn, rw,
>> +                QEMU_PLUGIN_INLINE_ADD_U64,
>> +                mem_count, 1);
>>          }
>>          if (do_callback) {
>>              qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
>> @@ -117,6 +123,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plu=
gin_id_t id,
>>          }
>>      }
>>=20
>> +    counts =3D qemu_plugin_scoreboard_new(sizeof(CPUCount));
>> +    mem_count =3D qemu_plugin_scoreboard_u64_in_struct(
>> +        counts, CPUCount, mem_count);
>> +    io_count =3D qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount,=
 io_count);
>>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>      qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>      return 0;
>> --
>> 2.43.0
>>=20
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

