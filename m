Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B213C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 10:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiW7F-00088C-IY; Thu, 13 Feb 2025 05:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1325cea77=graf@amazon.de>)
 id 1tiW72-00086L-W1; Thu, 13 Feb 2025 05:06:30 -0500
Received: from smtp-fw-52004.amazon.com ([52.119.213.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1325cea77=graf@amazon.de>)
 id 1tiW70-0006BA-BN; Thu, 13 Feb 2025 05:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739441187; x=1770977187;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=ll4CuhIf7mFggQoX8RTnwFFYu7XxUD88uccQ2k3U6aQ=;
 b=cKRFeiDqRPEmB5PcwTlz0z3Hur81KWWJa6CdzFI2b2/bLLQI4x2XXplZ
 S4wjX+suEU5bo3IZiWNULOG442NGNEBZwl151MVvNiNASRnUBUJcXIx1C
 MJNPCprqMv3ki3dbFDDHo4tgk7AXwJnhzi979mYyn9t8+i0ZSUv+zuVI+ w=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
 d="scan'208,217";a="270824079"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-52004.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:06:19 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:37198]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.53:2525]
 with esmtp (Farcaster)
 id 1325899b-285c-4051-90f8-0998ab36c980; Thu, 13 Feb 2025 10:06:18 +0000 (UTC)
X-Farcaster-Flow-ID: 1325899b-285c-4051-90f8-0998ab36c980
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 10:06:10 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Thu, 13 Feb 2025
 10:06:07 +0000
Content-Type: multipart/alternative;
 boundary="------------Xf1MkVMVt0nC8UJaQN0AJdG3"
Message-ID: <f2cea4d6-6bde-4e22-9f1d-2aa92a0d287d@amazon.com>
Date: Thu, 13 Feb 2025 11:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/23] hw/uefi: add var-service-core.c
To: Ard Biesheuvel <ardb@kernel.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, <qemu-devel@nongnu.org>, Eric Blake
 <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 <qemu-arm@nongnu.org>, Michael Roth <michael.roth@amd.com>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250211092324.965440-1-kraxel@redhat.com>
 <20250211092324.965440-10-kraxel@redhat.com>
 <da0ac9ed-fdca-433e-b793-5423f430a852@amazon.com>
 <iuwaykfdm7bwtvblyz7lkew3em2ksi5xeztdphqjdv7tsp2ejw@s6j64y3lfmrw>
 <ea1d355b-7e56-47ef-b1e7-158003b6d85f@amazon.com>
 <kk4f5e3olb26qfjveqefkuzrjc45djikkk7uspz4yj7iesdmbj@zointitbvhdp>
 <73fe41f7-dff0-4506-8769-1997323c0a76@amazon.com>
 <4bwjwcs2k4hbrj6mokc57a5dy57jjssfxnvd4qm5257dgnid3x@yqdx7e47o2mf>
 <2c06a98c-f286-4632-a352-8b47dc4cc43c@amazon.com>
 <CAMj1kXHDMCNGG94V8VcnS8busEGs-MwOy+Ne_oRCkvtw9DiX1w@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAMj1kXHDMCNGG94V8VcnS8busEGs-MwOy+Ne_oRCkvtw9DiX1w@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.119.213.154;
 envelope-from=prvs=1325cea77=graf@amazon.de; helo=smtp-fw-52004.amazon.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

--------------Xf1MkVMVt0nC8UJaQN0AJdG3
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 13.02.25 10:28, Ard Biesheuvel wrote:
> On Wed, 12 Feb 2025 at 22:26, Alexander Graf<graf@amazon.com> wrote:
>>
>> On 12.02.25 16:18, Gerd Hoffmann wrote:
>>>     Hi,
>>>
>>>>> Yes.  Knowing both physical and virtual address works only for memory
>>>>> you allocated yourself before ExitBootServices.  So you can't pass on
>>>>> pointers from the OS, you have to copy the data to a buffer where you
>>>>> know the physical address instead.  Yes, some overhead.  Should still
>>>>> be much faster than going to pio transfer mode ...
>>>> MacOS takes over the full physical address map past ExitBootServices: Your
>>>> code no longer has VA access to random code
>>> That is totally fine.  EFI drivers must register everything they need as
>>> runtime memory.  Anything else can be unmapped by the OS when calling
>>> EFI services.
>>>
>>>> and it literally memcpy()'s all preserved (virtual available) code and
>>>> data to different physical addresses.
>>> Uhm.  I have my doubts this copying behavior is blessed by the UEFI spec.
>>
>> I don't remember anything in the spec prohibiting it.
>>
> The UEFI spec clearly states that runtime services must either be
> called using a 1:1 mapping, or via a virtual remapping but in that
> case, SetVirtualAddresMap() must be called to inform the firmware of
> the new virtual mapping.


Correct, which is what boot.efi does. That mapping only tells firmware 
about the change from old VA -> new VA though.


> Even if this is not clearly stated, this violates the intent of the
> UEFI spec: the code reasons about mappings of physical memory,
> implying that the mapping is the only thing that changes. Moving
> memory contents around can only be done safely after
> SetVirtualAddressMap(), making it mandatory on these systems, whereas
> the spec clearly states that it is entirely optional.


The spec says that calling SetVirtualAddressMap is optional from the 
firmware's point of view. A boot loader may call it - and even depend on 
its functionality. The spec even goes further and almost endorses the 
case boot.efi does:

> The call to SetVirtualAddressMap() must be done with the physical 
> mappings. On successful return from this function, the system must 
> then make any future calls with the newly assigned virtual mappings. 
> All address space mappings must be done in accordance to the 
> cacheability flags as specified in the original address map. [...]


You can absolutely read that paragraph as "From here on, only virtual 
mappings matter".


> But whatever OSX does on x86 is irrelevant anyway: it is vertically
> integrated with the firmware, which is vaguely EFI based but does not
> aim for spec compliance. The OSX EULA does not permit running it on
> anything other than Apple hardware. And x86 Apple hardware will be
> reaching obsolescence pretty soon, at least where future development
> is concerned.


I halfway agree. It's fairly trivial to make x86 Mac OS X work with 
stock edk2 [1]. All you need are a few boot services, a non-standard way 
(or BootXXX variables) to find the real boot binary and APFS driver 
(binary is included in every APFS FS) load support. The rest is a fairly 
standard compliant UEFI environment.

But I'm not sure how that's relevant to the argument that we need a way 
to perform runtime service calls without relying on DMA? In addition to 
the potential VA/PA mismatch issue, relying on DMA from RTS can quickly 
also get broken for any confidential compute environments where you need 
to take explicit action to make memory visible to the hypervisor.

All I'm asking for is an (optional) viable path that works without DMA :).


> My colleague filed a USWG proposal for a EFI_MEMORY_SHARED attribute
> that must be honored by the OS when creating runtime mappings, and map
> the region in a way that allows access by another observer (typically
> the VMM but semantically it could mean other things too)


For something as core as a UEFI variable service that should become the 
default in a generic platform like QEMU, I don't think we should rely on 
new additions to the UEFI spec :(. Users want to be able to run old 
Operating Systems.


>
>>>> You simply have nothing that is all of 1) RAM (mapped as cacheable on
>>>> ARM), 2) known VA 3) known PA.
>>> Bummer.
>>>
>>>> So we really really need a fallback mechanism that works without DMA
>>>> :).
>>> On arm it should be relatively simple to move the buffer to device
>>> memory.  Just place one more region on the platform bus, advertise
>>> address + size via device tree, done.
>>
>> That will bring back all issues with cached vs non-cached memory
>> accesses, no? So edk2 will always access that memory as device memory
>> which means it bypasses the cache, while QEMU will access it through the
>> cache. So that buffer would need to actually be MMIO memory I suppose?
>>
> Indeed. Presenting memory as MMIO just to trick the guest into mapping
> it shared is not the right approach here, which is why we need
> EFI_MEMORY_SHARED on ARM. On x86, using the EfiMemoryMappedIo type
> happens to work, but it is a hack (e.g., you cannot allocate memory of
> this type)


The non-hacky alternative would be to expose a real 64KiB large MMIO 
window into host memory that goes through full instruction emulation for 
every access. Then we could expose it as real MMIO target memory to RTS 
which should always work. DMA can then be an (optional) optimization on 
top to copy to/from that buffer.


Alex


[1] 
https://github.com/tianocore/edk2/compare/vUDK2018...agraf:edk2:vUDK2018-AppleSupportPkg

--------------Xf1MkVMVt0nC8UJaQN0AJdG3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 13.02.25 10:28, Ard Biesheuvel
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAMj1kXHDMCNGG94V8VcnS8busEGs-MwOy+Ne_oRCkvtw9DiX1w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
On Wed, 12 Feb 2025 at 22:26, Alexander Graf <a class="moz-txt-link-rfc2396E" href="mailto:graf@amazon.com">&lt;graf@amazon.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

On 12.02.25 16:18, Gerd Hoffmann wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">   Hi,

</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">Yes.  Knowing both physical and virtual address works only for memory
you allocated yourself before ExitBootServices.  So you can't pass on
pointers from the OS, you have to copy the data to a buffer where you
know the physical address instead.  Yes, some overhead.  Should still
be much faster than going to pio transfer mode ...
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">MacOS takes over the full physical address map past ExitBootServices: Your
code no longer has VA access to random code
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">That is totally fine.  EFI drivers must register everything they need as
runtime memory.  Anything else can be unmapped by the OS when calling
EFI services.

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">and it literally memcpy()'s all preserved (virtual available) code and
data to different physical addresses.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Uhm.  I have my doubts this copying behavior is blessed by the UEFI spec.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">

I don't remember anything in the spec prohibiting it.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The UEFI spec clearly states that runtime services must either be
called using a 1:1 mapping, or via a virtual remapping but in that
case, SetVirtualAddresMap() must be called to inform the firmware of
the new virtual mapping.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Correct, which is what boot.efi does. That mapping only tells
      firmware about the change from old VA -&gt; new VA though.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAMj1kXHDMCNGG94V8VcnS8busEGs-MwOy+Ne_oRCkvtw9DiX1w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">Even if this is not clearly stated, this violates the intent of the
UEFI spec: the code reasons about mappings of physical memory,
implying that the mapping is the only thing that changes. Moving
memory contents around can only be done safely after
SetVirtualAddressMap(), making it mandatory on these systems, whereas
the spec clearly states that it is entirely optional.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>The spec says that calling SetVirtualAddressMap is optional from
      the firmware's point of view. A boot loader may call it - and even
      depend on its functionality. The spec even goes further and almost
      endorses the case boot.efi does:<br>
      <br>
      <blockquote type="cite"><span
style="color: rgb(64, 64, 64); font-family: Lato, proxima-nova, &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(252, 252, 252); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">The
          call to SetVirtualAddressMap() must be done with the physical
          mappings. On successful return from this function, the system
          must then make any future calls with the newly assigned
          virtual mappings. All address space mappings must be done in
          accordance to the cacheability flags as specified in the
          original address map. [...]<br>
        </span></blockquote>
      <br>
      <br>
      You can absolutely read that paragraph as "From here on, only
      virtual mappings matter".<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAMj1kXHDMCNGG94V8VcnS8busEGs-MwOy+Ne_oRCkvtw9DiX1w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">But whatever OSX does on x86 is irrelevant anyway: it is vertically
integrated with the firmware, which is vaguely EFI based but does not
aim for spec compliance. The OSX EULA does not permit running it on
anything other than Apple hardware. And x86 Apple hardware will be
reaching obsolescence pretty soon, at least where future development
is concerned.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>I halfway agree. It's fairly trivial to make x86 Mac OS X work
      with stock edk2 [1]. All you need are a few boot services, a
      non-standard way (or BootXXX variables) to find the real boot
      binary and APFS driver (binary is included in every APFS FS) load
      support. The rest is a fairly standard compliant UEFI environment.<br>
      <br>
      But I'm not sure how that's relevant to the argument that we need
      a way to perform runtime service calls without relying on DMA? In
      addition to the potential VA/PA mismatch issue, relying on DMA
      from RTS can quickly also get broken for any confidential compute
      environments where you need to take explicit action to make memory
      visible to the hypervisor.<br>
      <br>
      All I'm asking for is an (optional) viable path that works without
      DMA :).<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAMj1kXHDMCNGG94V8VcnS8busEGs-MwOy+Ne_oRCkvtw9DiX1w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">My colleague filed a USWG proposal for a EFI_MEMORY_SHARED attribute
that must be honored by the OS when creating runtime mappings, and map
the region in a way that allows access by another observer (typically
the VMM but semantically it could mean other things too)</pre>
    </blockquote>
    <p><br>
    </p>
    <p>For something as core as a UEFI variable service that should
      become the default in a generic platform like QEMU, I don't think
      we should rely on new additions to the UEFI spec :(. Users want to
      be able to run old Operating Systems.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAMj1kXHDMCNGG94V8VcnS8busEGs-MwOy+Ne_oRCkvtw9DiX1w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">You simply have nothing that is all of 1) RAM (mapped as cacheable on
ARM), 2) known VA 3) known PA.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Bummer.

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">So we really really need a fallback mechanism that works without DMA
:).
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">On arm it should be relatively simple to move the buffer to device
memory.  Just place one more region on the platform bus, advertise
address + size via device tree, done.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">

That will bring back all issues with cached vs non-cached memory
accesses, no? So edk2 will always access that memory as device memory
which means it bypasses the cache, while QEMU will access it through the
cache. So that buffer would need to actually be MMIO memory I suppose?

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Indeed. Presenting memory as MMIO just to trick the guest into mapping
it shared is not the right approach here, which is why we need
EFI_MEMORY_SHARED on ARM. On x86, using the EfiMemoryMappedIo type
happens to work, but it is a hack (e.g., you cannot allocate memory of
this type)
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>The non-hacky alternative would be to expose a real 64KiB large
      MMIO window into host memory that goes through full instruction
      emulation for every access. Then we could expose it as real MMIO
      target memory to RTS which should always work. DMA can then be an
      (optional) optimization on top to copy to/from that buffer.<br>
      <br>
      <br>
      Alex<br>
    </p>
    <p><br>
    </p>
    <p>[1]
<a class="moz-txt-link-freetext" href="https://github.com/tianocore/edk2/compare/vUDK2018...agraf:edk2:vUDK2018-AppleSupportPkg">https://github.com/tianocore/edk2/compare/vUDK2018...agraf:edk2:vUDK2018-AppleSupportPkg</a><br>
      <br>
    </p>
  </body>
</html>

--------------Xf1MkVMVt0nC8UJaQN0AJdG3--

