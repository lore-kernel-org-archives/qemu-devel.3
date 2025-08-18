Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C440CA0EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 10:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unxPT-0005oR-0E; Mon, 18 Aug 2025 06:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1unxPR-0005oH-Ig
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 06:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1unxPP-0007X9-D0
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 06:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755514087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/dAp1ESoudxX6WmjmV5CO2COtT8lm8uIkdGtg3uWp0A=;
 b=Y7NH/FlaiIMh2aohSRvMTcEQsSWCuprRQrCSwN6SwCfb0wng2fFNGp8PteIT80Ogmc6Crh
 gySrMXfw7RYCDmnMFAf3d/r5u848XUuX4TejVczWWvJ0dX5cxKvmN0160hgcpQERtN3SOj
 W/FF5WPBLZUqMkjkBniJ8Xa3cJ9iz00=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-ZB90LVJhMXeCDKE0hz6JYg-1; Mon, 18 Aug 2025 06:48:05 -0400
X-MC-Unique: ZB90LVJhMXeCDKE0hz6JYg-1
X-Mimecast-MFC-AGG-ID: ZB90LVJhMXeCDKE0hz6JYg_1755514085
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b916fd2cf3so1901272f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 03:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755514084; x=1756118884;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/dAp1ESoudxX6WmjmV5CO2COtT8lm8uIkdGtg3uWp0A=;
 b=us++Hpu+oGBKItiCXxzqjWEPDvyyp30zlYzig3gthbX/AmRqSWag1diAEKY2tJ6eSL
 6tyxep+pwPSnkA0/K30OcueZvKv9sfY/G219oTB1RP7RSPZC3+6ofSXUSs+Hi4hMJNTJ
 dv+uTg8NXUU7lSOpAi4EQAVbJX4m4PXJyOYzv3rqYneFAz+EtL4O51ybyWM6GCGT4QFy
 ufSQWssg3T+nsZMP8RZAk4ve7H9T0ZIi9isFWHKbUaXPJtipg1KHRR8ymZyHNRG5t7EH
 Eg02DaL47kLubxrS7sul2PZ/qJ7MIr/w4hhPNqJfFMfBTy/GRDguk4V8cvYrCJ+I+X8G
 gelQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmwJfi647Ok1ThXlnfmVLt0k9CmAdzs5FlePv6umF2wF7lJ8GYn7cRazXphsmHWWwhIklO8AMXmWmq@nongnu.org
X-Gm-Message-State: AOJu0Yxol+e8ubyytzbVsOCkwtEMoS3ptN8FbVxuipahp57bhaSOawan
 OF5+G0xeaeFL2JdYc80+zOYSy5bpSiugUNS+6sBd7XIX8O4FPLNhfsIkfymOgN40migKkOUVkoc
 N+RbwqAhLaSKFRi7mWlfHt7dHFaX9xwD34zCkZt6KWfQEozQ4GM3xiuf7
X-Gm-Gg: ASbGncurriaOz1fnL6kBEoZ0BKCh5Bt7Pdc/+GWDsBOScFWRbrwIVsOwN1s/LXbntHw
 m/8WVSYggvOVFHB2AEIJRVdkrmV+y7V4QGwu7x9xOkg081PUn/tydDAO+BExd7ovsH/93CBkfIw
 1qCZ1pOdcxL+sW6oqizBXHMRFsFUeygNYe4a+Dj+tW8thvO0KRx3HilytlIcHb/oArgaYYfsLD4
 4YwuSlHOU9o19tfOUKDyBK9a0n7aFCxbHDJQATVH2QGiY+CRlxShX7Qy00T3nJ6VN0YQiFGbPvm
 Vrf1djXtTFdTPY5AJ13akUUNJN8dm1lW9hnGk0BfNdAD
X-Received: by 2002:a05:6000:40de:b0:3b9:14f2:7edf with SMTP id
 ffacd0b85a97d-3ba50661e65mr13153735f8f.1.1755514084481; 
 Mon, 18 Aug 2025 03:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRUeq6W0dUNkIKsZzcv28/Ex6uz3/j0jx230EXuNO+sNeuo6XFQcEYZSg6CE0lrXVnqXlNDg==
X-Received: by 2002:a05:6000:40de:b0:3b9:14f2:7edf with SMTP id
 ffacd0b85a97d-3ba50661e65mr13153709f8f.1.1755514084026; 
 Mon, 18 Aug 2025 03:48:04 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.234.144])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45a223206c7sm128166575e9.16.2025.08.18.03.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 03:48:03 -0700 (PDT)
Message-ID: <142fdd75-f449-4fe2-9c00-5ce03673c59e@redhat.com>
Date: Mon, 18 Aug 2025 12:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/tcg/svm: fix incorrect canonicalization
To: Zero Tang <zero.tangptr@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, eduardo@habkost.net
References: <CAAXNugBwiRuwiNHeuBV5U+HyrSisPSN-HL_7n6Pqc7oAOTX6Pw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAAXNugBwiRuwiNHeuBV5U+HyrSisPSN-HL_7n6Pqc7oAOTX6Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/6/25 09:58, Zero Tang wrote:
>   Replaces "long" with "int64_t" during canonicalization.
> 
>   ---
>   In Linux GCC, "long" has 8 bytes. However, in msys2 GCC, "long" has 4
>   bytes. In this case, canonicalization would set all high bits to 1 when
>   the segment base is bigger than 0x7FFF (assuming 48-bit linear address).
> 
>   This is why QEMU-TCG in Windows cannot boot a bluepill-like hypervisor
>   in UEFI, in that the guest IDT and GDT bases are above 0x7FFF, thereby
>   resulting in incorrect bases. When an interrupt arrives, it would
>   trigger a #PF exception; the #PF would trigger again, resulting in a #DF
>   exception; the #PF would trigger for the third time, resulting in
>   triple-fault, and eventually causes the shutdown VM-Exit to the
>   bluepill hypervisor right after it boots.
> 
>   In summary, this patch replaces "long" with "int64_t" in order to enforce
>   the canonicalization with 64-bit signed integers.
> 
>   Signed-off-by: Zero Tang <zero.tangptr@gmail.com>
Queued, thanks.  However, please note that the patch is not formatted 
correctly; do not send patches as HTML mail.  In this case it was one 
line of code only so I fixed it up.

Paolo


