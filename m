Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C48CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6tX-0002yX-RO; Tue, 26 Mar 2024 09:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rp6tQ-0002rn-3U; Tue, 26 Mar 2024 09:31:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rp6tM-0003Dk-FL; Tue, 26 Mar 2024 09:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QtOU5JTRLxTRUdgADv2KCVCEp2SuayuLztIleGhAyMQ=; b=DNKZI83K8e61TFHkluNMLsbTw8
 vy8fDdUpuUuh5C78OFG7UHESm3aGocrAu2jFYxD0RlwmzLue/Hr5JLi34odMRqdKsiUjB7EI0JQmb
 1yq82BeOj8FdH81Lakj7CHaeGtK952mkmATx8M5fPZOKIEklJtWBxV63KwZvW86YuzqFHUZDbKq3I
 igg38kG7qN8FJXPAbB0qauAIBpzdicUuo/J+XCasGxWqQ5diMOfhXD1uBkT2rkAAYHlhjOD5tCW8X
 Wwowq1JmJc0/xSPwFy/X2nMibNc0xwro/OBZ67KISDgZZ9v+E3wiY1XVtB52BsrV6ANcKaG+bdwOw
 iO3h5O+xNYfuh2nyvx3dzt/zvH7W5YuJolcgqGqUpJP7LEjfq85pppfscHVTJoQfmCYsWn1h7GuZo
 T9VszpLiQUl81k7s/IQ9EuDN6C1vF7NSwkBfnfrkIUx8rw+hALKMZ9Z+8TXmYPnRijTYQK4c/qMSQ
 OyhWDhWPlIthIP5emuUcIE0oQwM3NtNR2wb5nr3D4w782ojjeMsud6kUCWD5wLgDm0W0DdYnelat6
 D46o9SIIp1juGkRo7sbECzZnYiYbvHMyM26HYLlPbqiLUVgfY8HdKqJhOooNKjC8lbjNVa2JT9CRs
 cSnmVtRTRL+K17Lj/UEWPkkHyva2tzJH+Ct2HRbGc=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rp6sK-0006nG-2D; Tue, 26 Mar 2024 13:30:00 +0000
Message-ID: <d8ddb193-fe76-4554-b887-5106eed2dd01@ilande.co.uk>
Date: Tue, 26 Mar 2024 13:30:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, devel@lists.libvirt.org,
 richard.henderson@linaro.org, mst@redhat.com, thuth@redhat.com,
 qemu-trivial@nongnu.org
References: <20240326125104.90103-1-imammedo@redhat.com>
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
In-Reply-To: <20240326125104.90103-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
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

On 26/03/2024 12:51, Igor Mammedov wrote:

> ISAPC machine was introduced 25 years ago and it's a lot of time since
> such machine was around with real ISA only PC hardware practically defunct.
> Also it's slowly bit-rots (for example: I was able to boot RHEL6 on RHEL9 host
> in only TCG mode, while in KVM mode it hung in the middle of boot)
> 
> Rather than spending time on fixing 'the oldest' no longer tested machine type,
> deprecate it so we can clean up QEMU code from legacy fixups and hopefully
> make it easier to follow.
> 
> Folks who have to use ancient guest that requires ISAPC can still
> use older QEMU to play with it.

Heh I've actually been using isapc over the past couple of weeks to fire up some old 
programs in a Windows 3 VM :)

I'd really hate to see isapc disappear as there are a number of people from the retro 
crowd (such as myself) who fire up QEMU/KVM on various historical images, and whilst 
there are alternatives, there isn't really anything that touches QEMU performance-wise.

This leads into the question as to how QEMU should handle less recent machines: I 
appreciate that from an enterprise perspective there is little interest, but there 
are plenty of hobbyists and historians who are.

 From my personal experience with SPARC/macppc machines I accept that they are not 
first-class citizens, and so my approach here is that I don't mind if patches break 
migration or command-line compatibility as long as I can still fire up the VM. 
Regressions do occur, but fortunately they don't tend to occur that often.

I can see how there is a lot of legacy cruft around handling legacy command line 
options that could be improved by removing isapc, and I think that a lot of this is 
around preserving historical behaviour.

How about splitting the isapc machine out of the generic PC init so that it can be 
used going forward with less command-line/migration compatibility guarantees, but 
also won't prevent subsequent tidy-ups/changes to the main PC machines going forward?

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   docs/about/deprecated.rst | 7 +++++++
>   hw/i386/pc_piix.c         | 1 +
>   2 files changed, 8 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..5708296991 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -226,6 +226,13 @@ These old machine types are quite neglected nowadays and thus might have
>   various pitfalls with regards to live migration. Use a newer machine type
>   instead.
>   
> +``isapc`` (since 9.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +These old machine type are quite neglected nowadays and thus might have
> +various pitfalls with regards to live migration. Use a newer machine type
> +instead.
> +
>   Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
>   '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>   
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 18ba076609..96f72384dd 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -921,6 +921,7 @@ static void isapc_machine_options(MachineClass *m)
>       m->default_nic = "ne2k_isa";
>       m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>       m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
> +    m->deprecation_reason = "old and unattended - use a newer version instead";
>   }
>   
>   DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,


ATB,

Mark.


