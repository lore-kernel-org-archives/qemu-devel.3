Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDEEC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnUc-0002Sp-4N; Thu, 13 Mar 2025 14:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsnUU-0002Pr-2j
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:41:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsnUR-0003ub-Eo
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:41:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso9294995e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741891266; x=1742496066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vk1GjD4OgQICCfJ2bhmcMEs2ToAk6wLcE4zy4qVhYBw=;
 b=cux+zAh5CuDNvq2HYHZDzIdY44EnIo43ukZT+t3JcF8bE6C3A9pc3r2EslXe8L+vkJ
 QFCfinHIwO66d7jEAmWyeWGda+rcB0gh5oXeTxklzN4pfiPPQjH7GFh48BMmNiswPXVN
 M/OT91XXS0rw7ANEZO8s6YC6RttEeadqPIq4/dcMW7/biHpZwo69saqjCL4ql3WVZvuv
 v7pmNFHVJhq0rITaWUZIraByWP54c/cJeYAAdWoAFBPMVyWHSZvYe3o0cWZP8lq/6eOG
 zYgmqjs5N2iXkwH61LtO/ft+WCXGueL01ytzyI1a4I9GX0s71cPYlFXfyliA44/50n6/
 8EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741891266; x=1742496066;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vk1GjD4OgQICCfJ2bhmcMEs2ToAk6wLcE4zy4qVhYBw=;
 b=ZiTPt5UxQTW9eP3Ox+NTvkwA3/qCYMpvl7189qpjEdW5PcvnGB0ryJ1SPfou6XTlKC
 wq/TqvCbaFkFI3dj4DmrEeJ5bd+Qqaz8/FhHClWE8/6Wa6WBUGpKmv4nZetsqdDlukRD
 fspx4ehbjIrgKJM47aZTqrtQ6J4aDVJRUK7uBLRxpxTlwi3iMYxtdC4gouAOQ32v0Qoa
 mGj6kVQtL7p5CCkUHLDbbLJQC0qWWJiisS8diNxdOf6uOM/ijkRfMrBccRmU/1m1k1j6
 qcxI9fVzVfPJM+XQSO/l8gy5mqpnfsyKt/P6rYV4JJbwnvAn+mBaEu4PdQT6KiJajM/x
 Cz7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfbvfbHQQ4M8lDtKE4CuqG3GtPy9kLCSIVuJ2kOH6S5JyHYGd6pkCoAYIMMDBpliFoew6gVYZ7eSvD@nongnu.org
X-Gm-Message-State: AOJu0YwRTrDlbR8jeYX2POXHE51+btCNOiq151pCuVyhGcm3igB8CkrP
 RgYz0kmubBJkgLoiEACJ6w6Z4wQ8dDVOKypWMjhBYj3dPvBPEjfyfOPmeBEKnoY=
X-Gm-Gg: ASbGncvUaK0AqgTWoh2LFVznYveHqwlyJycwy8XkLK9F+yCTL+pTBryxyuDwD/pzckn
 6MQhW6sacTdfyV4JjTERdOkeJawFpeZpcaG0LAwzWnOc/d1pAbUVh7vILyPsNijC470Qdzh1Lpp
 +SJv8KOO2ty+35iF1xZce+TcZHA1JE/k1h2AmaDXEDoIwYpE3yGv5vEJSQSb1YMVDL5AnFILjC4
 34VvUGrLNW2PTa5xkuPmYlFVGWZR/hCP0dvChXmSFVcOp9GpowOqscd9r5NzhHlU/QMLWnczfZO
 o+/LCdQ+t/ZoP68rbrhr5FXS3g6s15g/dMYVh2YD+c1BpUo=
X-Google-Smtp-Source: AGHT+IEPBnbzjzz3WQGs40fdxkmWE1VAoo6119Eh7a5TSWtRS5ma81BP4uHc+q4fjqhdm0GDunpCBA==
X-Received: by 2002:a05:600c:4690:b0:43c:fe85:e4a0 with SMTP id
 5b1f17b1804b1-43d1d89953dmr7969815e9.7.1741891265621; 
 Thu, 13 Mar 2025 11:41:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d031d2c26sm58716845e9.0.2025.03.13.11.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 11:41:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 263725F8C7;
 Thu, 13 Mar 2025 18:41:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Saanjh Sengupta <saanjhsengupta@outlook.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  "amir.gonnen@neuroblade.ai"
 <amir.gonnen@neuroblade.ai>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "aabhashswain25@gmail.com"
 <aabhashswain25@gmail.com>,  "aniantre@gmail.com" <aniantre@gmail.com>
Subject: Re: Building QEMU as a Shared Library
In-Reply-To: <SL2P216MB13806B5994D2A1F4DC5E5685CCD32@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
 (Saanjh Sengupta's message of "Thu, 13 Mar 2025 11:34:35 +0000")
References: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
 <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
 <30a35e73-2f72-4e1c-b38f-c744b6884706@linaro.org>
 <SE1SPRMB0015BDAF043E9103B24B9973CCC82@SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM>
 <67a10cba-5bb8-4dda-a7c7-c7a3637bb1b3@linaro.org>
 <SL2P216MB138053F139E1B688D2BBA201CCD12@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
 <2f1078d7-31bf-4940-aa43-30a45f7a07a0@linaro.org>
 <SL2P216MB1380316B32539524D1CCD831CCD02@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
 <ab0a0e8d-9c26-4225-942b-9d6996abfb8f@linaro.org>
 <SL2P216MB13806B5994D2A1F4DC5E5685CCD32@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 13 Mar 2025 18:41:04 +0000
Message-ID: <87bju44vun.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Saanjh Sengupta <saanjhsengupta@outlook.com> writes:

> Hi,
>
> What we are trying to achieve is that the QEMU should run for a particula=
r number of instructions, let's say for example
> 10000 instructions and then pause it's emulation. After a resume trigger =
is received to the QEMU it must resume it's
> emulation and start the instruction count from 10001 (which basically
> means that the context should be saved).

I think you want to run under icount and you will need to modify the
trigger plugin. Under icount we run each vCPU in turn, so if the plugin
pauses the vCPU will de-facto be paused.

You would have to implement some sort of control interface in the
plugin. Or you could add an API to trigger the gdbstub. I think I had
that on a patch series at one point.

>
> In the previous mail when you mentioned g_usleep, I believe this shall no=
t work (as per our use-case) since it will reset the
> instruction count to 0 (as per what you mentioned).=20
>
> To achieve the use-case, do you have any leads/suggestions ?=20
>
> Regards
> Saanjh Sengupta=20
>
> -------------------------------------------------------------------------=
------------------------------------------------
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Sent: Wednesday, March 12, 2025 11:50:23 am
> To: Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-Daud=
=C3=A9 <philmd@linaro.org>; Paolo Bonzini
> <pbonzini@redhat.com>; Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
> Cc: amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-devel@non=
gnu.org <qemu-devel@nongnu.org>; Alex
> Benn=C3=A9e <alex.bennee@linaro.org>
> Subject: Re: Building QEMU as a Shared Library
>
> On 3/11/25 21:31, Saanjh Sengupta wrote:
>>=20
>>=20
>> Hi,
>>=20
>> Thank you for the clarification. Regarding the last time
>> /"Stoptrigger might be a better fit for what you want to do, and instead=
=20
>> of exiting, you want to resume emulation after N insn. The function=20
>> qemu_clock_advance_virtual_time() can only be used to move the time=20
>> forward, and you can not stop the "virtual time" by design."/
>> /
>> /
>> I did not quite understand this. Even if I have to modify the=20
>> stopTrigger plugin, I would want it to pause rather than exiting.
>> For example: It gets 10000 instructions executed after that it should=20
>> pause and after some time it should then resume again execute till 20000=
=20
>> instructions (because previously it executed till 10000 and then it must=
=20
>> execute till 20000). How do I do this? How do I state the code to pause=
=20
>> the qemu's emulation after 10000 instructions?
>>=20
>
> By using g_usleep to pause the current cpu.
> As well, it's needed to reset insn_count to 0 to count instructions again.
>
> With this command line:
> ./build/qemu-system-x86_64 -plugin=20
> ./build/contrib/plugins/libstoptrigger.so,icount=3D1000 -d plugin
>
> And with those changes to stoptrigger:
>
> diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
> index b3a6ed66a7b..77fd413cef1 100644
> --- a/contrib/plugins/stoptrigger.c
> +++ b/contrib/plugins/stoptrigger.c
> @@ -41,11 +41,12 @@ typedef struct {
>       int exit_code;
>   } ExitInfo;
>
> -static void exit_emulation(int return_code, char *message)
> +static void pause_emulation(int return_code, char *message)
>   {
>       qemu_plugin_outs(message);
>       g_free(message);
> -    exit(return_code);
> +    /* exit(return_code); */
> +    g_usleep(1 * G_USEC_PER_SEC);
>   }
>
>   static void exit_icount_reached(unsigned int cpu_index, void *udata)
> @@ -53,7 +54,9 @@ static void exit_icount_reached(unsigned int=20
> cpu_index, void *udata)
>       uint64_t insn_vaddr =3D qemu_plugin_u64_get(current_pc, cpu_index);
>       char *msg =3D g_strdup_printf("icount reached at 0x%" PRIx64 ",=20
> exiting\n",
>                                   insn_vaddr);
> -    exit_emulation(icount_exit_code, msg);
> +    pause_emulation(icount_exit_code, msg);
> +    /* reset instruction counter */
> +    qemu_plugin_u64_set(insn_count, cpu_index, 0);
>   }
>
>   static void exit_address_reached(unsigned int cpu_index, void *udata)
> @@ -61,7 +64,7 @@ static void exit_address_reached(unsigned int=20
> cpu_index, void *udata)
>       ExitInfo *ei =3D udata;
>       g_assert(ei);
>       char *msg =3D g_strdup_printf("0x%" PRIx64 " reached, exiting\n",=20
> ei->exit_addr);
> -    exit_emulation(ei->exit_code, msg);
> +    pause_emulation(ei->exit_code, msg);
>   }
>
>> Moreover, I tried an activity where I was utilising the QMP protocol to=
=20
>> control the virtual time (with respect to the IPS plugin). In that=20
>> context when the QMP stop is triggered, my virtual time does got freezed=
=20
>> until the resume is triggered. Does this mean I am able to manipulate=20
>> the virtual time of the QEMU?
>>=20
>
> I am not sure of how it works, but the plugin interface only allows to=20
> move time forward.
>
>>=20
>>=20
>> Regards
>> Saanjh Sengupta
>> ------------------------------------------------------------------------
>> *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> *Sent:* Wednesday, March 12, 2025 2:14:47 AM
>> *To:* Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-=20
>> Daud=C3=A9 <philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Mar=
c-=20
>> Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-=20
>> devel@nongnu.org <qemu-devel@nongnu.org>; Alex Benn=C3=A9e=20
>> <alex.bennee@linaro.org>
>> *Subject:* Re: Building QEMU as a Shared Library
>> On 3/11/25 02:50, Saanjh Sengupta wrote:
>>> Hi,
>>>=20
>>> I have a couple of questions:
>>>=20
>>>  1.
>>>     When I use the libstoptrigger.so: in that case the QEMU 's emulation
>>>     stops after executing the defined number of instructions. Post this,
>>>     the whole QEMU terminates. And while using the libips.so I am
>>>     assuming that the QEMU doesn't execute no more than the defined
>>>     instructions. Please correct me if I am wrong.
>>=20
>> That's correct for both plugins, with the additional note that libips
>> does this per second only.
>>=20
>>>  2.
>>>     In my case, I want the QEMU to start emulation for some time and
>>>     PAUSE it's emulation for some time; after it is Paused (it's virtual
>>>     time is also to be paused) and then let's say for after 'x' time
>>>     period it should resume it's virtual time.
>>>=20
>>=20
>> The virtual time variable in ips plugin is only related to this plugin,
>> and based on how many instructions have been executed, which is
>> different from what you want to achieve.
>>=20
>> Stoptrigger might be a better fit for what you want to do, and instead
>> of exiting, you want to resume emulation after N insn.
>> The function qemu_clock_advance_virtual_time() can only be used to move
>> the time forward, and you can not stop the "virtual time" by design.
>>=20
>>> image
>>>=20
>>>=20
>>> I have added this segment inside the update_system_time function inside=
=20
>>> the ipsPlugin.c. but once the instructions reach to the defined limit=20
>>> the virtual time does not seem to stop.
>>> Do you have any suggestions on that front?
>>>=20
>>>=20
>>> Regards
>>> Saanjh Sengupta
>>> ------------------------------------------------------------------------
>>> *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> *Sent:* Wednesday, March 5, 2025 5:20:38 AM
>>> *To:* Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-=20
>>> Daud=C3=A9 <philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Ma=
rc-=20
>>> Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-=20
>>> devel@nongnu.org <qemu-devel@nongnu.org>; Alex Benn=C3=A9e=20
>>> <alex.bennee@linaro.org>
>>> *Subject:* Re: Building QEMU as a Shared Library
>>> Hi Saanjh,
>>>=20
>>> depending what you are trying to achieve exactly, plugins can provide a
>>> solution. It's convenient and you can stay on top of QEMU upstream,
>>> without having to create a downstream fork.
>>>=20
>>> We already have plugins for stopping after a given number of
>>> instructions, or slow down execution of a VM:
>>>=20
>>> # stop after executing 1'000'000 instructions:
>>> $ ./build/qemu-system-x86_64 -plugin
>>> ./build/contrib/plugins/libstoptrigger,icount=3D1000000 -d plugin
>>>=20
>>> # execute no more than 1'000'000 instructions per second:
>>> $ ./build/qemu-system-x86_64 -plugin
>>> ./build/contrib/plugins/libips.so,ips=3D1000000 -d plugin
>>>=20
>>> You can see source code associated (./contrib/plugins/stoptrigger.c and
>>> ./contrib/plugins/ips.c), to implement something similar to what you
>>> want, but based on time.
>>> Would that satisfy your need?
>>>=20
>>> Regards,
>>> Pierrick
>>>=20
>>> On 3/3/25 21:53, Saanjh Sengupta wrote:
>>>>=20
>>>>=20
>>>> Hi,
>>>>=20
>>>> Thank you so much for your inputs. I was able to create the .so file o=
f=20
>>>> QEMU.
>>>>=20
>>>> Actually, what we are trying is to understand and explore possibilitie=
s=20
>>>> of Virtual Time Control in QEMU. In short, what I mean to say is an=20
>>>> approach via which I can tell QEMU to emulate for XYZ time when the I=
=20
>>>> give a trigger and then pause the emulation by itself after the XYZ ti=
me=20
>>>> is completed.
>>>>=20
>>>> On that front itself, do you have any inputs/ideas regarding the same?
>>>>=20
>>>>=20
>>>> Regards
>>>> Saanjh Sengupta
>>>> ----------------------------------------------------------------------=
--
>>>> *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> *Sent:* Tuesday, February 25, 2025 6:29:44 AM
>>>> *To:* Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>; Paolo Bonzini=20
>>>> <pbonzini@redhat.com>; Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat=
.com>
>>>> *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-=20
>>>> devel@nongnu.org <qemu-devel@nongnu.org>; Saanjh Sengupta=20
>>>> <saanjhsengupta@outlook.com>
>>>> *Subject:* Re: Building QEMU as a Shared Library
>>>> Hi Saanjh,
>>>>=20
>>>> here is a minimal patch that builds one shared library per target (arc=
h,
>>>> mode) where arch is cpu arch, and mode is system or user, and launch
>>>> system-aarch64 through a simple driver:
>>>>=20
>>>> https://github.com/pbo-linaro/qemu/commit/ <https://github.com/pbo-=20
>> linaro/qemu/commit/> <https://github.com/pbo-
>>> linaro/qemu/commit/>
>>>> fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f <https://github.com/pbo-linar=
o/
>>>> qemu/commit/fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f>
>>>>=20
>>>> With this, it could be possible to create a driver that can execute any
>>>> existing target. It's a sort of single binary for QEMU, but shared
>>>> objects are mandatory, and duplicates all the QEMU state. So there is =
no
>>>> real benefit compared to having different processes.
>>>>=20
>>>> In more, to be able to do concurrent emulations, there are much more
>>>> problems to be solved. QEMU state is correctly kept per target, but all
>>>> other libraries states are shared. There are various issues if you
>>>> launch two emulations at the same time in two threads:
>>>> - glib global context
>>>> - qemu calls exit in many places, which stops the whole process
>>>> - probably other things I didn't explore
>>>>=20
>>>> At this point, even though qemu targets can be built as shared objects,
>>>> I would recommend to use different processes, and implement some form =
on
>>>> IPC to synchronize all this.
>>>> Another possibility is to try to build machines without using the
>>>> existing main, but I'm not sure it's worth all the hassle.
>>>>=20
>>>> What are you trying to achieve?
>>>>=20
>>>> Regards,
>>>> Pierrick
>>>>=20
>>>> On 2/24/25 01:10, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> Cc'ing our meson experts
>>>>>=20
>>>>> On 22/2/25 14:36, Saanjh Sengupta wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I referred to your mailing chains on suggesting QEMU to be built as a
>>>>>> shared library.
>>>>>>
>>>>>> *Change meson.build to build QEMU as a shared library (with PIC enab=
led
>>>>>> for static libraries)*
>>>>>> *
>>>>>> *
>>>>>> Could you please suggest what exactly has to be enabled in the meson=
.build?
>>>>>>
>>>>>> I am confused on that front.
>>>>>>
>>>>>> Regards
>>>>>> Saanjh Sengupta
>>>>>=20
>>>>=20
>>>=20
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

