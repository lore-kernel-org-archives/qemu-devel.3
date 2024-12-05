Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC09E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJHo-0007RY-7H; Thu, 05 Dec 2024 16:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1tJFSM-00007q-Nt; Thu, 05 Dec 2024 12:16:12 -0500
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1tJFSK-0003EC-MN; Thu, 05 Dec 2024 12:16:02 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MlfGs-1u1gpG232g-00f1Ar; Thu, 05 Dec 2024 18:15:52 +0100
Message-ID: <fd654e78-9995-4eb2-bbe5-573563cf34f7@vivier.eu>
Date: Thu, 5 Dec 2024 18:15:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,64} part of the same
 family
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv <qemu-riscv@nongnu.org>,
 David Abdurachmanov <davidlt@rivosinc.com>, Mark Corbin <mark@dibsco.co.uk>
References: <20241203094702.124748-1-abologna@redhat.com>
 <cb079b65-e5fc-4667-aa63-9ff347666b6e@linaro.org>
 <Z07a_kYh4duwWKWw@redhat.com>
 <CAFEAcA8BAW4=Yk5q0CgQNL4UZpUJXiwRV6VD-52_Rw0SN=E1Cg@mail.gmail.com>
 <dc1b450a-f250-4b84-80bd-6f14888ce327@linaro.org>
 <Z1AsKNcbY2I46Tx1@redhat.com>
Content-Language: fr, en-GB
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <Z1AsKNcbY2I46Tx1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lrDjBRG04McZbtJyaYDiyXmM1886hXd/e46G7uklDurelVovQdk
 9QrCr1dwXVoj2wBH7FwJ8ho5GStWcY7YB3j7AOll4pv6IrGPY1y7pwibHDN5nlp2eNGkfQ+
 cIkZa6RPIAKUu4dtrIgrRUmUFv4sEgpaxQ8j8wG8lI7rymvUYefhtg1SA4emTRBk5+mE8WL
 R0Qcie2MEHN9qXxdxdgTg==
UI-OutboundReport: notjunk:1;M01:P0:kE7V9Gl2Yv8=;IEEXSAzLj8OAZdA1ke9fN8pVRfy
 CDdZlGMZKpcN7m75ef4lLGmOyikAevke2nXNv4ChTlc1WttRMx8OBzP9dbE8RtQvqm+0G13ys
 LqTE5oYkKdk83o14d/aAZI/gbse50/wFjKeb08ABMwx327juUfMJe8kjmvE+eyuKSkjKPMoDB
 Bxdnab+StGf21+0CgW8x8jj4qjZjvNhNLqzxr09Ja9b6dOLTZXQHlLLyw+hvhfTNZZWSRNrHX
 qof/om21GaHQ07N+ZXswSMjeIpXUqkObKXCdcwWEd5gTLQ0tZdXv61uUqcT/ckyhC7ZJsfCw0
 UzXaTyMo1PJbB0Fd914QefyZJx0TjvMwBSJ0Vdpp53OSXQUKvp23A9xoEhwjaudZEDI4F8CXJ
 aFt0splLcZDF3IfXL8/foIRN2dbng1JgHFfhim8eYM2+hr9/0slQNDEhcHFLruCwqTFk9/Pac
 3cqKf9NtyVR+eGSTQzIf+Ig/QQK1RgVOCzLIHS0CMLINIzXM1lMoNWC7ErQ0P33DF7GL9sbKc
 SM84cMsx8rc3tzNQaRnjcre93DqQrysCk/zYVXGZZSrdf2G/kBmGkiDn8LggO21UR21w6r4uH
 yHtY4sc130gH7DUY9DpTw3mqT1ikccUR5DJiwz8/xtxzGfKy4hpNuYE3/H/erHEfDQonrqmFQ
 LMl+3N2gdVyuvoB7tDEaAG74JpQo8nAl8+jGCYjV/QU4t6Bhyg3cviLgU1ttFDgiyl2ldZGks
 202uXzb88PRZmSsAcyLb+mYmxgkJqO4+FuTlI9tC+dnZ1nHBSVQ4P++leXhE1DtUXwyqmVYeM
 J/fYS4kLEoeRN+zul6G8SwKsV9lrYcY3avfe8NlUMSy+Dri8A58EDC/CpXm2vfOuJwiMvRpJa
 sTWaA1V1Jn3TvqsVbOXW846nexADnNdJJBSo6YCDzHYn4v4C0iZCW+IVb07JDH42iY794kpz+
 rKelrrHyVuLqgnzTJ5wdWed0IqhBDmsaPJa7gjV/DyEuq/K6CdLTa9rxVOF6ALqbsuktGt9GC
 /oZfaUKkx5qA4GE0jv8Vgwg3qW0GdbiMCS5KnAZ
Received-SPF: pass client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 05 Dec 2024 16:21:21 -0500
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

Le 04/12/2024 à 11:17, Daniel P. Berrangé a écrit :
> On Tue, Dec 03, 2024 at 07:57:14AM -0600, Richard Henderson wrote:
>> On 12/3/24 04:35, Peter Maydell wrote:
>>> On Tue, 3 Dec 2024 at 10:19, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>> Separatley this from patch, we should also consider whether
>>>> it is time to do the same for aarch64/arm7.
>>>>
>>>> If I look at this page:
>>>>
>>>>     https://gpages.juszkiewicz.com.pl/arm-socs-table/arm-socs.html
>>>>
>>>> and sort by 'announced' to see msot recent CPUs first, then
>>>> almost all of them have "NO" in the "aarch32 support" column.
>>>>
>>>> IOW, on modern aarch64 CPUs, qemu-arm is the only viable way
>>>> to run 32-bit usermode binaries AFAICT, and suggests we ought
>>>> to be creating a binfmt rule for that on aarch64 hosts.
>>>
>>> What happens if you have a host CPU that *does* support 32-bit
>>> natively and you also register the binfmt rule? Does the
>>> host kernel prefer to execute natively or does it invoke
>>> QEMU? I don't think we want to roll out something that
>>> silently downgrades native execution to emulation...
>>
>> The registered rule applies and the kernel invokes qemu.
> 
> This is all quiet difficult from a distro POV, but not QEMU's fault.
> 
> We want to install the binfmt rules in a way that we "do the right thing"
> regardless of hardware out of the box.
> 
> The systemd logic for loading binfmt rules is unconditional, loading
> everything from /usr/lib/binfmt.d, but we need a way to make things
> conditional on the lack of support for aarch32 on the currently running
> platform.

Now, there is another alternative: binfmt_misc is now part of user namespace, so you can define a 
binfmt rule for a given namespace:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=21ca59b365c091d583f36ac753eaa8baf947be6f

I have added a new parameter to unshare to help to run a new namespace with binfmt_misc:

https://github.com/util-linux/util-linux/commit/9d55de0d0d5c6298b38b58c3f4dc876c56213f85

Thanks,
Laurent

