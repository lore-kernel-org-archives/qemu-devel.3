Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64963D25059
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 08:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfDkM-0002eu-A8; Mon, 12 Jan 2026 03:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfDjK-0002IK-Hd
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 03:56:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfDjI-0003y6-VM
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 03:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768208212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qmZPwUyr1NuCMpR18g7/XARwNyqESXHIaPMOLB7xu68=;
 b=W1yjBfNIsFhcg5xvdCgP4kUlK1ZikvOqWGAWk4+j747uGIAgPQByx2Dzeg8RmRnz6g0OH5
 OnmEz0XEIokLTCCL4CIuXRo6VAmlWINHFp0GDx1PebWx4pQ0rh7vpDYkY2u65npjTmuWCE
 8ko6NXFn3cOhErFc7xaJ7aIooWqjplw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-PeI3J6RQNouv8zhNxHFO1g-1; Mon, 12 Jan 2026 03:56:49 -0500
X-MC-Unique: PeI3J6RQNouv8zhNxHFO1g-1
X-Mimecast-MFC-AGG-ID: PeI3J6RQNouv8zhNxHFO1g_1768208208
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432586f2c82so3005661f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 00:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768208208; x=1768813008; darn=nongnu.org;
 h=in-reply-to:autocrypt:content-language:from:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qmZPwUyr1NuCMpR18g7/XARwNyqESXHIaPMOLB7xu68=;
 b=HSL/STuP6EcJCrwqlQHSun9CkMrUEq6nJuYQblNqzRHMSo6ktg5H80UBkbj3zTlKRS
 JXNf61jj6sV3bfGIu118GHpM3SbHBoDZBRxQEDgkjE35PrHMAwwcxGBqNz0zx76eApf+
 AWD1u9aJx4WgeBJqqG/EG81NSqqCD4nghkbPcMIkmcIvqaSXPsH/aiHpmr36lzVYXY9v
 B9TJZLiSzvgq5osk61EG+IaBIdbLH4FtP3ZrMs96X591wdpAuX19I518ze5txQ9nEVno
 B38GHrWOdF4WO7eu0awKXJwHMMtC342+nPBvLWCN/SIjTy3KVjGjiLZGHvazU3iPgNn5
 eXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768208208; x=1768813008;
 h=in-reply-to:autocrypt:content-language:from:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qmZPwUyr1NuCMpR18g7/XARwNyqESXHIaPMOLB7xu68=;
 b=Dug0FExnK7eGmaCBLvf/1SX1MHFveKfYQ7gIDy0n5SrEOvLH+FI7RltDQjzgpWIn9T
 yvcd1MkwxMIyFyu2Qu/S25n+nt7hLgCAcrV5JokfSWeGT5kjL6Xk8Bmw6r1yxbWzDxeQ
 PPVFurYhwZpS1ZLZ3tvphj92sRLEMsvXRnChsLvIbfNqsEerY3iHACYe45C5b4MY/n8J
 PbFs8JIr4gFoERPd6RQKRITVlePOFAJdjlaahQV0/zqz5pYydhubhmAVRzxA8Bn4bNWF
 KSz43nv2FxPLq18iGh38C6XVXrRgP0w5tqhfBZZziN0oZ4+DMZ8JG5j4gyMPp0iq5rJK
 e8Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSpBu/pvl4haqh5S/oLEHVVWbZsBPCYOVEJNFSJehAwF5BGA2JXm+5USU7Aj+PfcM98VU6YDAvIVx6@nongnu.org
X-Gm-Message-State: AOJu0Yx91cy/QR1yx7BqBynMBhspll4omyhO6WPwwzOdm8Xe8dMVWl1c
 7PB1VMtPIWIT5y5Z+RocPnPxhSU3TMhriwP12leAXuIwYAMW4RwFRTTquFyv6KEBpV51b622cco
 1SkRjyXOpplBXL04buyOO7DxMB+h50yUincF53qGA4QCGNoUlL34WeC0q
X-Gm-Gg: AY/fxX6danRXGfNuEm5xpirCVLiIw/LGrpglBLvuhumut+BXbMqEHkBKlDKEAJrIvl7
 OvmwZq9LgXprkf4/uV9BcxWgYZeyWjy1ganbbh3YvYiFT3au7yCpcUtMoO+OkSejvkXIEtrzlEp
 vUPqpr5ArNJLRTWLTBJ9DUupK/k2GfY1lXX3rzgRWl2/MdGBw3bZCbr30HU5a6L9izuwDEQcVkJ
 ffcfWUUooWww1HCZCVXVa9r2gTzJJpL9XFlfxXu22tEL8Ksv+QkR2eQSYg3m/aWyLzZlE/AQ+ZW
 7T6cxdMf6yWfC+7zWWLkHULbE5rK8+d6fhkIfwDFVb0VHRaQKoutKoExrezhEU53Ro49Fjr3aBq
 xsBfmA7Bg+GrqOoAd7m3lsUIo65XJwmVXo8+wXUbfTdVIWWtzXUMQ1TkohtrhjPMMOtuBrm/2e9
 F4XD9QL6XgPSwsYA==
X-Received: by 2002:a05:6000:238a:b0:432:c17c:3094 with SMTP id
 ffacd0b85a97d-432c17c349emr23635857f8f.3.1768208208454; 
 Mon, 12 Jan 2026 00:56:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe/hMdjlCwgZQstLUbzna56G9XN+9oVJ6MdNDEy2be8uy8yxRLgJibLNZcXobPeJOR3tqYjw==
X-Received: by 2002:a05:6000:238a:b0:432:c17c:3094 with SMTP id
 ffacd0b85a97d-432c17c349emr23635823f8f.3.1768208208034; 
 Mon, 12 Jan 2026 00:56:48 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacc5sm37356297f8f.5.2026.01.12.00.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 00:56:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------00XYlhsQcqq2NNGTke6AGwqw"
Message-ID: <546f3a4b-64ff-4f63-bb07-f5cb52b6c64c@redhat.com>
Date: Mon, 12 Jan 2026 09:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/22] util: Introduce ldm_p() and stm_p() load/store
 helpers
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
 <20260109165058.59144-3-philmd@linaro.org>
 <0db4b897-7645-43f2-a0e9-9dbe52a2746a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <0db4b897-7645-43f2-a0e9-9dbe52a2746a@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------00XYlhsQcqq2NNGTke6AGwqw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/26 00:23, Richard Henderson wrote:
> I'm not fond of the pointer arithmetic or the code structure.
> 
> Perhaps better as
> 
>      switch (mop & (MO_BSWAP | MO_SIZE)) {
>      case MO_LEUW:
>          return lduw_le_p(ptr);
>      case MO_BEUW:
>          return lduw_be_p(ptr);
>      ...
>      default:
>          g_assert_not_reached();
>      }
> 
> which would hopefully compile to host endian-swapping load insns like
> 
> .L1:
> 	mov	(ptr), %eax
> 	ret
> .L2:
> 	movbe	(ptr), %eax
> 	ret

It only might do so for 32-bits, because movbe also bundles a free 
32->64-bit zero extension, but not for the smaller ones.  Thinking about 
which, I think ldm_p also needs to handle MO_SIGN?  It can be done all 
in one with

static inline uint64_t ldm_p(const void *ptr, MemOp mop)
{
     const unsigned size = memop_size(mop);
     uint64_t val;
     uint8_t *pval = (uint8_t *)&val;

     if (HOST_BIG_ENDIAN) {
         pval += sizeof(val) - size;
     }

     assert(size < 8);
     __builtin_memcpy(pval, ptr, size);

     if (mop & MO_BSWAP) {
         val = __builtin_bswap64(val);
     } else if (mop & MO_SIGN) {
         val <<= (64 - 8 * size);
     } else {
         return val;
     }

     if (mop & MO_SIGN) {
         return ((int64_t) val) >> (64 - 8 * size);
     } else {
         return val >> (64 - 8 * size);
     }
}

static inline void stm_p(void *ptr, uint64_t val, MemOp mop)
{
     const unsigned size = memop_size(mop);
     uint8_t *pval = (uint8_t *)&val;

     assert(size < 8);
     if ((mop & MO_BSWAP)) {
         val = __builtin_bswap64(val) >> (64 - size * 8);
     }

     if (HOST_BIG_ENDIAN) {
         pval += sizeof(val) - size;
     }

     __builtin_memcpy(ptr, pval, size);
}

When inlining ldm_p, GCC is able to generate movzx/movsx instruction but 
doesn't recognize bswap64 + right shift as a smaller-width bswap + zero 
extension; clang does.  Neither is able to generate movbe instructions, 
though.

I attach a standalone file I played with.

Paolo
--------------00XYlhsQcqq2NNGTke6AGwqw
Content-Type: text/x-csrc; charset=UTF-8; name="ldst.c"
Content-Disposition: attachment; filename="ldst.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8YXNzZXJ0Lmg+Cgp0eXBlZGVmIGVudW0g
TWVtT3AgewogICAgTU9fMTYgPSAxLAogICAgTU9fMzIgPSAyLAogICAgTU9fU0laRSA9IDcs
CiAgICBNT19TSUdOID0gOCwKICAgIE1PX0JTV0FQID0gMTYsCn0gTWVtT3A7CgpleHRlcm4g
dm9pZCBfX2F0dHJpYnV0ZV9fKChub3JldHVybikpIGdfYXNzZXJ0X25vdF9yZWFjaGVkKHZv
aWQpOwoKc3RhdGljIGlubGluZSBpbnQgbWVtb3Bfc2l6ZShNZW1PcCB4KQp7CiAgICByZXR1
cm4gMSA8PCAoeCAmIE1PX1NJWkUpOwp9CgpzdGF0aWMgaW5saW5lIHVpbnQ2NF90IGxkbV9w
KGNvbnN0IHZvaWQgKnB0ciwgTWVtT3AgbW9wKQp7CiAgICBjb25zdCB1bnNpZ25lZCBzaXpl
ID0gbWVtb3Bfc2l6ZShtb3ApOwogICAgdWludDY0X3QgdmFsOwogICAgdWludDhfdCAqcHZh
bCA9ICh1aW50OF90ICopJnZhbDsKCiAgICBhc3NlcnQoc2l6ZSA8IDgpOwogICAgX19idWls
dGluX21lbWNweShwdmFsLCBwdHIsIHNpemUpOwoKICAgIGlmIChtb3AgJiBNT19CU1dBUCkg
ewogICAgICAgIHZhbCA9IF9fYnVpbHRpbl9ic3dhcDY0KHZhbCk7CiAgICB9IGVsc2UgaWYg
KG1vcCAmIE1PX1NJR04pIHsKICAgICAgICB2YWwgPDw9ICg2NCAtIDggKiBzaXplKTsKICAg
IH0gZWxzZSB7CiAgICAgICAgcmV0dXJuIHZhbDsKICAgIH0KCiAgICBpZiAobW9wICYgTU9f
U0lHTikgewogICAgICAgIHJldHVybiAoKGludDY0X3QpIHZhbCkgPj4gKDY0IC0gOCAqIHNp
emUpOwogICAgfSBlbHNlIHsKICAgICAgICByZXR1cm4gdmFsID4+ICg2NCAtIDggKiBzaXpl
KTsKICAgIH0KfQoKc3RhdGljIGlubGluZSB2b2lkIHN0bV9wKHZvaWQgKnB0ciwgdWludDY0
X3QgdmFsLCBNZW1PcCBtb3ApCnsKICAgIGNvbnN0IHVuc2lnbmVkIHNpemUgPSBtZW1vcF9z
aXplKG1vcCk7CiAgICB1aW50OF90ICpwdmFsID0gKHVpbnQ4X3QgKikmdmFsOwoKICAgIGFz
c2VydChzaXplIDwgOCk7CiAgICBpZiAoKG1vcCAmIE1PX0JTV0FQKSkgewogICAgICAgIHZh
bCA9IF9fYnVpbHRpbl9ic3dhcDY0KHZhbCkgPj4gKDY0IC0gc2l6ZSAqIDgpOwogICAgfQoK
ICAgIF9fYnVpbHRpbl9tZW1jcHkocHRyLCBwdmFsLCBzaXplKTsKfQoKdWludDMyX3QgbGR1
d19iZV9wKGNvbnN0IHZvaWQgKnB0cikKewogICAgcmV0dXJuIGxkbV9wKHB0ciwgTU9fMTYg
fCBNT19CU1dBUCk7Cn0KCnVpbnQzMl90IGxkc3dfbGVfcChjb25zdCB2b2lkICpwdHIpCnsK
ICAgIHJldHVybiBsZG1fcChwdHIsIE1PXzE2IHwgTU9fU0lHTik7Cn0KCnVpbnQzMl90IGxk
c2xfYmVfcChjb25zdCB2b2lkICpwdHIpCnsKICAgIHJldHVybiBsZG1fcChwdHIsIE1PXzMy
IHwgTU9fQlNXQVAgfCBNT19TSUdOKTsKfQoKdm9pZCBzdGxfYmVfcCh2b2lkICpwdHIsIHVp
bnQzMl90IHZhbCkKewogICAgc3RtX3AocHRyLCB2YWwsIE1PXzMyIHwgTU9fQlNXQVAgfCBN
T19TSUdOKTsKfQo=

--------------00XYlhsQcqq2NNGTke6AGwqw--


