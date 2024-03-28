Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EFDC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprQt-00012Y-PJ; Thu, 28 Mar 2024 11:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rprQr-000128-GC
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:12:45 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rprQp-0002hY-49
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iq5DgTFlMNQJcpk2hGIsTk92BrX+KrbqiuPwL2avd9M=; b=hOufGUhVBZRUEUF1NOeLteT15b
 OO+2wY9yTtOrceP+WYOjYhPErMXCX+hjb7DUZPVgAiWc4PE5CyuZRxUA6bd2DJnMe5CnBxs6BZWEg
 GCiATR7NLrS12izyRmECiHmpCVn3XLb4BB/sbisLD5H7w8zMF+lyCrk1o8X6jRxyqyxDaDUxDl6Cu
 tkC2hUBZdsa0QEU4r0MlaWdpTNrDXjX/RAvXsnB1OGoRY7d+rFzKHDTmQRX1SiiPRFrM1nBpwHcm0
 RIAEgQdCdYh0pMcEr4x9nREtvU6glIUlAqedoyF5Xymq3PphQMWVR88UWXAxfweHTOr3pqs3RiQLM
 E5p9enK490fEBPAe0bUAlmRv+i+gksTMGAXWc1DU9T3leR2lhBmucjUSVaZytxGBpKBmX55zuI6Ih
 Mo8LmjdOjjCuPq9djsCtxPygfuAMkRK2uYi15SObM+uKMuA+KgVVVmU91ptALouF2EHE15h6MSlaa
 gbaPHLRvsa1n+9oHZ1pLv87y6lmFrXFveSKmmEbiQX9WURXTJ7fClqc8sZQHzAICxlToeYocd+rA1
 0kL3M3P1t+fnNsc7Sd2lZ1QLV/q+bqV0I2XK2spQY95v5mIQnLEceTunOJeZ6Rltv4o4ywcs65OcC
 1i0nk5IKS/xn5AKzu48fIARiV2odPaxR0rYERnn08=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rprPp-0000ch-V2; Thu, 28 Mar 2024 15:11:46 +0000
Message-ID: <70006b4e-b2ae-4d74-be22-4dabf46e0217@ilande.co.uk>
Date: Thu, 28 Mar 2024 15:12:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240327165456.34716-1-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240327165456.34716-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH-for-9.0 v2] hw/i386/pc: Deprecate 64-bit CPUs on ISA-only
 PC machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 27/03/2024 16:54, Philippe Mathieu-Daudé wrote:

> Per Daniel suggestion [*]:
> 
>   > isapc could arguably be restricted to just 32-bit CPU models,
>   > because we should not need it to support any feature that didn't
>   > exist prior to circa 1995. eg refuse to start with isapc, if 'lm'
>   > is present in the CPU model for example.
> 
> Display a warning when such CPU is used:
> 
>    $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu Westmere
>    qemu-system-x86_64: warning: Use of 64-bit CPU 'Westmere' is deprecated on the ISA-only PC machine
>    QEMU 8.2.91 monitor - type 'help' for more information
>    (qemu) q
> 
>    $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu athlon
>    QEMU 8.2.91 monitor - type 'help' for more information
>    (qemu) q
> 
> [*] https://lore.kernel.org/qemu-devel/ZgQkS4RPmSt5Xa08@redhat.com/
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst |  7 +++++++
>   include/hw/i386/pc.h      |  1 +
>   hw/i386/pc_piix.c         | 14 ++++++++++++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..345c35507f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -208,6 +208,13 @@ is no longer packaged in any distro making it harder to run the
>   ``check-tcg`` tests. Unless we can improve the testing situation there
>   is a chance the code will bitrot without anyone noticing.
>   
> +64-bit (x86_64) CPUs on the ``isapc`` machine (since 9.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``isapc`` machine aims to emulate old PC machine without PCI was
> +generalized, so hardware available around 1995, before 64-bit intel
> +CPUs were produced.
> +
>   System emulator machines
>   ------------------------
>   
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 27a68071d7..2d202b9549 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -96,6 +96,7 @@ struct PCMachineClass {
>       const char *default_south_bridge;
>   
>       /* Compat options: */
> +    bool deprecate_64bit_cpu; /* Specific to the 'isapc' machine */
>   
>       /* Default CPU model version.  See x86_cpu_set_default_version(). */
>       int default_cpu_version;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 18ba076609..2e5b2efc33 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -182,7 +182,20 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>       }
>   
>       pc_machine_init_sgx_epc(pcms);
> +
>       x86_cpus_init(x86ms, pcmc->default_cpu_version);
> +    if (pcmc->deprecate_64bit_cpu) {
> +        X86CPU *cpu = X86_CPU(first_cpu);
> +
> +        if (cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> +            const char *cpu_type = object_get_typename(OBJECT(first_cpu));
> +            int cpu_len = strlen(cpu_type) - strlen(X86_CPU_TYPE_SUFFIX);
> +
> +            warn_report("Use of 64-bit CPU '%.*s' is deprecated"
> +                        " on the ISA-only PC machine",
> +                        cpu_len, cpu_type);
> +        }
> +    }
>   
>       if (kvm_enabled()) {
>           kvmclock_create(pcmc->kvmclock_create_always);
> @@ -918,6 +931,7 @@ static void isapc_machine_options(MachineClass *m)
>       pcmc->gigabyte_align = false;
>       pcmc->smbios_legacy_mode = true;
>       pcmc->has_reserved_memory = false;
> +    pcmc->deprecate_64bit_cpu = true;
>       m->default_nic = "ne2k_isa";
>       m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>       m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);

The logic around checking CPUID_EXT2_LM looks good to me. Slightly curious as to 
whether people feel updating PCMachineClass is necessary, or you can simply do 
qdev_get_machine() and use object_dynamic_cast() to see if the machine matches 
MACHINE_NAME("isapc") and warn that way?

FWIW I'd be amazed if anyone were actually overriding the default and trying to do 
this, but I guess that's what the warn_report() is for.... anyhow:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


