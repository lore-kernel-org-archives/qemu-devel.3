Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C796C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyxv-0002EH-Ge; Wed, 20 Mar 2024 12:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmyxu-0002E4-CM
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmyxs-0007xe-00
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710952732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K5r5p+TdefoFVY2Sm9HFnen4qIuY7gJN6xyg80IowfU=;
 b=J6jckVBTXug/9Y7H/3O1sNMZC4i/JBsEwZUNMt8YOnqte+MsbVhqblJrRVMpr3nJyUGwz/
 ID0tRg3GoIcwt4mqWbiYsw7TFPXQnnIrYkklzRu4i5NocpNU2xnBeMLz1lqkRORgWzGSf7
 LMRD4axC9CeKcNpEnUAdQZJdJR8HAGg=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-8QfkvD_IP2yVYhRACOP9CQ-1; Wed, 20 Mar 2024 12:38:51 -0400
X-MC-Unique: 8QfkvD_IP2yVYhRACOP9CQ-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-4767d683821so1220569137.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710952730; x=1711557530;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K5r5p+TdefoFVY2Sm9HFnen4qIuY7gJN6xyg80IowfU=;
 b=iwHjt9G0oQkZabrFSciQvtSeMX+ElhQuBtmmEB8l3dITllGLpR42+IN9UpTnG9qEBD
 ZRk4k4uVq7TDjZi6KkTVPY91WRLGawk3JXFSy1PTPjtbD8ah/iJourNfubj2CnWLxIsi
 LaYxw6dj2GE/9zVCyt9ELP/NVZbljIke6T+lYsLByJe4tE0iEjHNK9aDIcMAKY8NPSGD
 uGuJ2PPES96xRp022e60Pv5fxG0oGbYSziRgJY5q+60tqCP/RpTae/WHSFEvaQsGEA0C
 oIJJcPvXyeJQaU8lLksLXbDwWrHHGRABS09Sw7qXoUjX/BbF1OYlnQRANzfHMqKkp9rH
 JzlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOdTUypK/hytT/HKvcPchjzwHvXAYV9SORGrZg0vX+sKpDPwDT+W52sGYK9BPHV0LpC0rQ6oty/CMwYCWQHuiE/JzGhfA=
X-Gm-Message-State: AOJu0YxImLgQ1131Dx27zSu/rrpXQTRgvCMLBHJ/Ievyq/t9D/tTKzAF
 +MWbRLJmvwX8mDc/KW+JdOHwY8j10ng9OWvGHHGzE9zfoKc/o/990v5HgRbQfAgNuTDTWElR599
 dZs6RBJdvg0TXCrZIBLOomgUeBlMrO/85MpkYhUst5ICrWM20Ls0x
X-Received: by 2002:a67:f744:0:b0:475:fb4c:7945 with SMTP id
 w4-20020a67f744000000b00475fb4c7945mr17255619vso.26.1710952730753; 
 Wed, 20 Mar 2024 09:38:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjdSZzCVJ68iThyIsGzMXH+YUdcqituas/ZbaBs84fPj14wkD26kaOdp/88pPYCe+J59FWmg==
X-Received: by 2002:a67:f744:0:b0:475:fb4c:7945 with SMTP id
 w4-20020a67f744000000b00475fb4c7945mr17255600vso.26.1710952730493; 
 Wed, 20 Mar 2024 09:38:50 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 d24-20020ab07258000000b007dc1a45e05fsm1572801uap.39.2024.03.20.09.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 09:38:49 -0700 (PDT)
Message-ID: <08fc19f0-fa0a-40c5-b77f-90ea55c140a2@redhat.com>
Date: Wed, 20 Mar 2024 17:38:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/49] RAMBlock: Add support of KVM private guest memfd
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 David Hildenbrand <david@redhat.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-7-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240320083945.991426-7-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/20/24 09:39, Michael Roth wrote:
> @@ -1842,6 +1842,17 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>           }
>       }
>   
> +    if (kvm_enabled() && (new_block->flags & RAM_GUEST_MEMFD)) {
> +        assert(new_block->guest_memfd < 0);
> +
> +        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
> +                                                        0, errp);
> +        if (new_block->guest_memfd < 0) {
> +            qemu_mutex_unlock_ramlist();
> +            return;
> +        }
> +    }
> +

This potentially leaks new_block->host.  This can be squashed into the patch:

diff --git a/system/physmem.c b/system/physmem.c
index 3a4a3f10d5a..0836aff190e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1810,6 +1810,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
      const bool shared = qemu_ram_is_shared(new_block);
      RAMBlock *block;
      RAMBlock *last_block = NULL;
+    bool free_on_error = false;
      ram_addr_t old_ram_size, new_ram_size;
      Error *err = NULL;
  
@@ -1839,6 +1841,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                  return;
              }
              memory_try_enable_merging(new_block->host, new_block->max_length);
+            free_on_error = true;
          }
      }
  
@@ -1849,7 +1852,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                                                          0, errp);
          if (new_block->guest_memfd < 0) {
              qemu_mutex_unlock_ramlist();
-            return;
+            goto out_free;
          }
      }
  
@@ -1901,6 +1904,13 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
          ram_block_notify_add(new_block->host, new_block->used_length,
                               new_block->max_length);
      }
+    return;
+
+out_free:
+    if (free_on_error) {
+        qemu_anon_ram_free(new_block->host, new_block->max_length);
+        new_block->host = NULL;
+    }
  }
  
  #ifdef CONFIG_POSIX


