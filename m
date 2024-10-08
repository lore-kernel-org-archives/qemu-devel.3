Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6B8CED276
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 08:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy5AF-0000oH-QH; Tue, 08 Oct 2024 04:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy5AC-0000ar-8P
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 04:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy5AA-00062g-A1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 04:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728374505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9QhZJ0eHo+KvEJ0qOi+bI3DWzF0LqJRHk/5DmLjJVJA=;
 b=Zn2AzFeSnR7gIN3EwZP/11tTsB7qsdgNe9RocjddyTNgMVx1UaJ5UUf9EVckVUzQjmCR/w
 cNVprsfvjzbsPdz5/0m5NzlZENEgLWdAA168JLGjloMApmVT+U625rVEoxYdefJyPFvOqp
 bnDU9W+FZ4wtEJJz6e9spx/8SwVxDLo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Q6isrIwVMqemL0wrKz-xDg-1; Tue, 08 Oct 2024 04:01:43 -0400
X-MC-Unique: Q6isrIwVMqemL0wrKz-xDg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42ac185e26cso46704085e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 01:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374502; x=1728979302;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QhZJ0eHo+KvEJ0qOi+bI3DWzF0LqJRHk/5DmLjJVJA=;
 b=vYvBB3iBQrbvecbhi+bIgND23ncRkEhITWrA81wNo37hqKfylIsDzLAaYtmtbZxx42
 ZZ7bTr0D5qB/SwsELxtBq7kTLvW7/qvX34+sDZR/ZZ9ucnZQEMkp35o5o4AwHFnDAcPV
 VD8urkJhgF2P6z0vwexus47uOj9LTK5Y9JOOwPtnMVwt/pD1bq+66W12u4lENK2RU2w+
 bDBs6c6gHrV++uJoHRRTgvPO6L7ueh+z40xQLwx/8eZBpLF8ti1hTFc1UDJLMSPLZR3L
 wVhoW+YvQWcUDXV8h5fO3ArTsIsVInk8oHuEGUuJhdcKeD9ngGerrYG0o3pONgw8XMj2
 wK7A==
X-Gm-Message-State: AOJu0Ywnb3axufrblycY4ItXdLJcrY33b2DvQ2DSwklpQ7qZOex+b/jp
 nFsJUYOsm6khX0MT8PmIUQK+tDICUywNr0J/ttXlEmd2FonqQcvRMrKoFt06xvaoi+jIFgaEHh1
 gGTqQHgIMZ4zt/hZM9T85VXL1ofCNdt/RskVr+oKiUop5xgW3KCWg6xGKcUT6yDZLs/6Auu8/0u
 5SKOQJoNNhRoRgZW+qk4pRQf4UmOB9dw==
X-Received: by 2002:a05:600c:1e26:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-42f9210c3d1mr37438595e9.12.1728374501678; 
 Tue, 08 Oct 2024 01:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELwqKF+EmyLXRwyIxEjDb2BeGshD+mDrNwF8m+pJr0wzPnCgl2t1QwoDP7w7N6n42rWQti6A==
X-Received: by 2002:a05:600c:1e26:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-42f9210c3d1mr37438305e9.12.1728374501095; 
 Tue, 08 Oct 2024 01:01:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43017466075sm13140565e9.0.2024.10.08.01.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 01:01:40 -0700 (PDT)
Message-ID: <7517bf36-aaf7-43de-b47b-768dd51c2ad0@redhat.com>
Date: Tue, 8 Oct 2024 10:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
To: qemu-devel@nongnu.org, berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org
References: <20241008075724.2772149-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241008075724.2772149-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/8/24 09:57, Cédric Le Goater wrote:
> Hello,
> 
> This is a resping of Alejandro's series fixing SG Accumulative Hash
> Calculations. See [1] for more details.

arf.

[1] https://lore.kernel.org/all/20240807195122.2827364-1-alejandro.zeise@seagate.com/

C.

> 
> The goal of this patch series is to fix accumulative hashing support
> in the Aspeed HACE module. The issue that stemmed this patch was a
> failure to boot an OpenBMC image using the "ast2600-evb" machine. The
> U-boot 2019.04 loader failed to verify image hashes.
> 
> These incorrect image hashes given by the HACE to the U-boot guest are
> due to an oversight in the HACE module. Previously when operating in
> scatter-gather accumulative mode, the HACE would cache the address
> provided by the guest which contained the source data. However, there
> was no deep copy, so when HACE generated the digest upon the reception
> of the final accumulative chunk the digest was incorrect, as the
> addresses provided had their regions overwritten by that time.
> 
> This fix consists of two main steps:
> * Add an accumulative hashing function to the qcrypto library
> * Modify the HACE module to use the accumulative hashing functions
> 
> All the crypto library backends (nettle, gnutls, etc.) support
> accumulative hashing, so it was trivial to create wrappers for those
> functions.
> 
> Changes in v5 (clg):
> 
>   - Changed documentation "non-zero on error" -> "-1 on error"
>   - Dropped qcrypto_hash_supports() in qcrypto_glib_hash_new()
>   - Removed superfluous cast (GChecksum *) in qcrypto_glib_hash_free()
>   - Reworked qcrypto_glib_hash_finalize()
>   - Dropped qcrypto_hash_supports() in qcrypto_gcrypt_hash_new()
>   - Reworked qcrypto_gcrypt_hash_finalize()
>   - Handled gcry_md_open() errors in qcrypto_gcrypt_hash_new()
>   - Dropped qcrypto_hash_supports() in qcrypto_gnutls_hash_new()
>   - Reworked qcrypto_gnutls_hash_finalize()
>   - Handled gnutls_hash_init() errors in qcrypto_gnutls_hash_new()
>   - Replaced gnutls_hash_deinit() by gnutls_hash_output() in
>     qcrypto_gnutls_hash_finalize()
>   - Freed resources with gnutls_hash_deinit() in qcrypto_gnutls_hash_free()
>   - Dropped qcrypto_hash_supports() in qcrypto_nettle_hash_new()
>   - Split iov changes from original patch
>   - Handled qcrypto_afalg_hash_ctx_new() errors in qcrypto_afalg_hash_new()
>   - Freed alg_name in qcrypto_afalg_hash_new()
>   - Reworked qcrypto_afalg_recv_from_kernel()
>   - Split iov changes from original patch
>   - Reworked qcrypto_hash_bytesv() error handling
>   - Used hash->driver int qcrypto_hash_new(), qcrypto_hash_free() qcrypto_hash_updatev()
>   - Introduced qcrypto_hash_supports() check in  qcrypto_hash_new()
>   - Introduced g_autofree variables in qcrypto_hash_finalize_digest()
>     and qcrypto_hash_finalize_base64()
>   - Re-arrranged code in qcrypto_hash_digestv() and qcrypto_hash_digest()
>   - Improved test_hash_accumulate() with g_autofree variables
>   - Fixed spelling in commit log
>   - Checkpatch fixes
> 
> Changes in V4:
> * Restructured patches so unit tests pass for each independently.
> * Freeing hash context is now a void function.
> * Added autoptr cleanup function definition for qcrypto_hash_free.
> * Separated qcrypto_hash_update into qcrypto_hash_update and
>    qcrypto_hash_updatev.
> * Changed public hash functions to use afalg implementation correctly if support
>    is enabled.
> * Fixed accumulative hashing in afalg driver (pass MSG_MORE socket flag).
> 
> Changes in V3:
> * Reworked crypto hash API with comments from Daniel
>    * Creation/Deletion of contexts, updating, and finalizing
>    * Modified existing API functions to use the new 4 main core functions
>    * Added test for accumulative hashing
>    * Added afalg driver implementation
> * Fixed bug in HACE module where hash context fails to allocate,
>    causing the HACE internal state to be incorrect and segfault.
> 
> Changes in V2:
> * Fixed error checking bug in libgcrypt crypto backend of
>    accumulate_bytesv
> 
> Alejandro Zeise (16):
>    crypto: accumulative hashing API
>    crypto/hash-glib: Implement new hash API
>    crypto/hash-gcrypt: Implement new hash API
>    crypto/hash-gnutls: Implement new hash API
>    crypto/hash-nettle: Implement new hash API
>    util/iov: Introduce iov_send_recv_with_flags()
>    crypto/hash-afalg: Implement new hash API
>    crypto/hash: Implement and use new hash API
>    tests/unit/test-crypto-hash: accumulative hashing
>    crypto/hash-glib: Remove old hash API functions
>    crypto/hash-gcrypt: Remove old hash API functions
>    crypto/hash-gnutls: Remove old hash API functions
>    crypto/hash-nettle: Remove old hash API functions
>    crypto/hash-afalg: Remove old hash API functions
>    crypto/hashpriv: Remove old hash API function
>    hw/misc/aspeed_hace: Fix SG Accumulative hashing
> 
>   crypto/hashpriv.h             |  13 ++-
>   include/crypto/hash.h         | 119 ++++++++++++++++++++++++
>   include/hw/misc/aspeed_hace.h |   4 +
>   include/qemu/iov.h            |  27 ++++++
>   crypto/hash-afalg.c           | 167 ++++++++++++++++++++++++----------
>   crypto/hash-gcrypt.c          | 112 +++++++++++++----------
>   crypto/hash-glib.c            |  92 +++++++++++--------
>   crypto/hash-gnutls.c          |  97 +++++++++++++-------
>   crypto/hash-nettle.c          |  81 ++++++++++-------
>   crypto/hash.c                 | 161 ++++++++++++++++++++++++++------
>   hw/misc/aspeed_hace.c         |  96 ++++++++++---------
>   tests/unit/test-crypto-hash.c |  46 ++++++++++
>   util/iov.c                    |  25 +++--
>   13 files changed, 756 insertions(+), 284 deletions(-)
> 


