Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A54C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPjQ-0006pN-RO; Tue, 18 Feb 2025 10:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkPjN-0006oX-B6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:41:54 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkPjK-0002bf-Qm
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:41:52 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43996e95114so5133185e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739893308; x=1740498108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rftezDm0PXXAzXVMv5QO3Kp9pkZEb9I5IaKVIiUl1+w=;
 b=PCpEU+822rOiuTQGRwY3qSB5Qa1LjDmn/5aOgKv22/aha3g8VqxwBcK7hNJiZmm3nu
 U19O1DnsXVcr5TwlgraO2YCKJwLdGoCePX1XnJCe9atL+1gjPw0Xw788AXUDpYMyWbcZ
 dF8Wm0G0+n34yptvDr4Xtwn5IvF0fFeChfv3QdyMTQFlC0YyLz1hP7OPgZJAP0hqpMkx
 qkG64w84Gx52sc2hxYwYTSYc2HRm8x+AihFq+Yezp3zUOTNOAsdqniqZISazEUOaynV1
 awII52P0B4g0wjXdhWusN/sHYKNtGE1Af0rMdFwWKPn0plCWo1C2Z5YFz/cJzNspo9Z2
 8GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739893308; x=1740498108;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rftezDm0PXXAzXVMv5QO3Kp9pkZEb9I5IaKVIiUl1+w=;
 b=CNJmF8I0x1MhS3xHVh2eHubYW+FwgZrE/O4w4+ir/j8ArvgOcduFIsZCecHN/OrPzB
 jLPfka5IQ+ziKx5OCrmsDWS2ykKh5rPF5pgZECf0GBUksTsB0N54YGWt1q9rta3XFR5H
 GYQU1lKVMVMnzXrh0a1Qz5gnE7APM8cJk1YAsIS0UUiSTyJYk3I3BDjNZfllu/UvJFYW
 HdRf3fT1SPtGPvDV4x+wgxkhiRZkxzhAMC6siastwe1A/xIVdDbKmE4QpL+VcR2Fx9mE
 WL+Yov22FtgTGuvxMSL8w6je4oDCrd0eezNWqms2JtBQvhpuoMHVV/3ssMc/As1OhZj7
 /oQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYNvogbGwr86xCiQKj0ecb4nG32O7IeL+SkMmFoklNL0Ihp8bXpJWmULRqbnlHu8NuKjkN39AFFCPv@nongnu.org
X-Gm-Message-State: AOJu0YyEO7asE6qf/auuFJoai2C0NQL+2vb5Ha1hlNh25e+ZTW2y1zPl
 BtVku2+wcyx8KIgTb7oUJmWGSPXq8hEajHGMLH76JLvV0cSnl77IOtqaNVi4cMw=
X-Gm-Gg: ASbGnct7GMerHcgU6MgRbpawpJ94uwmcoksEyO437ggBuZY56lt757FDj3t8CV2TQeW
 pFNZS/Rhs3kLi8/U0lC5uc1jzPE9l6S/2JYL2GlY/YPE3iAZZYi7UpRrHSP/hffDWwCkfWaUm8a
 LcM0AxZ19IkR+MUbxfEFomJECl3stzOqRY+XynZ0QhlVcrLDMQ04YlVekUEvdeGREySi9y7HhGk
 jMFdhD5jMxT8C6Fxmd/HeHz0PeOsFSDz3k3iUkK0LDs8zgtDjkzJi7pUMG6Qve8zw/M3VM7xd81
 tNV2RynJhkapxzX2taJUlKaT2VTXD/4sL3PBt7yIBkv3dFcH6vMBVZWQ2uA=
X-Google-Smtp-Source: AGHT+IF/8ntl9BcDGAADsSp5RSNssX1/saVLS8T4n7eb/VsqHM+B23KD2LwLr97A98aYw1YdA9oepQ==
X-Received: by 2002:a05:600c:1ca8:b0:439:8a44:1e65 with SMTP id
 5b1f17b1804b1-4398a441f98mr62729005e9.7.1739893308542; 
 Tue, 18 Feb 2025 07:41:48 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398cb4de78sm41912265e9.24.2025.02.18.07.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 07:41:48 -0800 (PST)
Message-ID: <5580a9e6-c1bc-44c8-9edc-d98ba4985123@linaro.org>
Date: Tue, 18 Feb 2025 16:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/9] meson: Disallow 64-bit on 32-bit Xen emulation
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>, qemu-devel@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
 <20250208205725.568631-4-richard.henderson@linaro.org>
 <aeaf0f19-0f14-4a02-9c51-09521e7c75e1@linaro.org>
 <9b22d0ff-5902-4ec7-ae54-e974482ebd87@citrix.com>
 <3fb630f4-ebd2-4f14-a1fe-4e84786a1400@linaro.org>
Content-Language: en-US
In-Reply-To: <3fb630f4-ebd2-4f14-a1fe-4e84786a1400@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/2/25 16:25, Philippe Mathieu-Daudé wrote:
> +Vikram
> 
> On 18/2/25 15:10, Andrew Cooper wrote:
>> On 18/02/2025 11:20 am, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> Adding Xen community.
>>>
>>> On 8/2/25 21:57, Richard Henderson wrote:
>>>> Require a 64-bit host binary to spawn a 64-bit guest.
>>>>
>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>    meson.build | 9 +++++++--
>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index 1af8aeb194..911955cfa8 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -304,9 +304,14 @@ else
>>>>    endif
>>>>    accelerator_targets = { 'CONFIG_KVM': kvm_targets }
>>>>    -if cpu in ['x86', 'x86_64']
>>>> +if cpu == 'x86'
>>>> +  xen_targets = ['i386-softmmu']
>>>> +elif cpu == 'x86_64'
>>>>      xen_targets = ['i386-softmmu', 'x86_64-softmmu']
>>>> -elif cpu in ['arm', 'aarch64']
>>>> +elif cpu == 'arm'
>>>> +  # i386 emulator provides xenpv machine type for multiple
>>>> architectures
>>>> +  xen_targets = ['i386-softmmu']
>>>
>>> Is actually someone *testing* this config? I'm having hard time building
>>> it, so am very suspicious about how it runs, and start to wonder if I'm
>>> not just wasting my time (as could be our CI).
>>
>> It was intentional.  I believe it was Stefano (CC'd) who introduced it.
> 
> In the introduction commit, "ARM targets" is used, so apparently both
> 32/64bit were picked deliberately:
> 
> ---
> commit aaea616d54317b8a0154adf52303a51da2d8d56f
> Author: Vikram Garhwal <vikram.garhwal@amd.com>
> Date:   Wed Jun 14 17:03:38 2023 -0700
> 
>      meson.build: enable xenpv machine build for ARM
> 
>      Add CONFIG_XEN for aarch64 device to support build for ARM targets.
> 
>      Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
>      Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
>      Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> diff --git a/meson.build b/meson.build
> index 481865bfa97..cfa98e9e25f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -136,7 +136,7 @@ endif
>   if cpu in ['x86', 'x86_64', 'arm', 'aarch64']
>     # i386 emulator provides xenpv machine type for multiple architectures
>     accelerator_targets += {
> -    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu'],
> +    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu'],
>     }
>   endif
>   if cpu in ['x86', 'x86_64']
> ---

Hmm wrong commit apparently, but the history isn't clear. See:

-- >8 --
commit 3b6b75506de44c5070639943c30a0ad5850f5d02
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Mon Sep 17 11:59:41 2012 +0200

     configure: factor out list of supported Xen/KVM/HAX targets

     This will be useful when the functions are called, early in the 
configure
     process, to filter out targets that do not support hardware 
acceleration.

     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/configure b/configure
...
+supported_xen_target() {
+    test "$xen" = "yes" || return 1
+    glob "$1" "*-softmmu" || return 1
+    case "${1%-softmmu}:$cpu" in
+        arm:arm | aarch64:aarch64 | \
+        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
+            return 0
+        ;;
+    esac
+    return 1
+}
+
  # default parameters
  source_path=$(dirname "$0")
  cpu=""
@@ -6178,46 +6222,22 @@ echo "TARGET_ABI_DIR=$TARGET_ABI_DIR" >> 
$config_target_mak
  if [ "$HOST_VARIANT_DIR" != "" ]; then
      echo "HOST_VARIANT_DIR=$HOST_VARIANT_DIR" >> $config_target_mak
  fi
-case "$target_name" in
-  i386|x86_64)
-    if test "$xen" = "yes" -a "$target_softmmu" = "yes" ; then
-      echo "CONFIG_XEN=y" >> $config_target_mak
-      if test "$xen_pci_passthrough" = yes; then
+
+if supported_xen_target $target; then
+    echo "CONFIG_XEN=y" >> $config_target_mak
+    if test "$xen_pci_passthrough" = yes; then
          echo "CONFIG_XEN_PCI_PASSTHROUGH=y" >> "$config_target_mak"
-      fi
      fi
-    ;;
-  *)
---

Paolo, Alex, was this intentional?

>> Xen uses qemu-system-i386 everywhere because qemu-system-x86_64 doesn't
>> make compatible VMs.  I'm not sure why; I suspect it's bugs in the Xen
>> machine types, but I don't know QEMU well enough to be sure.
>>
>> Another thing that (at least, was) tied to qemu-system-i386 was using
>> Qemu as a XenBlk <-> QCOW adapter, at which point it wasn't even really
>> a system emulator, just a paravirtual disk implementation.
>>
>> This is, AIUI, what ARM wants with the xenpv machine.  If there's a
>> better way to do this, please do say.
> 
> No, I concur.
> 
>> Looking through Xen's CI, I can't see any of the ARM builds building
>> QEMU at all.  I think it's quite possible it's not tested any more.
> 
> We only cross-build, see our cross-arm64-xen-only job:
> https://gitlab.com/qemu-project/qemu/-/jobs/9165958873
> 
> Note, if it is not clear, the problem I have is to test Xen on
> 32-bit ARM hosts; I don't have any problem with 64-bit ones.
> 
> Regards,
> 
> Phil.


