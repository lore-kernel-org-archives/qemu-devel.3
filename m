Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1185FD3B7E1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 07:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFTJe-0002uQ-C0; Mon, 25 Nov 2024 02:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tFTJc-0002tV-Ob
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 02:15:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tFTJa-0008Lx-Gq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 02:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732518921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JGShTioejfBrz2tPauKVa+5Y9a0dsM111o37HqGmUgA=;
 b=ihcLrii3iP+7cRk9t40gYnuuiHk7z0OXApO2nrxDTRxBGLvwZLHJrq+kCFWpXblb8+evnD
 XAtDowZinkkF3LMdxk5W9W+qvst8tbfvQgkEBtJGR+ZZ0QUQQ7fUHeL43I/HHoKg/0c9vj
 616EMk1ikl5INRyt18PHJcR//WcSOiY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-MhepYGj6Ps2EjZY6F1m5yg-1; Mon, 25 Nov 2024 02:15:20 -0500
X-MC-Unique: MhepYGj6Ps2EjZY6F1m5yg-1
X-Mimecast-MFC-AGG-ID: MhepYGj6Ps2EjZY6F1m5yg
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5cffb934628so3035316a12.3
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 23:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732518919; x=1733123719;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JGShTioejfBrz2tPauKVa+5Y9a0dsM111o37HqGmUgA=;
 b=XOr0fm6vRzDEOkRI/U0F/BhUtYGTvWro9bSyVYX5RCq0roxhgMWp9Lxpl0oiVfu0Lx
 nITSmno3T5Q7LvA5Tzm1L48NYFFWt53lu+E2OihNcLf9L6OuHs/4ShvtY3F6BVltvMUM
 tRjoF02Pkrg0iBxsGugFI+bYqrYOHqkRodxw4qJDFtaFo26a2ftDqXR/synuaB2Ru6SQ
 iqNZQo2FaCbetvCxoHnHqe3ArDddGLJ8LLVtHJD5dxJBGqrnMkOOhxiJ3nsbYXvr827n
 mGrnNsa5BKFyvGlKax08gv9NQwEbhBBniOeP7p/cYXvXGOdv5PUiWbDtl8pvh6UFMh+F
 NlRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0/fRW22teKrqlp1DM8j1iCksbuntsVdgE2pM9EFP+ubiCklnpnnsBCBlk6jCeumyH7csiszTm1XaU@nongnu.org
X-Gm-Message-State: AOJu0YxLXUmwxpAb4B2zLiY/y62lKkjrrH/V8oiNniah14FCmjmeIbmP
 l6Hxbtu1PV/6eRgqC+HRt/gTzpqlJSNJJPrH8GxP3tx2LwiHiSwp3ZTi1FlfFFw7ESVipd89M7L
 LCyGw6Uj8biTolXc8Mkr3VoSNGwJ6ZssW18Z7kY1p27bgStP98TZJ
X-Gm-Gg: ASbGncuL+OC1s30TgUsYm1Z/+TXD/wZ6vV4T8Nbu5deJOJoBjRR9Jn9wTDIdbzwC0Aj
 oecFmT4+f3J7KQuXG7lcUdMqEkm0Xnzj4xQYL7NlFNE4/RHmbe+N9yZ53ayMCNbMHSUxFo1Up12
 bi8oAxeuCIxWHszPOsMMqs31TMqF6vOh6aQyUZ1pAqR7hS0TpBynbiu30z9TQqSlGGa0E8ld00O
 Gl81iiI0D+sbKL1kPOCW9EoqFtLcv7iIoESlGswiIoWHIKW47sOoKFaWx5T4IO0s3BVhmGB0O6D
 y+E=
X-Received: by 2002:a05:6402:530b:b0:5cf:f470:a4a0 with SMTP id
 4fb4d7f45d1cf-5d0207ba254mr9513899a12.32.1732518918815; 
 Sun, 24 Nov 2024 23:15:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXEBGst9biMGZbkwTQaQG3TfeiHPueh68XO6QCXx2NBJV9MfBBUAf04QqUlDc5GqWX+b0oXA==
X-Received: by 2002:a05:6402:530b:b0:5cf:f470:a4a0 with SMTP id
 4fb4d7f45d1cf-5d0207ba254mr9513878a12.32.1732518918500; 
 Sun, 24 Nov 2024 23:15:18 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d01d3b036bsm3747114a12.20.2024.11.24.23.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 23:15:18 -0800 (PST)
Message-ID: <f5ad7d51-a6fa-4f3d-b4b2-524dad42e670@redhat.com>
Date: Mon, 25 Nov 2024 08:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24/11/2024 21.23, Pierrick Bouvier wrote:
> On 11/24/24 04:10, Paolo Bonzini wrote:
>> On 11/24/24 01:21, Pierrick Bouvier wrote:
>>> After thinking about it, a simple, exhaustive and reliable way to find
>>> this type information is the debug (dwarf) info.
>>> By compiling qemu binaries with --enable-debug, and extracting info
>>> using llvm-dwarfdump plus a custom filter [4], we can obtain a text
>>> representation of all structures QEMU uses.
>>
>> Yes, this is a good idea.
>>
>>> As there is a lot of repetition between all qemu binaries, the reduced
>>> list of structs concerned is [6]:
>>> +name:ArduinoMachineClass size:0x0198
>>> +name:ARMCacheAttrs size:0x04
>>> +name:ARMVAParameters size:0x04
>>> +name:AspeedMachineClass size:0x01d0
>>> +name:_GIOChannel size:0x70
>>
>> This one unfortunately shows why the global change is wrong.  The size
>> of _GIOChannel must match between glib and QEMU, otherwise you have an
>> ABI mismatch.
>>
> 
> In the codebase, we always use this type as an opaque type (through pointer, 
> using library functions to interact with it and never use it's size). So the 
> fact we see a different layout is *not* an issue for QEMU. I don't see it as 
> a counter example that this does not work.

If you have a look at the difference between the binaries with "pahole", you 
can see also differences in bitfields in glib structs (GdkEventKey), even if 
the overall size of the struct does not change.

So even if it would be working by chance with the current libraries, this is 
a ticking time bomb - for each future library, this could break at any point 
in time, so IMHO we really must not enable -mno-ms-bitfields globally on 
Windows.

>> In other words, the global default _must_ be -mms-bitfields, because all
>> other libraries (and also Windows itself, though you didn't find any
>> occurrences) are built with MSVC ABI compatibility.  Bitfields are
>> relatively rare, and therefore you only found one occurrence; however,
>> this is a constraint that we cannot get rid of.
>>
> 
> -mms-bitfields is already the (silent) gcc default on windows, to mimic MSVC 
> behaviour. Yes, it would be preferable to use this default and gcc_struct 
> attribute, but right now, it does not work with clang. So the whole point is 
> to accept a compromise for this.
> We can even apply this selectively when clang is detected in case QEMU 
> community is scared changing this default would break existing code.
>
> I don't understand the strong pushback against clang support on windows. 

It's certainly not a dislike of Clang. It's simply that we've seen problems 
in the past with bitfields in structures, and so far nobody went ahead and 
checked each and every target whether we are clean nowadays. And as long as 
nobody does this tedious job, we cannot say that Clang is really a supported 
compiler on Windows.

> Because of a "theoretical" problem, that was proved here we don't have 
> currently, we are stuck with gcc_struct attribute. This is currently 
> blocking clang, and I don't see the point about that.

It's not a "theoretical" problem, it's a real one. Have a look at commit 
642ba89672279fbdd14016a90da239c85e845d18 for example. If you revert the 
change to VTD_IR_TableEntry in include/hw/i386/intel_iommu.h and have a look 
a the difference of the output of "pahole" of the binaries, one compiled 
with -mms-bitfields and one with -mnoms-bitfields, you can see:

  union VTD_IR_TableEntry {
         struct {
                 uint32_t           present:1;          /*     0: 0  4 */
                 uint32_t           fault_disable:1;    /*     0: 1  4 */
                 uint32_t           dest_mode:1;        /*     0: 2  4 */
                 uint32_t           redir_hint:1;       /*     0: 3  4 */
                 uint32_t           trigger_mode:1;     /*     0: 4  4 */
                 uint32_t           delivery_mode:3;    /*     0: 5  4 */
                 uint32_t           __avail:4;          /*     0: 8  4 */
                 uint32_t           __reserved_0:3;     /*     0:12  4 */
                 uint32_t           irte_mode:1;        /*     0:15  4 */
                 uint32_t           vector:8;           /*     0:16  4 */
                 uint32_t           __reserved_1:8;     /*     0:24  4 */
                 uint32_t           dest_id;            /*     4     4 */
                 uint16_t           source_id;          /*     8     2 */

-               /* XXX 6 bytes hole, try to pack */
+               /* Bitfield combined with previous fields */

-               uint64_t           sid_q:2;            /*    16: 0  8 */
-               uint64_t           sid_vtype:2;        /*    16: 2  8 */
-               uint64_t           __reserved_2:44;    /*    16: 4  8 */
-       } irte;                                        /*     0    24 */
+               uint64_t           sid_q:2;            /*     8:16  8 */
+               uint64_t           sid_vtype:2;        /*     8:18  8 */
+               uint64_t           __reserved_2:44;    /*     8:20  8 */
+       } irte;                                        /*     0    16 */
         uint64_t                   data[2];            /*     0    16 */
  };

This problem is fixed nowadays since it also caused issues on big endian 
hosts (btw, using bitfields in structs that are used for data interchange is 
evil, we should maybe forbid this in the coding styles) ... but do we know 
whether there are other problems left? So far, nobody really looked at it 
yet, I think.

I checked the x86_64, aarch64 and ppc64 targets with pahole, and we seem to 
be clear there nowadays. But before we could drop the attribute on Clang on 
Windows, I think we need someone who *carefully* looks at *all* targets and 
confirms that we don't have any issues left.

  Thomas


