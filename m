Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA64AC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rms6q-00086L-RM; Wed, 20 Mar 2024 05:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rms6o-000860-5b
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rms6m-0008S0-MW
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710926379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DB0vWT0Z+EdyohLleucWWp9JAYZ/tAwg+pOedU6RK+o=;
 b=i40DusDC/gtyV20KhSfmoVeuCNj27jjPZokdu0plKqlAwe5bGsR7qPgg3r8fcTD+e1vZ0c
 s/fyvqNZZKOZGyA3YTFbAP/6a36WyAyPHKlnLVCmm5YCQUU5KIYsKOsiHyJ8gyQQwGDgkH
 WqqEQwYj1M5IDhNkSKATAIovIBHMgd0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-78mmtiGnM2qofOJXTBrbhA-1; Wed, 20 Mar 2024 05:19:36 -0400
X-MC-Unique: 78mmtiGnM2qofOJXTBrbhA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d49ce3736aso35435601fa.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 02:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710926375; x=1711531175;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DB0vWT0Z+EdyohLleucWWp9JAYZ/tAwg+pOedU6RK+o=;
 b=gxbBh7+ermC01rLkvOT8esCo/+GKdQAFbEe8xrq//ocY444QBo7TF/lSdZBag2C37m
 +xu5DJ42XS+tSbOS6O1bxn7Uvm8I57/Q+dW0UySrh16XOsHXbX+MHNzCcB0jxDXu2XIz
 q/Meq9HSCRwSOzj6+0bMLZUgn6aPZCEX+8vH+47nlox3pT6v6fTMHPPkgp+Hu3wHRWfI
 5jfrbnI0jriISqh9GRZcCXFVkMjrboQ4voHR9lbU5rSTwQBeJJRCYtqz0+P4XocHm1qv
 /7704Ag76KOs2jurUybOyvDLn8eKVZZkHdDi4Rfyen48r+OS+jPFhLCDKwP3AwVLkJkF
 hZ9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYyvWa122aRUOoj6qKXshF2DAABrhfDTO3jLMnd7QOEU+iYEXNOsWC0LYsbNja56E6UbWO8AeN/ha2M3pb1Uv9B7aGlFY=
X-Gm-Message-State: AOJu0Ywh8sFaLCiTHB6rnLMIB37jpqTx7HZru9kC4DOBzjvAdeE+jX+6
 PmnOOV6qkCQbKW4wGAENJYgkCp5RSmnHcB9jMI1tzVoTWdEXIwp/lWX0V4Io5pkTMMeT+zzAdvX
 gFT33YpRL/TV2BNX0KgzSHBLKI6fY9BC8d+KHo/UESmKmRZqzOkbv
X-Received: by 2002:a2e:6814:0:b0:2d4:6a34:97bf with SMTP id
 c20-20020a2e6814000000b002d46a3497bfmr8736682lja.49.1710926375469; 
 Wed, 20 Mar 2024 02:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo9MnXlyB54dCqjWyQGfrcUBLZH6ZyGSEV7fXznWcU684+dMRzEE2pe3w31FiYYiJ+Qe8ogw==
X-Received: by 2002:a2e:6814:0:b0:2d4:6a34:97bf with SMTP id
 c20-20020a2e6814000000b002d46a3497bfmr8736644lja.49.1710926374359; 
 Wed, 20 Mar 2024 02:19:34 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 an14-20020a17090656ce00b00a465b72a1f3sm4560080ejc.85.2024.03.20.02.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 02:19:33 -0700 (PDT)
Message-ID: <8386f7ac-418d-4d94-9553-1d2baac17cc1@redhat.com>
Date: Wed, 20 Mar 2024 10:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/49] scripts/update-linux-headers: Add setup_data.h
 to import list
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-3-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240320083945.991426-3-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On 3/20/24 09:38, Michael Roth wrote:
> Data structures like struct setup_data have been moved to a separate
> setup_data.h header which bootparam.h relies on. Add setup_data.h to
> the cp_portable() list and sync it along with the other header files.
> 
> Note that currently struct setup_data is stripped away as part of
> generating bootparam.h, but that handling is no currently needed for
> setup_data.h since it doesn't pull in many external
> headers/dependencies. However, QEMU currently redefines struct
> setup_data in hw/i386/x86.c, so that will need to be removed as part of
> any header update that pulls in the new setup_data.h to avoid build
> bisect breakage.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>

Including Linux headers from standard-headers breaks build on
non-Linux systems, and <asm/setup_data.h> is the first architecture
specific #include in include/standard-headers/.

So this needs a small fixup, to rewrite asm/ include to the
standard-headers/asm-* subdirectory for the current architecture.
     
While at it, we should remove asm-generic/kvm_para.h from the list of
allowed includes: it does not have a matching substitution, so if it
appeared it would break the build it on non-Linux systems where there
is no /usr/include/asm-generic/ directory.

Applied patches 2-5 to my QEMU coco tree - still temporary, but
certainly better than the hack that I posted yesterday.  By the time
QEMU 9.1 opens there will be something more stable to import from.

Paolo

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 579b03dc824..d48856f9e24 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -61,7 +61,6 @@ cp_portable() {
                                       -e 'linux/const' \
                                       -e 'linux/kernel' \
                                       -e 'linux/sysinfo' \
-                                     -e 'asm-generic/kvm_para' \
                                       -e 'asm/setup_data.h' \
                                       > /dev/null
      then
@@ -78,6 +77,7 @@ cp_portable() {
          -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
          -e 's/"\(input-event-codes\.h\)"/"standard-headers\/linux\/\1"/' \
          -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
+        -e 's/<asm\/\([^>]*\)>/"standard-headers\/asm-'$arch'\/\1"/' \
          -e 's/__bitwise//' \
          -e 's/__attribute__((packed))/QEMU_PACKED/' \
          -e 's/__inline__/inline/' \
@@ -157,12 +157,13 @@ for arch in $ARCHLIST; do
          cp_portable "$tmpdir/bootparam.h" \
                      "$output/include/standard-headers/asm-$arch"
          cp_portable "$tmpdir/include/asm/setup_data.h" \
-                    "$output/linux-headers/asm-x86"
+                    "$output/standard-headers/asm-x86"
      fi
      if [ $arch = riscv ]; then
          cp "$tmpdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
      fi
  done
+arch=
  
  rm -rf "$output/linux-headers/linux"
  mkdir -p "$output/linux-headers/linux"


